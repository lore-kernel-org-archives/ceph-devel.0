From: Peter Maloney <peter.maloney@brockmann-consult.de>
Subject: Re: global backfill reservation?
Date: Tue, 6 Jun 2017 16:51:54 +0200
Message-ID: <1c216fb8-6f80-d37c-8779-4309e33e95df@brockmann-consult.de>
References: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal>
 <CABZ+qqmtqL7Dgzu4XNsfyqgdJRZrkRXbfxRaRH+1bWg8zvDCBA@mail.gmail.com>
 <c59514c6-c817-dcea-ba16-4cc6003316de@brockmann-consult.de>
 <CABZ+qq=0FCRcoKAn88FradsW17s3d0aT4H5gAkXSbz_yY0fRaQ@mail.gmail.com>
 <dbe60a96-8873-6457-70f4-048b129376ff@brockmann-consult.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:60869 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdFFOwD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jun 2017 10:52:03 -0400
In-Reply-To: <dbe60a96-8873-6457-70f4-048b129376ff@brockmann-consult.de>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On 06/02/17 17:38, Sage Weil wrote:
> I don't see how this would be any different from a peering perspective.  
> The pattern of data movement and remapping would be different, but there's 
> no difference in this sequence that seems like it relate to peering 
> taking 10s of seconds.  :/
>
> How confident are you that this was a real effect?  Could it be that when 
> you tried the second method your disk caches were warm vs the first time 
> around when they were cold?
>
> sage


After the new disks are added, much more confident. See below... one
time I crush weighted 6 at once, with issues, and the other times it was
other disks, with no issues if I don't crush reweight too many at once.


On 06/04/17 00:58, Peter Maloney wrote:
> On 06/03/17 09:51, Dan van der Ster wrote:
>> On Fri, Jun 2, 2017 at 4:05 PM, Peter Maloney
>> <peter.maloney@brockmann-consult.de> wrote:
>>> ...
>>> And Sage, if that's true, then couldn't ceph by default just do the
>>> first kind of peering work before any pgs, pools, clients, etc. are
>>> affected, before moving on to the stuff that affects clients, regardless
>>> of which steps were used? At some point during adding t hose 2 nodes I
>>> was thinking how could ceph be so broken and mysterious... why does it
>>> just hang there? Would it do this during recovery of a dead osd too? Now
>>> I know how to avoid it and that it shouldn't affect recovering dead osds
>>> (not changing crush weight)... but it would be nice for all users not to
>>> ever think that way. :)
>>>
>>> ...
>> Here's what we do:
>>   1. Create and start new OSDs with initial crush weight = 0.0. No PGs
>> should re-peer when these are booted.
>>   2. Run the reweight script, e.g. like this for some 6T drives:
>>
>>    ceph-gentle-reweight -o osd.10,osd.11,osd.12 -l 15 -b 50 -d 0.01 -t 5.46
>>
>> In practice we've added >150 drives at once with that script -- using
>> that tiny delta.
>>
>> We use crush reweight because it "works for us (tm)". We haven't seen
>> any strange peering hangs, though we exercise this on hammer, not
>> (yet) jewel.
>> I hadn't thought of your method using osd reweight -- how do you add
>> new osds with an initial osd reweight? Maybe you create the osds in a
>> non-default root then move them after being reweighted to 0.0?
>>
>> Cheers, Dan
> I added them with crush weight 0, then my plan was to raise the weight
> like you do. That's basically what I did for all the other servers. But
> I fiddled with the crush map and had them in another root when I set the
> reweight 0, then weight 6, then moved them to root default (long
> peering), then reweight 1 (short peering). But that wasn't what I
> planned on doing or plan to do in the future.
>
> I expect that would be the same as crush weight 0 and in the normal root
> when created, then when ready for peering, set reweight 0 first, then
> crush weight 6, then after peering is done, reweight 1 for a few at a
> time (ceph osd reweight ...; sleep 2; while ceph health | grep peering;
> do sleep 1; done ...).
>
> The next step in this upgrade is to replace 18 2TB disks with 6TB
> ones... I'll do it that way and find out if it works without the extra root.

So I'm done removing the 18 2TB disks and adding the 6TB ones (plus
replacing a dead one). I did 6 disks at a time (all the 2TB disks on
each node).

I didn't test raising weight slowly, but I did test that setting the
weight straight to 6 on all at once (with reweight still 0) causes
client issues. (but reweight to 1 all at once, multi-process even, like
I do here works fine)

Here's the script that does the job well. First have the new osds
created with weight 0, and daemons running. Then this script finds them
by weight 0 and works with them:

> # list osds with hosts next to them for easy filtering with awk
> (doesn't support chassis, rack, etc. buckets)
> ceph_list_osd() {
>     ceph osd tree | awk '
>         BEGIN {found=0; host=""};
>         $3 == "host" {found=1; host=$4; getline};
>         $3 == "host" {found=0}
>         found || $3 ~ /osd\./ {print $0 " " host}'
> }
>
> peering_sleep() {
>     echo "sleeping"
>     sleep 2
>     while ceph health | grep -q peer; do
>         echo -n .
>         sleep 1
>     done
>     echo
>     sleep 5
> }
>
> # after an osd is already created, this reweights them to 'activate' them
> ceph_activate_osds() {
>     weight="$1"
>     host=$(hostname -s)
>     
>     if [ -z "$weight" ]; then
>         weight=6.00099
>     fi
>     
>     # for crush weight 0 osds, set reweight 0 so the crush weight
> non-zero won't cause as many blocked requests
>     for id in $(ceph_list_osd | awk '$2 == 0 {print $1}'); do
>         ceph osd reweight $id 0 &
>     done
>     wait
>     peering_sleep
>     
>     # the harsh reweight which we do slowly
>     for id in $(ceph_list_osd | awk -v host="$host" '$5 == 0 && $7 ==
> host {print $1}'); do
>         echo ceph osd crush reweight "osd.$id" "$weight"
>         ceph osd crush reweight "osd.$id" "$weight"
>         peering_sleep
>     done
>     
>     # the light reweight
>     for id in $(ceph_list_osd | awk -v host="$host" '$5 == 0 && $7 ==
> host {print $1}'); do
>         ceph osd reweight $id 1 &
>     done
>     wait
> }

and the ceph status in case it's somehow useful:
> root@ceph1:~ # ceph -s
>     cluster 684e4a3f-25fb-4b78-8756-62befa9be15e
>      health HEALTH_WARN
>             756 pgs backfill_wait
>             6 pgs backfilling
>             260 pgs degraded
>             183 pgs recovery_wait
>             260 pgs stuck degraded
>             945 pgs stuck unclean
>             60 pgs stuck undersized
>             60 pgs undersized
>             recovery 494450/38357551 objects degraded (1.289%)
>             recovery 26900171/38357551 objects misplaced (70.130%)
>      monmap e3: 3 mons at
> {ceph1=10.3.0.131:6789/0,ceph2=10.3.0.132:6789/0,ceph3=10.3.0.133:6789/0}
>             election epoch 614, quorum 0,1,2 ceph1,ceph2,ceph3
>       fsmap e322: 1/1/1 up {0=ceph2=up:active}, 2 up:standby
>      osdmap e119625: 60 osds: 60 up, 60 in; 933 remapped pgs
>             flags sortbitwise,require_jewel_osds
>       pgmap v19175947: 1152 pgs, 4 pools, 31301 GB data, 8172 kobjects
>             94851 GB used, 212 TB / 305 TB avail
>             494450/38357551 objects degraded (1.289%)
>             26900171/38357551 objects misplaced (70.130%)
>                  685 active+remapped+wait_backfill
>                  200 active+clean
>                  164 active+recovery_wait+degraded+remapped
>                   52 active+undersized+degraded+remapped+wait_backfill
>                   19 active+degraded+remapped+wait_backfill
>                   12 active+recovery_wait+degraded
>                    7 active+clean+scrubbing
>                    7 active+recovery_wait+undersized+degraded+remapped
>                    5 active+degraded+remapped+backfilling
>                    1 active+undersized+degraded+remapped+backfilling
> recovery io 900 MB/s, 240 objects/s
>   client io 79721 B/s rd, 10418 kB/s wr, 19 op/s rd, 137 op/s wr
>
> root@ceph1:~ # ceph osd tree
> ID WEIGHT    TYPE NAME      UP/DOWN REWEIGHT PRIMARY-AFFINITY
> -1 336.06061 root default                                     
> -2  64.01199     host ceph1                                   
>  0   4.00099         osd.0       up  0.61998          1.00000
>  1   4.00099         osd.1       up  0.59834          1.00000
>  2   4.00099         osd.2       up  0.79213          1.00000
> 27   4.00099         osd.27      up  0.69460          1.00000
> 30   6.00099         osd.30      up  0.73935          1.00000
> 31   6.00099         osd.31      up  0.81180          1.00000
> 10   6.00099         osd.10      up  0.64571          1.00000
> 12   6.00099         osd.12      up  0.94655          1.00000
> 13   6.00099         osd.13      up  0.75957          1.00000
> 14   6.00099         osd.14      up  0.77515          1.00000
> 15   6.00099         osd.15      up  0.74663          1.00000
> 16   6.00099         osd.16      up  0.93401          1.00000
> -3  64.01181     host ceph2                                   
>  3   4.00099         osd.3       up  0.69209          1.00000
>  4   4.00099         osd.4       up  0.75365          1.00000
>  5   4.00099         osd.5       up  0.80797          1.00000
> 28   4.00099         osd.28      up  0.66307          1.00000
> 32   6.00099         osd.32      up  0.81369          1.00000
> 33   6.00099         osd.33      up  1.00000          1.00000
>  9   6.00098         osd.9       up  0.58499          1.00000
> 17   6.00098         osd.17      up  0.90613          1.00000
> 18   6.00098         osd.18      up  0.73138          1.00000
> 19   6.00098         osd.19      up  0.80649          1.00000
> 20   6.00098         osd.20      up  0.51999          1.00000
> 21   6.00098         osd.21      up  0.79404          1.00000
> -4  64.01181     host ceph3                                   
>  6   4.00099         osd.6       up  0.56717          1.00000
>  7   4.00099         osd.7       up  0.72240          1.00000
>  8   4.00099         osd.8       up  0.79919          1.00000
> 29   4.00099         osd.29      up  0.80109          1.00000
> 34   6.00099         osd.34      up  0.71120          1.00000
> 35   6.00099         osd.35      up  0.63611          1.00000
> 11   6.00098         osd.11      up  0.67000          1.00000
> 22   6.00098         osd.22      up  0.80756          1.00000
> 23   6.00098         osd.23      up  0.67000          1.00000
> 24   6.00098         osd.24      up  0.71599          1.00000
> 25   6.00098         osd.25      up  0.64540          1.00000
> 26   6.00098         osd.26      up  0.76378          1.00000
> -5  72.01199     host ceph4                                   
> 36   6.00099         osd.36      up  0.74846          1.00000
> 37   6.00099         osd.37      up  0.71387          1.00000
> 38   6.00099         osd.38      up  0.71129          1.00000
> 39   6.00099         osd.39      up  0.76547          1.00000
> 40   6.00099         osd.40      up  0.73967          1.00000
> 41   6.00099         osd.41      up  0.64742          1.00000
> 42   6.00099         osd.42      up  0.81006          1.00000
> 44   6.00099         osd.44      up  0.65381          1.00000
> 45   6.00099         osd.45      up  0.77457          1.00000
> 46   6.00099         osd.46      up  0.82390          1.00000
> 47   6.00099         osd.47      up  0.85431          1.00000
> 43   6.00099         osd.43      up  0.64775          1.00000
> -6  72.01300     host ceph5                                   
> 48   6.00099         osd.48      up  0.71269          1.00000
> 49   6.00099         osd.49      up  0.97649          1.00000
> 50   6.00099         osd.50      up  0.98079          1.00000
> 51   6.00099         osd.51      up  0.75307          1.00000
> 52   6.00099         osd.52      up  0.86545          1.00000
> 53   6.00099         osd.53      up  0.64278          1.00000
> 54   6.00099         osd.54      up  0.94551          1.00000
> 55   6.00099         osd.55      up  0.73465          1.00000
> 56   6.00099         osd.56      up  0.69908          1.00000
> 57   6.00099         osd.57      up  0.78789          1.00000
> 58   6.00099         osd.58      up  0.89081          1.00000
> 59   6.00099         osd.59      up  0.66379          1.00000

