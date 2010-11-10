From: srimugunthan dhandapani <srimugunthan.dhandapani@gmail.com>
Subject: mount error on cephv0.22.2
Date: Wed, 10 Nov 2010 18:45:12 +0530
Message-ID: <AANLkTinJUHUs1Zub-05ov=SXnLEn7mHrGihxnzad4G3+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e649ceacb774270494b2a52c
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48993 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab0KJNPN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Nov 2010 08:15:13 -0500
Received: by wyb36 with SMTP id 36so660846wyb.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Nov 2010 05:15:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--0016e649ceacb774270494b2a52c
Content-Type: text/plain; charset=ISO-8859-1

Hi all,
I used v0.22.2 ceph with latest git "ceph-standalone-client kernel"
(2.6.36-rc8) and when i try to mount i get the following error
mount error 5 = Input/output error
the dmesg call trace is as follows:
[  199.099511] ceph: loaded (mds proto 32)
[  227.730778] libceph: client4099 fsid 2bf77910-49e4-89cb-8ef0-b74ce321acc4
[  227.730999] libceph: mon0 192.168.1.79:6789 session established
[  360.236062] INFO: task cosd:5004 blocked for more than 120 seconds.
[  360.236068] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  360.236073] cosd          D f4f7df20     0  5004      1 0x00000000
[  360.236080]  f4f7df30 00200086 00000002 f4f7df20 f4f7dee8 c01673d0
ffffffff 00000000
[  360.236092]  c02383f0 f4f758d0 c085c940 f4f75b58 f4f75b5c 5adef48d
00000035 c085c940
[  360.236104]  c085c940 c085c940 00000000 c085c940 5ade69ed 00000035
f4f758d0 00000001
[  360.236115] Call Trace:
[  360.236128]  [<c01673d0>] ? autoremove_wake_function+0x20/0x50
[  360.236135]  [<c02383f0>] ? blkdev_writepage+0x0/0x20
[  360.236143]  [<c05a21e5>] rwsem_down_failed_common+0x95/0xf0
[  360.236148]  [<c05a2272>] rwsem_down_read_failed+0x12/0x20
[  360.236153]  [<c05a22c7>] call_rwsem_down_read_failed+0x7/0x10
[  360.236157]  [<c05a16ec>] ? down_read+0x1c/0x20
[  360.236163]  [<c020f51f>] iterate_supers+0x5f/0xc0
[  360.236167]  [<c0230400>] ? sync_one_sb+0x0/0x30
[  360.236171]  [<c0230459>] sys_sync+0x29/0x60
[  360.236176]  [<c0102fe3>] sysenter_do_call+0x12/0x28

my ceph.conf is attached. i was able to mount with the same ceph.conf
file in ceph0.21.1 and kernel 2.6.35  and also with ceph0.21.3 and
2.6.35 kernel.
I got  the same error with v0.22.2 and kernel 2.6.35 . So i updated
the kernel but it didn't help.
In ceph code , in src/cmds.cc and src/cosd.cc i commented out the line
//  g_conf.profiler_running = IsHeapProfilerRunning;
for the compilation to pass.

the steps i used the following commands as root:

mkcephfs -c /etc/ceph/ceph.conf --allhosts -v
/etc/init.d/ceph -a start
modprobe ceph
mount -t ceph 192.168.1.79:/ /ceph

Kindly point out what i am missing.
thanks,
mugunthan

--0016e649ceacb774270494b2a52c
Content-Type: application/octet-stream; name="ceph.conf"
Content-Disposition: attachment; filename="ceph.conf"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggc8gzo30

Owo7IFNhbXBsZSBjZXBoIGNlcGguY29uZiBmaWxlLgo7CjsgVGhpcyBmaWxlIGRlZmluZXMgY2x1
c3RlciBtZW1iZXJzaGlwLCB0aGUgdmFyaW91cyBsb2NhdGlvbnMKOyB0aGF0IENlcGggc3RvcmVz
IGRhdGEsIGFuZCBhbnkgb3RoZXIgcnVudGltZSBvcHRpb25zLgoKOyBJZiBhICdob3N0JyBpcyBk
ZWZpbmVkIGZvciBhIGRhZW1vbiwgdGhlIHN0YXJ0L3N0b3Agc2NyaXB0IHdpbGwKOyB2ZXJpZnkg
dGhhdCBpdCBtYXRjaGVzIHRoZSBob3N0bmFtZSAob3IgZWxzZSBpZ25vcmUgaXQpLiAgSWYgaXQg
aXMKOyBub3QgZGVmaW5lZCwgaXQgaXMgYXNzdW1lZCB0aGF0IHRoZSBkYWVtb24gaXMgaW50ZW5k
ZWQgdG8gc3RhcnQgb24KOyB0aGUgY3VycmVudCBob3N0IChlLmcuLCBpbiBhIHNldHVwIHdpdGgg
YSBzdGFydHVwLmNvbmYgb24gZWFjaAo7IG5vZGUpLgoKCjsgY3VycmVudCBjbHVzdGVyIG1hZGUg
b2Ygbm9kZTQgbm9kZTUgbm9kZTYgYW5kIG5vZGU3IHdpdGggbm9kZTQgYmVpbmcgdGhlIG1kcyBh
bmQgbW9uaXRvcgo7IGdsb2JhbApbZ2xvYmFsXQoJOyBlbmFibGUgc2VjdXJlIGF1dGhlbnRpY2F0
aW9uCjsJYXV0aCBzdXBwb3J0ZWQgPSBjZXBoeAoJcGlkIGZpbGUgPSAvdmFyL3J1bi9jZXBoLyRu
YW1lLnBpZAogICAgICAgIGRlYnVnIG1zID0gMQoKOyBtb25pdG9ycwo7ICBZb3UgbmVlZCBhdCBs
ZWFzdCBvbmUuICBZb3UgbmVlZCBhdCBsZWFzdCB0aHJlZSBpZiB5b3Ugd2FudCB0bwo7ICB0b2xl
cmF0ZSBhbnkgbm9kZSBmYWlsdXJlcy4gIEFsd2F5cyBjcmVhdGUgYW4gb2RkIG51bWJlci4KW21v
bl0KCW1vbiBkYXRhID0gL2RhdGEvbW9uJGlkCgoJOyBsb2dnaW5nLCBmb3IgZGVidWdnaW5nIG1v
bml0b3IgY3Jhc2hlcywgaW4gb3JkZXIgb2YKCTsgdGhlaXIgbGlrZWxpaG9vZCBvZiBiZWluZyBo
ZWxwZnVsIDopCgk7ZGVidWcgbXMgPSAxCgk7ZGVidWcgbW9uID0gMjAKCTtkZWJ1ZyBwYXhvcyA9
IDIwCgk7ZGVidWcgYXV0aCA9IDIwCgpbbW9uMF0KCWhvc3QgPSAxOTIuMTY4LjEuNzkKCW1vbiBh
ZGRyID0gMTkyLjE2OC4xLjc5OjY3ODkKCjsgbWRzCjsgIFlvdSBuZWVkIGF0IGxlYXN0IG9uZS4g
IERlZmluZSB0d28gdG8gZ2V0IGEgc3RhbmRieS4KW21kc10KCTsgd2hlcmUgdGhlIG1kcyBrZWVw
cyBpdCdzIHNlY3JldCBlbmNyeXB0aW9uIGtleXMKCTtrZXlyaW5nID0gL2RhdGEva2V5cmluZy4k
bmFtZQoKCTsgbWRzIGxvZ2dpbmcgdG8gZGVidWcgaXNzdWVzLgoJO2RlYnVnIG1zID0gMQoJO2Rl
YnVnIG1kcyA9IDIwCgpbbWRzLm5vZGUwXQoJaG9zdCA9IDE5Mi4xNjguMS43OQoKOyBvc2QKOyAg
WW91IG5lZWQgYXQgbGVhc3Qgb25lLiAgVHdvIGlmIHlvdSB3YW50IGRhdGEgdG8gYmUgcmVwbGlj
YXRlZC4KOyAgRGVmaW5lIGFzIG1hbnkgYXMgeW91IGxpa2UuCltvc2RdCgk7IFRoaXMgaXMgd2hl
cmUgdGhlIGJ0cmZzIHZvbHVtZSB3aWxsIGJlIG1vdW50ZWQuCgk7IG9zZCBkYXRhID0gL2RhdGEv
b3NkJGlkCgoJOyBJZGVhbGx5LCBtYWtlIHRoaXMgYSBzZXBhcmF0ZSBkaXNrIG9yIHBhcnRpdGlv
bi4gIEEgZmV3CiAJOyBodW5kcmVkIE1CIHNob3VsZCBiZSBlbm91Z2g7IG1vcmUgaWYgeW91IGhh
dmUgZmFzdCBvciBtYW55CiAJOyBkaXNrcy4gIFlvdSBjYW4gdXNlIGEgZmlsZSB1bmRlciB0aGUg
b3NkIGRhdGEgZGlyIGlmIG5lZWQgYmUKIAk7IChlLmcuIC9kYXRhL29zZCRpZC9qb3VybmFsKSwg
YnV0IGl0IHdpbGwgYmUgc2xvd2VyIHRoYW4gYQogCTsgc2VwYXJhdGUgZGlzayBvciBwYXJ0aXRp
b24uCgk7IG9zZCBqb3VybmFsID0gL2RhdGEvb3NkJGlkL2pvdXJuYWwKCgk7IG9zZCBsb2dnaW5n
IHRvIGRlYnVnIG9zZCBpc3N1ZXMsIGluIG9yZGVyIG9mIGxpa2VsaWhvb2Qgb2YgYmVpbmcKCTsg
aGVscGZ1bAoJO2RlYnVnIG1zID0gMQoJO2RlYnVnIG9zZCA9IDIwCgk7ZGVidWcgZmlsZXN0b3Jl
ID0gMjAKCTtkZWJ1ZyBqb3VybmFsID0gMjAKCgoKCltvc2QxXQoJaG9zdCA9IDE5Mi4xNjguMS43
OQoJb3NkIGRhdGEgPSAvbW50L29zZF9jZXBoCg==
--0016e649ceacb774270494b2a52c--
