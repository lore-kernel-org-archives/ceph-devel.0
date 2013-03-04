From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Approaches to wrapping aio_exec
Date: Mon, 4 Mar 2013 11:34:23 -0800
Message-ID: <44EC9874-E8C9-4C20-89A1-3D491065739B@cs.ucsc.edu>
References: <B102A7D4-40F1-4D18-96FC-58188E3E2440@cs.ucsc.edu> <CAC-hyiF+LGPmgeg7oVX_-7oJFAh5J54BfyZHX1h_0vwxtoShiA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:41182 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757496Ab3CDTeZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 14:34:25 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so3319652pbb.27
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 11:34:24 -0800 (PST)
In-Reply-To: <CAC-hyiF+LGPmgeg7oVX_-7oJFAh5J54BfyZHX1h_0vwxtoShiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Mar 3, 2013, at 6:31 PM, Yehuda Sadeh <yehuda@inktank.com> wrote:

> I pushed the wip-librados-exec branch last week that solves a similar
> issue. I added two more ObjectOperation::exec() api calls. The more
> interesting one added a callback context that is called with the
> output buffer of the completed sub-op. Currently in order to use it
> you'll need to use operate()/aio_operate(), however, a similar
> aio_exec interface can be added.

Thanks for the pointer to the branch. So, if I understand correctly,
we might have a new librados::aio_exec_completion call that accepts
a completion object? For example:

aio_exec_completion(AioCompletion *c, bufferlist *outbl,
            ObjectOperationCompletion* completion)
{
  Context *onack = new C_aio_Ack(c);

  ::ObjectOperation rd;
  ObjectOpCompletionCtx *ctx = new ObjectOpCompletionCtx(completion);
  rd.call(cls, method, inbl, ctx->outbl, ctx, NULL);
  objecter->read(oid, oloc, rd, snap_seq, outbl, 0, onack, &c->objver);

  return 0;
}

where the caller would provide an ObjectOperationCompletion where it's
finish(..) would unwrap the protocol?

Do you expect wip-librados-exec going up stream pretty soon, and would
something like librados::aio_exec_completion be a candidate for adding
to librados?

Thanks,
Noah
