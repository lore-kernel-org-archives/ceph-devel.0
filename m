From: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Subject: Problem in building Ceph on CentOS 6
Date: Tue, 20 Mar 2012 14:21:12 +0800
Message-ID: <CALwGbPKfZSBGoTQT+3+3iDv4Bqt2orUTDahc6reObdnLq1cdsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47876 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560Ab2CTGVN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Mar 2012 02:21:13 -0400
Received: by iagz16 with SMTP id z16so10549419iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Mar 2012 23:21:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello everyone.

I'm following the steps in
http://ceph.newdream.net/wiki/Building_kernel_client?TPSecNotice&TPNotC=
heck
to build ceph on my CentOS.

I've updated my kernel to version 3.2.12 without selecting any ceph
related configuration options. Then I follow these steps until "$ make
-C ceph".

I get the following error message.


> [deltamaster@localhost ceph-client-standalone]$ sudo make -C ceph
> make: Entering directory `/home/deltamaster/ceph-client-standalone/ce=
ph'
> make -C /lib/modules/3.2.12/build M=3D/home/deltamaster/ceph-client-s=
tandalone/ceph CONFIG_CEPH_FS=3Dm modules
> make[1]: Entering directory `/usr/src/linux-3.2.12'
>   CC [M]  /home/deltamaster/ceph-client-standalone/ceph/inode.o
> /home/deltamaster/ceph-client-standalone/ceph/inode.c:95: warning: in=
itialization from incompatible pointer type
> /home/deltamaster/ceph-client-standalone/ceph/inode.c: In function =91=
fill_inode=92:
> /home/deltamaster/ceph-client-standalone/ceph/inode.c:623: error: ass=
ignment of read-only member =91i_nlink=92
> /home/deltamaster/ceph-client-standalone/ceph/inode.c: In function =91=
ceph_permission=92:
> /home/deltamaster/ceph-client-standalone/ceph/inode.c:1810: error: =91=
IPERM_FLAG_RCU=92 undeclared (first use in this function)
> /home/deltamaster/ceph-client-standalone/ceph/inode.c:1810: error: (E=
ach undeclared identifier is reported only once
> /home/deltamaster/ceph-client-standalone/ceph/inode.c:1810: error: fo=
r each function it appears in.)
> /home/deltamaster/ceph-client-standalone/ceph/inode.c:1816: error: to=
o many arguments to function =91generic_permission=92
> make[2]: *** [/home/deltamaster/ceph-client-standalone/ceph/inode.o] =
Error 1
> make[1]: *** [_module_/home/deltamaster/ceph-client-standalone/ceph] =
Error 2
> make[1]: Leaving directory `/usr/src/linux-3.2.12'
> make: *** [all] Error 2
> make: Leaving directory `/home/deltamaster/ceph-client-standalone/cep=
h'

I've no idea how to solve this.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
