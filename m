From: Bassam Tabbara <bassam@tabbara.com>
Subject: Re: opentracing
Date: Tue, 23 Jan 2018 08:24:07 -0800
Message-ID: <21DF87C3-225B-4CCE-BF64-6F43794CD622@tabbara.com>
References: <alpine.DEB.2.11.1801191944190.24931@piezo.novalocal>
 <CALe9h7fUidu=qYc9WYG3i9NKdOwHwSX-YiMOMF5zNtXGjGdu8A@mail.gmail.com>
 <ed07fd35-ff21-4886-f348-4c1845566472@suse.de>
 <CALe9h7f1SnpDTK-_HuQ8+S_M+bz1gmkGQkNKytc=A6RsnqCHCw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34558 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeAWQYK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jan 2018 11:24:10 -0500
Received: by mail-pf0-f182.google.com with SMTP id e76so706440pfk.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jan 2018 08:24:10 -0800 (PST)
In-Reply-To: <CALe9h7f1SnpDTK-_HuQ8+S_M+bz1gmkGQkNKytc=A6RsnqCHCw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Mohamad Gebai <mgebai@suse.de>, Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

(resending due to a bounce)

+1 for using opentracing as the protocol for tracing. Specially, it =
would be great if each ceph role (MON, OSD, etc.) could spit out open =
tracing metrics on a local socket, such that a sidecar could collect it =
using Jaeger or whatever else. It would be great to be able to trace a =
high level application/user request all the way down to the ceph layer =
using this approach. This seems like a good first step.

I=E2=80=99m also unsure about building a dependency on Jaeger from =
ceph-mgr. It seems to me that some of the features like =E2=80=9Ctop=E2=80=
=9D or a ceph dashboard will inherently require more software/services =
outside of ceph proper (like Jaeger, Prometheus, Web Servers, etc.). If =
we are looking for software that must become a plugin in ceph-mgr our =
choices are going to be limited, or we=E2=80=99re going to be building =
more than we need to.=20

Instead, I think =E2=80=9Ctop=E2=80=9D could just assume that Jaeger and =
Prometheus exist in the cluster, and if they don=E2=80=99t it shows =
basic/limited information. We could provide recipes for running Jaeger =
and Prometheus in ansible / Kubernetes etc.

My 2 cents.

> On Jan 22, 2018, at 10:12 AM, John Spray <jspray@redhat.com> wrote:
>=20
> On Mon, Jan 22, 2018 at 5:59 PM, Mohamad Gebai <mgebai@suse.de> wrote:
>> I really doubt anyone uses Blkin. I've tried to get it working on =
multiple
>> occasions and was never able to. There's also the fact that there =
were
>> problems in the actual code [1][2] that went unnoticed for a while. =
:) I
>> don't know if anyone uses the LTTng tracepoints though, but I think =
they're
>> more for developers than users.
>>=20
>> Regarding Sage's email, I think there are different aspects to this:
>>=20
>> 1. Debug logs
>> There's a compromise between ease of use and performance that has to =
be
>> made. For debug logs, we currently use plain text logging, which is =
the
>> simplest mechanism, but it's not very efficient. Moving to a =
"third-party"
>> tracer for this might be risky since it requires the cluster admin to
>> actually deal with the tracer (LTTng or other) or make Ceph and the =
tracer
>> work closely together (enable tracing, manage the trace, etc.). A =
potential
>> hybrid solution for Ceph would be to rework the current logging =
subsystem to
>> be more efficient. For example, we could move to compact binary =
format such
>> as CTF [3]. This would make internal logging much more efficient in =
time (no
>> locking or string handling required) and disk space.
>>=20
>> 2. rbd top and rados top
>> I don't know enough about what this feature implies to add anything =
to the
>> discussion, but from what I understand, tracing might not be a good =
match
>> for it. Do we really need tracing to get the top consumers of ops in =
the
>> cluster? If we want the full history and the ability to replay, then =
sure.
>> Otherwise, it might be more efficient to just do the bookkeeping =
internally
>> (similar to perf dumps). Maybe I'm missing something or misunderstood =
these
>> features?
>=20
> Just to fill out the context here, when we talk about "rbd top" it's a
> reference to some mechanism like
> (http://tracker.ceph.com/projects/ceph/wiki/Live_Performance_Probes),
> or any other mechanism that lets people see their system activity
> broken down by which client is most active, which rbd image is most
> busy, etc.
>=20
> The tracing relevance comes from the proposed underlying mechanism,
> which is to sample the ops on the OSD (and MDS for cephfs) and then
> aggregate them based on what the user is interested in (i.e. those
> per-client, per-image, etc) counts -- that's what makes it a tracing
> system, albeit with a very small number of tracepoints.
>=20
> John
>=20
>>=20
>> 3. Distributed tracing (Jaeger/OpenTracing)
>> I agree with John that this might add significant infrastructure =
complexity.
>> However, it could be that instrumenting the code according to the
>> specification is enough, and let the user take care of plugging their =
tracer
>> and infrastructure to it. I'm happy to do more research and see how =
this can
>> be used in Ceph.
>>=20
>> Any thought on these points?
>>=20
>> [1]
>> =
https://github.com/ceph/blkin/commit/ad1302e8aadadc1b68489a5576ee2d350fd50=
2a3#diff-d470631b3b4002102866f0bcd25fcf5eL61
>> [2]
>> =
https://github.com/ceph/ceph/commit/9049a97d414332d0d37a80a05c44d76b8dd5e8=
a0
>> [3] http://diamon.org/ctf/
>>=20
>> Mohamad
>>=20
>>=20
>>=20
>> On 01/22/2018 05:07 AM, John Spray wrote:
>>=20
>> On Fri, Jan 19, 2018 at 7:52 PM, Sage Weil <sweil@redhat.com> wrote:
>>=20
>> I think we need to take a step back and reconsider our approach to
>> tracing.  Thus far, it has been an ad hoc combination of our
>> home-brew debug logs and a few lttng tracepoints.  We have some =
initial
>> integration of blkin tracepoints as well, but I'm not sure if anyone =
has
>> actually used them.
>>=20
>> I'm looking at opentracing.io (see e.g.
>> http://opentracing.io/documentation/) and this looks like a more =
viable
>> path forward since it is not tied to specific tracing tools and is =
being
>> adopted by CNCF projects.  There's also the new Jaeger tool that is =
(from
>> what I gather) a newer dapper/zipkin type tool that will presumably =
be
>> usable if we go this path.
>>=20
>> I was on a call recently with a partner and they mentioned that their =
tool
>> would consume tracepoints via opentracing tracepoints and that one of =
the
>> key features was that it would sample instead of pulling an =
exhaustive
>> trace.  (=46rom what I gather this is outside of the opentracing =
library in
>> the application, though--it's up to the tracer to sample or not to
>> sample.)
>>=20
>> One of the looming features that we'd like to work on now that the =
mgr is
>> in place is a 'rados top' or 'rbd top' like function that samples =
requests
>> at the OSDs (or clients?) to build an aggregate view of the top =
consumers
>> of ops in the cluster.  I'm wondering whether it makes sense to build =
this
>> sort of functionality on top of generic tracepoints instead of our =
own
>> purpose-built instrumentation.
>>=20
>> Given that the main "top" style stuff all comes from a single
>> tracepoint per daemon ("handle op"), it seems like the actual tracing
>> library is a relatively unimportant piece, unless there is something
>> special about the way it does sampling.  If the "top" stuff can use a
>> generic tracing library then that's probably more of a bonus than a
>> driver for adoption.
>>=20
>> For the central aggregation piece, I'm a little suspicious of =
packages
>> like Jaeger that back onto a full Cassandra/Elasticsearch backend --
>> while they claim good performance, I don't know how big those =
database
>> servers have to be for it all to work well.  For something to be "out
>> of the box" on Ceph (i.e. not require users to think about extra
>> hardware) we need things that will work with relatively constrained
>> system resources.
>>=20
>> It's definitely worth investigating though.
>>=20
>> John
>>=20
>>=20
>>=20
>> Is there anyone who is interested in heading this =
effort/investigation up?
>>=20
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

