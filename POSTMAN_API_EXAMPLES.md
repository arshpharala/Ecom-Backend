# API Multi-Language Postman Usage Guide

You can pass the language (`lang`) to any API URL using any of the **3 flexible methods** below. All methods check against your `locales` database table (`en`, `ar`, `en-ae`, etc.), with **English** as the default fallback if omitted.

---

## 1️⃣ Method 1: Path Parameter (URL Segment) — *Recommended for Clean URLs*

Add the 2-letter or 5-letter language code directly in the URL path right after `/v1/`.

| Endpoint Description | Method | Postman Request URL |
| :--- | :--- | :--- |
| **Get Products (Arabic)** | `GET` | `http://localhost:8000/api/v1/ar/products` |
| **Get Products (English)** | `GET` | `http://localhost:8000/api/v1/en/products` |
| **Get Product Details (Arabic)** | `GET` | `http://localhost:8000/api/v1/ar/products/{variant_id}` |
| **Get Banners (Arabic)** | `GET` | `http://localhost:8000/api/v1/ar/banners` |
| **Get App Init / Categories (Arabic)**| `GET` | `http://localhost:8000/api/v1/ar/init` |
| **Get CMS Page (Arabic)** | `GET` | `http://localhost:8000/api/v1/ar/pages/about-us` |

---

## 2️⃣ Method 2: Query Parameter (`?lang=` or `?locale=`)

Pass `lang` or `locale` as a query parameter in Postman Params tab.

| Endpoint Description | Method | Postman Request URL |
| :--- | :--- | :--- |
| **Get Products** | `GET` | `http://localhost:8000/api/v1/products?lang=ar` |
| **Get Product Details** | `GET` | `http://localhost:8000/api/v1/products/{variant_id}?lang=ar` |
| **Get Banners** | `GET` | `http://localhost:8000/api/v1/banners?locale=ar` |
| **Get App Init** | `GET` | `http://localhost:8000/api/v1/init?lang=ar` |

---

## 3️⃣ Method 3: HTTP Request Headers

Keep standard URLs and pass the language code in the Postman **Headers** tab.

**Request URL:** `http://localhost:8000/api/v1/products`

**Headers Tab in Postman:**
| Key | Value | Description |
| :--- | :--- | :--- |
| `Accept-Language` | `ar` | Standard HTTP browser header (e.g. `ar` or `ar-AE`) |
| `X-Locale` | `ar` | Custom application header |
| `lang` | `ar` | Direct language header |

---

## 4️⃣ Default Behavior (No Language Specified)

If no language parameter or header is provided:
- **Request:** `http://localhost:8000/api/v1/products`
- **Behavior:** Automatically resolves to default English (`en` / `en-ae`).

---

## 💡 Quick Summary Table for Postman

```http
### 1. Path segment
GET /api/v1/ar/products
GET /api/v1/en/products

### 2. Query string
GET /api/v1/products?lang=ar
GET /api/v1/products?locale=ar

### 3. Header
GET /api/v1/products
Headers:
  Accept-Language: ar
```
