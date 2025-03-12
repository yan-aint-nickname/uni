<!doctype html>
<html lang="ru">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title></title>
    <style>
      table,
      th,
      td {
        border: 1pt solid black;
        border-collapse: collapse;
      }

      td {
        padding: 10pt;
      }
    </style>
  </head>
  <body>
    <?php
      if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $lname = $_POST['lname'] ?? '';
        $fname = $_POST['fname'] ?? '';
        $patronimic = $_POST['patronimic'] ?? '';
        $graduation_date = $_POST['graduation_date'] ?? '';
        $tel = $_POST['tel'] ?? '';
        $email = $_POST['email'] ?? '';
        $diploma = $_POST['diploma'] ?? '';
        $points = $_POST['points'] ?? '';
        $uni = $_POST['uni'] ?? '';
        $coliving = isset($_POST['coliving']) ? 'Да' : 'Нет';

        $additional_points = [];
        if (isset($_POST['red-diploma'])) $additional_points[] = 'Красный аттестат';
        if (isset($_POST['reporting-for-duty'])) $additional_points[] = 'ГТО';
        if (isset($_POST['olimpiad'])) $additional_points[] = 'Олимпиада';

        $educational_program = "";
        if (isset($_POST['educational-program-bachelor'])) $educational_program = 'Бакалавриат';
        if (isset($_POST['educational-program-master'])) $educational_program = 'Магистратура';
        if (isset($_POST['educational-program-speciality'])) $educational_program = 'Специалитет';
        if (isset($_POST['educational-program-phd'])) $educational_program = 'Аспирантура';

        echo "<h2>Данные, которые вы отправили:</h2>";
        echo "<p><strong>Фамилия:</strong> $lname</p>";
        echo "<p><strong>Имя:</strong> $fname</p>";
        echo "<p><strong>Отчество:</strong> $patronimic</p>";
        echo "<p><strong>Дата окончания школы:</strong> $graduation_date</p>";
        echo "<p><strong>Телефон:</strong> $tel</p>";
        echo "<p><strong>E-mail:</strong> $email</p>";
        echo "<p><strong>Программа обучения:</strong> $educational_program</p>";
        echo "<p><strong>Количество баллов:</strong> $points</p>";
        echo "<p><strong>ВУЗ:</strong> $uni</p>";
        echo "<p><strong>Общежитие:</strong> $coliving</p>";
        echo "<p><strong>Дополнительные баллы:</strong> " . implode(', ', $additional_points) . "</p>";
      }
    ?>
    <h1>Поступление в ВУЗ</h1>
    <form
      action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>"
      method="POST"
    >
      <table>
        <tr>
          <td rowspan="2" align="right">
            <label class="large-label" for="lname">Фамилия:</label>
            <input type="text" id="lname" name="lname" value="Иванов" /><br />
            <label for="fname">Имя:</label>
            <input type="text" id="fname" name="fname" value="Иван" /><br />
            <label for="patronimic">Отчество:</label>
            <input
              type="text"
              id="patronimic"
              name="patronimic"
              value="Иванович"
            />
            <br />
          </td>
          <td>
            <label for="date">Дата окончания школы</label>
            <input id="date" type="date" name="graduation_date" value="" />
            <br />
            <br />

            <label for="tel">Телефон</label>
            <input
              type="tel"
              name="tel"
              placeholder="+7 XXX-XXX-XX-XX"
              pattern="+7 [0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2}"
              id="tel"
            />
            <br />

            <label for="email">E-mail</label>
            <input id="email" type="email" name="email" value="" />

            <br />
          </td>
          <td rowspan="2">
            <label for="educational-program">Программа обучения</label
            ><br /><br />

            <label for="educational-program-bachelor">Бакалавриат</label>
            <input
              id="educational-program-bachelor"
              type="radio"
              name="educational-program-bachelor"
              value=""
            /><br />
            <label for="educational-program-master">Магистратура</label>
            <input
              id="educational-program-master"
              type="radio"
              name="educational-program-master"
              value=""
            /><br />
            <label for="educational-program-speciality">Специалитет</label>
            <input
              id="educational-program-speciality"
              type="radio"
              name="educational-program-speciality"
              value=""
            /><br />
            <label for="educational-program-phd">Аспирантура</label>
            <input
              id="educational-program-phd"
              type="radio"
              name="educational-program-phd"
              value=""
            /><br />
            <br />
          </td>
        </tr>
        <tr>
          <td>
            <label for="points">Количество баллов</label><br />
            <input
              id="points"
              type="range"
              name="points"
              value="0"
              min="1"
              max="310"
              oninput="this.nextElementSibling.value = this.value"
            />
            <output>0</output>
          </td>
        </tr>
        <tr>
          <td rowspan="2">
            <label for="diploma">Загрузить аттестат</label><br />
            <input id="diploma" type="file" name="diploma" value="" />
            <br />
          </td>
          <td align="center">
            <label for="uni">ВУЗ</label><br />
            <select id="uni" type="select" name="uni" value="">
              <option>МЭИ</option>
              <option>МГТУ им. Баумана</option>
              <option>МАИ</option>
              <option>МИФИ</option>
              <option>МФТИ</option>
            </select>
            <br />
          </td>

          <td rowspan="2" align="center">
            <label for="additional-points">Дополнительные баллы:</label>
            <br /><br />

            <label for="red-diploma">Красный аттестат</label>
            <input
              id="red-diploma"
              type="checkbox"
              name="red-diploma"
              value=""
            /><br />

            <label for="reporting-for-duty">ГТО</label>
            <input
              id="reporting-for-duty"
              type="checkbox"
              name="reporting-for-duty"
              value=""
            /><br />

            <label for="olimpiad">Олимпиада</label>
            <input
              id="olimpiad"
              type="checkbox"
              name="olimpiad"
              value=""
            /><br />
          </td>
        </tr>
        <tr>
          <td align="center">
            <label for="coliving">Общежитие:</label>
            <input id="coliving" type="checkbox" name="coliving" value="<?php echo $coliving?>" />
            <br />
          </td>
        </tr>

        <tr>
          <td colspan="3" align="center">
            <input type="submit" value="Отправить" />
            <input type="reset" value="Сбросить" />
          </td>
        </tr>
      </table>
    </form>

  </body>
</html>
