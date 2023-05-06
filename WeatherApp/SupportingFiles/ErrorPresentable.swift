// ErrorPresentable.swift
// Created by Anastasiya Kudasheva

import Foundation

protocol ErrorPresentable: Error {
	var description: String { get }
}
