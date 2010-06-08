From: Sage Weil <sage@newdream.net>
Subject: Re: IPv6 Status
Date: Mon, 7 Jun 2010 21:42:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006072137540.3013@cobra.newdream.net>
References: <AANLkTimTZSGxg-0LFo9BtSJpq74JV-I0V84m7I5DVxCB@mail.gmail.com>
 <AANLkTikUFKCG8KEhbc3wqWRIbciPnIyNgJMSz5GucMj4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-315127405-1275972148=:3013"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47601 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab0FHEl7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jun 2010 00:41:59 -0400
In-Reply-To: <AANLkTikUFKCG8KEhbc3wqWRIbciPnIyNgJMSz5GucMj4@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Roy <imjustmatthew@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-315127405-1275972148=:3013
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Matthew,

On Mon, 7 Jun 2010, Matthew Roy wrote:
> On=A02009-10-02=A0there was a commit "use sockaddr_storage; and some=A0ip=
v6
> support groundwork" but I can't find any references to IPv6 support
> being completed. Did that commit actually complete IPv6 support or are
> more changes still required?
>=20
> Commit diff:
> http://ceph.newdream.net/git/p=3Dceph.git;a=3Dcommitdiff;h=3Ddd732cbfc1c9=
2f0d8dba2743a979baad6685a98c;hp=3D18b3bfc5650be6584c5c95fce447fa66fb918a83

I think all the basic groundwork is there.  The entity_addr_t type used=20
throughout contains a sockaddr_storage, which can hold either ipv4 or ipv6=
=20
addresses, and that commit updated the parsing function to handle v6=20
address syntax.

The last step is just to update msg/SimpleMessenger.cc to actually bind or=
=20
connect an ipv6 socket.  It should be pretty straightforward to fix the=20
various places in the bind(), accept(), and connect() methods to do that,=
=20
particularly if you already have v6 networking set up in your=20
environment.

sage
--557981400-315127405-1275972148=:3013--
