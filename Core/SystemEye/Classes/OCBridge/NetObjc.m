//
//  NetObjc.m
//  Pods
//
//  Created by zixun on 17/1/4.
//
//

#import "NetObjc.h"
#import <ifaddrs.h>
#import <sys/socket.h>

#import <net/if.h>
#import <sys/types.h>
#import <sys/sysctl.h>
#import <sys/mman.h>
#import <mach/mach.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#include <sys/ioctl.h>

@implementation NetModel

@end

@implementation NetObjc

+ (nonnull NetModel *)flow {
    NetModel *result = [[NetModel alloc] init];
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    
    if (getifaddrs(&addrs) == 0) {
        
        cursor = addrs;
        while (cursor != NULL)
        {
            // names of interfaces: en0 is WiFi ,pdp_ip0 is WWAN
            if (cursor->ifa_addr->sa_family == AF_LINK)
            {
                if (strcmp(cursor->ifa_name, "en0") == 0) {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    result.wifiSend += networkStatisc->ifi_obytes;
                    result.wifiReceived += networkStatisc->ifi_ibytes;
                }
                
                if (strcmp(cursor->ifa_name, "pdp_ip0") == 0) {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    result.wwanSend += networkStatisc->ifi_obytes;
                    result.wwanReceived += networkStatisc->ifi_ibytes;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    
    return result;
}

+ (nullable NSString *)wifiIPAddress {
    // Set a string for the address
    NSString *result;
    // Set up structs to hold the interfaces and the temporary address
    struct ifaddrs *interfaces;
    struct ifaddrs *temp;
    // Set up int for success or fail
    int status = 0;
    
    // Get all the network interfaces
    status = getifaddrs(&interfaces);
    
    // If it's 0, then it's good
    if (status == 0) {
        // Loop through the list of interfaces
        temp = interfaces;
        // Run through it while it's still available
        while(temp != NULL) {
            // If the temp interface is a valid interface
            if(temp->ifa_addr->sa_family == AF_INET){
                // Check if the interface is WiFi
                if([[NSString stringWithUTF8String:temp->ifa_name] isEqualToString:@"en0"]){
                    // Get the WiFi IP Address
                    result = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp->ifa_addr)->sin_addr)];
                }
            }
            
            // Set the temp value to the next interface
            temp = temp->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return result;
}

// Get WiFi Netmask Address
+ (nullable NSString *)wifiNetmaskAddress {
        // Set up the variable
        struct ifreq afr;
        // Copy the string
        strncpy(afr.ifr_name, [@"en0" UTF8String], IFNAMSIZ-1);
        // Open a socket
        int afd = socket(AF_INET, SOCK_DGRAM, 0);
        
        // Check the socket
        if (afd == -1) {
            // Error, socket failed to open
            return nil;
        }
        
        // Check the netmask output
        if (ioctl(afd, SIOCGIFNETMASK, &afr) == -1) {
            // Error, netmask wasn't found
            close(afd);
            return nil;
        }
        
        // Close the socket
        close(afd);
        
        // Create a char for the netmask
        char *netstring = inet_ntoa(((struct sockaddr_in *)&afr.ifr_addr)->sin_addr);
        
        // Create a string for the netmask
        NSString *netmask = [NSString stringWithUTF8String:netstring];
        
        // Return successful
        return netmask;
}


// Get Cell IP Address
+ (nullable NSString *)cellIPAddress {
    // Set a string for the address
    NSString *IPAddress;
    // Set up structs to hold the interfaces and the temporary address
    struct ifaddrs *Interfaces;
    struct ifaddrs *temp;
    struct sockaddr_in *s4;
    char buf[64];
    
    // If it's 0, then it's good
    if (!getifaddrs(&Interfaces)) {
        // Loop through the list of interfaces
        temp = Interfaces;
        
        // Run through it while it's still available
        while(temp != NULL) {
            // If the temp interface is a valid interface
            if(temp->ifa_addr->sa_family == AF_INET) {
                // Check if the interface is Cell
                if([[NSString stringWithUTF8String:temp->ifa_name] isEqualToString:@"pdp_ip0"]) {
                    s4 = (struct sockaddr_in *)temp->ifa_addr;
                    
                    if (inet_ntop(temp->ifa_addr->sa_family, (void *)&(s4->sin_addr), buf, sizeof(buf)) == NULL) {
                        // Failed to find it
                        IPAddress = nil;
                    } else {
                        // Got the Cell IP Address
                        IPAddress = [NSString stringWithUTF8String:buf];
                    }
                }
            }
            
            // Set the temp value to the next interface
            temp = temp->ifa_next;
        }
    }
    
    // Free the memory of the interfaces
    freeifaddrs(Interfaces);
    
    // Check to make sure it's not empty
    if (IPAddress == nil || IPAddress.length <= 0) {
        // Empty, return not found
        return nil;
    }
    
    // Return the IP Address of the WiFi
    return IPAddress;
}

+ (nullable NSString *)cellNetmaskAddress {
    // Set up the variable
    struct ifreq afr;
    // Copy the string
    strncpy(afr.ifr_name, [@"pdp_ip0" UTF8String], IFNAMSIZ-1);
    // Open a socket
    int afd = socket(AF_INET, SOCK_DGRAM, 0);
    
    // Check the socket
    if (afd == -1) {
        // Error, socket failed to open
        return nil;
    }
    
    // Check the netmask output
    if (ioctl(afd, SIOCGIFNETMASK, &afr) == -1) {
        // Error, netmask wasn't found
        // Close the socket
        close(afd);
        // Return error
        return nil;
    }
    
    // Close the socket
    close(afd);
    
    // Create a char for the netmask
    char *netstring = inet_ntoa(((struct sockaddr_in *)&afr.ifr_addr)->sin_addr);
    
    // Create a string for the netmask
    NSString *Netmask = [NSString stringWithUTF8String:netstring];
    
    // Return successful
    return Netmask;
}

@end
