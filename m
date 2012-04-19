From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Question about IoCtx::aio_exec semantics
Date: Thu, 19 Apr 2012 12:45:16 -0700
Message-ID: <948EED83-8AF0-4678-8B14-1B1F9F4DE914@cs.ucsc.edu>
References: <1CD68FE4-74EB-4599-B7F8-309C0DD92D34@cs.ucsc.edu> <CAC-hyiEtTkrY7N+8hLxM=zZWUcH=Vi0dMGxwnTHc-6BERk7T3w@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:39461 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827Ab2DSTpR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Apr 2012 15:45:17 -0400
In-Reply-To: <CAC-hyiEtTkrY7N+8hLxM=zZWUcH=Vi0dMGxwnTHc-6BERk7T3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Fantastic. Thanks!

-Noah

On Apr 19, 2012, at 12:34 PM, Yehuda Sadeh Weinraub wrote:

> On Thu, Apr 19, 2012 at 12:04 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> I've had a lot of success using rados_exec(), but I need to graduate the implementation to use IoCtx::aio_exec for increased concurrency. I'm a little confused about how aio_exec should be used:
>> 
>> Here is aio_exec:
>> 
>>   int aio_exec(const std::string& oid, AioCompletion *c, const char *cls, const char *method, bufferlist& inbl, bufferlist *outbl);
>> 
>> I'd like to have many outstanding competitions, one for each call of aio_exec. Once @c has completed, I'd like to have access to the @outbl bufferlist. So, is the intended use here to allocate an empty bufferlist for each submitted completion?
> 
> Yes, you'll need to have a bufferlist for each request sent if your
> exec is expected to return data. Note that only read operations should
> return data.
>> 
>> In rgw/rgw_rados.cc a use is:
>> 
>>  AioCompletion *c = librados::Rados::aio_create_completion(NULL, NULL, NULL);
>>  r = io_ctx.aio_exec(oid, c, "rgw", "dir_suggest_changes", in, NULL);
>>  c->release();
>> 
>> To clarify, are the semantics here that an asynchronous aio_exec is made without checking for completion or return values.
> 
> Right. We send the "dir_suggest_changes" request and dropping the
> reference, so that we can't get the return value once it's done.
> 
> Yehuda

