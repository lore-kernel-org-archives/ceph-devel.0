From: Sage Weil <sage@newdream.net>
Subject: RE: [PATCH] ceph: rbd option listing and tcp_nodelay support
Date: Thu, 22 Jan 2015 06:40:27 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501220639460.13723@cobra.newdream.net>
References: <alpine.DEB.2.10.1501220029310.28090@Ubuntu-VirtualBox> <CALFYKtCn-gGfjZ0qnjRoiS_ksX2KC4PJMcLO0gW5znXgbVAQgg@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2827C9AA@SACMBXIP02.sdcorp.global.sandisk.com> <CALFYKtAJ5RiwkEiUGD=oVFzC+Rtor9pF7R4_L9Di9Zg4THCviA@mail.gmail.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2827C9E0@SACMBXIP02.sdcorp.global.sandisk.com> <CALFYKtDazJJ6mXHu26qBe=ygXuX3VQGVmxs5pJ90hnu2ns+10Q@mail.gmail.com> <9E914F5BD7F48A4782456CEB550A42280A75FDDB@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44230 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbbAVOk2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jan 2015 09:40:28 -0500
In-Reply-To: <9E914F5BD7F48A4782456CEB550A42280A75FDDB@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Chaitanya Huilgol <chaitanya.huilgol@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 22 Jan 2015, Chaitanya Huilgol wrote:
> Hi Ilya,
> 
> We have two options here,
> (1) Have kernel export supported options and pass on supported options from ceph.conf automatically if user has not specified the same via rbd -o - this is what is done in the current patch
> Or
> (2) As suggested by you, Have a default map options in ceph.conf  and pass all options which have not be overridden by rbd -o
> 
> As I understand, there is no need to do both - we need to choose between the two.
> After your suggestion, I am leaning towards option-2 as it give more krbd specific control. However, the onus now rests on the user to add default options based on what the kernel supports (for this we can still provide the options listing via the sysbus interface, say with 'rbd map supported_options' cli)

I also think #2 is simpler and less surprising for the user.  I think we 
can keep it simple!

sage
