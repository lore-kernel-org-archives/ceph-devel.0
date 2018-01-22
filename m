From: John Spray <jspray@redhat.com>
Subject: Re: opentracing
Date: Mon, 22 Jan 2018 10:07:02 +0000
Message-ID: <CALe9h7fUidu=qYc9WYG3i9NKdOwHwSX-YiMOMF5zNtXGjGdu8A@mail.gmail.com>
References: <alpine.DEB.2.11.1801191944190.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:45406 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeAVKHX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Jan 2018 05:07:23 -0500
Received: by mail-wm0-f48.google.com with SMTP id i186so15153430wmi.4
        for <ceph-devel@vger.kernel.org>; Mon, 22 Jan 2018 02:07:23 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801191944190.24931@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jan 19, 2018 at 7:52 PM, Sage Weil <sweil@redhat.com> wrote:
> I think we need to take a step back and reconsider our approach to
> tracing.  Thus far, it has been an ad hoc combination of our
> home-brew debug logs and a few lttng tracepoints.  We have some initial
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

Given that the main "top" style stuff all comes from a single
tracepoint per daemon ("handle op"), it seems like the actual tracing
library is a relatively unimportant piece, unless there is something
special about the way it does sampling.  If the "top" stuff can use a
generic tracing library then that's probably more of a bonus than a
driver for adoption.

For the central aggregation piece, I'm a little suspicious of packages
like Jaeger that back onto a full Cassandra/Elasticsearch backend --
while they claim good performance, I don't know how big those database
servers have to be for it all to work well.  For something to be "out
of the box" on Ceph (i.e. not require users to think about extra
hardware) we need things that will work with relatively constrained
system resources.

It's definitely worth investigating though.

John



>
> Is there anyone who is interested in heading this effort/investigation up?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
