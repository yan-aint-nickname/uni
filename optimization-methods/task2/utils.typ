#let func_3(x) = {
  calc.pow(x, 2) + 2 * x - 4
}


#let bisection_method(l, r, f, epsilon: 0.1) = {
  let iteration = 1
  while (r - l) / 2 >= epsilon {
    let x = (l + r) / 2
    let x_1 = x - epsilon
    let x_2 = x + epsilon

    if f(x_1) < f(x_2) {
      r = x
    } else {
      l = x
    }
    iteration += 1
  }
  ((l + r) / 2, f((l + r) / 2), iteration)
}

#let calc_median(a, b) = {
  (a + b) / 2
}

#let calc_lambda(a, b) = {
  a + 0.382 * (b - a)
}

#let calc_mu(a, b) = {
  a + 0.618 * (b - a)
}

#let golden_ratio(a, b, f, epsilon: 0.1) = {
  let iterations = 1
  while calc.abs(b - a) > epsilon {
    let lambda = calc_lambda(a, b)
    let mu = calc_mu(a, b)
    if f(lambda) > f(mu) {
      a = lambda
    } else {
      b = mu
    }
    iterations += 1
  }
  let x_min = (b + a) / 2
  (x_min, f(x_min), iterations)
}

#let fib(n) = {
  let i = 0
  let next = 1
  let prev = 0
  while i < n {
    let tmp = next
    next += prev
    prev = tmp
    i += 1
  }
  prev
}

// fib testing
#{
  let fib_numbers = (0, 1, 1, 2, 3, 5, 8, 13, 21, 34)
  for (i, v) in fib_numbers.enumerate() {
    assert.eq(fib(i), v)
  }
}
