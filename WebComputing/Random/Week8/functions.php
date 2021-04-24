<?php
function display_month ($month, $year) {
  $first_day_of_month = mktime(0, 0, 0, $month, 1, $year);
  $first_day_of_week = date('w', $first_day_of_month);
  $days_in_month = date('t', $first_day_of_month);
  $month_name = date('F', $first_day_of_month);
  $todayMonth =  date("m");
  $todayDay =  date("d");
  $specialDates = array(array(26,01),array(07,10));
  echo "<h1>$month_name $year</h1>";
  echo '<table border="solid">';
  echo '<tr><th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th></tr>';
  echo '<tr>';
  echo "<td colspan=\"$first_day_of_week\">&nbsp;</td>";
  for ($day_of_week = $first_day_of_week, $day_of_month=1;
  $day_of_month <= $days_in_month;
  $day_of_month++, $day_of_week++) {
  if ($day_of_week == 7) { # if past end of week
  echo '</tr>'; # end the row for the current week
  $day_of_week = 0; # reset to the start of the week
  echo '<tr>'; # create a row for the next week
  }
  if($day_of_week == 6 && $first_day_of_week==0){
    echo '</tr>'; # end the row for the current week
    $day_of_week = 0; # reset to the start of the week
    echo '<tr>'; # create a row for the next week
    $first_day_of_week=1;
  }
  $test=0;
  for($x = 0; $x <= 2; $x++){
    if($specialDates[$x][0]==$day_of_month && $specialDates[$x][1]==$month){
      $test=1;
    }
  }
  if($todayDay==$day_of_month&&$todayMonth ==$month){
    $test=1;
  }
  if($test==1){
    if($month<10){
      $link = "http://www.abc.net.au/news/archive/?date=2017-0$month-$day_of_month";
    }else{
    $link = "http://www.abc.net.au/news/archive/?date=2017-$month-$day_of_month";
  }
    echo"<td id='test'> <a href='$link'>$day_of_month</td>";
  }else{
    echo"<td >$day_of_month</td>";
  }
  }
  echo '</tr>';
  echo '</table>';
  }
?>
