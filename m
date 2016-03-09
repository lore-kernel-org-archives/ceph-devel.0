From: Dan van der Ster <dan@vanderster.com>
Subject: Re: default min_size for erasure pools
Date: Wed, 9 Mar 2016 21:32:30 +0100
Message-ID: <CABZ+qq=T29GL7qb7ruwYVkQmqF=XQSyha71_j-_nLf1YAbTSSw@mail.gmail.com>
References: <CABZ+qqnLbXY97REQOMRuNc2n+-f_g21bwU2E39XN6tCVfM_nJw@mail.gmail.com>
	<CAJ4mKGY2Y+_P3O20UKE36pNWdpRkWQNtnqMK9mbkYuCu=15LLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36219 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934070AbcCIUce (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 15:32:34 -0500
Received: by mail-lb0-f179.google.com with SMTP id x1so82707555lbj.3
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2016 12:32:33 -0800 (PST)
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com. [209.85.217.180])
        by smtp.gmail.com with ESMTPSA id f134sm40419lff.34.2016.03.09.12.32.30
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 12:32:30 -0800 (PST)
Received: by mail-lb0-f180.google.com with SMTP id x1so82706415lbj.3
        for <ceph-devel@vger.kernel.org>; Wed, 09 Mar 2016 12:32:30 -0800 (PST)
In-Reply-To: <CAJ4mKGY2Y+_P3O20UKE36pNWdpRkWQNtnqMK9mbkYuCu=15LLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 3/9/16, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Wed, Mar 9, 2016 at 6:25 AM, Dan van der Ster <dan@vanderster.com>
> wrote:
>> Hi,
>>
>> For replicated pools we default to min_size=2 when size=3
>> (size-size/2) in order to avoid the split brain scenario, for example
>> as described here:
>> http://www.spinics.net/lists/ceph-devel/msg27008.html
>>
>> But for erasure pools we default to min_size=k which I think is a
>> recipe for similar problems.
>>
>> Shouldn't we default to at least min_size=k+1??
>>
>> diff --git a/src/mon/OSDMonitor.cc b/src/mon/OSDMonitor.cc
>> index 77e26de..5d51686 100644
>> --- a/src/mon/OSDMonitor.cc
>> +++ b/src/mon/OSDMonitor.cc
>> @@ -4427,7 +4427,7 @@ int OSDMonitor::prepare_pool_size(const unsigned
>> pool_type,
>>        err = get_erasure_code(erasure_code_profile, &erasure_code, ss);
>>        if (err == 0) {
>>         *size = erasure_code->get_chunk_count();
>> -       *min_size = erasure_code->get_data_chunk_count();
>> +       *min_size = erasure_code->get_data_chunk_count() + 1;
>>        }
>>      }
>>      break;
>
> Well, losing any OSDs at that point would be bad since it would become
> inaccessible until you get that whole set back, but there's not really
> any chance of serving up bad reads like Sam is worried about in the
> ReplicatedPG case. (...at least, assuming you have more data chunks
> than parity chunks.) Send in a PR on github?
> -Greg
>

Oops, that link discussed reads, but I'm more worried about writes.
I.e. if we allow writes when only k osds are up, then one of the m
down osds comes back and starts backfilling or recovery, but then one
of the k osds that took writes goes down before recovery completes.

PR incoming.

.. Dan
