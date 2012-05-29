From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: poor OSD performance using kernel 3.4
Date: Tue, 29 May 2012 21:50:35 +0200
Message-ID: <4FC5288B.5090508@univ-nantes.fr>
References: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro> <4FC49B12.8020004@profihost.ag> <4FC4D1A8.1080001@univ-nantes.fr> <4FC4E0A9.8010008@profihost.ag> <4FC50C4A.4090101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-cha.cpub.univ-nantes.fr ([193.52.103.113]:47489 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754581Ab2E2Tuq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 15:50:46 -0400
In-Reply-To: <4FC50C4A.4090101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, ceph-devel@vger.kernel.org

Le 29/05/2012 19:50, Mark Nelson a =C3=A9crit :
>
> 1 1GbE Client node
> 3 1GbE Mon nodes
> 2 1GbE OSD nodes with 1 OSD on each mounted on a 7200rpm SAS drive. =20
> btrfs with -l 64k -n64k, mounted using noatime.  H700 Raid controller=
=20
> with each drive in a 1 disk raid0.  Journals are partitioned on a=20
> separate drive.
>
Hello ,
=46orgot to mention I'm using 10 Gbe and FS using btrfs with -l 64k -n6=
4k,=20
but also space_cache,compress=3Dlzo,nobarrier,noatime.
journal is on tmpfs :

  osd journal =3D /dev/shm/journal
  osd journal size =3D 6144

Remember It's not a production system for the moment. I'm just trying t=
o=20
evaluate what is the best performance I can get. (and if the system is=20
stable enough to start alpha/pre-production services). BTW, I noticed=20
OSD usings XFS are much much slower than OSD with btrfs right now,=20
particulary in rbd tests. btrfs have some stability problems, even if=20
with newer kernels it seems better.

> /proc/version:
> Linux version 3.4.0-ceph (autobuild-ceph@gitbuilder-kernel-amd64)
>
> rados -p data bench 120 write:
>
> Total time run:        120.601286
> Total writes made:     2979
> Write size:            4194304
> Bandwidth (MB/sec):    98.805
>
> Average Latency:       0.647507
> Max latency:           1.39966
> Min latency:           0.181663
>
> Once I get these nodes up to 0.47 and get them switched over to 10GbE=
=20
> I'll redo the btrfs tests and try out xfs as well with longer running=
=20
> tests.
>
>>> As you can see, much more stable bandwith with this pool.
>> That's pretty strange...
>
> Indeed, that is very strange!  Can you check to see how many pgs are=20
> in each?  Any difference in replication level?  You can check with:
>
> ceph osd pool get <pool> size
root@label5:~# ceph osd pool get data size
don't know how to get pool field size
root@label5:~# ceph osd pool get rbd size
don't know how to get pool field size

Is size the good name of the field ? In the the wiki size isn't listed=20
as a valid field

> ceph osd pool get <pool> pg_num
>
root@label5:~# ceph osd pool get rbd pg_num
PG_NUM: 576
root@label5:~# ceph osd pool get data pg_num
PG_NUM: 576


Th pg num is quite low because I started with small OSD (9 osd with 200=
G=20
each - internal disks) when I formatted. Now, I reduced to 8 osd, (osd.=
4=20
is out) but with much larger (& faster) storage. 6 OSD have 5T on it, 2=
=20
have still 200G but they are planned to migrate before the end of the w=
eek.

I try, for the moment, to keep the OSD similars. Replication is set to =
2.

No OSD is full, I don't have much data stored for the moment.

Concerning crush map, I'm not using the default one :

The 8 nodes are in 3 different locations (some kilometers away). 2 are=20
in 1 place, 2 in another, and the 4 last in the principal place.
I try to group host together to avoid problem when I loose a location=20
(electrical problem, for example). Not sure I really customized the=20
crush map as I should have.

here is the map :
  begin crush map

# devices
device 0 osd.0
device 1 osd.1
device 2 osd.2
device 3 osd.3
device 4 device4
device 5 osd.5
device 6 osd.6
device 7 osd.7
device 8 osd.8

# types
type 0 osd
type 1 host
type 2 rack
type 3 pool

# buckets
host karuizawa {
     id -5        # do not change unnecessarily
     # weight 1.000
     alg straw
     hash 0    # rjenkins1
     item osd.2 weight 1.000
}
host hazelburn {
     id -6        # do not change unnecessarily
     # weight 1.000
     alg straw
     hash 0    # rjenkins1
     item osd.3 weight 1.000
}
rack loire {
     id -3        # do not change unnecessarily
     # weight 2.000
     alg straw
     hash 0    # rjenkins1
     item karuizawa weight 1.000
     item hazelburn weight 1.000
}
host carsebridge {
     id -8        # do not change unnecessarily
     # weight 1.000
     alg straw
     hash 0    # rjenkins1
     item osd.5 weight 1.000
}
host cameronbridge {
     id -9        # do not change unnecessarily
     # weight 1.000
     alg straw
     hash 0    # rjenkins1
     item osd.6 weight 1.000
}
rack chantrerie {
     id -7        # do not change unnecessarily
     # weight 2.000
     alg straw
     hash 0    # rjenkins1
     item carsebridge weight 1.000
     item cameronbridge weight 1.000
}
host chichibu {
     id -2        # do not change unnecessarily
     # weight 1.000
     alg straw
     hash 0    # rjenkins1
     item osd.0 weight 1.000
}
host glenesk {
     id -4        # do not change unnecessarily
     # weight 1.000
     alg straw
     hash 0    # rjenkins1
     item osd.1 weight 1.000
}
host braeval {
     id -10        # do not change unnecessarily
     # weight 1.000
     alg straw
     hash 0    # rjenkins1
     item osd.7 weight 1.000
}
host hanyu {
     id -11        # do not change unnecessarily
     # weight 1.000
     alg straw
     hash 0    # rjenkins1
     item osd.8 weight 1.000
}
rack lombarderie {
     id -12        # do not change unnecessarily
     # weight 4.000
     alg straw
     hash 0    # rjenkins1
     item chichibu weight 1.000
     item glenesk weight 1.000
     item braeval weight 1.000
     item hanyu weight 1.000
}
pool default {
     id -1        # do not change unnecessarily
     # weight 8.000
     alg straw
     hash 0    # rjenkins1
     item loire weight 2.000
     item chantrerie weight 2.000
     item lombarderie weight 4.000
}

# rules
rule data {
     ruleset 0
     type replicated
     min_size 1
     max_size 10
     step take default
     step chooseleaf firstn 0 type host
     step emit
}
rule metadata {
     ruleset 1
     type replicated
     min_size 1
     max_size 10
     step take default
     step chooseleaf firstn 0 type host
     step emit
}
rule rbd {
     ruleset 2
     type replicated
     min_size 1
     max_size 10
     step take default
     step chooseleaf firstn 0 type host
     step emit
}

# end crush map

Hope it helps,
cheers

--=20
Yann Dupont - Service IRTS, DSI Universit=C3=A9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
