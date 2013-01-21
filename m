From: Ulysse 31 <ulysse31@gmail.com>
Subject: Re: ceph replication and data redundancy
Date: Mon, 21 Jan 2013 09:14:25 +0100
Message-ID: <CAFSDvD1M-7ZJWR=PQBZwkEWOM9ijQ0ManWPGrKBZTPvOWrb4KQ@mail.gmail.com>
References: <CAFSDvD0ouu-YwStP_RyOUj2K3vdiOBCZJR_PO8os5-x2cAMfsQ@mail.gmail.com>
	<50FC2967.6080207@widodh.nl>
	<48C16807A78A464DA590FC8010B37632@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:51015 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab3AUIO0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jan 2013 03:14:26 -0500
Received: by mail-oa0-f47.google.com with SMTP id h1so5719230oag.6
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jan 2013 00:14:26 -0800 (PST)
In-Reply-To: <48C16807A78A464DA590FC8010B37632@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Hi everybody,

In fact, i found searching the doc on section "adding/removing a
monitor", infos about the paxos system used for quorum establishment.
=46ollowing the documentation, in a catastrophy scenario, i need to
remove the other monitors configured on the other buildings.
=46or better efficiency, i think i'll keep 1 monitor per building, and,
if two other building fails, i will delete those two monitors from the
configuration in order to access data again.
I'll simulate that and see if it goes well.
Thanks for your help and advices.

Regards,


--
Gomes do Vale Victor
System, Network and Security engineer.

2013/1/20 Gregory Farnum <greg@inktank.com>:
> (Sorry for the blank email just now, my client got a little eager!)
>
> Apart from the things that Wido has mentioned, you say you've set up =
4 nodes and each one has a monitor on it. That's why you can't do anyth=
ing when you bring down two nodes =97 the monitor cluster requires a st=
rict majority in order to continue operating, which is why we recommend=
 odd numbers. If you set up a different node as a monitor (simulating o=
ne in a different data center) and then bring down two nodes, things sh=
ould keep working.
> -Greg
>
>
> On Sunday, January 20, 2013 at 9:29 AM, Wido den Hollander wrote:
>
>> Hi,
>>
>> On 01/17/2013 10:55 AM, Ulysse 31 wrote:
>> > Hi all,
>> >
>> > I'm not sure if it's the good mailing, if not, sorry for that, tel=
l me
>> > the appropriate one, i'll go for it.
>> > Here is my actual project :
>> > The company i work for has several buildings, each of them are lin=
ked
>> > with gigabit trunk links allowing us to have multiple machines ove=
r
>> > the same lan on different buildings.
>> > We need to archive some data (over 5 to 10Tb), but we want that da=
ta
>> > present on each buildings, and, in case of the lost of a building
>> > (catastrophy scenario) we steel have the data.
>> > Rather than using simple storage machines sync'ed by rsync, we tha=
ught
>> > re-using older desktop machines we have in stock, and make a
>> > clusterized fs on it :
>> > In fact, speed is clearly not the goal of this data storage, we wo=
uld
>> > just store old projects on it sometimes, and will access it in rar=
e
>> > cases. the most important is to keep that data archived somewhere.
>>
>>
>>
>> Ok, keep that in mind. All writes to RADOS are synchronous, so if yo=
u
>> experience high latency or some congestion on your network Ceph will
>> become slow.
>>
>> > I was interrested by ceph in the way that we can declare, using th=
e
>> > crush-map, a hierarchical maner to place replicated data.
>> > So for a test, i build a sample cluster composed of 4 nodes, insta=
lled
>> > under debian squeeze and actual bobtail stable version of ceph.
>> > On my sample i wanted to simulate 2 "per buildings" nodes, each no=
des
>> > has a 2Tb disk and has mon/osd/mds (i know it is not optimized, bu=
t
>> > that just a sample), osd uses xfs on /dev/sda3, and made a crush m=
ap
>> > like :
>> > ---
>> > # begin crush map
>> >
>> > # devices
>> > device 0 osd.0
>> > device 1 osd.1
>> > device 2 osd.2
>> > device 3 osd.3
>> >
>> > # types
>> > type 0 osd
>> > type 1 host
>> > type 2 rack
>> > type 3 row
>> > type 4 room
>> > type 5 datacenter
>> > type 6 root
>> >
>> > # buckets
>> > host server-0 {
>> > id -2 # do not change unnecessarily
>> > # weight 1.000
>> > alg straw
>> > hash 0 # rjenkins1
>> > item osd.0 weight 1.000
>> > }
>> > host server-1 {
>> > id -5 # do not change unnecessarily
>> > # weight 1.000
>> > alg straw
>> > hash 0 # rjenkins1
>> > item osd.1 weight 1.000
>> > }
>> > host server-2 {
>> > id -6 # do not change unnecessarily
>> > # weight 1.000
>> > alg straw
>> > hash 0 # rjenkins1
>> > item osd.2 weight 1.000
>> > }
>> > host server-3 {
>> > id -7 # do not change unnecessarily
>> > # weight 1.000
>> > alg straw
>> > hash 0 # rjenkins1
>> > item osd.3 weight 1.000
>> > }
>> > rack bat0 {
>> > id -3 # do not change unnecessarily
>> > # weight 3.000
>> > alg straw
>> > hash 0 # rjenkins1
>> > item server-0 weight 1.000
>> > item server-1 weight 1.000
>> > }
>> > rack bat1 {
>> > id -4 # do not change unnecessarily
>> > # weight 3.000
>> > alg straw
>> > hash 0 # rjenkins1
>> > item server-2 weight 1.000
>> > item server-3 weight 1.000
>> > }
>> > root root {
>> > id -1 # do not change unnecessarily
>> > # weight 3.000
>> > alg straw
>> > hash 0 # rjenkins1
>> > item bat0 weight 3.000
>> > item bat1 weight 3.000
>> > }
>> >
>> > # rules
>> > rule data {
>> > ruleset 0
>> > type replicated
>> > min_size 1
>> > max_size 10
>> > step take root
>> > step chooseleaf firstn 0 type rack
>> > step emit
>> > }
>> > rule metadata {
>> > ruleset 1
>> > type replicated
>> > min_size 1
>> > max_size 10
>> > step take root
>> > step chooseleaf firstn 0 type rack
>> > step emit
>> > }
>> > rule rbd {
>> > ruleset 2
>> > type replicated
>> > min_size 1
>> > max_size 10
>> > step take root
>> > step chooseleaf firstn 0 type rack
>> > step emit
>> > }
>> > # end crush map
>> > ---
>> >
>> > Using this crush-map, coupled with a default pool data size 2
>> > (replication 2), allowed me to be sure to have duplicate of all da=
ta
>> > on both "sample building" bat0 and bat1.
>> > Then I mounted on a client using ceph-fuse using : ceph-fuse -m
>> > server-2:6789 /mnt/mycephfs (server-2 located on bat1), everything
>> > works fine has expected, can write/read data, from one or more
>> > clients, no probs on that.
>>
>>
>>
>> Just to repeat. CephFS is still in development and can be buggy some=
times.
>>
>> Also, if you do this, make sure you have an Active/Standby MDS setup
>> where each building has an MDS.
>>
>> > Then I begin stress tests, i simulate the lost of one node, no pro=
blem
>> > on that, still can access to the cluster data.
>> > Finally i simulate the lost of a building (bat0), bringing down
>> > server-0 and server-1. the results was an hang on the cluster, no =
more
>> > access to any data ... ceph -s on the active nodes hanging with :
>> >
>> > 2013-01-17 09:14:18.327911 7f4e5ca70700 0 -- xxx.xxx.xxx.52:0/1654=
3
>> > > > xxx.xxx.xxx.51:6789/0 pipe(0x2c9d490 sd=3D3 :0 pgs=3D0 cs=3D0 =
l=3D1).fault
>> > >
>> >
>> >
>> >
>> > I start search the net and might have found the answer, the proble=
m
>> > came from the fact that my rules uses "step chooseleaf firstn 0 ty=
pe
>> > rack", which, allows me in fact to have data replicated on both
>> > buildings, but seems to hang if a building is missing ...
>> > I know that actually geo - replication is currently under developm=
ent,
>> > but is there a way to do what i'm trying to do without it ?
>> > Thanks for your help and answers.
>>
>>
>>
>> Pools nowadays have a "min_size", if their replicas go under that th=
ey
>> become incomplete and don't work.
>>
>> You have to set this to 1 for your 'data' en 'metadata' pool:
>>
>> osd pool data set min_size 1
>> osd pool metadata set min_size 1
>>
>> You might want to test this with plain RADOS instead of the filesyst=
em,
>> just to be sure.
>>
>> Try creating a new pool and use the 'rados' tool to write some data =
and
>> see if it works when you bring a building down.
>>
>> Wido
>>
>> > Best Regards,
>> >
>> >
>> >
>> >
>> >
>> > --
>> > Gomes do Vale Victor
>> > System, Network and Security Engineer
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org (mailto:majordo=
mo@vger.kernel.org)
>> > More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org (mailto:majordomo=
@vger.kernel.org)
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
