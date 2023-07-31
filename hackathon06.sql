create database quanlysinhvien;
use quanlysinhvien;
create table dmkhoa
(
    maKhoa  varchar(20) primary key,
    tenkhoa varchar(255)
);
create table dmnganh
(
    maNganh  int auto_increment primary key,
    tenNganh varchar(255),
    maKhoa   varchar(20) not null,
    foreign key (maKhoa) references dmkhoa (maKhoa)
);
create table dmlop
(
    maLop      varchar(20) primary key,
    tenLop     varchar(255),
    maNganh    int not null,
    khoaHoc    int,
    HeDT       varchar(255),
    namNhapHoc int,

    foreign key (maNganh) references dmnganh (maNganh)

);
create table dmhocphan
(
    maHP    int auto_increment primary key,
    tenHP   varchar(255),
    sodvht  int,
    maNganh int not null,
    hocKy   int,
    foreign key (maNganh) references dmnganh (maNganh)
);
create table sinhvien
(
    maSV     int auto_increment primary key,
    HoTen    varchar(255),
    maLop    varchar(20) not null,
    gioiTinh tinyint(1),
    ngaySinh date,
    diaChi   varchar(255),
    foreign key (maLop) references dmlop (maLop)

);
create table diemhp
(
    maSV   int not null,
    maHP   int not null,
    diemHP float,
    foreign key (maSV) references sinhvien (maSV),
    foreign key (maHP) references dmhocphan (maHP)
);
insert into dmkhoa (maKhoa, tenkhoa)
values ('CNTT', 'Công  nghệ thông tin '),
       ('KT', 'kế toán'),
       ('SP', 'sư phạm');
insert into dmnganh (maNganh, tenNganh, maKhoa)
values (140902, 'sư phạm toán tin', 'SP'),
       (408202, 'Tin học ứng dung', 'CNTT');
insert into dmlop (maLop, tenLop, maNganh, khoaHoc, HeDT, namNhapHoc)
values ('CT11', 'Cao đẳng tin học', 408202, 11, 'TC', 2013),
       ('CT12', 'Cao đẳng tin học', 408202, 12, 'CĐ', 2013),
       ('CT13', 'Cao đẳng tin học', 408202, 13, 'TC', 2014)
;
insert into dmhocphan (tenHP, sodvht, maNganh, hocKy)
values ('Toán cao cấp A1', 4, 408202, 1),
       ('Tiến Anh 1', 3, 408202, 1),
       ('Vật lý đại cương', 4, 408202, 1),
       ('Tiến Anh 2', 7, 408202, 1),
       ('Tiến Anh 1', 3, 140902, 2),
       ('Xác suất thống kê', 3, 408202, 2)
;
insert into sinhvien (HoTen, maLop, gioiTinh, ngaySinh, diaChi)
values ('Phan Thanh', 'CT12', 0, '1990-09-12', 'Tuy Phước'),
       ('Nguyễn THị Cẩm', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
       ('Võ THị Hà', 'CT12', 1, '1995-07-02', 'An nhơn'),
       ('Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây sơn'),
       ('Trần Văn Hoàng', 'CT13', 0, '1995-08-04', 'vĩnh thạch'),
       ('Đăng THị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
       ('Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phù Mỹ'),
       ('Nguyễn Văn Huy', 'CT11', 0, '1995-06-04', 'Tây Phước'),
       ('Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài Nhơn')
;
insert into diemhp (maSV, maHP, diemHP)
values (2, 2, 5.9),
       (2, 3, 4.5),
       (3, 1, 4.3),
       (3, 2, 6.7),
       (3, 3, 7.3),
       (4, 1, 4),
       (4, 2, 5.2),
       (4, 3, 3.5),
       (5, 1, 9.8),
       (5, 2, 7.9),
       (5, 3, 7.5),
       (6, 1, 6.1),
       (6, 2, 5.6),
       (6, 3, 4),
       (7, 1, 6.2)
;
# 1.	 Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP, MaHP của những sinh viên có điểm HP >= 5     (5đ)
select *,
       sv.maLop,
       d.diemHP,
       d.maHP
from sinhvien sv
         join diemhp d on sv.maSV = d.maSV
where diemHP >= 5;
# 2.	Hiển thị danh sách MaSV, HoTen, MaLop, MaHP, DiemHP, MaHP được sắp xếp theo ưu tiên MaLop, HoTen tăng dần. (5đ)
select sv.maSV,
       sv.HoTen,
       dl.maLop,
       d.diemHP,
       d.maHP
from sinhvien sv
         join diemhp d on sv.maSV = d.maSV
         join dmlop dL on dL.maLop = sv.maLop
order by dl.maLop and sv.HoTen asc;
# 3.	Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, HocKy của những sinh viên có DiemHP từ 5  7 ở học kỳ I. (5đ)
select sv.maSV,
       sv.HoTen,
       dl.maLop,
       d.diemHP,
       dhp.hocKy
from sinhvien sv
         join diemhp d on sv.maSV = d.maSV
         join dmlop dL on dL.maLop = sv.maLop
         join dmhocphan dhp on dhp.maHP = d.maHP
where d.diemHP between 5 and 7;
# 4.	Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CNTT (5đ)
select sv.maSV,
       sv.HoTen,
       dl.maLop,
       dl.tenLop,
       dn.maKhoa
from sinhvien sv
         join diemhp d on sv.maSV = d.maSV
         join dmlop dL on dL.maLop = sv.maLop
         join dmnganh dn on dn.maNganh = dL.maNganh
where dn.maKhoa like 'CNTT';
# 5.	Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp (SiSo): (5đ)
select dl.maLop,
       dl.tenLop,
       count(sv.maSV)
from sinhvien sv
         join diemhp d on sv.maSV = d.maSV
         join dmlop dL on dL.maLop = sv.maLop
group by dl.maLop;
# 6.	Cho biết điểm trung bình chung của mỗi sinh viên ở mỗi học kỳ
select dhp.hocKy,
       sv.maSV,
       sum(d.diemHP * sodvht) / sum(sodvht) as 'Tổng điểm trung bình '
from sinhvien sv

         join diemhp d on sv.maSV = d.maSV
         join dmhocphan dhp on dhp.maHP = d.maHP
group by dhp.hocKy, sv.maSV
;
# 7.	Cho biết MaLop, TenLop, số lượng nam nữ theo từng lớp.
select sv.maLop,
       dl.tenLop,
       SUM(CASE WHEN sv.gioiTinh = 'Nam' THEN 1 ELSE 0 END) AS 'tổng sinh viên nam',
       SUM(CASE WHEN sv.gioiTinh = 'Nữ' THEN 1 ELSE 0 END)  AS 'tổng sinh viên nữ'
from sinhvien sv
         join dmlop dl on dl.maLop = sv.maLop
group by dl.maLop;
#8.	Cho biết điểm trung bình chung của mỗi sinh viên ở học kỳ 1
# Biết: DiemTBC = ∑▒〖(DiemHP*Sodvhp)/∑(Sodvhp)〗

select sv.maSV,
       sum(d.diemHP * sodvht) / sum(sodvht) as 'Tổng điểm trung bình '
from sinhvien sv

         join diemhp d on sv.maSV = d.maSV
         join dmhocphan dhp on dhp.maHP = d.maHP
where dhp.hocKy = 1
group by dhp.hocKy, sv.maSV
;
# 9.	Cho biết MaSV, HoTen, Số các học phần thiếu điểm (DiemHP<5) của mỗi sinh viên
select sv.maSV,
       sv.HoTen,
       d.diemHP,
       sum(dhp.maHP)
from sinhvien sv
         join diemhp d on sv.maSV = d.maSV
         join dmhocphan dhp on dhp.maHP = d.maHP
where d.diemHP < 5
group by d.diemHP, sv.HoTen, sv.maSV
# 10.	Đếm số sinh viên có điểm HP <5 của mỗi học phần
select dhp.maHP,
       count(distinct sv.maSV) as 'Số lượng sinh viên thiếu'
from sinhvien sv
         join diemhp d on sv.maSV = d.maSV
         join dmhocphan dhp on dhp.maHP = d.maHP
where d.diemHP < 5
group by dhp.maHP
# 11.	Tính tổng số đơn vị học trình có điểm HP<5 của mỗi sinh viên
select sv.maSV,
       sv.HoTen,
       dhp.maHP,
       sum(dhp.sodvht) as 'tổn số đơn vị học trình'
from sinhvien sv
         join diemhp d on sv.maSV = d.maSV
         join dmhocphan dhp on dhp.maHP = d.maHP
where d.diemHP < 5
group by dhp.maHP, sv.maSV, sv.HoTen;
# 12.	Cho biết MaLop, TenLop có tổng số sinh viên >2.
select dl.maLop,
       dl.tenLop,
       count(distinct sv.maSV)
from sinhvien sv
         join diemhp d on sv.maSV = d.maSV
         join dmlop dL on dL.maLop = sv.maLop
group by dl.maLop
having count(sv.maSV) > 2;
# 13.	Cho biết HoTen sinh viên có ít nhất 2 học phần có điểm < 5
select
    sv.maSV,
    sv.HoTen,
    count(dhp.maHP) as 'số lượng '
from sinhvien sv
         join diemhp d on sv.maSV = d.maSV
         join dmlop dL on dL.maLop = sv.maLop
         join dmhocphan dhp on dhp.maHP = d.maHP
where d.diemHP < 5
group by sv.maSV, sv.HoTen
having  count(dhp.maHP)  >=2
 ;
