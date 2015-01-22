From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] ceph: rbd option listing and tcp_nodelay support
Date: Thu, 22 Jan 2015 15:50:15 +0300
Message-ID: <CALFYKtDT2Eka6j6dKL-ev3mhVQcT+S7GC79eHac1S7r8nMUEcg@mail.gmail.com>
References: <alpine.DEB.2.10.1501220029310.28090@Ubuntu-VirtualBox>
	<CALFYKtCn-gGfjZ0qnjRoiS_ksX2KC4PJMcLO0gW5znXgbVAQgg@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2827C9AA@SACMBXIP02.sdcorp.global.sandisk.com>
	<CALFYKtAJ5RiwkEiUGD=oVFzC+Rtor9pF7R4_L9Di9Zg4THCviA@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2827C9E0@SACMBXIP02.sdcorp.global.sandisk.com>
	<CALFYKtDazJJ6mXHu26qBe=ygXuX3VQGVmxs5pJ90hnu2ns+10Q@mail.gmail.com>
	<9E914F5BD7F48A4782456CEB550A42280A75FDDB@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:40574 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbAVMuQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jan 2015 07:50:16 -0500
Received: by mail-qa0-f50.google.com with SMTP id k15so908620qaq.9
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jan 2015 04:50:15 -0800 (PST)
In-Reply-To: <9E914F5BD7F48A4782456CEB550A42280A75FDDB@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@inktank.com>, Chaitanya Huilgol <chaitanya.huilgol@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jan 22, 2015 at 12:54 PM, Chaitanya Huilgol
<Chaitanya.Huilgol@sandisk.com> wrote:
> Hi Ilya,
>
> We have two options here,
> (1) Have kernel export supported options and pass on supported options from ceph.conf automatically if user has not specified the same via rbd -o - this is what is done in the current patch
> Or
> (2) As suggested by you, Have a default map options in ceph.conf  and pass all options which have not be overridden by rbd -o
>
> As I understand, there is no need to do both - we need to choose between the two.
> After your suggestion, I am leaning towards option-2 as it give more krbd specific control. However, the onus now rests on the user to add default options based on what the kernel supports (for this we can still provide the options listing via the sysbus interface, say with 'rbd map supported_options' cli)

And the question then is: do we really need this supported_options cli?
rbd map options are treated very much like filesystem mount options -
the set of supported options is determined by the kernel version and is
documented in rbd(8) man page.

(There aren't any kernel version details in there currently, but that's
simply because all existing options have been added in bulk a long time
ago, and we can fix that omission with the addition of tcp_nodelay.)

Thanks,

                Ilya
