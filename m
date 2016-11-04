From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: Plugin for querying rgw metadata
Date: Thu, 3 Nov 2016 18:15:01 -0700
Message-ID: <CADRKj5RL0zZSQK-N_gqEM-fJmW7maw=MwGpY54UFeWwGo=0jwA@mail.gmail.com>
References: <8FC2060F93794D44942D588B8B547287121F993F@BPXM03GP.gisp.nec.co.jp>
 <CADRKj5RN4KWCHH9WhWYMRXsDi1L2x6ry6z_hHUcy426VbspQnQ@mail.gmail.com> <8FC2060F93794D44942D588B8B547287121FAA41@BPXM03GP.gisp.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34358 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752892AbcKDBPD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2016 21:15:03 -0400
Received: by mail-vk0-f41.google.com with SMTP id x186so55190011vkd.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2016 18:15:02 -0700 (PDT)
In-Reply-To: <8FC2060F93794D44942D588B8B547287121FAA41@BPXM03GP.gisp.nec.co.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hidekazu Nakamura <hid-nakamura@vf.jp.nec.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Haruhiko Katou <har-katou@ts.jp.nec.com>

On Thu, Nov 3, 2016 at 5:52 PM, Hidekazu Nakamura
<hid-nakamura@vf.jp.nec.com> wrote:
> Yahuda,
>
>> > I heard at OpenStack Summit Barcelona[*] that community will develop
>> plugin
>> > which put metadata into elasticsearch for querying metadata.
>> > Could anyone teach me spec of it?
>>
>> I sent an email to ceph-devel a while back describing it, here it is:
>>
>> http://www.spinics.net/lists/ceph-devel/msg32219.html
>
> Thank you for pointing.
> As far as I understand, My concern is not satisfied by this feature.
>
>> >
>> > My concern is whether operator could know object sync status between zones.
>>
>> 'radosgw-admin sync status' can be used to query each zone about the
>> sync status, but it's not a per-object granularity.
>
> Yes, 'radosgw-admin sync status' represents overall status between zones.
> Per-object is needed for disaster recovery purposes. Because multisite sync is
> asynchronous as you know, it's possible that object is uploaded only single zone
> when other zones are down.
> Does community have plan to develop sync status per-object granularity?
>

No immediate plan, but I created the following ticket:

http://tracker.ceph.com/issues/17795

This can be accomplished by iterating through the data shards,
gathering modified buckets list and then going through the bucket
indexes and get a list of all the objects that need to be synced.

Yehuda
