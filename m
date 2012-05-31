From: Sage Weil <sage@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 09:29:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205310928550.28422@cobra.newdream.net>
References: <4FBE415E.8030702@profihost.ag> <4FC54CDB.1000506@inktank.com>
 <4FC5BF27.5060704@profihost.ag> <CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com>
 <4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com>
 <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag>
 <4FC62BB0.1020003@inktank.com> <4FC66A1F.1080407@profihost.ag>
 <CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com>
 <4FC68CAA.9030708@profihost.ag> <CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com>
 <4FC7197D.5010406@profihost.ag> <CAC-hyiFjRFLVHYUKv8bGG0u8u2ZrHgP78U2Txt+3R7GGwtopZA@mail.gmail.com>
 <4FC77045.6050907@univ-nantes.fr> <4FC77407.1050401@profihost.ag>
 <4FC775F3.8080109@univ-nantes.fr> <4FC78339.10900@univ-nantes.fr>
 <4FC78EFF.1090206@inktank.com> <4FC79193.1000604@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1863697350-1338481766=:28422"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33226 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab2EaQ3a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 12:29:30 -0400
In-Reply-To: <4FC79193.1000604@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Mark Nelson <mark.nelson@inktank.com>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Yehuda Sadeh <yehuda@inktank.com>, Stefan Majer <stefan.majer@gmail.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1863697350-1338481766=:28422
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 31 May 2012, Yann Dupont wrote:
> On 31/05/2012 17:32, Mark Nelson wrote:
> > ceph osd pool get<pool>  pg_num
>=20
> My setup is detailed in a previous mail , But as I changed some parameter=
s
> this morning, here we go :
>=20
> root@chichibu:~# ceph osd pool get data pg_num
> PG_NUM: 576
> root@chichibu:~# ceph osd pool get rbd pg_num
> PG_NUM: 576

Can you post 'ceph osd dump | grep ^pool' so we can see which CRUSH rules=
=20
the pools are mapped to?

Thanks!
sage


>=20
>=20
>=20
> The pg num is quite low because I started with small OSD (9 osd with 200G=
 each
> - internal disks) when I formatted. Now, I reduced to 8 osd, (osd.4 is ou=
t)
> but with much larger (& faster) storage.
>=20
>=20
> Now, each of the 8 OSD have 5T on it, I try, for the moment, to keep the =
OSD
> similars. Replication is set to 2.
>=20
>=20
> The fs is btrfs formatted with big metadata (-l 64k -n64k), and mounted v=
ia
> space_cache,compress=3Dlzo,nobarrier,noatime.
>=20
> journal is on tmpfs :
>  osd journal =3D /dev/shm/journal
>  osd journal size =3D 6144
>=20
> I know this is dangerous, remember It's NOT a production system for the
> moment.
>=20
> No OSD is full, I don't have much data stored for the moment.
>=20
> Concerning crush map, I'm not using the default one :
>=20
> The 8 nodes are in 3 different locations (some kilometers away). 2 are in=
 1
> place, 2 in another, and the 4 last in the principal place.
>=20
> There is 10G between all the nodes and they are in the same VLAN, no rout=
er
> involved (but there is (negligible ?) latency between nodes)
>=20
> I try to group host together to avoid problem when I loose a location
> (electrical problem, for example). Not sure I really customized the crush=
 map
> as I should have.
>=20
> here is the map :
>  begin crush map
>=20
> # devices
> device 0 osd.0
> device 1 osd.1
> device 2 osd.2
> device 3 osd.3
> device 4 device4
> device 5 osd.5
> device 6 osd.6
> device 7 osd.7
> device 8 osd.8
>=20
> # types
> type 0 osd
> type 1 host
> type 2 rack
> type 3 pool
>=20
> # buckets
> host karuizawa {
>     id -5        # do not change unnecessarily
>     # weight 1.000
>     alg straw
>     hash 0    # rjenkins1
>     item osd.2 weight 1.000
> }
> host hazelburn {
>     id -6        # do not change unnecessarily
>     # weight 1.000
>     alg straw
>     hash 0    # rjenkins1
>     item osd.3 weight 1.000
> }
> rack loire {
>     id -3        # do not change unnecessarily
>     # weight 2.000
>     alg straw
>     hash 0    # rjenkins1
>     item karuizawa weight 1.000
>     item hazelburn weight 1.000
> }
> host carsebridge {
>     id -8        # do not change unnecessarily
>     # weight 1.000
>     alg straw
>     hash 0    # rjenkins1
>     item osd.5 weight 1.000
> }
> host cameronbridge {
>     id -9        # do not change unnecessarily
>     # weight 1.000
>     alg straw
>     hash 0    # rjenkins1
>     item osd.6 weight 1.000
> }
> rack chantrerie {
>     id -7        # do not change unnecessarily
>     # weight 2.000
>     alg straw
>     hash 0    # rjenkins1
>     item carsebridge weight 1.000
>     item cameronbridge weight 1.000
> }
> host chichibu {
>     id -2        # do not change unnecessarily
>     # weight 1.000
>     alg straw
>     hash 0    # rjenkins1
>     item osd.0 weight 1.000
> }
> host glenesk {
>     id -4        # do not change unnecessarily
>     # weight 1.000
>     alg straw
>     hash 0    # rjenkins1
>     item osd.1 weight 1.000
> }
> host braeval {
>     id -10        # do not change unnecessarily
>     # weight 1.000
>     alg straw
>     hash 0    # rjenkins1
>     item osd.7 weight 1.000
> }
> host hanyu {
>     id -11        # do not change unnecessarily
>     # weight 1.000
>     alg straw
>     hash 0    # rjenkins1
>     item osd.8 weight 1.000
> }
> rack lombarderie {
>     id -12        # do not change unnecessarily
>     # weight 4.000
>     alg straw
>     hash 0    # rjenkins1
>     item chichibu weight 1.000
>     item glenesk weight 1.000
>     item braeval weight 1.000
>     item hanyu weight 1.000
> }
> pool default {
>     id -1        # do not change unnecessarily
>     # weight 8.000
>     alg straw
>     hash 0    # rjenkins1
>     item loire weight 2.000
>     item chantrerie weight 2.000
>     item lombarderie weight 4.000
> }
>=20
> # rules
> rule data {
>     ruleset 0
>     type replicated
>     min_size 1
>     max_size 10
>     step take default
>     step chooseleaf firstn 0 type host
>     step emit
> }
> rule metadata {
>     ruleset 1
>     type replicated
>     min_size 1
>     max_size 10
>     step take default
>     step chooseleaf firstn 0 type host
>     step emit
> }
> rule rbd {
>     ruleset 2
>     type replicated
>     min_size 1
>     max_size 10
>     step take default
>     step chooseleaf firstn 0 type host
>     step emit
> }
>=20
> # end crush map
>=20
> Hope it helps,
> cheers
>=20
>=20
> --=20
> Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
> Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1863697350-1338481766=:28422--
