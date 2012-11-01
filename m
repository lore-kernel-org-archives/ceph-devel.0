From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Re: bobtail timing
Date: Thu, 1 Nov 2012 04:14:11 +0000
Message-ID: <20121101041411.7982294a8fcb09f7057c33a9@ist.utl.pt>
References: <alpine.DEB.2.00.1210311341580.20646@cobra.newdream.net>
	<CAPrxi59Mcsm4zeJLL=WXQy9qyiBQ=JC6htOi9KN4Wmx7T8RnBQ@mail.gmail.com>
	<alpine.DEB.2.00.1210311436230.20646@cobra.newdream.net>
	<20121101031246.fcc80a63e2506af3fcaa9dda@ist.utl.pt>
	<alpine.DEB.2.00.1210312014510.8302@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.ist.utl.pt ([193.136.128.22]:58828 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab2KAEOQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 1 Nov 2012 00:14:16 -0400
In-Reply-To: <alpine.DEB.2.00.1210312014510.8302@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org


On Wed, 31 Oct 2012 20:17:49 -0700 (PDT) Sage Weil <sage@inktank.com> w=
rote:
> On Thu, 1 Nov 2012, Cl?udio Martins wrote:
> > On Wed, 31 Oct 2012 14:38:28 -0700 (PDT) Sage Weil <sage@inktank.co=
m> wrote:
> > > On Wed, 31 Oct 2012, Noah Watkins wrote:
> > > > Which branch is the freeze taken against? master?
> > >=20
> > > Right.  Basically, every 3-4 weeks:
> > >=20
> > >  - next is tagged as v0.XX
> > >    - and is merged back into master
> > >  - next branch is reset to current master
> > >  - testing branch is reset to just-tagged v0.XX
> > >=20
> >=20
> >  Hmm, interesting. But doesn't that mean that when the real v0.XX i=
s
> > later officially _released_, its top commit might not be the commit
> > that was tagged as v0.XX? Assuming that issues are found after the
> > testing branch is reset to v0.XX, fixes would go on top of v0.XX, r=
ight?
> >=20
> >  Am I missing something, or people checking out a v0.XX with git mi=
ght
> > not be getting the real v0.XX that was released as tarballs?
>=20
> The releases and tarballs contain *exactly* the content that is tagge=
d=20
> v0.X.  The branches may accumulate additional fixes after that, which=
=20
> will later be tagged with a v0.X.Y point release.  Since we've starte=
d=20
> maintaing a stable release, we haven't done point releases for=20
> the development 'testing' releases, although if there are important b=
ugs=20
> we may need to do so in the future.
>=20
> The 'stable' branch tracks the last stable release (currently argonau=
t)=20
> and is where bug fixes accumulate until the next release.  For exampl=
e,=20
> stable current contains v0.48.2 and several additional commits (mostl=
y=20
> backports of proviioning scripts to support the ceph-deploy tool that=
=20
> we're working on).
>=20

 Ok, it makes perfect sense now. I wasn't realising that the tarball is
released as soon as the branch is tagged, sorry about that.

Thanks for the clarification.

Best regards

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
