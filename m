From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: full_ratios - please explain?
Date: Wed, 18 Feb 2015 10:53:58 -0500
Message-ID: <CAGbvivKWi8gEqxpmUbivN1tJC7JgAXVxUFS+jqUqOunCyMffAQ@mail.gmail.com>
References: <CAGbvivJ89toPvbO8XOQ8ru_BDQJbJfZvbj2NhxFk1G5K=d-3Zw@mail.gmail.com>
	<54E4AA53.2020900@42on.com>
	<CAGbvivKMg+BnbG2JcAAFMjDwO4u_WGb1q26MbvCa-08TUtPT-Q@mail.gmail.com>
	<alpine.DEB.2.00.1502180726420.22050@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:55588 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbbBRPx7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Feb 2015 10:53:59 -0500
Received: by mail-ob0-f178.google.com with SMTP id uz6so3385591obc.9
        for <ceph-devel@vger.kernel.org>; Wed, 18 Feb 2015 07:53:59 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502180726420.22050@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel@vger.kernel.org

OK, thanks for the clarifications!

-Wyllys


On Wed, Feb 18, 2015 at 10:52 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 18 Feb 2015, Wyllys Ingersoll wrote:
>> Thanks!  More below inline...
>>
>> On Wed, Feb 18, 2015 at 10:05 AM, Wido den Hollander <wido@42on.com> wrote:
>> > On 18-02-15 15:39, Wyllys Ingersoll wrote:
>> >> Can someone explain the interaction and effects of all of these
>> >> "full_ratio" parameters?  I havent found any real good explanation of how
>> >> they affect the distribution of data once the cluster gets above the
>> >> "nearfull" and close to the "close" ratios.
>> >>
>> >
>> > When only ONE (1) OSD goes over the mon_osd_nearfull_ratio the cluster
>> > goes from HEALTH_OK into HEALTH_WARN state.
>> >
>> >>
>> >> mon_osd_full_ratio
>> >> mon_osd_nearfull_ratio
>> >>
>> >> osd_backfill_full_ratio
>> >> osd_failsafe_full_ratio
>> >> osd_failsafe_nearfull_ratio
>> >>
>> >> We have a cluster with about 144 OSDs (518 TB) and trying to get it to a
>> >> 90% full rate for testing purposes.
>> >>
>> >> We've found that when some of the OSDs get above the mon_osd_full_ratio
>> >> value (.95 in our system), then it stops accepting any new data, even
>> >> though there is plenty of space left on other OSDs that are not yet even up
>> >> to 90%.  Tweaking the osd_failsafe ratios enabled data to move again for a
>> >> bit, but eventually it becomes unbalanced and stops working again.
>> >>
>> >
>> > Yes, that is because with Ceph safety goes first. When only one OSD goes
>> > over the full ratio the whole cluster stops I/O.
>>
>>
>>
>> Which full_ratio?  The problem is that there are at least 3
>> "full_ratios" - mon_osd_full_ratio, osd_failsafe_full_ratio, and
>> osd_backfill_full_ratio - how do they interact? What is the
>> consequence of having one be higher than the others?
>
> mon_osd_full_ratio (.95) ... when any OSD reaches this threshold the
> monitor marks the cluster as 'full' and client writes are not accepted.
>
> mon_osd_nearfull_ratio (.85) ... when any OSD reaches this threshold the
> cluster goes HEALTH_WARN and calls out near-full OSDs.
>
> osd_backfill_full_ratio (.85) ... when an OSD locally reaches this
> threshold it will refuse to migrate a PG to itself.  This prevents
> rebalancing or repair from overfilling an OSD.  It should be lower than
> the
>
> The osd_failsafe_full_ratio (.97) is a final sanity check that makes the
> OSD throw out writes if it is really close to full.
>
> It's bad news if an OSD fills up completely so we do what we can to
> prevent it.
>
>> Its seems extreme that 1 full osd out of potentially hundreds would
>> cause all IO into the cluster to stop when there are literally 10s or
>> 100s of terrabytes of space left on other, less-full OSDs.
>
> Yes, but the nature of hash-based distribution is that you don't know
> where a write will go, so you don't want to let the cluster fill up.  85%
> is pretty conservative; you could increase it if you're comfortable.  Just
> be aware that file systems over 80% start to get very slow so it is a
> bad idea to run them this full anyway.
>
>> The confusion for me (and probably for others) is the proliferation of
>> "full_ratio" parameters and a lack of clarity on how they all affect
>> the cluster health and ability to balance when things start to fill
>> up.
>>
>>
>> >
>> > CRUSH does not take OSD utilization into account when placing data, so
>> > it's almost impossible to predict which I/O can continue.
>> >
>> > Data safety and integrity is priority number 1. Full disks are a danger
>> > to those priorities, so I/O is stopped.
>>
>>
>> Understood, but 1 full disk out of hundreds should not cause the
>> entire system to stop accepting new data or even balancing out the
>> data that it already has especially when there is room to grow yet on
>> other OSDs.
>
> The "proper" response to this currently is that if an OSD reaches the
> lower nearfull threshold the admin gets a warning and triggers some
> rebalancing.  That's why it's 10% lower then the actual full cutoff--there
> is plenty of time to adjust weights and/or expand the cluster.
>
> It's not an ideal approach, perhaps, but it's simple and works well
> enough.  And it's not clear that there's is anything better we can do that
> isn't also very complicated...
>
> sage
