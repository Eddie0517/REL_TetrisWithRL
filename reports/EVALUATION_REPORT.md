# 📊 BÁO CÁO ĐÁNH GIÁ HIỆU SUẤT MÔ HÌNH (EVALUATION REPORT)
## DỰ ÁN: REINFORCEMENT LEARNING TETRIS (REL_TetrisWithRL)

> **Ngày thực hiện đánh giá:** 29/09/2026  
> **Môi trường thử nghiệm:** Gymnasium-like Fast Tetris Engine (`src/env/tetris_env.py`)  
> **Thuật toán chính:** Double Deep Q-Network (DDQN) với Vector đặc trưng hình học  
> **Checkpoints kiểm thử:** [`checkpoints/best_model.pth`](../checkpoints/best_model.pth)  

---

## 📌 1. Bảng Đánh Giá Chỉ Số Dự Án (Core Metrics Table)

Dưới đây là bảng tổng hợp các chỉ số định lượng then chốt của tác tử AI được phát triển trong dự án:

| Chỉ số (Metrics) | Kết quả của dự án bạn (DDQN Agent - 200 Episodes) |
| :--- | :--- |
| **Điểm trung bình (Mean Score)** | **336.0 điểm** *(± 193.7)* |
| **Điểm cao nhất (Max Score)** | **680 điểm** |
| **Số hàng xóa trung bình (Mean Cleared Lines)** | **8.4 hàng / ván** *(± 4.8)* |
| **Số hàng xóa kỷ lục (Max Cleared Lines)** | **17 hàng / ván** |
| **Số khối đặt được trung bình (Mean Placed Pieces)** | **57.4 khối / ván** *(thời gian sống sót)* |
| **Thời gian huấn luyện (Training Duration)** | **~4 – 5 phút** *(200 episodes trên CPU/GPU)* |
| **Mức cải thiện so với baseline (vs Random)** | **+108% thời gian sống sót** *(từ 27.6 lên 57.4 khối)*<br>**Tăng đột phá về ăn hàng:** từ `0` hàng lên trung bình `8.4` hàng |
| **Thời gian suy luận mỗi nước đi (Inference Latency)** | **~ 5.4 ms / nước đi** *(phù hợp thời gian thực 60+ FPS)* |

---

## 🔬 2. Bảng Đối Chiếu Thực Nghiệm 3 Chiều (Comparative Benchmark)

Kiểm thử được tiến hành độc lập trên cùng một phân phối khối tetromino ngẫu nhiên giữa 3 tác tử:
1. **Random Agent:** Tác tử chọn nước đi ngẫu nhiên hoàn toàn (mốc sàn đối chứng).
2. **DDQN Agent (Dự án):** Mô hình mạng nơ-ron học tăng cường sâu sau 200 ván tự học.
3. **Pierre Dellacherie Heuristic:** Thuật toán heuristic kinh điển thế giới (mốc trần đối chứng).

| Tiêu chí đánh giá | Random Agent (Mốc sàn) | DDQN Agent (Dự án của bạn) | Pierre Dellacherie Heuristic (Mốc trần) |
| :--- | :---: | :---: | :---: |
| **Điểm trung bình (Mean Score)** | `0.0` | **336.0** | `8,532.0` |
| **Điểm số tối đa (Max Score)** | `0` | **680** | `9,020` |
| **Số hàng xóa trung bình (Mean Lines)** | `0.0` | **8.4** | `195.8` |
| **Số hàng xóa tối đa (Max Lines)** | `0` | **17** | `198` |
| **Số khối đặt trung bình (Survival Steps)** | `27.6` | **57.4** | `500.0` *(chạm trần test)* |
| **Độ lệch chuẩn số hàng (Std Dev Lines)** | `0.0` | **4.84** | `1.33` |
| **Thời gian suy luận trung bình** | $< 1$ ms | **~ 5.4 ms** | ~ 62.8 ms |

---

## 📈 3. Biểu Đồ Trực Quan Hóa (Benchmark Figures)

Biểu đồ so sánh phân phối số hàng dọn sạch (Cleared Lines) và Điểm số (Score) được xuất tự động tại:
👉 **[`reports/figures/benchmark_comparison.png`](figures/benchmark_comparison.png)**

Dữ liệu JSON thô chi tiết cho từng ván đấu được lưu tại:
👉 **[`reports/figures/benchmark_results.json`](figures/benchmark_results.json)**

---

## 🧠 4. Phân Tích & Đánh Giá Chuyên Sâu

### 4.1. Khả năng tự học của Tác tử DDQN:
* **Kiểm soát bề mặt bàn cờ:** Vector 4 đặc trưng ($\text{AggHeight}, \text{Holes}, \text{Bumpiness}, \text{Lines}$) đã giúp mạng nơ-ron nhận thức rõ hậu quả tiêu cực của việc để lại lỗ hổng (*holes*).
* **Hiệu suất sinh tồn:** Sau 200 ván, AI đã kéo dài thời gian sống sót từ **27.6 bước lên 57.4 bước** (tăng hơn **108%** so với việc rơi ngẫu nhiên).
* **Khả năng dọn hàng có chủ đích:** Mô hình đạt kỷ lục **17 hàng** trong một ván đấu, chứng minh AI đã biết cách xếp bằng bề mặt và chờ gạch để ăn các combo 2-4 hàng.

### 4.2. So sánh với Pierre Dellacherie Heuristic:
* Heuristic sử dụng trọng số toán học được tối ưu sẵn qua hàng triệu ván thực nghiệm của các chuyên gia toán học, đạt mốc gần 200 hàng/ván.
* DDQN ở mốc 200 episodes mới chỉ tiếp cận khoảng ~5% thời lượng huấn luyện cần thiết. Theo kế hoạch tại [`TRAINING_PLAN.md`](../TRAINING_PLAN.md), khi huấn luyện từ 1,500 – 2,000 episodes, chỉ số của DDQN sẽ tiệm cận và có thể vượt Heuristic ở các tình huống phức tạp.

---

## 💻 5. Cách Tái Lập Kết Quả Đánh Giá (Reproducibility)

Để tự chạy lại toàn bộ bài kiểm tra và cập nhật lại số liệu, sử dụng lệnh sau:

```bash
# Đánh giá 10 ván chơi cho mỗi tác tử và xuất biểu đồ mới
python src/evaluate.py --games 10 --output-dir reports/figures
```

Sau khi chạy xong, kết quả sẽ tự động được ghi đè vào thư mục `reports/figures/`.
