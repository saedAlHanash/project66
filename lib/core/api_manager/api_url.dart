class GetUrl {
  static const temp = '';
  static const getHome = 'home';

  //--------------

  static const getAllCourses = 'courses';

  static const getAllLessons = 'lessons';

  static const getAllLessonsFree = 'lessons/free';

  static const getAllSeasons = 'seasons';

  static const getAllSummaries = 'summaries';

  static const getCourseProgress = 'courses/progress-user';
  static const getMe = 'auth/me';

  static const getAllNotifications = 'notifications';

  static const getSocialMedia = 'social-media';

  static const privacyPolicy = 'privacy-policy';

  static const getAnnouncements = 'announcements';

  static const favorite = 'favorites';

  static const productById = 'products';
  static const products = 'products';
  static const search = 'products/search';

  static const offers = 'products/offers';
  static const bestSeller = 'products/best-seller';
  static const setting = 'settings';

  static const orders = 'orders';

  static const categoryById = 'category';
  static const subCategoryById = 'subCategory';

  static const coupon = 'carts/redeem-coupon';

  static const flashDeals = 'products/flash-deals';

  static const categories = 'categories';
  static const banners = 'ads/banners';
  static const slider = 'ads/sliders';

  static const colors = 'colors';

  static const manufacturers = 'manufacturers';

  static const newArrivalProducts = 'products/new-arrivals';

  static const cart = 'carts';

  static const profile = 'profile';

  static const orderById = 'orders';

  static const subCategories = 'categories/sub';

  static const governors = 'governors';

  static const orderStatus = 'orders/statues';

  static const driverLocation = 'orders/coordinate';

  static const getMessages = 'drivers/messages';

  static const getSupportMessages = 'conversations';

  static const getRoomMessages = 'messages';

  static const faq = 'questions';

  static const termsAndConditions = 'pages';

  static const educationalGrade = 'educational-grade';

  static const shipment = 'Shipment/Get';

  static const loggedUser = 'User/GetLoggedUser';
  static const idType = 'IDType/Get';

  static const temps = '';

  static const office = 'Office/Get';
  static const package = 'PackageType/Get';

  static const trip = 'Trip/Get';

  static const content = 'PackageContentType/GetAll';

  static const weight = 'PackageWeight/Get';

  static const pairing = 'Pairing/Get';

  static const shipmentStates = 'Shipment/GetShipmentStates';

  static const track = 'ShipmentTracking/TrackByReferenceNo';

  static const banner = 'Banner/Get';

  static const offer = 'LoanOffer/Get';

  static const bank = 'Bank/Get';

  static const loanType = 'LoanType/Get';

  static const shortList = 'ShortList/Get';

  static const criterion = 'Criterion/Get';
}

class PostUrl {
  static const weights = 'PackageWeight/GetAll';
  static const offices = 'Office/GetAll';
  static const idTypes = 'IDType/GetAll';

  static const addReview = 'reviews';
  static const loginUrl = 'Auth/Login';
  static const logout = 'Auth/Logout';
  static const signup = 'Auth/RequestOtp';

  static const forgetPassword = 'auth/forget-password';

  static const resetPassword = 'password/reset';

  static const closeVideo = 'lessons/close-video';

  static const insertFireBaseToken = 'auth/me/update-fcm-token';

  static const uploadFile = 'FileManager/Upload';

  static const insertCode = 'courses/insert-code';

  static const confirmCode = 'Auth/ConfirmAccount';
  static const otpPassword = 'password/check';

  static const addShortListorite = 'favorites';

  static const restPass = 'reset-password';

  static const createOrder = 'checkout/cash';
  static const createEPaymentOrder = 'checkout/credit';

  static const resendCode = 'Auth/ResendOtp';

  static const addToCart = 'carts';

  static const updateProfile = 'User/UpdatePersonalData';

  static const addSupportMessage = 'messages/add';

  static const loginSocial = 'social/login';
  static const addPhone = 'social/add-phone';

  static const socialVerifyPhone = 'social/verify-phone';

  static const countries = 'Country/GetAll';

  static const cities = 'City/GetAll';

  static const shipments = 'Shipment/GetAll';

  static const temps = '';

  static const packages = 'PackageType/GetAll';

  static const trips = 'Trip/GetAll';

  static const contents = 'PackageContentType/GetAll';

  static const createShipment = 'Shipment/Add';

  static const createTrip = 'Trip/Add';

  static const updateShipment = 'Shipment/Update';

  static const fiendMatching = 'Pairing/FindMatch';

  static const createTemp = '';

  static const sendPairing = 'Pairing/SendParingRequest';

  static const pairingRequests = 'Pairing/GetAllPairingRequests';
  static const pairings = 'Pairing/GetAllPairings';

  static const notifications = 'User/GetNotifications';

  static const createBeneficiary = 'Beneficiary/Add';

  static const readNotification = 'User/ReadNotifications';

  static const banners = 'Banner/GetAll';

  static const sendBulk = 'MemberDetail/BulkUpdate';

  static const portfolios = 'MemberDetail/GetAll';

  static const createShortList = 'ShortList/Add';

  static const createOffer = 'LoanOffer/Add';

  static const offers = 'LoanOffer/GetAll';

  static const banks = 'Bank/GetAll';

  static const createBank = 'Bank/Add';

  static const createLoanType = 'LoanType/Add';

  static const loanTypes = 'LoanType/GetAll';

  static const shortLists = 'ShortList/GetAll';

  static const criteria = 'Criterion/GetAll';

  static const addOffer = 'ShortListOffer/Add';

  static const shortListOffers = 'ShortListOffer/GetAll';

  static const bankTypes = 'BankType/GetAll';

  static const applyOffer = 'OfferApplication/ApplyToLoan';

  static const appliedOffers = 'OfferApplication/MemberApplications';

  static var favs ='Favorite/GetAll';

  static var createFav = 'Favorite/Add';

  static String addMessage(int id) {
    return 'drivers/messages/$id/add';
  }

  static String increase(int id) {
    return 'carts/products/$id/quantity/increase';
  }

  static String decrease(int id) {
    return 'carts/products/$id/quantity/decrease';
  }
}

class PutUrl {
  static const updateName = 'update-name';
  static const updatePhone = 'update-phone';
  static const updateAddress = 'update-address';

  static const updateShipment = 'Shipment/Update';

  static const updateTrip = 'Trip/Update';

  static const updateTemp = '';

  static const updateBeneficiary = 'Beneficiary/Update';

  static const updateShortList = 'ShortList/Update';

  static const updateOffer = 'ShortListOffer/Update';

  static const updateBank = 'Bank/Update';

  static const updateLoanType = 'LoanType/Update';
}

class DeleteUrl {
  static const removeFromCart = 'carts/products';

  static const clearCart = 'carts';

  static const deleteTrip = 'Trip/Delete';

  static const deleteTemp = 'Criterion/Delete';
  static const deleteRequest = 'Pairing/DeleteParingRequest';

  static const deleteShipment = 'Shipment/Delete';

  static const deleteBeneficiary = 'Beneficiary/Delete';

  static const deletePairing = 'Pairing/CancelParing';

  static const deleteShortList = 'ShortList/Delete';

  static const deleteOffer = 'ShortListOffer/Delete';

  static const deleteBank = 'Bank/Delete';

  static const deleteLoanType = 'LoanType/Delete';

  static var deleteFav = 'Favorite/Delete';
}

class PatchUrl {
  static const updateUpdateStatus = 'Pairing/UpdateParingRequestStatus';

  static const cancelTrip = 'Trip/CancelTrip';
}

const additionalConst = '/api/v1/';
// const baseUrl = '192.168.1.112:5002';
const baseUrl = 'loanx.coretech-mena.com';
const imagePath = 'https://$baseUrl/documents/';
