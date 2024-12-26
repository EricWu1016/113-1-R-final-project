# 載入必要的套件
library(tidyverse)

# 設定檔案路徑
file_path <- "/mnt/data/111年4月臺南市工廠登記清冊.csv"

# 讀取資料
data <- read_csv(file_path, locale = locale(encoding = "BIG5")) # 如果是中文可能需要設定正確的編碼

# 查看資料結構
glimpse(data)

# 簡單分析：檢查某一欄的數據分布
data %>%
  count(某一欄位名稱) %>%
  arrange(desc(n))

# 視覺化範例
data %>%
  ggplot(aes(x = 某一欄位名稱)) +
  geom_bar() +
  labs(title = "某一欄位的分布", x = "欄位名稱", y = "數量")

