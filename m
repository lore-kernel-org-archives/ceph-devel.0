From: Sage Weil <sage@newdream.net>
Subject: Re: rados pool object listing suckage
Date: Thu, 12 May 2011 11:18:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105121059420.19492@cobra.newdream.net>
References: <Pine.LNX.4.64.1105111445100.14296@cobra.newdream.net>
 <BANLkTi=q+Ksrp_E1Wecyr5BDDym6qndHSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1326747982-1305224292=:19492"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57780 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264Ab1ELSRW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2011 14:17:22 -0400
In-Reply-To: <BANLkTi=q+Ksrp_E1Wecyr5BDDym6qndHSQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1326747982-1305224292=:19492
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 May 2011, Colin McCabe wrote:
> On Wed, May 11, 2011 at 2:57 PM, Sage Weil <sage@newdream.net> wrote:
> > The ability to list objects in rados pools is something we originally
> > added to round out the librados interface and to support the requiremen=
ts
> > of radosgw (S3 and swift both let you list objects in buckets). =A0The
> > current interface is stateless. =A0You iterate over the PGs in the pool=
, and
> > for each one, request up to N objects. =A0The result has up to N result=
s and
> > (optionally) a cookie to continue and get more objects for that pg.
> > Currently, that cookie is a readdir offset from the directory on the
> > server.
> >
> > The problem is that we currently list objects based only on what we hav=
e
> > on disk. =A0If the PG is degraded and we're recovery, we miss any objec=
ts
> > that aren't yet copied locally.
> >
> > Because the 'list all objects in a pool' operation consists of many
> > smaller requests, and there is no state to associate them, it's hard to
> > solve this one correctly. =A0The osd _knows_ which objects are missing =
at
> > all times, but it needs to include those in the results in a sane way.
> >
> > My original thought was use the low 2^63 values of the offset/cookie to
> > represent any (potentially) missing objects and use that as an index in=
to
> > the missing set, and then use the high values to represent the readdir
> > offset. =A0That's easy enough to do (and I just did), but because recov=
ery
> > is progressing while the client is doing the series of list-objects cal=
ls,
> > you can get duplicates (client sees an object while it was missing, and
> > also sees it later when it was on disk). =A0Conversely, if a pg starts =
out
> > as not degraded, we may return no missing objects, and later return an
> > incomplete set of on-disk objects because the primary changed.
> >
> > This approach can be hacked if the client restarts the whole process (f=
or
> > a given pg) when the primary changes (because, for any given pg mapping=
,
> > the missing set will also shrink or stay the same). =A0That will work, =
but
> > will potentially return some objects twice.
>=20
> Can the client keep track of all the objects it has already seen? Then
> it could eliminate dups from the result it gets from the server.
>=20
> You can't track this information on the server because of the obvious
> DDOS exploit, but it seems like the client could keep around this
> state.

So radosgw does that (it has to sort the full list alphanumerically, even,=
=20
blech!).  Objecter and librados don't though, because otherwise any user=20
would incur the overhead of doing the filter step (which involves building=
=20
a set<object_t> and is expensive for a very large pool).

I guess barring anything super clever we haven't thought of, I'm inclined=
=20
to leave dedup as the Objecter/librados user's responsibility.  That's=20
what I committed yesterday.

This is hard because we're sharding the pool contents across multiple PGs=
=20
on different nodes for scalability.  I assume S3 is also sharding bucket=20
contents across multiple nodes, but they always return the object list=20
alphanumerically sorted (!), so there must be a separate index stored=20
centrally somewhere.  That architectural difference makes meeting their=20
API requirement in radosgw expensive.

sage
--557981400-1326747982-1305224292=:19492--
