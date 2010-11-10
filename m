From: srimugunthan dhandapani <srimugunthan.dhandapani@gmail.com>
Subject: Re: mount error on cephv0.22.2
Date: Wed, 10 Nov 2010 23:16:53 +0530
Message-ID: <AANLkTinRfL3-MPB-22i7eO8Xqs2VJdu0r65Cc5kyBSDm@mail.gmail.com>
References: <AANLkTinJUHUs1Zub-05ov=SXnLEn7mHrGihxnzad4G3+@mail.gmail.com>
	<1289397347.2212.8.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6546da65825cd0494b67106
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41321 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab0KJRqz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Nov 2010 12:46:55 -0500
Received: by yxt33 with SMTP id 33so18122yxt.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Nov 2010 09:46:54 -0800 (PST)
In-Reply-To: <1289397347.2212.8.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

--0016e6546da65825cd0494b67106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi
The process with the D state is:
root      5167  0.0  0.0   1804   240 pts/0    D+   23:09   0:00
/sbin/mount.ceph 192.168.1.79 / /ceph -o rw

ps aux | grep ceph output is:

1000      1419  3.1  1.0  89684 21016 ?        S    23:04   0:15 gedit
/home/srimugunthan/Desktop/ceph_checklist
root      4072  0.2  0.1  49604  3228 ?        Ssl  23:08   0:00
/usr/bin/cmon -i 0 -c /tmp/ceph.conf.3544
root      4589  0.4  0.1  73652  2988 ?        Ssl  23:08   0:00
/usr/bin/cmds -i node0 -c /tmp/ceph.conf.3544
root      5119  0.2  0.7 198356 15756 ?        Ssl  23:08   0:00
/usr/bin/cosd -i 1 -c /tmp/ceph.conf.3544
root      5157  0.0  0.0      0     0 ?        S<   23:09   0:00 [ceph-msgr=
]
root      5166  0.0  0.0   3788   608 pts/0    S+   23:09   0:00 mount
-t ceph 192.168.1.79:/ /ceph
root      5167  0.0  0.0   1804   240 pts/0    D+   23:09   0:00
/sbin/mount.ceph 192.168.1.79 / /ceph -o rw
root      5168  0.0  0.0      0     0 ?        S<   23:09   0:00
[ceph-writeback]
root      5169  0.0  0.0      0     0 ?        S<   23:09   0:00
[ceph-pg-invalid]
root      5170  0.0  0.0      0     0 ?        S<   23:09   0:00 [ceph-trun=
c]
root      5225  0.0  0.0   3372   732 pts/1    S+   23:12   0:00 grep
--color=3Dauto ceph

ceph -s output is :
2010-11-10 23:11:50.345617 b74296d0 -- :/5216 messenger.start
2010-11-10 23:11:50.346006 b74296d0 -- :/5216 --> mon0
192.168.1.79:6789/0 -- auth(proto 0 30 bytes) v1 -- ?+0 0x9b4f828
2010-11-10 23:11:50.346464 b6426b70 -- 192.168.1.79:0/5216 learned my
addr 192.168.1.79:0/5216
2010-11-10 23:11:50.347320 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D mon0
192.168.1.79:6789/0 1 =3D=3D=3D=3D auth_reply(proto 1 0 Success) v1 =3D=3D=
=3D=3D
24+0+0 (1462504351 0 0) 0x9b51ae0
2010-11-10 23:11:50.347475 b7428b70 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- mon_subscribe({monmap=3D0+}) v1 -- ?+0 0x9b519c8
2010-11-10 23:11:50.347529 b7428b70 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(0 v0) v1 -- ?+0 0x9b51c40
2010-11-10 23:11:50.347582 b7428b70 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(1 v0) v1 -- ?+0 0x9b51df8
2010-11-10 23:11:50.347675 b7428b70 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(2 v0) v1 -- ?+0 0x9b4f9f0
2010-11-10 23:11:50.347734 b7428b70 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(3 v0) v1 -- ?+0 0x9b4fb10
2010-11-10 23:11:50.347790 b7428b70 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(4 v0) v1 -- ?+0 0x9b4fc40
2010-11-10 23:11:50.347840 b7428b70 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(5 v0) v1 -- ?+0 0x9b4fd70
2010-11-10 23:11:50.347890 b7428b70 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(6 v0) v1 -- ?+0 0x9b4fea0
2010-11-10 23:11:50.348445 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D mon0
192.168.1.79:6789/0 2 =3D=3D=3D=3D mon_map v1 =3D=3D=3D=3D 187+0+0 (2881423=
474 0 0)
0x9b51998
2010-11-10 23:11:50.349157 b74296d0 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(0 v0) v1 -- ?+0 0x9b51a98
2010-11-10 23:11:50.349407 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D mon0
192.168.1.79:6789/0 3 =3D=3D=3D=3D mon_subscribe_ack(300s) v1 =3D=3D=3D=3D =
20+0+0
(20232142 0 0) 0x9b51998
2010-11-10 23:11:50.349628 b74296d0 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(1 v0) v1 -- ?+0 0x9b51bb8
2010-11-10 23:11:50.349708 b74296d0 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(2 v0) v1 -- ?+0 0x9b51df8
2010-11-10 23:11:50.349760 b74296d0 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(3 v0) v1 -- ?+0 0x9b4f9f0
2010-11-10 23:11:50.349812 b74296d0 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(4 v0) v1 -- ?+0 0x9b4fb10
2010-11-10 23:11:50.349861 b74296d0 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(5 v0) v1 -- ?+0 0x9b4fc40
2010-11-10 23:11:50.349912 b74296d0 -- 192.168.1.79:0/5216 --> mon0
192.168.1.79:6789/0 -- observe(6 v0) v1 -- ?+0 0x9b51998
2010-11-10 23:11:50.350574 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D mon0
192.168.1.79:6789/0 4 =3D=3D=3D=3D mon_observe_notify(v8 114646 bytes lates=
t
v8) v1 =3D=3D=3D=3D 114697+0+0 (1311084701 0 0) 0x9b4f9f0
2010-11-10 23:11:50.350674    pg v8: 528 pgs: 528
active+clean+degraded; 11 KB data, 89846 MB used, 30508 MB / 123 GB
avail; 10/20 degraded (50.000%)
2010-11-10 23:11:50.354159 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D mon0
192.168.1.79:6789/0 5 =3D=3D=3D=3D mon_observe_notify(v4 459 bytes latest v=
4)
v1 =3D=3D=3D=3D 510+0+0 (3032970034 0 0) 0x9b7dcf8
2010-11-10 23:11:50.354200   mds e4: 1/1/1 up {0=3Dup:active}
2010-11-10 23:11:50.354250 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D mon0
192.168.1.79:6789/0 6 =3D=3D=3D=3D mon_observe_notify(v3 1638 bytes latest =
v3)
v1 =3D=3D=3D=3D 1689+0+0 (4040025353 0 0) 0x9b7e568
2010-11-10 23:11:50.354281   osd e3: 1 osds: 1 up, 1 in
2010-11-10 23:11:50.354375 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D mon0
192.168.1.79:6789/0 10 =3D=3D=3D=3D mon_observe_notify(v5 1002 bytes latest
v5) v1 =3D=3D=3D=3D 1053+0+0 (180097538 0 0) 0x9b7f080
2010-11-10 23:11:50.354409   log 2010-11-10 23:09:06.232712 mon0
192.168.1.79:6789/0 4 : [INF] mds0 192.168.1.79:6800/4588 up:active
2010-11-10 23:11:50.354469 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D mon0
192.168.1.79:6789/0 12 =3D=3D=3D=3D mon_observe_notify(v1 13 bytes latest v=
1)
v1 =3D=3D=3D=3D 64+0+0 (3469238695 0 0) 0x9b7f408
2010-11-10 23:11:50.354508 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D mon0
192.168.1.79:6789/0 13 =3D=3D=3D=3D mon_observe_notify(v1 183 bytes latest =
v1)
v1 =3D=3D=3D=3D 234+0+0 (1598745335 0 0) 0x9b7f6a0
2010-11-10 23:11:50.354540   mon e1: 1 mons at {0=3D192.168.1.79:6789/0}
2010-11-10 23:11:50.354573 b7428b70 -- 192.168.1.79:0/5216 <=3D=3D mon0
192.168.1.79:6789/0 14 =3D=3D=3D=3D mon_observe_notify(v3 1025 bytes latest
v3) v1 =3D=3D=3D=3D 1076+0+0 (4171918925 0 0) 0x9b7fc80
2010-11-10 23:11:50.355243 b74296d0 -- 192.168.1.79:0/5216 shutdown complet=
e.

the new ceph.conf is attached.
Thanks,
mugunthan


On Wed, Nov 10, 2010 at 7:25 PM, Wido den Hollander <wido@widodh.nl> wrote:
> Hi,
>
> It seems you OSD is stalling.
>
> When you do "ps aux", do you see any processes in the "D" state (beside
> cosd)
>
> And what does "ceph -s" show?
>
> Btw, in your ceph.conf, use "host =3D <hostname>" instead of the
> IP-Address of the machine.
>
> Wido
>
> On Wed, 2010-11-10 at 18:45 +0530, srimugunthan dhandapani wrote:
>> Hi all,
>> I used v0.22.2 ceph with latest git "ceph-standalone-client kernel"
>> (2.6.36-rc8) and when i try to mount i get the following error
>> mount error 5 =3D Input/output error
>> the dmesg call trace is as follows:
>> [ =A0199.099511] ceph: loaded (mds proto 32)
>> [ =A0227.730778] libceph: client4099 fsid 2bf77910-49e4-89cb-8ef0-b74ce3=
21acc4
>> [ =A0227.730999] libceph: mon0 192.168.1.79:6789 session established
>> [ =A0360.236062] INFO: task cosd:5004 blocked for more than 120 seconds.
>> [ =A0360.236068] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [ =A0360.236073] cosd =A0 =A0 =A0 =A0 =A0D f4f7df20 =A0 =A0 0 =A05004 =
=A0 =A0 =A01 0x00000000
>> [ =A0360.236080] =A0f4f7df30 00200086 00000002 f4f7df20 f4f7dee8 c01673d=
0
>> ffffffff 00000000
>> [ =A0360.236092] =A0c02383f0 f4f758d0 c085c940 f4f75b58 f4f75b5c 5adef48=
d
>> 00000035 c085c940
>> [ =A0360.236104] =A0c085c940 c085c940 00000000 c085c940 5ade69ed 0000003=
5
>> f4f758d0 00000001
>> [ =A0360.236115] Call Trace:
>> [ =A0360.236128] =A0[<c01673d0>] ? autoremove_wake_function+0x20/0x50
>> [ =A0360.236135] =A0[<c02383f0>] ? blkdev_writepage+0x0/0x20
>> [ =A0360.236143] =A0[<c05a21e5>] rwsem_down_failed_common+0x95/0xf0
>> [ =A0360.236148] =A0[<c05a2272>] rwsem_down_read_failed+0x12/0x20
>> [ =A0360.236153] =A0[<c05a22c7>] call_rwsem_down_read_failed+0x7/0x10
>> [ =A0360.236157] =A0[<c05a16ec>] ? down_read+0x1c/0x20
>> [ =A0360.236163] =A0[<c020f51f>] iterate_supers+0x5f/0xc0
>> [ =A0360.236167] =A0[<c0230400>] ? sync_one_sb+0x0/0x30
>> [ =A0360.236171] =A0[<c0230459>] sys_sync+0x29/0x60
>> [ =A0360.236176] =A0[<c0102fe3>] sysenter_do_call+0x12/0x28
>>
>> my ceph.conf is attached. i was able to mount with the same ceph.conf
>> file in ceph0.21.1 and kernel 2.6.35 =A0and also with ceph0.21.3 and
>> 2.6.35 kernel.
>> I got =A0the same error with v0.22.2 and kernel 2.6.35 . So i updated
>> the kernel but it didn't help.
>> In ceph code , in src/cmds.cc and src/cosd.cc i commented out the line
>> // =A0g_conf.profiler_running =3D IsHeapProfilerRunning;
>> for the compilation to pass.
>>
>> the steps i used the following commands as root:
>>
>> mkcephfs -c /etc/ceph/ceph.conf --allhosts -v
>> /etc/init.d/ceph -a start
>> modprobe ceph
>> mount -t ceph 192.168.1.79:/ /ceph
>>
>> Kindly point out what i am missing.
>> thanks,
>> mugunthan
>
>

--0016e6546da65825cd0494b67106
Content-Type: application/octet-stream; name="ceph.conf"
Content-Disposition: attachment; filename="ceph.conf"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggci4z3s0

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
IDIwCgk7ZGVidWcgYXV0aCA9IDIwCgpbbW9uMF0KCWhvc3QgPSBub2RlMQoJbW9uIGFkZHIgPSAx
OTIuMTY4LjEuNzk6Njc4OQoKOyBtZHMKOyAgWW91IG5lZWQgYXQgbGVhc3Qgb25lLiAgRGVmaW5l
IHR3byB0byBnZXQgYSBzdGFuZGJ5LgpbbWRzXQoJOyB3aGVyZSB0aGUgbWRzIGtlZXBzIGl0J3Mg
c2VjcmV0IGVuY3J5cHRpb24ga2V5cwoJO2tleXJpbmcgPSAvZGF0YS9rZXlyaW5nLiRuYW1lCgoJ
OyBtZHMgbG9nZ2luZyB0byBkZWJ1ZyBpc3N1ZXMuCgk7ZGVidWcgbXMgPSAxCgk7ZGVidWcgbWRz
ID0gMjAKClttZHMubm9kZTBdCglob3N0ID0gbm9kZTEKCjsgb3NkCjsgIFlvdSBuZWVkIGF0IGxl
YXN0IG9uZS4gIFR3byBpZiB5b3Ugd2FudCBkYXRhIHRvIGJlIHJlcGxpY2F0ZWQuCjsgIERlZmlu
ZSBhcyBtYW55IGFzIHlvdSBsaWtlLgpbb3NkXQoJOyBUaGlzIGlzIHdoZXJlIHRoZSBidHJmcyB2
b2x1bWUgd2lsbCBiZSBtb3VudGVkLgoJOyBvc2QgZGF0YSA9IC9kYXRhL29zZCRpZAoKCTsgSWRl
YWxseSwgbWFrZSB0aGlzIGEgc2VwYXJhdGUgZGlzayBvciBwYXJ0aXRpb24uICBBIGZldwogCTsg
aHVuZHJlZCBNQiBzaG91bGQgYmUgZW5vdWdoOyBtb3JlIGlmIHlvdSBoYXZlIGZhc3Qgb3IgbWFu
eQogCTsgZGlza3MuICBZb3UgY2FuIHVzZSBhIGZpbGUgdW5kZXIgdGhlIG9zZCBkYXRhIGRpciBp
ZiBuZWVkIGJlCiAJOyAoZS5nLiAvZGF0YS9vc2QkaWQvam91cm5hbCksIGJ1dCBpdCB3aWxsIGJl
IHNsb3dlciB0aGFuIGEKIAk7IHNlcGFyYXRlIGRpc2sgb3IgcGFydGl0aW9uLgoJOyBvc2Qgam91
cm5hbCA9IC9kYXRhL29zZCRpZC9qb3VybmFsCgoJOyBvc2QgbG9nZ2luZyB0byBkZWJ1ZyBvc2Qg
aXNzdWVzLCBpbiBvcmRlciBvZiBsaWtlbGlob29kIG9mIGJlaW5nCgk7IGhlbHBmdWwKCTtkZWJ1
ZyBtcyA9IDEKCTtkZWJ1ZyBvc2QgPSAyMAoJO2RlYnVnIGZpbGVzdG9yZSA9IDIwCgk7ZGVidWcg
am91cm5hbCA9IDIwCgoKCgpbb3NkMV0KCWhvc3QgPSBub2RlMQoJb3NkIGRhdGEgPSAvbW50L29z
ZF9jZXBoCg==
--0016e6546da65825cd0494b67106--
