<?php
function input_field($errors, $name, $label) {
echo '<div class="required_field">';
label($name, $label);
$value = posted_value($name);
echo "<input type=\"text\" id=\"$name\" name=\"$name\" value=\"$value\"/>";
errorLabel($errors, $name);
echo '</div>';
}

function posted_value($name){
if(isset($_POST[$value])) echo htmlspecialchars($_POST[$value]);
}

function label($name, $label){
echo "<label for=\"$name\">$label :</label>";
}

function errorLabel($errors, $name){
$id=$name+"error";
echo "<span id=\"$id\" class=\"error\">";
if (isset($errors[$name])) echo $errors[$name];
echo "</span>";
}

function select($name, $values) {
    echo "<select id=\"$name\" name=\"$name\">";
    foreach ($values as $value => $display) {
        $selected = ($value==posted_value($name))?'selected="selected"':'';
        echo "<option $selected value=\"$value\">$display</option>";
    }
    echo '</select>';
}
?>
