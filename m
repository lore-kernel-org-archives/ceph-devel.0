From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Re: bobtail timing
Date: Thu, 1 Nov 2012 03:12:46 +0000
Message-ID: <20121101031246.fcc80a63e2506af3fcaa9dda@ist.utl.pt>
References: <alpine.DEB.2.00.1210311341580.20646@cobra.newdream.net>
	<CAPrxi59Mcsm4zeJLL=WXQy9qyiBQ=JC6htOi9KN4Wmx7T8RnBQ@mail.gmail.com>
	<alpine.DEB.2.00.1210311436230.20646@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.ist.utl.pt ([193.136.128.21]:51373 "EHLO smtp1.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756872Ab2KADMv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 31 Oct 2012 23:12:51 -0400
In-Reply-To: <alpine.DEB.2.00.1210311436230.20646@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org


On Wed, 31 Oct 2012 14:38:28 -0700 (PDT) Sage Weil <sage@inktank.com> w=
rote:
> On Wed, 31 Oct 2012, Noah Watkins wrote:
> > Which branch is the freeze taken against? master?
>=20
> Right.  Basically, every 3-4 weeks:
>=20
>  - next is tagged as v0.XX
>    - and is merged back into master
>  - next branch is reset to current master
>  - testing branch is reset to just-tagged v0.XX
>=20

 Hmm, interesting. But doesn't that mean that when the real v0.XX is
later officially _released_, its top commit might not be the commit
that was tagged as v0.XX? Assuming that issues are found after the
testing branch is reset to v0.XX, fixes would go on top of v0.XX, right=
?

 Am I missing something, or people checking out a v0.XX with git might
not be getting the real v0.XX that was released as tarballs?

Thanks

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
