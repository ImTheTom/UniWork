<?php
function select($name, $values) {
echo "<select id=\"$name\" name=\"$name\">";
foreach ($values as $value => $display) {
$selected = ($value==posted_value($name))?'selected="selected"':'';
echo "<option $selected value=\"$value\">$display</option>";
}
echo '</select>';
}
?>
