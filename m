From: Mohamad Gebai <mgebai@suse.de>
Subject: Re: opentracing
Date: Mon, 22 Jan 2018 13:00:40 -0500
Message-ID: <01bcff94-1575-4d11-c8ee-4e9611f94cc9@suse.de>
References: <alpine.DEB.2.11.1801191944190.24931@piezo.novalocal>
 <CALe9h7fUidu=qYc9WYG3i9NKdOwHwSX-YiMOMF5zNtXGjGdu8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbeAVSAI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Jan 2018 13:00:08 -0500
In-Reply-To: <CALe9h7fUidu=qYc9WYG3i9NKdOwHwSX-YiMOMF5zNtXGjGdu8A@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I really doubt anyone uses Blkin. I've tried to get it working on
multiple occasions and was never able to. There's also the fact that
there were problems in the actual code [1][2] that went unnoticed for a
while. :) I don't know if anyone uses the LTTng tracepoints though, but
I think they're more for developers than users.

Regarding Sage's email, I think there are different aspects to this:

1. Debug logs
There's a compromise between ease of use and performance that has to be
made. For debug logs, we currently use plain text logging, which is the
simplest mechanism, but it's not very efficient. Moving to a
"third-party" tracer for this might be risky since it requires the
cluster admin to actually deal with the tracer (LTTng or other) or make
Ceph and the tracer work closely together (enable tracing, manage the
trace, etc.). A potential hybrid solution for Ceph would be to rework
the current logging subsystem to be more efficient. For example, we
could move to compact binary format such as CTF [3]. This would make
internal logging much more efficient in time (no locking or string
handling required) and disk space.

2. rbd top and rados top
I don't know enough about what this feature implies to add anything to
the discussion, but from what I understand, tracing might not be a good
match for it. Do we really need tracing to get the top consumers of ops
in the cluster? If we want the full history and the ability to replay,
then sure. Otherwise, it might be more efficient to just do the
bookkeeping internally (similar to perf dumps). Maybe I'm missing
something or misunderstood these features?

3. Distributed tracing (Jaeger/OpenTracing)
I agree with John that this might add significant infrastructure
complexity. However, it could be that instrumenting the code according
to the specification is enough, and let the user take care of plugging
their tracer and infrastructure to it. I'm happy to do more research and
see how this can be used in Ceph.

Any thought on these points?

[1]
https://github.com/ceph/blkin/commit/ad1302e8aadadc1b68489a5576ee2d350fd502a3#diff-d470631b3b4002102866f0bcd25fcf5eL61
[2]
https://github.com/ceph/ceph/commit/9049a97d414332d0d37a80a05c44d76b8dd5e8a0
[3] http://diamon.org/ctf/

Mohamad


On 01/22/2018 05:07 AM, John Spray wrote:
> On Fri, Jan 19, 2018 at 7:52 PM, Sage Weil <sweil@redhat.com> wrote:
>> I think we need to take a step back and reconsider our approach to
>> tracing.  Thus far, it has been an ad hoc combination of our
>> home-brew debug logs and a few lttng tracepoints.  We have some initial
>> integration of blkin tracepoints as well, but I'm not sure if anyone has
>> actually used them.
>>
>> I'm looking at opentracing.io (see e.g.
>> http://opentracing.io/documentation/) and this looks like a more viable
>> path forward since it is not tied to specific tracing tools and is being
>> adopted by CNCF projects.  There's also the new Jaeger tool that is (from
>> what I gather) a newer dapper/zipkin type tool that will presumably be
>> usable if we go this path.
>>
>> I was on a call recently with a partner and they mentioned that their tool
>> would consume tracepoints via opentracing tracepoints and that one of the
>> key features was that it would sample instead of pulling an exhaustive
>> trace.  (From what I gather this is outside of the opentracing library in
>> the application, though--it's up to the tracer to sample or not to
>> sample.)
>>
>> One of the looming features that we'd like to work on now that the mgr is
>> in place is a 'rados top' or 'rbd top' like function that samples requests
>> at the OSDs (or clients?) to build an aggregate view of the top consumers
>> of ops in the cluster.  I'm wondering whether it makes sense to build this
>> sort of functionality on top of generic tracepoints instead of our own
>> purpose-built instrumentation.
> Given that the main "top" style stuff all comes from a single
> tracepoint per daemon ("handle op"), it seems like the actual tracing
> library is a relatively unimportant piece, unless there is something
> special about the way it does sampling.  If the "top" stuff can use a
> generic tracing library then that's probably more of a bonus than a
> driver for adoption.
>
> For the central aggregation piece, I'm a little suspicious of packages
> like Jaeger that back onto a full Cassandra/Elasticsearch backend --
> while they claim good performance, I don't know how big those database
> servers have to be for it all to work well.  For something to be "out
> of the box" on Ceph (i.e. not require users to think about extra
> hardware) we need things that will work with relatively constrained
> system resources.
>
> It's definitely worth investigating though.
>
> John
>
>
>
>> Is there anyone who is interested in heading this effort/investigation up?
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

