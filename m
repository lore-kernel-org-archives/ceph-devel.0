From: "caleb.miles" <caleb.miles@inktank.com>
Subject: Re: Crush not deliverying data uniformly -> HEALTH_ERR full osd
Date: Wed, 08 Aug 2012 15:57:28 -0700
Message-ID: <5022EED8.1070107@inktank.com>
References: <81C477727102DA4E9B2605AC748C495419104F5549@exch10> <CAC-hyiG54FgJmhHibkY6a-qqePALEjGrWrxNwHo2KhehswLfpw@mail.gmail.com> <81C477727102DA4E9B2605AC748C495419104F5553@exch10> <CAC-hyiFs=chueJTHPiBKXOyAg+y2LRQhxUHZsasbqhVRZZSrwQ@mail.gmail.com> <CA+zLgM0mko410C0MXWjuoqrc4oM9niF47wpPfzU7Ts6-AFF8Jg@mail.gmail.com> <81C477727102DA4E9B2605AC748C495419104F5579@exch10> <5022EE4D.1090604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59942 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757803Ab2HHW5c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Aug 2012 18:57:32 -0400
Received: by pbbrr13 with SMTP id rr13so2167859pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 08 Aug 2012 15:57:31 -0700 (PDT)
In-Reply-To: <5022EE4D.1090604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 08/08/2012 03:55 PM, caleb.miles wrote:
> Hi Paul,
>
> Sorry to take so long to get back to you. Could you add the following 
> lines to the top of your CRUSH map
>
>  # tunables
>  tunable choose_local_tries 0
>  tunable choose_local_fallback_tries 0
>  tunable choose_total_tries 50
>
> and compile with
>
> crushtool --enable-unsafe-tunables -c <your_map.txt>
>
> Caleb
>
> On 08/06/2012 03:40 PM, Paul Pettigrew wrote:
>> Hi Caleb
>> Crushmap below, thanks!
>> Paul
>>
>>
>>
>> root@dsanb1-coy:~# cat crushfile.txt
>> # begin crush map
>>
>> # devices
>> device 0 osd.0
>> device 1 osd.1
>> device 2 osd.2
>> device 3 osd.3
>> device 4 osd.4
>> device 5 osd.5
>> device 6 osd.6
>> device 7 osd.7
>> device 8 osd.8
>> device 9 osd.9
>> device 10 osd.10
>> device 11 osd.11
>> device 12 osd.12
>> device 13 osd.13
>> device 14 osd.14
>> device 15 osd.15
>> device 16 osd.16
>> device 17 osd.17
>> device 18 osd.18
>> device 19 osd.19
>> device 20 osd.20
>> device 21 osd.21
>> device 22 osd.22
>>
>> # types
>> type 0 osd
>> type 1 host
>> type 2 rack
>> type 3 zone
>>
>> # buckets
>> host dsanb1-coy {
>>          id -2           # do not change unnecessarily
>>          # weight 11.000
>>          alg straw
>>          hash 0  # rjenkins1
>>          item osd.0 weight 2.000
>>          item osd.1 weight 2.000
>>          item osd.10 weight 2.000
>>          item osd.2 weight 2.000
>>          item osd.3 weight 2.000
>>          item osd.4 weight 2.000
>>          item osd.5 weight 2.000
>>          item osd.6 weight 2.000
>>          item osd.7 weight 2.000
>>          item osd.8 weight 2.000
>>          item osd.9 weight 2.000
>> }
>> host dsanb2-coy {
>>          id -4           # do not change unnecessarily
>>          # weight 6.000
>>          alg straw
>>          hash 0  # rjenkins1
>>          item osd.11 weight 1.000
>>          item osd.12 weight 1.000
>>          item osd.13 weight 1.000
>>          item osd.14 weight 1.000
>>          item osd.15 weight 1.000
>>          item osd.16 weight 1.000
>> }
>> host dsanb3-coy {
>>          id -5           # do not change unnecessarily
>>          # weight 6.000
>>          alg straw
>>          hash 0  # rjenkins1
>>          item osd.17 weight 1.000
>>          item osd.18 weight 1.000
>>          item osd.19 weight 1.000
>>          item osd.20 weight 1.000
>>          item osd.21 weight 1.000
>>          item osd.22 weight 1.000
>> }
>> rack 2nrack {
>>          id -3           # do not change unnecessarily
>>          # weight 23.000
>>          alg straw
>>          hash 0  # rjenkins1
>>          item dsanb1-coy weight 11.000
>>          item dsanb2-coy weight 6.000
>>          item dsanb3-coy weight 6.000
>> }
>> zone default {
>>          id -1           # do not change unnecessarily
>>          # weight 23.000
>>          alg straw
>>          hash 0  # rjenkins1
>>          item 2nrack weight 23.000
>> }
>> rack 1nrack {
>>          id -6           # do not change unnecessarily
>>          # weight 11.000
>>          alg straw
>>          hash 0  # rjenkins1
>>          item  weight 11.000
>> }
>> zone bak {
>>          id -7           # do not change unnecessarily
>>          # weight 23.000
>>          alg straw
>>          hash 0  # rjenkins1
>>          item 1nrack weight 23.000
>> }
>>
>> # rules
>> rule data {
>>          ruleset 0
>>          type replicated
>>          min_size 1
>>          max_size 10
>>          step take default
>>          step chooseleaf firstn 0 type host
>>          step emit
>> }
>> rule metadata {
>>          ruleset 1
>>          type replicated
>>          min_size 1
>>          max_size 10
>>          step take default
>>          step chooseleaf firstn 0 type host
>>          step emit
>> }
>> rule rbd {
>>          ruleset 2
>>          type replicated
>>          min_size 1
>>          max_size 10
>>          step take default
>>          step chooseleaf firstn 0 type host
>>          step emit
>> }
>> rule backup {
>>          ruleset 3
>>          type replicated
>>          min_size 1
>>          max_size 10
>>          step take bak
>>          step chooseleaf firstn 0 type host
>>          step emit
>> }
>>
>> # end crush map
>>
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org 
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Caleb Miles
>> Sent: Tuesday, 7 August 2012 6:09 AM
>> To: ceph-devel@vger.kernel.org
>> Subject: Re: Crush not deliverying data uniformly -> HEALTH_ERR full osd
>>
>> Hello Paul,
>>
>> Could you post your CRUSH map, crushtool -d <CRUSH_MAP>
>>
>> caleb
>>
>> On Mon, Aug 6, 2012 at 1:01 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>>> ---------- Forwarded message ----------
>>> From: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
>>> Date: Sun, Aug 5, 2012 at 8:08 PM
>>> Subject: RE: Crush not deliverying data uniformly -> HEALTH_ERR full
>>> osd
>>> To: Yehuda Sadeh <yehuda@inktank.com>
>>> Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
>>>
>>>
>>> Hi Yehuda, we have:
>>>
>>> root@dsanb1-coy:/mnt/ceph# ceph osd dump | grep ^pool pool 0 'data'
>>> rep size 2 crush_ruleset 0 object_hash rjenkins pg_num
>>> 1472 pgp_num 1472 last_change 1 owner 0 crash_replay_interval 45 pool
>>> 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_num
>>> 1472 pgp_num 1472 last_change 1 owner 0 pool 2 'rbd' rep size 2
>>> crush_ruleset 2 object_hash rjenkins pg_num
>>> 1472 pgp_num 1472 last_change 1 owner 0 pool 3 'backup' rep size 1
>>> crush_ruleset 3 object_hash rjenkins pg_num
>>> 1472 pgp_num 1472 last_change 1 owner 0
>>>
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Yehuda Sadeh
>>> Sent: Monday, 6 August 2012 11:16 AM
>>> To: Paul Pettigrew
>>> Cc: ceph-devel@vger.kernel.org
>>> Subject: Re: Crush not deliverying data uniformly -> HEALTH_ERR full
>>> osd
>>>
>>> On Sun, Aug 5, 2012 at 5:16 PM, Paul Pettigrew
>>> <Paul.Pettigrew@mach.com.au> wrote:
>>>> Hi Ceph community
>>>>
>>>> We are at the stage of performance capacity testing, where
>>>> significant amounts of backup data is being written to Ceph.
>>>>
>>>> The issue we have, is that the underlying HDD's are not being
>>>> populated
>>>> (roughly) uniformly, and our Ceph system hits a brick wall after a
>>>> couple of days our 30TB storage system is no longer able to operate
>>>> after having only stored ~7TB.
>>>>
>>>> Basically, despite HDD's (1:1 ratio between OSD and HDD) all being
>>>> the same storage size and weighting in the Crushmap, we have disks 
>>>> either:
>>>> a) using 1% space;
>>>> b) using 48%; or
>>>> c) using 96%
>>>> Too precise a split to be an accident.  See below for more detail
>>>> (osd11-22 not expected to get data, per our crushmap):
>>>>
>>>>
>>>> ceph pg dump
>>>> <snip>
>>>> pool 0  2442    0       0       0       10240000000 7302520 7302520
>>>> pool 1  57      0       0       0       127824767 5603518 5603518
>>>> pool 2  0       0       0       0       0       0       0
>>>> pool 3  1808757 0       0       0       7584377697985 1104048 1104048
>>>>   sum    1811256 0       0       0       7594745522752 14010086
>>>> 14010086
>>>> osdstat kbused  kbavail kb      hb in   hb out
>>>> 0       930606904       1021178408      1953514584
>>>> [11,12,13,14,15,16,17,18,19,20,21,22]   []
>>>> 1       1874428 1949525164      1953514584
>>>> [11,12,13,14,15,16,17,18,19,20,21,22]   []
>>>> 2       928811428       1022963676      1953514584
>>>> [11,12,13,14,15,16,17,18,19,20,21,22]   []
>>>> 3       929733676       1022051996      1953514584
>>>> [11,12,13,14,15,16,17,18,19,20,21,22]   []
>>>> 4       1719124 1949678844      1953514584
>>>> [11,12,13,14,15,16,17,18,19,20,21,22]   []
>>>> 5       1853452 1949545892      1953514584
>>>> [11,12,13,14,15,16,17,18,19,20,21,22]   []
>>>> 6       930979476       1020807132      1953514584
>>>> [11,12,13,14,15,16,17,18,19,20,21,22]   []
>>>> 7       1808968 1949590496      1953514584
>>>> [11,12,13,14,15,16,17,18,19,20,21,22]   []
>>>> 8       934035924       1017759100      1953514584
>>>> [11,12,13,14,15,16,17,18,19,20,21,22]   []
>>>> 9       1855955384      94927432        1953514584
>>>> [11,12,13,14,15,16,17,18,19,20,21,22]   []
>>>> 10      933572004       1018232340      1953514584
>>>> [11,12,13,14,15,16,17,18,19,20,21,22]   []
>>>> 11      2057096 953060760       957230808
>>>> [0,1,2,3,4,5,6,7,8,9,10,17,18,19,20,21,22]      []
>>>> 12      2053512 953064656       957230808
>>>> [0,1,2,3,4,5,6,7,8,9,10,17,18,19,20,21,22]      []
>>>> 13      2148732 972501316       976762584
>>>> [0,1,2,3,4,5,6,7,8,9,10,17,18,19,20,21,22]      []
>>>> 14      2064640 972585104       976762584
>>>> [0,1,2,3,4,5,6,7,8,9,10,17,18,19,20,21,22]      []
>>>> 15      1945388 972703468       976762584
>>>> [0,1,2,3,4,5,6,7,8,9,10,17,18,19,20,21] []
>>>> 16      2051708 972599412       976762584
>>>> [0,1,2,3,4,6,7,8,9,10,17,18,19,20,21]   []
>>>> 17      2137632 952980216       957230808
>>>> [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]      []
>>>> 18      2000124 953117508       957230808
>>>> [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]      []
>>>> 19      2095124 972554492       976762584
>>>> [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]      []
>>>> 20      1986800 972662640       976762584
>>>> [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]      []
>>>> 21      2035204 972615332       976762584
>>>> [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]      []
>>>> 22      1961412 972687788       976762584
>>>> [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]      []
>>>>   sum    7475488140      25609393172     33131684328
>>>>
>>>> 2012-08-06 10:03:58.964716 7f06783bb700  0 -- 10.32.0.10:0/15147
>>>> send_keepalive con 0x223f690, no pipe.
>>>>
>>>>
>>>> root@dsanb1-coy:~# df -h
>>>> Filesystem                               Size  Used Avail Use% 
>>>> Mounted on
>>>> /dev/md0                                 462G   12G  446G 3% /
>>>> udev                                      12G  4.0K   12G 1% /dev
>>>> tmpfs                                    4.8G  448K  4.8G 1% /run
>>>> none                                     5.0M     0  5.0M 0% /run/lock
>>>> none                                      12G     0   12G 0% /run/shm
>>>> /dev/sdc                                 1.9T  888G  974G 48%
>>>> /ceph-data/osd.0
>>>> /dev/sdd                                 1.9T  1.8G  1.9T 1%
>>>> /ceph-data/osd.1
>>>> /dev/sdp                                 1.9T  891G  972G 48%
>>>> /ceph-data/osd.10
>>>> /dev/sde                                 1.9T  886G  976G 48%
>>>> /ceph-data/osd.2
>>>> /dev/sdf                                 1.9T  887G  975G 48%
>>>> /ceph-data/osd.3
>>>> /dev/sdg                                 1.9T  1.7G  1.9T 1%
>>>> /ceph-data/osd.4
>>>> /dev/sdh                                 1.9T  1.8G  1.9T 1%
>>>> /ceph-data/osd.5
>>>> /dev/sdi                                 1.9T  888G  974G 48%
>>>> /ceph-data/osd.6
>>>> /dev/sdm                                 1.9T  1.8G  1.9T 1%
>>>> /ceph-data/osd.7
>>>> /dev/sdn                                 1.9T  891G  971G 48%
>>>> /ceph-data/osd.8
>>>> /dev/sdo                                 1.9T  1.8T   91G 96%
>>>> /ceph-data/osd.9
>>>> 10.32.0.10,10.32.0.25,10.32.0.11:6789:/   31T  7.1T   24T 23% 
>>>> /mnt/ceph
>>>>
>>>>
>>>> We are writing via fstab based cephfs mounts, and the above is going
>>>> to pool3, which is a "backup" pool where we are testing replication
>>>> level of 1x only. This should not have any effect though? Below will
>>>> illustrate the layout we are using (above data writing issue is only
>>>> going to the first node per our testing design):
>>>>
>>>> root@dsanb1-coy:~# ceph osd tree
>>>> dumped osdmap tree epoch 136
>>>> # id    weight  type name       up/down reweight
>>>> -7      23      zone bak
>>>> -6      23              rack 1nrack
>>>> -2      11                      host dsanb1-coy
>>>> 0       2                               osd.0   up      1
>>>> 1       2                               osd.1   up      1
>>>> 10      2                               osd.10  up      1
>>>> 2       2                               osd.2   up      1
>>>> 3       2                               osd.3   up      1
>>>> 4       2                               osd.4   up      1
>>>> 5       2                               osd.5   up      1
>>>> 6       2                               osd.6   up      1
>>>> 7       2                               osd.7   up      1
>>>> 8       2                               osd.8   up      1
>>>> 9       2                               osd.9   up      1
>>>> -1      23      zone default
>>>> -3      23              rack 2nrack
>>>> -2      11                      host dsanb1-coy
>>>> 0       2                               osd.0   up      1
>>>> 1       2                               osd.1   up      1
>>>> 10      2                               osd.10  up      1
>>>> 2       2                               osd.2   up      1
>>>> 3       2                               osd.3   up      1
>>>> 4       2                               osd.4   up      1
>>>> 5       2                               osd.5   up      1
>>>> 6       2                               osd.6   up      1
>>>> 7       2                               osd.7   up      1
>>>> 8       2                               osd.8   up      1
>>>> 9       2                               osd.9   up      1
>>>> -4      6                       host dsanb2-coy
>>>> 11      1                               osd.11  up      1
>>>> 12      1                               osd.12  up      1
>>>> 13      1                               osd.13  up      1
>>>> 14      1                               osd.14  up      1
>>>> 15      1                               osd.15  up      1
>>>> 16      1                               osd.16  up      1
>>>> -5      6                       host dsanb3-coy
>>>> 17      1                               osd.17  up      1
>>>> 18      1                               osd.18  up      1
>>>> 19      1                               osd.19  up      1
>>>> 20      1                               osd.20  up      1
>>>> 21      1                               osd.21  up      1
>>>> 22      1                               osd.22  up      1
>>>>
>>>>
>>>> Has anybody got any suggestions?
>>>>
>>> How many pgs per pool do you have? Specifically:
>>> $ ceph osd dump | grep ^pool
>>>
>>> Thanks,
>>> Yehuda
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at http://vger.kernel.org/majordomo-info.html
>>
>>
>

