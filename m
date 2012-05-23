From: Gregory Farnum <greg@inktank.com>
Subject: Re: Designing a cluster guide
Date: Wed, 23 May 2012 14:47:24 -0700
Message-ID: <CAPYLRzhaMMibth51pFLihCH1P0f5h7V2BO-281g5GXECNno6CA@mail.gmail.com>
References: <4FB75BAD.3080709@profihost.ag>
	<8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
	<CAMvP8PDRUTO8M0=4MvjDtEtUM7aKePOWvGRFiJA1onu4VgXHPw@mail.gmail.com>
	<CAMwB3TicLaW54wAyZZ=-V7nY-DX0igU8XDh+ZRw_WuK0juH15A@mail.gmail.com>
	<7111C6286D862F43B94FD6291D8989158644DD@EX01.onqtel.local>
	<CAPYLRzgyyW5N894X1T=-gNyRdPmu-+VDr0=NuuLVEs93nGJZbw@mail.gmail.com>
	<Pine.LNX.4.64.1205220852290.15565@Psilocybe.Update.UU.SE>
	<296E2D5FBD414EAEACB9E345FF676519@inktank.com>
	<Pine.LNX.4.64.1205230859410.15565@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46630 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933288Ab2EWVr0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 17:47:26 -0400
Received: by lbbgm6 with SMTP id gm6so5424590lbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 May 2012 14:47:24 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205230859410.15565@Psilocybe.Update.UU.SE>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jerker Nyberg <jerker@update.uu.se>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, May 23, 2012 at 12:47 PM, Jerker Nyberg <jerker@update.uu.se> w=
rote:
> On Tue, 22 May 2012, Gregory Farnum wrote:
>
>> Direct users of the RADOS object store (i.e., librados) can do all k=
inds
>> of things with the integrity guarantee options. But I don't believe =
there's
>> currently a way to make the filesystem do so =D1=D1 among other thin=
gs, you're
>> running through the page cache and other writeback caches anyway, so=
 it
>> generally wouldn't be useful except when running an fsync or similar=
=2E And at
>> that point you probably really want to not be lying to the applicati=
on
>> that's asking for it.
>
>
> I am comparing with in-memory databases. If replication and failovers=
 are
> used, couldn't in-memory in some cases be good enough? And faster.
>
>
>> do you have a use case on Ceph?
>
>
> Currently of interest:
>
> =9A* Scratch file system for HPC. (kernel client)
> =9A* Scratch file system for research groups. (SMB, NFS, SSH)
> =9A* Backend for simple disk backup. (SSH/rsync, AFP, BackupPC)
> =9A* Metropolitan cluster.
> =9A* VDI backend. KVM with RBD.
Hmm. Sounds to me like scratch filesystems would get a lot out of not
having to hit disk on the commit, but not much out of having separate
caching locations versus just letting the OSD page cache handle it. :)
The others, I don't really see collaborative caching helping much eithe=
r.

So basically it sounds like you want to be able to toggle off Ceph's
data safety requirements. That would have to be done in the clients;
it wouldn't even be hard in ceph-fuse (although I'm not sure about the
kernel client). It's probably a pretty easy way to jump into the code
base.... :)
Anyway, make a bug for it in the tracker (I don't think one exists
yet, though I could be wrong) and someday when we start work on the
filesystem again we should be able to get to it. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
