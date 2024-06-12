export enum PackageType {
  Week = 'week',
  Weeks = 'weeks',
  Month = 'month',
  Months = 'months',
  Year = 'year',
  Years = 'years'
}

export interface PackageForCreate {
  package_name: string;
  duration: number;
  package_type: PackageType;
  price: number;
  benefits: string;
}

export interface PackageForUpdate {
	id: number;
	package_name: string;
	duration: number;
  package_type: PackageType;
	price: number;
	benefits: string;
}
