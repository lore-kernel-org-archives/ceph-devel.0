From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: opentracing
Date: Fri, 19 Jan 2018 14:34:03 -0800
Message-ID: <CAJ4mKGYaQrwjQ98Rsuk_66bgcfs-JQpMq3VZXnFh=L9daEc+8Q@mail.gmail.com>
References: <alpine.DEB.2.11.1801191944190.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33775 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756585AbeASWeG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jan 2018 17:34:06 -0500
Received: by mail-lf0-f50.google.com with SMTP id t139so3857468lff.0
        for <ceph-devel@vger.kernel.org>; Fri, 19 Jan 2018 14:34:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801191944190.24931@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jan 19, 2018 at 11:52 AM, Sage Weil <sweil@redhat.com> wrote:
> I think we need to take a step back and reconsider our approach to
> tracing.  Thus far, it has been an ad hoc combination of our
> home-brew debug logs and a few lttng tracepoints.

Okay, let's talk about the purpose of debugging, tracepoints, and
tracing infrastructure, because this sentence confuses me a bit.

We have historically relied on textual output going into logs to debug
Ceph. This is *bad*, as it's a big performance hit and means usually
when something goes wrong, we have to try and reproduce it to get
anything approaching useful data out.

From what I've seen, tracepoints have two primary uses:
1) sampling on a per-op basis lets you identify latency trends across
your stack, find hotspots, and alert to possible issues before they
become fire alarms.
2) tracing all ops when reproducing an issue lets you trace out
progress in a light-weight enough fashion it tends not to change
program behavior, which is useful for bugs which depend on timing.

So, tracing is good for monitoring (possibly including "rbd top", I
suppose?). And it is good for teasing out information about the kinds
of bugs we've had which disappear with debug logging enabled.
But tracing is not in itself good for debugging a *live* system unless
it's a recurring issue. That requires something else.

The OpTracker was designed to solve this problem, and it's been a big
help but not a cure-all because
1) it requires manually deciding which pieces matter, and occasionally
we miss one
2) it doesn't cover everything happening in the system, which means it
has some giant blind spots (eg, what's happening with peering that
might block ops).
The OpTracker's big advantage, of course, is that it's low-enough cost
you can just leave it on in production and then query it when there's
a problem. [1]

I've definitely been assuming that in seastar-land, we will have an
OpTracker equivalent that treats *everything* as an op and tracks them
by simply appending each future it schedules to a list. Then when
there's an issue, we ought to be able to identify which states a
blocked op has gone through, as well as the *live* future it's waiting
on, and then hunt around through the other ops in the system to see
which of them is preventing that future from running.

So I don't think tracing really helps us much with that kind of
individual op debugging which we'd previously used logs for. [2] But
that OpTracker v2 also doesn't help us much with analyzing systemic
latency issues or gathering other high-level statistics since you need
to query individual operations about their state, which will
presumably incur latency-spiking runtime costs.

Am I alone in this understanding of the world?
-Greg

[1]: Theoretically, anyway. We have an option to turn it off because
on sufficiently-fast flash it's been proven to slow things down. IIRC
that was a mix of (mostly?) lock contention issues that we couldn't
really solve, and also because we do string generation for each
important event. We could fix that but it would be a pain.
[2]: That doesn't mean tracing and debugging systems can't play nicely
together! We may want to use the same systems for gathering
"interesting information" about a particular future that is exposed
each way, for instance.

>  We have some initial
> integration of blkin tracepoints as well, but I'm not sure if anyone has
> actually used them.
>
> I'm looking at opentracing.io (see e.g.
> http://opentracing.io/documentation/) and this looks like a more viable
> path forward since it is not tied to specific tracing tools and is being
> adopted by CNCF projects.  There's also the new Jaeger tool that is (from
> what I gather) a newer dapper/zipkin type tool that will presumably be
> usable if we go this path.
>
> I was on a call recently with a partner and they mentioned that their tool
> would consume tracepoints via opentracing tracepoints and that one of the
> key features was that it would sample instead of pulling an exhaustive
> trace.  (From what I gather this is outside of the opentracing library in
> the application, though--it's up to the tracer to sample or not to
> sample.)
>
> One of the looming features that we'd like to work on now that the mgr is
> in place is a 'rados top' or 'rbd top' like function that samples requests
> at the OSDs (or clients?) to build an aggregate view of the top consumers
> of ops in the cluster.  I'm wondering whether it makes sense to build this
> sort of functionality on top of generic tracepoints instead of our own
> purpose-built instrumentation.
>
> Is there anyone who is interested in heading this effort/investigation up?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
