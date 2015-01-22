From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] ceph: rbd option listing and tcp_nodelay support
Date: Thu, 22 Jan 2015 17:28:47 +0300
Message-ID: <CALFYKtAu-h86KL6A5o9tLyKo7UW=K_3Tv0aC4=hyhhR0Qd7X9w@mail.gmail.com>
References: <alpine.DEB.2.10.1501220029310.28090@Ubuntu-VirtualBox>
	<CALFYKtCn-gGfjZ0qnjRoiS_ksX2KC4PJMcLO0gW5znXgbVAQgg@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2827C9AA@SACMBXIP02.sdcorp.global.sandisk.com>
	<CALFYKtAJ5RiwkEiUGD=oVFzC+Rtor9pF7R4_L9Di9Zg4THCviA@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2827C9E0@SACMBXIP02.sdcorp.global.sandisk.com>
	<CALFYKtDazJJ6mXHu26qBe=ygXuX3VQGVmxs5pJ90hnu2ns+10Q@mail.gmail.com>
	<9E914F5BD7F48A4782456CEB550A42280A75FDDB@SACMBXIP01.sdcorp.global.sandisk.com>
	<CALFYKtDT2Eka6j6dKL-ev3mhVQcT+S7GC79eHac1S7r8nMUEcg@mail.gmail.com>
	<9E914F5BD7F48A4782456CEB550A42280A75FE4C@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:54522 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbbAVO2s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jan 2015 09:28:48 -0500
Received: by mail-qg0-f43.google.com with SMTP id e89so1373566qgf.2
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jan 2015 06:28:47 -0800 (PST)
In-Reply-To: <9E914F5BD7F48A4782456CEB550A42280A75FE4C@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@inktank.com>, Chaitanya Huilgol <chaitanya.huilgol@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jan 22, 2015 at 4:33 PM, Chaitanya Huilgol
<Chaitanya.Huilgol@sandisk.com> wrote:
> Ok, I think for now we should first get the core feature support in, if the changes in the messenger layer look fine, then I will generate two patches
> -  messenger specific options
> - tcp_nodelay support
>
> As a next set we can implement the  krbd_default_map_options in the ceph.conf and pass it down.
>
> Let me know.

Honestly, I don't see the point of splitting options the way you did
either.  There is just too much boilerplate for something as simple as
couple of flags: a struct with a single field to which ceph_messenger
then has a pointer, all the msgr opt macros (why?), the fact that
libceph options are now split between libceph.h and messenger.h, etc.

I'd just pass struct ceph_options * to ceph_messenger_init() and be
done with it.

Thanks,

                Ilya
