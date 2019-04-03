<?php

if (isset($_GET['installpackage-addtoplex'])) {
        $q = $_REQUEST["plexfile"];
        header('Location: //');
        shell_exec("sudo /usr/local/bin/quickbox/package/install/installpackage-addtoplex $q");
}

?>