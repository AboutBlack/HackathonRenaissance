<?php
namespace Home\Controller;
use Think\Controller;
class IndexController extends Controller {
    
    public function index(){
    	echo "hack2016";
    }

    public function login(){
    	$user = M("User");
    	$data['user'] = $_POST['user'];
    	$data['pass'] = $_POST['pass'];
    	$res = $user->where($data)->find();
    	if ($res) {
    		echo json_encode(array('status'=>'0','data'=>$res));
    	} else {
    		echo json_encode(array('status'=>'-1','msg'=>'login error'));
    	}
    }


    public function livelist()
    {
		$list = M("live_list");
		$mail = M("mail");
		$userModel = M("User");
		$rst  = $list->where($data)->order('time desc')->select();
		for ($i=0; $i < count($rst); $i++) {
			$tmp['user'] = $rst[$i]['user'];
			$tmp['room'] = $rst[$i]['room'];
			$img = json_decode($rst[$i]['live_img']);
			$user_img['user'] = $rst[$i]['user'];
			$user = $userModel->where($user_img)->find();
			$rst[$i]['user_img'] = $user['img'];
			$rst[$i]['live_img'] = $img[0];
			$rst[$i]['mail'] = $mail->where($tmp)->select();
		}
		header('Content-Type: application/json');
		echo json_encode($rst); 
    }

    public function livestatus()
    {
    	$list = M("live_list");
    	$tmp['room'] = '999';
    	// $data['user']   = $_POST['user'];
    	$data['status'] = $_POST['status'];
    	if ($data['status']) {
    		$rst  = $list->where($tmp)->data($data)->save();
			if ($rst) {
				header('Content-Type: application/json');
	    		echo json_encode(array('status'=>'0'));
	    	} else {
	    		header('Content-Type: application/json');
	    		echo json_encode(array('status'=>'-1'));
	    	}
    	}
    }

    public function fabu()
    {
    	$data['user'] = $_POST['user'];
    	$data['live_img']  	= json_encode($_POST['img']);
    	$data['live_time'] 	= $_POST['time'];
    	$data['live_title'] = $_POST['title'];
    	$list = M("live_list");
    	if (empty($data['user'])) {
    		echo json_encode(array('status'=>'-2'));
    		return;
    	}
    	$rst = $list->data($data)->add();
    	if ($rst) {
    		header('Content-Type: application/json');
    		echo json_encode(array('status'=>'0'));
    	} else {
    		header('Content-Type: application/json');
    		echo json_encode(array('status'=>'-1'));
    	}
    }

    public function pushMail()
    {
    	$data['user'] = $_POST['user'];
    	$data['title'] = $_POST['title'];
    	$data['price'] = $_POST['price'];
    }

    /**
     * 上传图片
     * @date   2016-06-25
     * @return json     json (status,data)
     */
    public function fileUpload()
    {
		$qnConfig = $this->getQiNiuConfig();
		$config = $this->getUploadConfig();
    	$upload = new \Think\Upload($config,'qiniu',$qnConfig);// 实例化上传类
	    $info   =   $upload->upload();
	    if(!$info) {
	    	header('Content-Type: application/json');
	        echo json_encode(array('status'=>'-1','data'=>array()));
	        return;
	    }else{// 上传成功
    		for ($i=0; $i < count($info); $i++) { 
    			$tmp[$i] = $info[$i]['url'];
    		}
    		header('Content-Type: application/json');
        	echo json_encode(array('status'=>'0','data'=>$tmp));
	    }
    }

    /**
     * get qi niu config
     * @date   2016-06-25
     * @return array     qiniu config
     */
    private function getQiNiuConfig()
    {
    	$config = array(
	        'secretKey'      => '',
	        'accessKey'      => '',
	        'domain'         => '', 
	        'bucket'         => '', //空间名称
	        'timeout'        => 300, //超时时间
	    );
	    return $config;
    }

    /**
     * get img config
     * @date   2016-06-25
     * @return array     imgage config
     */
   private function getUploadConfig()
   {
	   	$config = array(
		    'maxSize'    =>    3145728,
		    'rootPath'   =>   './Uploads/',
		    'savePath'   =>    '',
		    'saveName'   =>    array('uniqid',''),
		    'exts'       =>    array('jpg', 'gif', 'png', 'jpeg'),
		    'autoSub'    =>    true,
		    'subName'    =>    array('date','Ymd'),
		);
		return $config;
   }







}