From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] ceph: rbd option listing and tcp_nodelay support
Date: Thu, 22 Jan 2015 18:08:28 +0300
Message-ID: <CALFYKtAeiAta3iEeraBkOTu7bfnXcaoFhweVqL=+ZiEeSukQ-A@mail.gmail.com>
References: <alpine.DEB.2.10.1501220029310.28090@Ubuntu-VirtualBox>
	<CALFYKtCn-gGfjZ0qnjRoiS_ksX2KC4PJMcLO0gW5znXgbVAQgg@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2827C9AA@SACMBXIP02.sdcorp.global.sandisk.com>
	<CALFYKtAJ5RiwkEiUGD=oVFzC+Rtor9pF7R4_L9Di9Zg4THCviA@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2827C9E0@SACMBXIP02.sdcorp.global.sandisk.com>
	<CALFYKtDazJJ6mXHu26qBe=ygXuX3VQGVmxs5pJ90hnu2ns+10Q@mail.gmail.com>
	<9E914F5BD7F48A4782456CEB550A42280A75FDDB@SACMBXIP01.sdcorp.global.sandisk.com>
	<CALFYKtDT2Eka6j6dKL-ev3mhVQcT+S7GC79eHac1S7r8nMUEcg@mail.gmail.com>
	<9E914F5BD7F48A4782456CEB550A42280A75FE4C@SACMBXIP01.sdcorp.global.sandisk.com>
	<CALFYKtAu-h86KL6A5o9tLyKo7UW=K_3Tv0aC4=hyhhR0Qd7X9w@mail.gmail.com>
	<9E914F5BD7F48A4782456CEB550A42280A75FEDC@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:40270 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbbAVPI3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jan 2015 10:08:29 -0500
Received: by mail-qg0-f52.google.com with SMTP id z107so1542934qgd.11
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jan 2015 07:08:28 -0800 (PST)
In-Reply-To: <9E914F5BD7F48A4782456CEB550A42280A75FEDC@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jan 22, 2015 at 5:39 PM, Chaitanya Huilgol
<Chaitanya.Huilgol@sandisk.com> wrote:
> Well, there was no ceph_options pointer in the messenger layer and no=
_crc flag was being passed into the messenger as an additional flag and=
 maintained within the messenger again as bool no_crc, I inferred that =
it was intentional and we did not want the generic options in the messe=
nger layer.  If it is fine to have messenger point back to the ceph_opt=
ions, then that=E2=80=99s the easiest way to do it.
> Also, we would have some additional option coming in with RDMA suppor=
t (xio messenger) which would be very messenger specific, so having a m=
essenger options had made sense.

OK, we'll see how to refactor it nicely then.

Given that tcp_nodelay is just a bool, for now I'd suggest the simplest
and least invasive patch:

- add bool tcp_nodelay field to ceph_messenger
- add bool tcp_nodelay parameter to ceph_messenger_init()
- call ceph_messenger_init() with ceph_test_opt(client, TCP_NODELAY)

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
