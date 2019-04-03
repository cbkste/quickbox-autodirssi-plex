<?php

if (isset($_GET['installpackage-addtoplex'])) {
        header('Location: //');
        shell_exec("sudo /usr/local/bin/quickbox/package/install/installpackage-addtoplex");
}

?>