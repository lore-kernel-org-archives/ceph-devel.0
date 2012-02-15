From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Repeated messages of "heartbeat_check: no heartbeat from"
Date: Wed, 15 Feb 2012 15:12:32 +0100
Message-ID: <4F3BBD50.3030905@widodh.nl>
References: <1312546310.2754.41.camel@wido-laptop.pcextreme.nl> <1312972246.2742.7.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:41217 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab2BOOMh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2012 09:12:37 -0500
Received: from [IPv6:2a00:f10:113:1:16da:e9ff:fe71:cc37] (unknown [IPv6:2a00:f10:113:1:16da:e9ff:fe71:cc37])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 3508C3FA57
	for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2012 15:12:33 +0100 (CET)
In-Reply-To: <1312972246.2742.7.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

On 08/10/2011 12:30 PM, Wido den Hollander wrote:
> Hi,
>
> I tried reproducing this today with the new heartbeat code, couldn't.
>
> The new heartbeat code seems to work much better under load, I haven't
> seen any bouncing like I saw before.

I'm still observing this bouncing, after a couple of days running my 
cluster the OSD's started to say they are down again.

[INF] osd.19 [2a00:f10:11b:cef0:225:90ff:fe33:49cc]:6809/14435 failed 
(by osd.4 [2a00:f10:11b:cef0:225:90ff:fe32:cf64]:6800/15389

[INF] osd.8 [2a00:f10:11b:cef0:225:90ff:fe33:49f2]:6806/15035 failed (by 
osd.25 [2a00:f10:11b:cef0:225:90ff:fe33:49ca]:6803/14344

[INF] osd.22 [2a00:f10:11b:cef0:225:90ff:fe33:497c]:6806/14527 failed 
(by osd.13 [2a00:f10:11b:cef0:225:90ff:fe33:49b0]:6803/14188

It's the same again, a couple of OSD's don't like eachother anymore and 
start marking the other as down.

My ceph.conf: http://zooi.widodh.nl/ceph/ceph.conf

I'm taking osd.19 and osd.4 here as example.

Some logs on Pastebin: http://pastebin.com/EYUHbPua

All systems are idle, so this can't be an issue of limited CPU cycles.

As this seems to keep coming back, what steps should we take next?

debug_ms and os are on 20.

What I noticed is that osd.4 never says: "osd.19 already has epoch 19", 
but that is I guess since it thinks osd.19 is down?

On osd.4 I never see I connection coming in from osd.19. I'm trying to 
figure out which of the two is wrong here.

Any suggestions?

Wido

>
> Wido
>
> On Fri, 2011-08-05 at 14:11 +0200, Wido den Hollander wrote:
>> Hi,
>>
>> I'm seeing something weird which I don't want to report in a issue yet
>> in the tracker.
>>
>> I suffered a pretty big crash which caused me to loose 15 of my 40 OSDs.
>> Some died because my WD Green 2TB disks failed, others since btrfs
>> didn't survive the hard reboot I had to give them.
>>
>> When watching 'ceph -w' I noticed this:
>>
>> 2011-08-05 13:32:03.209958    pg v504313: 8008 pgs: 1 inactive, 334
>> active+clean, 10 peering, 1 crashed+peering, 14 down+peering, 7 active
>> +clean+degraded, 7624 crashed+down+peering, 8 down+degraded+peering, 9
>> crashed+down+degraded+peering; 4417 GB data, 13121 GB used, 32504 GB /
>> 46575 GB avail; 8255/3391107 degraded (0.243%)
>> 2011-08-05 13:32:03.225712   mds e6033: 1/1/1 up {0=dga=up:replay(laggy
>> or crashed)}
>> 2011-08-05 13:32:03.225747   osd e9934: 40 osds: 25 up, 25 in
>> 2011-08-05 13:32:03.225874   log 2011-08-05 13:32:01.646596 mon0
>> [2a00:f10:113:1:230:48ff:fed3:b086]:6789/0 29796 : [INF] osd37
>> [2a00:f10:113:1:225:90ff:fe33:49a4]:6803/17881 failed (by osd7
>> [2a00:f10:113:1:225:90ff:fe32:cf64]:6806/2746)
>> 2011-08-05 13:32:03.225964   mon e1: 1 mons at
>> {dga=[2a00:f10:113:1:230:48ff:fed3:b086]:6789/0}
>> 2011-08-05 13:32:03.929650   log 2011-08-05 13:32:03.603681 mon0
>> [2a00:f10:113:1:230:48ff:fed3:b086]:6789/0 29797 : [INF] osd19
>> [2a00:f10:113:1:225:90ff:fe33:49cc]:6806/2740 failed (by osd5
>> [2a00:f10:113:1:225:90ff:fe32:cf64]:6800/2506)
>>
>> Here you see that osd5 is reporting that osd37 is down and osd7 is
>> reporting that osd19 is down.
>>
>> These messages keep being repeated, over and over. My 'debug ms' is at
>> 1, so I took a look at the logs:
>>
>> Aug  5 13:32:41 atom1 osd.5[2507]: 7f75227fc700 osd5 9963
>> heartbeat_check: no heartbeat from osd19 since 2011-08-04
>> 17:01:02.504942 (cutoff 2011-08-05 13:32:21.916364)
>> Aug  5 13:32:42 atom1 osd.5[2507]: 7f7531579700 osd5 9963
>> heartbeat_check: no heartbeat from osd19 since 2011-08-04
>> 17:01:02.504942 (cutoff 2011-08-05 13:32:22.381632)
>> Aug  5 13:32:43 atom1 osd.5[2507]: 7f7531579700 osd5 9965
>> heartbeat_check: no heartbeat from osd19 since 2011-08-04
>> 17:01:02.504942 (cutoff 2011-08-05 13:32:23.474198)
>> Aug  5 13:32:44 atom1 osd.5[2507]: 7f75227fc700 osd5 9965
>> heartbeat_check: no heartbeat from osd19 since 2011-08-04
>> 17:01:02.504942 (cutoff 2011-08-05 13:32:24.027161)
>>
>> osd5 keeps claiming that osd19 is down, but when I check the logs I see
>> that osd19 is running and exchanging heartbeat messages with the other
>> OSDs in the cluster.
>>
>> What seems odd to me is that there are no log messages about osd7
>> claiming that osd37 is down, although it keeps being repeated by 'ceph
>> -w'.
>>
>> $ ceph osd injectargs 7 '--debug-ms 1'
>> $ ceph osd injectargs 37 '--debug-ms 1'
>>
>> I made sure that was injected, but still, no log messages.
>>
>> Going through the logs a bit further (after setting the logging to 20) I
>> saw osd.19 reporting:
>>
>> Aug  5 13:48:23 atom4 osd.19[2741]: 7f634ca8e700 --
>> [2a00:f10:113:1:225:90ff:fe33:49cc]:6810/2740>>
>> [2a00:f10:113:1:225:90ff:fe32:cf64]:6808/2506 pipe(0x7f64e4193ec0 sd=56
>> pgs=1530 cs=1 l=0).reader got envelope type=70 src osd5 front=61 data=0
>> off 0
>>
>> It seems that it is communicating with osd5, but osd5 does not seem to
>> communicate with osd19?
>>
>> The log also confirms that:
>>
>> Aug  5 14:10:05 atom1 osd.5[2507]: 7f7531579700 --
>> [2a00:f10:113:1:225:90ff:fe32:cf64]:6800/2506 -->
>> [2a00:f10:113:1:230:48ff:fed3:b086]:6789/0 -- osd_failure(osd19
>> [2a00:f10:113:1:225:90ff:fe33:49cc]:6806/2740 e10020 v10020) v1 -- ?+0
>> 0x6948000 con 0x1cd7710
>> Aug  5 14:10:05 atom1 osd.5[2507]: 7f7531579700 --
>> [2a00:f10:113:1:225:90ff:fe32:cf64]:6800/2506 submit_message
>> osd_failure(osd19 [2a00:f10:113:1:225:90ff:fe33:49cc]:6806/2740 e10020
>> v10020) v1 remote [2a00:f10:113:1:230:48ff:fed3:b086]:6789/0
>> Aug  5 14:10:05 atom1 osd.5[2507]: 7f75365a1700 --
>> [2a00:f10:113:1:225:90ff:fe32:cf64]:6800/2506>>
>> [2a00:f10:113:1:230:48ff:fed3:b086]:6789/0 pipe(0x1cd74a0 sd=13 pgs=178
>> cs=1 l=1).writer encoding 17093 0x6948000 osd_failure(osd19
>> [2a00:f10:113:1:225:90ff:fe33:49cc]:6806/2740 e10020 v10020) v1
>>
>> Now, to prevent (I tried...) my cluster from bouncing around I placed
>> this in the OSD section:
>>
>>      osd min down reporters = 3
>>      osd min down reports = 5
>>
>> Since only osd5 and osd7 are sending out these messages osd19 nor osd37
>> get marked down, but what is going on here?
>>
>> I haven't restarted the OSDs yet.
>>
>> I noticed that the OSD heartbeat process is being revised currently, but
>> I thought it might be helpful to report this.
>>
>> Wido
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

