From: =?ISO-8859-1?Q?S=E9bastien_Paolacci?=
	<sebastien.paolacci@gmail.com>
Subject: pg 0.xxxx on [] is laggy
Date: Tue, 29 Jun 2010 14:12:44 +0200
Message-ID: <AANLkTimJpJeHVMvhLSyASwo3DjE9sd1njJ7PGG9yhPa1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35437 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab0F2MMs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jun 2010 08:12:48 -0400
Received: by wyb38 with SMTP id 38so2626622wyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jun 2010 05:12:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

First of all, many thanks for this wonderful piece of software that
actually looks very promising. It's a segment that imho definitely
lack of credible open source alternatives to the (sometimes infamous
and inefficient) proprietary systems.

So I've just pulled the unstable branch from last Sunday and are few
outcomes (local vm, sorry for that, but as for a first try...):

- Build: transparent, which is actually not so common for an unstable
branch of a said to not be mature project ;). Thanks.

- Config: it's a bit difficult to understand the real meaning of all
the available options (debian and suse dedicated pages are however
very helpful), so documentation is sparse, as expected, and I should
have start by reading the code anyway (so my bad at the end).

- First setup attempt left me with a "mon fs missing 'whoami'.. did
you run mkcephfs?" (see end of mail) I just echoed a "0" in
"/data/mom0/whoami" and it did startup.

- cfuse -m 127.0.01:5678/ /mnt/ceph is eating all my memory and
crashes with a bad_alloc
root@debian-vm1:/home/seb# gdb cfuse
(gdb) run -m 127.0.0.1:6789/ /mnt/ceph/
Starting program: /usr/local/bin/cfuse -m 127.0.0.1:6789/ /mnt/ceph/
[Thread debugging using libthread_db enabled]
terminate called after throwing an instance of 'std::bad_alloc'
  what():  std::bad_alloc

Program received signal SIGABRT, Aborted.
0x00007ffff6b12175 in raise () from /lib/libc.so.6
(gdb) bt
#0  0x00007ffff6b12175 in raise () from /lib/libc.so.6
#1  0x00007ffff6b14f80 in abort () from /lib/libc.so.6
#2  0x00007ffff73a5dd5 in __gnu_cxx::__verbose_terminate_handler() ()
from /usr/lib/libstdc++.so.6
#3  0x00007ffff73a4176 in ?? () from /usr/lib/libstdc++.so.6
#4  0x00007ffff73a41a3 in std::terminate() () from /usr/lib/libstdc++.so.6
#5  0x00007ffff73a429e in __cxa_throw () from /usr/lib/libstdc++.so.6
#6  0x00007ffff73a472d in operator new(unsigned long) () from
/usr/lib/libstdc++.so.6
#7  0x000000000053884d in
__gnu_cxx::new_allocator<entity_addr_t>::allocate
(this=0x7fffffffdcf0, __position=..., __x=<value optimized out>)
    at /usr/include/c++/4.4/ext/new_allocator.h:89
#8  std::_Vector_base<entity_addr_t, std::allocator<entity_addr_t>
>::_M_allocate (this=0x7fffffffdcf0, __position=..., __x=<value
optimized out>)
    at /usr/include/c++/4.4/bits/stl_vector.h:140
#9  std::vector<entity_addr_t, std::allocator<entity_addr_t>
>::_M_insert_aux (this=0x7fffffffdcf0, __position=..., __x=<value
optimized out>)
    at /usr/include/c++/4.4/bits/vector.tcc:322
#10 0x000000000053630e in std::vector<entity_addr_t,
std::allocator<entity_addr_t> >::push_back (s=<value optimized out>,
vec=...)
    at /usr/include/c++/4.4/bits/stl_vector.h:741
#11 parse_ip_port_vec (s=<value optimized out>, vec=...) at config.cc:182
#12 0x000000000052a9a2 in MonClient::build_initial_monmap
(this=0x7fffffffddc0) at mon/MonClient.cc:62
#13 0x000000000044347c in main (argc=2, argv=0x7c65e0, envp=<value
optimized out>) at cfuse.cc:67
(gdb) fr 11
#11 parse_ip_port_vec (s=<value optimized out>, vec=...) at config.cc:182
182         vec.push_back(a);
(gdb) info local
a = {type = 0, nonce = 0, {addr = {ss_family = 0, __ss_align = 0,
__ss_padding = '\000' <repeats 111 times>}, addr4 = {sin_family = 0,
sin_port = 0, sin_addr = {s_addr = 0},
      sin_zero = "\000\000\000\000\000\000\000"}, addr6 = {sin6_family
= 0, sin6_port = 0, sin6_flowinfo = 0, sin6_addr = {__in6_u =
{__u6_addr8 = '\000' <repeats 15 times>,
          __u6_addr16 = {0, 0, 0, 0, 0, 0, 0, 0}, __u6_addr32 = {0, 0,
0, 0}}}, sin6_scope_id = 0}}}
p = 0x7c666e "/"
end = 0x7c666f ""
(gdb)


- cfuse /mnt/ceph is however working as expected. Creating files and
browsing /mnt/ceph content provide with the desired result, dbench -D
/mnt/ceph/ -t 10 2 however seems to endless wait for completion. On
the cfuse side, I'm getting (what seems to be) an endless serie of "pg
0.xxx on [] is laggy"

10.06.29_13:09:29.611244 7fe0e7571710 -- 127.0.0.1:0/2807 >>
127.0.0.1:6800/2736 pipe(0xd083b0 sd=6 pgs=3 cs=1 l=0).getting message
bytes now, currently using 352/104857600
10.06.29_13:09:29.611267 7fe0e7571710 -- 127.0.0.1:0/2807 >>
127.0.0.1:6800/2736 pipe(0xd083b0 sd=6 pgs=3 cs=1 l=0).aborted = 0
10.06.29_13:09:29.611281 7fe0e7571710 -- 127.0.0.1:0/2807 >>
127.0.0.1:6800/2736 pipe(0xd083b0 sd=6 pgs=3 cs=1 l=0).reader got
message 1779 0xd71c70 client_caps(flush_ack ino 10000000089 139 seq 3
caps=pAsxLsXsxFsxcrwb dirty=Fw wanted=- follows 0 size 0/0 mtime
0.000000) v1
10.06.29_13:09:29.611309 7fe0e7d72710 -- 127.0.0.1:0/2807 >>
127.0.0.1:6800/2736 pipe(0xd083b0 sd=6 pgs=3 cs=1 l=0).writer: state =
2 policy.server=0
10.06.29_13:09:29.611320 7fe0e7d72710 -- 127.0.0.1:0/2807 >>
127.0.0.1:6800/2736 pipe(0xd083b0 sd=6 pgs=3 cs=1 l=0).write_ack 1779
10.06.29_13:09:29.611331 7fe0e7d72710 -- 127.0.0.1:0/2807 >>
127.0.0.1:6800/2736 pipe(0xd083b0 sd=6 pgs=3 cs=1 l=0).writer: state =
2 policy.server=0
10.06.29_13:09:29.611347 7fe0ead78710 -- 127.0.0.1:0/2807 <== mds0
127.0.0.1:6800/2736 1777 ==== client_caps(flush_ack ino 10000000086
136 seq 3 caps=pAsxLsXsxFsxcrwb dirty=Fw wanted=- follows 0 size 0/0
mtime 0.000000) v1 ==== 176+0+0 (407452104 0 0) 0xd71210
10.06.29_13:09:29.611371 7fe0ead78710 -- 127.0.0.1:0/2807 <== mds0
127.0.0.1:6800/2736 1778 ==== client_caps(flush_ack ino 10000000087
137 seq 3 caps=pAsxLsXsxFsxcrwb dirty=Fw wanted=- follows 0 size 0/0
mtime 0.000000) v1 ==== 176+0+0 (3805174403 0 0) 0xd70e70
10.06.29_13:09:29.611746 7fe0ead78710 -- 127.0.0.1:0/2807 <== mds0
127.0.0.1:6800/2736 1779 ==== client_caps(flush_ack ino 10000000089
139 seq 3 caps=pAsxLsXsxFsxcrwb dirty=Fw wanted=- follows 0 size 0/0
mtime 0.000000) v1 ==== 176+0+0 (1062806157 0 0) 0xd71c70
10.06.29_13:09:32.265289 7fe0e9d76710 -- 127.0.0.1:0/2807 >>
127.0.0.1:6789/0 pipe(0xd09010 sd=5 pgs=3 cs=1 l=1).writer: state = 2
policy.server=0
10.06.29_13:09:32.265350 7fe0e9d76710 -- 127.0.0.1:0/2807 >>
127.0.0.1:6789/0 pipe(0xd09010 sd=5 pgs=3 cs=1 l=1).write_keepalive
10.06.29_13:09:32.265476 7fe0e9d76710 -- 127.0.0.1:0/2807 >>
127.0.0.1:6789/0 pipe(0xd09010 sd=5 pgs=3 cs=1 l=1).writer: state = 2
policy.server=0
10.06.29_13:09:32.289977 7fe0e8d74710 client4099.objecter  pg 0.4e11
on [] is laggy: 93
10.06.29_13:09:32.290055 7fe0e8d74710 client4099.objecter  pg 0.eba2
on [] is laggy: 7
10.06.29_13:09:32.290079 7fe0e8d74710 client4099.objecter  pg 0.e050
on [] is laggy: 112
10.06.29_13:09:32.290097 7fe0e8d74710 client4099.objecter  pg 0.9066
on [] is laggy: 34
10.06.29_13:09:32.290116 7fe0e8d74710 client4099.objecter  pg 0.df8a
on [] is laggy: 106
10.06.29_13:09:32.290142 7fe0e8d74710 client4099.objecter  pg 0.3b2e
on [] is laggy: 70
10.06.29_13:09:32.290162 7fe0e8d74710 client4099.objecter  pg 0.4136
on [] is laggy: 62
10.06.29_13:09:32.290178 7fe0e8d74710 client4099.objecter  pg 0.8c98
on [] is laggy: 32
10.06.29_13:09:32.290193 7fe0e8d74710 client4099.objecter  pg 0.9d2b
on [] is laggy: 54
10.06.29_13:09:32.290208 7fe0e8d74710 client4099.objecter  pg 0.d372
on [] is laggy: 52
10.06.29_13:09:32.290227 7fe0e8d74710 client4099.objecter  pg 0.661 on
[] is laggy: 64
10.06.29_13:09:32.290241 7fe0e8d74710 client4099.objecter  pg 0.c822
on [] is laggy: 46
10.06.29_13:09:32.290256 7fe0e8d74710 client4099.objecter  pg 0.cbe6
on [] is laggy: 110
10.06.29_13:09:32.290270 7fe0e8d74710 client4099.objecter  pg 0.8506
on [] is laggy: 44
10.06.29_13:09:32.290284 7fe0e8d74710 client4099.objecter  pg 0.9960
on [] is laggy: 83
10.06.29_13:09:32.290299 7fe0e8d74710 client4099.objecter  pg 0.1571
on [] is laggy: 39
(...)

As previously stated I just have a very partial understanding of the
system and I barely took time to look at the sources, so the most
probable reason for this to happen is obviously a
misconfiguration/misuse issue on my side. Shouldn't it however be the
case, what could I provide you with (or where should I start) to
further investigate?

Thanks,
Sebastien

root@debian-vm1:/home/seb# cat /etc/ceph/ceph.conf | grep -v '^;'
[global]
       pid file = /var/run/ceph/$name.pid
       debug ms = 10
[mon]
       mon data = /data/mon$id
[mon0]
       host = debian-vm1
       mon addr = 127.0.0.1:6789
[mds]
[mds0]
       host = debian-vm1
[osd]
       sudo = true
       osd data = /data/osd$id
       osd journal = /data/osd$id/journal
       osd journal size = 128
       filestore journal writeahead = true
[osd0]
       host = debian-vm1

root@debian-vm1:/home/seb# mount | grep data
/dev/sda7 on /data type ext3 (rw,user_xattr)

root@debian-vm1:/home/seb# clear; mkcephfs --allhosts -v -c /etc/ceph/ceph.conf
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon  "mon addr" ""
/usr/local/bin/monmaptool --create --clobber --add 127.0.0.1:6789
--print /tmp/monmap.2416
/usr/local/bin/monmaptool: monmap file /tmp/monmap.2416
/usr/local/bin/monmaptool: generated fsid d5f42ea9-a17f-0916-62a0-6d2e1ea822da
epoch 1
fsid d5f42ea9-a17f-0916-62a0-6d2e1ea822da
last_changed 10.06.29_13:07:31.438903
created 10.06.29_13:07:31.438903
        mon0 127.0.0.1:6789/0
/usr/local/bin/monmaptool: writing epoch 1 to /tmp/monmap.2416 (1 monitors)
max osd in /etc/ceph/ceph.conf is 0, num osd is 1
/usr/local/bin/osdmaptool: osdmap file '/tmp/osdmap.2416'
/usr/local/bin/osdmaptool: writing epoch 1 to /tmp/osdmap.2416
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon  "crush map src" ""
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon  "crush map" ""
Building admin keyring at /tmp/admin.keyring.2416
creating /tmp/admin.keyring.2416
Building monitor keyring with all service keys
creating /tmp/monkeyring.2416
importing contents of /tmp/admin.keyring.2416 into /tmp/monkeyring.2416
creating /tmp/keyring.mds.0
importing contents of /tmp/keyring.mds.0 into /tmp/monkeyring.2416
creating /tmp/keyring.osd.0
importing contents of /tmp/keyring.osd.0 into /tmp/monkeyring.2416
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon  "user" ""
=== mon0 ===
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mon  "mon data" ""
--- debian-vm1# /usr/local/bin/cmon -c /etc/ceph/ceph.conf --mkfs -i 0
--monmap /tmp/monmap.2416 --osdmap /tmp/osdmap.2416 -k
/tmp/keyring.2416 ; rm -f /tmp/keyring.2416
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
/usr/local/bin/cmon: created monfs at /data/mon0 for mon0
`/tmp/admin.keyring.2416' -> `/data/mon0/admin_keyring.bin'
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds  "user" ""
=== mds0 ===
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t mds  "keyring" ""
WARNING: no keyring specified for mds0
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "user" ""
=== osd0 ===
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "osd data" ""
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "osd journal" ""
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "keyring" ""
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "btrfs path"
"/data/osd0"
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "btrfs devs" ""
/usr/local/bin/cconf -c /etc/ceph/ceph.conf -i 0 -t osd  "btrfs
options" "noatime"
--- debian-vm1# test -d /data/osd0 || mkdir -p /data/osd0
--- debian-vm1# test -d /data/osd0/journal || mkdir -p /data/osd0
--- debian-vm1# /usr/local/bin/cosd -c /etc/ceph/ceph.conf --monmap
/tmp/monmap.2416 -i 0 --mkfs --osd-data /data/osd0
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
created object store /data/osd0 journal /data/osd0/journal for osd0
fsid d5f42ea9-a17f-0916-62a0-6d2e1ea822da
WARNING: no keyring specified for osd0
root@debian-vm1:/home/seb# /etc/init.d/ceph start
=== mon0 ===
Starting Ceph mon0 on debian-vm1...
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
mon fs missing 'whoami'.. did you run mkcephfs?
failed: ' /usr/bin/cmon -i 0 -c /etc/ceph/ceph.conf '
