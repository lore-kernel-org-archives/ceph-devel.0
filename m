From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] ceph: rbd option listing and tcp_nodelay support
Date: Thu, 22 Jan 2015 19:52:57 +0300
Message-ID: <CALFYKtAKkN+3QWH=RODBdoTXiV1eUaTk4_yF1nE6wrczTcovFQ@mail.gmail.com>
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
	<CALFYKtAeiAta3iEeraBkOTu7bfnXcaoFhweVqL=+ZiEeSukQ-A@mail.gmail.com>
	<9E914F5BD7F48A4782456CEB550A42280A75FF3B@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:43089 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbbAVQw5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jan 2015 11:52:57 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so2170942qcw.9
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jan 2015 08:52:57 -0800 (PST)
In-Reply-To: <9E914F5BD7F48A4782456CEB550A42280A75FF3B@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jan 22, 2015 at 7:48 PM, Chaitanya Huilgol
<Chaitanya.Huilgol@sandisk.com> wrote:
> Ok, will make the changes and send it as a single tcp_nodelay patch. One final clarification, do we want the TCP_NODELAY set by default or only when requested?

On by default I think.

Thanks,

                Ilya
