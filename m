From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: Performance testing to tune osd recovery sleep
Date: Fri, 28 Jul 2017 11:34:29 +0800
Message-ID: <CAEYCsVJzfXPBUfUgSZ167QvSMpgq6uXKAoTrVhWORmLMVjtzOg@mail.gmail.com>
References: <CAKn7kBkC6jQpJ6BycPW6cvJLaXbXEMFP-qBVVFHOGEHvO7FjfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33510 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbdG1Dea (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jul 2017 23:34:30 -0400
Received: by mail-oi0-f52.google.com with SMTP id a9so123494014oih.0
        for <ceph-devel@vger.kernel.org>; Thu, 27 Jul 2017 20:34:30 -0700 (PDT)
In-Reply-To: <CAKn7kBkC6jQpJ6BycPW6cvJLaXbXEMFP-qBVVFHOGEHvO7FjfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Neha Ojha <nojha@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Nana,

    Great testing.  One question,  do we have any idea why # of
degraded object keep increasing during recovery? and especially in
fio-rbd testing, there are multiple spike on each test.


Xiaoxi

2017-07-20 7:56 GMT+08:00 Neha Ojha <nojha@redhat.com>:
> Hi all,
>
> The osd recovery sleep option has been re-implemented to make it
> asynchronous. This value determines the sleep time in seconds before
> the next recovery or backfill op.
>
> We have done rigorous testing on HDDs, SSDs and HDD+SSD setups, with
> both Filestore and Bluestore, in order to come up with better default
> values for this configuration option. Detailed performance results can
> be found here: https://drive.google.com/file/d/0B7I5sSnjMhmbN1ZOanF3T2JIZm8/view?usp=sharing
>
> Following are some of our conclusions:
>
> - We need separate default values of osd_recovery_sleep for HDDs, SSDs
> and hybrid(HDD+SSD) setups.
>
> - In setups with only HDDs, increasing the amount of sleep time, shows
> performance improvement. However, the total time taken by background
> recovery operation also increases. We found that recovery sleep value
> of 0.1 sec is optimal for these kind of setups.
>
> - In setups with only SSDs, with increase in sleep value, we do not
> see any drastic improvement in performance. Therefore, we have decided
> to keep the sleep value 0, and not pay any extra price in terms of
> increased recovery time.
>
> - In hybrid setups, where osd data is on HDDs and osd journal is on
> SSDs, increasing the sleep value more than 0 helps, but we would like
> to choose a default value lesser than 0.1 sec in order to not increase
> the recovery time too much. We haven't finalized this value yet.
> Introducing this configuration option would require some more work, in
> terms of determining whether the journal is on HDD or SSD.
>
> With https://github.com/ceph/ceph/pull/16328, we are introducing two
> new configuration options osd_recovery_sleep_hdd and
> osd_recovery_sleep_ssd.
>
> Please let me know if you any thoughts about it or have trouble
> accessing the link.
>
> Thanks,
> Neha
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
