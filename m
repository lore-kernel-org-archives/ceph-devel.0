From: pankaj singh <psingh.ait@gmail.com>
Subject: Problem while CEPH setup
Date: Wed, 7 Dec 2011 12:40:42 +0530
Message-ID: <CAPrqf92pUqDZznQHhnKAwFHwZh0OMWs3r-5VMjWcu_g9ds-ehQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55375 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab1LGHKo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2011 02:10:44 -0500
Received: by wgbdr13 with SMTP id dr13so730724wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 06 Dec 2011 23:10:43 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: rohan puri <rohan.puri15@gmail.com>

    Hi,

    I and my friend Rohan tries to setup ceph on our machine. We are new
    to ceph. We have got some issues during ceph setup.
    We have followed following steps.

    1. downloaded the code from Git repo.
    2. compile the code. ./configure ; make
    3. make install
    4. created ceph.conf file.
    /------------------
    [global]
    ;       log dir = out
    ;       logger dir = log
    ;       chdir = ""
    ;       pid file = out/$type$id.pid
    ;       auth supported = cephx
    ;       keyring = /etc/ceph/$name.keyring
    [mon]
          mon data = /root/workera/CEPH/mondata/data/mon.$id

    [osd]
          osd data = /root/workera/CEPH/mondata/data/osd.$id
          osd journal = /root/workera/CEPH/mondata/data/osd.$id.journal
          osd journal size = 1000

    [mon.0]
          host = alpha
          mon addr = 192.168.56.102:6789

    [osd.0]
          host = alpha
          btrfs devs = /root/workera/CEPH/mondata/data/osd0

    [mds]
          debug mds = 1
    [mds.alpha]
          host = alpha
    /----------------------
    5. Created the necessary directories. mkdir -p
/root/workera/CEPH/mondata/data
    6. created a file disk "osd0" with btrfs filesystem.
    7. Run mkcephfs --allhosts -c ceph.conf
      This is the error what i got:

    /---------------------------
    temp dir is /tmp/mkcephfs.rvWtFT0Ddi
    preparing monmap in /tmp/mkcephfs.rvWtFT0Ddi/monmap
    /usr/local/bin/monmaptool --create --clobber --add 0
    192.168.56.102:6789 --print /tmp/mkcephfs.rvWtFT0Ddi/monmap
    /usr/local/bin/monmaptool: monmap file /tmp/mkcephfs.rvWtFT0Ddi/monmap
    /usr/local/bin/monmaptool: generated fsid
fa4b96f9-9c95-424c-b9b0-d55b83ce1d59
    epoch 0
    fsid fa4b96f9-9c95-424c-b9b0-d55b83ce1d59
    last_changed 2011-12-04 05:35:34.443071
    created 2011-12-04 05:35:34.443071
    0: 192.168.56.102:6789/0 mon.0
    /usr/local/bin/monmaptool: writing epoch 0 to
    /tmp/mkcephfs.rvWtFT0Ddi/monmap (1 monitors)
    === osd.0 ===
    2011-12-04 05:35:34.785176 b70bc710 created object store
    /root/workera/CEPH/mondata/data/osd.0 journal
    /root/workera/CEPH/mondata/data/osd.0.journal for osd.0 fsid
    fa4b96f9-9c95-424c-b9b0-d55b83ce1d59
    creating private key for osd.0 keyring
/tmp/mkcephfs.rvWtFT0Ddi/keyring.osd.0
    creating /tmp/mkcephfs.rvWtFT0Ddi/keyring.osd.0
    === mds.alpha ===
    creating private key for mds.alpha keyring
    /tmp/mkcephfs.rvWtFT0Ddi/keyring.mds.alpha
    creating /tmp/mkcephfs.rvWtFT0Ddi/keyring.mds.alpha
    Building generic osdmap from /tmp/mkcephfs.rvWtFT0Ddi/conf
    /usr/local/bin/osdmaptool: osdmap file '/tmp/mkcephfs.rvWtFT0Ddi/osdmap'
    *** glibc detected *** /usr/local/bin/osdmaptool: free(): invalid
    pointer: 0x081e84a8 ***
    ======= Backtrace: =========
    /lib/libc.so.6(+0x6ed8b)[0xb71e6d8b]
    /lib/libc.so.6(cfree+0x9b)[0xb71eb28b]
    /usr/local/bin/osdmaptool(crush_calc_straw+0x26c)[0x8135cdc]
    /usr/local/bin/osdmaptool(crush_make_straw_bucket+0xd7)[0x8135e07]
    /usr/local/bin/osdmaptool(crush_make_bucket+0xb0)[0x8135ed0]
    /usr/local/bin/osdmaptool(_ZN12CrushWrapper10add_bucketEiiiiiPiS0_+0x46)[0x811430c]
    /usr/local/bin/osdmaptool(_ZN6OSDMap32build_simple_crush_map_from_confEP11CephContextR12CrushWrapperRSt3mapIiPKcSt4lessIiESaISt4pairIKiS6_EEE+0x102)[0x8111f34]
    /usr/local/bin/osdmaptool(_ZN6OSDMap22build_simple_from_confEP11CephContextjR6uuid_diii+0x588)[0x8111d88]
    /usr/local/bin/osdmaptool(main+0xc80)[0x80f4d8f]
    /lib/libc.so.6(__libc_start_main+0xf3)[0xb7191003]
    /usr/local/bin/osdmaptool[0x80f3ed1]
    ======= Memory map: ========
    08048000-081cf000 r-xp 00000000 08:02 802104     /usr/local/bin/osdmaptool
    081cf000-081d1000 r--p 00187000 08:02 802104     /usr/local/bin/osdmaptool
    081d1000-081d3000 rw-p 00189000 08:02 802104     /usr/local/bin/osdmaptool
    081d3000-081ff000 rw-p 00000000 00:00 0          [heap]
    b68b2000-b68b3000 ---p 00000000 00:00 0
    b68b3000-b7178000 rw-p 00000000 00:00 0
    b7178000-b72de000 r-xp 00000000 08:02 525765     /lib/libc-2.14.1.so
    b72de000-b72e0000 r--p 00165000 08:02 525765     /lib/libc-2.14.1.so
    b72e0000-b72e1000 rw-p 00167000 08:02 525765     /lib/libc-2.14.1.so
    b72e1000-b72e4000 rw-p 00000000 00:00 0
    b72e4000-b7300000 r-xp 00000000 08:02 525771     /lib/libgcc_s.so.1
    b7300000-b7301000 r--p 0001b000 08:02 525771     /lib/libgcc_s.so.1
    b7301000-b7302000 rw-p 0001c000 08:02 525771     /lib/libgcc_s.so.1
    b7302000-b732b000 r-xp 00000000 08:02 525493     /lib/libm-2.14.1.so
    b732b000-b732c000 r--p 00028000 08:02 525493     /lib/libm-2.14.1.so
    b732c000-b732d000 rw-p 00029000 08:02 525493     /lib/libm-2.14.1.so
    b732d000-b740f000 r-xp 00000000 08:02 270052
/usr/lib/libstdc++.so.6.0.16
    b740f000-b7413000 r--p 000e2000 08:02 270052
/usr/lib/libstdc++.so.6.0.16
    b7413000-b7414000 rw-p 000e6000 08:02 270052
/usr/lib/libstdc++.so.6.0.16
    b7414000-b741c000 rw-p 00000000 00:00 0
    b741c000-b7811000 r-xp 00000000 08:02 293697
/usr/lib/libcryptopp.so.9.0.0
    b7811000-b7847000 r--p 003f5000 08:02 293697
/usr/lib/libcryptopp.so.9.0.0
    b7847000-b7849000 rw-p 0042b000 08:02 293697
/usr/lib/libcryptopp.so.9.0.0
    b7849000-b784d000 rw-p 00000000 00:00 0
    b784d000-b7854000 r-xp 00000000 08:02 525478     /lib/librt-2.14.1.so
    b7854000-b7855000 r--p 00006000 08:02 525478     /lib/librt-2.14.1.so
    b7855000-b7856000 rw-p 00007000 08:02 525478     /lib/librt-2.14.1.so
    b7856000-b785a000 r-xp 00000000 08:02 525907     /lib/libuuid.so.1.3.0
    b785a000-b785b000 r--p 00003000 08:02 525907     /lib/libuuid.so.1.3.0
    b785b000-b785c000 rw-p 00004000 08:02 525907     /lib/libuuid.so.1.3.0
    b785c000-b7873000 r-xp 00000000 08:02 525926     /lib/libpthread-2.14.1.so
    b7873000-b7874000 r--p 00016000 08:02 525926     /lib/libpthread-2.14.1.so
    b7874000-b7875000 rw-p 00017000 08:02 525926     /lib/libpthread-2.14.1.so
    b7875000-b7877000 rw-p 00000000 00:00 0
    b788c000-b788f000 rw-p 00000000 00:00 0
    b788f000-b78ae000 r-xp 00000000 08:02 525496     /lib/ld-2.14.1.so
    b78ae000-b78af000 r--p 0001f000 08:02 525496     /lib/ld-2.14.1.so
    b78af000-b78b0000 rw-p 00020000 08:02 525496     /lib/ld-2.14.1.so
    bfdfc000-bfe1d000 rw-p 00000000 00:00 0          [stack]
    ffffe000-fffff000 r-xp 00000000 00:00 0          [vdso]
    *** Caught signal (Aborted) **
     in thread b7176710
     ceph version 0.39-28-g4a0b00a
(commit:4a0b00a0f29a87965925e0b44c997bece96b9936)
     1: (ceph::BackTrace::BackTrace(int)+0x36) [0x8107cc6]
     2: /usr/local/bin/osdmaptool() [0x81079bd]
     3: [0xffffe400]
     4: (gsignal()+0x45) [0xb71a58c5]
     5: (abort()+0x175) [0xb71a71d5]
     6: (()+0x685ca) [0xb71e05ca]
     7: (()+0x6ed8b) [0xb71e6d8b]
     8: (cfree()+0x9b) [0xb71eb28b]
     9: (crush_calc_straw()+0x26c) [0x8135cdc]
     10: (crush_make_straw_bucket()+0xd7) [0x8135e07]
     11: (crush_make_bucket()+0xb0) [0x8135ed0]
     12: (CrushWrapper::add_bucket(int, int, int, int, int, int*,
    int*)+0x46) [0x811430c]
     13: (OSDMap::build_simple_crush_map_from_conf(CephContext*,
    CrushWrapper&, std::map<int, char const*, std::less<int>,
    std::allocator<std::pair<int const, char const*> > >&)+0x102)
    [0x8111f34]
     14: (OSDMap::build_simple_from_conf(CephContext*, unsigned int,
    uuid_d&, int, int, int)+0x588) [0x8111d88]
     15: (main()+0xc80) [0x80f4d8f]
     16: (__libc_start_main()+0xf3) [0xb7191003]
     17: /usr/local/bin/osdmaptool() [0x80f3ed1]
    /usr/local/sbin/mkcephfs: line 405: 26267 Aborted
    (core dumped) $BINDIR/osdmaptool --create-from-conf $dir/osdmap -c
    $conf
    /-------------------------------------

    This error probably occurs because of following reason
    In function crush_calc_straw while allocating "reverse" malloc getting
    zero as the argument because "bucket->h.size" happens to be zero. So
    while trying to free this variable causing  trouble.

    So, We tried a work around by putting the check for zero size in
    the start of function, which would return from the function if it is zero.

     After this mkcephfs ran successfully but still

    getting issues while trying to run ceph-mon.
    Now ceph-mon  command is unable to create ceph-mon daemon and hence when we

    try to mount with the fuse interface or using the kernel client it
    does not gets mounted stating error connection failed.

    Here is my machine info:
    Platform = OpenSuse 12.1
    kernel version = linux-3.1.0-1.2

-- 
Regards,
Pankaj SIngh
Phone No: 8826266889
