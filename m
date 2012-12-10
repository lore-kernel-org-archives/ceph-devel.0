From: Gregory Farnum <greg@inktank.com>
Subject: Re: on disk encryption
Date: Mon, 10 Dec 2012 07:53:18 -0800
Message-ID: <6EACA8977B8949FE9A17B74B37772B4A@inktank.com>
References: <alpine.DEB.2.00.1209150428490.16190@cobra.newdream.net>
 <CANT6BaObaeTF9giuTi-f=2gjW4BUVHyZxRSvETNhunqAta=6FA@mail.gmail.com>
 <50C5A894.8020507@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33796 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab2LJPxX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 10:53:23 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so2124430pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 07:53:23 -0800 (PST)
In-Reply-To: <50C5A894.8020507@ubuntu.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>, Peter Reiher <reiher@inktank.com>
Cc: Dustin Kirkland <dustin.kirkland@gazzang.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Monday, December 10, 2012 at 1:17 AM, James Page wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> =20
> On 19/09/12 02:53, Dustin Kirkland wrote:
> > > > Looking forward, another option might be to implement
> > > > encryption inside btrfs (placeholder fields are there in the
> > > > disk format, introduced along with the compression code way
> > > > back when). This would let ceph-osd handle more of the key
> > > > handling internally and do something like, say, only encrypt
> > > > the current/ and snap_*/ subdirectories.
> > > > =20
> > > > Other ideas? Thoughts?
> > > > =20
> > > > sage
> > I love the idea of btrfs supporting encryption natively much like
> > it does compression. It may be some time before that happens, so
> > in the meantime, I'd love to see Ceph support dm-crypt and/or
> > eCryptfs beneath.
> =20
> =20
> =20
> Has this discussion progressed into any sort of implementation yet?
> It sounds like this is going to be a key feature for users who want
> top-to-bottom encryption of data right down to the block level.


Peter is working on this now =E2=80=94 I'll let him discuss the details=
=2E :)
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
