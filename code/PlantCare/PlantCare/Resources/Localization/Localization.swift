import Foundation

struct Localization {
    struct Language {
        static let Vietnamese = "Vietnamese"
        static let English = "English"
    }
    
    struct TitleApp {
        static let Title = "PlantCare"
    }
    
    struct Onboarding {
        static let Skip = "Skip"
        static let Next = "Next"
        static let GetStarted = "Get Started!"
        static let titleSlide1 = "Identify Plant Diseases"
        static let descriptionSlide1 = "You can identify the plant diseases you don't know through your camera"
        static let titleSlide2 = "Discover Many Plant Diseases"
        static let descriptionSlide2 = "Let's learn about the many plant diseases that exist in the world"
        static let titleSlide3 = "Q&A About Plant Diseases"
        static let descriptionSlide3 = "Let's ask questions and answers with the community"
    }
    
    struct Authenticate {
        static let EmailPlaceHolder = "Enter email..."
        static let NewEmailPlaceHolder = "Enter new email..."
        static let PasswordPlaceHolder = "Enter password..."
        static let NewPasswordPlaceHolder = "Enter new password..."
        static let OldPasswordPlaceHolder = "Enter old password..."
        static let Email = "Email"
        static let Password = "Password"
        static let UsernamePlaceholder = "Enter username..."
        static let NewUsernamePlaceholder = "Enter new username..."
        static let NoAccount = "Don't have an account?"
        static let AlreadyAccount = "Already have an account?"
        static let ConfirmPassword = "Re-enter password..."
        
        static let Login = "Login"
        static let Register = "Register"
        static let CreateAccount = "Create your account"
        
        static let ForgotPass = "Forgot password?"
        static let ResetPassTitle = "Reset Password"
        static let ResetPassInfo = "Enter your email address and follow the instructions on the link in the email you received to reset your password"
        static let Send = "Send"
        static let RequirementPassword = "Password is at least 8 characters, contains a special character and a number."
        static let ErrorRequirementPassword = "Please make sure your password is at least 8 characters, contains a special character and a number."
        static let LogOut = "Log Out"
        static let EmptyErrorTF = "Please enter this field!"
    }
    
    struct Home {
        static let TakePicture = "Take a picture"
        static let Diagnois = "See diagnosis"
        static let Medicine = "Get medicine"
        static let SelectImg = "Select a photo"
        static let Photo = "Photo"
        static let Camera = "Camera"
        static let Cancel = "Cancel"
        static let Search = "Search..."
        static let All = "All"
        static let SearchTitle = "Search"
        static let ReferenceResult = "Bạn nhận thấy kết quả đúng không?"
        static let Heal = "Plant piseases classification"
        static let References = "References"
    }
    
    struct AppleDisease {
        static let Apple = "Apple"
        
        static let AppleScab = "Apple Scab"
        static let AppleScabAbout = "The disease usually occurs on leaves and fruits. In the leaves, the diseased spots are round, greenish gray and slightly raised, usually appearing under the leaves, and then gradually spreading to other places. On the fruit, the diseased spots are dark brown, and also raised like scabs and cracks, the fruit is distorted and falls prematurely. At first, the spots are round, bluish-gray in color, then gradually become more prominent and have bluish-black filaments. Over a period of time, these filaments disappear, and the lesions grow up like thorns. In the later stages, the disease causes the leaves to shrivel and die, and the lesions on the fruit turn dark brown, and scab and crack. If there is no timely treatment, the fruit will be deformed, distorted, low quality, hard fruit pulp and less water, sometimes falling prematurely."
        static let AppleScabTreatment = "After harvesting, it is necessary to cut down thoroughly and collect all remnants of diseased plants to focus and burn to avoid spreading. Do not plant too thick to make the garden lack of light. Regularly prune to have ventilation, avoid high humidity to help plants grow well. When the disease first appears, it is possible to use some chemical drugs such as Carosal 50SC, Canazole Super 320EC, Azoxystrobin, Benomyl, Metalaxyl ... and should spray the foliage and fruits evenly. How to use please read the label carefully. Pay attention to spray at times before the new batch of plants."
        
        static let AppleBlackRot = "Apple Black Rot"
        static let AppleBlackRotAbout = "This disease occurs in leaves, fruit and bark. The disease usually appears starting on the leaves. The leaves have purple spots on the leaf surface, and as these spots age, the edges are purple, and the center of the spot is yellow-brown. This disease causes leaves to fall, affecting crop yield."
        static let AppleBlackRotTreatment = "After harvesting, it is necessary to cut down thoroughly and collect all remnants of diseased plants to focus and burn to avoid spreading. When signs of disease appear, remove the diseased area to avoid spreading. Insect screens can be used to keep insects out. In addition, copper-based sprays, lime sulfur can be used to control the disease. How to use please read the label carefully. How to use please read the label carefully. Pay attention to spray at times before the new batch of plants."
        
        static let AppleCedar = "Cedar Apple Rust"
        static let AppleCedarAbout = "Signs of this disease are rust spots on the leaves. The fruit may also be deformed or spotty."
        static let AppleCedarTreatment = "When diseased plants are detected, they should be removed to avoid infecting other plants. Some chemical drugs can be used to combat this disease."
    }
    
    struct Blueberry {
        static let Blueberry = "Blueberry"
    }
    
    struct Raspberry {
        static let Raspberry = "Raspberry"
    }
    
    struct Soybean {
        static let Soybean = "Soybean"
    }
    
    struct CornDisease {
        static let Corn = "Corn"
        
        static let CornGraySpot = "Corn Grey Leaf Spot"
        static let CornGraySpotAbout = "This disease is common in maize and the extent of damage depends on the cultivar. The disease affects mainly leaf blades, leaf nests and seeds. The disease causes damage from the time the plant has 2-3 leaves until the end of the growth period of the plant. Lesions are initially small, needle-like, yellowish spots that then expand into small circles or ovals."
        static let CornGraySpotTreatment = "Use disease resistant varieties. Note, seeds can be treated with Rovrral before planting. Sanitize the field, remove the remnants of diseased plants. When plants are sick, chemical drugs Tilt 250ND and Anvil 5SC 0.1% concentration can be used to prevent diseases in the field (Please read the instructions carefully before using)."
        
        static let CornRust = "Common Rust"
        static let CornRustAbout = "Signs of this disease are clear yellow to pale yellow spots, scattered on the leaf blade. After a period of time, the disease covers the leaves, creating long black spots on the leaves. The disease persists on leaf, seed and corn residues. The disease appears more during the flowering stage. The disease causes poor plant growth, and reduced yield."
        static let CornRustTreatment = "Sanitize the field, increase intensive farming. When detecting diseased plants, some chemical drugs such as New Kasuran can be used; Dithane; Anvil; Kumulus; Cavil; Tilvil; Vectra; Copper – zin C… (Remember to read carefully before using)."
        
        static let CornNorthenBlight = "Northern Corn Leaf Blight"
        static let CornNorthenBlightAbout = "Signs of this disease are long, round or oval spots on leaves, only brown or silver gray. If the disease is not treated in time, these spots will spread, causing the leaves to dry out, causing the leaves to lose color, wither and become brittle. In bad, underdeveloped, sunken corn fields, or lack of water, corn plants grow poorly, stunt, and fail to develop, which are also conditions for this disease to develop. Usually this disease appears on the old leaves, close to the base, then spreads to the upper leaves."
        static let CornNorthenBlightTreatment = "Crop maize with legumes. Use disease resistant varieties. Need to fertilize fully and balance, increase potassium fertilizer. When diseased plants are detected, they should be removed to avoid infecting other plants. Before sowing, corn seeds should be treated with hot water of 52°C for 10 minutes."
    }
    
    struct Grape {
        static let Grape = "Grape"
        struct BlackRot {
            static let BlackRot = "Grape Black Rot"
            static let BlackRotAbout = "This disease is caused by the fungus Guignardia bidwellii. The warm and humid climate is also favorable for pathogens to grow. The disease affects all parts of the vine, especially the fruit. Signs of disease on leaves are round black spots, which gradually spread, then cause the leaves to wilt, then fall off the tree. As for the fruit, the disease causes the fruit to soften, rot and wither, causing loss of crop yield."
            static let BlackRotTreatment = "Use disease resistant varieties. Sanitize the field, remove the remnants of diseased plants. Prevention can be sprayed by spraying Score 250 ND (2 ml / 8 -10 liter bottle), Topsin M 70% (10 – 15 g / 10 liter bottle) or Anvil 5 SC (10 – 15 ml / bottle) (Remember read the user manual before use)."
        }
        
        struct Esca {
            static let Esca = "Grape Esca"
            static let EscaAbout = "This disease is caused by different fungi. This disease affects only mature trees, ten years of age or older. Heavy pruning, winter frosts or damaged trees, are also among the causes of this disease. Signs of disease often go unnoticed and can cause sudden plant death. The telltale sign of this disease appearing on the leaves is the presence of black spots on the leaf surface."
            static let EscaTreatment = "Use disease resistant varieties. Sanitize the field, remove the remnants of diseased plants. Some chemical methods can be used to control pests."
        }
        
        struct GrapeLeafBlight {
            static let GrapeLeafBlight = "Grape Leaf Blight"
            static let GrapeLeafBlightAbout = "This disease occurs in all parts of the plant. Signs of this disease are black spots appearing on the surface of the leaves."
            static let GrapeLeafBlightTreatment = "Use disease resistant varieties. Sanitize the field, remove the remnants of diseased plants. Some chemical methods can be used to control pests."
        }
    }
    
    struct Orange {
        static let Orange = "Orange"
        static let OrangeHaunglongbing = "Orange Haunglongbing"
        static let OrangeHaunglongbingAbout = "This disease is very common in citrus fruit trees. Signs of disease on leaves are based on the color of orange leaves. Orange leaves will yellow the entire leaf blade and have a darker yellow color and emerge in the veins. The disease will develop on the upper leaves first, then on the lower leaves."
        static let OrangeHaunglongbingTreatment = "To avoid diseased plants, it is necessary to rotate crops, create drainage ditches to avoid sunken gardens. Limit inorganic fertilizers, increase organic fertilizers. When a diseased tree is detected, it is necessary to prune and remove the diseased part. Add fertilizer to the plants."
    }
    
    struct Peach {
        static let Peach = "Peach"
        static let PeachBacterialSpot = "Peach Bacterial Spot"
        static let PeachBacterialSpotAbout = "The disease appears on fruit and leaves, and can spread to branches. The disease appears on leaves with purple-red spots, which over time can cause leaves to puncture, and fall off the tree. In fruit, this disease will initially appear small black spots and gradually spread, affecting the quality of the fruit. The disease usually develops in humid places."
        static let PeachBacterialSpotTreatment = "Regularly prune to have ventilation, avoid high humidity to help plants grow well. When sick, some chemical measures can be used when necessary."
    }
    
    struct PepperBell {
        static let PepperBell = "Pepper Bell"
        struct BacterialSpot {
            static let BacterialSpot = "Bacterial Spot"
            static let BacterialSpotAbout = "The disease develops mainly on the leaves of Banh Mi to the leaves of bean sprouts. The disease appears on leaves with yellow and round lesions, brown spots in the middle, surrounded by yellow borders and often appears on the underside of leaves. In fruit, lesions are brown, elongated and often wet. In addition to leaves and fruit, the disease usually appears on the stem and fruit stalk. This disease causes leaves to fall, dry, underdeveloped plants, reduce crop yield."
            static let BacterialSpotTreatment = "Diseased parts should be removed. Several biological safety measures can be used. When necessary, can use some drugs with active ingredients such as Mancozed,... (Remember to read the instructions carefully before using)."
        }
    }
    
    struct Potato {
        static let Potato = "Potato"
        
        struct EarlyBlight {
            static let EarlyBlight = "Potato Early Blight"
            static let EarlyBlightAbout = "Dark lesions with yellow borders may form concentric rings of raised and sunken tissue on leaves and stems; lesions are initially circular but become angular; leaves are necrotic but still attached to the plant; dry, dark lesions on tubers with a skin-like or rough texture and yellow margins with greenish water."
            static let EarlyBlightTreatment = "Use disease resistant varieties. Increase rotation with other varieties, planting with appropriate density. Balanced fertilization, supplemented with intermediate and trace elements to help increase the resistance of plants such as foliar fertilizers. In cloudy weather with little sunshine, a lot of fog, with drizzle, cool and humid air, it is necessary to prevent in advance with the following drugs: ZIN 80WP, or DIPOMATE 80WP. Should spray 2 times 5-7 days apart when new diseases appear on the tree."
        }
        
        struct LateBlight {
            static let LateBlight = "Potato Late Blight"
            static let LateBlightAbout = "The disease usually appears first on the leaf apex, creating a pale greenish stain and then spreading to the leaf blade. The middle part of the disease turns black-brown and around the disease, there is often a layer of spongy white spores covered like a layer of white mold like frost, causing the leaves to die quickly. Diseases on petioles, branches and stems, at first as brown or black spots, then spread around and extend into segments. The disease makes the stem rot soft and easily broken."
            static let LateBlightTreatment = "Avoid farming during the rainy season. Create ventilation conditions for tomato fields. Do not plant many consecutive crops or years on the same field. Apply Ridomil Gold, Copper Zinc as recommended."
        }
    }
    
    struct Squash {
        static let Squash = "Squash"
        static let SquashPowderyMildew = "Squash Powdery Mildew"
        static let SquashPowderyMildewAbout = "The disease appears at the very beginning of plant growth. Initially, small spots appear on the leaves, gradually covered with a layer of white fungus, dense like powdery powder appearing to cover the entire leaf blade. Diseased leaves gradually turn from green to yellow, dry leaves burn and fall easily. The disease occurs in all parts of the plant. The disease causes weak vigor, low quality and poor yield. The disease develops strongly in high humidity conditions, but dry conditions are favorable for the dispersal of fungal spores in the field. In particular, powdery mildew damages both sides of leaves, often causing strong damage on the upper surface. The fungus survives in the seeds of diseased plant residues and is spread by wind."
        static let SquashPowderyMildewTreatment = "Sanitize the field, remove disease remnants. Make high beds, good drainage to avoid high humidity. Planting at a reasonable density, do not plant too thick, easy to cause serious damage. Choose good, clean, disease-resistant varieties. Clean up diseased plant residues after harvest. Treat seeds with specific drugs for each disease before planting. It is possible to use some pesticides to spray unless the disease is early appearing and there are favorable weather conditions for the development of the disease such as Score, Topsin M, Anvil, Mataxyl, Aliette, Ridomil Gold, Agri-phos, Phosphonate... for spraying to eliminate downy mildew (Remember to read the instructions carefully before using)."
    }
    
    struct Strawberry {
        static let Strawberry = "Strawberry"
        static let StrawberryLeafScorch = "Strawberry Leaf Scorch"
        static let StrawberryLeafScorchAbout = "The disease initially appears as small spots, then spreads to dark brown areas. The disease can infect petioles, calyx and fruit. Plants can die when severely infected, at which time the stems and leaves will be deformed and purple-black. The disease often appears on young leaves, reducing the yield of plants."
        static let StrawberryLeafScorchTreatment = "Use disease resistant varieties. Reasonable planting density. Treat the soil before sowing. Proper watering. Use RV04 for leaf burn."
    }
    
    struct Tomato {
        static let Tomato = "Tomato"
        
        struct TomatoBacterialSpot {
            static let TomatoBacterialSpot = "Tomato Bacterial Spot"
            static let TomatoBacterialSpotAbout = "This disease is caused by the bacterium Septoria lycopersici, which especially thrives in warm, humid conditions. Dark brown spots first appear on the undersides of the lower leaves, growing and joining together over time. Eventually, infected leaves will drop and the plant will be severely weakened by lack of photosynthesis."
            static let TomatoBacterialSpotTreatment = "It is necessary to remove the diseased parts, and then spray the remaining parts of the plant with an organic fungicide based on copper or potassium bicarbonate."
        }
        
        struct TomatoEarlyBlight {
            static let TomatoEarlyBlight = "Tomato Early Blight"
            static let TomatoEarlyBlighAbout = "The disease can cause damage during the growing period of tomato plants, but is usually more damaging from flowering to mature fruit. Infected plants will wilt first, may wilt a branch or a small branch, then the lower leaves continue to wilt and droop, eventually leading to the entire plant withering, falling, and death. The disease often arises, develops and causes severe damage in conditions of high air temperature and humidity, causing much damage to farmers."
            static let TomatoEarlyBlighTreatment = "Use disease resistant varieties. Make high beds, plant trees with a moderate density. Fertilize balance between nitrogen, phosphorus and potassium, and add organic fertilizer, lime powder for plants. Rotate with other plants. When there are signs of disease, it may be necessary to use Stamer 20 WP to spray immediately."
        }
        
        struct TomatoLateBlight {
            static let TomatoLateBlight = "Tomato Late Blight"
            static let TomatoLateBlightAbout = "Signs of disease are green-brown spots appearing on the leaf edges and tips, gradually, turning completely brown. As the disease develops, the leaves turn brown, curl, and dry out. The possibility of infection is high in the summer."
            static let TomatoLateBlightTreatment = "Use disease resistant varieties. Reasonable planting density. Should rotate regularly. Tomatoes and potatoes should not be planted next to each other. Fertilizers containing silicon can help plants strengthen resistance to mold. When sick, can spray some fungicides based on mandipropamide, fluazinam, mancozed, chlorothalonil to treat the disease (Remember to read the instructions carefully before using)."
        }
        
        struct TomatoLeafMold {
            static let TomatoLeafMold = "Tomato Leaf Mold"
            static let TomatoLeafMoldAbout = "Initially, the lesions are translucent, after spreading, the diseased tissue turns yellowish-gray in color. The disease appears on both sides of the leaves, causing the leaves to drop. The disease persists on diseased plant residues, spores spread in the air, fall on tomato leaves, infection occurs quickly but symptoms are shown slowly after 2 weeks, disease often appears on lower leaves root. Warm and humid weather is also one of the conditions for the development of the disease."
            static let TomatoLeafMoldTreatment = "Field sanitation. Using disease-resistant varieties Building a trellis, pruning leaves at the base, increasing ventilation for tomato beds has the effect of reducing disease severity. Use pesticides with the following active ingredients for prevention and control: Azoxystrobin, Difenoconazole Validacin, Hexaconazole..."
        }
        
        struct TomatoSeptoriaLeafSpot {
            static let TomatoSeptoriaLeafSpot = "Tomato Septoria Leaf Spot"
            static let TomatoSeptoriaLeafSpotAbout = "The disease can enter during the young plant stage. The pathogen mainly damages leaves and can infect the body. Initially, black spots appear on the leaf surface like a needle, so farmers often call it pinworm disease, soggy spots with a diameter of 1-3 mm later develop into round spots with a black border. and in the center is gray. Lesions can grow up to 5-6 mm. The disease occurs first on the lower leaves, heavily infected leaves turn yellow, then turn brown and then drop leaves. Plants are most susceptible to disease during the fruiting stage. Radiation disease occurs in all stages of plant growth and development, and is most harmful in wet weather conditions. The disease usually occurs after a period of continuous rain for many days."
            static let TomatoSeptoriaLeafSpotTreatment = "Use disease-free seeds. Prune out diseased plant parts. Implement crop rotation. Reasonable planting density. The following drugs can be used to control the disease such as the active ingredient Chlorothalonil (Daconil 75WP), the active ingredient Azoxystrobin (Overamis 300SC), the drug Mighty 560SC, a mixture of the two above active ingredients (Azoxystrobin 60g/l + Chlorothalonil 500g/l) , Mancozeb active ingredients such as Dithane 80WP, Penncozeb 75DF, Manzate 75DF..., copper-based drugs such as Kocide, Champion, Cuproxat...or a mixture of Chlorothalonil and Carbendazim also bring very high efficiency (Remember to read the instructions carefully before using). when used). It is recommended to spray after rain and spray again after 5-7 days."
        }
        
        struct TomatoSpiderMites {
            static let TomatoSpiderMites = "Tomato Two Spotted Spider Mite"
            static let TomatoSpiderMitesAbout = "The leaves have yellow and white spots, which are easy to recognize. The tomato leaves will blister, yellow and rough and eventually dry and fall off. In addition, the fruit can also be infected with this disease."
            static let TomatoSpiderMitesTreatment = "Use drugs containing the active ingredient chlorantraniliprole to kill spiders (Be sure to read the instructions carefully before using)."
        }
        
        struct TomatoTargetSpot {
            static let TomatoTargetSpot = "Tomato Target Spot"
            static let TomatoTargetSpotAbout = "The disease affects older leaves first, initially as a yellow-green spot, without obvious margins, forming on the upper surface of the leaf. The underside of the disease forms a greenish-gray mold like velvet, the lesions are linked, turning brown, causing the leaves to wilt, die but usually do not fall. The disease also causes damage on inflorescences, left peduncles become black spots, concave, after drying, they fall off. The disease thrives in conditions of humidity > 85%, high humidity, the fungus forms many spores and spreads rapidly. Spores are easily transmitted by wind, rain, tools and insects."
            static let TomatoTargetSpotTreatment = "Remove diseased plant parts. A number of biological and chemical methods can be used to prevent and treat plant diseases."
        }
        
        struct TomatoYellowLeafCurlVirus {
            static let TomatoYellowLeafCurlVirus = "Tomato Yellow Leaf Curl Virus"
            static let TomatoYellowLeafCurlVirusAbout = "The disease is caused by a viral infection, usually spread by aphids or brought into the garden through infected seedlings. The first sign is that the foliage curls inward, then begins to turn yellow. Plant growth will be stunted, flowering will be reduced and fruit set will be reduced or stopped altogether."
            static let TomatoYellowLeafCurlVirusTreatment = "Field sanitation. Use disease resistant varieties. Making trellis, pruning leaves at the base, increasing ventilation for tomato beds have the effect of reducing the level of disease."
        }
        
        struct TomatoMosaicVirus {
            static let TomatoMosaicVirus = "Tomato Mosaic Virus"
            static let TomatoMosaicVirusAbout = "Diseased plants are dwarfed, number of flowers are few, leaf margins are yellow, leaves are curled up, leaf size is reduced. When infected early, leaves strongly curled and no fruit, early tree stunted, withered, with mild disease, barren, deformed fruit, easy to fall, reduced fruit quality, reduced yield. The disease thrives in conditions of high temperature and humidity, so it usually thrives in the months of April to September. Tomatoes are planted too thickly, fertilized with inorganic nitrogen, and soil moisture is too high. and heavy. The high density of white planthoppers 3-4 individuals/m2 can cause diseases and develop in a wide range, young tomatoes without flowers have few diseases, in the flowering period, disease results often develop and cause severe damage."
            static let TomatoMosaicVirusTreatment = "Field sanitation. Use disease resistant varieties. Some chemical measures can be used by spraying to control the density of whitefly with drugs such as Rong Viet, Penalduc 145EC, Super King 500SL, Voiduc, ... (Remember to read the instructions carefully before use. use)."
        }
    }
    
    struct Cherry {
        static let Cherry = "Cherry"
        static let CherryPowderyMildew = "Cherry Powdery Mildew"
        static let CherryPowderyMildewAbout = "Initially, the leaves appear yellow spots, gradually forming a white powdery layer, then turning gray and spreading on leaves, stems and fruits. Fungi survive at 10-12°C, but optimal conditions are at 30°C."
        static let CherryPowderyMildewTreatment = ""
    }
    
    struct Result {
        static let PredictionTitle = "Prediction"
        static let SymptomTitle = "Symptom"
        static let ConditionTitle = "Conditions for disease development"
        static let PreventionTitle = "Prevention and treatment"
        static let CertaintyTitle = "Certainty"
        static let TypeTitle = "Type"
        static let ThreatTitle = "Threat Level"
        
        static let HighLevel = "High"
        static let LowLevel = "Low"
        static let MediumLevel = "Medium"
        
        static let Fungus = "Fungus"
        static let Healthy = "Healthy"
        
        static let None = "None"
        static let NoResult = "No Result"
        
        static let Fungi = "Fungi"
        static let Bacterial = "Bacterial"
        static let Mold = "Mold"
        static let Virus = "Virus"
        static let Mite = "Mite"
    }
    
    struct Setting {
        static let Language = "Language"
        static let PostingHistory = "Posting history"
        static let SearchingHistory = "Searching history"
        static let EditingInfo = "Editing profile"
        static let EditingInfoPlaceholder = "Enter something"
    }
    
    struct Title {
        static let Result = "Result"
        static let Refernce = "Reference"
        static let Setting = "Setting"
        static let Welcome = "Welcome to PlantCare"
        static let EditProfile = "Edit Profile"
    }
    
    struct Forum {
        static let PlaceholderProblem = "Describe your problem ..."
        static let Post = "Post"
        static let Forum = "Forum"
        static let Comment = "Comment"
    }
    
    struct Alert {
        static let Congrat = "Hurray!"
        static let RegisterSuccessfully = "Register successfully!"
        static let GoLogIn = "Log in"
        static let Cancel = "Cancel"
        static let Sorry = "Sorry"
        static let OK = "OK"
        static let ResetEmail = "A password reset email has been sent!"
        static let LogOut = "Log Out"
        static let LogoutMessage = "Are you sure you want to log out?"
        static let Save = "Save"
        static let Yes = "Yes"
        static let No = "No"
        static let AuthentInfo = "Is the result right?"
        static let NotLogIn = "Your account is not logged in!"
        static let ReturnPage = "Homepage"
        static let SaveQuestion = "Do you want to save?"
    }
    
    struct Profile {
        static let MyAccount = "My Account"
        static let ChangePass = "Change password"
        static let EditPost = "Ask what?"
        static let Hello = "Hello!"
        static let Username = "Username"
        static let Email = "Email"
        static let Password = "Password"
    }
    
    struct Notification {
        static let Error = "Something went wrong."
        static let Success = "Thank you for rating."
        static let SavedSuccess = "Saved result successfully."
        static let DeletedSuccess = "Deleted successfully."
        static let Delete = "Delete"
        static let DeletePost = "Delete Post?"
        static let UpdateImage = "Changed image successfully."
        static let UpdateInfo = "Changed information successfully."
    }
    
    struct Labelling {
        static let Relabelling = "Relabel"
        static let PlantName = "Enter plant name"
        static let DiseaseName = "Enter disease name"
        
    }
    
    struct Postting {
        static let EmptyTextView = "Please enter something!"
        static let Cancel = "Cancel"
        static let SubmitPlaceHolder = "Add a comment..."
        static let Submit = "Submit"
        static let Share = "Share"
    }
    
    struct Time {
        static let JustNow = "Just now"
        static let SecondAgo = "second ago"
        static let SecondsAgo = "seconds ago"
        static let MinuteAgo = "minute ago"
        static let MinutesAgo = "minutes ago"
        static let HourAgo = "hour ago"
        static let HoursAgo = "hours ago"
        static let DayAgo = "day ago";
        static let DaysAgo = "days ago";
        static let WeekAgo = "week ago";
        static let WeeksAgo = "weeks ago";
    }
}

