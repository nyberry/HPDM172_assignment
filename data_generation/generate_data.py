"""
Data generator for the HPDM172 assignment.

This script creates synthetic data representing hospitals, doctors, patients,
medications, diseases, appointments, prescriptions, and lab test results.
All outputs are written as CSV files into the ./data/ directory.

Run directly:

    python generate_data.py

Outputs:
    hospitals.csv
    doctors.csv
    patients.csv
    medications.csv
    diseases.csv
    disease_treatments.csv
    disease_specialists.csv
    lab_tests.csv
    prescriptions.csv
    appointments.csv
    lab_results.csv
"""

import csv
import random
from datetime import datetime, timedelta

random.seed(42)  # ensure reproducibile results


# ---------------------------------------------------------------------------
# Constants: number of records to generate
# ---------------------------------------------------------------------------

N_HOSPITALS = 40
N_DOCTORS = 100
N_PATIENTS = 600
N_MEDICATIONS = 40
N_DISEASES = 12
N_LAB_TESTS = 15
N_PRESCRIPTIONS = 500
N_APPOINTMENTS = 1000
N_LAB_RESULTS = 800

TODAY = datetime(2025, 12, 1)  # fixed "today" so it’s reproducible


# ---------------------------------------------------------------------------
# Lists of names for each entity type
# ---------------------------------------------------------------------------


FIRST_NAMES = [
    "Oliver",
    "George",
    "Harry",
    "Jack",
    "Jacob",
    "Noah",
    "Charlie",
    "Muhammad",
    "Thomas",
    "Oscar",
    "William",
    "James",
    "Leo",
    "Alfie",
    "Henry",
    "Joshua",
    "Freddie",
    "Archie",
    "Ethan",
    "Isaac",
    "Alexander",
    "Joseph",
    "Edward",
    "Samuel",
    "Max",
    "Daniel",
    "Arthur",
    "Lucas",
    "Mohammed",
    "Logan",
    "Theo",
    "Harrison",
    "Benjamin",
    "Mason",
    "Finley",
    "Arlo",
    "Sebastian",
    "Adam",
    "Teddy",
    "Dylan",
    "Zachary",
    "Reuben",
    "Hugo",
    "Luca",
    "Louis",
    "Jaxon",
    "Roman",
    "Toby",
    "Rory",
    "Amelia",
    "Olivia",
    "Isla",
    "Emily",
    "Ava",
    "Grace",
    "Sophia",
    "Mia",
    "Poppy",
    "Ella",
    "Lily",
    "Evie",
    "Jessica",
    "Isabella",
    "Charlotte",
    "Sophie",
    "Daisy",
    "Alice",
    "Phoebe",
    "Freya",
    "Florence",
    "Sienna",
    "Willow",
    "Elsie",
    "Matilda",
    "Ruby",
    "Harper",
    "Emma",
    "Chloe",
    "Rosie",
    "Molly",
    "Maya",
    "Millie",
    "Eva",
    "Erin",
    "Aria",
    "Lottie",
    "Zara",
    "Thea",
    "Annabelle",
    "Heidi",
    "Eleanor",
    "Luna",
    "Beatrice",
    "Hannah",
    "Imogen",
    "Elizabeth",
    "Ivy",
    "Georgia",
]

LAST_NAMES = [
    "Smith",
    "Jones",
    "Williams",
    "Brown",
    "Taylor",
    "Davies",
    "Wilson",
    "Evans",
    "Thomas",
    "Johnson",
    "Roberts",
    "Robinson",
    "Thompson",
    "Wright",
    "Walker",
    "White",
    "Edwards",
    "Hughes",
    "Green",
    "Hall",
    "Lewis",
    "Harris",
    "Clarke",
    "Patel",
    "Jackson",
    "Wood",
    "Turner",
    "Martin",
    "Cooper",
    "Hill",
    "Ward",
    "Morris",
    "Moore",
    "Clark",
    "Lee",
    "King",
    "Baker",
    "Harrison",
    "Morgan",
    "Allen",
    "James",
    "Scott",
    "Phillips",
    "Watson",
    "Davis",
    "Parker",
    "Price",
    "Bennett",
    "Young",
    "Griffiths",
    "Mitchell",
    "Kelly",
    "Cook",
    "Carter",
    "Shaw",
    "Collins",
    "Bell",
    "Barker",
    "Murphy",
    "Miller",
    "Cox",
    "Richards",
    "Khan",
    "Marshall",
    "Anderson",
    "Simpson",
    "Ellis",
    "Adams",
    "Singh",
    "Begum",
    "Wilkinson",
    "Foster",
    "Chapman",
    "Powell",
    "Gray",
    "Rose",
    "Stevens",
    "Fisher",
    "Barnes",
    "Matthews",
    "Thomson",
    "Lawrence",
    "Webb",
    "Reynolds",
    "Lloyd",
    "Graham",
    "Holt",
    "Jenkins",
    "Farrell",
    "Pearson",
    "Fox",
    "Gibson",
    "Berry",
    "Owen",
    "Spencer",
    "Burton",
    "Holmes",
    "Moss",
    "Black",
]

STREET_NAMES = [
    "High Street",
    "Station Road",
    "Main Road",
    "Church Road",
    "Church Street",
    "Park Road",
    "London Road",
    "Victoria Road",
    "Green Lane",
    "Manor Road",
    "Park Avenue",
    "Queen Street",
    "Kings Road",
    "Kingsway",
    "New Road",
    "West Street",
    "North Street",
    "South Street",
    "East Street",
    "The Avenue",
    "The Crescent",
    "The Drive",
    "The Green",
    "The Grove",
    "The Close",
    "The Street",
    "Mill Road",
    "Mill Lane",
    "Bridge Street",
    "School Lane",
    "Chapel Street",
    "Elm Road",
    "Oak Road",
    "Cedar Road",
    "Birch Road",
    "Maple Avenue",
    "Springfield Road",
    "Clarence Road",
    "Richmond Road",
    "Albert Road",
    "George Street",
    "York Road",
    "Grosvenor Road",
    "Broadway",
    "Broad Street",
    "Lower Road",
    "Upper Street",
    "Broad Lane",
    "Windmill Lane",
    "Meadow Lane",
    "Field Road",
    "Hill Road",
    "Hill Street",
    "Church Lane",
    "Park Lane",
    "College Road",
    "Manor Lane",
    "Farm Lane",
    "Lime Grove",
    "Beech Road",
    "Poplar Avenue",
    "Willow Road",
    "Holly Road",
    "Cavendish Road",
    "Fairfield Road",
    "North Road",
    "South Road",
    "East Road",
    "West Road",
    "St James Road",
    "St Johns Road",
    "St Marys Road",
    "St Marks Road",
    "St Peters Road",
    "Prospect Road",
    "Queensway",
    "Valley Road",
    "Riverside",
    "River Street",
    "Market Street",
    "Market Road",
    "Harbour Road",
    "Sea View Road",
    "Beacon Hill",
    "Long Lane",
    "Short Street",
    "Old Road",
    "New Street",
    "Orchard Road",
    "Hawthorn Road",
    "Sycamore Road",
    "Firs Avenue",
    "Ash Road",
    "Acacia Avenue",
    "Castle Street",
    "Court Road",
    "Garden Lane",
    "Summerhill Road",
]


TOWNS = [
    "Exeter",
    "Topsham",
    "Exminster",
    "Starcross",
    "Dawlish",
    "Teignmouth",
    "Bishopsteignton",
    "Newton Abbot",
    "Kingsteignton",
    "Chudleigh",
    "Christow",
    "Cheriton Bishop",
    "Cranbrook",
    "Broadclyst",
    "Pinhoe",
    "Heavitree",
    "Alphington",
    "Ide",
    "Kennford",
    "Kenton",
    "Mamhead",
    "Shillingford St George",
    "Shillingford Abbot",
    "Tedburn St Mary",
    "Crediton",
    "Copplestone",
    "Morchard Bishop",
    "Bow",
    "North Tawton",
    "Thorverton",
    "Bickleigh",
    "Silverton",
    "Killerton",
    "Cullompton",
    "Kentisbeare",
    "Willand",
    "Uffculme",
    "Tiverton",
    "Halberton",
    "Sampford Peverell",
    "Bradninch",
    "Feniton",
    "Whimple",
    "Rockbeare",
    "Honiton",
    "Ottery St Mary",
    "West Hill",
    "Tipton St John",
    "Sidmouth",
    "Sidbury",
    "Seaton",
    "Colyton",
    "Beer",
    "Axminster",
    "Uplyme",
    "Lyme Regis",
    "Uffculme",
    "Burlescombe",
    "Stoke Canon",
    "Rewe",
    "Brampford Speke",
    "Poltimore",
    "Huxham",
    "Aylesbeare",
    "Clyst St George",
    "Clyst St Mary",
    "Clyst Honiton",
    "Exton",
    "Lympstone",
    "Woodbury",
    "Woodbury Salterton",
    "Budleigh Salterton",
    "East Budleigh",
    "Otterton",
    "Newton Poppleford",
    "Harberton",
    "Honiton",
    "Awliscombe",
    "Yarcombe",
    "Dunkeswell",
    "Broadhembury",
    "Talaton",
    "Payhembury",
    "Kilmington",
    "Dalwood",
    "Stockland",
    "Upottery",
    "Monkton",
    "Weston",
    "Branscombe",
    "Salcombe Regis",
    "Rousdon",
    "Whitford",
    "Shute",
    "Musbury",
    "Colyford",
    "Farway",
    "Gittisham",
]

HOSPITAL_TYPES = [
    "General Hospital",
    "Community Hospital",
    "Specialist Hospital",
    "Clinic",
    "Medical Centre",
    "Health Centre",
    "Infirmary",
    "Sanitorium",
    "Secure Facility",
    "Correctional Healthcare Institute",
    "Chiropractic Hospital",
    "Massage and Spa",
    "Rehabilitation Centre",
    "Urgent Care Centre",
    "Outpatient Facility",
    "Diagnostic Centre",
    "Surgical Centre",
    "Maternity Hospital",
    "Pediatric Hospital",
    "Psychiatric Hospital",
    "Veterans Hospital",
    "Military Hospital",
    "Veterinary Hospital",
    "Eye Hospital",
    "Dental Hospital",
    "Cardiac Centre",
    "Cancer Centre",
    "Electroconvulsive Therapy Centre",
]

GENDERS = ["Male", "Female", "Other"]


# ---------------------------------------------------------------------------
# Helper functions
# ---------------------------------------------------------------------------


def rand_date(start_year=1958, end_year=2005):
    """For DOB: Random date between 1 Jan start_year and 31 Dec end_year (inclusive)."""
    start = datetime(start_year, 1, 1)
    end = datetime(end_year, 12, 31)
    delta = (end - start).days
    return (start + timedelta(days=random.randint(0, delta))).date()


def rand_date_within_years(years=2):
    """Random date within the last `years` years from TODAY."""
    days = years * 365
    return (TODAY - timedelta(days=random.randint(0, days))).date()


def rand_datetime_within_days(past_days=90, future_days=30):
    """
    Return a random datetime between TODAY - past_days and TODAY + future_days.

    Args:
        past_days (int): Days before TODAY to include.
        future_days (int): Days after TODAY to include.

    Returns:
        datetime: Random datetime in the defined interval.
    """
    start = TODAY - timedelta(days=past_days)
    end = TODAY + timedelta(days=future_days)
    total_seconds = int((end - start).total_seconds())
    return start + timedelta(seconds=random.randint(0, total_seconds))


# ---------------------------------------------------------------------------
# Generators for each entity type
# ---------------------------------------------------------------------------


def generate_hospitals():
    """
    Generate a list of synthetic hospitals with UNIQUE names.

    Returns:
        list[list]: Rows of hospital data:
            [hospital_id, name, address, beds, accreditation_date, has_ae, is_teaching]
    """

    hospitals = []
    used_names = set()  # Track uniqueness

    for i in range(1, N_HOSPITALS + 1):

        # Generate a unique hospital name
        while True:
            name = f"{random.choice(TOWNS)} {random.choice(HOSPITAL_TYPES)}"
            if name not in used_names:
                used_names.add(name)
                break

        # Random address
        street = random.choice(STREET_NAMES)
        town = random.choice(TOWNS)
        address = f"{random.randint(1, 200)} {street}, {town}, UK"

        beds = random.randint(100, 800)
        accreditation_year = random.randint(2000, 2025)
        accreditation_date = rand_date(accreditation_year, accreditation_year)
        has_ae = random.choice([0, 1])
        teaching = random.choice([0, 1])

        hospitals.append(
            [i, name, address, beds, accreditation_date.isoformat(), has_ae, teaching]
        )

    return hospitals


def generate_doctors(hospitals):
    """
    Generate synthetic doctors assigned to hospitals.

    Args:
        hospitals (list): List of hospital rows.

    Returns:
        list[list]: Rows of doctor data following:
            [doctor_id, hospital_id, first, last, dob, address]
    """

    doctors = []
    hospital_ids = [h[0] for h in hospitals]

    # Distribute doctors fairly evenly across hospitals
    for doc_id in range(1, N_DOCTORS + 1):
        hospital_id = random.choice(hospital_ids)
        first = random.choice(FIRST_NAMES)
        last = random.choice(LAST_NAMES)
        dob = rand_date(1960, 1995)
        street = random.choice(STREET_NAMES)
        town = random.choice(TOWNS)
        address = f"{random.randint(1, 200)} {street}, {town}, UK"
        doctors.append([doc_id, hospital_id, first, last, dob.isoformat(), address])
    return doctors


def generate_patients(doctors):
    """
    Generate synthetic patients fairly distributed across doctors.

    Args:
        doctors (list): Doctor rows with IDs.

    Returns:
        list[list]: Patient rows:
            [patient_id, doctor_id, first, last, dob, address, gender]
    """
    patients = []
    doctor_ids = [d[0] for d in doctors]

    # divide among docs
    per_doc = N_PATIENTS // len(doctor_ids)
    remainder = N_PATIENTS % len(doctor_ids)

    patient_id = 1
    for idx, doc_id in enumerate(doctor_ids):
        n = per_doc + (1 if idx < remainder else 0)
        for _ in range(n):
            first = random.choice(FIRST_NAMES)
            last = random.choice(LAST_NAMES)
            dob = rand_date(1940, 2018)
            street = random.choice(STREET_NAMES)
            town = random.choice(TOWNS)
            address = f"{random.randint(1, 200)} {street}, {town}, UK"
            gender = random.choice(GENDERS)
            patients.append(
                [patient_id, doc_id, first, last, dob.isoformat(), address, gender]
            )
            patient_id += 1
    return patients


def generate_medications():
    """
    Generate synthetic medications (or labelled placeholders if > base list size).

    Returns:
        list[list]: Medication rows:
            [medication_id, name]
    """
    base_names = [
        "Atorvastatin",
        "Lisinopril",
        "Metformin",
        "Omeprazole",
        "Amlodipine",
        "Simvastatin",
        "Losartan",
        "Levothyroxine",
        "Salbutamol",
        "Sertraline",
        "Amoxicillin",
        "Ibuprofen",
        "Paracetamol",
        "Prednisolone",
        "Furosemide",
        "Warfarin",
        "Clopidogrel",
        "Bisoprolol",
        "Ramipril",
        "Dapagliflozin",
        "Tamsulosin",
        "Citalopram",
        "Fluoxetine",
        "Gabapentin",
        "Tramadol",
        "Hydrochlorothiazide",
        "Spironolactone",
        "Pantoprazole",
        "Ranitidine",
        "Metoprolol",
        "Aspirin",
        "Insulin glargine",
        "Insulin aspart",
        "Duloxetine",
        "Venlafaxine",
        "Allopurinol",
        "Clarithromycin",
        "Azithromycin",
        "Nitrofurantoin",
        "Cefalexin",
        "Levofloxacin",
        "Sildenafil",
        "Tadalafil",
        "Melatonin",
        "Novochok",
    ]

    meds = []
    for i in range(1, N_MEDICATIONS + 1):
        if i <= len(base_names):
            name = base_names[i - 1]
        else:
            name = f"Med_{i:03d}"
        meds.append([i, name])
    return meds


def generate_diseases():
    """
    Return disease definitions with ICD-10 codes.

    Returns:
        list[list]: Disease rows:
            [disease_id, name, description, icd10_code]
    """

    disease_defs = [
        ("Hypertension", "Elevated blood pressure", "I10"),
        ("Type 2 diabetes mellitus", "Disorder of glucose metabolism", "E11"),
        ("Ischaemic heart disease", "Coronary artery disease", "I25"),
        ("Asthma", "Reversible airway obstruction", "J45"),
        ("COPD", "Chronic obstructive pulmonary disease", "J44"),
        ("Chronic kidney disease", "Impaired kidney function", "N18"),
        ("Heart failure", "Impaired cardiac pump function", "I50"),
        ("Depression", "Mood disorder", "F32"),
        ("Anxiety disorder", "Anxiety-related condition", "F41"),
        ("Osteoarthritis", "Degenerative joint disease", "M19"),
        ("Rheumatoid arthritis", "Inflammatory arthritis", "M06"),
        ("Hyperlipidaemia", "Raised cholesterol or triglycerides", "E78"),
        ("Chronic liver disease", "Progressive liver damage", "K76"),
        ("Hypothyroidism", "Underactive thyroid gland", "E03"),
        ("Migraine", "Recurrent headache disorder", "G43"),
    ]

    diseases = []
    for i, (name, desc, icd) in enumerate(disease_defs, start=1):
        diseases.append([i, name, desc, icd])
    return diseases


def generate_disease_treatments(diseases, medications):
    """
    Link diseases to 1–3 medications each.

    Returns:
        list[list]: DiseaseTreatment rows:
            [disease_treatment_id, disease_id, medication_id]
    """
    treatments = []
    treatment_id = 1
    med_ids = [m[0] for m in medications]

    for disease in diseases:
        disease_id = disease[0]
        # For each disease, pick 1–3 medications
        for med_id in random.sample(med_ids, random.randint(1, 3)):
            treatments.append([treatment_id, disease_id, med_id])
            treatment_id += 1
    return treatments


def generate_disease_specialists(diseases, doctors):
    """
    Assign 2–5 specialist doctors per disease.

    Returns:
        list[list]: DiseaseSpecialist rows:
            [disease_specialist_id, disease_id, doctor_id]
    """
    specialists = []
    spec_id = 1
    doctor_ids = [d[0] for d in doctors]

    for disease in diseases:
        disease_id = disease[0]
        # For each disease, pick 2–5 doctors as specialists
        for doc_id in random.sample(doctor_ids, random.randint(2, 5)):
            specialists.append([spec_id, disease_id, doc_id])
            spec_id += 1
    return specialists


def generate_lab_tests():
    """
    Return definitions of lab tests (blood, urine, imaging).

    Returns:
        list[list]: Lab test rows:
            [test_id, name, description, units, reference_range, sample_type]
    """
    base_tests = [
        ("Full blood count", "Haematology panel", "10^9/L", "See comment", "Blood"),
        ("Serum creatinine", "Renal function", "µmol/L", "60–110", "Blood"),
        ("eGFR", "Estimated GFR", "mL/min/1.73m2", ">60", "Blood"),
        ("HbA1c", "Glycated haemoglobin", "%", "20–42", "Blood"),
        ("Lipid profile", "Total cholesterol, HDL, LDL", "mmol/L", "TC <5.0", "Blood"),
        ("ALT", "Alanine transaminase", "IU/L", "0–40", "Blood"),
        ("AST", "Aspartate transaminase", "IU/L", "0–40", "Blood"),
        ("CRP", "C-reactive protein", "mg/L", "0–5", "Blood"),
        ("TSH", "Thyroid-stimulating hormone", "mU/L", "0.4–4.0", "Blood"),
        ("Free T4", "Thyroxine", "pmol/L", "9–25", "Blood"),
        ("Urine dipstick", "Urinalysis", "", "Negative", "Urine"),
        ("Urine ACR", "Albumin:creatinine ratio", "mg/mmol", "<3", "Urine"),
        ("Chest X-ray", "Plain film imaging", "", "", "Imaging"),
        ("CT chest", "CT thorax", "", "", "Imaging"),
        ("MRI brain", "MRI head", "", "", "Imaging"),
    ]

    lab_tests = []
    for i in range(1, N_LAB_TESTS + 1):
        name, desc, units, ref, sample = base_tests[i - 1]
        lab_tests.append([i, name, desc, units, ref, sample])
    return lab_tests


# Prescriptions


def generate_prescriptions(patients, doctors, medications):
    """
    Generate prescription records, ensuring patient is linked to their GP.

    Returns:
        list[list]: Prescription rows:
            [id, patient_id, doctor_id, medication_id, prescribed_date,
             dose_value, dose_units, instructions, duration_days, route]
    """

    prescriptions = []
    presc_id = 1

    patient_ids = [p[0] for p in patients]
    doctor_by_id = {d[0]: d for d in doctors}
    doctor_ids = [d[0] for d in doctors]
    med_ids = [m[0] for m in medications]

    routes = ["Oral", "Inhaled", "Topical", "Subcutaneous", "Intravenous"]
    dose_units_choices = ["mg", "mcg", "g", "units", "puffs"]

    for _ in range(N_PRESCRIPTIONS):
        patient_id = random.choice(patient_ids)
        # Ensure doctor is the patient's registered doctor
        # patients: [patient_id, doctor_id, ...]
        patient_row = next(p for p in patients if p[0] == patient_id)
        doctor_id = patient_row[1]

        medication_id = random.choice(med_ids)
        prescribed_date = rand_date_within_years(2)
        dose_value = random.randint(1, 500)
        dose_units = random.choice(dose_units_choices)
        dose_instructions = random.choice(
            ["OD", "BD", "TDS", "QDS", "PRN", "Once weekly"]
        )
        duration_days = random.choice([7, 14, 28, 30, 90])
        route = random.choice(routes)

        prescriptions.append(
            [
                presc_id,
                patient_id,
                doctor_id,
                medication_id,
                prescribed_date.isoformat(),
                dose_value,
                dose_units,
                dose_instructions,
                duration_days,
                route,
            ]
        )
        presc_id += 1

    return prescriptions


def generate_appointments(patients, doctors, hospitals):
    """
    Generate synthetic appointments for patients with their registered doctor.

    Returns:
        list[list]: Appointment rows:
            [id, patient_id, doctor_id, hospital_id, datetime_string,
             duration_minutes, reason, status]
    """
    appointments = []
    appt_id = 1

    hospital_by_id = {h[0]: h for h in hospitals}
    doctor_by_id = {d[0]: d for d in doctors}

    for _ in range(N_APPOINTMENTS):
        patient = random.choice(patients)
        patient_id = patient[0]
        doctor_id = patient[1]  # registered doctor
        doc_row = doctor_by_id[doctor_id]
        hospital_id = doc_row[1]

        start_dt = rand_datetime_within_days(90, 30)
        duration = random.choice([10, 15, 20, 30, 40])
        reason = random.choice(
            [
                "Follow-up",
                "Medication review",
                "New symptoms",
                "Annual review",
                "Test results discussion",
            ]
        )
        status = random.choice(["Scheduled", "Completed", "Cancelled", "No-show"])

        appointments.append(
            [
                appt_id,
                patient_id,
                doctor_id,
                hospital_id,
                start_dt.strftime("%Y-%m-%d %H:%M:%S"),
                duration,
                reason,
                status,
            ]
        )
        appt_id += 1

    return appointments


# Lab Results


def generate_lab_results(patients, doctors, lab_tests):
    """
    Generate synthetic lab results for random patients and tests.

    Returns:
        list[list]: Lab result rows:
            [id, test_id, patient_id, doctor_id, requested_date, result_date,
             value, is_normal, notes]
    """
    lab_results = []
    result_id = 1

    patient_ids = [p[0] for p in patients]
    doctor_ids = [d[0] for d in doctors]
    lab_test_ids = [t[0] for t in lab_tests]

    for _ in range(N_LAB_RESULTS):
        lab_test_id = random.choice(lab_test_ids)
        patient_id = random.choice(patient_ids)
        doctor_id = random.choice(doctor_ids)
        requested_date = rand_date_within_years(2)
        # result date on/after requested date
        result_date = requested_date + timedelta(days=random.randint(0, 7))
        value = round(random.uniform(0.1, 200.0), 1)
        is_normal = random.choice([0, 1])
        notes = random.choice(
            [
                "Within normal range",
                "Slightly elevated",
                "Significantly abnormal",
                "Repeat test recommended",
                "Clinical correlation advised",
            ]
        )

        lab_results.append(
            [
                result_id,
                lab_test_id,
                patient_id,
                doctor_id,
                requested_date.isoformat(),
                result_date.isoformat(),
                str(value),
                is_normal,
                notes,
            ]
        )
        result_id += 1

    return lab_results


# ---------------------------------------------------------------------------
# CSV output helper
# ---------------------------------------------------------------------------


def write_csv(filename, header, rows):
    """
    Write data rows to a CSV file in ./data/.

    Args:
        filename (str): Name of the CSV file.
        header (list[str]): Column names.
        rows (list[list]): Data rows.

    Side effects:
        Writes a CSV file and prints a status message.
    """
    filepath = f"data/{filename}"
    with open(filepath, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(rows)
    print(f"Wrote {len(rows)} rows to {filepath}")


# ---------------------------------------------------------------------------
# Main generator function
# ---------------------------------------------------------------------------


def main():

    hospitals = generate_hospitals()
    doctors = generate_doctors(hospitals)
    patients = generate_patients(doctors)
    medications = generate_medications()
    diseases = generate_diseases()
    disease_treatments = generate_disease_treatments(diseases, medications)
    disease_specialists = generate_disease_specialists(diseases, doctors)
    lab_tests = generate_lab_tests()
    prescriptions = generate_prescriptions(patients, doctors, medications)
    appointments = generate_appointments(patients, doctors, hospitals)
    lab_results = generate_lab_results(patients, doctors, lab_tests)

    # Write CSVs matching your schema
    write_csv(
        "hospitals.csv",
        [
            "hospital_id",
            "name",
            "address",
            "beds",
            "accreditation_date",
            "has_emergency_department",
            "is_teaching_hospital",
        ],
        hospitals,
    )

    write_csv(
        "doctors.csv",
        [
            "doctor_id",
            "hospital_id",
            "first_name",
            "last_name",
            "date_of_birth",
            "address",
        ],
        doctors,
    )

    write_csv(
        "patients.csv",
        [
            "patient_id",
            "doctor_id",
            "first_name",
            "last_name",
            "date_of_birth",
            "address",
            "gender",
        ],
        patients,
    )

    write_csv(
        "medications.csv",
        ["medication_id", "name"],
        medications,
    )

    write_csv(
        "diseases.csv",
        ["disease_id", "name", "description", "icd10_code"],
        diseases,
    )

    write_csv(
        "disease_treatments.csv",
        ["disease_treatment_id", "disease_id", "medication_id"],
        disease_treatments,
    )

    write_csv(
        "disease_specialists.csv",
        ["disease_specialist_id", "disease_id", "doctor_id"],
        disease_specialists,
    )

    write_csv(
        "lab_tests.csv",
        [
            "lab_test_id",
            "name",
            "description",
            "units",
            "reference_range",
            "sample_type",
        ],
        lab_tests,
    )

    write_csv(
        "prescriptions.csv",
        [
            "prescription_id",
            "patient_id",
            "doctor_id",
            "medication_id",
            "prescribed_date",
            "dose_value",
            "dose_units",
            "dose_instructions",
            "duration_days",
            "route",
        ],
        prescriptions,
    )

    write_csv(
        "appointments.csv",
        [
            "appointment_id",
            "patient_id",
            "doctor_id",
            "hospital_id",
            "appointment_start",
            "duration_minutes",
            "reason",
            "status",
        ],
        appointments,
    )

    write_csv(
        "lab_results.csv",
        [
            "lab_result_id",
            "lab_test_id",
            "patient_id",
            "doctor_id",
            "requested_date",
            "result_date",
            "result_value",
            "is_normal",
            "notes",
        ],
        lab_results,
    )


if __name__ == "__main__":
    main()
