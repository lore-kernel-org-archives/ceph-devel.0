From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Thu, 24 Sep 2015 19:14:01 +0300
Message-ID: <56042149.60409@mirantis.com>
References: <56018A05.6090100@mirantis.com>
 <alpine.DEB.2.00.1509221201570.11876@cobra.newdream.net>
 <56029F66.3070503@mirantis.com>
 <alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net>
 <CAJ4mKGanEtC3yX5Y2SA+698FEtNupOVcpFnoDLoJ7Hwo1ruSGw@mail.gmail.com>
 <5602C48C.4010009@mirantis.com>
 <CAJ4mKGZLc1AzAbhEKpjSdUd21dXWgVxiLjjETHuP+EwVCA8EoA@mail.gmail.com>
 <5604131E.2030408@mirantis.com>
 <alpine.DEB.2.00.1509240829540.13265@cobra.newdream.net>
 <56041D16.6060805@mirantis.com>
 <alpine.DEB.2.00.1509240900540.13265@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:34488 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618AbbIXQOF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 12:14:05 -0400
Received: by lacdq2 with SMTP id dq2so14185219lac.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 09:14:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1509240900540.13265@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 24.09.2015 19:03, Sage Weil wrote:
> On Thu, 24 Sep 2015, Igor Fedotov wrote:
>
>>
>> There is probably no need in strict alignment with the stripe size. We can use
>> block sizes that client provides on write dynamically. If some client writes
>> in stripes - then we compress that block. If others use larger blocks ( e.g.
>> caching agent on flush) - we can use that size or split the provided block
>> into several smaller chunks ( e.g. up to max N*stripe_size ) for overhead
>> reduction on random read. Even if client uses dynamic block sizes ( low level
>> RADOS use?) we can rely on them some way without static bind to stripe size.
>> Surely this is much easier when appends are permitted only.  General "random
>> writes" case will be more complex.
> Dynamic stripe sizes are possible but it's a significant change from the
> way the EC pool currently works.  I would make that a separate project (as
> its useful in its own right) and not complicate the compression situation.
>
> Or, if it simplifies the compression approach, then I'd make that change
> first.
My point was rather about the lack of need to depend on stripe size for 
compression than about the need for dynamic stripes.
As far as I understand clients can write data using blocks larger then 
stripe size, e.g. several stripes together. Is that correct?

At least I could see that for cache flush and low-level RADOS access.
So we can compress every written block independently - if it has stripe 
size - that's OK - compress it as-is. if it's larger - let's compress 
the whole block or split into less ones and compress them independently.

Thus I think there is no explicit need for additional changes in Ceph 
for doing compression.

Thanks,
Igor.
> sage

