From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph Messaging on Accelio (libxio) RDMA
Date: Wed, 18 Dec 2013 14:13:05 -0800
Message-ID: <CAPYLRzgATRTXarsXjSa9Gx2rQTHZzumJfgkyO07VpeeqHSbSGQ@mail.gmail.com>
References: <CAPYLRzisuLNgx9hU5FPMLDCg+L5vC9m=XVMREs6Ss4aNNViD5Q@mail.gmail.com>
	<184417606.236.1386810838124.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:64745 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193Ab3LRWNG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Dec 2013 17:13:06 -0500
Received: by mail-qa0-f53.google.com with SMTP id j5so899027qaq.5
        for <ceph-devel@vger.kernel.org>; Wed, 18 Dec 2013 14:13:05 -0800 (PST)
In-Reply-To: <184417606.236.1386810838124.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Yaron Haviv <yaronh@mellanox.com>, Eyal Salomon <esalomon@mellanox.com>

(Sorry for the delay getting back on this.)

On Wed, Dec 11, 2013 at 5:13 PM, Matt W. Benjamin <matt@cohortfs.com> wrote:
> Hi Greg,
>
> I haven't fixed the decision to reify replies in the Messenger at this
> point, but it is what the current prototype code tries to do.
>
> The request/response model is more general than my language implied, and
> also is not the only one available.  However, it is the richest model in
> Accelio, and I'm currently exploring how best to exploit it.
>
> The most general model available sends one-way messages in both directions,
> and obviously looks the most like current Messenger model.  Under the covers,
> both Accelio models are built on the same primitives.  The one-way model
> is not incompatible with zero-copy RDMA operations, though I believe it's
> at least trivially true that the one-way model uses only send/recv and
> read operations.  Behind the scenes, the underlying Accelio framework
> requires a more or less exchange of state between the endpoints to maintain
> a balance of RDMA resources in each direction, and to complete RDMA read
> and write transactions (which use registered memory at the sender/receiver,
> respectively).

This sounds more like the acks which the SimpleMessenger already does
(unless I'm misunderstanding what you mean), in that the recipient has
to tell the sender "I have received this message and you don't need to
buffer it any more". Surely we want to let them move on before we've
(for instance) written the submitted data to disk? Or is it also about
telling the sender when they can re-consume the memory in the
recipient's box?

> This isn't of course something the Messenger consumer needs
> to be aware of, except precisely so as to permit the framework to know when
> the upper layer operations on registered memory have completed.
>
> As for the higher level semantics, the first thing to note is that all the
> Accelio primitives provide for delivery receipts, and one of my goals is to
> unify Message acks completely with recepts.  A second key point is that the
> primary property of the current reply hook is not it's ability to reply, but
> it's completion semantics, and these can be articulated on any of the Accelio
> models.  It's possible that's all that's desired.
>
> I'm still exploring is whether the request/response model provides additional
> value to the caller that one-way would not.  The third available model would
> would use xio response messages to deliver any message available at sthe
> responder, so perhaps permitting greater application utilization of the
> underlying resources in some circumstances.  I think a lot of this will be
> clearer as I connect the XioMessenger to Ceph callers.  As we've worked on the
> prototype we've found a number of places where we could tweak the Accelio APIs
> to good effect, and I think we'll find more places as continue work.

I'm still a little fuzzy about how we'd even use a request-reply model
when there are two (or zero) replies to a given request.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
