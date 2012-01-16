From: Andrey Stepachev <octo47@gmail.com>
Subject: Slow ceph io. High iops. Compared to hadoop.
Date: Mon, 16 Jan 2012 13:42:47 +0400
Message-ID: <CAADCt4+BEYHi8x_RFTo5GEkvneqc_XDO_RGJuWUNhXYNcMS47w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d043d66fdc3d2fc04b6a20a7b
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40909 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab2APJnJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jan 2012 04:43:09 -0500
Received: by wgbdq11 with SMTP id dq11so450081wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jan 2012 01:43:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--f46d043d66fdc3d2fc04b6a20a7b
Content-Type: text/plain; charset=UTF-8

Hi all.

Last week I've investigate the status for hadoop on ceph.
I create some patches to remove some bugs and crashes.
Looks like it works. Even hbase works on top.

For reference all sources and patches are here

https://github.com/octo47/hadoop-common/tree/branch-1.0-ceph
https://github.com/octo47/ceph/tree/v0.40-hadoop

After YCSB and TestDSFIO work without crashes i start investigate
performance.

I have 5node cluster with 4 sata disks. btrfs. 24core on each.
raid. iozone shows up to 520MB/s.

Performance differs in 2-3 times. After some tests i see strange thing.
hadoop uses disk very close to iozone: small amount and iops and high
throughtput (same as iozone).
ceph uses very inefficient: huge amount of iops, up to 3 times less
throughtput (i think because of high amount of iops).

hadoop dstat output:
sda--sdb--sdc--sdd- ----total-cpu-usage---- -dsk/total- --io/total-
util:util:util:util|usr sys idl wai hiq siq| read  writ| read  writ
 100: 100: 100: 100|  1   5  83  11   0   0|   0   529M|   0   247
 100: 100: 100: 100|  1   0  83  16   0   0|   0   542M|   0   168
 100: 100: 100: 100|  1   0  81  18   0   0|  28k  518M|6.00   149
 100: 100: 100: 100|  1   4  77  17   0   0|   0   533M|   0   243
 100: 100: 100: 100|  1   3  83  13   0   0|   0   523M|   0   264

ceph dstat output:
===================================================
sda--sdb--sdc--sdd- ----total-cpu-usage---- -dsk/total- --io/total-
util:util:util:util|usr sys idl wai hiq siq| read  writ| read  writ
68.0:70.0:79.0:76.0|  1   2  93   4   0   0|   0   195M|   0  1723
86.0:85.0:93.0:91.0|  1   2  91   5   0   0|   0   226M|   0  1816
85.0:85.0:85.0:84.0|  1   3  92   4   0   0|   0   235M|   0  2316


So, my question is: can someone point me:
a) can it be because of inefficient buffer size on osd part
(i tried to increase CephOutputStream buffer to 256kb, not helps)
b) what other problems can be and what options can i tune
to find out what is going on.

PS: i can't use iozone on kernel mounted fs. something
hang in kernel, only reboot helps.
in /var/log/messages i see attached kern.log.



-- 
Andrey.

--f46d043d66fdc3d2fc04b6a20a7b
Content-Type: text/x-log; charset=US-ASCII; name="kern.log"
Content-Disposition: attachment; filename="kern.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gxhb1ujs0

SmFuIDE2IDEzOjM0OjU2IGNlcGgwNmcga2VybmVsOiBbMTQ5NjY4Ny4yODk4OTNdIGxpY3A6bW4g
NC4wLjYuNzo3OXNzaW5ldGJpaGQ8Mz5bMTQ5ODI5NC4wMDYwNDZdIElORk86IHJjdV9zY2hlZF9z
dGF0ZSBkZXRlY3RlZCBzdGFsbCBvbiBDUFUgMSAodD02MDAwIGppZmZpZXMpCkphbiAxNiAxMzoz
Njo0OSBjZXBoMDZnIGtlcm5lbDogWzE0OTg0MDYuNDEyODk4XSBidHJmcy10cmFuc2FjdGkgRCBm
ZmZmODgwMzJhNGM0ODkwICAgICAwICAxOTU4ICAgICAgMiAweDAwMDAwMDAwCkphbiAxNiAxMzoz
Njo0OSBjZXBoMDZnIGtlcm5lbDogWzE0OTg0MDYuNDEyOTAyXSAgZmZmZjg4MDMyM2Y2M2I3MCAw
MDAwMDAwMDAwMDAwMDQ2IGZmZmY4ODAzMjNmNjNiMjAgZmZmZmZmZmYwMDAwMDAwMApKYW4gMTYg
MTM6MzY6NDkgY2VwaDA2ZyBrZXJuZWw6IFsxNDk4NDA2LjQxMjkwNiAgMDAwMDAwMWEwZmY4MDJm
M2QgZmY4MzM2MDAwMDAwMDAyNApKYW4gMTYgMTM6MzY6NDkgY2VwaDA2ZyA0WzQ4MC4xOTkgZmY4
MDJmM2QgMDAwMDAyNCBmZjgwM2RjMDBmZjg4M2FjNDA8PjE5NDY0MjFdQ2wgcmM6PD4xOTQ2NDIy
XSA8ZmZmZjE5MzBdP193aV9iZmUreDAwMzAKSmFuIDE2IDEzOjM2OjQ5IGNlcGgwNmcgNFs0ODAu
MTk5IFtmZmZmODU0OD4gdV9mbG5fYXRvX2kreDgwOQpKYW4gMTYgMTM6MzY6NDkgY2VwaDA2ZyA0
WzQ4MC4xNF0gPGZmZmYxODcwXT9hdW9lb2V3a191Y2luMDQveDA8PjE5NDY0MTk2IFtmZmZmODFk
YT4gX2F0b191ZnIwMjAzCkphbiAxNiAxMzozNjo0OSBjZXBoMDZnIDRbMTk0NjQyNl0gW2ZmZmZm
YTE5OD4gcnRfZV91ZXMwMmMwMzBbcnMKSmFuIDE2IDEzOjM2OjQ5IGNlcGgwNmcgNFs0ODAuMTk1
IFtmZmZmYTE5Nj4gcnRfbF91ZXMwMjEwMjBbdGZdCkphbiAxNiAxMzozNjo0OSBjZXBoMDZnIDRb
NDgwLjEwMiBbZmZmZjgwNDk+ICBhZXVfaSt4MDA0CkphbiAxNiAxMzozNjo0OSBjZXBoMDZnIDRb
NDg0MC4xMDEgW2ZmZmZhMTg0PiBybmF0b190cmEreDgveGEgYnJzCkphbiAxNiAxMzozNjo0OSBj
ZXBoMDZnIDRbNDgwLjEwMSBbZmZmZmExOGM+ICB0Zl9pX3Ffbl9vMDkveDBbdGZdPD4xOTQ2NDMz
XSA8ZmZmZjE4MjZda2hhK3g2MGEKSmFuIDE2IDEzOjM2OjQ5IGNlcGgwNmcgNFs0ODAuMTA3IFtm
ZmZmODVmNj4gZW5sdHJhX2VwcjA0MDEKSmFuIDE2IDEzOjM2OjQ5IGNlcGgwNmcgNFs0ODAuMTAw
IFtmZmZmODA0YT4gIHRyYV9va3JmK3g5L3g5CkphbiAxNiAxMzozNjo0OSBjZXBoMDZnIDRbNDgw
LjEwMyBbZmZmZjg1ZjY+ICBzY2FnK3gzMDEKSmFuIDE2IDEzOjM4OjQ5IGNlcGgwNmcga2VybmVs
OiBbMTQ5ODUyNi4yMjgwOTBdIGJ0cmZzLXRyYW5zYWN0aSBEIGZmZmY4ODAzMmE0YzQ4OTAgICAg
IDAgIDE5NTggICAgICAyIDB4MDAwMDAwMDAKSmFuIDE2IDEzOjM4OjQ5IGNlcGgwNmcga2VybmVs
OiBbMTQ5ODUyNi4yMjgwOTRdICBmZmZmODgwMzIzZjYzYjcwIDAwMDAwMDAwMDAwMDAwNDYgZmZm
Zjg4MDMyM2Y2M2IyMCBmZmZmZmZmZjAwMDAwMDAwCkphbiAxNiAxMzozODo0OSBjZXBoMDZnIGtl
cm5lbDogWzE0OTg1MjYuMjI4MDk4XSAgMDAwMDAwMDAwMDAxMmE0MCBmZmZmODgwMzIzZjYzZmQ4
IGZmZmY4ODAzMjNmNjIwMTAgMDAwMDAwMDAwMDAxMmE0MApKYW4gMTYgMTM6Mzg6NDkgY2VwaDA2
ZyBrZXJuZWw6IFsxNDk4NTI2LjIyODEwMV0gIGZmZmY4ODAzMjNmNjNmZDggMDAwMDAwMDAwMDAx
MmE0MCBmZmZmODgwMzJkMWMwMDAwIGZmZmY4ODAzMmE0YzQ0ZDAKSmFuIDE2IDEzOjM4OjQ5IGNl
cGgwNmcga2VybmVsOiBbMTQ5ODUyNi4yMjgxMDRdIENhbGwgVHJhY2U6CkphbiAxNiAxMzozODo0
OSBjZXBoMDZnIGtlcm5lbDogWzE0OTg1MjYuMjI4MTE0XSAgWzxmZmZmZmZmZjgxMTlkM2IwPl0g
PyBfX3dhaXRfb25fYnVmZmVyKzB4MzAvMHgzMApKYW4gMTYgMTM6Mzg6NDkgY2VwaDA2ZyBrZXJu
ZWw6IFsxNDk4NTI2LjIyODEyMF0gIFs8ZmZmZmZmZmY4MTVlNDY0Yz5dIGlvX3NjaGVkdWxlKzB4
OGMvMHhkMApKYW4gMTYgMTM6Mzg6NDkgY2VwaDA2ZyBrZXJuZWw6IFsxNDk4NTI2LjIyODEyMl0g
IFs8ZmZmZmZmZmY4MTE5ZDNiZT5dIHNsZWVwX29uX2J1ZmZlcisweGUvMHgyMApKYW4gMTYgMTM6
Mzg6NDkgY2VwaDA2ZyBrZXJuZWw6IFsxNDk4NTI2LjIyODEyNV0gIFs8ZmZmZmZmZmY4MTVlNGRk
Zj5dIF9fd2FpdF9vbl9iaXQrMHg1Zi8weDkwCkphbiAxNiAxMzozODo0OSBjZXBoMDZnIGtlcm5l
bDogWzE0OTg1MjYuMjI4MTI4XSAgWzxmZmZmZmZmZjgxMTlkM2IwPl0gPyBfX3dhaXRfb25fYnVm
ZmVyKzB4MzAvMHgzMApKYW4gMTYgMTM6Mzg6NDkgY2VwaDA2ZyBrZXJuZWw6IFsxNDk4NTI2LjIy
ODEzMF0gIFs8ZmZmZmZmZmY4MTVlNGU4OD5dIG91dF9vZl9saW5lX3dhaXRfb25fYml0KzB4Nzgv
MHg5MApKYW4gMTYgMTM6Mzg6NDkgY2VwaDA2ZyBrZXJuZWw6IFsxNDk4NTI2LjIyODEzNV0gIFs8
ZmZmZmZmZmY4MTA4NDdkMD5dID8gYXV0b3JlbW92ZV93YWtlX2Z1bmN0aW9uKzB4NDAvMHg0MApK
YW4gMTYgMTM6Mzg6NDkgY2VwaDA2ZyBrZXJuZWw6IFsxNDk4NTI2LjIyODEzOF0gIFs8ZmZmZmZm
ZmY4MTE5ZDNhZT5dIF9fd2FpdF9vbl9idWZmZXIrMHgyZS8weDMwCkphbiAxNiAxMzozODo0OSBj
ZXBoMDZnIGtlcm5lbDogWzE0OTg1MjYuMjI4MTU4XSAgWzxmZmZmZmZmZmEwMWQ5MThjPl0gd3Jp
dGVfZGV2X3N1cGVycysweDJhYy8weDM0MCBbYnRyZnNdCkphbiAxNiAxMzozODo0OSBjZXBoMDZn
IGtlcm5lbDogWzE0OTg1MjYuMjI4MTY4XSAgWzxmZmZmZmZmZmEwMWQ5NDYxPl0gd3JpdGVfYWxs
X3N1cGVycysweDI0MS8weDJkMCBbYnRyZnNdCkphbiAxNiAxMzozODo0OSBjZXBoMDZnIGtlcm5l
bDogWzE0OTg1MjYuMjI4MTc4XSAgWzxmZmZmZmZmZmEwMWQ5NTAzPl0gd3JpdGVfY3RyZWVfc3Vw
ZXIrMHgxMy8weDIwIFtidHJmc10KSmFuIDE2IDEzOjM4OjQ5IGNlcGgwNmcga2VybmVsOiBbMTQ5
ODUyNi4yMjgxODhdICBbPGZmZmZmZmZmYTAxZGY1OD4gdGZfb210dGFzY2luMDYzMDgwW3RmXTw+
MTk1NjI4OV0gPGZmZmYxZTVlXT9fYV9wbmxjK3gveDA8PjE5NTYyODBdIDxmZmZmMGRjOV0/aml0
YXNjaW4wNi94NyBicnMKSmFuIDE2IDEzOjM4OjQ5IGNlcGgwNmcgNFsxOTU2MjgwXSBbZmZmZjgw
NDk+ICBhZV91cGJ0MDQveDA8PjE5NTYyODFdIDxmZmZmMGQ4M110YXNjaW5raGVkMDIzMDIwW3Rm
XTw+MTk1NjI4Ml0gPGZmZmZhMGQ1MF0/YnJzYm93X25fb3gwMDkgYnJzCkphbiAxNiAxMzo0MDo0
OSBjZXBoMDZnIDRbNDgyLjIyMSAgW2ZmZmZmMWVhNF1rcmVfaGVkaGxlK3gveDA8PjE5NTYyODNd
IDxmZmZmMTgxMF0/a2hlZHdyZV9uMDEwMDEwPD4xNDk1NjI4M10gPGZmZmYxZWEwXT9nX2huZTAx
L3gzPDM+WzE0OTg2NDYuMDQzMTYzXSBJTkZPOiB0YXNrIGJ0cmZzLXRyYW5zYWN0aToxOTU4IGJs
b2NrZWQgZm9yIG1vcmUgdGhhbiAxMjAgc2Vjb25kcy4KSmFuIDE2IDEzOjQwOjQ5IGNlcGgwNmcg
a2VybmVsOiBbMTQ5ODY0Ni4wNDMzMzBdIGJ0cmZzLXRyYW5zYWN0aSBEIGZmZmY4ODAzMmE0YzQ4
OTAgICAgIDAgIDE5NTggICAgICAyIDB4MDAwMDAwMDAKSmFuIDE2IDEzOjQwOjQ5IGNlcGgwNmcg
a2VybmVsOiBbMTQ5ODY0Ni4wNDMzMzRdICBmZmZmODgwMzIzZjYzYjcwIDAwMDAwMDAwMDAwMDAw
NDYgZmZmZjg4MDMyM2Y2M2IyMCBmZmZmZmZmZjAwMDAwMDAwCkphbiAxNiAxMzo0MDo0OSBjZXBo
MDZnIGtlcm5lbDogWzE0OTg2NDYuMDQzMzM4XSAgMDAwMDAwMDAwMDAxMmE0MCBmZmY4ODMzNmY4
ZmY4MDJmMjEgMDAwMDAxYTA8PjE5NjYwMzRdIGZmODAyZjNkIDAwMDAwMWEwZmY4MDIxMDBmZjgw
MjRjNGQKSmFuIDE2IDEzOjQwOjQ5IGNlcGgwNmcgNFs0ODQuNDM0IGFsVGFlCkphbiAxNiAxMzo0
MDo0OSBjZXBoMDZnIDRbNDg0LjQzMyBbZmZmZjgxZGI+ICBfYXRvX3VmcjAzL3gwPD4xOTY2MDM1
XSBbPGZmZmYxZTZjXWlfY2V1ZTA4L3gwPD4xOTY2MDM2XSA8ZmZmZjE5M2I+IGxlX25iZmUreC94
MDw+MTk2NjAzNl0gWzxmZmZmMWVkZl1fd2lfbmJ0MDUveDA8PjE5NjYwMzcgW2ZmZmY4MWRiPiAg
X2F0b191ZnIwMy94MDw+MTk2NjA0MzddIDxmZmZmMWVlOF1vdG9faWV3aV9uYnQwNy94MDw+MTk2
NjAzN10gPGZmZmYxODcwXT9hdHJtdl9hZWZudG9uK3gwMDQKSmFuIDE2IDEzOjQwOjQ5IGNlcGgw
NmcgNFs0ODQuNDM3IFtmZmZmODFkYT4gX2F0b191ZnIwMi94MDw+MTk2NjAzOV0gPGZmZmYwZDFj
XXdpZWRlX3VlczAyYzAzMFt0Zl08PjE5NjYwMzBdIDxmZmZmMGQ0MV13aWVhbHNwcit4NC94ZCBb
dGZdPD4xOTY2MDMxXSBbZmZmZmExOTA+IHJ0X3RlX3VlK3gzMDIgYnJzCkphbiAxNiAxMzo0MDo0
OSBjZXBoMDZnIDRbNDg0LjQ0NiBbZmZmZmExZjg+IHRmX29tdHRhc2NpbjA2My8wODBbdGZdPD4x
OTY2MDMzXSA8ZmZmZjFlNWVdP19hX3BubGMreC94MDw+MTk2NjAzM10gPGZmZmYwZGM5XT9qaW5f
cm5hdG8reDkwMjBbdGZdPD4xOTY2MDM0XSA8ZmZmZjE4NzBdP3drX3BidDA0L3gwPD4xOTY2MDM1
XSA8ZmZmZmEwZDgzXXRhc3RvX3RyYSt4OC94YSBicnMKSmFuIDE2IDEzOjQwOjU3IGNlcGgwNmcg
NFs0ODQuNDQyIFtmZmZmYTE4Yz4gIHRmX2lfcWVkaSt4MDA5IGJyZl08PjE5NjYwMzZdIDxmZmZm
MTgyNl1raGVkMDkveDA8PjE5NjYwMzZdIDxmZmZmMWVhNF1rcmVfaGVkaGxlK3gveDA8PjE5NjYw
MzddIDxmZmZmMTgxMF0/a2hlZHdyZV9uMDEwMDEwPD4xOTY2MDM3XSA8ZmZmZjFlYTBdP2dfaG5l
MDEveDM8Mz5bMTQ5ODY1NC4wNTA2OTVdIElORk86IHJjdV9zY2hlZF9zdGF0ZSBkZXRlY3RlZCBz
dGFsbCBvbiBDUFUgMSAodAo=
--f46d043d66fdc3d2fc04b6a20a7b--
