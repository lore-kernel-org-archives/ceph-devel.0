From: Jens Axboe <axboe@kernel.dk>
Subject: Re: fio rbd completions (Was: fio rbd hang for block sizes > 1M)
Date: Mon, 27 Oct 2014 08:15:31 -0600
Message-ID: <544E5383.9010001@kernel.dk>
References: <5449BBB3.7090109@catalyst.net.nz> <5449E50E.7000808@kernel.dk> <5449EEF1.1060407@catalyst.net.nz> <544A51C7.40803@gmail.com> <544A5DA6.2010709@gmail.com> <544AD67D.4030603@catalyst.net.nz> <544AEAE7.6080603@redhat.com> <544AF0D2.1050405@catalyst.net.nz> <544B0C7F.4080109@catalyst.net.nz> <544B1D50.4010101@kernel.dk> <544B2C19.7070009@catalyst.net.nz> <544BF808.2090800@kernel.dk> <544C2371.1020403@catalyst.net.nz> <CAM9_UU_S7qhenZW34Lw3r=RHoVa1__610RRsFScgt0adi1dpFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:64816 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbaJ0OP3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 10:15:29 -0400
Received: by mail-pa0-f50.google.com with SMTP id eu11so5617743pac.9
        for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 07:15:28 -0700 (PDT)
In-Reply-To: <CAM9_UU_S7qhenZW34Lw3r=RHoVa1__610RRsFScgt0adi1dpFw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ketor D <d.ketor@gmail.com>, Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Mark Nelson <mark.nelson@inktank.com>, Mark Nelson <mark.a.nelson@gmail.com>, fio@vger.kernel.org, "xan.peng" <xanpeng@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/27/2014 03:27 AM, Ketor D wrote:
> Hi, Jens:
>           I have test your v2 and v3 patch.
>           The v2 patch get SIGABT and crash. The v3 patch hang.
> 
>          Why not simply comment usleep?

Because that is very inefficient as well, then fio would basically be
busy looping waiting for IO to finish.

-- 
Jens Axboe

