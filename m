From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to test ? :p
Date: Tue, 23 Apr 2013 12:02:16 +0200
Message-ID: <CAF6-1L50V3cn0Sqcw-LajZh=dO=x91HTe4mL2yQ-k5yiGeJ2sg@mail.gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<51704AF4.7060908@42on.com>
	<CAF6-1L5uhOknmR7O6TtrYoiE6Sqb1FbN1-U2cpDbAR31-i2=5A@mail.gmail.com>
	<67AC8E8B-C295-49EA-BD52-39F06E3C5A37@openminds.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:54846 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755641Ab3DWKCS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Apr 2013 06:02:18 -0400
Received: by mail-bk0-f48.google.com with SMTP id jf3so175445bkc.21
        for <ceph-devel@vger.kernel.org>; Tue, 23 Apr 2013 03:02:16 -0700 (PDT)
In-Reply-To: <67AC8E8B-C295-49EA-BD52-39F06E3C5A37@openminds.be>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bernard Grymonpon <bernard@openminds.be>, =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>, Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

Hi,

> We can test this, but just a couple of lines of input might be needed to get us going with this without digging through all the code.

Ok, so I added proper argument parsing (using the same format as the
qemu rbd driver) now, so it's easier to test.

First off, you need a working blktap setup for your distribution.
So for example, you should be able to use
"tap2:tapdisk:aio:/path/to/image.raw"  as a vbd.

Starting for there you need to :

 - Download and compile the rbd branch of git://github.com/smunaut/blktap.git
   You will need the ceph development files/packages for this ( for
debian librados-dev librbd-dev )

$ git clone git://github.com/smunaut/blktap.git
$ cd blktap
$ git checkout -b rbd origin/rbd
$ ./autogen.sh
$ ./configure
$ make

 - Replace the installed tapdisk binary with the new one

$ sudo cp ./drivers/.libs/tapdisk  /usr/bin/tapdisk

 - Add 'rbd' as supported format in 'xm'
   For some reason 'xm' checks the image format itself before handing
off to the tap-ctl ...

   Edit /usr/lib/xen-4.1/lib/python/xen/xend/server/BlktapController.py
and add 'rbd' in the blktap2_disk_types list at the top.
   (location of file will vary depending on xen version and distribution)

 - Setup a proper /etc/ceph/ceph.conf containing at least the mon addresses
   Also make sure you have a /etc/ceph/keyring with the user key if
you use cephx

Once that's done, you should be able to attach disk to a running VM using :

$ xm block-attach test_vm tap2:tapdisk:rbd:rbd/test xvda2 w

"rbd/test" above is the pool_name/image_name
You can add the same options as with the qemu driver.


Cheers,

    Sylvain
