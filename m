From: John Wilkins <john.wilkins@inktank.com>
Subject: Re: [ceph-users] PG down & incomplete
Date: Fri, 17 May 2013 11:27:11 -0700
Message-ID: <CAM2gkg51tSPiH_kesF=xQi3t6oET+f0D1XgxyE_6UOZei6PO3Q@mail.gmail.com>
References: <1368569751.5157.5.camel@localhost>
	<1368768722.22569.1.camel@localhost>
	<CAM2gkg4znKDOp-D=z459G2MCQcGzkHrLWF_Ox8uGexZNcMUM3Q@mail.gmail.com>
	<1368779478.22569.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f43.google.com ([209.85.212.43]:52081 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab3EQS1N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 May 2013 14:27:13 -0400
Received: by mail-vb0-f43.google.com with SMTP id p14so2547269vbm.30
        for <ceph-devel@vger.kernel.org>; Fri, 17 May 2013 11:27:12 -0700 (PDT)
In-Reply-To: <1368779478.22569.17.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

It looks like you have the "noout" flag set:

"noout flag(s) set; 1 mons down, quorum 0,1,2,3 a,b,c,e
   monmap e7: 5 mons at
{a=3D10.0.0.1:6789/0,b=3D10.0.0.2:6789/0,c=3D10.0.0.5:6789/0,d=3D10.0.0=
=2E6:6789/0,e=3D10.0.0.3:6789/0},
election epoch 2584, quorum 0,1,2,3 a,b,c,e
   osdmap e82502: 50 osds: 48 up, 48 in"

http://ceph.com/docs/master/rados/troubleshooting/troubleshooting-osd/#=
stopping-w-out-rebalancing

If you have down OSDs that don't get marked out, that would certainly
cause problems. Have you tried restarting the failed OSDs?

What do the logs look like for osd.15 and osd.25?

On Fri, May 17, 2013 at 1:31 AM, Olivier Bonvalet <ceph.list@daevel.fr>=
 wrote:
> Hi,
>
> thanks for your answer. In fact I have several different problems, wh=
ich
> I tried to solve separatly :
>
> 1) I loose 2 OSD, and some pools have only 2 replicas. So some data w=
as
> lost.
> 2) One monitor refuse the Cuttlefish upgrade, so I only have 4 of 5
> monitors running.
> 3) I have 4 old inconsistent PG that I can't repair.
>
>
> So the status :
>
>    health HEALTH_ERR 15 pgs incomplete; 4 pgs inconsistent; 15 pgs st=
uck
> inactive; 15 pgs stuck unclean; 1 near full osd(s); 19 scrub errors;
> noout flag(s) set; 1 mons down, quorum 0,1,2,3 a,b,c,e
>    monmap e7: 5 mons at
> {a=3D10.0.0.1:6789/0,b=3D10.0.0.2:6789/0,c=3D10.0.0.5:6789/0,d=3D10.0=
=2E0.6:6789/0,e=3D10.0.0.3:6789/0}, election epoch 2584, quorum 0,1,2,3=
 a,b,c,e
>    osdmap e82502: 50 osds: 48 up, 48 in
>     pgmap v12807617: 7824 pgs: 7803 active+clean, 1 active+clean
> +scrubbing, 15 incomplete, 4 active+clean+inconsistent, 1 active+clea=
n
> +scrubbing+deep; 5676 GB data, 18948 GB used, 18315 GB / 37263 GB ava=
il;
> 137KB/s rd, 1852KB/s wr, 199op/s
>    mdsmap e1: 0/0/1 up
>
>
>
> The tree :
>
> # id    weight  type name       up/down reweight
> -8      14.26   root SSDroot
> -27     8               datacenter SSDrbx2
> -26     8                       room SSDs25
> -25     8                               net SSD188-165-12
> -24     8                                       rack SSD25B09
> -23     8                                               host lyll
> 46      2                                                       osd.4=
6  up      1
> 47      2                                                       osd.4=
7  up      1
> 48      2                                                       osd.4=
8  up      1
> 49      2                                                       osd.4=
9  up      1
> -10     4.26            datacenter SSDrbx3
> -12     2                       room SSDs43
> -13     2                               net SSD178-33-122
> -16     2                                       rack SSD43S01
> -17     2                                               host kaino
> 42      1                                                       osd.4=
2  up      1
> 43      1                                                       osd.4=
3  up      1
> -22     2.26                    room SSDs45
> -21     2.26                            net SSD5-135-138
> -20     2.26                                    rack SSD45F01
> -19     2.26                                            host taman
> 44      1.13                                                    osd.4=
4  up      1
> 45      1.13                                                    osd.4=
5  up      1
> -9      2               datacenter SSDrbx4
> -11     2                       room SSDs52
> -14     2                               net SSD176-31-226
> -15     2                                       rack SSD52B09
> -18     2                                               host dragan
> 40      1                                                       osd.4=
0  up      1
> 41      1                                                       osd.4=
1  up      1
> -1      33.43   root SASroot
> -100    15.9            datacenter SASrbx1
> -90     15.9                    room SASs15
> -72     15.9                            net SAS188-165-15
> -40     8                                       rack SAS15B01
> -3      8                                               host brontes
> 0       1                                                       osd.0=
   up      1
> 1       1                                                       osd.1=
   up      1
> 2       1                                                       osd.2=
   up      1
> 3       1                                                       osd.3=
   up      1
> 4       1                                                       osd.4=
   up      1
> 5       1                                                       osd.5=
   up      1
> 6       1                                                       osd.6=
   up      1
> 7       1                                                       osd.7=
   up      1
> -41     7.9                                     rack SAS15B02
> -6      7.9                                             host alim
> 24      1                                                       osd.2=
4  up      1
> 25      1                                                       osd.2=
5  down    0
> 26      1                                                       osd.2=
6  up      1
> 27      1                                                       osd.2=
7  up      1
> 28      1                                                       osd.2=
8  up      1
> 29      1                                                       osd.2=
9  up      1
> 30      1                                                       osd.3=
0  up      1
> 31      0.9                                                     osd.3=
1  up      1
> -101    17.53           datacenter SASrbx2
> -91     17.53                   room SASs27
> -70     1.6                             net SAS188-165-13
> -44     0                                       rack SAS27B04
> -7      0                                               host bul
> -45     1.6                                     rack SAS27B06
> -4      1.6                                             host okko
> 32      0.2                                                     osd.3=
2  up      1
> 33      0.2                                                     osd.3=
3  up      1
> 34      0.2                                                     osd.3=
4  up      1
> 35      0.2                                                     osd.3=
5  up      1
> 36      0.2                                                     osd.3=
6  up      1
> 37      0.2                                                     osd.3=
7  up      1
> 38      0.2                                                     osd.3=
8  up      1
> 39      0.2                                                     osd.3=
9  up      1
> -71     15.93                           net SAS188-165-14
> -42     8                                       rack SAS27A03
> -5      8                                               host noburo
> 8       1                                                       osd.8=
   up      1
> 9       1                                                       osd.9=
   up      1
> 18      1                                                       osd.1=
8  up      1
> 19      1                                                       osd.1=
9  up      1
> 20      1                                                       osd.2=
0  up      1
> 21      1                                                       osd.2=
1  up      1
> 22      1                                                       osd.2=
2  up      1
> 23      1                                                       osd.2=
3  up      1
> -43     7.93                                    rack SAS27A04
> -2      7.93                                            host keron
> 10      0.97                                                    osd.1=
0  up      1
> 11      1                                                       osd.1=
1  up      1
> 12      1                                                       osd.1=
2  up      1
> 13      1                                                       osd.1=
3  up      1
> 14      0.98                                                    osd.1=
4  up      1
> 15      1                                                       osd.1=
5  down    0
> 16      0.98                                                    osd.1=
6  up      1
> 17      1                                                       osd.1=
7  up      1
>
>
> Here I have 2 roots : SSDroot and SASroot. All my OSD/PG problems are=
 on
> the SAS branch, and my CRUSH rules use per "net" replication.
>
> The osd.15 have a failling disk since long time, its data was correct=
ly
> moved (=3D OSD was out until the cluster obtain HEALTH_OK).
> The osd.25 is a buggy OSD that I can't remove or change : if I balanc=
e
> it's PG on other OSD, then this others OSD crash. That problem occur
> before I loose the osd.19 : OSD was unable to mark that PG as
> inconsistent since it was crashing during scrub. For me, all
> inconsistencies come from this OSD.
> The osd.19 was a failling disk, that I changed.
>
>
> And the health detail :
>
> HEALTH_ERR 15 pgs incomplete; 4 pgs inconsistent; 15 pgs stuck inacti=
ve;
> 15 pgs stuck unclean; 1 near full osd(s); 19 scrub errors; noout flag=
(s)
> set; 1 mons down, quorum 0,1,2,3 a,b,c,e
> pg 4.5c is stuck inactive since forever, current state incomplete, la=
st
> acting [19,30]
> pg 8.71d is stuck inactive since forever, current state incomplete, l=
ast
> acting [24,19]
> pg 8.3fa is stuck inactive since forever, current state incomplete, l=
ast
> acting [19,31]
> pg 8.3e0 is stuck inactive since forever, current state incomplete, l=
ast
> acting [31,19]
> pg 8.56c is stuck inactive since forever, current state incomplete, l=
ast
> acting [19,28]
> pg 8.19f is stuck inactive since forever, current state incomplete, l=
ast
> acting [31,19]
> pg 8.792 is stuck inactive since forever, current state incomplete, l=
ast
> acting [19,28]
> pg 4.0 is stuck inactive since forever, current state incomplete, las=
t
> acting [28,19]
> pg 8.78a is stuck inactive since forever, current state incomplete, l=
ast
> acting [31,19]
> pg 8.23e is stuck inactive since forever, current state incomplete, l=
ast
> acting [32,13]
> pg 8.2ff is stuck inactive since forever, current state incomplete, l=
ast
> acting [6,19]
> pg 8.5e2 is stuck inactive since forever, current state incomplete, l=
ast
> acting [0,19]
> pg 8.528 is stuck inactive since forever, current state incomplete, l=
ast
> acting [31,19]
> pg 8.20f is stuck inactive since forever, current state incomplete, l=
ast
> acting [31,19]
> pg 8.372 is stuck inactive since forever, current state incomplete, l=
ast
> acting [19,24]
> pg 4.5c is stuck unclean since forever, current state incomplete, las=
t
> acting [19,30]
> pg 8.71d is stuck unclean since forever, current state incomplete, la=
st
> acting [24,19]
> pg 8.3fa is stuck unclean since forever, current state incomplete, la=
st
> acting [19,31]
> pg 8.3e0 is stuck unclean since forever, current state incomplete, la=
st
> acting [31,19]
> pg 8.56c is stuck unclean since forever, current state incomplete, la=
st
> acting [19,28]
> pg 8.19f is stuck unclean since forever, current state incomplete, la=
st
> acting [31,19]
> pg 8.792 is stuck unclean since forever, current state incomplete, la=
st
> acting [19,28]
> pg 4.0 is stuck unclean since forever, current state incomplete, last
> acting [28,19]
> pg 8.78a is stuck unclean since forever, current state incomplete, la=
st
> acting [31,19]
> pg 8.23e is stuck unclean since forever, current state incomplete, la=
st
> acting [32,13]
> pg 8.2ff is stuck unclean since forever, current state incomplete, la=
st
> acting [6,19]
> pg 8.5e2 is stuck unclean since forever, current state incomplete, la=
st
> acting [0,19]
> pg 8.528 is stuck unclean since forever, current state incomplete, la=
st
> acting [31,19]
> pg 8.20f is stuck unclean since forever, current state incomplete, la=
st
> acting [31,19]
> pg 8.372 is stuck unclean since forever, current state incomplete, la=
st
> acting [19,24]
> pg 8.792 is incomplete, acting [19,28]
> pg 8.78a is incomplete, acting [31,19]
> pg 8.71d is incomplete, acting [24,19]
> pg 8.5e2 is incomplete, acting [0,19]
> pg 8.56c is incomplete, acting [19,28]
> pg 8.528 is incomplete, acting [31,19]
> pg 8.3fa is incomplete, acting [19,31]
> pg 8.3e0 is incomplete, acting [31,19]
> pg 8.372 is incomplete, acting [19,24]
> pg 8.2ff is incomplete, acting [6,19]
> pg 8.23e is incomplete, acting [32,13]
> pg 8.20f is incomplete, acting [31,19]
> pg 8.19f is incomplete, acting [31,19]
> pg 3.7c is active+clean+inconsistent, acting [24,13,39]
> pg 3.6b is active+clean+inconsistent, acting [28,23,5]
> pg 4.5c is incomplete, acting [19,30]
> pg 3.d is active+clean+inconsistent, acting [29,4,11]
> pg 4.0 is incomplete, acting [28,19]
> pg 3.1 is active+clean+inconsistent, acting [28,19,5]
> osd.10 is near full at 85%
> 19 scrub errors
> noout flag(s) set
> mon.d (rank 4) addr 10.0.0.6:6789/0 is down (out of quorum)
>
>
> Pools 4 and 8 have only 2 replica, and pool 3 have 3 replica but
> inconsistent data.
>
> Thanks in advance.
>
> Le vendredi 17 mai 2013 =C3=A0 00:14 -0700, John Wilkins a =C3=A9crit=
 :
>> If you can follow the documentation here:
>> http://ceph.com/docs/master/rados/operations/monitoring-osd-pg/  and
>> http://ceph.com/docs/master/rados/troubleshooting/  to provide some
>> additional information, we may be better able to help you.
>>
>> For example, "ceph osd tree" would help us understand the status of
>> your cluster a bit better.
>>
>> On Thu, May 16, 2013 at 10:32 PM, Olivier Bonvalet <ceph.list@daevel=
=2Efr> wrote:
>> > Le mercredi 15 mai 2013 =C3=A0 00:15 +0200, Olivier Bonvalet a =C3=
=A9crit :
>> >> Hi,
>> >>
>> >> I have some PG in state down and/or incomplete on my cluster, bec=
ause I
>> >> loose 2 OSD and a pool was having only 2 replicas. So of course t=
hat
>> >> data is lost.
>> >>
>> >> My problem now is that I can't retreive a "HEALTH_OK" status : if=
 I try
>> >> to remove, read or overwrite the corresponding RBD images, near a=
ll OSD
>> >> hang (well... they don't do anything and requests stay in a growi=
ng
>> >> queue, until the production will be done).
>> >>
>> >> So, what can I do to remove that corrupts images ?
>> >>
>> >> _______________________________________________
>> >> ceph-users mailing list
>> >> ceph-users@lists.ceph.com
>> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> >>
>> >
>> > Up. Nobody can help me on that problem ?
>> >
>> > Thanks,
>> >
>> > Olivier
>> >
>> > _______________________________________________
>> > ceph-users mailing list
>> > ceph-users@lists.ceph.com
>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
>>
>> --
>> John Wilkins
>> Senior Technical Writer
>> Intank
>> john.wilkins@inktank.com
>> (415) 425-9599
>> http://inktank.com
>>
>
>



--=20
John Wilkins
Senior Technical Writer
Intank
john.wilkins@inktank.com
(415) 425-9599
http://inktank.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
