From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: building boost statically
Date: Fri, 29 Apr 2016 09:01:03 +0200
Message-ID: <20160429070103.GF26146@predictor>
References: <alpine.DEB.2.11.1604281843520.25990@cpach.fuggernut.com>
 <robbat2-20160428T225021-424429122Z@orbis-terrarum.net>
 <alpine.DEB.2.11.1604281908430.25990@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:42342 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751657AbcD2HFP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Apr 2016 03:05:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1604281908430.25990@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Thu, Apr 28, 2016 at 07:14:15PM -0400, Sage Weil wrote:
> On Thu, 28 Apr 2016, Robin H. Johnson wrote:
> > If support for statically linking a newer Boost is brought it, plea=
se,
> > please keep dynamic boost builds as fully supported, for distributi=
ons
> > that can keep up to date. As a bonus, at some point in the future, =
when
> > the slower distributions catch up, you might be able to escape the
> > static again.
>=20
> Yeah, having the option to either build statically or dynamically aga=
inst=20
> an up-to-date distro is probably the right carrot/stick combination t=
o=20
> incentivize the distros to move to a newer boost.

Plus, final binary sizes would be smaller if dynamic linking would succ=
eed.
=20
> Being able to conditionally not use the new stuff (e.g., typedef=20
> small_vector<> back to vector<>) may or may not work well, depending =
on=20
> which new thing we're trying to use.

That's bad idea, IMHO.
Why not check for features we need on configure state and use static or
dynamic accordingly?

--=20
Piotr Da=C5=82ek
branch@predictor.org.pl
http://blog.predictor.org.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
