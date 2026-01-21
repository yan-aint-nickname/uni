// Если захочется проверить код и попробовать что-то менять можно сделать это прямов в браузере
// на официальном сайте языка https://go.dev/play/
package main

import (
	"bufio"
	"flag"
	"fmt"
	"os"
	"slices"
	"strconv"
)

// Мы не знаем на этапе компиляции сколько строк чисел будет в файле
// Для оптимизации памяти, избегаем частых реаллокаций
const rowsAmount uint = 25

// На вход принимает название файла в виде строки
// На выход отдает указатель на динамический массив(slice) и ошибку если есть
func readFromFile(path string) ([]float64, error) {
	// Открываем файл для чтения
	file, err := os.Open(path)

	// Обработка ошибки открытия файла, возвращем пустой указатель и ошибку
	if err != nil {
		return nil, fmt.Errorf("error reading a file, %w", err)
	}
	// После выхода из тела функции закрываем файл
	defer file.Close()

	// Инициализиуем сканер на файле, разделитель '\n'
	scanner := bufio.NewScanner(file)

	// Предварительно аллоцируем динамическую память(массив массивов) длиной 25
	// NOTE: если строк будет больше 25, то функция append переаллоцирует память на 50 и так далее.
	array := make([]float64, 0, rowsAmount)

	// Scan итерируется по файлу и записывает строку до '\n' в переменную scanner.token.
	// Если EOF(конец файла), то Scan вернет false и выйдет из цикла.
	for scanner.Scan() {
		// Text возвращает самый последний токен(строку), сгенерированный вызовом scanner.Scan, в виде строки.
		// Atoi(ascii to integer) - Переводит ascii-символ в число, если не получается то выдаёт ошибку
		elem, err := strconv.ParseFloat(scanner.Text(), 64)
		if err != nil {
			return nil, err
		}
		array = append(array, elem)
	}
	// Возвращаем указатель на массив и ошибку если есть
	return array, scanner.Err()
}

// На вход принимает массив чисел.
// На выход отдает i_min, i_max.
// ints = nil или len(ints) < 2 приведет к undefined behaviour.
// Вероятнее всего будет возвращено [0 0 или 1]
// NOTE: i_min, i_max - именованные параметры инициализируются на этапе компиляции и оба выставляются в 0
func getIndexesOfMinAndMax(row []float64) (i_min, i_max int) {
	// Итерируемся по массиву чисел
	// i - индекс элемента, v - элемент
	for i, v := range row {
		// Если находим элемент больше записываем новый индекс максимально элемента и наоборот
		// NOTE: находит только первое вхождение min/max элементов в массиве.
		// Если дальше в массиве будет число равное минимальному, то индекс не поменяется
		if v > row[i_max] {
			i_max = i
		} else if v < row[i_min] {
			i_min = i
		}
	}
	// Возвращаем индексы
	return i_min, i_max
}

// Произведение элементов массива(среза) между 2-мя индексами невключительно
func Product(row []float64, left, right int) (float64, error) {
	// Если индексы заходят за краевые значения то функция возвращает 0 и ошибку
	if left < 0 || right > len(row) || right - left <= 1 {
		return 0, fmt.Errorf("неверные индексы %d %d для массива %v", left, right, row)
	}
	product := float64(1.0)
	for i := left + 1; i < right; i++ {
		product *= row[i]
	}
	return product, nil
}

// Функция SortStableFunc преобразовывает массив ,
// как определено переданной вторым аргументов функцией.
// Стабильность этой сортировки гарантируется.
// Функция для сравнения func(a, b) должна возвращать отрицательное число,
// когда a < b, положительное число, когда a > b, и ноль, когда a == b или a и b несравнимы.
// NOTE: функция мутирует исходный массив!
func RearrangeToZerosFirst(array []float64) {
	slices.SortStableFunc(array, func(a, b float64) int {
		if a == 0 {
			return -1
		}
		if b == 0 {
			return 1
		}
		return 0
	})
}

// Пример использования go run main.go --input=./input.txt
func main() {
	// Объявление перменной пути до файла
	var path string

	// StringVar определяет строковый флаг с указанным именем, значением по умолчанию и описанием.
	// Первый аргумент это ссылка на строковую переменную, в которую будет записано значение флага.
	flag.StringVar(&path, "input", "input.txt", "Path to a file with input data")

	// Parse анализирует флаги командной строки из os.Args[1:].
	// Должна вызываться после определения всех флагов.
	flag.Parse()

	array, err := readFromFile(path)

	// Если при чтении файла произошла ошибка, выводим её и завершаем программу
	if err != nil {
		fmt.Println("Error:", err)
		os.Exit(1)
	}

	// Находим индексы минимального и максимального элемента в массиве
	i_min, i_max := getIndexesOfMinAndMax(array)
	// Найдем левую и правые границы для поиска произведения элементов массива
	left, right := min(i_min, i_max), max(i_min, i_max)
	// Нахождение произведения элеметов массива между левой и правой границами
	product, err := Product(array, left, right)
	if err != nil {
		fmt.Println("Error:", err)
	}
	fmt.Printf("Массив = %v\ni_min = %d\ni_max = %d\nПроизведение = %f\n", array, i_min, i_max, product)

	RearrangeToZerosFirst(array)
	fmt.Println("Преобразованный массив =", array)
}
