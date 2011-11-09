From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 1/4] client: return stripe address replicas
Date: Wed, 9 Nov 2011 14:05:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111091404430.31435@cobra.newdream.net>
References: <1320806361-1801-1-git-send-email-jayhawk@cs.ucsc.edu>
 <1320806361-1801-2-git-send-email-jayhawk@cs.ucsc.edu>
 <CAORUGqDjakCO6X-w-gofZWwiJZf65Lfk2VnV0OaDAZiSDATZXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-761864748-1320876324=:31435"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36182 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864Ab1KIWF2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 17:05:28 -0500
In-Reply-To: <CAORUGqDjakCO6X-w-gofZWwiJZf65Lfk2VnV0OaDAZiSDATZXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-761864748-1320876324=:31435
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 9 Nov 2011, Tommi Virtanen wrote:
> On Tue, Nov 8, 2011 at 18:39, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> > + =A0/* naddr =3D=3D 0: drop through and return actual size */
> > + =A0if (naddr && (address.size() > (unsigned)naddr))
>=20
> I have to say I'm not completely comfortable with the magicness of
> naddr=3D=3D0, mostly because I haven't seen other APIs do it like that.

getxattr(2) and listxattr(2) are the ones I've seen:

"An empty buffer of size zero can be passed into these calls to return the=
=20
current size of the list of extended attribute names, which can be used to=
=20
estimate the size of a buffer which is sufficiently large to hold the list=
=20
of names."


--557981400-761864748-1320876324=:31435--
