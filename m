From: Vedant Nanda <vedant15114@iiitd.ac.in>
Subject: Re: gsoc proposal review
Date: Sun, 2 Apr 2017 16:07:41 +0530
Message-ID: <CAL-vruMWB4tHNP9q_u=mEr4-FD5L1JporzsPuw7pDJ83GeV1mw@mail.gmail.com>
References: <CAJE9aON8KMVwab6YZ2gVgG2aBprG3WzqjLiu+8mn=OY=R7Ui=Q@mail.gmail.com>
 <CAL-vruOHvvux=Z82pcEiUD+_j1JWWbe2JGckxsQo1huDVo_fBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36534 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdDBKhm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Apr 2017 06:37:42 -0400
Received: by mail-oi0-f41.google.com with SMTP id r203so99819739oib.3
        for <ceph-devel@vger.kernel.org>; Sun, 02 Apr 2017 03:37:42 -0700 (PDT)
In-Reply-To: <CAL-vruOHvvux=Z82pcEiUD+_j1JWWbe2JGckxsQo1huDVo_fBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, kchai@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have done quite a few changes in the proposal after your review. Any
comments before submitting the final draft to Google?

Link : https://docs.google.com/document/d/1dPrijkn8-5l4TL6C2TCORivtz_TpeccurNTI4qnFyS0/edit?usp=sharing

On Sat, Mar 25, 2017 at 7:07 PM, Vedant Nanda <vedant15114@iiitd.ac.in> wrote:
> Thanks for the comments Kefu. I haved listed some metrics in the
> proposal and changed the Modus Operandi accordingly.
> Sure will use the mailing list from now on.
>
> - I have referenced my contribution in the section titled
>  'Git Log'. (https://docs.google.com/document/d/1dPrijkn8-5l4TL6C2TCORivtz_TpeccurNTI4qnFyS0/edit#heading=h.m4oj0wmukbry)
>
> - Correct me if I'm wrong, some metrics profiling an OSD could be :
>      I/O stats, Network stats, Number of placement groups served by an
> OSD, Number of objects stored in the OSD.
>
> Something such as high logging levels may lead to many disk writes
> thus slowing down the OSD. High value of 'osd_recovery_max_chunk' may
> cause throttling in network speeds. Since these settings lead to slow
> OSDs, these are the "root causes".
>
> Also, the project requires the python module to 'follow predefined
> policies' to address the problem. Is the action defined based on the
> metric (in which case knowing the root cause would be important) or Is
> the action same irrespective of the metric classifying the OSD as
> slow?
>
> It'll be great if anybody else can review my GSoC proposal too. Link
> to proposal : https://docs.google.com/document/d/1dPrijkn8-5l4TL6C2TCORivtz_TpeccurNTI4qnFyS0/edit?usp=sharing
>
> Cheers,
> Vedant
>
> On Fri, Mar 24, 2017 at 12:52 PM, kefu chai <tchaikov@gmail.com> wrote:
>> hi Vedant,
>>
>> please use the public mailing list. that will allow other developers
>> to provide you help if i am not able to do so. also, it means that you
>> can start interacting with the rest (large) community instead of just
>> me (barely useful).
>>
>> i just reviewed your proposal[1], couple comments:
>>
>> - you need to reference your contribution to the ceph project in your
>> proposal. this is required.
>> - you can be more specific regarding to what metrics you could use to
>> identify a slow OSD. would be better if you can list some of them.
>>
>>>  For example,if for all OSDs, the subdirectories split at the same time, it may lead to throttling in speeds.
>>
>> this is the root cause, not the metrics.
>>
>> some part of the M.O. overlap with
>> http://ceph.com/gsoc2017-ideas/#root-cause-analysis-tool.
>>
>>
>>
>> ---
>> [1] https://docs.google.com/document/d/1dPrijkn8-5l4TL6C2TCORivtz_TpeccurNTI4qnFyS0/
>>
>>
>> --
>> Regards
>> Kefu Chai
