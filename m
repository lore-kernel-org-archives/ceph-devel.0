From: Jerker Nyberg <jerker@Update.UU.SE>
Subject: Re: Designing a cluster guide
Date: Wed, 23 May 2012 21:47:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205230859410.15565@Psilocybe.Update.UU.SE>
References: <4FB75BAD.3080709@profihost.ag> <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
 <CAMvP8PDRUTO8M0=4MvjDtEtUM7aKePOWvGRFiJA1onu4VgXHPw@mail.gmail.com>
 <CAMwB3TicLaW54wAyZZ=-V7nY-DX0igU8XDh+ZRw_WuK0juH15A@mail.gmail.com>
 <7111C6286D862F43B94FD6291D8989158644DD@EX01.onqtel.local>
 <CAPYLRzgyyW5N894X1T=-gNyRdPmu-+VDr0=NuuLVEs93nGJZbw@mail.gmail.com>
 <Pine.LNX.4.64.1205220852290.15565@Psilocybe.Update.UU.SE>
 <296E2D5FBD414EAEACB9E345FF676519@inktank.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-293463789-83196304-1337756467=:15565"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:48574 "EHLO
	Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141Ab2EWTrG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 15:47:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by Psilocybe.Update.UU.SE (Postfix) with ESMTP id 41FA43006C
	for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 21:47:03 +0200 (CEST)
In-Reply-To: <296E2D5FBD414EAEACB9E345FF676519@inktank.com>
Content-ID: <Pine.LNX.4.64.1205230901190.15565@Psilocybe.Update.UU.SE>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---293463789-83196304-1337756467=:15565
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.1205230901191.15565@Psilocybe.Update.UU.SE>

On Tue, 22 May 2012, Gregory Farnum wrote:

> Direct users of the RADOS object store (i.e., librados) can do all kinds 
> of things with the integrity guarantee options. But I don't believe 
> there's currently a way to make the filesystem do so ÿÿ among other 
> things, you're running through the page cache and other writeback caches 
> anyway, so it generally wouldn't be useful except when running an fsync 
> or similar. And at that point you probably really want to not be lying 
> to the application that's asking for it.

I am comparing with in-memory databases. If replication and failovers are 
used, couldn't in-memory in some cases be good enough? And faster.

> do you have a use case on Ceph?

Currently of interest:

  * Scratch file system for HPC. (kernel client)
  * Scratch file system for research groups. (SMB, NFS, SSH)
  * Backend for simple disk backup. (SSH/rsync, AFP, BackupPC)
  * Metropolitan cluster.
  * VDI backend. KVM with RBD.

Regards,
Jerker Nyberg, Uppsala, Sweden.
---293463789-83196304-1337756467=:15565--
