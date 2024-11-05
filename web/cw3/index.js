const form = document.querySelector("form");

// Check if no form element provided
if (form == null) {
  console.error("No form provided!");
}

const errorMessages = {
  email: "Пожалуйста, введите действительный адрес электронной почты",
  tel: "Пожалуйста, введите действительный номер телефона в формате: +7 XXX-XXX-XX-XX",
  graduationDate:
    "Пожалуйста, введите действительную дату в формате YYYY-MM-DD",
  lname: "Фамилия должна содержать только буквы",
  fname: "Имя должно содержать только буквы",
  patronimic: "Отчество должно содержать только буквы",
  points: "Количество баллов должно быть от 1 до 310",
};

function isAlphabetic(value) {
  const cyrillicPattern = new RegExp("^[\\u0400-\\u04FF]+$");
  const latinPattern = new RegExp("^[a-zA-Z]+$");
  return cyrillicPattern.test(value) || latinPattern.test(value);
}

const validators = {
  /*
   * For email regex info: https://stackoverflow.com/a/46181/17096849
   * */
  email: (value) => {
    if (!value) {
      return { isValid: false, msg: errorMessages.email };
    }

    const emailRegExp = new RegExp(
      "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
    );

    return { isValid: emailRegExp.test(value), msg: errorMessages.email };
  },
  tel: (value) => {
    const phoneRegExp = new RegExp(
      "^\\+7\\s[0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2}$",
    );
    return { isValid: phoneRegExp.test(value), msg: errorMessages.tel };
  },
  graduationDate: (value) => {
    const dateRegExp = new RegExp("^\\d{4}-\\d{2}-\\d{2}$");
    if (!value || !dateRegExp.test(value)) {
      return { isValid: false, msg: errorMessages.graduationDate };
    }
    const d = new Date(`${value}T00:00:00.000Z`);
    return { isValid: !isNaN(d.getTime()), msg: errorMessages.graduationDate };
  },
  lname: (value) => {
    return { isValid: isAlphabetic(value), msg: errorMessages.lname };
  },
  fname: (value) => {
    return { isValid: isAlphabetic(value), msg: errorMessages.fname };
  },
  patronimic: (value) => {
    if (value.length != 0) {
      return isAlphabetic(value);
    }
    return { isValid: true, msg: errorMessages.patronimic };
  },
  points: (value) => {
    return { isValid: value <= 310 && value > 0, msg: errorMessages.points };
  },
};

/*
 * @param {HTMLFormElement} params
 * @returns {Map<string, boolean>}
 * */
function isValidForm(params) {
  const formData = new FormData(params);
  const formValues = Object.fromEntries(formData);

  const errors = {};
  // Ошибка предыдущих ошибок
  clearErrors(form);

  for (const [key, value] of Object.entries(formValues)) {
    if (!validators[key]) continue;

    const validation = validators[key](value);
    if (!validation.isValid) {
      errors[key] = validation.msg;
    }
  }

  if (Object.keys(errors).length > 0) {
    showErrors(form, errors);
    return false;
  }

  return true;
}

/*
 * @param {SubmitEvent} event
 * */
function handleSubmitEvent(event) {
  const valid = isValidForm(event.target);
  if (!valid) {
    event.preventDefault();
  }
}

function showErrors(form, errors) {
  const existingErrorList = document.querySelector(".error-list");
  if (existingErrorList) {
    existingErrorList.remove();
  }
  const errorList = document.createElement("div");
  errorList.className = "error-list";

  const ul = document.createElement("ul");
  Object.entries(errors).forEach(([fieldName, message]) => {
    const li = document.createElement("li");
    console.log(fieldName, message);
    const input = form.querySelector(`[name="${fieldName}"]`);
    const labelText = input.previousElementSibling?.textContent || fieldName;
    li.textContent = `${labelText}: ${message}`;
    ul.appendChild(li);

    input.classList.add("error");
  });

  errorList.appendChild(ul);

  form.insertAdjacentElement("beforebegin", errorList);
  requestAnimationFrame(() => {
    errorList.classList.add("show");
  });
}

function clearErrors(form) {
  const errorList = document.querySelector(".error-list");
  if (errorList) {
    errorList.remove();
  }

  form.querySelectorAll(".error").forEach((input) => {
    input.classList.remove("error");
  });
}

function clearErrorList(event) {
  const formData = new FormData(event.target);
  const formValues = Object.fromEntries(formData);
  clearErrors(formValues);
}

form.addEventListener("submit", handleSubmitEvent);
form.addEventListener("reset", clearErrorList);
