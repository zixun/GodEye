//
//  TextViewController.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/6/23.
//  Copyright © 2016年 egg swift. All rights reserved.
//  Test from: '007 The Spy Who Loved Me'

import UIKit

class TextViewController: UIViewController {
    var textView: UITextView!
    var num: Int = 0
    var text1: String = "Part One: Me One: Scaredy Cat \n    I WAS running away. I was running away from England, from my childhood, from the winter, from a sequence of untidy, unattractive love-affairs, from the few sticks of furniture and jumble of overworn clothes that my London life had collected around me; and I was running away from drabness, fustiness, snobbery, the claustrophobia of close horizons, and from my inability, although I am quite an attractive rat, to make headway in the rat-race. In fact I was running away from almost everything except the law. \n    And I had run a very long way indeed-almost, exaggerating a bit, halfway round the world. In fact I had come all the way from London to The Dreamy Pines Motor Court, which is ten miles west of Lake George, the famous American tourist resort in the Adirondacks-that vast expanse of mountains, lakes, and pine forests which forms most of the northern territory of New York State. I had started on September the first, and it was now Friday the thirteenth of October. When I had left, the grimy little row of domesticated maples in my square had been green, or as green as any tree can be in London in August. Now, in the billion-strong army of pine trees that marched away northward toward the Canadian border, the real, wild maples flamed here and there like shrapnel-bursts. And I felt that I, or at any rate my skin, had changed just as much-from the grimy sallowness that had been the badge of my London life to the snap and color and sparkle of living out of doors and going to bed early and all those other dear dull things that had been part of my life in Quebec before it was decided that I must go to England and learn to be a \"lady.\" Very unfashionable, of course, this cherry-ripe, strength-through-joy complexion, and I had even stopped using lipstick and nail polish, but to me it had been like sloughing off a borrowed skin and getting back into my own, and I was childishly happy and pleased with myself whenever I looked in the mirror (that's another thing-I'll never say \"looking-glass\" again; I just don't have to any more) and found myself not wanting to paint a different face over my own. I'm not being smug about this. I was just running away from the person I'd been for the past five years. I wasn't particularly pleased with the person I was now, but I had hated and despised the other one, and I was glad to be rid of her face."
    var text2: String = "\nStation WOKO (they might have dreamed up a grander call-sign!) in Albany, the capital of New York State and about fifty miles due south of where I was, announced that it was six o'clock. The weather report that followed included a storm warning with gale-force winds. The storm was moving down from the north and would hit Albany around eight p.m. That meant that I would be having a noisy night. I didn't mind. Storms don't frighten me, and although the nearest living soul, as far as I knew, was ten miles away up the not very good secondary road to Lake George, the thought of the pines that would soon be thrashing outside, the thunder and lightning and rain, made me already feel snug and warm and protected in anticipation. And alone! But above all alone! \"Loneliness becomes a lover, solitude a darling sin.\" Where had I read that? Who had written it? It was so exactly the way I felt, the way that, as a child, I had always felt until I had forced myself to \"get into the swim,\" \"be one of the crowd\"-a good sort, on the ball, hep. And what a hash I had made of \"togetherness\"! I shrugged the memory of failure away. Everyone doesn't have to live in a heap. Painters, writers, musicians are lonely people. So are statesmen and admirals and generals. But then, I added to be fair, so are criminals and lunatics. Let's just say, not to be too flattering, that true Individuals are lonely. It's not a virtue-the reverse, if anything. One ought to share and communicate if one is to be a useful member of the tribe. The fact that I was so much happier when I was alone was surely the sign of a faulty, a neurotic character. I had said this so often to myself in the past five years that now, that evening, I just shrugged my shoulders and, hugging my solitude to me, walked across the big lobby to the door and went out to have a last look at the evening."
    var text3: String = "\nI hate pine trees. They are dark and stand very still and you can't shelter under them or climb them. They are very dirty, with a most un-treelike black dirt, and if you get this dirt mixed with their resin they make you really filthy. I find their jagged shapes vaguely inimical, and the way they mass so closely together gives me the impression of an army of spears barring my passage. The only good thing about them is their smell, and, when I can get hold of it, I use pine-needle essence in my bath. Here, in the Adirondacks, the endless vista of pine trees was positively sickening. They clothe every square yard of earth in the valleys and climb up to the top of every mountain so that the impression is of a spiky carpet spread to the horizon-an endless vista of rather stupid-looking green pyramids waiting to be cut down for matches and coat-hangers and copies of the New York Times."
    var text4: String = "\nFive acres or so of these stupid trees had been cleared to build the motel, which is all that this place really was. \"Motel\" isn't a good word any longer. It has become smart to use \"Motor Court\" or \"Ranch Cabins\" ever since motels became associated with prostitution, gangsters, and murders, for all of which their anonymity and lack of supervision is a convenience. The site, touristwise, in the lingo of the trade, was a good one. There was this wandering secondary road through the forest, which was a pleasant alternative route between Lake George and Glen Falls to the south, and halfway along it was a small lake, cutely called Dreamy Waters, that was a traditional favorite with picnickers. It was on the southern shore of this lake that the motel had been built, its reception lobby facing the road, with, behind this main building, the rooms fanning out in a semicircle. There were forty rooms with kitchen, shower, and lavatory, and they all had some kind of view of the lake behind them. The whole construction and design was the latest thing-glazed pitch-pine frontages and pretty timber roofs all over knobbles, air-conditioning, television in every cabin, children's playground, swimming pool, golf range out over the lake with floating balls (fifty balls, one dollar)-all the gimmicks. Food? Cafeteria in the lobby, and grocery and liquor deliveries twice a day from Lake George. All this for ten dollars single and sixteen double. No wonder that, with around two hundred thousand dollars' capital outlay and a season lasting only from July the first to the beginning of October, or, so far as the NO VACANCY sign was concerned, from July fourteenth to Labor Day, the owners were finding the going hard. Or so those dreadful Phanceys had told me when they'd taken me on as receptionist for only thirty dollars a week plus keep. Thank heavens they were out of my hair! Song in my heart? There had been the whole heavenly choir at six o'clock that morning when their shiny station-wagon had disappeared down the road on their way to Glens Falls and then to Troy where the monsters came from. Mr. Phancey had made a last grab at me, and I hadn't been quick enough. His free hand had run like a fast lizard over my body before I had crunched my heel into his instep. He had let go then. When his contorted face had cleared, he said softly, \"All right, sex-box. Just see that you mind camp good until the boss comes to take over the keys tomorrow noon. Happy dreams tonight.\" Then he had grinned a grin I hadn't understood, and had gone over to the station-wagon, where his wife had been watching from the driver's seat. \"Come on, Jed,\" she had said sharply. \"You can work off those urges on West Street tonight.\" She put the car in gear and called over to me sweetly, \" \'By now, cutie-pie. Write us every day.\" Then she had wiped the crooked smile off her face and I caught a last glimpse of her withered hatchet profile as the car turned out onto the road. Phew! What a couple! Right out of a book-and what a book! Dear Diary! Well, people couldn\'t come much Worse, and now they\'d gone. From now on, on my travels, the human race must improve!"
    var text5: String = "\nI had been standing there, looking down the way the Phanceys had gone, remembering them. Now I turned and looked to the north to see after the weather. It had been a beautiful day, Swiss clear and hot for the middle of October, but now high fretful clouds, black with jagged pink hair from the setting sun, were piling down the sky. Fast little winds were zigzagging among the forest tops and every now and then they hit the single yellow light above the deserted gas station down the road at the tail of the lake and set it swaying. When a longer gust reached me, cold and buffeting, it brought with it the whisper of a metallic squeak from the dancing light, and the first time this happened I shivered deliciously at the little ghostly noise. On the lake shore, beyond the last of the cabins, small waves were lapping fast against the stones, and the gunmetal surface of the lake was fretted with sudden cat\'s-paws that sometimes showed a fleck of white. But, in between the angry gusts, the air was still, and the sentinel trees across the road and behind the motel seemed to be pressing silently closer to huddle round the campfire of the brightly lit building at my back. \n    I suddenly wanted to go to the john, and I smiled to myself. It was the piercing tickle that comes to children during hide-and-seek-in-the-dark and Sardines, when, in your cupboard under the stairs, you heard the soft creak of a floorboard, the approaching whisper of the searchers. Then you clutched yourself in thrilling anguish and squeezed your legs together and waited for the ecstasy of discovery, the crack of light from the opening door and then-the supreme moment-your urgent \"Ssh! Come in with me!\" the softly closing door and the giggling warm body pressed tight against your own."
    var text6: String = "\nStanding there, a \"big girl\" now, I remembered it all and recognized the sensual itch brought on by a fleeting apprehension-the shiver down the spine, the intuitive gooseflesh that come from the primitive fear-signals of animal ancestors. 1 was amused and I hugged the moment to me. Soon the thunderheads would burst and I would step back from the howl and chaos of the storm into my well-lighted comfortable cave, make myself a drink, listen to the radio, and feel safe and cosseted. \n    It was getting dark. Tonight there would be no evening chorus from the birds. They had long ago read the signs and disappeared into their own shelters in the forest, as had the animals-the squirrels and the chipmunks and the deer. In all this huge wild area there was now only me out in the open. I took a last few deep breaths of the soft, moist air. The humidity had strengthened the scent of pine and moss, and now there was also a strong underlying armpit smell of earth. It was almost as if the forest was sweating with the same pleasurable excitement I was feeling. Somewhere, from quite close, a nervous owl asked loudly \"Who?\" and then was silent. I took a few steps away from the lighted doorway and stood in the middle of the dusty road, looking north. A strong gust of wind hit me and blew back my hair. Lightning threw a quick blue-white hand across the horizon. Seconds later thunder growled softly like a wakening guard dog, and then the big wind came and the tops of the trees began to dance and thrash and the yellow light over the gas station jigged and blinked down the road as if to warn me. It was warning me. Suddenly the dancing light was blurred with rain, its luminosity fogged by an advancing gray sheet of water. The first heavy drops hit me, and 1 turned and ran. \n    I banged the door behind me, locked it, and put up the chain. I was only just in time. Then the avalanche crashed down and settled into a steady roar of water whose patterns of sound varied from a heavy drumming on the slanting timbers of the roof to a higher, more precise slashing at the windows. In a moment these sounds were joined by the busy violence of the overflow drainpipes. And the noisy background pattern of the storm was set."
    var text7: String = "\nI was still standing there, cozily listening, when the thunder that had been creeping quietly up behind my back sprang its ambush. Suddenly lightning blazed in the room, and at the same instant there came a blockbusting crash that shook the building and made the air twang like piano wire. It was just one single colossal explosion that might have been a huge bomb falling only yards away. There was a sharp tinkle as a piece of glass fell out of one of the windows onto the floor, and then the noise of water pattering in onto the linoleum. \n    I didn\'t move. I couldn\'t. I stood and cringed, my hands over my ears. I hadn\'t meant it to be like this! The silence, that had been deafening, resolved itself back into the roar of the rain, the roar that had been so comforting but that now said, \"You hadn\'t thought it could be so bad. You had never seen a storm in these mountains. Pretty flimsy this little shelter of yours, really. How\'d you like to have the lights put out as a start? Then the crash of a thunderbolt through that matchwood ceiling of yours? Then, just to finish you off, lightning to set fire to the place-perhaps electrocute you? Or shall we just frighten you so much that you dash out in the rain and try and make those ten miles to Lake George. Like to be alone, do you? Well, just try this for size!\" Again the room turned blue-white, again, just overhead, there came the ear-splitting crack of the explosion, but this time the crack widened and racketed to and fro in a furious cannonade that set the cups and glasses rattling behind the bar and made the woodwork creak with the pressure of the sound-waves.My legs felt weak, and I faltered to the nearest chair and sat down, my head in my hands. How could I have been so foolish, so-so impudent? If only someone would come, someone to stay with me, someone to tell me that this was only a storm! But it wasn\'t! It was catastrophe, the end of the world! And all aimed at me! Now! It would be coming again! Any minute now! I must do something, get help! But the Phanceys had paid off the telephone company, and the service had been disconnected. There was only one hope! I got up and ran to the door, reaching up for the big switch that controlled the VACANCY/NO VACANCY sign in red neon above the threshold. If I put it to VACANCY, there might be someone driving down the road. Someone who would be glad of shelter. But, as I pulled the switch, the lightning that had been watching me crackled viciously in the room, and, as the thunder crashed, I was seized by a giant hand and hurled to the floor."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView = UITextView.init(frame: self.view.bounds)
        textView.isEditable = false
        textView.alwaysBounceVertical = true
        textView.textColor = UIColor.init(white: 0.3, alpha: 1.0)
        textView.textAlignment = .justified
        textView.textContainerInset = UIEdgeInsets.init(top: 12, left: 8, bottom: 12, right: 8)
        self.view.addSubview(textView)
        
        textView.es_addPullToRefresh {
            [weak self] in
            guard let weakSelf = self else {
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                weakSelf.num = 0
                let style = NSMutableParagraphStyle.init()
                style.lineSpacing = 0.0
                style.firstLineHeadIndent = 10.0
                style.alignment = .justified
                weakSelf.textView.attributedText = NSAttributedString.init(string: weakSelf.text1, attributes: [NSParagraphStyleAttributeName : style, NSFontAttributeName: UIFont.init(name: "ChalkboardSE-Bold", size: 16.0)!, NSForegroundColorAttributeName: UIColor.init(white: 0.3, alpha: 1.0)])
                weakSelf.textView.es_stopPullToRefresh()
            }
        }
        
        textView.es_addInfiniteScrolling {
            [weak self] in
            guard let weakSelf = self else {
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                weakSelf.num += 1
                var str: String = weakSelf.text1
                if weakSelf.num >= 1 {
                    str += weakSelf.text2
                }
                if weakSelf.num >= 2 {
                    str += weakSelf.text3
                }
                if weakSelf.num >= 3 {
                    str += weakSelf.text4
                }
                if weakSelf.num >= 4 {
                    str += weakSelf.text5
                }
                if weakSelf.num >= 5 {
                    str += weakSelf.text6
                }
                if weakSelf.num >= 6 {
                    str += weakSelf.text7
                }
                if weakSelf.num >= 7 {
                    weakSelf.textView.es_noticeNoMoreData()
                } else {
                    let style = NSMutableParagraphStyle.init()
                    style.lineSpacing = 0.0
                    style.firstLineHeadIndent = 10.0
                    style.alignment = .justified
                    weakSelf.textView.attributedText = NSAttributedString.init(string: str, attributes: [NSParagraphStyleAttributeName : style, NSFontAttributeName: UIFont.init(name: "ChalkboardSE-Bold", size: 16.0)!, NSForegroundColorAttributeName: UIColor.init(white: 0.3, alpha: 1.0)])

                    weakSelf.textView.es_stopLoadingMore()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.textView.es_startPullToRefresh()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !textView.frame.equalTo(self.view.bounds) {
            textView.frame = self.view.bounds
        }
    }
    
}
