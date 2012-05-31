From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: poor OSD performance using kernel 3.4 => problem found
Date: Thu, 31 May 2012 11:14:39 -0500
Message-ID: <4FC798EF.3070500@inktank.com>
References: <4FBE415E.8030702@profihost.ag> <4FC54CDB.1000506@inktank.com> <4FC5BF27.5060704@profihost.ag> <CADdPHGs9dpSh9Oyu+5yDhyYU=Et_-zF5MuYybBuuAN5DgR433A@mail.gmail.com> <4FC5C941.6010105@profihost.ag> <CADdPHGuiJqZUCK-0qR_CrOo6GRhkjaCdkOhJ2boq3zD0_voTsA@mail.gmail.com> <4FC5FEC1.90103@profihost.ag> <4FC60FC8.207@inktank.com> <4FC61596.3050703@profihost.ag> <4FC62BB0.1020003@inktank.com> <4FC66A1F.1080407@profihost.ag> <CADdPHGuxa7TAyqXcXehb9WgKgkHwkybYTrj2oue_PKsiF+oR3A@mail.gmail.com> <4FC68CAA.9030708@profihost.ag> <CADdPHGutEwoDc=Kcrqcx2ZMO=dqhuoT5iLoP-WxqD+e5ZUmBRA@mail.gmail.com> <4FC7197D.5010406@profihost.ag> <CAC-hyiFjRFLVHYUKv8bGG0u8u2ZrHgP78U2Txt+3R7GGwtopZA@mail.gmail.com> <4FC77045.6050907@univ-nantes.fr> <4FC77407.1050401@profihost.ag> <4FC775F3.8080109@univ-nantes.fr>
 <4FC78339.10900@univ-nantes.fr> <4FC78EFF.1090206@inktank.com> <4FC79193.1000604@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:49178 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659Ab2EaQOr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 12:14:47 -0400
Received: by gglu4 with SMTP id u4so958819ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 09:14:46 -0700 (PDT)
In-Reply-To: <4FC79193.1000604@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Yehuda Sadeh <yehuda@inktank.com>, Stefan Majer <stefan.majer@gmail.com>, ceph-devel@vger.kernel.org

On 05/31/2012 10:43 AM, Yann Dupont wrote:
> On 31/05/2012 17:32, Mark Nelson wrote:
>> ceph osd pool get<pool> pg_num
>
> My setup is detailed in a previous mail , But as I changed some
> parameters this morning, here we go :
>
> root@chichibu:~# ceph osd pool get data pg_num
> PG_NUM: 576
> root@chichibu:~# ceph osd pool get rbd pg_num
> PG_NUM: 576
>
>
>
> The pg num is quite low because I started with small OSD (9 osd with
> 200G each - internal disks) when I formatted. Now, I reduced to 8 osd,
> (osd.4 is out) but with much larger (& faster) storage.
>
>
> Now, each of the 8 OSD have 5T on it, I try, for the moment, to keep the
> OSD similars. Replication is set to 2.
>
>
> The fs is btrfs formatted with big metadata (-l 64k -n64k), and mounted
> via space_cache,compress=lzo,nobarrier,noatime.
>
> journal is on tmpfs :
> osd journal = /dev/shm/journal
> osd journal size = 6144
>
> I know this is dangerous, remember It's NOT a production system for the
> moment.
>
> No OSD is full, I don't have much data stored for the moment.
>
> Concerning crush map, I'm not using the default one :
>
> The 8 nodes are in 3 different locations (some kilometers away). 2 are
> in 1 place, 2 in another, and the 4 last in the principal place.
>
> There is 10G between all the nodes and they are in the same VLAN, no
> router involved (but there is (negligible ?) latency between nodes)
>
> I try to group host together to avoid problem when I loose a location
> (electrical problem, for example). Not sure I really customized the
> crush map as I should have.
>
> here is the map :
> begin crush map
>
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
>
> # types
> type 0 osd
> type 1 host
> type 2 rack
> type 3 pool
>
> # buckets
> host karuizawa {
> id -5 # do not change unnecessarily
> # weight 1.000
> alg straw
> hash 0 # rjenkins1
> item osd.2 weight 1.000
> }
> host hazelburn {
> id -6 # do not change unnecessarily
> # weight 1.000
> alg straw
> hash 0 # rjenkins1
> item osd.3 weight 1.000
> }
> rack loire {
> id -3 # do not change unnecessarily
> # weight 2.000
> alg straw
> hash 0 # rjenkins1
> item karuizawa weight 1.000
> item hazelburn weight 1.000
> }
> host carsebridge {
> id -8 # do not change unnecessarily
> # weight 1.000
> alg straw
> hash 0 # rjenkins1
> item osd.5 weight 1.000
> }
> host cameronbridge {
> id -9 # do not change unnecessarily
> # weight 1.000
> alg straw
> hash 0 # rjenkins1
> item osd.6 weight 1.000
> }
> rack chantrerie {
> id -7 # do not change unnecessarily
> # weight 2.000
> alg straw
> hash 0 # rjenkins1
> item carsebridge weight 1.000
> item cameronbridge weight 1.000
> }
> host chichibu {
> id -2 # do not change unnecessarily
> # weight 1.000
> alg straw
> hash 0 # rjenkins1
> item osd.0 weight 1.000
> }
> host glenesk {
> id -4 # do not change unnecessarily
> # weight 1.000
> alg straw
> hash 0 # rjenkins1
> item osd.1 weight 1.000
> }
> host braeval {
> id -10 # do not change unnecessarily
> # weight 1.000
> alg straw
> hash 0 # rjenkins1
> item osd.7 weight 1.000
> }
> host hanyu {
> id -11 # do not change unnecessarily
> # weight 1.000
> alg straw
> hash 0 # rjenkins1
> item osd.8 weight 1.000
> }
> rack lombarderie {
> id -12 # do not change unnecessarily
> # weight 4.000
> alg straw
> hash 0 # rjenkins1
> item chichibu weight 1.000
> item glenesk weight 1.000
> item braeval weight 1.000
> item hanyu weight 1.000
> }
> pool default {
> id -1 # do not change unnecessarily
> # weight 8.000
> alg straw
> hash 0 # rjenkins1
> item loire weight 2.000
> item chantrerie weight 2.000
> item lombarderie weight 4.000
> }
>
> # rules
> rule data {
> ruleset 0
> type replicated
> min_size 1
> max_size 10
> step take default
> step chooseleaf firstn 0 type host
> step emit
> }
> rule metadata {
> ruleset 1
> type replicated
> min_size 1
> max_size 10
> step take default
> step chooseleaf firstn 0 type host
> step emit
> }
> rule rbd {
> ruleset 2
> type replicated
> min_size 1
> max_size 10
> step take default
> step chooseleaf firstn 0 type host
> step emit
> }
>
> # end crush map
>
> Hope it helps,
> cheers
>
>

Hi Yann,

You might want to start out by running sar/iostat/collectl on the OSD 
nodes and seeing if anything looks funny during the slow test compared 
to the fast one.  If that doesn't reveal much, you could run blktrace on 
one of the OSDs during the tests and see if the IO to the disk looks 
different.  I can help out if you want to send me your blktrace results. 
  Similarly you could watch the network streams for both tests and see 
if anything looks different there.

Thanks!
Mark
