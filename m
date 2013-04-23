From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to test ? :p
Date: Tue, 23 Apr 2013 20:51:01 +0200
Message-ID: <CAF6-1L4HPK0A_T-PmsonFCFUmA5ugT8Y_CXmwdG7-erRnfEhSA@mail.gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<51704AF4.7060908@42on.com>
	<CAF6-1L5uhOknmR7O6TtrYoiE6Sqb1FbN1-U2cpDbAR31-i2=5A@mail.gmail.com>
	<67AC8E8B-C295-49EA-BD52-39F06E3C5A37@openminds.be>
	<CAF6-1L50V3cn0Sqcw-LajZh=dO=x91HTe4mL2yQ-k5yiGeJ2sg@mail.gmail.com>
	<517664AD02000099000F6C41@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:43130 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757156Ab3DWSvE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Apr 2013 14:51:04 -0400
Received: by mail-bk0-f49.google.com with SMTP id w5so416040bku.8
        for <ceph-devel@vger.kernel.org>; Tue, 23 Apr 2013 11:51:02 -0700 (PDT)
In-Reply-To: <517664AD02000099000F6C41@collaborate.seakr.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>
Cc: Wido den Hollander <wido@42on.com>, pasik@iki.fi, Bernard Grymonpon <bernard@openminds.be>, ceph-devel@vger.kernel.org

Hi,

> My distro (openSuSE 12.1) has /usr/sbin/tapdisk for original tapdisk v1, and /usr/sbin/tapdisk2 for version 2 stuff.  I'm replacing /usr/sbin/tapdisk2.

Mm, do you know where I could find the source for those tapdisk binaries ?


> This is attempting to just use "tap2:aio" for the image format ("tap2:tapdisk:aio" fails identically, as does "tap2:rbd:rbd/test").  In my /var/log/messages file, I see the following:
> Apr 23 10:34:51 se004922 kernel: [ 6328.409708] blktap_control_allocate_tap: allocated tap ffff8807a4898800
> Apr 23 10:34:51 se004922 tapdisk[32464]: tapdisk-control: init, 10 x 4k buffers
> Apr 23 10:34:51 se004922 tapdisk[32464]: I/O queue driver: lio
> Apr 23 10:34:51 se004922 tapdisk[32464]: tapdisk-log: started, level 0
> Apr 23 10:34:51 se004922 tapdisk[32464]: nbd: Set up local unix domain socket on path '/var/run/blktap-control/nbdclient32464'
> Apr 23 10:34:53 se004922 tapdisk[32464]: ERROR: errno -5 at tapdisk_control_read_message: failure reading message at offset 280/536
> Apr 23 10:34:53 se004922 tap-ctl: tap-err:tap_ctl_read_message: failure reading message
> Apr 23 10:34:53 se004922 tap-ctl: tap-err:tap_ctl_send_and_receive: failed to receive 'unknown' message
>
> That "nbd" portion is particularly puzzling - why would it try to start nbd when I've specified a simple tap2:aio image?

The tree I used seem to init some of the NBD logic in all cases (nbd
is integrated in the core rather than purely in the driver).

My guess is that the tree I used is close enough to the debian source
for it to work with just switching tapdisk, but different from
opensuse package.
Can you try to ./configure --prefix=/usr  and then make install ?
This will replace all the binaries including tap-ctl. If they're in a
distinct package, you can pre-uninstall the blktap-utils from your
distro.
'

Cheers,

    Sylvain
