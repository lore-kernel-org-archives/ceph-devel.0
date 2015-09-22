From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: OSD::op_is_discardable condition doubled
Date: Tue, 22 Sep 2015 07:41:20 -0700
Message-ID: <CAJ4mKGYV+Dm+fK=c51akbuheT6c+c6OV54N+M22POZGOZ7-mnQ@mail.gmail.com>
References: <90EABA838E32E141BC06296A2C40520A1A62D80F@IRSMSX108.ger.corp.intel.com>
	<alpine.DEB.2.00.1509220524500.11876@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34622 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbbIVOlV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Sep 2015 10:41:21 -0400
Received: by wicfx3 with SMTP id fx3so195747431wic.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2015 07:41:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1509220524500.11876@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "Lakis, Jacek" <jacek.lakis@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Sep 22, 2015 at 5:26 AM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 22 Sep 2015, Lakis, Jacek wrote:
>> Hi ceph-devel!
>> We're checking OSD::op_is_discardable condition two times: in dispatcher (handle_op) and in worker threads (do_request->can_discard_request->can_discard_op)
>>
>>   if (!op->get_connection()->is_connected() &&
>>       op->get_version().version == 0) {
>>     return true;
>>   }
>>
>> Is there any purpose to do this? If not, which of those should be
>> removed in your opinion? If condition in handle_op will remain, OP won't
>> pass to the worker threads through the prioritized queue. On the other
>> hand, leaving it in do_request will parallelize this check (I started
>> parallelizing in PR 5211).
>
> Is there a reason not to do it twice?  It looks pretty cheap.
>
> But, if we have to choose, I'd leave it in the worker thread.  It is
> unlikely to trigger on newly dispatched messages (that were *just* taken
> off the wire), and the worker thread check is critical to avoid wasting
> work on requeued/delayed messages that no longer have clients waiting on
> them.

While this is definitely the right choice if eliminating one, I think
there was a specific reason to leave it in both. Perhaps just because
it's cheap, but I think maybe the rest of the dispatch work in that
thread relies on it having a connection. (Unless that got changed? We
are a lot more generous about lack of connections than we used to be.)
-Greg
