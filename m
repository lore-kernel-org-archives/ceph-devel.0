From: Sage Weil <sweil@redhat.com>
Subject: Re: radosgw - stuck ops
Date: Tue, 4 Aug 2015 09:55:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508040950540.22099@cobra.newdream.net>
References: <BLU175-W48D8E409F917C02492E3C4DF760@phx.gbl> <CADRKj5SadChvVbVmVx18SFKfAeXWKiGmLB4Xybkqn3xXxoxnyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1105132496-1438707330=:22099"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50857 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214AbbHDQzb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Aug 2015 12:55:31 -0400
In-Reply-To: <CADRKj5SadChvVbVmVx18SFKfAeXWKiGmLB4Xybkqn3xXxoxnyg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: GuangYang <yguang11@outlook.com>, "Just, Samuel" <sjust@redhat.com>, Sadeh-Weinraub Yehuda <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1105132496-1438707330=:22099
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 4 Aug 2015, Yehuda Sadeh-Weinraub wrote:
> On Mon, Aug 3, 2015 at 6:53 PM, GuangYang <yguang11@outlook.com> wrote:
>       Hi Yehuda,
>       Recently with our pre-production clusters (with radosgw), we had
>       an outage that all radosgw worker threads got stuck and all
>       clients request resulted in 500 because that there is no worker
>       thread taking care of them.
> 
>       What we observed from the cluster, is that there was a PG stuck
>       at *peering* state, as a result, all requests hitting that PG
>       would occupy a worker thread infinitely and that gradually stuck
>       all workers.
> 
>       The reason why the PG stuck at peering is still under
>       investigation, but radosgw side, I am wondering if we can pursue
>       anything to improve such use case (to be more specific, 1 out of
>       8192 PGs' issue cascading to a service unavailable across the
>       entire cluster):
> 
>       1. The first approach I can think of is to add timeout at
>       objecter layer for each OP to OSD, I think the complexity comes
>       with WRITE, that is, how do we make sure the integrity if we
>       abort at objecter layer. But for immutable op, I think we
>       certainly can do this, since at an upper layer, we already reply
>       back to client with an error.
>       2. Do thread pool/working queue sharding  at radosgw, in which
>       case, partial failure would (hopefully) only impact partial of
>       worker threads and only cause a partial outage.
> 
> 
> The problem with timeouts is that they are racy and can bring the system
> into inconsistent state. For example, an operation takes too long, rgw gets
> a timeout, but the operation actually completes on the osd. So rgw returns
> with an error, removes the tail and does not complete the write, whereas in
> practice the new head was already written and points at the newly removed
> tail. The index would still show as if the old version of the object was
> still there. I'm sure we can come up with some more scenarios that I'm not
> sure we could resolve easily.

Yeah, unless the entire request goes boom when we time out.  In 
that case, it'd look like a radosgw failure (and the head wouldn't get 
removed, etc.).

This could trivially be done by just setting the suicide timeouts on the 
rgw work queue, but in practice I think that just means all the requests 
will fail (even ones that were making progress at the time) *or* all of 
them will get retried and the list of 'hung' requests will continue to 
pile up (unless the original clients disconnect and the LB/proxy/wahtever 
stops sending them to rgw?).

> The problem with sharding is that for large enough objects they could end up
> writing to any pg, so I'm not sure how effective that would be.

Yeah.

In practice, though, the hung threads aren't consuming any CPU.. they're 
just blocked.  I wonder if rgw could go into a mode where it counts idle 
vs progressing threads, and expands the work queue so that work still gets 
done.  Then/or once it hits some threshold it realizes there's a backend 
hang, it drains requests making progress, and does an orderly restart.

Ideally, we'd have a way to 'kill' a single request process, in which case 
we could time it out and return the appropriate HTTP code to the 
front-end, but in lieu of that... :/

> One solution that I can think of is to determine before the read/write
> whether the pg we're about to access is healthy (or has been unhealthy for a
> short period of time), and if not to cancel the request before sending the
> operation. This could mitigate the problem you're seeing at the expense of
> availability in some cases. We'd need to have a way to query pg health
> through librados which we don't have right now afaik.
> Sage / Sam, does that make sense, and/or possible?

This seems mostly impossible because we don't know ahead of time which 
PG(s) a request is going to touch (it'll generally be a lot of them)?

sage
--557981400-1105132496-1438707330=:22099--
