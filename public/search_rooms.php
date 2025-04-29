<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <title>Search Available Rooms</title>
  <link rel="stylesheet" href="css/style.css">
</head>

<body>
  <h1>Search Available Rooms</h1>

  <!-- === FORM: Room Search === -->
  <form action="search_rooms.php" method="post">
    <label for="check_in">Check-in Date:</label>
    <input type="date" id="check_in" name="check_in" required><br>

    <label for="check_out">Check-out Date:</label>
    <input type="date" id="check_out" name="check_out" required><br>

    <label for="room_type">Room Type:</label>
    <select id="room_type" name="room_type" required>
      <?php
      // Step 1: Connect to the database by including your connection file
      include "../includes/db_connection.php";

      // Step 2: Write a query to select the room_type_id and type_name columns from the Room_Types table
      $sql = "SELECT room_type_id, type_name FROM Room_Types";

      // Step 3: Run the query and store the result
      $result = mysqli_query($conn, $sql);

      // Step 4: Use a while loop to go through each result row
      // Hint: Each row will have room_type_id and type_name — use them to make <option> tags inside the dropdown

      while ($row = mysqli_fetch_assoc($result)) {
        echo "<option value='{$row['room_type_id']}'>{$row['type_name']}</option>";
      }
      ?>
    </select><br>

    <input type="submit" value="Search">
  </form>

  <?php
  // Step 6: Check if the form was submitted using the POST method
  if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    // Step 7: Get the input values from the form:
    // - Read check-in date
    // - Read check-out date
    // - Read selected room type
    $check_in = $_POST['check_in'];
    $check_out = $_POST['check_out'];
    $room_type = $_POST['room_type'];

    // Step 8: Make sure the check-out date is AFTER the check-in date
    // Hint: Just compare the two strings — they are in YYYY-MM-DD format
    if ($check_out < $check_in) {
      echo "Check-out date must be later than check-in date";
    } else {

      // Step 9: Build a SQL query to find rooms that match the selected room type
      // and are NOT already booked during the selected dates.
      //
      // Hint: You’ll need these conditions:
      // - The room_type_id must match
      // - The room must NOT have a booking that overlaps
      //
      // EXTRA HINT: To avoid rooms with overlapping bookings, use:
      // “NOT EXISTS (SELECT * FROM Bookings WHERE [date overlap logic])”

      $sql = "SELECT r.*
            FROM Rooms r
            JOIN Room_Types rt ON rt.room_type_id = r.room_type_id
            WHERE r.room_type_id = '$room_type'
              AND r.status = 'available'
              AND NOT EXISTS (
                  SELECT 1 FROM Bookings b
                  WHERE b.room_id = r.room_id
                    AND (
                        b.check_in_date < '$check_out'
                        AND b.check_out_date > '$check_in'
                    )
              )
            ";
      // Step 10: Run the SQL query to get matching rooms
      $result = mysqli_query($conn, $sql);
      // Step 11: Count how many rooms were returned
      // Hint: Use mysqli_num_rows() to check if the result has 1 or more rows

      if (mysqli_num_rows($result) > 0) {

        // Step 12: Use a while loop to go through each available room
        echo "<h2>Available rooms:</h2>";
        while ($row = mysqli_fetch_assoc($result)) {

          // Step 12.1: For each room, show basic info like:
          // - Room number
          // - Floor
          echo "Room Number: {$row['room_number']}  | Floor: {$row['floor_id']} <br/>";
          // Step 12.2: Add a link next to it:
          // "Book This Room"
          // → the link should go to book_room.php and pass room_id, check-in and check-out dates using URL
          echo "<a href='book_room.php?room_id={$row['room_id']}'&check_in='{$check_in}&check_out='{$check_out}'>Book This Room</a>:";
        }
      } else {

        // Step 13: If no rooms are found, show a message:
        // "Sorry, no rooms are available for your selection"
        echo "Sorry, no rooms are available for your selection";
      }
    }
  }
  ?>
</body>

</html>