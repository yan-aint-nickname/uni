# Спрашиваем пользователя путь до файла с пользователями, которых хотим добавить
$scvPath = Read-Host "Введите путь до файла с пользователями"

# Задание переменной класса пользователя $strClass
$strClass = "User"

# Задание места создания пользователя через переменную $objADSI
$objADSI = [ADSI]"LDAP://ou=ITSecurity,ou=IT,DC=MIC,DC=local"

# Импорт пользователей из файла
$users = Import-Csv -Path $scvPath

foreach ($user in $users) {
	try {
		# Создание пользователя
		$objUser = $objADSI.create($strClass, "CN=" + $user.CN)
		# Фиксирование результатов (commit)
		$objUser.SetInfo()
		Write-Host "Создан пользователь: $($user.CN)" -ForegroundColor Green
	}
	catch {
		# Если произошла ошибка создания пользователя, выводим сообщение об этом
		Write-Host "Ошибка создания пользователя: $($user.CN): $_" -ForegroundColor Red
	}
}

Write-Host "`nСоздание пользователей завершено" -ForegroundColor Yellow
