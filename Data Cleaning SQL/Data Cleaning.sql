--CLEANING DATA IN SQL 

-- Standardize Date Format 

Select SaleDateConverted, CONVERT(Date, SaleDate)
from NashvilleHousing 

UPDATE NashvilleHousing 
Set SaleDateConverted = CONVERT(Date, SaleDate)

ALTER TABLE NashvilleHousing 
Add SaleDateConverted Date

--Populate Property Address data 

Select  *
from NashvilleHousing 
--where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null


--Breaking out address into individual columns 


select 
SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) -1, LEN(PropertyAddress)) as Address
from NashvilleHousing

ALTER TABLE NashvilleHousing 
Add PropertySplitAddress  nvarchar(255)

ALTER TABLE NashvilleHousing 
Add City nvarchar(255)

UPDATE NashvilleHousing 
Set PropertySplitAddress = SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

UPDATE NashvilleHousing 
Set City = SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) -1, LEN(PropertyAddress))

--Using PARSENAME to seperate owner address 

select 
PARSENAME(REPLACE (OwnerAddress, ',','.'),3),
PARSENAME(REPLACE (OwnerAddress, ',','.'),2),
PARSENAME(REPLACE (OwnerAddress, ',','.'),1)
from NashvilleHousing

ALTER TABLE NashvilleHousing 
Add OwnerSplitAddress  nvarchar(255)

UPDATE NashvilleHousing 
Set OwnerSplitAddress = PARSENAME(REPLACE (OwnerAddress, ',','.'),3)

ALTER TABLE NashvilleHousing 
Add OwnerSplitCity  nvarchar(255)

UPDATE NashvilleHousing 
Set OwnerSplitCity = PARSENAME(REPLACE (OwnerAddress, ',','.'),2)

ALTER TABLE NashvilleHousing 
Add OwnerSplitState  nvarchar(255)

UPDATE NashvilleHousing 
Set OwnerSplitState = PARSENAME(REPLACE (OwnerAddress, ',','.'),1)


--Change Y and N to yes and no in "Sold as Vacant" field

select DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
from NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant,
CASE 
WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant 
END 
from NashvilleHousing

UPDATE NashvilleHousing
set SoldAsVacant = CASE 
WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant 
END 
from NashvilleHousing

--Remove Duplicates 
WITH RowNumCTE as(
select *, 
ROW_NUMBER () OVER (PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate,LegalReference
order by UniqueID) row_num 
from NashvilleHousing
)
delete 
from RowNumCTE
where row_num > 1

--Delete usused colums 

ALTER TABLE NashvilleHousing 
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE NashvilleHousing 
DROP COLUMN SaleDate

select * from NashvilleHousing