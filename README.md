# 🎮 Tetris with Reinforcement Learning (REL_TetrisWithRL)

> **Dự án Nghiên cứu & Huấn luyện AI Tự Động Chơi Tetris Bằng Học Tăng Cường (Reinforcement Learning)**  
> Kho lưu trữ mã nguồn cho môn học **Reinforcement Learning** kèm giao diện mô phỏng game **Cyber Tetris** hiện đại.

[![GitHub Repo](https://img.shields.io/badge/GitHub-Eddie0517%2FREL__TetrisWithRL-blue?logo=github)](https://github.com/Eddie0517/REL_TetrisWithRL)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python](https://img.shields.io/badge/Python-3.10+-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![HTML5 / Canvas](https://img.shields.io/badge/HTML5-Canvas%20Game-E34F26?logo=html5&logoColor=white)](index.html)

---

## 📌 1. Giới thiệu đề tài (Project Overview)

Tetris là một trong những bài toán kinh điển trong khoa học máy tính thuộc lớp độ phức tạp **NP-Complete**. Dự án này tập trung vào việc nghiên cứu, mô hình hóa toán học và áp dụng các thuật toán **Học tăng cường (Reinforcement Learning)** — trọng tâm là **Deep Q-Network (DQN / Double DQN)** kết hợp kỹ thuật trích xuất đặc trưng hình học (*Geometric Feature Representation*) để huấn luyện tác tử AI có khả năng tự động chơi Tetris đạt hiệu suất cao.

Đồng thời, dự án cung cấp một giao diện game **Cyber Tetris** theo phong cách Cyberpunk hiện đại (Canvas, Web Audio API, Glassmorphism) sẵn sàng để chơi thủ công hoặc kết nối trực quan hóa mô hình AI theo thời gian thực.

Chi tiết đề cương nghiên cứu khoa học được trình bày tại file:  
👉 **[Xem chi tiết Đề cương nghiên cứu (PROPOSAL.md)](PROPOSAL.md)**

---

## 📑 2. Mô hình hóa bài toán (MDP Formulation)

Bài toán được chuẩn hóa thành một quá trình quyết định Markov hữu hạn $\mathcal{M} = \langle \mathcal{S}, \mathcal{A}, \mathcal{P}, \mathcal{R}, \gamma \rangle$:

### 2.1. Không gian trạng thái (State Space $\mathcal{S}$)
Thay vì sử dụng ma trận pixel thô, trạng thái bàn cờ sau mỗi nước đi dự kiến được mã hóa bằng vector 4 chiều đặc trưng:

$$s_t = \left[ \text{AggHeight}, \text{Holes}, \text{Bumpiness}, \text{Lines} \right]^T$$

1. **Tổng chiều cao các cột (Aggregate Height):** $\sum_{c=1}^{10} h_c$
2. **Số lượng lỗ hổng (Holes):** Số ô trống bị các khối gạch khác che phủ bên trên.
3. **Độ gồ ghề bề mặt (Bumpiness):** $\sum_{c=1}^{9} |h_c - h_{c+1}|$ (đo độ mấp mô).
4. **Số hàng dọn sạch ngay lập tức (Cleared Lines):** $0, 1, 2, 3, 4$.

### 2.2. Không gian hành động (Action Space $\mathcal{A}$)
Sử dụng **Placement-based Action Space**:
* Với mỗi khối gạch hiện tại, tác tử duyệt qua tất cả các cặp vị trí hợp lệ $(x, r)$ (với $x$ là cột thả và $r$ là góc xoay).
* Quyết định nước đi tối ưu:
  $$a^* = \arg\max_{a \in \mathcal{A}(s_t)} Q(s'(s_t, a))$$

### 2.3. Hàm thưởng (Reward Function $\mathcal{R}$)
$$\mathcal{R} = w_1 \cdot (\text{Lines})^2 - w_2 \cdot \Delta \text{Holes} - w_3 \cdot \Delta \text{Bumpiness} - w_4 \cdot \Delta \text{AggHeight} + r_{\text{alive}}$$

* **Thưởng dọn hàng:** Bình phương số hàng để khuyến khích nước đi ăn combo 4 hàng (TETRIS).
* **Phạt lỗ hổng & độ gồ ghề:** Tránh tạo các hốc kẹt không thể lấp đầy và giữ bề mặt bằng phẳng.
* **Thưởng sống sót:** $+1$ điểm mỗi bước hợp lệ.

---

## 🗂️ 3. Cấu trúc thư mục (Repository Structure)

```text
REL_TetrisWithRL/
├── PROPOSAL.md          # Bản đề cương chi tiết đề tài nghiên cứu Reinforcement Learning
├── README.md            # Tài liệu hướng dẫn tổng quan & mô tả kho lưu trữ
├── index.html           # Giao diện chính của game Cyber Tetris (HTML5 Canvas)
├── style.css            # Thiết kế Cyberpunk Glassmorphism & layout tương thích thiết bị
├── audio.js             # Bộ tổng hợp âm thanh 8-bit & nhạc nền (Web Audio API)
├── tetris.js            # Engine game: 7-bag, ghost piece, wall kicks, hold piece, scoring
└── note                 # Ghi chú môi trường phát triển & port cục bộ
```

---

## 🕹️ 4. Tính năng của Game Cyber Tetris

* **Chuẩn cơ chế Tetris hiện đại (Tetris Guideline):**
  * Hệ thống chọn khối **7-Bag Randomizer** công bằng.
  * Tính năng **Hold Piece** (giữ lại khối gạch).
  * Hàng chờ **Next Pieces** (hiển thị trước 3 khối tiếp theo).
  * **Ghost Piece** (bóng định vị vị trí rơi của khối gạch).
  * Cơ chế xoay hỗ trợ **Wall Kicks** cơ bản.
  * Hiệu ứng rung màn hình (*Screen Shake*) và nổ hạt neon (*Particle Explosion*) khi dọn hàng.
* **Âm thanh Arcade tích hợp:**
  * Sử dụng **Web Audio API** tạo trực tiếp âm thanh từ sóng dao động (không lo lỗi thiếu file mp3).
  * Có nhạc nền Synthwave 8-bit lặp tuần hoàn và nút bật/tắt tiện lợi.
* **Hỗ trợ đa nền tảng:**
  * Bàn phím máy tính (Desktop).
  * Phím cảm ứng ảo trên màn hình cho điện thoại / máy tính bảng (Mobile Touch Controls).

### Bảng phím tắt điều khiển:
| Thao tác | Phím bấm trên bàn phím |
| :--- | :--- |
| **Sang trái / Sang phải** | Phím mũi tên `←` `→` hoặc `A` `D` |
| **Xoay theo chiều kim đồng hồ** | Phím mũi tên `↑` hoặc `W` / `X` |
| **Xoay ngược chiều** | Phím `Z` hoặc `Ctrl` |
| **Thả rơi chậm (Soft Drop)** | Phím mũi tên `↓` hoặc `S` |
| **Thả rơi tức thì (Hard Drop)** | Phím `Space` |
| **Giữ khối gạch (Hold)** | Phím `C` hoặc `Shift` |
| **Tạm dừng / Tiếp tục** | Phím `P` hoặc `Esc` |
| **Chơi ván mới** | Phím `R` |

---

## 🚀 5. Hướng dẫn chạy thử nghiệm tại máy cục bộ (Local Run)

Bạn có thể chạy trực tiếp trò chơi trên bất kỳ trình duyệt nào:

### Cách 1: Sử dụng Python HTTP Server
```bash
# Di chuyển vào thư mục dự án
cd REL_TetrisWithRL

# Khởi chạy máy chủ HTTP nội bộ
python -m http.server 8080
```
Mở trình duyệt và truy cập: **`http://localhost:8080`**

### Cách 2: Mở trực tiếp file HTML
Nhấp đúp chuột vào file `index.html` hoặc mở bằng trình duyệt (Chrome, Edge, Firefox, Brave...).

---

## 📦 6. Lộ trình phát triển AI (RL Roadmap)

1. [x] **Xây dựng đề cương nghiên cứu (Research Proposal):** Hoàn thành [`PROPOSAL.md`](PROPOSAL.md).
2. [x] **Xây dựng game mô phỏng giao diện Cyberpunk:** Hoàn thành với HTML5/Canvas/Audio API.
3. [ ] **Môi trường huấn luyện Python (Gym/Gymnasium Environment):** Xây dựng `tetris_env.py` hỗ trợ tính toán đặc trưng hình học siêu tốc với NumPy.
4. [ ] **Huấn luyện mô hình Double DQN:** Cài đặt mạng nơ-ron PyTorch và chạy huấn luyện 5,000 episodes.
5. [ ] **Đánh giá & Benchmark:** So sánh hiệu năng giữa thuật toán Heuristic (Dellacherie) và Deep Q-Network.
6. [ ] **Tích hợp Model vào Web Visualizer:** Sử dụng ONNX Runtime Web để mô hình AI chơi trực tiếp trên trình duyệt.

---

## 👤 Tác giả & Đóng góp
* **Họ và tên:** Eddie / Khang
* **Kho lưu trữ:** [github.com/Eddie0517/REL_TetrisWithRL](https://github.com/Eddie0517/REL_TetrisWithRL)
* **Môn học:** Reinforcement Learning (REL)

*Giữ bản quyền mã nguồn theo giấy phép MIT.*
