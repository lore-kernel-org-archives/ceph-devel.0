From: =?windows-1252?Q?Christian_Brunner?= <chb@muc.de>
Subject: AW: qemu-kvm/rbd: first attempt to implement aio
Date: Fri, 16 Apr 2010 22:53:26 +0200
Message-ID: <vmime.4bc8ce46.7b48.29f201574f35f6c1@lvps80-237-162-219.dedicated.hosteurope.de>
References: <20100415202439.GA8005@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.brunner-muc.de ([80.237.162.219]:57596 "EHLO
	mail.brunner-muc.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414Ab0DPVT4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Apr 2010 17:19:56 -0400
In-Reply-To: <r2va37615151004151709wef84ae66hed2dc4d713c94c14@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?windows-1252?Q?Yehuda_Sadeh_Weinraub?= <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

> Yeah, it looks like the rados aio interface is racy. You should be
> able to first set aio completion and only then to do the read/write
> and not the other way around as it is now. I've just pushed a fix to
> the unstable branch that changes the interface a bit. Now you first
> need to do a rados_aio_create_completion() first and use it in the
> rados_aio_read()/write() call. Note that I haven't tested it yet, so
> let me know if there's any problem.
>
> Thanks,
> Yehuda

Thank you - the race condition seems to be fixed. 

I'm still experiencing some cases where the callback function is being
called a few hundred times, but I've to dig into this a little bit,
before I can tell about it.

Christian



