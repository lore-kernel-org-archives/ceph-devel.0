From: Jerker Nyberg <jerker@Update.UU.SE>
Subject: Re: Designing a cluster guide
Date: Thu, 24 May 2012 10:33:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205240900570.15565@Psilocybe.Update.UU.SE>
References: <4FB75BAD.3080709@profihost.ag> <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
 <CAMvP8PDRUTO8M0=4MvjDtEtUM7aKePOWvGRFiJA1onu4VgXHPw@mail.gmail.com>
 <CAMwB3TicLaW54wAyZZ=-V7nY-DX0igU8XDh+ZRw_WuK0juH15A@mail.gmail.com>
 <7111C6286D862F43B94FD6291D8989158644DD@EX01.onqtel.local>
 <CAPYLRzgyyW5N894X1T=-gNyRdPmu-+VDr0=NuuLVEs93nGJZbw@mail.gmail.com>
 <Pine.LNX.4.64.1205220852290.15565@Psilocybe.Update.UU.SE>
 <296E2D5FBD414EAEACB9E345FF676519@inktank.com>
 <Pine.LNX.4.64.1205230859410.15565@Psilocybe.Update.UU.SE>
 <CAPYLRzhaMMibth51pFLihCH1P0f5h7V2BO-281g5GXECNno6CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-293463789-119365053-1337848412=:15565"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:42701 "EHLO
	Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2EXIdf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 04:33:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by Psilocybe.Update.UU.SE (Postfix) with ESMTP id 9328C3006C
	for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 10:33:32 +0200 (CEST)
In-Reply-To: <CAPYLRzhaMMibth51pFLihCH1P0f5h7V2BO-281g5GXECNno6CA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---293463789-119365053-1337848412=:15565
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 23 May 2012, Gregory Farnum wrote:

> On Wed, May 23, 2012 at 12:47 PM, Jerker Nyberg <jerker@update.uu.se> wrote:
>
>>  * Scratch file system for HPC. (kernel client)
>>  * Scratch file system for research groups. (SMB, NFS, SSH)
>>  * Backend for simple disk backup. (SSH/rsync, AFP, BackupPC)
>>  * Metropolitan cluster.
>>  * VDI backend. KVM with RBD.
>
> Hmm. Sounds to me like scratch filesystems would get a lot out of not
> having to hit disk on the commit, but not much out of having separate
> caching locations versus just letting the OSD page cache handle it. :)
> The others, I don't really see collaborative caching helping much either.

Oh, sorry, those were my use cases for ceph in general. Yes, scratch is 
mosty of interest. But also fast backup. Currently IOPS is limiting our 
backup speed on a small cluster with many files but not much data. I have 
problems scanning through and backing all changed files every night. 
Currently I am backing to ZFS but Ceph might help with scaling up 
performance and size. Another option is going for SSD instead of 
mechanical drives.

> Anyway, make a bug for it in the tracker (I don't think one exists
> yet, though I could be wrong) and someday when we start work on the
> filesystem again we should be able to get to it. :)

Thank you for your thoughts on this. I hope to be able to do that soon.

Regards,
Jerker Nyberg, Uppsala, Sweden.
---293463789-119365053-1337848412=:15565--
