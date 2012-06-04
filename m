From: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Subject: Re: Stuck OSD phantom
Date: Mon, 04 Jun 2012 13:51:48 +0930
Message-ID: <4FCC37DC.9060902@bashkirtsev.com>
References: <4FCC166C.30202@bashkirtsev.com> <Pine.LNX.4.64.1206032105250.13750@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.logics.net.au ([150.101.56.178]:40909 "EHLO
	mail.logics.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab2FDEWI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 00:22:08 -0400
In-Reply-To: <Pine.LNX.4.64.1206032105250.13750@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/06/12 13:38, Sage Weil wrote:
> Hi Vladimir,
>
> On Mon, 4 Jun 2012, Vladimir Bashkirtsev wrote:
>> Dear devs,
>>
>> While playing around with ceph with six OSDs I decided to retire two OSDs
>> simultaneously (I do triplication so ceph should withstand such damage) to see
>> how ceph will cope with it. I was doing it in different ways trying to get
>> ceph off-rails and it looks I have managed it. :)
>>
>> First of all I have tried to kill OSDs by pulling them off and then doing ceph
>> osd lost . Performed as expected. However ceph kept record of former OSDs even
>> so it did not try to use it. Looks correct.
>>
>> Then I have recreated OSDs and magically they just came back online and filled
>> up with data again. Again: that's what is expected.
>>
>> At last I have tried planned removal of OSDs:
>>
>> ceph osd crush remove 3
>> ceph osd rm osd.3
>>
>> Ceph complained that osd is still up. Shutdown OSD, tried again. Success.
>> Done the same with second OSD. Everything looked fine still.
>>
>> And then accidentally (and that's perhaps good test) I have rebooted box
>> running osd.3 and it had ceph osd in rc. So osd.3 started without having
>> knowledge that it was evicted from cluster. Cluster magically took it back and
>> osd.3 joined the culster (however it did not got any load as it was removed
>> from crush). I removed it from rc, shut it down, done ceph osd crush remove 3
>> (just to be certain) and ceph osd rm osd.3 (both succeeded) but now I have
>> osd.3 still counted towards total cluster capacity, osd dump shows it as non
>> existent, pg dump shows it as it still member of a cluster:
>>
>> [root@x ceph]# ceph osd dump
>> dumped osdmap epoch 14892
>> epoch 14892
>> fsid 7719f573-4c48-4852-a27f-51c7a3fe1c1e
>> created 2012-03-31 04:47:12.130128
>> modifed 2012-06-04 11:16:57.687645
>> flags
>>
>> pool 0 'data' rep size 3 crush_ruleset 0 object_hash rjenkins pg_num 192
>> pgp_num 192 last_change 13812 owner 0 crash_replay_interval 45
>> pool 1 'metadata' rep size 3 crush_ruleset 1 object_hash rjenkins pg_num 192
>> pgp_num 192 last_change 13815 owner 0
>> pool 2 'rbd' rep size 3 crush_ruleset 2 object_hash rjenkins pg_num 192
>> pgp_num 192 last_change 13817 owner 0
>>
>> max_osd 6
>> osd.0 up   in  weight 1 up_from 14407 up_thru 14890 down_at 14400
>> last_clean_interval [14383,14399) 172.16.64.200:6801/25023
>> 172.16.64.200:6802/25023 172.16.64.200:6803/25023 exists,up
>> osd.1 up   in  weight 1 up_from 14420 up_thru 14890 down_at 14413
>> last_clean_interval [14388,14412) lost_at 11147 172.16.64.201:6800/5719
>> 172.16.64.201:6801/5719 172.16.64.201:6802/5719 exists,up
>> 2c7ca892-e83c-4158-a3ae-7c4f96f040b0
>> osd.4 up   in  weight 1 up_from 14432 up_thru 14890 down_at 14425
>> last_clean_interval [14393,14424) lost_at 13373 172.16.64.204:6800/17419
>> 172.16.64.204:6802/17419 172.16.64.204:6803/17419 exists,up
>> 19703275-74c3-403b-8647-85cc4f7ad870
>> osd.5 up   in  weight 1 up_from 14448 up_thru 14890 down_at 14438
>> last_clean_interval [14366,14437) 172.16.64.205:6800/7021
>> 172.16.64.205:6801/7021 172.16.64.205:6802/7021 exists,up
>> 699a39ca-3806-4c4f-9cdc-76cbed61b2ab
>>
>> [root@x ceph]# ceph pg dump
>> dumped all in format plain
>> version 2223459
>> last_osdmap_epoch 14892
>> last_pg_scan 12769
>> full_ratio 0.95
>> nearfull_ratio 0.85
>> <-snip->
>> pool 0    21404    0    0    0    40635329394    23681638    23681638
>> pool 1    114    0    0    0    234237438    4481899    4481899
>> pool 2    113241    0    2    0    473699447111    27387426    27387426
>>   sum    134759    0    2    0    514569013943    55550963    55550963
>> osdstat    kbused    kbavail    kb    hb in    hb out
>> 0    399440780    316714764    744751104    [1,4,5]    []
>> 1    400369588    125798956    546603008    [0,4,5]    []
>> 3    130380    90124804    94470144    [0,1,4,5]    []
>> 4    387384720    132412912    540409856    [0,1,5]    []
>> 5    344705816    233764680    600997888    [0,1,4]    []
>>   sum    1532031284    898816116    2527232000
>>
>> Any idea how to get rid of it completely?
> That is a bug; testing a fix now.  It's harmless, though, aside from
> slightly skewing the used/free stats you see from 'ceph pg stat' or 'df'.
>
> As a workaround, you can create the osd, and then mark it OUT (ceph osd
> out 3) first, and then delete it (ceph osd rm 3).  Or wait for the next
> release, and then recreate and re-delete (ceph osd rm 3) it.
>
> Thanks!
> sage
Thank you for quick response! Will wait for next version while trying to 
get ceph confused in other way. :)

Regards,
Vladimir
