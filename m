From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to test ?
 :p
Date: Tue, 23 Apr 2013 10:38:37 -0600
Message-ID: <517664AD02000099000F6C41@collaborate.seakr.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
 <51704AF4.7060908@42on.com>
 <CAF6-1L5uhOknmR7O6TtrYoiE6Sqb1FbN1-U2cpDbAR31-i2=5A@mail.gmail.com>
 <67AC8E8B-C295-49EA-BD52-39F06E3C5A37@openminds.be>
 <CAF6-1L50V3cn0Sqcw-LajZh=dO=x91HTe4mL2yQ-k5yiGeJ2sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:43700 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756341Ab3DWQoE convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:4:1>);
	Tue, 23 Apr 2013 12:44:04 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.14.3/8.14.3/Debian-9.4) with ESMTP id r3NGc5VA031509
	for <ceph-devel@vger.kernel.org>; Tue, 23 Apr 2013 10:38:06 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 576B444DE9
	for <ceph-devel@vger.kernel.org>; Tue, 23 Apr 2013 10:38:39 -0600 (MDT)
In-Reply-To: <CAF6-1L50V3cn0Sqcw-LajZh=dO=x91HTe4mL2yQ-k5yiGeJ2sg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, pasik@iki.fi, Bernard Grymonpon <bernard@openminds.be>, Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

(Apologies in advance, this is somewhat off-topic from ceph-devel...)
> 
> First off, you need a working blktap setup for your distribution.
> So for example, you should be able to use
> "tap2:tapdisk:aio:/path/to/image.raw"  as a vbd.

So, this works perfectly fine *before* replacing my /usr/sbin/tapdisk2 binary with the one built from the git repo.

> 
> Starting for there you need to :
> 
>  - Download and compile the rbd branch of git://github.com/smunaut/blktap.git
>    You will need the ceph development files/packages for this ( for
> debian librados-dev librbd-dev )
> 
> $ git clone git://github.com/smunaut/blktap.git
> $ cd blktap
> $ git checkout -b rbd origin/rbd
> $ ./autogen.sh
> $ ./configure
> $ make

This goes just fine, no issues here.

> 
>  - Replace the installed tapdisk binary with the new one
> 
> $ sudo cp ./drivers/.libs/tapdisk  /usr/bin/tapdisk

My distro (openSuSE 12.1) has /usr/sbin/tapdisk for original tapdisk v1, and /usr/sbin/tapdisk2 for version 2 stuff.  I'm replacing /usr/sbin/tapdisk2.

> 
>  - Add 'rbd' as supported format in 'xm'
>    For some reason 'xm' checks the image format itself before handing
> off to the tap-ctl ...
> 
>    Edit /usr/lib/xen-4.1/lib/python/xen/xend/server/BlktapController.py
> and add 'rbd' in the blktap2_disk_types list at the top.
>    (location of file will vary depending on xen version and distribution)

Fixed this.

> 
>  - Setup a proper /etc/ceph/ceph.conf containing at least the mon addresses
>    Also make sure you have a /etc/ceph/keyring with the user key if
> you use cephx
> 
> Once that's done, you should be able to attach disk to a running VM using :
> 
> $ xm block-attach test_vm tap2:tapdisk:rbd:rbd/test xvda2 w
> 

After replacing the /usr/sbin/tapdisk2 binary with the newly-built one from the git repo, I'm unable to attach RBD *or* RAW images to a VM.  Here's the error I get upon attempting to start the VM:

Error: ('create', '-aaio:/tmp/small.img') failed (1280  )

This is attempting to just use "tap2:aio" for the image format ("tap2:tapdisk:aio" fails identically, as does "tap2:rbd:rbd/test").  In my /var/log/messages file, I see the following:
Apr 23 10:34:51 se004922 kernel: [ 6328.409708] blktap_control_allocate_tap: allocated tap ffff8807a4898800
Apr 23 10:34:51 se004922 tapdisk[32464]: tapdisk-control: init, 10 x 4k buffers
Apr 23 10:34:51 se004922 tapdisk[32464]: I/O queue driver: lio
Apr 23 10:34:51 se004922 tapdisk[32464]: tapdisk-log: started, level 0
Apr 23 10:34:51 se004922 tapdisk[32464]: nbd: Set up local unix domain socket on path '/var/run/blktap-control/nbdclient32464'
Apr 23 10:34:53 se004922 tapdisk[32464]: ERROR: errno -5 at tapdisk_control_read_message: failure reading message at offset 280/536
Apr 23 10:34:53 se004922 tap-ctl: tap-err:tap_ctl_read_message: failure reading message
Apr 23 10:34:53 se004922 tap-ctl: tap-err:tap_ctl_send_and_receive: failed to receive 'unknown' message

That "nbd" portion is particularly puzzling - why would it try to start nbd when I've specified a simple tap2:aio image?

-Nick



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
