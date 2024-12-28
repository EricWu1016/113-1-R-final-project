# 載入必要套件
library(tidyverse)

# 讀取檔案
lines <- readLines("111年4月臺南市工廠登記清冊.csv", encoding = "BIG5")

# 轉為 UTF-8 並重新保存
writeLines(lines, "converted_file.csv", useBytes = TRUE)

# 再讀取轉換後的檔案
factory <- read_csv("converted_file.csv")


# 2. 確認欄位名稱
colnames(factory)

# 3. 清理欄位名稱（將 "-" 替換為 "_"）
factory <- factory %>%
  rename_with(~ str_replace_all(., "-", "_"))

# 檢查修改後的欄位名稱
colnames(factory)

# 4. 簡單分析與視覺化

## (a) 計算各行政區的工廠數量
district_counts <- factory %>%
  mutate(行政區 = str_extract(工廠地址, "^[^市]+區")) %>%
  count(行政區, sort = TRUE)

# 查看結果
print(district_counts)

## (b) 視覺化各行政區的工廠分布
district_counts %>%
  ggplot(aes(x = reorder(行政區, n), y = n)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(
    title = "臺南市各行政區工廠分布",
    x = "行政區",
    y = "工廠數量"
  ) +
  theme_minimal()

# 5. 篩選出特定產業類別（例如：食品製造業）
food_industry <- factory %>%
  filter(str_detect(符合之產業類別, "食品製造業"))

# 查看篩選結果
glimpse(food_industry)

# 6. 匯出處理後的資料
write_csv(factory, "處理後的臺南市工廠登記清冊.csv")
write_csv(food_industry, "食品製造業工廠清單.csv")

