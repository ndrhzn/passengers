files <- c(
  'https://data.gov.ua/dataset/8c792a9f-6cda-42f8-8b12-04e8a046ff0e/resource/b8a0cd21-6c40-460e-83e6-4bef5310108f/download/f35_12_2019.xlsx',
  'https://data.gov.ua/dataset/8c792a9f-6cda-42f8-8b12-04e8a046ff0e/resource/169da93c-b5f7-4fd3-86ea-2dffa45fd867/download/f35_11_2019.xlsx',
  'https://data.gov.ua/dataset/8c792a9f-6cda-42f8-8b12-04e8a046ff0e/resource/dedb39d4-5de9-4d29-80ab-28728f24c5da/download/f35_10_2019.xlsx',
  'https://data.gov.ua/dataset/8c792a9f-6cda-42f8-8b12-04e8a046ff0e/resource/afbe45ad-e3be-45f7-b60a-d0fcca882fb0/download/f35_09_2019.xlsx',
  'https://data.gov.ua/dataset/8c792a9f-6cda-42f8-8b12-04e8a046ff0e/resource/72dda745-e2e0-40f0-8179-7b6eb8719682/download/f35_08_2019.xlsx',
  'https://data.gov.ua/dataset/8c792a9f-6cda-42f8-8b12-04e8a046ff0e/resource/a08d440e-d1c9-4246-b990-19611adb2f9d/download/f35_07_2019.xlsx',
  'https://data.gov.ua/dataset/8c792a9f-6cda-42f8-8b12-04e8a046ff0e/resource/7f45361a-5309-415a-9a4b-d4af69e7ff2b/download/f35_06_2019.xlsx',
  'https://data.gov.ua/dataset/8c792a9f-6cda-42f8-8b12-04e8a046ff0e/resource/6bce9431-4ffb-4b8e-85b5-7f2c4c74eda2/download/f35_05_2019.xlsx',
  'https://data.gov.ua/dataset/8c792a9f-6cda-42f8-8b12-04e8a046ff0e/resource/8e7411ab-5db5-4a2d-97e6-7a8920c609cf/download/f35_04_2019.xlsx',
  'https://data.gov.ua/dataset/8c792a9f-6cda-42f8-8b12-04e8a046ff0e/resource/753ec829-375c-4736-8b71-8490aceb4fc1/download/f35_03_2019.xlsx',
  'https://data.gov.ua/dataset/8c792a9f-6cda-42f8-8b12-04e8a046ff0e/resource/ac653402-3373-4460-b597-9fd0d2f495fe/download/f35_02_2019.xlsx',
  'https://data.gov.ua/dataset/8c792a9f-6cda-42f8-8b12-04e8a046ff0e/resource/e6dcf57b-ca58-48b6-86b3-c992e3719090/download/f35_01_2019.xlsx'
  )

for(i in files) {
  
  filename <- substr(i, 121, 136)
  
  download.file(i, destfile = paste0('data/raw/', filename))
  
}