From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: ./vstart sticking on mutex
Date: Fri, 13 Jul 2012 15:59:01 -0700
Message-ID: <CAPrxi5_yP45obgnqfDW2EYD04RyD61MwqirJZ_JNMZRdmevobw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41816 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475Ab2GMW7C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 18:59:02 -0400
Received: by gglu4 with SMTP id u4so4113061ggl.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 15:59:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Howdy,

With the latest master branch I'm seeing "./vstart -d -n --localhost"
get stuck when creating an osd. The output from starting is below, as
well as the backtrace of the stuck ceph process.

Thanks,
Noah

backtrace for: ./ceph -c ceph.conf osd create
723da811-e971-4b92-9778-8cd5939dce85

(gdb) bt
#0  0x00007f63e7d8e04c in pthread_cond_wait@@GLIBC_2.3.2 () from
/lib/x86_64-linux-gnu/libpthread.so.0
#1  0x00000000004c966e in Wait (mutex=..., this=0x21e34d0) at ./common/Cond.h:55
#2  MonClient::authenticate (this=0x21e3110, timeout=0) at mon/MonClient.cc:326
#3  0x00000000004629e4 in ceph_tool_common_init (mode=<optimized out>,
concise=<optimized out>) at tools/common.cc:456
#4  0x000000000045ae09 in main (argc=<optimized out>, argv=<optimized
out>) at tools/ceph.cc:290
(gdb)

nwatkins@kyoto:~/test/ceph/src$ ./vstart.sh -d -n --localhost
** going verbose **
./init-ceph: ceph conf ./ceph.conf not found; system is not configured.
ip 127.0.0.1

WARNING: hostname resolves to loopback; remote hosts will not be able to
  connect.  either adjust /etc/hosts, or edit this script to use your
  machine's real IP.

creating keyring
./monmaptool --create --clobber --add a 127.0.0.1:6789 --add b
127.0.0.1:6790 --add c 127.0.0.1:6791 --print /tmp/ceph_monmap.25351
./monmaptool: monmap file /tmp/ceph_monmap.25351
./monmaptool: generated fsid 29045494-7487-40a1-9aef-9886dfaadcc2
epoch 0
fsid 29045494-7487-40a1-9aef-9886dfaadcc2
last_changed 2012-07-13 15:51:23.234058
created 2012-07-13 15:51:23.234058
0: 127.0.0.1:6789/0 mon.a
1: 127.0.0.1:6790/0 mon.b2: 127.0.0.1:6791/0 mon.c
./monmaptool: writing epoch 0 to /tmp/ceph_monmap.25351 (3 monitors)
./ceph-mon --mkfs -c ceph.conf -i a --monmap=/tmp/ceph_monmap.25351
./ceph-mon2012-07-13 15:51:23.346109 7fd3c001e7a0 -1 auth: error
reading file: /etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin:
can't open /etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin:
(2) No such file or directory: error creating monfs: 2012-07-13
15:51:23.346129 7fd3c001e7a0 -1 mon.a@-1(probing) e0 unable to load
initial keyring
/etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin
(2) No such file or directory
./ceph-mon --mkfs -c ceph.conf -i b --monmap=/tmp/ceph_monmap.25351
./ceph-mon: error creating monfs: (2) No such file or
directory2012-07-13 15:51:23.472375 7fabb0c777a0 -1 auth: error
reading file: /etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin:
can't open /etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin:
(2) No such file or directory
2012-07-13 15:51:23.472395 7fabb0c777a0 -1 mon.b@-1(probing) e0 unable
to load initial keyring
/etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin
./ceph-mon --mkfs -c ceph.conf -i c --monmap=/tmp/ceph_monmap.25351
./ceph-mon: error creating monfs: (2) No such file or
directory2012-07-13 15:51:23.598827 7fbef4ba87a0 -1 auth: error
reading file: /etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin:
can't open /etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin:
(2) No such file or directory
2012-07-13 15:51:23.598848 7fbef4ba87a0 -1 mon.c@-1(probing) e0 unable
to load initial keyring
/etc/ceph/ceph.keyring,/etc/ceph/keyring,/etc/ceph/keyring.bin

./ceph-mon -i a -c ceph.conf
starting mon.a rank 0 at 127.0.0.1:6789/0 mon_data dev/mon.a fsid
29045494-7487-40a1-9aef-9886dfaadcc2
./ceph-mon -i b -c ceph.conf
starting mon.b rank 1 at 127.0.0.1:6790/0 mon_data dev/mon.b fsid
29045494-7487-40a1-9aef-9886dfaadcc2
./ceph-mon -i c -c ceph.conf
starting mon.c rank 2 at 127.0.0.1:6791/0 mon_data dev/mon.c fsid
29045494-7487-40a1-9aef-9886dfaadcc2
./vstart.sh: 384: btrfs: not found
add osd0 723da811-e971-4b92-9778-8cd5939dce85
