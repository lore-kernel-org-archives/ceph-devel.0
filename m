From: Neha Ojha <nojha@redhat.com>
Subject: Re: Performance testing to tune osd recovery sleep
Date: Fri, 28 Jul 2017 08:08:06 -0700
Message-ID: <CAKn7kBnsm6d1F7=TmNVp-H1uT4_jFJEyve+3d3YUrjWv7Co7Ww@mail.gmail.com>
References: <CAKn7kBkC6jQpJ6BycPW6cvJLaXbXEMFP-qBVVFHOGEHvO7FjfA@mail.gmail.com>
 <CAEYCsVJzfXPBUfUgSZ167QvSMpgq6uXKAoTrVhWORmLMVjtzOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34085 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbdG1PIH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jul 2017 11:08:07 -0400
Received: by mail-oi0-f42.google.com with SMTP id x3so131189227oia.1
        for <ceph-devel@vger.kernel.org>; Fri, 28 Jul 2017 08:08:07 -0700 (PDT)
In-Reply-To: <CAEYCsVJzfXPBUfUgSZ167QvSMpgq6uXKAoTrVhWORmLMVjtzOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Xiaoxi,

The number of degraded objects increase during recovery with rados
bench because new objects get created during the time recovery is
happening.

With fio, the total number of objects remain fixed. The spikes are
based on the way the experiment is set up. The number of degraded
objects increase when we kill an osd. That's the point where recovery
kicks in(in turn the spike) and after this, we wait for the cluster to
heal. Once the cluster heals, we bring the osd back up, and recovery
starts again, hence, the spikes of degraded objects increase again.
They eventually settle down when recovery gets over.

I hope this answers your question.

Thanks,
Neha

On Thu, Jul 27, 2017 at 8:34 PM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
> Hi Nana,
>
>     Great testing.  One question,  do we have any idea why # of
> degraded object keep increasing during recovery? and especially in
> fio-rbd testing, there are multiple spike on each test.
>
>
> Xiaoxi
>
> 2017-07-20 7:56 GMT+08:00 Neha Ojha <nojha@redhat.com>:
>> Hi all,
>>
>> The osd recovery sleep option has been re-implemented to make it
>> asynchronous. This value determines the sleep time in seconds before
>> the next recovery or backfill op.
>>
>> We have done rigorous testing on HDDs, SSDs and HDD+SSD setups, with
>> both Filestore and Bluestore, in order to come up with better default
>> values for this configuration option. Detailed performance results can
>> be found here: https://drive.google.com/file/d/0B7I5sSnjMhmbN1ZOanF3T2JIZm8/view?usp=sharing
>>
>> Following are some of our conclusions:
>>
>> - We need separate default values of osd_recovery_sleep for HDDs, SSDs
>> and hybrid(HDD+SSD) setups.
>>
>> - In setups with only HDDs, increasing the amount of sleep time, shows
>> performance improvement. However, the total time taken by background
>> recovery operation also increases. We found that recovery sleep value
>> of 0.1 sec is optimal for these kind of setups.
>>
>> - In setups with only SSDs, with increase in sleep value, we do not
>> see any drastic improvement in performance. Therefore, we have decided
>> to keep the sleep value 0, and not pay any extra price in terms of
>> increased recovery time.
>>
>> - In hybrid setups, where osd data is on HDDs and osd journal is on
>> SSDs, increasing the sleep value more than 0 helps, but we would like
>> to choose a default value lesser than 0.1 sec in order to not increase
>> the recovery time too much. We haven't finalized this value yet.
>> Introducing this configuration option would require some more work, in
>> terms of determining whether the journal is on HDD or SSD.
>>
>> With https://github.com/ceph/ceph/pull/16328, we are introducing two
>> new configuration options osd_recovery_sleep_hdd and
>> osd_recovery_sleep_ssd.
>>
>> Please let me know if you any thoughts about it or have trouble
>> accessing the link.
>>
>> Thanks,
>> Neha
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
