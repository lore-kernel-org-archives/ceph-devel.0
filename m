From: Tommi Virtanen <tv@inktank.com>
Subject: Re: domino-style OSD crash
Date: Mon, 9 Jul 2012 12:48:56 -0700
Message-ID: <CADvuQRHzygdWL6Pjd6G0eqTD9S4tRbb_NYS+3ZpH+7WcUfXZWg@mail.gmail.com>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com>
 <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com>
 <4FF2AFEB.1010403@univ-nantes.fr> <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com>
 <4FF35C01.4070400@univ-nantes.fr> <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com>
 <4FF3F98C.30602@univ-nantes.fr> <CADvuQRFQCrQn3dF=r6VLPo3Q5vBVvCROowa99Rfak=qkbXb0rA@mail.gmail.com>
 <4FFB2B60.5000201@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52024 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab2GITtR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 15:49:17 -0400
Received: by yenl2 with SMTP id l2so10492972yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 12:49:17 -0700 (PDT)
In-Reply-To: <4FFB2B60.5000201@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Sam Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jul 9, 2012 at 12:05 PM, Yann Dupont <Yann.Dupont@univ-nantes.fr> wrote:
>> The information here isn't enough to say whether the cause of the
>> corruption is btrfs or LevelDB, but the recovery needs to handled by
>> LevelDB -- and upstream is working on making it more robust:
>> http://code.google.com/p/leveldb/issues/detail?id=97
>
> Yes, saw this. It's very important. Sometimes, s... happens. In respect to
> the size ceph volumes can reach, having a tool to restart damaged nodes (for
> whatever reason) is a must.
>
> Thanks for the time you took to answer. It's much clearer for me now.

If it doesn't recover, you re-format the disk and thereby throw away
the contents. Not really all that different from handling hardware
failure. That's why we have replication.
