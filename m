From: Sage Weil <sage@newdream.net>
Subject: Re: crashed+down+peering
Date: Sat, 4 Dec 2010 16:53:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012041651160.28007@cobra.newdream.net>
References: <AANLkTi=qVPB4ouEySHKAbRZLo7YgSyq6MdyY3LkT5JfS@mail.gmail.com>
 <Pine.LNX.4.64.1012021126270.1982@cobra.newdream.net>
 <AANLkTikQkU6xmcvQ52Z=xBZgXubZ67hGAaZfUrqUdaKd@mail.gmail.com>
 <AANLkTinTGHy-SPDNev0wXfgzU5-JR4RYe36fnnF4Pg60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-971282018-1291510408=:28007"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52614 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025Ab0LEAsn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Dec 2010 19:48:43 -0500
In-Reply-To: <AANLkTinTGHy-SPDNev0wXfgzU5-JR4RYe36fnnF4Pg60@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-971282018-1291510408=:28007
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 4 Dec 2010, Christian Brunner wrote:
> >> On Thu, 2 Dec 2010, Christian Brunner wrote:
> >>> We have simulated the simultanious crash of multiple osds in our
> >>> environment. After starting all the cosd again, we have the following
> >>> situation:
> >>>
> >>> 2010-12-02 16:18:33.944436 =A0 =A0pg v724432: 3712 pgs: 1 active, 360=
5
> >>> active+clean, 1 crashed+peering, 46 down+peering, 56
> >>> crashed+down+peering, 3 active+clean+inconsistent; 177 GB data, 365 G=
B
> >>> used, 83437 GB / 83834 GB avail; 1/93704 degraded (0.001%)
> >>>
> >>> When I set of an "rbd rm" command for one of our rbd volumes, it seem=
s
> >>> to hit the the "crashed+down+peering" pg. After that the command is
> >>> stuck.
> >>
> >> The pg isn't active, so any IO will hang until peering completes. =A0W=
hat
> >> version of the code are you running? =A0If it's something from unstabl=
e
> >> from the last couple of weeks it's probably related to problems there;
> >> please upgrade and restart the osds. =A0If it's the latest and greates=
t
> >> 'rc', we should look at the logs to see what's going on!
> >
> > We are running 0.23 - I will upgrade to the latest 'rc' tomorrow.
>=20
> Upgrading to the latest rc version worked well. Everything is working
> again and all, except one pg are "active+clean". However there is one
> pg marked as "active+clean+inconsistent".
>=20
> What can I do about an inconsistent group? I general a short
> description of the possible pg states would be helpful.

If a scrub detects an issue it marks the PG inconsistent.  THe idea is you=
=20
can then do

 # ceph pg repair 1.123

to re-scrub and repair.  Make sure you have the latest 'rc' before you do=
=20
that, though, as I just fixed an issue there yesterday.  And keep in mind=
=20
the repair code is not well tested.  You may want to re-scrub first (ceph=
=20
pg scrub 1.123) and watch the log (ceph -w) to see what the inconsistency=
=20
actually is.

sage
--557981400-971282018-1291510408=:28007--
