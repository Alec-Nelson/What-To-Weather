<?php

include_once '../global.php';

// get the identifier for the page we want to load
$action = $_GET['action'];

// instantiate a SiteController and route it
$sc = new SiteController();
$sc->route($action);

class SiteController {

	// route us to the appropriate class method for this action
	public function route($action) {
		switch($action) {
			case 'home':
				$this->home();
				break;

			case 'signup':
				$this->signup();
				break;

			case 'about':
				$this->about();
				break;

			case 'login':
				$this->login();
				break;

			case 'logout':
				$this->logout();
				break;

			case 'signupUser':
				$this->signupUser();
				break;

			case 'settings':
				$this->settings();
				break;

			case 'settingsChange':
				$this->settingsChange();
				break;

			case 'settingsDelete':
				$this->settingsDelete();
				break;

			case 'settingsConfirm':
				$this->settingsConfirm();
				break;

      case 'signupCheck':
        $this->signupCheck();
        break;


      case 'addclothes':
        $this->addclothes();
        break;


      case 'addclothesSubmit':
        $this->addclothesSubmit();
        break;

      case 'posts':
        $this->posts();
        break;

      case 'postsSubmit':
        $this->postsSubmit();
        break;
		}

	}


	//takes user to log in page
    public function home() {
    	$pageTitle = 'Log in';
    	$posts = Posts::getAllPosts();
    	$authors = [];
    	$clothingString = [];
    	foreach($posts as $post){
    		array_push($authors, AppUser::loadById($post->get('author_id')));
    		$string = "Shirt: ";
    		$string .= Clothing::loadById($post->get('shirt_id'))->get('clothingname');
    		$string .= " Pants: ";
    		$string .= Clothing::loadById($post->get('pants_id'))->get('clothingname');
    		$string .= " Shoes: ";
    		$string .= Clothing::loadById($post->get('shoes_id'))->get('clothingname');
    		if($post->get('hat_id') != 0){
    			$string .= " Hat: ";
    			$string .= Clothing::loadById($post->get('hat_id'))->get('clothingname');
    		}
    		if($post->get('jacket_id') != 0){
    			$string .= " Jacket: ";
    			$string .= Clothing::loadById($post->get('jacket_id'))->get('clothingname');
    		}
    		array_push($clothingString, $string);
    	}
		include_once SYSTEM_PATH.'/view/LogIn.tpl';
    }

    public function signup() {
    	$pageTitle = 'Sign Up';
		include_once SYSTEM_PATH.'/view/SignUp.tpl';
    }

    public function about() {
    	$pageTitle = 'About';
		include_once SYSTEM_PATH.'/view/About.tpl';
    }

		public function addclothes() {
			//checks if user  is logged in
			// if not redirects to sign up page
			if( !isset($_SESSION['username']) || $_SESSION['username'] == '')
			{
				$_SESSION['error'] = "Account Required";
				header('Location: '.BASE_URL.'/signup');
			}
			else
			{
				$user = AppUser::loadByUsername($_SESSION['username']);
				$userName = $user->get('username');
				// $clothes = Clothing::getAllClothes();
				$clothes = Clothing::getClothingById($user->get('id'));
			}
			include_once SYSTEM_PATH.'/view/AddClothes.tpl';
    }

		public function login()
		{
			$un = $_POST['uname'];
				$pw = $_POST['pass'];
				$user = AppUser::loadByUsername($un);
				if($user == null) {
					// username not found
					$_SESSION['error'] = "Username not found";
					header('Location: '.BASE_URL);
				} // incorrect password
				elseif($user->get('pw') != $pw)
				{
					$_SESSION['error'] = "Incorrect Password";

				}
				else
				{
					$_SESSION['username'] = $un;
					$_SESSION['error'] = "You are logged in as ".$un.".";
				}

				// redirect to home page
				header('Location: '.BASE_URL);
		}

		// logs the user out
		// ends session
		public function logout() {
				// erase the session
				unset($_SESSION['username']);
				session_destroy(); // for good measure

				// redirect to home page
				header('Location: '.BASE_URL);
		}

		//creates users then
		//adds the user to the database
		public function signupUser()
		{
			//variables from page textbox
			$em = $_POST['email'];
			$un = $_POST['uname'];
			$pw = $_POST['pass'];
			$pw2 = $_POST['pass2'];
			//all fields must be entered
			if($un == null || $pw == null || $pw2 == null || $em == null)
			{
				$_SESSION['error'] = "Enter all fields";
				header('Location: '.BASE_URL.'/signup');
			}
			elseif($pw != $pw2)
			{
				$_SESSION['error'] = "Passwords Do Not Match";
			}
			else //creates new user with given fields
			{
				$user = new AppUser();
				$user->set('email', $em);
				$user->set('username', $un);
				$user->set('pw', $pw);
				$user->set('first_name', 'First Name');
				$user->set('last_name', 'Last Name');
				$user->save();
				$_SESSION['error'] = "Account Creation Successful";
				header('Location: '.BASE_URL);

			}
		}

		//takes user to settings pages
		public function settings()
		{
			//checks if user  is logged in
			// if not redirects to sign up page
			if( !isset($_SESSION['username']) || $_SESSION['username'] == '')
			{
				$_SESSION['error'] = "Account Required";
				header('Location: '.BASE_URL.'/signup');
			}
			else
			{
				$user = AppUser::loadByUsername($_SESSION['username']);
				$email = $user->get('email');
				$userName = $user->get('username');
				$firstName = $user->get('first_name');
				$lastName = $user->get('last_name');
				$pageTitle = 'Settings';
    			$pageContent = 'Some introductory text would go here.';
			}
			include_once SYSTEM_PATH.'/view/Settings.tpl';
		}

		//checks if any field have  new values
		//replaces those fields
		public function settingsChange()
		{
			$user = AppUser::loadByUsername($_SESSION['username']);
			if ($_POST['newEmail'] != null)
			{
				$user->set('email', $_POST['newEmail']);
			}
			if ($_POST['newUser'] != null)
			{
				$user->set('username', $_POST['newUser']);
				$_SESSION['username'] = $_POST['newUser'];
			}
			if ($_POST['newFirst'] != null)
			{
				$user->set('first_name', $_POST['newFirst']);
			}
			if ($_POST['newLast'] != null)
			{
				$user->set('last_name', $_POST['newLast']);
			}
			$user->save();
			header('Location: '.BASE_URL.'/settings');

		}

		//makes sure user wants to delete account
		public function settingsConfirm()
		{
			$_SESSION['error'] = "Are you sure you want to permantly delete your account?";
			$_SESSION['confirm'] = "true";
			header('Location: '.BASE_URL.'/settings');

		}

		//deletes user account
		//ends  session
		public function settingsDelete()
		{
			$user = AppUser::loadByUsername($_SESSION['username']);
			$user->delete();
			$_SESSION['confirm'] = null;
			$_SESSION['username'] = null;
			header('Location: '.BASE_URL);

		}

    public function signupCheck() {
    header('Content-Type: application/json'); // set the header to hint the response type (JSON) for JQuery's Ajax method
    $username = $_GET['username']; // get the username data

    // make sure it's a real username
    if(is_null($username) || $username == '') {
      echo json_encode(array('error' => 'Invalid username.'));
    } else {
      // okay, it's a real username. Is it available?
      $user = AppUser::loadByUsername($username);
      if(is_null($user)) {
        // $user is null, so username is available!
        echo json_encode(array(
          'success' => 'success',
          'check' => 'available'
        ));
      } else {
        echo json_encode(array(
          'success' => 'success',
          'check' => 'unavailable'
        ));
      }
    }


}

	public function addclothesSubmit()
	{
		$user = AppUser::loadByUsername($_SESSION['username']);
		header('Content-Type: application/json'); // set the header to hint the response type (JSON) for JQuery's Ajax method
		$clothingName = $_POST['clothingname']; // get the clothings name
		$clothingType = $_POST['clothingtype'];
		$tempMin = $_POST['tempmin'];
		$tempMax = $_POST['tempmax'];
		$author_id = $user->get('id');
		if ($clothingName == '' || $tempMin == '' || $tempMax =='')
		{
			echo json_encode(array(
						'success' => 'fail',
						'error' => 'Not All Entries filled'
					));
		}
		else
		{
			$clothing = new Clothing();
			$clothing->set('author_id', $author_id);
			$clothing->set('clothingname', $clothingName);
			$clothing->set('clothingtype', $clothingType);
			$clothing->set('tempmin', $tempMin);
			$clothing->set('tempmax', $tempMax);
			$clothing->save();
			echo json_encode(array(
						'success' => 'success',
						'check' => 'available',
						'name' => $clothingName,
						'type' => $clothingType,
						'min' => $tempMin,
						'max' => $tempMax
					));
		}

	}

	public function posts() {
	//checks if user  is logged in
	// if not redirects to sign up page
	if( !isset($_SESSION['username']) || $_SESSION['username'] == '')
	{
		$_SESSION['error'] = "Account Required";
		header('Location: '.BASE_URL.'/signup');
	}
	else
	{
		$user = AppUser::loadByUsername($_SESSION['username']);
		$userName = $user->get('username');
		// $clothes = Clothing::getAllClothes();
		$clothes = Clothing::getClothingById($user->get('id'));
		// $jackets = Clothing::getClothingByType($user->get('id'), 'jacket');
	}
	include_once SYSTEM_PATH.'/view/Post.tpl';


	public function postsSubmit()
	{
		//variables from page textbox
		$shirt = $_POST['email'];
		$jacket = $_POST['uname'];
		$pants = $_POST['pass'];
		$shoes = $_POST['pass2'];
		//all fields must be entered
		if($un == null || $pw == null || $pw2 == null || $em == null)
		{
			$_SESSION['error'] = "Enter all fields";
			header('Location: '.BASE_URL.'/signup');
		}
		elseif($pw != $pw2)
		{
			$_SESSION['error'] = "Passwords Do Not Match";
		}
		else //creates new user with given fields
		{
			$user = new AppUser();
			$user->set('email', $em);
			$user->set('username', $un);
			$user->set('pw', $pw);
			$user->set('first_name', 'First Name');
			$user->set('last_name', 'Last Name');
			$user->save();
			$_SESSION['error'] = "Account Creation Successful";
			header('Location: '.BASE_URL);

		}
	}


}
