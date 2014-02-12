From: Sage Weil <sage@inktank.com>
Subject: Re: ceph-brag ready
Date: Wed, 12 Feb 2014 13:35:56 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402121330120.30222@cobra.newdream.net>
References: <78E29451-D203-4B1A-B825-E86894D940FB@enovance.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-729670203-1392240956=:30222"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51531 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbaBLVf4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Feb 2014 16:35:56 -0500
In-Reply-To: <78E29451-D203-4B1A-B825-E86894D940FB@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <sebastien.han@enovance.com>, alfredo.deza@inktank.com, zack.cerza@inktank.com
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-729670203-1392240956=:30222
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Feb 2014, Sebastien Han wrote:
> First implementation of the ceph-brag is ready.
> We have a public repo available here, so can try it out.
>=20
> https://github.com/enovance/ceph-brag

This is great!  Would love to get this into firefly.

I have several suggestions on how we can make the generated output a bit=20
more general and useful, but that's a whole can of worms we can open=20
later.

> However I don=92t have any idea on how to submit this to github.com/cep=
h.
> Can someone help me on that?

From a packaging perspective the simplest thing is to merge it into=20
ceph.git.  That can be done just by rearranging your file structure to=20
align with ceph.git's (put this in src/ceph-brag or ceph-brag) and then=20
add the git tree as a remote and merge to master.

Then we can slot this into the existing packaging files (debian/* and=20
ceph.spec.in) so that a ceph-brag package is generated, or just include=20
this in ceph-common.  I would lean toward the latter just because the=20
client is small.  I guess a server package would be appropriate, though? =
=20
Or use PyPi?  I'll shut up now before Alfredo or Zack start shaking their=
=20
heads.

sage
--557981400-729670203-1392240956=:30222--
