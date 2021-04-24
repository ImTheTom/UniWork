<form action="partA.php" method="POST">
  Text<input type="text" name="text"><br>
  email <input type="text" id="email" name="email" value="<?php
  if(isset($_POST['email'])) {
    echo htmlspecialchars($_POST['email']);
  }
  ?>"/><br>
  Hidden<input type="hidden" name="hidden"><br>
  Password<input type="password" name="password" value="<?php
  if(isset($_POST['password'])) {
    echo htmlspecialchars($_POST['password']);
  }
  ?>"/><br>
  CheckBox<input type="checkbox" name="checkbox"><br>
  Reset<input type="reset" name="reset"><br>
  Submit<input type="submit" name="submit"><br>
  TextArea<input type="textarea" name="textarea"><br>
  select<select name="select">
    <option value="select1">Select1</option>
    <option value="select2">Select2</option>
    </select>
</form>
