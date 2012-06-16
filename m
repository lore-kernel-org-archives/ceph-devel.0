From: Sage Weil <sage@inktank.com>
Subject: Re: RBD layering design draft
Date: Sat, 16 Jun 2012 08:11:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206160808050.1862@cobra.newdream.net>
References: <4FDB9FBB.9000807@inktank.com> <Pine.LNX.4.64.1206151742380.28086@cobra.newdream.net>
 <CAC-hyiEGzAF=hAae6mZLjOd+5jckVZD6+WfvJHpCYuueDCCX7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1597746000-1339859514=:1862"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60861 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab2FPPL5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Jun 2012 11:11:57 -0400
In-Reply-To: <CAC-hyiEGzAF=hAae6mZLjOd+5jckVZD6+WfvJHpCYuueDCCX7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1597746000-1339859514=:1862
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 15 Jun 2012, Yehuda Sadeh wrote:
> On Fri, Jun 15, 2012 at 5:46 PM, Sage Weil <sage@inktank.com> wrote:
> > Looks good! =A0Couple small things:
> >
> >> =A0 =A0 $ rbd unpreserve pool/image@snap
> >
> > Is 'preserve' and 'unpreserve' the verbiage we want to use here? =A0Not=
 sure
> > I have a better suggestion, but preserve is unusual.
> >
>=20
> freeze, thaw/unfreeze?

Freeze/thaw usually mean something like quiesce I/O or read-only, usually=
=20
temporarily.  What we actaully mean is "you can't delete this".  Maybe=20
pin/unpin?  preserve/unpreserve may be fine, too!

sage
--557981400-1597746000-1339859514=:1862--
