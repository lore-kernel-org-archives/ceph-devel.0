From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: full_ratios - please explain?
Date: Wed, 18 Feb 2015 10:21:41 -0500
Message-ID: <CAGbvivKMg+BnbG2JcAAFMjDwO4u_WGb1q26MbvCa-08TUtPT-Q@mail.gmail.com>
References: <CAGbvivJ89toPvbO8XOQ8ru_BDQJbJfZvbj2NhxFk1G5K=d-3Zw@mail.gmail.com>
	<54E4AA53.2020900@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:58934 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbbBRPVm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Feb 2015 10:21:42 -0500
Received: by mail-ob0-f169.google.com with SMTP id wp4so3110237obc.0
        for <ceph-devel@vger.kernel.org>; Wed, 18 Feb 2015 07:21:41 -0800 (PST)
In-Reply-To: <54E4AA53.2020900@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

Thanks!  More below inline...

On Wed, Feb 18, 2015 at 10:05 AM, Wido den Hollander <wido@42on.com> wrote:
> On 18-02-15 15:39, Wyllys Ingersoll wrote:
>> Can someone explain the interaction and effects of all of these
>> "full_ratio" parameters?  I havent found any real good explanation of how
>> they affect the distribution of data once the cluster gets above the
>> "nearfull" and close to the "close" ratios.
>>
>
> When only ONE (1) OSD goes over the mon_osd_nearfull_ratio the cluster
> goes from HEALTH_OK into HEALTH_WARN state.
>
>>
>> mon_osd_full_ratio
>> mon_osd_nearfull_ratio
>>
>> osd_backfill_full_ratio
>> osd_failsafe_full_ratio
>> osd_failsafe_nearfull_ratio
>>
>> We have a cluster with about 144 OSDs (518 TB) and trying to get it to a
>> 90% full rate for testing purposes.
>>
>> We've found that when some of the OSDs get above the mon_osd_full_ratio
>> value (.95 in our system), then it stops accepting any new data, even
>> though there is plenty of space left on other OSDs that are not yet even up
>> to 90%.  Tweaking the osd_failsafe ratios enabled data to move again for a
>> bit, but eventually it becomes unbalanced and stops working again.
>>
>
> Yes, that is because with Ceph safety goes first. When only one OSD goes
> over the full ratio the whole cluster stops I/O.



Which full_ratio?  The problem is that there are at least 3
"full_ratios" - mon_osd_full_ratio, osd_failsafe_full_ratio, and
osd_backfill_full_ratio - how do they interact? What is the
consequence of having one be higher than the others?


Its seems extreme that 1 full osd out of potentially hundreds would
cause all IO into the cluster to stop when there are literally 10s or
100s of terrabytes of space left on other, less-full OSDs.

The confusion for me (and probably for others) is the proliferation of
"full_ratio" parameters and a lack of clarity on how they all affect
the cluster health and ability to balance when things start to fill
up.


>
> CRUSH does not take OSD utilization into account when placing data, so
> it's almost impossible to predict which I/O can continue.
>
> Data safety and integrity is priority number 1. Full disks are a danger
> to those priorities, so I/O is stopped.


Understood, but 1 full disk out of hundreds should not cause the
entire system to stop accepting new data or even balancing out the
data that it already has especially when there is room to grow yet on
other OSDs.

If 1 disk reaches the "full_ratio", but 99 (or 999) others are still
well below that value, why doesn't it get balanced out ( assuming the
crush map considers all OSDs equal and all the pools have similar
pg_num values) ?
