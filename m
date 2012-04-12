From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: wip-librbd-caching
Date: Thu, 12 Apr 2012 12:55:05 -0700
Message-ID: <582DBF31C8134214A82602D1ADD97892@dreamhost.com>
References: <4F872D48.6070801@tuxadero.com>
 <Pine.LNX.4.64.1204121240310.21220@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46960 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965875Ab2DLTzI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Apr 2012 15:55:08 -0400
Received: by obbtb18 with SMTP id tb18so3138604obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Apr 2012 12:55:08 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204121240310.21220@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Martin Mailand <martin@tuxadero.com>, ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>

On Thursday, April 12, 2012 at 12:45 PM, Sage Weil wrote:
> On Thu, 12 Apr 2012, Martin Mailand wrote:
> > The other point is, that the cache is not KSM enabled, therefore id=
entical
> > pages will not be merged, could that be changed, what would be the =
downside?
> > =20
> > So maybe we could reduce the memory footprint of the cache, but kee=
p it's
> > performance.
> =20
> =20
> =20
> I'm not familiar with the performance implications of KSM, but the =20
> objectcacher doesn't modify existing buffers in place, so I suspect i=
t's a =20
> good candidate. And it looks like there's minimal effort in enabling =
=20
> it...


But if you're supposed to advise the kernel that the memory is a good c=
andidate, then probably we shouldn't be making that madvise call on eve=
ry buffer (I imagine it's doing a sha1 on each page and then examining =
a tree) =E2=80=94 especially since we (probably) flush all that data ou=
t relatively quickly. And RBD doesn't currently have any information ab=
out whether the data is OS or user data=E2=80=A6 (I guess in future, wi=
th layering, we could call madvise on pages which were read from an und=
erlying gold image.)
Also, TV is wondering if the data is even page-aligned or not? I can't =
recall off-hand.
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
