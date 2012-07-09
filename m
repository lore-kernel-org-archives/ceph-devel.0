From: Tommi Virtanen <tv@inktank.com>
Subject: Re: domino-style OSD crash
Date: Mon, 9 Jul 2012 10:43:30 -0700
Message-ID: <CADvuQRFQCrQn3dF=r6VLPo3Q5vBVvCROowa99Rfak=qkbXb0rA@mail.gmail.com>
References: <4FCC7573.3000704@univ-nantes.fr> <CADvuQRF1EUK-iuwd49TJibaSaTN4G6gbCHRvQ3W_e4JoOZ5ODA@mail.gmail.com>
 <CA+4uBUYoDFWcYhmd_EacQgJSf+i=WcA7x-PNWZ0EerD+_fTAjg@mail.gmail.com>
 <4FF2AFEB.1010403@univ-nantes.fr> <CADvuQRFukwLw6cCxxU_AA76=pQS2uVZQBgu47qkJay2DFd0FaQ@mail.gmail.com>
 <4FF35C01.4070400@univ-nantes.fr> <CADvuQRGyp8j=XXStvOFc37Gy7RoWD1AQK5ih-BHudJ8hH7dT7g@mail.gmail.com>
 <4FF3F98C.30602@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44047 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab2GIRnv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 13:43:51 -0400
Received: by pbbrp8 with SMTP id rp8so19560319pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 10:43:51 -0700 (PDT)
In-Reply-To: <4FF3F98C.30602@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Sam Just <sam.just@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 4, 2012 at 1:06 AM, Yann Dupont <Yann.Dupont@univ-nantes.fr> wrote:
> Well, I probably wasn't clear enough. I talked about crashed FS, but i was
> talking about ceph. The underlying FS (btrfs in that case) of 1 node (and
> only one) has PROBABLY crashed in the past, causing corruption in ceph data
> on this node, and then the subsequent crash of other nodes.
>
> RIGHT now btrfs on this node is OK. I can access the filesystem without
> errors.

But the LevelDB isn't. It's contents got corrupted, somehow somewhere,
and it really is up to the LevelDB library to tolerate those errors;
we have a simple get/put interface we use, and LevelDB is triggering
an internal error.

> One node had problem with btrfs, leading first to kernel problem , probably
> corruption (in disk/ in memory maybe ?) ,and ultimately to a kernel oops.
> Before that ultimate kernel oops, bad data has been transmitted to other
> (sane) nodes, leading to ceph-osd crash on thoses nodes.

The LevelDB binary contents are not transferred over to other nodes;
this kind of corruption would not spread over the Ceph clustering
mechanisms. It's more likely that you have 4 independently corrupted
LevelDBs. Something in the workload Ceph runs makes that corruption
quite likely.

The information here isn't enough to say whether the cause of the
corruption is btrfs or LevelDB, but the recovery needs to handled by
LevelDB -- and upstream is working on making it more robust:
http://code.google.com/p/leveldb/issues/detail?id=97
