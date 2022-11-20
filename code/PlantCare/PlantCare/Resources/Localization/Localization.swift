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
        static let GetStarted = "Get Started"
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
        static let AppleBlackRotCondition = ""
        static let AppleBlackRotTreatment = "After harvesting, it is necessary to cut down thoroughly and collect all remnants of diseased plants to focus and burn to avoid spreading. When signs of disease appear, remove the diseased area to avoid spreading. Insect screens can be used to keep insects out. In addition, copper-based sprays, lime sulfur can be used to control the disease. How to use please read the label carefully. How to use please read the label carefully. Pay attention to spray at times before the new batch of plants."
        
        static let AppleCedar = "Cedar Apple Rust"
        static let AppleCedarAbout = "Signs of this disease are rust spots on the leaves. The fruit may also be deformed or spotty."
        static let AppleCedarCondition = "It will spread from leaf to fruit."
        static let AppleCedarTreatment = "When diseased plants are detected, they should be removed to avoid infecting other plants. Some chemical drugs can be used to combat this disease."
    }
    
    struct CornDisease {
        static let Corn = "Corn"
        
        static let CornGraySpot = "Corn Grey Leaf Spot"
        static let CornGraySpotAbout = "This disease is common in maize and the extent of damage depends on the cultivar. The disease affects mainly leaf blades, leaf nests and seeds. The disease causes damage from the time the plant has 2-3 leaves until the end of the growth period of the plant. Lesions are initially small, needle-like, yellowish spots that then expand into small circles or ovals."
        static let CornGraySpotCondition = ""
        static let CornGraySpotTreatment = "Use disease resistant varieties. Note, seeds can be treated with Rovrral before planting. Sanitize the field, remove the remnants of diseased plants. When plants are sick, chemical drugs Tilt 250ND and Anvil 5SC 0.1% concentration can be used to prevent diseases in the field (Please read the instructions carefully before using)."
        
        static let CornRust = "Common Rust"
        static let CornRustAbout = "Signs of this disease are clear yellow to pale yellow spots, scattered on the leaf blade. After a period of time, the disease covers the leaves, creating long black spots on the leaves. The disease persists on leaf, seed and corn residues. The disease appears more during the flowering stage. The disease causes poor plant growth, and reduced yield."
        static let CornRustCondition = "T"
        static let CornRustTreatment = "Sanitize the field, increase intensive farming. When detecting diseased plants, some chemical drugs such as New Kasuran can be used; Dithane; Anvil; Kumulus; Cavil; Tilvil; Vectra; Copper – zin C… (Remember to read carefully before using)."
        
        static let CornNorthenBlight = "Northern Corn Leaf Blight"
        static let CornNorthenBlightAbout = "The lesions are long and round or oval, brown or silver-gray, without a yellow halo. If the disease is severe, many spots will mix together, making the whole leaf dry. Leaves lose color, wither and become brittle."
        static let CornNorthenBlightCondition = "Large leaf spot disease often occurs in bad, underdeveloped corn fields; bad fields, lowland or waterlogged soil, fields with heavy texture, tight, easy to scum, or fields that are often lack of water… making corn plants grow poorly, stunted, unable to develop as well. is a condition for the disease to arise and cause more damage than other fields, old leaves close to the base often arise first, severe disease can spread to the upper leaves. The fungus enters the leaves mainly through the stomata, mostly in the young parts of the plant.\nThe growth temperature of the fungus is 5-8°C, 27-35°C."
        static let CornNorthenBlightTreatment = "Rotating maize with legumes.\nUse disease resistant maize.\nCollect the remnants of corn and then take it out of the field to destroy.\nFertilize fully and balance for corn plants. Increase potassium fertilizer for corn.\nTreat corn seeds with hot water of 52°C for 10 minutes."
    }
    
    struct Grape {
        static let Grape = "Grape"
        struct BlackRot {
            static let BlackRot = "Black Rot"
            static let BlackRotAbout = ""
            static let BlackRotCondition = ""
            static let BlackRotTreatment = ""
        }
        
        struct Esca {
            static let Esca = "Grape Esca"
            static let EscaAbout = ""
            static let EscaCondition = ""
            static let EscaTreatment = ""
        }
        
        struct GrapeLeafBlight {
            static let GrapeLeafBlight = "Grape Leaf Blight"
            static let GrapeLeafBlightAbout = ""
            static let GrapeLeafBlightCondition = ""
            static let GrapeLeafBlightTreatment = ""
        }
    }
    
    struct Orange {
        static let Orange = "Orange"
        static let OrangeHaunglongbing = "Orange Haunglongbing"
        static let OrangeHaunglongbingAbout = ""
        static let OrangeHaunglongbingCondition = ""
        static let OrangeHaunglongbingTreatment = ""
    }
    
    struct Peach {
        static let Peach = "Peach"
        static let PeachBacterialSpot = "Peach Bacterial Spot"
        static let PeachBacterialSpotAbout = ""
        static let PeachBacterialSpotCondition = ""
        static let PeachBacterialSpotTreatment = ""
    }
    
    struct PepperBell {
        static let PepperBell = "Pepper Bell"
        struct BacterialSpot {
            static let BacterialSpot = "Bacterial Spot"
            static let BacterialSpotAbout = ""
            static let BacterialSpotCondition = ""
            static let BacterialSpotTreatment = ""
        }
    }
    
    struct Potato {
        static let Potato = "Potato"
        
        struct EarlyBlight {
            static let EarlyBlight = "Early Blight"
            static let EarlyBlightAbout = ""
            static let EarlyBlightCondition = ""
            static let EarlyBlightTreatment = ""
        }
        
        struct LateBlight {
            static let LateBlight = "Late Blight"
            static let LateBlightAbout = ""
            static let LateBlightCondition = ""
            static let LateBlightTreatment = ""
        }
    }
    
    struct Squash {
        static let Squash = "Squash"
        static let SquashPowderyMildew = "Squash Powdery Mildew"
        static let SquashPowderyMildewAbout = ""
        static let SquashPowderyMildewCondition = ""
        static let SquashPowderyMildewTreatment = ""
    }
    
    struct Strawberry {
        static let Strawberry = "Strawberry"
        static let StrawberryLeafScorch = "Strawberry Leaf Scorch"
        static let StrawberryLeafScorchAbout = ""
        static let StrawberryLeafScorchCondition = ""
        static let StrawberryLeafScorchTreatment = ""
    }
    
    struct Tomato {
        static let Tomato = "Tomato"
        
        struct TomatoBacterialSpot {
            static let TomatoBacterialSpot = "Tomato Bacterial Spot"
            static let TomatoBacterialSpotAbout = ""
            static let TomatoBacterialSpotCondition = ""
            static let TomatoBacterialSpotTreatment = ""
        }
        
        struct TomatoEarlyBlight {
            static let TomatoEarlyBlight = "Tomato Early Blight"
            static let TomatoEarlyBlighAbout = ""
            static let TomatoEarlyBlighCondition = ""
            static let TomatoEarlyBlighTreatment = ""
        }
        
        struct TomatoLateBlight {
            static let TomatoLateBlight = "Tomato Late Blight"
            static let TomatoLateBlightAbout = ""
            static let TomatoLateBlightCondition = ""
            static let TomatoLateBlightTreatment = ""
        }
        
        struct TomatoLeafMold {
            static let TomatoLeafMold = "Tomato Leaf Mold"
            static let TomatoLeafMoldAbout = ""
            static let TomatoLeafMoldCondition = ""
            static let TomatoLeafMoldTreatment = ""
        }
        
        struct TomatoSeptoriaLeafSpot {
            static let TomatoSeptoriaLeafSpot = "Tomato Septoria Leaf Spot"
            static let TomatoSeptoriaLeafSpotAbout = ""
            static let TomatoSeptoriaLeafSpotCondition = ""
            static let TomatoSeptoriaLeafSpotTreatment = ""
        }
        
        struct TomatoSpiderMites {
            static let TomatoSpiderMites = "Tomato Spider Mites"
            static let TomatoSpiderMitesAbout = ""
            static let TomatoSpiderMitesCondition = ""
            static let TomatoSpiderMitesTreatment = ""
        }
        
        struct TomatoTargetSpot {
            static let TomatoTargetSpot = "Tomato Target Spot"
            static let TomatoTargetSpotAbout = ""
            static let TomatoTargetSpotCondition = ""
            static let TomatoTargetSpotTreatment = ""
        }
        
        struct TomatoYellowLeafCurlVirus {
            static let TomatoYellowLeafCurlVirus = "Tomato Yellow Leaf Curl Virus"
            static let TomatoYellowLeafCurlVirusAbout = ""
            static let TomatoYellowLeafCurlVirusCondition = ""
            static let TomatoYellowLeafCurlVirusTreatment = ""
        }
        
        struct TomatoMosaicVirus {
            static let TomatoMosaicVirus = "Tomato Mosaic Virus"
            static let TomatoMosaicVirusAbout = ""
            static let TomatoMosaicVirusCondition = ""
            static let TomatoMosaicVirusTreatment = ""
        }
    }
    
    struct Cherry {
        static let Cherry = "Cherry"
        static let CherryPowderyMildew = "Cherry Powdery Mildew"
        static let CherryPowderyMildewAbout = ""
        static let CherryPowderyMildewCondition = ""
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

