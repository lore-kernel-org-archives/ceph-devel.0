From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: uneven placement
Date: Fri, 27 Jul 2012 15:07:47 +0200
Message-ID: <501292A3.50606@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls2-lmb.cpub.univ-nantes.fr ([193.52.103.111]:36556 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751113Ab2G0NHx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jul 2012 09:07:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp-tls.univ-nantes.fr (Postfix) with ESMTP id 183DC40164A
	for <ceph-devel@vger.kernel.org>; Fri, 27 Jul 2012 15:07:51 +0200 (CEST)
Received: from smtp-tls.univ-nantes.fr ([127.0.0.1])
	by localhost (smtptls2-lmb.cpub.univ-nantes.fr [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id q5PHwlnhS+ME for <ceph-devel@vger.kernel.org>;
	Fri, 27 Jul 2012 15:07:48 +0200 (CEST)
Received: from [IPv6:2001:660:7220:0:8594:5b1b:b04:9d0c] (unknown [IPv6:2001:660:7220:0:8594:5b1b:b04:9d0c])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-tls.univ-nantes.fr (Postfix) with ESMTPSA id 0D7F043A00F
	for <ceph-devel@vger.kernel.org>; Fri, 27 Jul 2012 15:07:48 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello.
I'm running ceph with great success for 3 weeks now (the key was using=20
xfs instead of btrfs on osd nodes).

Using it with rbd volumes, for lot of things (backup, etc). My setup is=
=20
already detailled in the list, I'll just summarize again :

My ceph cluster is made of 8 OSD with quite big storage attached.
All OSD nodes are equal, except 4 OSD have 6,2 TB, 4 have 8 TB storage.



All is really running well, except placement seems non optimal ;

One OSD is now near_full (93%), 2 others have more 86% where others are=
=20
only 50% full.

This morning I tried

ceph osd reweight-by-utilization 110


the placement is still in progress :

ceph -s
    health HEALTH_WARN 83 pgs backfill; 83 pgs recovering; 86 pgs stuck=
=20
unclean; recovery 623428/11876870 degraded (5.249%); 3 near full osd(s)
    monmap e1: 3 mons at=20
{chichibu=3D172.20.14.130:6789/0,glenesk=3D172.20.14.131:6789/0,karuiza=
wa=3D172.20.14.133:6789/0},=20
election epoch 46, quorum 0,1,2 chichibu,glenesk,karuizawa
    osdmap e731: 8 osds: 8 up, 8 in
     pgmap v792090: 1728 pgs: 1641 active+clean, 3 active+remapped, 1=20
active+clean+scrubbing, 83 active+recovering+remapped+backfill; 21334 G=
B=20
data, 42865 GB used, 15262 GB / 58128 GB avail; 623428/11876870 degrade=
d=20
(5.249%)
    mdsmap e31: 1/1/1 up {0=3Dglenesk=3Dup:active}, 2 up:standby


But it seems to lead to worse comportment (filing the already near -ful=
l):

see the 8 OSD :
/dev/mapper/xceph--chichibu-data
                       8,0T  5,4T  2,7T  68% /XCEPH-PROD/data
/dev/mapper/xceph--glenesk-data
                       6,2T  3,2T  3,1T  51% /XCEPH-PROD/data
/dev/mapper/xceph--karuizawa-data
                       8,0T  7,0T  1,1T  87% /XCEPH-PROD/data
/dev/mapper/xceph--hazelburn-data
                       6,2T  5,9T  373G  95% /XCEPH-PROD/data
/dev/mapper/xceph--carsebridge-data
                       8,0T  6,9T  1,2T  86% /XCEPH-PROD/data
/dev/mapper/xceph--cameronbridge-data
                       6,2T  5,1T  1,2T  83% /XCEPH-PROD/data
/dev/mapper/xceph--braeval-data
                       8,0T  4,6T  3,5T  57% /XCEPH-PROD/data
/dev/mapper/xceph--hanyu-data
                       6,2T  4,2T  2,1T  67% /XCEPH-PROD/data



Now the crush map : You'll notice that my 8 OSD nodes are placed in 4=20
datacenters, and hosts with 8 TB have a different weight that the 6.2T=20
nodes.


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
type 3 row
type 4 room
type 5 datacenter
type 6 pool

# buckets
host carsebridge {
     id -7        # do not change unnecessarily
     # weight 1.000
     alg straw
     hash 0    # rjenkins1
     item osd.5 weight 1.000
}
host cameronbridge {
     id -8        # do not change unnecessarily
     # weight 1.000
     alg straw
     hash 0    # rjenkins1
     item osd.6 weight 1.000
}
datacenter chantrerie {
     id -12        # do not change unnecessarily
     # weight 2.330
     alg straw
     hash 0    # rjenkins1
     item carsebridge weight 1.330
     item cameronbridge weight 1.000
}
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
datacenter loire {
     id -11        # do not change unnecessarily
     # weight 2.330
     alg straw
     hash 0    # rjenkins1
     item karuizawa weight 1.330
     item hazelburn weight 1.000
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
     id -9        # do not change unnecessarily
     # weight 1.000
     alg straw
     hash 0    # rjenkins1
     item osd.7 weight 1.000
}
host hanyu {
     id -10        # do not change unnecessarily
     # weight 1.000
     alg straw
     hash 0    # rjenkins1
     item osd.8 weight 1.000
}
datacenter lombarderie {
     id -13        # do not change unnecessarily
     # weight 4.660
     alg straw
     hash 0    # rjenkins1
     item chichibu weight 1.330
     item glenesk weight 1.000
     item braeval weight 1.330
     item hanyu weight 1.000
}
pool default {
     id -1        # do not change unnecessarily
     # weight 8.000
     alg straw
     hash 0    # rjenkins1
     item chantrerie weight 2.000
     item loire weight 2.000
     item lombarderie weight 4.000
}
rack unknownrack {
     id -3        # do not change unnecessarily
     # weight 8.000
     alg straw
     hash 0    # rjenkins1
     item chichibu weight 1.000
     item glenesk weight 1.000
     item karuizawa weight 1.000
     item hazelburn weight 1.000
     item carsebridge weight 1.000
     item cameronbridge weight 1.000
     item braeval weight 1.000
     item hanyu weight 1.000
}

# rules
rule data {
     ruleset 0
     type replicated
     min_size 1
     max_size 10
     step take default
     step chooseleaf firstn 0 type datacenter
     step emit
}
rule metadata {
     ruleset 1
     type replicated
     min_size 1
     max_size 10
     step take default
     step chooseleaf firstn 0 type datacenter
     step emit
}
rule rbd {
     ruleset 2
     type replicated
     min_size 1
     max_size 10
     step take default
     step chooseleaf firstn 0 type datacenter
     step emit
}

# end crush map

There is probably something I'm doing wrong,but what ??
(BTW running 0.49 right now, it's not changing this problem)

Any hints will be appreciated,
Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
