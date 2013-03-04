From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Approaches to wrapping aio_exec
Date: Mon, 4 Mar 2013 11:44:12 -0800
Message-ID: <CAC-hyiH50MPd2uQUDA-CaXSdEETWJ4o0+wCWpAduVMdJxyYeEA@mail.gmail.com>
References: <B102A7D4-40F1-4D18-96FC-58188E3E2440@cs.ucsc.edu>
	<CAC-hyiF+LGPmgeg7oVX_-7oJFAh5J54BfyZHX1h_0vwxtoShiA@mail.gmail.com>
	<44EC9874-E8C9-4C20-89A1-3D491065739B@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:39269 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758840Ab3CDToN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 14:44:13 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so5152310iak.38
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 11:44:12 -0800 (PST)
In-Reply-To: <44EC9874-E8C9-4C20-89A1-3D491065739B@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Mar 4, 2013 at 11:34 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>
> On Mar 3, 2013, at 6:31 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>
>> I pushed the wip-librados-exec branch last week that solves a similar
>> issue. I added two more ObjectOperation::exec() api calls. The more
>> interesting one added a callback context that is called with the
>> output buffer of the completed sub-op. Currently in order to use it
>> you'll need to use operate()/aio_operate(), however, a similar
>> aio_exec interface can be added.
>
> Thanks for the pointer to the branch. So, if I understand correctly,
> we might have a new librados::aio_exec_completion call that accepts
> a completion object? For example:
>
> aio_exec_completion(AioCompletion *c, bufferlist *outbl,
>             ObjectOperationCompletion* completion)
> {
>   Context *onack = new C_aio_Ack(c);
>
>   ::ObjectOperation rd;
>   ObjectOpCompletionCtx *ctx = new ObjectOpCompletionCtx(completion);
>   rd.call(cls, method, inbl, ctx->outbl, ctx, NULL);
>   objecter->read(oid, oloc, rd, snap_seq, outbl, 0, onack, &c->objver);
>
>   return 0;
> }
>
> where the caller would provide an ObjectOperationCompletion where it's
> finish(..) would unwrap the protocol?

Right.

>
> Do you expect wip-librados-exec going up stream pretty soon, and would

We can push it ahead if needed, it doesn't depend on any of the stuff
I'm working on right now. It just waits for someone to properly review
it.

> something like librados::aio_exec_completion be a candidate for adding
> to librados?
>

Sure, if there's a need then I don't see why not.

Yehuda
