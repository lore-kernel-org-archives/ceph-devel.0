From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to test ?
 :p
Date: Tue, 23 Apr 2013 14:09:35 -0600
Message-ID: <5176961F02000099000F6C70@collaborate.seakr.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
 <51704AF4.7060908@42on.com>
 <CAF6-1L5uhOknmR7O6TtrYoiE6Sqb1FbN1-U2cpDbAR31-i2=5A@mail.gmail.com>
 <67AC8E8B-C295-49EA-BD52-39F06E3C5A37@openminds.be>
 <CAF6-1L50V3cn0Sqcw-LajZh=dO=x91HTe4mL2yQ-k5yiGeJ2sg@mail.gmail.com>
 <517664AD02000099000F6C41@collaborate.seakr.com>
 <CAF6-1L4HPK0A_T-PmsonFCFUmA5ugT8Y_CXmwdG7-erRnfEhSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:45454 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab3DWUJj convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:4:1>);
	Tue, 23 Apr 2013 16:09:39 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.14.3/8.14.3/Debian-9.4) with ESMTP id r3NK92Ve012404
	for <ceph-devel@vger.kernel.org>; Tue, 23 Apr 2013 14:09:03 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 29A9A44DE9
	for <ceph-devel@vger.kernel.org>; Tue, 23 Apr 2013 14:09:37 -0600 (MDT)
In-Reply-To: <CAF6-1L4HPK0A_T-PmsonFCFUmA5ugT8Y_CXmwdG7-erRnfEhSA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Wido den Hollander <wido@42on.com>, pasik@iki.fi, Bernard Grymonpon <bernard@openminds.be>, ceph-devel@vger.kernel.org

>>> On 2013/04/23 at 12:51, Sylvain Munaut <s.munaut@whatever-company.com> wrote: 
> Hi,
> 
>> My distro (openSuSE 12.1) has /usr/sbin/tapdisk for original tapdisk v1, and 
> /usr/sbin/tapdisk2 for version 2 stuff.  I'm replacing /usr/sbin/tapdisk2.
> 
> Mm, do you know where I could find the source for those tapdisk binaries ?

It looks to me like openSuSE is just using the blktap stuff included with the Xen source code.  If I grab the xen 4.1.4 tarball from xen.org and unpack it, go to tools, there are two directories "blktap" and "blktap2" under that directory that generate the tapdisk and tapdisk2 binaries, along with several other tapdisk-related binaries.  openSuSE uses this with a few minor patches.

> 
> 
>> This is attempting to just use "tap2:aio" for the image format 
> ("tap2:tapdisk:aio" fails identically, as does "tap2:rbd:rbd/test").  In my 
> /var/log/messages file, I see the following:
>> Apr 23 10:34:51 se004922 kernel: [ 6328.409708] blktap_control_allocate_tap: 
> allocated tap ffff8807a4898800
>> Apr 23 10:34:51 se004922 tapdisk[32464]: tapdisk-control: init, 10 x 4k 
> buffers
>> Apr 23 10:34:51 se004922 tapdisk[32464]: I/O queue driver: lio
>> Apr 23 10:34:51 se004922 tapdisk[32464]: tapdisk-log: started, level 0
>> Apr 23 10:34:51 se004922 tapdisk[32464]: nbd: Set up local unix domain 
> socket on path '/var/run/blktap-control/nbdclient32464'
>> Apr 23 10:34:53 se004922 tapdisk[32464]: ERROR: errno -5 at 
> tapdisk_control_read_message: failure reading message at offset 280/536
>> Apr 23 10:34:53 se004922 tap-ctl: tap-err:tap_ctl_read_message: failure 
> reading message
>> Apr 23 10:34:53 se004922 tap-ctl: tap-err:tap_ctl_send_and_receive: failed to 
> receive 'unknown' message
>>
>> That "nbd" portion is particularly puzzling - why would it try to start nbd 
> when I've specified a simple tap2:aio image?
> 
> The tree I used seem to init some of the NBD logic in all cases (nbd
> is integrated in the core rather than purely in the driver).

Okay, makes sense.

> 
> My guess is that the tree I used is close enough to the debian source
> for it to work with just switching tapdisk, but different from
> opensuse package.
> Can you try to ./configure --prefix=/usr  and then make install ?
> This will replace all the binaries including tap-ctl. If they're in a
> distinct package, you can pre-uninstall the blktap-utils from your
> distro.
> '
> 

I tried doing the --prefix=/usr, but did not do a make install...I'll have to give that a shot and see what happens.  I need to get a test system set up here, since the one I was working on is someone else's workstation and I don't want to completely destroy it :-).

-Nick



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
