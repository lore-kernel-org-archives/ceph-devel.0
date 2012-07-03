From: Tommi Virtanen <tv@inktank.com>
Subject: Re: domino-style OSD crash
Date: Tue, 3 Jul 2012 14:38:47 -0700
Message-ID: <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com>
 <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com>
 <4FF2AFEB.1010403@univ-nantes.fr> <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com>
 <4FF35C01.4070400@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56909 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab2GCVjH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 17:39:07 -0400
Received: by pbbrp8 with SMTP id rp8so9865000pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 14:39:07 -0700 (PDT)
In-Reply-To: <4FF35C01.4070400@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Sam Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 3, 2012 at 1:54 PM, Yann Dupont <Yann.Dupont@univ-nantes.fr> wrote:
> In the case I could repair, do you think a crashed FS as it is right now is
> valuable for you, for future reference , as I saw you can't reproduce the
> problem ? I can make an archive (or a btrfs dump ?), but it will be quite
> big.

At this point, it's more about the upstream developers (of btrfs etc)
than us; we're on good terms with them but not experts on the on-disk
format(s). You might want to send an email to the relevant mailing
lists before wiping the disks.
