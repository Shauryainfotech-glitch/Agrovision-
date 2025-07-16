class DiseaseIdentificationResult {
  final String diseaseName;
  final double confidence;
  final String description;
  final List<Treatment> treatments;
  final DiseaseSeverity severity;
  final double affectedArea;

  DiseaseIdentificationResult({
    required this.diseaseName,
    required this.confidence,
    required this.description,
    required this.treatments,
    required this.severity,
    required this.affectedArea,
  });
}

class Treatment {
  final String id;
  final String name;
  final String nameHindi;
  final String description;
  final TreatmentType type;
  final double cost;
  final double effectiveness;
  final String dosage;
  final String applicationMethod;
  final String frequency;
  final List<String> precautions;
  final bool isOrganic;
  final TreatmentAvailability availability;

  Treatment({
    required this.id,
    required this.name,
    required this.nameHindi,
    required this.description,
    required this.type,
    required this.cost,
    required this.effectiveness,
    required this.dosage,
    required this.applicationMethod,
    required this.frequency,
    required this.precautions,
    required this.isOrganic,
    required this.availability,
  });
}

enum DiseaseSeverity { low, moderate, high, critical }

enum TreatmentType { chemical, organic, biological, cultural }

enum TreatmentAvailability { inStock, limitedStock, outOfStock, preOrder }
