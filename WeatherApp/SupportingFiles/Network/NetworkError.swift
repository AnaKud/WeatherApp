// NetworkError.swift
// Created by Anastasiya Kudasheva

enum NetworkError: ErrorPresentable {
	case parsingError
	case internetError
	case emptyDataError

	var description: String {
		switch self {
		case .parsingError: return "Data decoding error"
		case .internetError: return "Data fetching error"
		case .emptyDataError: return "No data"
		}
	}
}
