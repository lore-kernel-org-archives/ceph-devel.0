From: Gregory Farnum <greg@inktank.com>
Subject: Re: Designing a cluster guide
Date: Tue, 22 May 2012 22:31:57 -0700
Message-ID: <296E2D5FBD414EAEACB9E345FF676519@inktank.com>
References: <4FB75BAD.3080709@profihost.ag>
 <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>
 <CAMvP8PDRUTO8M0=4MvjDtEtUM7aKePOWvGRFiJA1onu4VgXHPw@mail.gmail.com>
 <CAMwB3TicLaW54wAyZZ=-V7nY-DX0igU8XDh+ZRw_WuK0juH15A@mail.gmail.com>
 <7111C6286D862F43B94FD6291D8989158644DD@EX01.onqtel.local>
 <CAPYLRzgyyW5N894X1T=-gNyRdPmu-+VDr0=NuuLVEs93nGJZbw@mail.gmail.com>
 <Pine.LNX.4.64.1205220852290.15565@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64923 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab2EWFbp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 01:31:45 -0400
Received: by dady13 with SMTP id y13so9233494dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 22:31:45 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205220852290.15565@Psilocybe.Update.UU.SE>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jerker Nyberg <jerker@update.uu.se>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Tuesday, May 22, 2012 at 2:04 AM, Jerker Nyberg wrote:
> On Mon, 21 May 2012, Gregory Farnum wrote:
> =20
> > This one the write is considered "safe" once it is on-disk on all
> > OSDs currently responsible for hosting the object.
> =20
> =20
> =20
> Is it possible to configure the client to consider the write successf=
ul =20
> when the data is hitting RAM on all the OSDs but not yet committed to=
 =20
> disk?

Direct users of the RADOS object store (i.e., librados) can do all kind=
s of things with the integrity guarantee options. But I don't believe t=
here's currently a way to make the filesystem do so =E2=80=94 among oth=
er things, you're running through the page cache and other writeback ca=
ches anyway, so it generally wouldn't be useful except when running an =
fsync or similar. And at that point you probably really want to not be =
lying to the application that's asking for it.

> Also, the IBM zFS research file system is talking about cooperative c=
ache =20
> and Lustre about a collaborative cache. Do you have any thoughts of t=
his =20
> regarding Ceph?

I haven't heard of this before, but assuming I'm understanding my brief=
 read directly, this isn't on the current Ceph roadmap. I sort of see h=
ow it's useful, but I think it's less useful for a system like Ceph =E2=
=80=94 we're more scale-out in terms of CPU and memory correlating with=
 added disk space compared to something like Lustre where the object st=
orage (OST) and the object handlers (OSS) are divorced, and we stripe f=
iles across more servers than I believe Lustre tends to do.
But perhaps I'm missing something =E2=80=94 do you have a use case on C=
eph?
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
