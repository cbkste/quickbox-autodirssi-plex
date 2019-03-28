<!-- autodl panel -->
<script>
function addToPlex(file){
var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("txtHint").innerHTML = this.responseText;
            }
        };
        xmlhttp.open("GET", "widgets/autodl_data.php?plexfile=test", true);
        xmlhttp.send();
}

</script>
<div class="panel panel-main panel-inverse">
        <?php $file = file('/home/mod/.autodl/DownloadHistory.txt');
        $count = count($file);
         ?>

            <div class="panel-heading">
              <h4 class="panel-title"><?php echo T('AUTO DL'); ?></h4>
            </div>
            <div class="panel-body text-center" style="padding:0;">
              <div class="table-responsive ps-container">
                <table id="dataTable1" class="table table-bordered table-striped-col" style="font-size: 12px">
                  <thead>
                    <tr>
                      <th><?php echo T('NAME'); ?></th>
                      <th><?php echo T('DETAILS'); ?></th>
                      <th><?php echo T('Add to Plex'); ?></th>
                  </thead>
                  <tbody>
 <?php
for ($x = count($file); $x >= 8; $x--) {
$filePosition = $x;
echo "<tr><td>TL</td><td>";
echo explode('https:', $file[$x -1])[0];
echo "</td>";

if (!file_exists("/install/.deluge.lock")) {
        echo "<td style=\"vertical-align: middle; text-align: center\"><a href=\"?installpackage-addtoplex=true&filename=$filePosition\" data-toggle=\"modal\" data-target=\"#sysResponse\" class=\"btn btn-xs btn-success\">ADD</a></td></tr>";
} else {
        echo "<td style=\"vertical-align: middle; text-align: center\"><a class=\"btn btn-xs btn-success\">EXISTS</a></td></tr>";
}
}
?>
</tbody>
                </table>
              </div>
            </div>
          </div>
<!-- autodl panel -->