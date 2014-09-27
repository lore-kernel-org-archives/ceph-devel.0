From: Timur Nurlygayanov <tnurlygayanov-nYU0QVwCCFFWk0Htik3J/w@public.gmane.org>
Subject: Why performance of benchmarks with small blocks is
	extremely small?
Date: Sat, 27 Sep 2014 19:17:22 +0400
Message-ID: <CAHCYybOs-_ykBJYHY4zsY7FXZKtcz7VMnahc23T+L3AvO4VRZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0982156116=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-community-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0982156116==
Content-Type: multipart/alternative; boundary=089e011608acc85b0405040d87d9

--089e011608acc85b0405040d87d9
Content-Type: text/plain; charset=UTF-8

Hello all,

I installed OpenStack with Glance + Ceph OSD with replication factor 2 and
now I can see the write operations are extremly slow.
For example, I can see only 0.04 MB/s write speed when I run rados bench
with 512b blocks:

rados bench -p test 60 write --no-cleanup -t 1 -b 512

 Maintaining 1 concurrent writes of 512 bytes for up to 60 seconds or 0
objects
 Object prefix: benchmark_data_node-17.domain.tld_15862
   sec Cur ops   started  finished    avg MB/s     cur MB/s       last
lat          avg lat
     0       0         0         0              0
0                   -                   0
     1       1        83        82            0.0400341   0.0400391
0.008465       0.0120985
     2       1       169       168          0.0410111    0.0419922
0.080433       0.0118995
     3       1       240       239          0.0388959    0.034668
0.008052       0.0125385
     4       1       356       355          0.0433309   0.0566406
0.00837         0.0112662
     5       1       472       471          0.0459919   0.0566406
0.008343       0.0106034
     6       1       550       549          0.0446735   0.0380859
0.036639       0.0108791
     7       1       581       580          0.0404538   0.0151367
0.008614       0.0120654


My test environment configuration:
Hardware servers with 1Gb network interfaces, 64Gb RAM and 16 CPU cores per
node, HDDs WDC WD5003ABYX-01WERA0.
OpenStack with 1 controller, 1 compute and 2 ceph nodes (ceph on separate
nodes).
CentOS 6.5, kernel 2.6.32-431.el6.x86_64.

I tested several config options for optimizations, like in
/etc/ceph/ceph.conf:

[default]
...
osd_pool_default_pg_num = 1024
osd_pool_default_pgp_num = 1024
osd_pool_default_flag_hashpspool = true
...
[osd]
osd recovery max active = 1
osd max backfills = 1
filestore max sync interval = 30
filestore min sync interval = 29
filestore flusher = false
filestore queue max ops = 10000
filestore op threads = 16
osd op threads = 16
...
[client]
rbd_cache = true
rbd_cache_writethrough_until_flush = true

and in /etc/cinder/cinder.conf:

[DEFAULT]
volume_tmp_dir=/tmp

but in the result performance was increased only on ~30 % and it not looks
like huge success.

Non-default mount options and TCP optimization increase the speed in about
1%:

[root@node-17 ~]# mount | grep ceph
/dev/sda4 on /var/lib/ceph/osd/ceph-0 type xfs
(rw,noexec,nodev,noatime,nodiratime,user_xattr,data=writeback,barrier=0)

[root@node-17 ~]# cat /etc/sysctl.conf
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_sack = 1


Do we have other ways to significantly improve CEPH storage performance?
Any feedback and comments are welcome!

Thank you!


-- 

Timur,
QA Engineer
OpenStack Projects
Mirantis Inc

--089e011608acc85b0405040d87d9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PjxkaXY+PGRpdj5IZWxsbyBhbGwsPGJyPjxicj48L2Rp
dj5JIGluc3RhbGxlZCBPcGVuU3RhY2sgd2l0aCBHbGFuY2UgKyBDZXBoIE9TRCB3aXRoIHJlcGxp
Y2F0aW9uIGZhY3RvciAyIGFuZCBub3cgSSBjYW4gc2VlIHRoZSB3cml0ZSBvcGVyYXRpb25zIGFy
ZSBleHRyZW1seSBzbG93LjwvZGl2PjxkaXY+Rm9yIGV4YW1wbGUsIEkgY2FuIHNlZSBvbmx5IDAu
MDQgTUIvcyB3cml0ZSBzcGVlZCB3aGVuIEkgcnVuIHJhZG9zIGJlbmNoIHdpdGggNTEyYiBibG9j
a3M6PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PnJhZG9zIGJlbmNoIC1wIHRlc3QgNjAgd3JpdGUg
LS1uby1jbGVhbnVwIC10IDEgLWIgNTEyPGJyPjxicj7CoE1haW50YWluaW5nIDEgY29uY3VycmVu
dCB3cml0ZXMgb2YgNTEyIGJ5dGVzIGZvciB1cCB0byA2MCBzZWNvbmRzIG9yIDAgb2JqZWN0czxi
cj7CoE9iamVjdCBwcmVmaXg6IGJlbmNobWFya19kYXRhX25vZGUtMTcuZG9tYWluLnRsZF8xNTg2
Mjxicj7CoMKgIHNlYyBDdXIgb3BzwqDCoCBzdGFydGVkwqAgZmluaXNoZWQgwqDCoCBhdmcgTUIv
c8KgwqDCoMKgIGN1ciBNQi9zwqDCoMKgwqDCoMKgIGxhc3QgbGF0wqDCoMKgwqDCoMKgwqDCoMKg
IGF2ZyBsYXQ8YnI+wqDCoMKgwqAgMMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqDCoCAwwqDC
oMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqAgwqAgwqAgwqAgMMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC3CoMKg
wqDCoMKgwqDCoCDCoCDCoCDCoCDCoCDCoMKgIDA8YnI+wqDCoMKgwqAgMcKgwqDCoMKgwqDCoCAx
wqDCoMKgwqDCoMKgwqAgODPCoMKgwqDCoMKgwqDCoCA4MiDCoCDCoCDCoCDCoCDCoMKgIDAuMDQw
MDM0McKgwqAgMC4wNDAwMzkxwqDCoMKgwqDCoCAwLjAwODQ2NSDCoCDCoCDCoCAwLjAxMjA5ODU8
YnI+wqDCoMKgwqAgMsKgwqDCoMKgwqDCoCAxwqDCoMKgwqDCoMKgIDE2OcKgwqDCoMKgwqDCoCAx
NjjCoMKgwqDCoMKgwqDCoMKgwqAgMC4wNDEwMTExIMKgwqAgMC4wNDE5OTIywqDCoMKgwqDCoCAw
LjA4MDQzMyDCoCDCoCDCoCAwLjAxMTg5OTU8YnI+wqDCoMKgwqAgM8KgwqDCoMKgwqDCoCAxwqDC
oMKgwqDCoMKgIDI0MMKgwqDCoMKgwqDCoCAyMznCoMKgwqDCoMKgwqDCoMKgwqAgMC4wMzg4OTU5
IMKgwqAgMC4wMzQ2NjjCoMKgwqDCoMKgwqAgMC4wMDgwNTLCoMKgwqDCoMKgwqAgMC4wMTI1Mzg1
PGJyPsKgwqDCoMKgIDTCoMKgwqDCoMKgwqAgMcKgwqDCoMKgwqDCoCAzNTbCoMKgwqDCoMKgwqAg
MzU1wqDCoMKgwqDCoMKgwqDCoMKgIDAuMDQzMzMwOSDCoCAwLjA1NjY0MDbCoMKgwqDCoMKgIDAu
MDA4MzfCoMKgwqDCoMKgwqDCoMKgIDAuMDExMjY2Mjxicj7CoMKgwqDCoCA1wqDCoMKgwqDCoMKg
IDHCoMKgwqDCoMKgwqAgNDcywqDCoMKgwqDCoMKgIDQ3McKgwqDCoMKgwqDCoMKgwqDCoCAwLjA0
NTk5MTnCoMKgIDAuMDU2NjQwNiDCoCDCoMKgIDAuMDA4MzQzwqDCoMKgwqDCoMKgIDAuMDEwNjAz
NDxicj7CoMKgwqDCoCA2wqDCoMKgwqDCoMKgIDHCoMKgwqDCoMKgwqAgNTUwwqDCoMKgwqDCoMKg
IDU0OcKgwqDCoMKgwqDCoMKgwqDCoCAwLjA0NDY3MzXCoMKgIDAuMDM4MDg1OSDCoCDCoMKgIDAu
MDM2NjM5wqDCoMKgwqDCoMKgIDAuMDEwODc5MTxicj7CoMKgwqDCoCA3wqDCoMKgwqDCoMKgIDHC
oMKgwqDCoMKgwqAgNTgxwqDCoMKgwqDCoMKgIDU4MMKgwqDCoMKgwqDCoMKgwqDCoCAwLjA0MDQ1
MzjCoMKgIDAuMDE1MTM2NyDCoCDCoMKgIDAuMDA4NjE0wqDCoMKgwqDCoMKgIDAuMDEyMDY1NDxi
cj48YnI+PGJyPjxkaXY+TXkgdGVzdCBlbnZpcm9ubWVudCBjb25maWd1cmF0aW9uOjxicj48L2Rp
dj48ZGl2PkhhcmR3YXJlIHNlcnZlcnMgd2l0aCAxR2IgbmV0d29yayBpbnRlcmZhY2VzLCA2NEdi
IFJBTSBhbmQgMTYgQ1BVIGNvcmVzIHBlciBub2RlLCBIRERzIFdEQyBXRDUwMDNBQllYLTAxV0VS
QTAuPGJyPjwvZGl2Pk9wZW5TdGFjayB3aXRoIDEgY29udHJvbGxlciwgMSBjb21wdXRlIGFuZCAy
IGNlcGggbm9kZXMgKGNlcGggb24gc2VwYXJhdGUgbm9kZXMpLjxicj5DZW50T1MgNi41LCBrZXJu
ZWwgMi42LjMyLTQzMS5lbDYueDg2XzY0Ljxicj48YnI+PC9kaXY+SSB0ZXN0ZWQgc2V2ZXJhbCBj
b25maWcgb3B0aW9ucyBmb3Igb3B0aW1pemF0aW9ucywgbGlrZSBpbiAvZXRjL2NlcGgvY2VwaC5j
b25mOjxicj48YnI+PC9kaXY+W2RlZmF1bHRdPGJyPi4uLjxicj5vc2RfcG9vbF9kZWZhdWx0X3Bn
X251bSA9IDEwMjQ8YnI+b3NkX3Bvb2xfZGVmYXVsdF9wZ3BfbnVtID0gMTAyNDxicj5vc2RfcG9v
bF9kZWZhdWx0X2ZsYWdfaGFzaHBzcG9vbCA9IHRydWU8YnI+Li4uPGJyPltvc2RdPGJyPm9zZCBy
ZWNvdmVyeSBtYXggYWN0aXZlID0gMTxicj5vc2QgbWF4IGJhY2tmaWxscyA9IDE8YnI+ZmlsZXN0
b3JlIG1heCBzeW5jIGludGVydmFsID0gMzA8YnI+ZmlsZXN0b3JlIG1pbiBzeW5jIGludGVydmFs
ID0gMjk8YnI+ZmlsZXN0b3JlIGZsdXNoZXIgPSBmYWxzZTxicj5maWxlc3RvcmUgcXVldWUgbWF4
IG9wcyA9IDEwMDAwPGJyPmZpbGVzdG9yZSBvcCB0aHJlYWRzID0gMTY8YnI+b3NkIG9wIHRocmVh
ZHMgPSAxNjxicj4uLi48YnI+W2NsaWVudF08YnI+cmJkX2NhY2hlID0gdHJ1ZTxicj5yYmRfY2Fj
aGVfd3JpdGV0aHJvdWdoX3VudGlsX2ZsdXNoID0gdHJ1ZTxicj48ZGl2Pjxicj48L2Rpdj48ZGl2
PmFuZCBpbiAvZXRjL2NpbmRlci9jaW5kZXIuY29uZjo8YnI+PGJyPjwvZGl2PjxkaXY+W0RFRkFV
TFRdPGJyPjwvZGl2PjxkaXY+dm9sdW1lX3RtcF9kaXI9L3RtcDxicj48L2Rpdj48ZGl2Pjxicj5i
dXQgaW4gdGhlIHJlc3VsdCBwZXJmb3JtYW5jZSB3YXMgaW5jcmVhc2VkIG9ubHkgb24gfjMwICUg
YW5kIGl0IG5vdCBsb29rcyBsaWtlIGh1Z2Ugc3VjY2Vzcy48YnI+PGJyPjwvZGl2PjxkaXY+Tm9u
LWRlZmF1bHQgbW91bnQgb3B0aW9ucyBhbmQgVENQIG9wdGltaXphdGlvbiA8c3BhbiBpZD0icmVz
dWx0X2JveCIgY2xhc3M9IiIgbGFuZz0iZW4iPjxzcGFuIGNsYXNzPSIiPmluY3JlYXNlIHRoZSBz
cGVlZDwvc3Bhbj4gPHNwYW4gY2xhc3M9IiI+aW4gYWJvdXQ8L3NwYW4+IDxzcGFuIGNsYXNzPSIi
PjElPC9zcGFuPjwvc3Bhbj46PGJyPjxicj5bcm9vdEBub2RlLTE3IH5dIyBtb3VudCB8IGdyZXAg
Y2VwaDxicj4vZGV2L3NkYTQgb24gL3Zhci9saWIvY2VwaC9vc2QvY2VwaC0wIHR5cGUgeGZzIChy
dyxub2V4ZWMsbm9kZXYsbm9hdGltZSxub2RpcmF0aW1lLHVzZXJfeGF0dHIsZGF0YT13cml0ZWJh
Y2ssYmFycmllcj0wKTxicj48YnI+W3Jvb3RAbm9kZS0xNyB+XSMgY2F0IC9ldGMvc3lzY3RsLmNv
bmY8YnI+bmV0LmNvcmUucm1lbV9tYXggPSAxNjc3NzIxNjxicj5uZXQuY29yZS53bWVtX21heCA9
IDE2Nzc3MjE2PGJyPm5ldC5pcHY0LnRjcF9ybWVtID0gNDA5NiA4NzM4MCAxNjc3NzIxNjxicj5u
ZXQuaXB2NC50Y3Bfd21lbSA9IDQwOTYgNjU1MzYgMTY3NzcyMTY8YnI+bmV0LmlwdjQudGNwX3dp
bmRvd19zY2FsaW5nID0gMTxicj5uZXQuaXB2NC50Y3BfdGltZXN0YW1wcyA9IDE8YnI+bmV0Lmlw
djQudGNwX3NhY2sgPSAxPGJyPjwvZGl2PjxkaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+RG8g
d2UgaGF2ZSBvdGhlciB3YXlzIHRvIHNpZ25pZmljYW50bHkgaW1wcm92ZSBDRVBIIHN0b3JhZ2Ug
cGVyZm9ybWFuY2U/PGJyPjxkaXY+PGRpdj48ZGl2PkFueSBmZWVkYmFjayBhbmQgY29tbWVudHMg
YXJlIHdlbGNvbWUhPGJyPjxicj48L2Rpdj48ZGl2PlRoYW5rIHlvdSE8YnI+PGJyPjxiciBjbGVh
cj0iYWxsIj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj4tLSA8YnI+PGRpdiBkaXI9Imx0
ciI+PGZvbnQgY29sb3I9IiM4ODg4ODgiPjxmb250IGNvbG9yPSIjODg4ODg4Ij48YnI+PC9mb250
PjwvZm9udD48ZGl2IHN0eWxlPSJmb250LWZhbWlseTphcmlhbDtmb250LXNpemU6c21hbGwiPlRp
bXVyLDwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsO2ZvbnQtc2l6ZTpzbWFsbCI+
UUEgRW5naW5lZXI8L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTphcmlhbDtmb250LXNpemU6
c21hbGwiPk9wZW5TdGFjayBQcm9qZWN0czwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OmFy
aWFsO2ZvbnQtc2l6ZTpzbWFsbCI+TWlyYW50aXMgSW5jPC9kaXY+PC9kaXY+DQo8L2Rpdj4NCg==
--089e011608acc85b0405040d87d9--

--===============0982156116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0982156116==--
