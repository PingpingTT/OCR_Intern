import re

THAI_MONTHS = {
    "ม.ค.": "01",
    "ก.พ.": "02",
    "มี.ค.": "03",
    "เม.ย.": "04",
    "พ.ค.": "05",
    "มิ.ย.": "06",
    "ก.ค.": "07",
    "ส.ค.": "08",
    "ก.ย.": "09",
    "ต.ค.": "10",
    "พ.ย.": "11",
    "ธ.ค.": "12",
}

def format_thai_date(date_str):
    match = re.search(r"(\d{1,2})\s+([^\s]+)\s+(\d{4})", date_str)
    if not match:
        return None
    
    day, month_th, year = match.groups()
    month = THAI_MONTHS.get(month_th)

    if not month:
        return None

    year = int(year)
    if year > 2400: 
        year -= 543

    return f"{int(day):02d}/{month}/{year}"


def parse_idcard(text: str):

    # -------- ID CARD --------
    id_match = re.search(r"\d{1}\s?\d{4}\s?\d{5}\s?\d{2}\s?\d{1}", text)
    id_card = re.sub(r"\s+", "", id_match.group()) if id_match else None

    # -------- FULL NAME --------
    name_match = re.search(r"(นาย|นาง|น.ส.)\s+[^\n]+", text)
    full_name = name_match.group().strip() if name_match else None

    # -------- BIRTH DATE --------
    birth_match = re.search(r"เกิดวันที่\s*-\s*([^\n]+)", text)
    if not birth_match:
        birth_match = re.search(r"(\d{1,2}\s+[^\s]+\s+\d{4})", text)

    birth_date = format_thai_date(birth_match.group(1)) if birth_match else None

    # -------- ISSUE DATE --------
    issue_match = re.search(r"วันออกบัตร[:\-]?\s*([^\n]+)", text)
    issue_date = format_thai_date(issue_match.group(1)) if issue_match else None

    # -------- EXPIRY DATE --------
    expiry_match = re.search(r"วันหมดอายุ[:\-]?\s*([^\n]+)", text)
    expiry_date = format_thai_date(expiry_match.group(1)) if expiry_match else None

    return {
        "fullName": full_name,
        "idCard": id_card,
        "birthDate": birth_date,
        "issueDate": issue_date,
        "expiryDate": expiry_date,
    }