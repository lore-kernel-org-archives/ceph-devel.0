From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: qemu-kvm/rbd: first attempt to implement aio
Date: Thu, 15 Apr 2010 17:09:45 -0700
Message-ID: <r2va37615151004151709wef84ae66hed2dc4d713c94c14@mail.gmail.com>
References: <20100414204907.GA976@ncolin.muc.de>
	 <20100415202439.GA8005@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55612 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758114Ab0DPAJq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Apr 2010 20:09:46 -0400
Received: by vws5 with SMTP id 5so514144vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 15 Apr 2010 17:09:45 -0700 (PDT)
In-Reply-To: <20100415202439.GA8005@ncolin.muc.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Thu, Apr 15, 2010 at 1:24 PM, Christian Brunner <chb@muc.de> wrote:
> To increase the performance of the qemu rbd driver I started to implement
> aio functions. Attached is an intial aio implementation. However it is
> missing the callback of rados_aio_read or _write from time to time.
> This leads to a lockup of the disk driver until the guest OS is
> perfomring a bus reset.
>
> If someone has an explanation for the cause of the lost callbacks. I
> would be happy.
>

Yeah, it looks like the rados aio interface is racy. You should be
able to first set aio completion and only then to do the read/write
and not the other way around as it is now. I've just pushed a fix to
the unstable branch that changes the interface a bit. Now you first
need to do a rados_aio_create_completion() first and use it in the
rados_aio_read()/write() call. Note that I haven't tested it yet, so
let me know if there's any problem.


Thanks,
Yehuda
