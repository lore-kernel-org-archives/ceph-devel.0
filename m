From: Mark Nigh <mnigh@netelligent.com>
Subject: RE: MDS Stuck In Replay
Date: Wed, 22 Jun 2011 15:30:07 -0500
Message-ID: <B828A4C02BE12543ACDFCF7EB0C693C678862530A6@NC-SVR-09.netelligent.com>
References: <B828A4C02BE12543ACDFCF7EB0C693C67886252F0F@NC-SVR-09.netelligent.com>
 <Pine.LNX.4.64.1106211545340.28760@cobra.newdream.net>
 <B828A4C02BE12543ACDFCF7EB0C693C67886252F3B@NC-SVR-09.netelligent.com>
 <18981DE9-A820-44EF-B5F7-B18C14C16C96@hq.newdream.net>
 <B828A4C02BE12543ACDFCF7EB0C693C6788625305D@NC-SVR-09.netelligent.com>
 <C87D8994-9C53-4712-8351-9C09FEFABAA6@hq.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.netelligent.com ([199.255.228.152]:56976 "EHLO
	NC-SVR-132.netelligent.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758541Ab1FVUaL convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Jun 2011 16:30:11 -0400
In-Reply-To: <C87D8994-9C53-4712-8351-9C09FEFABAA6@hq.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks for your help.

I think I can summarize my problems due to the inconsistent version I was running between nodes. Once I used your git steps below, I have consistent versions and I am working. My mds is in active state and my clients are able to read/write to the f/s.

Thanks!!

Mark Nigh

-----Original Message-----
From: Gregory Farnum [mailto:gregf@hq.newdream.net]
Sent: Wednesday, June 22, 2011 3:11 PM
To: Mark Nigh
Cc: ceph-devel@vger.kernel.org
Subject: Re: MDS Stuck In Replay

On Jun 22, 2011, at 12:25 PM, Mark Nigh wrote:

> I am having a few problems with getting consistent commit when I build from source. My apologies, but my experience with git is limited at best.
>
> After I clone, I have been issueing the following command git checkout master but on my second ceph server I am getting the following version:
>
> ceph version 0.29.1-374-gbfe0d55 (commit:bfe0d55c8f734e985046a02fb2126bf601b1a353)
>
> On my ceph001, which is the mds and mon, I get 0.29.1-4...
I'm not quite sure what you mean (we can help you out live if you want to come into the channel), but to update you want to run:
git fetch origin
git reset --hard origin/master

("git pull" should also work but the above is more resilient if we make history changes.)

And then build. Also, we update master pretty often, so you'll want to make sure you've got build products from the same source on all your nodes. You can either do that by copying the binaries around (if the nodes are the same), or cloning your own local copy of the tree from all the nodes that build source.

Not sure what this backtrace could be (we'll need a log or the gdb backtrace to debug it further) but let's get you building fresh code first and see if it's still an issue.
-Greg

> I am also experiencing an issue now that after I start the cmds daemon. I get the following in the logs.
>
> 2011-06-22 14:21:38.880790 7fe039600700 -- 10.6.1.80:6800/9285 >> 10.6.1.80:6804/8857 pipe(0x1ab7000 sd=6 pgs=6 cs=1 l=1).writer: state = 2 policy.server=0
> 2011-06-22 14:21:38.880809 7fe03b705700 -- 10.6.1.80:6800/9285 dispatch_throttle_release 559839 to dispatch throttler 559839/104857600
> mds/LogEvent.cc: In function 'static LogEvent* LogEvent::decode(ceph::bufferlist&)', in thread '0x7fe038df8700'
> mds/LogEvent.cc: 91: FAILED assert(p.end())
> ceph version 0.29.1-4-g93623fb (commit:93623fba99f61207baacd1c46a44769e5118468f)
> 1: (LogEvent::decode(ceph::buffer::list&)+0x36e) [0x67e76e]
> 2: (MDLog::_replay_thread()+0x71d) [0x67aa8d]
> 3: (MDLog::ReplayThread::entry()+0xd) [0x4af55d]
> 4: (()+0x68ba) [0x7fe03e55b8ba]
> 5: (clone()+0x6d) [0x7fe03d1f002d]
> ceph version 0.29.1-4-g93623fb (commit:93623fba99f61207baacd1c46a44769e5118468f)
> 1: (LogEvent::decode(ceph::buffer::list&)+0x36e) [0x67e76e]
> 2: (MDLog::_replay_thread()+0x71d) [0x67aa8d]
> 3: (MDLog::ReplayThread::entry()+0xd) [0x4af55d]
> 4: (()+0x68ba) [0x7fe03e55b8ba]
> 5: (clone()+0x6d) [0x7fe03d1f002d]
> *** Caught signal (Aborted) **
> in thread 0x7fe038df8700
> ceph version 0.29.1-4-g93623fb (commit:93623fba99f61207baacd1c46a44769e5118468f)
> 1: /usr/bin/cmds() [0x703252]
> 2: (()+0xef60) [0x7fe03e563f60]
> 3: (gsignal()+0x35) [0x7fe03d153165]
> 4: (abort()+0x180) [0x7fe03d155f70]
> 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fe03d9e6dc5]
> 6: (()+0xcb166) [0x7fe03d9e5166]
> 7: (()+0xcb193) [0x7fe03d9e5193]
> 8: (()+0xcb28e) [0x7fe03d9e528e]
> 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x373) [0x6cc793]
> 10: (LogEvent::decode(ceph::buffer::list&)+0x36e) [0x67e76e]
> 11: (MDLog::_replay_thread()+0x71d) [0x67aa8d]
> 12: (MDLog::ReplayThread::entry()+0xd) [0x4af55d]
> 13: (()+0x68ba) [0x7fe03e55b8ba]
> 14: (clone()+0x6d) [0x7fe03d1f002d]
>
> I will try deleting the /ceph directory and re-cloning.
>
> Thanks,
>
> Mark Nigh
> Systems Architect
>
>
>
> -----Original Message-----
> From: Gregory Farnum [mailto:gregf@hq.newdream.net]
> Sent: Tuesday, June 21, 2011 11:27 PM
> To: Mark Nigh
> Cc: Sage Weil; ceph-devel@vger.kernel.org
> Subject: Re: MDS Stuck In Replay
>
> This looks like a bug we had in our master branch for about 12 hours. Assuming you built from source, pull the latest master and try again. :)
>
> -Greg
>
> On Jun 21, 2011, at 5:26 PM, Mark Nigh <mnigh@netelligent.com> wrote:
>
>> As you can see, two (2) of the OSDs are down and out. They weren't when I first wrote the post.
>>
>> root@ceph001:~# ceph osd dump -o -
>> 2011-06-21 19:20:52.025776 mon <- [osd,dump]
>> 2011-06-21 19:20:52.026506 mon0 -> 'dumped osdmap epoch 612' (0)
>> epoch 612
>> fsid f1082578-eb4d-cdd7-4da2-5e6293396315
>> created 2011-06-20 16:05:04.711991
>> modifed 2011-06-21 18:15:33.498931
>> flags
>>
>> pg_pool 0 'data' pg_pool(rep pg_size 2 crush_ruleset 0 object_hash rjenkins pg_num 128 pgp_num 128 lpg_num 2 lpgp_num 2 last_change 1 owner 0)
>> pg_pool 1 'metadata' pg_pool(rep pg_size 2 crush_ruleset 1 object_hash rjenkins pg_num 128 pgp_num 128 lpg_num 2 lpgp_num 2 last_change 1 owner 0)
>> pg_pool 2 'rbd' pg_pool(rep pg_size 2 crush_ruleset 2 object_hash rjenkins pg_num 128 pgp_num 128 lpg_num 2 lpgp_num 2 last_change 1 owner 0)
>>
>> max_osd 4
>> osd0 up   in  weight 1 up_from 597 up_thru 611 down_at 596 last_clean_interval 2-595 10.6.1.80:6801/1891 10.6.1.80:6802/1891 10.6.1.80:6803/1891
>> osd1 up   in  weight 1 up_from 597 up_thru 611 down_at 596 last_clean_interval 3-595 10.6.1.80:6804/1982 10.6.1.80:6805/1982 10.6.1.80:6806/1982
>> osd2 down out up_from 596 up_thru 597 down_at 605 last_clean_interval 590-594
>> osd3 down out up_from 596 up_thru 597 down_at 605 last_clean_interval 593-594
>>
>> They start up fine.
>>
>> root@ceph002:~# /etc/init.d/ceph start osd2
>> === osd.2 ===
>> Mounting Btrfs on ceph002:/mnt/osd2
>> Scanning for Btrfs filesystems
>> failed to read /dev/sr0
>> Starting Ceph osd.2 on ceph002...
>> ** WARNING: Ceph is still under development.  Any feedback can be directed  **
>> **          at ceph-devel@vger.kernel.org or http://ceph.newdream.net/.     **
>> starting osd2 at 0.0.0.0:6800/8620 osd_data /mnt/osd2 /data/osd2/journal
>> root@ceph002:~# /etc/init.d/ceph start osd3
>> === osd.3 ===
>> Mounting Btrfs on ceph002:/mnt/osd3
>> Scanning for Btrfs filesystems
>> failed to read /dev/sr0
>> Starting Ceph osd.3 on ceph002...
>> ** WARNING: Ceph is still under development.  Any feedback can be directed  **
>> **          at ceph-devel@vger.kernel.org or http://ceph.newdream.net/.     **
>> starting osd3 at 0.0.0.0:6803/8769 osd_data /mnt/osd3 /data/osd3/journal
>>
>> But I do get these messages in the osd logs
>>
>> 2011-06-21 19:24:27.937179 7f93df30d700 -- 10.6.1.81:6801/8620 >> 10.6.1.81:6806/8769 pipe(0x30f7a00 sd=19 pgs=0 cs=0 l=0).accept bad authorizer
>> 2011-06-21 19:24:27.937254 7f93df30d700 AuthNoneAuthorizeHandle::verify_authorizer() failed to decode
>> 2011-06-21 19:24:27.937270 7f93df30d700 -- 10.6.1.81:6801/8620 >> 10.6.1.81:6806/8769 pipe(0x30f7a00 sd=19 pgs=0 cs=0 l=0).accept bad authorizer
>>
>> Here are the rule output.
>>
>> root@ceph001:~# crushtool -i cm --test --rule 0
>> devices weights (hex): [10000,10000,10000,10000]
>> rule 0 (data), x = 0..9999
>> device 0:      5013
>> device 1:      4987
>> device 2:      4963
>> device 3:      5037
>> num results 2: 10000
>>
>> root@ceph001:~# crushtool -i cm --test --rule 1
>> devices weights (hex): [10000,10000,10000,10000]
>> rule 1 (metadata), x = 0..9999
>> device 0:      5010
>> device 1:      5037
>> device 2:      4975
>> device 3:      4978
>> num results 2: 10000
>>
>>
>> Thanks for your assistance.
>>
>> Mark Nigh
>> Systems Architect
>> mnigh@netelligent.com
>> (p) 314.392.6926
>>
>>
>>
>> -----Original Message-----
>> From: Sage Weil [mailto:sage@newdream.net]
>> Sent: Tuesday, June 21, 2011 5:49 PM
>> To: Mark Nigh
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: MDS Stuck In Replay
>>
>> On Tue, 21 Jun 2011, Mark Nigh wrote:
>>> I am currently testing Ceph on Debian v6.0 (2.6.32) on the following system:
>>>
>>> 2 servers each with 2 HDD and 1 osd per HDD for a total of 4 OSD
>>> The 1st server has a one (1) mds and mon.
>>>
>>> Ceph gets built and functioning correctly but I think it is when I
>>> change my crushmap so that no data is stored on a single server that I
>>> get my mds in replay. I also get some pgs in peering. See below.
>>
>> If there are PGs in peering it will block MDS replay, so that's the core
>> issue.
>>
>> Can you include the 'ceph osd dump -o -' output so we can verify the
>> object pools are using the data and metadata crush rules?
>>
>> You can also verify that the individual crush rules are working with
>> something like
>>
>> $ ceph osd getcrushmap -o cm
>> 2011-06-21 15:44:09.434742 mon <- [osd,getcrushmap]
>> 2011-06-21 15:44:09.435168 mon0 -> 'got crush map from osdmap epoch 2' (0)
>> 2011-06-21 15:44:09.435370 7f8fd5b22720  wrote 320 byte payload to cm
>> $ crushtool -i cm --test --rule 0
>> devices weights (hex): [10000]
>> rule 0 (data), x = 0..9999
>> device 0:      10000
>> num results 1: 10000
>> $ crushtool -i cm --test --rule 1
>> devices weights (hex): [10000]
>> rule 1 (metadata), x = 0..9999
>> device 0:      10000
>> num results 1: 10000
>>
>> In your case you should see the objects split between 4 OSDs, not the 1 I
>> currently have running on my dev box.
>>
>> sage
>>
>>
>>>
>>> 2011-06-21 16:49:01.551129    pg v1497: 396 pgs: 272 active+clean, 124 peering; 374 MB data, 773 MB used, 11117 GB / 11118 GB avail
>>> 2011-06-21 16:49:01.551817   mds e10: 1/1/1 up {0=0=up:replay}
>>> 2011-06-21 16:49:01.551836   osd e602: 4 osds: 4 up, 4 in
>>> 2011-06-21 16:49:01.551898   log 2011-06-21 16:41:46.966074 mon0 10.6.1.80:6789/0 1 : [INF] mon.0@0 won leader election with quorum 0
>>> 2011-06-21 16:49:01.551947   mon e1: 1 mons at {0=10.6.1.80:6789/0}
>>>
>>> My crushmap is as follows:
>>>
>>> # begin crush map
>>>
>>> # devices
>>> device 0 device0
>>> device 1 device1
>>> device 2 device2
>>> device 3 device3
>>>
>>> # types
>>> type 0 device
>>> type 1 host
>>> type 2 root
>>>
>>> # buckets
>>> host host0 {
>>>       id -1           # do not change unnecessarily
>>>       # weight 2.000
>>>       alg straw
>>>       hash 0  # rjenkins1
>>>       item device0 weight 1.000
>>>       item device1 weight 1.000
>>> }
>>> host host1 {
>>>       id -2           # do not change unnecessarily
>>>       # weight 2.000
>>>       alg straw
>>>       hash 0  # rjenkins1
>>>       item device2 weight 1.000
>>>       item device3 weight 1.000
>>> }
>>> root root {
>>>       id -3           # do not change unnecessarily
>>>       # weight 2.000
>>>       alg straw
>>>       hash 0  # rjenkins1
>>>       item host0 weight 1.000
>>>       item host1 weight 1.000
>>> }
>>>
>>> # rules
>>> rule data {
>>>       ruleset 0
>>>       type replicated
>>>       min_size 1
>>>       max_size 10
>>>       step take root
>>>       step chooseleaf firstn 0 type host
>>>       step emit
>>> }
>>> rule metadata {
>>>       ruleset 1
>>>       type replicated
>>>       min_size 1
>>>       max_size 10
>>>       step take root
>>>       step choose firstn 0 type device
>>>       step emit
>>> }
>>>
>>> I tried to restart the mds daemon with no luck. Here are a few lines of the mds log. Let me know if there is anything else I can provide.
>>>
>>> 2011-06-21 16:50:44.047829 7f2fa8483700 -- 10.6.1.80:6800/19997 >> 10.6.1.80:6789/0 pipe(0x281d280 sd=10 pgs=1 cs=1 l=1).reader got message 141 0x283e780 mdsbeacon(4221/0 up:replay seq 141 v10) v2
>>> 2011-06-21 16:50:44.047892 7f2fac6fe700 -- 10.6.1.80:6800/19997 >> 10.6.1.80:6789/0 pipe(0x281d280 sd=10 pgs=1 cs=1 l=1).writer: state = 2 policy.server=0
>>> 2011-06-21 16:50:44.047918 7f2fac6fe700 -- 10.6.1.80:6800/19997 >> 10.6.1.80:6789/0 pipe(0x281d280 sd=10 pgs=1 cs=1 l=1).write_ack 141
>>> 2011-06-21 16:50:44.047944 7f2fac6fe700 -- 10.6.1.80:6800/19997 >> 10.6.1.80:6789/0 pipe(0x281d280 sd=10 pgs=1 cs=1 l=1).writer: state = 2 policy.server=0
>>> 2011-06-21 16:50:44.047969 7f2fa9485700 -- 10.6.1.80:6800/19997 <== mon0 10.6.1.80:6789/0 141 ==== mdsbeacon(4221/0 up:replay seq 141 v10) v2 ==== 103+0+0 (2350252520 0 0) 0x283e780 con 0x283d140
>>> 2011-06-21 16:50:44.047986 7f2fa9485700 -- 10.6.1.80:6800/19997 dispatch_throttle_release 103 to dispatch throttler 103/104857600
>>> 2011-06-21 16:50:44.058654 7f2fa8382700 -- 10.6.1.80:6800/19997 --> osd2 10.6.1.81:6800/1826 -- ping v1 -- ?+0 0x2841300
>>> 2011-06-21 16:50:44.058677 7f2fa8382700 -- 10.6.1.80:6800/19997 --> osd0 10.6.1.80:6801/1891 -- ping v1 -- ?+0 0x2841180
>>> 2011-06-21 16:50:44.058701 7f2fa6d7a700 -- 10.6.1.80:6800/19997 >> 10.6.1.81:6800/1826 pipe(0x2836a00 sd=9 pgs=7 cs=1 l=1).writer: state = 2 policy.server=0
>>> 2011-06-21 16:50:44.058730 7f2fa6d7a700 -- 10.6.1.80:6800/19997 >> 10.6.1.81:6800/1826 pipe(0x2836a00 sd=9 pgs=7 cs=1 l=1).writer: state = 2 policy.server=0
>>> 2011-06-21 16:50:44.058765 7f2fa727f700 -- 10.6.1.80:6800/19997 >> 10.6.1.80:6801/1891 pipe(0x281dc80 sd=7 pgs=6 cs=1 l=1).writer: state = 2 policy.server=0
>>> 2011-06-21 16:50:44.058810 7f2fa727f700 -- 10.6.1.80:6800/19997 >> 10.6.1.80:6801/1891 pipe(0x281dc80 sd=7 pgs=6 cs=1 l=1).writer: state = 2 policy.server=0
>>>
>>> Mark Nigh
>>> Systems Architect
>>> Netelligent Corporation
>>>
>>>
>>>
>>> This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>> This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.


This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
