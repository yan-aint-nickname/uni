package main

import (
	"math"
	"os"
	"reflect"
	"slices"
	"testing"
)

// Нам необходимо указать точность для сравнения чисел с плавающей точкой
const tolerance = 1e-9

// Тест функции readFromFile
func TestReadFromFile(t *testing.T) {
	// Создаем временный файл для тестирования
	content := "5\n2\n0\n-9\n2\n"
	tmpfile, err := os.CreateTemp("", "test_input_*.txt")
	if err != nil {
		t.Fatal(err)
	}
	defer os.Remove(tmpfile.Name())

	if _, err := tmpfile.Write([]byte(content)); err != nil {
		t.Fatal(err)
	}
	if err := tmpfile.Close(); err != nil {
		t.Fatal(err)
	}

	// Тест успешного чтения
	expected := []float64{5, 2, 0, -9, 2}
	result, err := readFromFile(tmpfile.Name())
	if err != nil {
		t.Errorf("Необработанная ошибка: %v", err)
	}
	if !reflect.DeepEqual(result, expected) {
		t.Errorf("Ожидание %v, реальность %v", expected, result)
	}

	// Тест чтения несуществующего файла
	_, err = readFromFile("nonexistent_file.txt")
	if err == nil {
		t.Error("Ожидалась ошибка отсутствующего файла, получили nil")
	}
}

// Тест функции readFromFile с некорректными данными
func TestReadFromFileInvalidData(t *testing.T) {
	content := "5\nabc\n3\n"
	tmpfile, err := os.CreateTemp("", "test_invalid_*.txt")
	if err != nil {
		t.Fatal(err)
	}
	defer os.Remove(tmpfile.Name())

	if _, err := tmpfile.Write([]byte(content)); err != nil {
		t.Fatal(err)
	}
	if err := tmpfile.Close(); err != nil {
		t.Fatal(err)
	}

	_, err = readFromFile(tmpfile.Name())
	if err == nil {
		t.Error("Ожидалась ошибка неверных данных, получили nil")
	}
}

// Тест функции getIndexesOfMinAndMax
func TestGetIndexesOfMinAndMax(t *testing.T) {
	tests := []struct {
		name        string
		input       []float64
		expectedMin int
		expectedMax int
	}{
		{
			name:        "Базовый случай",
			input:       []float64{5, 2, 0, -9, 2, 4, 1, -1, 7, 1, 0, 0},
			expectedMin: 3, // -9
			expectedMax: 8, // 7
		},
		{
			name:        "Минимум в начале, максимум в конце",
			input:       []float64{-10, 0, 5, 10},
			expectedMin: 0,
			expectedMax: 3,
		},
		{
			name:        "Максимум в начале, минимум в конце",
			input:       []float64{10, 5, 0, -10},
			expectedMin: 3,
			expectedMax: 0,
		},
		{
			name:        "Все элементы одинаковые",
			input:       []float64{5, 5, 5, 5},
			expectedMin: 0,
			expectedMax: 0,
		},
		{
			name:        "Два элемента",
			input:       []float64{-5, 10},
			expectedMin: 0,
			expectedMax: 1,
		},
		{
			name:        "Отрицательные числа",
			input:       []float64{-1, -5, -3, -10, -2},
			expectedMin: 3, // -10
			expectedMax: 0, // -1
		},
		{
			name:        "Нецелые числа",
			input:       []float64{-1.9, -5, -3, -10.3, -2},
			expectedMin: 3, // -10.3
			expectedMax: 0, // -1.9
		},
		{
			// Это не ошибка, а undefined behaiviour
			name:        "Не числовые символы",
			input:       []float64{'b', 'a', 2}, // это работает, потому что 'a' это тип rune = код символа в юникоде
			expectedMin: 2,                      // 2
			expectedMax: 0,                      // 'b'
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			minIdx, maxIdx := getIndexesOfMinAndMax(tt.input)
			if minIdx != tt.expectedMin {
				t.Errorf("Индекс минимального элемента: ожидание %d, реальность %d", tt.expectedMin, minIdx)
			}
			if maxIdx != tt.expectedMax {
				t.Errorf("Индекс максимального элемента: ожидание %d, реальность %d", tt.expectedMax, maxIdx)
			}
		})
	}
}

// Тест функции Product
func TestProduct(t *testing.T) {
	tests := []struct {
		name     string
		input    []float64
		left     int
		right    int
		expected float64
		hasError bool
	}{
		{
			name:     "Нормальный случай",
			input:    []float64{1, 2, 3, 4, 5},
			left:     1,
			right:    4,
			expected: 12.0, // 3 * 4
			hasError: false,
		},
		{
			name:     "Один элемент между границами",
			input:    []float64{1, 2, 3, 4},
			left:     0,
			right:    2,
			expected: 2.0,
			hasError: false,
		},
		{
			name:     "Произведение с нулем",
			input:    []float64{5, 2, 0, -9, 2},
			left:     0,
			right:    3,
			expected: 0.0, // 2 * 0
			hasError: false,
		},
		{
			name:     "Произведение отрицательных чисел",
			input:    []float64{1, -2, -3, 4},
			left:     0,
			right:    3,
			expected: 6.0, // -2 * -3
			hasError: false,
		},
		{
			name:     "Индексы рядом (нет элементов между)",
			input:    []float64{1, 2, 3, 4},
			left:     1,
			right:    2,
			expected: 0.0,
			hasError: true,
		},
		{
			name:     "Левый индекс отрицательный",
			input:    []float64{1, 2, 3, 4},
			left:     -1,
			right:    3,
			expected: 0.0,
			hasError: true,
		},
		{
			name:     "Правый индекс выходит за границы",
			input:    []float64{1, 2, 3, 4},
			left:     1,
			right:    10,
			expected: 0.0,
			hasError: true,
		},
		{
			name:     "Левый >= правого",
			input:    []float64{1, 2, 3, 4},
			left:     3,
			right:    2,
			expected: 0.0,
			hasError: true,
		},
		{
			name:     "Нецелые числа",
			input:    []float64{1.05, 2.03, 3.01, 4.05},
			left:     0,
			right:    3,
			expected: 2.03 * 3.01,
			hasError: false,
		},
		{
			name:     "ASCII-символы в массиве",
			input:    []float64{1, 2, 'a', 'c'},
			left:     0,
			right:    3,
			expected: 194.0,
			hasError: false,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result, err := Product(tt.input, tt.left, tt.right)

			if tt.hasError {
				if err == nil {
					t.Error("Ожидается ошибка, получили ничего")
				}
			} else {
				if err != nil {
					t.Errorf("Необработанная ошибка: %v", err)
				}
				if math.Abs(result-tt.expected) > tolerance {
					t.Errorf("Ожидание %f, реальность %f", tt.expected, result)
				}
			}
		})
	}
}

// Тест сортировки с нулями
func TestSortWithZeros(t *testing.T) {
	tests := []struct {
		name     string
		input    []float64
		expected []float64
	}{
		{
			name:     "Массив с нулями в середине",
			input:    []float64{5, 2, 0, -9, 2, 4, 1, -1, 7, 1, 0, 0},
			expected: []float64{0, 0, 0, 5, 2, -9, 2, 4, 1, -1, 7, 1},
		},
		{
			name:     "Массив без нулей",
			input:    []float64{5, 2, -9, 2, 4},
			expected: []float64{5, 2, -9, 2, 4},
		},
		{
			name:     "Массив только из нулей",
			input:    []float64{0, 0, 0, 0},
			expected: []float64{0, 0, 0, 0},
		},
		{
			name:     "Нули в начале",
			input:    []float64{0, 0, 1, 2, 3},
			expected: []float64{0, 0, 1, 2, 3},
		},
		{
			name:     "Нули в конце",
			input:    []float64{1, 2, 3, 0, 0},
			expected: []float64{0, 0, 1, 2, 3},
		},
		{
			name:     "Один ноль",
			input:    []float64{5, 0, 3, 1},
			expected: []float64{0, 5, 3, 1},
		},
		{
			name:     "Один ноль и нецелые числа",
			input:    []float64{5, 0, 3, 1, 1.0, 0.1},
			expected: []float64{0, 5, 3, 1, 1.0, 0.1},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// Копируем массив чтобы не мутировать оригинал
			input := make([]float64, len(tt.input))
			copy(input, tt.input)

			// Применяем ту же логику сортировки что и в main
			RearrangeToZerosFirst(input)

			if slices.Compare(input, tt.expected) != 0 {
				t.Errorf("Expected %v, got %v", tt.expected, input)
			}
		})
	}
}
