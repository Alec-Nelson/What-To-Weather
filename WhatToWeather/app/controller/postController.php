<?php

include_once '../global.php';

// get the identifier for the page we want to load
$action = $_GET['action'];

// instantiate a PostController and route it
$pc = new PostController();
$pc->route($action);

class PostController {

	// route us to the appropriate class method for this action
	public function route($action) {
		switch($action) {
			case 'posts':
				$this->posts();
				break;

			case 'post':
				$postID = $_GET['postID'];
				$this->post($postID);
				break;

			case 'comment':
				$postID = $_GET['postID'];
				$user = $_POST['yourName'];
				$comment = $_POST['yourComment'];
				$this->comment($postID, $user, $comment);
				break;
		}

	}

    public function posts() {
			// get all posts from this blog
			$posts = BlogPost::getAllPosts();
			include_once SYSTEM_PATH.'/view/posts.tpl';
    }

    public function post($pid) {
			// get data for this post
    	$postID = $pid;
			$post = BlogPost::loadById($postID);

			// get data for author of post
			$author = AppUser::loadById($post->get('author_id'));

		include_once SYSTEM_PATH.'/view/post.tpl';
    }

    public function comment($pid, $user, $comment) {
    	// save comment to database
    	echo "You submitted the following comment:<br>";
    	echo "Username: ".$user."<br>";
    	echo "Comment: ".$comment;

    }

}
