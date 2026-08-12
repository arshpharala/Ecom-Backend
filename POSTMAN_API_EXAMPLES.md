# API Multi-Language Postman Usage Guide

All standard API endpoints now run on clean URLs (e.g. `/api/v1/products/019f5fd9-c791-710c-ac4e-d6c0f7b4cc20`).

Language selection is controlled dynamically via headers or query parameters and checked against your `locales` database table (`en`, `ar`, `en-ae`, etc.), defaulting to **English (`en`)**.

---

## 1️⃣ Method 1: Request Headers (Recommended)

Set the language header in Postman's **Headers** tab:

| Key | Value | Description |
| :--- | :--- | :--- |
| `X-Locale` | `ar` | (Recommended) Custom application language header |
| `Accept-Language` | `ar` | Standard HTTP header (e.g., `ar`, `en`, `ar-AE`) |
| `lang` | `ar` | Alternative direct language header |

### Example Request in Postman:
* **URL:** `GET http://localhost:8000/api/v1/products`
* **URL:** `GET http://localhost:8000/api/v1/products/019f5fd9-c791-710c-ac4e-d6c0f7b4cc20`
* **Headers:**
  - `X-Locale`: `ar`

---

## 2️⃣ Method 2: Query Parameter (`?lang=` or `?locale=`)

Pass language via query parameter in Postman:

* **Products List:** `GET http://localhost:8000/api/v1/products?lang=ar`
* **Product Details:** `GET http://localhost:8000/api/v1/products/019f5fd9-c791-710c-ac4e-d6c0f7b4cc20?lang=ar`
* **App Init / Categories:** `GET http://localhost:8000/api/v1/init?lang=ar`
* **Banners:** `GET http://localhost:8000/api/v1/banners?locale=ar`

---

## 3️⃣ Default Behavior (No Header or Query Parameter)

If no header or query parameter is provided:
* **URL:** `GET http://localhost:8000/api/v1/products/019f5fd9-c791-710c-ac4e-d6c0f7b4cc20`
* **Behavior:** Automatically resolves to default English (`en` / `en-ae`).
