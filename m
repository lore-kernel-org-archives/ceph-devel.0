From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Approaches to wrapping aio_exec
Date: Wed, 6 Mar 2013 16:03:29 -0800
Message-ID: <8B0BECA1-F864-4CCB-B3E6-A49EAE7E492B@cs.ucsc.edu>
References: <B102A7D4-40F1-4D18-96FC-58188E3E2440@cs.ucsc.edu> <CAC-hyiF+LGPmgeg7oVX_-7oJFAh5J54BfyZHX1h_0vwxtoShiA@mail.gmail.com> <44EC9874-E8C9-4C20-89A1-3D491065739B@cs.ucsc.edu> <CAC-hyiH50MPd2uQUDA-CaXSdEETWJ4o0+wCWpAduVMdJxyYeEA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:53053 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754999Ab3CGAD2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 19:03:28 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so6781725pbb.13
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 16:03:28 -0800 (PST)
In-Reply-To: <CAC-hyiH50MPd2uQUDA-CaXSdEETWJ4o0+wCWpAduVMdJxyYeEA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

So I've been playing with the ObjectOperationCompletion code a bit. It seems to be really important to be able to handle decoding errors in in the handle_completion() callback. In particular, I'd like to be able to reach out and set the return value the user will see in the AioCompletion.

Any thoughts on dealing with this some how?

-Noah

On Mar 4, 2013, at 11:44 AM, Yehuda Sadeh <yehuda@inktank.com> wrote:

> On Mon, Mar 4, 2013 at 11:34 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> 
>> On Mar 3, 2013, at 6:31 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>> 
>>> I pushed the wip-librados-exec branch last week that solves a similar
>>> issue. I added two more ObjectOperation::exec() api calls. The more
>>> interesting one added a callback context that is called with the
>>> output buffer of the completed sub-op. Currently in order to use it
>>> you'll need to use operate()/aio_operate(), however, a similar
>>> aio_exec interface can be added.
>> 
>> Thanks for the pointer to the branch. So, if I understand correctly,
>> we might have a new librados::aio_exec_completion call that accepts
>> a completion object? For example:
>> 
>> aio_exec_completion(AioCompletion *c, bufferlist *outbl,
>>            ObjectOperationCompletion* completion)
>> {
>>  Context *onack = new C_aio_Ack(c);
>> 
>>  ::ObjectOperation rd;
>>  ObjectOpCompletionCtx *ctx = new ObjectOpCompletionCtx(completion);
>>  rd.call(cls, method, inbl, ctx->outbl, ctx, NULL);
>>  objecter->read(oid, oloc, rd, snap_seq, outbl, 0, onack, &c->objver);
>> 
>>  return 0;
>> }
>> 
>> where the caller would provide an ObjectOperationCompletion where it's
>> finish(..) would unwrap the protocol?
> 
> Right.
> 
>> 
>> Do you expect wip-librados-exec going up stream pretty soon, and would
> 
> We can push it ahead if needed, it doesn't depend on any of the stuff
> I'm working on right now. It just waits for someone to properly review
> it.
> 
>> something like librados::aio_exec_completion be a candidate for adding
>> to librados?
>> 
> 
> Sure, if there's a need then I don't see why not.
> 
> Yehuda

