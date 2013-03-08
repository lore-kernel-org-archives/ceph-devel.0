From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: [ceph-users] [solved] Changing CRUSH rule on a running cluster
Date: Fri, 08 Mar 2013 14:04:14 +0100
Message-ID: <1362747854.10442.100.camel@boolette.noo>
References: <1362385148.30983.7.camel@localhost>
	 <CAPYLRzj-9Hb=EdOLY6COOHcsKUujRqfCpUHqyp6tWS9UWzvf7Q@mail.gmail.com>
	 <1362559176.30983.43.camel@localhost>
	 <1362727086.10442.2.camel@boolette.noo>
	 <CAHzdKUJX_Nb4rCo6LtuEGqPb9feE4Mixszm-1gt9RzGTrDX_Qw@mail.gmail.com>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:57170 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933875Ab3CHNER convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Mar 2013 08:04:17 -0500
In-Reply-To: <CAHzdKUJX_Nb4rCo6LtuEGqPb9feE4Mixszm-1gt9RzGTrDX_Qw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marco Aroldi <marco.aroldi@gmail.com>
Cc: ceph-devel@vger.kernel.org, ceph-users <ceph-users@ceph.com>

Hi,

yes, the =C2=ABstep chooseleaf firstn 0 type room=C2=BB is correct. My =
problem was
that =C2=ABcrushtool --test=C2=BB was reporting =C2=ABbad mapping=C2=BB=
 PG, and some tests
on an *empty* pool gave me stucked PG in =C2=ABactive+remapped=C2=BB.

After some tests and reading, I saw that :
=C2=AB For large clusters, some small percentages of PGs map to less th=
an the
desired number of OSDs. This is more prevalent when there are several
layers of the hierarchy (e.g., row, rack, host, osd). =C2=BB

cf
http://ceph.com/docs/master/rados/operations/crush-map/?highlight=3Dcru=
sh#impact-of-legacy-values


I don't think my cluster is large (44 OSD referenced), but since I
describe all the 6 physical levels I have
(root=E2=86=92datacenter=E2=86=92room=E2=86=92network=E2=86=92rack=E2=86=
=92host), it seems that I hit that
=C2=ABmisbehavior=C2=BB.

So after testing with =C2=ABcrushtool --test=C2=BB and verifying that I=
 use ceph >
0.49 and linux kernel >=3D 3.6 everywhere, I enabled the =C2=ABcrush_tu=
nables=C2=BB
by following that :=20
http://ceph.com/docs/master/rados/operations/crush-map/?highlight=3Dcru=
sh#tuning-crush-the-hard-way

And it fixed the problem.

Olivier

Le vendredi 08 mars 2013 =C3=A0 09:30 +0100, Marco Aroldi a =C3=A9crit =
:
> Hi Oliver,
>=20
> can you post here on the mailing list the steps taken?
>=20
> From the IRC logs you said "if I use "choose .... osd", it works --
> but "chooseleaf ... host" doesn't work"
>=20
> So, to have data balanced between 2 rooms, is the rule "step
> chooseleaf firstn 0 type room" correct?=20
>=20
>=20
> Thanks
>=20
> --=20
> Marco
>=20
>=20
> 2013/3/8 Olivier Bonvalet <ceph.list@daevel.fr>
>        =20
>         >
>         > Thanks for your answer. So I made some tests on a dedicated
>         spool, I was
>         > able to move data from =C2=ABplatter=C2=BB to =C2=ABSSD=C2=BB=
 very well, it's
>         great.
>         >
>         > But I can't obtain that per "network" neither per "host"
>         setup :
>         > with 2 hosts, each one with 2 OSD, and with a pool with use
>         only 1
>         > replica (so, 2 copies), I tried this rule :
>         >
>         >         rule rbdperhost {
>         >               ruleset 5
>         >               type replicated
>         >               min_size 1
>         >               max_size 10
>         >               step take default
>         >               step chooseleaf firstn 0 type host
>         >               step emit
>         >         }
>         >
>         >
>         > As a result I obtain some PG which stuck in =C2=ABactive
>         +remapped=C2=BB state.
>         > When querying one of this PG, I see that CRUSH find only on=
e
>         OSD up for
>         > this one and can't find an other OSD to set replica.
>         >
>         > If I well understand, in this case the "chooseleaf firstn 0
>         type host"
>         > say to Ceph to choose 2 differents hosts, then in each of
>         them choose
>         > one OSD. So with 2 hosts, it should works, no ?
>         >
>         > Thanks,
>         > Olivier B.
>         >
>         >
>        =20
>         So, as said on IRC, it's solved. My rules were not working,
>         and after
>         use of =C2=ABtunables=C2=BB it's ok.
>        =20
>         I love that feature of changing data spreading on live !
>        =20
>        =20
>         _______________________________________________
>         ceph-users mailing list
>         ceph-users@lists.ceph.com
>         http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20
>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
