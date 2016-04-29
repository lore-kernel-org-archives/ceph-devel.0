From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: ECONNREFUSED implies OSD definitely failed
Date: Fri, 29 Apr 2016 21:02:58 +0200
Message-ID: <20160429190258.GH26146@predictor>
References: <alpine.DEB.2.11.1604221221000.8831@cpach.fuggernut.com>
 <20160428143251.GA1541@suse.de>
 <20160429074639.GG26146@predictor>
 <alpine.DEB.2.11.1604290828520.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:55410 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbcD2TBH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Apr 2016 15:01:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1604290828520.26967@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Lars Marowsky-Bree <lmb@suse.com>, ceph-devel@vger.kernel.org

On Fri, Apr 29, 2016 at 08:29:59AM -0400, Sage Weil wrote:
> On Fri, 29 Apr 2016, Piotr Da=C5=82ek wrote:
> > On Thu, Apr 28, 2016 at 04:32:51PM +0200, Lars Marowsky-Bree wrote:
> > > Exactly this - the system reconfiguring it's network interfaces a=
nd
> > > firewall rules (in a suboptimal fashion; it should drop, not reje=
ct, but
> > > ...).
> >=20
> > I'm not convinced that we should care about this. I think that prob=
ability
> > of (re)connect event occurrence during firewall reconfiguration is =
quite
> > low.
>=20
> Yeah, I tend to agree.
>=20
> Let's just add a config option to control the new behavior so that if=
, for=20
> some reason, there is an environment where this does happen the fast-=
fail=20
> can be disabled.

Sure, that's not a problem.

--=20
Piotr Da=C5=82ek
branch@predictor.org.pl
http://blog.predictor.org.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
