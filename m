From: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Subject: Re: cluster status information
Date: Thu, 26 May 2011 14:43:01 +0200
Message-ID: <BANLkTin0uHUitVVTJLHYcrw2j7d4bo0CNg@mail.gmail.com>
References: <4DDE4531.6060703@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42069 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757Ab1EZMnC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2011 08:43:02 -0400
Received: by yxs7 with SMTP id 7so253200yxs.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 05:43:01 -0700 (PDT)
In-Reply-To: <4DDE4531.6060703@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Hi all,

I'm new to ceph but I'll try it soon. It looks really excellent, keep
up the good work !!

=46rom my experience with a commercial solution of a scale out NAS
cluster (Isilon, not to name it), this is a really important feature
and attention should be put on that as well :)
What about an Isilon's like cluster status ?
Here is the output for the whole cluster + information for a specific
node (sorry for badly formatted text).
Could it be implemented somewhat like this in Ceph ? Simple & precise.

# isi status

Cluster Name:     my-cluster-1
Cluster Health:   [ OK ]
Available:         69T (11%)

                        Health    Throughput (bits/s)
 ID | IP Address      |D-A--S-R|   In     Out    Total |  Used  / Capac=
ity
----+-----------------+--------+-------+-------+-------+---------------=
--------
  1 | XX.YY.Z.1       | [ OK ] |  374M |  258M |  631M |   19T  /   22T=
 (89%)
  2 | XX.YY.Z.2       | [ OK ] |     0 |     0 |     0 |   19T  /   22T=
 (88%)
  3 | XX.YY.Z.3       | [ OK ] |  1.7M |     0 |  1.7M |   19T  /   22T=
 (89%)
  4 | XX.YY.Z.4       | [ OK ] |   16K |  177M |  177M |   19T  /   22T=
 (88%)
  5 | XX.YY.Z.5       | [ OK ] |  581M |  147M |  729M |   19T  /   22T=
 (88%)
  6 | XX.YY.Z.6       | [ OK ] |   12M |  151M |  163M |   19T  /   22T=
 (89%)
  7 | XX.YY.Z.7       | [ OK ] |  1.1K |  107K |  108K |   19T  /   22T=
 (89%)
  8 | XX.YY.Z.8       | [ OK ] |  9.0K |   89M |   89M |   19T  /   22T=
 (88%)
  9 | XX.YY.Z.9       | [ OK ] |  7.5M |  201K |  7.7M |   19T  /   22T=
 (88%)
 10 | XX.YY.Z.10      | [ OK ] |     0 |  933M |  933M |   19T  /   22T=
 (88%)
 11 | XX.YY.Z.11      | [ OK ] |  1.9K |  170M |  170M |   19T  /   22T=
 (88%)
 12 | XX.YY.Z.12      | [ OK ] |   992 |  948M |  948M |   19T  /   22T=
 (89%)
 13 | XX.YY.Z.13      | [ OK ] |  6.2M |  161M |  167M |   19T  /   22T=
 (89%)
 14 | XX.YY.Z.14      | [ OK ] |   80M |  228M |  308M |   19T  /   22T=
 (88%)
 15 | XX.YY.Z.15      | [ OK ] |   762 |  101M |  101M |   19T  /   22T=
 (88%)
 16 | XX.YY.Z.16      | [ OK ] |  1.6K |  178K |  180K |   19T  /   22T=
 (89%)
 17 | XX.YY.Z.17      | [ OK ] |   22M |  441M |  463M |   19T  /   22T=
 (88%)
 18 | XX.YY.Z.18      | [ OK ] |     0 |  303M |  303M |   19T  /   22T=
 (88%)
 19 | XX.YY.Z.19      | [ OK ] |  1.0M |  334M |  335M |   19T  /   22T=
 (88%)
 20 | XX.YY.Z.20      | [ OK ] |  3.1M |   17M |   20M |   19T  /   22T=
 (88%)
 21 | XX.YY.Z.21      | [ OK ] |  127M |  6.6M |  133M |   19T  /   22T=
 (88%)
 22 | XX.YY.Z.22      | [ OK ] |   29M |  126M |  155M |   19T  /   22T=
 (89%)
 23 | XX.YY.Z.23      | [ OK ] |     0 |     0 |     0 |   19T  /   22T=
 (88%)
 24 | XX.YY.Z.24      | [ OK ] |     0 |   74M |   74M |   19T  /   22T=
 (88%)
 25 | XX.YY.Z.25      | [ OK ] |   765 |     0 |   765 |   19T  /   22T=
 (88%)
 26 | XX.YY.Z.26      | [ OK ] |  380K |   99M |  100M |   19T  /   22T=
 (88%)
 27 | XX.YY.Z.27      | [ OK ] |   12M |  136M |  148M |   19T  /   22T=
 (88%)
 28 | XX.YY.Z.28      | [ OK ] |  1.1K |     0 |  1.1K |   19T  /   22T=
 (88%)
 29 | XX.YY.Z.29      | [ OK ] |  5.4M |  1.1G |  1.1G |   19T  /   22T=
 (88%)
-------------------------------+-------+-------+-------+---------------=
--------
 Cluster Totals:               |  1.3G |  6.0G |  7.3G |  558T  /  627T=
 (88%)

     Health Fields: D =3D Down, A =3D Attention, S =3D Smartfailed, R =3D=
 Read-Only

No Alerts.

--> Then, to get the status of a specific node (here : I want to know
on node 29 of the cluster) :

# isi status -n 29

Node LNN:            29
Node ID:             39
Node Name:           my-cluster-1-29
Node IP Address:     XX.YY.Z.29
Node Health:          [ OK ]
Node SN:             1234567890
Node Capacity:        22T
Available:           2.4T (11%)
Used:                 19T (88%)

Network Status:
        See 'isi networks list interfaces -v' for more detail or man(8)=
 isi.
Internal:            2 IB network interfaces (2 up, 0 down)
External:            2 GbE network interfaces (2 up, 0 down)
                     1 Aggregated network interfaces (0 up, 1 down)

Disk Drive Status:
  Bay  1 <12>      Bay  2 <15>      Bay  3 <18>      Bay  4 <21>
    13Mb/s           12Mb/s          6.7Mb/s          6.0Mb/s
  [HEALTHY]        [HEALTHY]        [HEALTHY]        [HEALTHY]

  Bay  5 <13>      Bay  6 <16>      Bay  7 <19>      Bay  8 <22>
   4.5Mb/s           15Mb/s           16Mb/s          8.5Mb/s
  [HEALTHY]        [HEALTHY]        [HEALTHY]        [HEALTHY]

  Bay  9 <14>      Bay 10 <17>      Bay 11 <20>      Bay 12 <23>
    11Mb/s          8.3Mb/s          6.6Mb/s          5.0Mb/s
  [HEALTHY]        [HEALTHY]        [HEALTHY]        [HEALTHY]

  Bay 13 <3>       Bay 14 <6>       Bay 15 <9>       Bay 16 <0>
   7.2Mb/s          6.1Mb/s          7.3Mb/s          8.2Mb/s
  [HEALTHY]        [HEALTHY]        [HEALTHY]        [HEALTHY]

  Bay 17 <4>       Bay 18 <7>       Bay 19 <10>      Bay 20 <1>
   6.5Mb/s           12Mb/s          3.1Mb/s          3.0Mb/s
  [HEALTHY]        [HEALTHY]        [HEALTHY]        [HEALTHY]

  Bay 21 <5>       Bay 22 <8>       Bay 23 <11>      Bay 24 <2>
   8.2Mb/s          6.7Mb/s          6.3Mb/s          6.8Mb/s
  [HEALTHY]        [HEALTHY]        [HEALTHY]        [HEALTHY]




2011/5/26 Fyodor Ustinov <ufm@ufm.su>:
> Hi!
>
> How to get information about status of each server in cluster?
>
> #ceph osd stat
> 2011-05-26 15:07:05.103621 mon <- [osd,stat]
> 2011-05-26 15:07:05.104201 mon0 -> 'e413: 6 osds: 5 up, 5 in' (0)
>
> I see - in cluster 6 osd servers and now up only 5. =A0How do I know =
which
> server is down?
>
> More global question - how to monitor the state of servers in a clust=
er?
>
> WBR,
> =A0 =A0Fyodor.
>
> P.S. JFYI: key "-s" do not described in manual page about ceph comman=
d.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
