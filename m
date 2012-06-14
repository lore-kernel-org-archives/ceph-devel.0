From: Sage Weil <sage@inktank.com>
Subject: Re: auth settings
Date: Wed, 13 Jun 2012 17:26:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206131723570.16470@cobra.newdream.net>
References: <Pine.LNX.4.64.1206130839450.25437@cobra.newdream.net>
 <efb7513b-6ec6-4347-adac-9fc7890cbd09@email.android.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1573542372-1339633588=:16470"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59862 "EHLO
	cobra.newdream.net" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752870Ab2FNA1T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jun 2012 20:27:19 -0400
In-Reply-To: <efb7513b-6ec6-4347-adac-9fc7890cbd09@email.android.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaopong Tran <xiaopong.tran@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1573542372-1339633588=:16470
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 14 Jun 2012, Xiaopong Tran wrote:
> Cool.  Will that be merged into master and ready for 0.48 as well=FF=FF
>=20
> cheers
>=20
> Xiaopong

Unfortunately this will to make it into 0.48.  It needs more careful=20
testing to make sure we are handling the range of cases correctly, and=20
there isn't enough time for that.

We do encourage you to enable auth with 'auth supported =3D cephx' in your=
=20
configs, though; this will make the upgrade when auth is eventually=20
enabled by default painless.

sage

>=20
>=20
> Sage Weil <sage@inktank.com> wrote:
>=20
> >The wip-auth branch has a revamp of the authentication settings.=20
> >Currently, there is a single option, 'auth supported', which is an
> >ordered=20
> >list of authentication methods (cephx or none) to use.  This is
> >somewhat=20
> >limiting
> >
> >This branch replaces that with 3 new settings:
> >
> >auth cluster required -- authentication method(s) required between ceph
> >    cluster daemons (e.g., mds to mds, mds to mon, etc.)
> > auth service required -- auth method(s) required by daemons of clients
> > auth client required  -- what clients require of daemons
> >
> >This lets you do a few things:
> >
> >- Require the cluster to internally use authentication, so that nobody
> >can
> >impersonate an osd or monitor.  You could still leave auth off for
> >clients
> >   if you don't want to deal with distributing keys to users.
> >- Make the cluster require that clients authentication, but let the
> >clients =20
> >   connect to whatever.
> >
> >For compatibility, the idea is that these are all blank by default, and
> >in=20
> >that case default to the deprecated 'auth supported' option that many
> >are=20
> >already using to enable cephx across the board. =20
> >
> >There's also some preliminary docs on what cephx gets you and what it=20
> >doesn't, and on how to enable authentication on a cluster without it.
> >
> >This gets us one step closer to enabling auth by default...
> >
> >sage
> >--
> >To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1573542372-1339633588=:16470--
