From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: ECONNREFUSED implies OSD definitely failed
Date: Fri, 29 Apr 2016 09:46:39 +0200
Message-ID: <20160429074639.GG26146@predictor>
References: <alpine.DEB.2.11.1604221221000.8831@cpach.fuggernut.com>
 <20160428143251.GA1541@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:48396 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbcD2Hor (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Apr 2016 03:44:47 -0400
Content-Disposition: inline
In-Reply-To: <20160428143251.GA1541@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Apr 28, 2016 at 04:32:51PM +0200, Lars Marowsky-Bree wrote:
> On 2016-04-22T12:24:52, Sage Weil <sweil@redhat.com> wrote:
>=20
> > Piotr has a PR at
> >=20
> > 	https://github.com/ceph/ceph/pull/8558
> >=20
> > that changes the messenger and OSD logic so that if we get an ECONN=
REFUSED=20
> > trying to talk to another OSD we can definitively conclude that the=
 OSD is=20
> > down/failed, without waiting for the normal heartbeat timeout.
> >=20
> > I think this is true in normal networking environments.  My only co=
ncern=20
> > is that there might be cases where the OSD isn't actually down and =
some=20
> > transient network issue could cause ECONNREFUSED.  Like... some=20
> > firewally magic networky thing.  If a transient ECONNREFUSED was po=
ssible,=20
> > it could cause some ugly flapping.
> >=20
> > Can anyone think of something that might cause this?  Even if it is=
=20
> > something obscure, it means we should have a config option to disab=
le this=20
> > new behavior (we probably should anyway).
>=20
> Exactly this - the system reconfiguring it's network interfaces and
> firewall rules (in a suboptimal fashion; it should drop, not reject, =
but
> ...).

I'm not convinced that we should care about this. I think that probabil=
ity
of (re)connect event occurrence during firewall reconfiguration is quit=
e
low.
=20
> Or a duplicate IP address (with a node that isn't running ceph-osd).
> Again, not supposed to happen.

That will cause a lot of other things to fail, and having ceph-osd get
downed faster gives a greater chance of getting someone's attention.=20

--=20
Piotr Da=C5=82ek
branch@predictor.org.pl
http://blog.predictor.org.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
