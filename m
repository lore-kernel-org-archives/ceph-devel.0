From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: uneven placement
Date: Wed, 01 Aug 2012 09:55:42 +0200
Message-ID: <5018E0FE.70400@univ-nantes.fr>
References: <501292A3.50606@univ-nantes.fr> <CADvuQRGhtOXt57cXf07Y0y9_v+XNQyC5qudhsdHPp34gdG5FOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls2-lmb.cpub.univ-nantes.fr ([193.52.103.111]:41876 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753879Ab2HAHzs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Aug 2012 03:55:48 -0400
In-Reply-To: <CADvuQRGhtOXt57cXf07Y0y9_v+XNQyC5qudhsdHPp34gdG5FOA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

Le 30/07/2012 19:53, Tommi Virtanen a =C3=A9crit :

> On Fri, Jul 27, 2012 at 6:07 AM, Yann Dupont <Yann.Dupont@univ-nantes=
=2Efr> wrote:
>> My ceph cluster is made of 8 OSD with quite big storage attached.
>> All OSD nodes are equal, except 4 OSD have 6,2 TB, 4 have 8 TB stora=
ge.
> Sounds like you should just set the weights yourself, based on the
> capacities you listed here.

Hi Tommi.

In my previous crush map, I was doing that more or less, I thought it=20
was sufficient :

datacenter chantrerie {
  ...
   item carsebridge weight 1.330
     item cameronbridge weight 1.000
}
datacenter loire {
  ...
     item karuizawa weight 1.330
     item hazelburn weight 1.000
}

datacenter lombarderie {
=2E..
     item chichibu weight 1.330
     item glenesk weight 1.000
     item braeval weight 1.330
     item hanyu weight 1.000
}

pool default {
    ...
     item chantrerie weight 2.000
     item loire weight 2.000
     item lombarderie weight 4.000
}

I've been able to grow a little more all my volumes, giving Now 8.6 TB=20
for 4 nodes, and 6.8TB for the 4 others ;
Now I've tried to be more precise , here is the crushmap I'm now using =
:


# begin crush map

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
host chichibu {
     id -2        # do not change unnecessarily
     # weight 8.600
     alg straw
     hash 0    # rjenkins1
     item osd.0 weight 8.600
}
host glenesk {
     id -4        # do not change unnecessarily
     # weight 6.800
     alg straw
     hash 0    # rjenkins1
     item osd.1 weight 6.800
}
host braeval {
     id -9        # do not change unnecessarily
     # weight 8.600
     alg straw
     hash 0    # rjenkins1
     item osd.7 weight 8.600
}
host hanyu {
     id -10        # do not change unnecessarily
     # weight 6.800
     alg straw
     hash 0    # rjenkins1
     item osd.8 weight 6.800
}
datacenter lombarderie {
     id -13        # do not change unnecessarily
     # weight 30.800
     alg straw
     hash 0    # rjenkins1
     item chichibu weight 8.600
     item glenesk weight 6.800
     item braeval weight 8.600
     item hanyu weight 6.800
}
host carsebridge {
     id -7        # do not change unnecessarily
     # weight 8.600
     alg straw
     hash 0    # rjenkins1
     item osd.5 weight 8.600
}
host cameronbridge {
     id -8        # do not change unnecessarily
     # weight 6.800
     alg straw
     hash 0    # rjenkins1
     item osd.6 weight 6.800
}
datacenter chantrerie {
     id -12        # do not change unnecessarily
     # weight 15.400
     alg straw
     hash 0    # rjenkins1
     item carsebridge weight 8.600
     item cameronbridge weight 6.800
}
host karuizawa {
     id -5        # do not change unnecessarily
     # weight 8.600
     alg straw
     hash 0    # rjenkins1
     item osd.2 weight 8.600
}
host hazelburn {
     id -6        # do not change unnecessarily
     # weight 6.800
     alg straw
     hash 0    # rjenkins1
     item osd.3 weight 6.800
}
datacenter loire {
     id -11        # do not change unnecessarily
     # weight 15.400
     alg straw
     hash 0    # rjenkins1
     item karuizawa weight 8.600
     item hazelburn weight 6.800
}
pool default {
     id -1        # do not change unnecessarily
     # weight 61.600
     alg straw
     hash 0    # rjenkins1
     item lombarderie weight 30.800
     item chantrerie weight 15.400
     item loire weight 15.400
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



- I suppose the individual osd weight is probably unused, as I only hav=
e=20
1 osd/host ?


It took several hours to rebalance the data, the result is , no=20
surprise, more or less the same :

/dev/mapper/xceph--chichibu-data
                       8,6T  5,3T  3,4T  61% /XCEPH-PROD/data
/dev/mapper/xceph--glenesk-data
                       6,8T  3,3T  3,6T  48% /XCEPH-PROD/data
/dev/mapper/xceph--braeval-data
                       8,6T  4,4T  4,3T  51% /XCEPH-PROD/data
/dev/mapper/xceph--hanyu-data
                       6,8T  4,3T  2,6T  63% /XCEPH-PROD/data
/dev/mapper/xceph--karuizawa-data
                       8,6T  6,7T  2,0T  78% /XCEPH-PROD/data
/dev/mapper/xceph--hazelburn-data
                       6,8T  6,0T  864G  88% /XCEPH-PROD/data
/dev/mapper/xceph--carsebridge-data
                       8,6T  6,9T  1,8T  81% /XCEPH-PROD/data
/dev/mapper/xceph--cameronbridge-data
                       6,8T  5,2T  1,6T  77% /XCEPH-PROD/data

In your precedent message, did you mean I should tweak manually the=20
weight based on the observation of those results ?
> stochastic, you may not get perfect balance with a small cluster.

Ok, I understand, I suppose my situation is even worse because I use=20
datacenter, so placement by "firstn" is only on the 3 datacenters, wich=
=20
gives :

17.3 out of 30.8 (56%) for datacenter lombarderie ;
12.7 out of 15.4 (82%) for datacenter loire ;
12.1 out of 15.4 (78%) for datacenter chantrerie ;

Which is not so bad.

> CRUSH evens out on larger clusters quite nicely, but there's still a
> lot of statistical variation in the picture.
I need to keep the notion of 3 datacenters ; All my data must be=20
replicated on 2 distincts (read, some kilometers away) places.
So, even if I artificially multiplicate osd (by using lots of little LV=
M=20
volumes on my arrays, I could reach 32 osd, for exemple) , I'll probabl=
y=20
have a better placement inside that datacenter, BUT I'd still only have=
=20
3 datacenters. As the firstn choice will only work on thoses 3 items, I=
t=20
will lead to similar problem . Am I wrong ?

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=C3=A9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
