From: Sage Weil <sage@newdream.net>
Subject: Re: FW: crashed+peering PGs
Date: Mon, 18 Jul 2011 10:17:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107181014280.22215@cobra.newdream.net>
References: <zarafa.4e23e05b.16b9.4cfc8d952979a1be@mail.brunner-muc.de>
 <CAO47_-8B0bQiSVeVzig8s4R_T0XXCFu8oC6yH=7OCfdvjo9sGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1409150912-1311009345=:22215"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49622 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab1GRROT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jul 2011 13:14:19 -0400
In-Reply-To: <CAO47_-8B0bQiSVeVzig8s4R_T0XXCFu8oC6yH=7OCfdvjo9sGA@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1107181016260.22215@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1409150912-1311009345=:22215
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1107181016261.22215@cobra.newdream.net>

On Mon, 18 Jul 2011, Christian Brunner wrote:
> >> >> $ ceph pg dump -o - | grep crashed
> >> >> pg_stat objects mip =A0 =A0 degr =A0 =A0unf =A0 =A0 kb =A0 =A0 =A0b=
ytes =A0 log
> >> >> disklog state =A0 v =A0 =A0 =A0 reported =A0 =A0 =A0 =A0up =A0 =A0 =
=A0acting =A0last_scrub
> >> >> 1.1ac =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0=
 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0
> >> >> =A0crashed+peering 0'0 =A0 =A0 5869'576 =A0 =A0 =A0 =A0[3,13] =A0[3=
,13] =A00'0
> >> >> 2011-07-13 17:04:30.221618
> >> >> 0.1ad =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0=
 =A0 =A0 =A0 0 =A0 =A0 =A0 198 =A0 =A0 198
> >> >> =A0crashed+peering 3067'1194 =A0 =A0 =A0 5869'515 =A0 =A0 =A0 =A0[3=
,13] =A0[3,13]
> >> >> 3067'1194 =A0 =A0 =A0 2011-07-13 17:04:29.221726
> >> >> 2.1ab =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0=
 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0
> >> >> =A0crashed+peering 0'0 =A0 =A0 5869'576 =A0 =A0 =A0 =A0[3,13] =A0[3=
,13] =A00'0
> >> >> 2011-07-13 17:04:31.222145
> >> >> 1.6c =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0
> >> >> =A0crashed+peering 0'0 =A0 =A0 5869'577 =A0 =A0 =A0 =A0[3,13] =A0[3=
,13] =A00'0
> >> >> 2011-07-13 17:05:35.237286
> >> >> 0.6d =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 0 =A0 =A0 =A0 0 =A0 =A0 =A0 198 =A0 =A0 198
> >> >> =A0crashed+peering 3067'636 =A0 =A0 =A0 =A05869'516 =A0 =A0 =A0 =A0=
[3,13] =A0[3,13]
> >> >> 3067'636 =A0 =A0 =A0 =A02011-07-13 17:05:34.237024
> >> >> 2.6b =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0
> >> >> =A0crashed+peering 0'0 =A0 =A0 5869'577 =A0 =A0 =A0 =A0[3,13] =A0[3=
,13] =A00'0
> >> >> 2011-07-13 17:05:37.238474
> >
> > Strange, none of these PGs show up in those logs. =A0Can you do
> >
> > ceph pg map 1.1ac
> >
> > for each PG and see where the current CRUSH map thinks they should be
> > stored? =A0That would be the node to look for them on. =A0You may also =
want to
> > look for $osd_data/current/$pgid_head on all the OSDs to see where the
> > copies are.
> >
> > The location in the pg dump (from the monitors PGMap) is just the last
> > reported location. =A0Primaries for each PG normally send stats updates
> > several times a minute for each PG that is touched (and less frequently
> > for those that are not). =A0So it's not necessarily bad that it doesn't
> > match... but it is strange that no surviving copy is reporting updated
> > information.
>=20
> pg dump matches the data from pg map:
>=20
> 2011-07-18 09:41:02.340371 mon <- [pg,map,1.1ac]
> 2011-07-18 09:41:02.410063 mon0 -> 'osdmap e6517 pg 1.1ac (1.1ac) ->
> up [3,13] acting [3,13]' (0)
> 2011-07-18 09:41:02.434859 mon <- [pg,map,0.1ad]
> 2011-07-18 09:41:02.435546 mon1 -> 'osdmap e6517 pg 0.1ad (0.1ad) ->
> up [3,13] acting [3,13]' (0)
> 2011-07-18 09:41:02.442316 mon <- [pg,map,2.1ab]
> 2011-07-18 09:41:02.442839 mon1 -> 'osdmap e6517 pg 2.1ab (2.1ab) ->
> up [3,13] acting [3,13]' (0)
> 2011-07-18 09:41:02.449131 mon <- [pg,map,1.6c]
> 2011-07-18 09:41:02.449679 mon2 -> 'osdmap e6517 pg 1.6c (1.6c) -> up
> [3,13] acting [3,13]' (0)
> 2011-07-18 09:41:02.455090 mon <- [pg,map,0.6d]
> 2011-07-18 09:41:02.455429 mon0 -> 'osdmap e6517 pg 0.6d (0.6d) -> up
> [3,13] acting [3,13]' (0)
> 2011-07-18 09:41:02.461530 mon <- [pg,map,2.6b]
> 2011-07-18 09:41:02.462012 mon2 -> 'osdmap e6517 pg 2.6b (2.6b) -> up
> [3,13] acting [3,13]' (0)
>=20
> I've also looked at the filesystem: $pgid_head directories do neither
> exist on osd003 nor on osd013.

Does it exist on any other nodes?

Did the osd crash you mentioned happen at the end (when you started seeing=
=20
these 6 pgs misbehave), or did it recover fully after that, and only do=20
this after a later OSD was reformatted?

sage

>=20
> I supect that the PGs are empty because they belong to a pool that we
> don't use, as we use ceph for rbd exclusive.
>=20
> Regards,
> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1409150912-1311009345=:22215--
