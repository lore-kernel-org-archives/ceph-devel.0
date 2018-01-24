From: Yingxin Cheng <yingxincheng@gmail.com>
Subject: Re: opentracing
Date: Wed, 24 Jan 2018 16:36:54 +0800
Message-ID: <CAJ8o=ntyOYiyKV-pm2-XvGOfjEFO=bzTeW4meHTpxbs+=86PpQ@mail.gmail.com>
References: <alpine.DEB.2.11.1801191944190.24931@piezo.novalocal>
 <CALe9h7fUidu=qYc9WYG3i9NKdOwHwSX-YiMOMF5zNtXGjGdu8A@mail.gmail.com>
 <ed07fd35-ff21-4886-f348-4c1845566472@suse.de> <CALe9h7f1SnpDTK-_HuQ8+S_M+bz1gmkGQkNKytc=A6RsnqCHCw@mail.gmail.com>
 <21DF87C3-225B-4CCE-BF64-6F43794CD622@tabbara.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:44543 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbeAXIgz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jan 2018 03:36:55 -0500
Received: by mail-oi0-f50.google.com with SMTP id s11so2299698oih.11
        for <ceph-devel@vger.kernel.org>; Wed, 24 Jan 2018 00:36:54 -0800 (PST)
In-Reply-To: <21DF87C3-225B-4CCE-BF64-6F43794CD622@tabbara.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bassam Tabbara <bassam@tabbara.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

(resend due to a bounce)

I agree with Greg that our tracing implementations (blkin/optracker)
don=E2=80=99t help much about systemic latency issues or high-level
statistics. And it is very difficult for me to start digging into a
group of tracing records without a whole picture of them. So I took
time to investigate tracing solutions in Ceph, and tried to build up
one that is more friendly to do performance analysis.

In my opinion, an ideal tracing solution should have the following features=
:
A) Allow us to dissect the cost of tracked request into consecutive
sub-costs (like spans but they don=E2=80=99t overlap), even if the datapath=
 is
across hosts. So there=E2=80=99s no chance to have =E2=80=9Cmissing pieces=
=E2=80=9D from
request being sent until responded. The tracepoints should be enough
to relate distributed events of the same request, but not in every
corners.
B) There should be a way to present the whole picture of concurrent
request execution behaviors from =E2=80=9Ca collection of=E2=80=9D tracing =
records.
C) Every piece of the sub-costs should be able to tell which request
it belongs, where it is in the physical deployment, and where it is in
the request logic. So that costs can be indexed and statistics can be
generated to help us (developers/admins) understand how the
performance issue is related to both external deployments and internal
implementations.

I have implemented part of this idea (currently 3 kinds of requests:
librbd ImageRequests, ObjectRequests and librados ObjectOperations).
The test environment is vstart with 3 osds (3 replica), and I used
fio-rbd to trigger writes at iodepth 16. Collected 6MB tracing
records, I can still understand the cluster performance patterns very
quickly from the =E2=80=9Cwhole picture=E2=80=9D [1] [2] [3] generated for =
3 kinds of
requests, respectively:
    [1] shows the pattern very clearly that the 256 =E2=80=9CImageRequests=
=E2=80=9D
were generated concurrently at groups of 16 requests, under fio
setting =E2=80=9Cio depth=E2=80=9D 16. And almost all costs (depicted in ye=
llow) lay
in the dissected sub-cost [image_context_writex_entry ->
image_request_complete_entry] that generates =E2=80=9CObjectRequests=E2=80=
=9D, which
were traced in [2].
    [2] extents the yellow area in [1], which shows the profiling of
256 =E2=80=9CObjectRequests=E2=80=9D at the same time. It shows that =E2=80=
=9CImageRequests=E2=80=9D
were converted into =E2=80=9CObjectRequests=E2=80=9D at 1:1 relationship, u=
nder the
fio write pattern =E2=80=9Csequential writing=E2=80=9D. And this time, almo=
st all
costs (also depicted in yellow) lay in the sub-cost [aio_operate_entry
-> handle_write_object_entry], which generates =E2=80=9CObjectOperations=E2=
=80=9D in
librados, shown in [3].
    [3] extents the yellow area in [2]. It shows the profiling of 260
=E2=80=9CObjectOperations=E2=80=9D from librados to osds. And the costs are=
 visible in
4 intervals (labeled in graph). The major overhead (i.e. the
bottleneck) lay in interval(c) and interval(d), which are the
processes to dequeue operations in PGShardedQueue and commit
transactions in ObjectStore (BlueStore), respectively.

For personalized statistics, they are easy to create from the indexed
sub-costs. I used python data analysis toolset pandas to index and
seaborn to create figures. The examples:
    [4] The distribution of ObjectRequests=E2=80=99 total costs.
    [5] The distributions of sub-costs, aggregated by ObjectOperation
request logics (top 6).
    [6] The distributions of sub-costs that are across services,
classified by whether they are across hosts.
    [7] The distributions of sub-cost [osd_doop_entry ->
osd_issueop_entry], aggregated by its physical locations (i.e. host).

More, the anormaly request can be queried and visualized in details
with location information such as thread, process and host:
    [8] The most complicated ObjectRequest lifecycle.
    [9] The slowest ObjectRequest lifecycle.

From my implementation, the requirement of tracers are pretty simple,
each tracepoint needs to print a unique keyword and propagate some
runtime context. I originally used loggings, and then switched to
lttng for better performance. For Ceph part it is more like an
analysis-oriented strategy about how to place tracepoints leveraging
existing tracers. And the major effort is done separately after trace
records are collected, including parsing, event correlation, analysis
and visualization.

Hope this helps.

-----
[1-9] https://github.com/cyx1231st/publish/blob/master/ceph_tracing.md
Note: [1-5] are from the same experiment. And for better illustration,
[7] is from a Ceph cluster with 3 VMs. [8] [9] are from another Ceph
experiment. And [5] is from an irrelevant experiment.

-Yingxin

2018-01-24 0:24 GMT+08:00 Bassam Tabbara <bassam@tabbara.com>:
> (resending due to a bounce)
>
> +1 for using opentracing as the protocol for tracing. Specially, it would=
 be great if each ceph role (MON, OSD, etc.) could spit out open tracing me=
trics on a local socket, such that a sidecar could collect it using Jaeger =
or whatever else. It would be great to be able to trace a high level applic=
ation/user request all the way down to the ceph layer using this approach. =
This seems like a good first step.
>
> I=E2=80=99m also unsure about building a dependency on Jaeger from ceph-m=
gr. It seems to me that some of the features like =E2=80=9Ctop=E2=80=9D or =
a ceph dashboard will inherently require more software/services outside of =
ceph proper (like Jaeger, Prometheus, Web Servers, etc.). If we are looking=
 for software that must become a plugin in ceph-mgr our choices are going t=
o be limited, or we=E2=80=99re going to be building more than we need to.
>
> Instead, I think =E2=80=9Ctop=E2=80=9D could just assume that Jaeger and =
Prometheus exist in the cluster, and if they don=E2=80=99t it shows basic/l=
imited information. We could provide recipes for running Jaeger and Prometh=
eus in ansible / Kubernetes etc.
>
> My 2 cents.
>
>> On Jan 22, 2018, at 10:12 AM, John Spray <jspray@redhat.com> wrote:
>>
>> On Mon, Jan 22, 2018 at 5:59 PM, Mohamad Gebai <mgebai@suse.de> wrote:
>>> I really doubt anyone uses Blkin. I've tried to get it working on multi=
ple
>>> occasions and was never able to. There's also the fact that there were
>>> problems in the actual code [1][2] that went unnoticed for a while. :) =
I
>>> don't know if anyone uses the LTTng tracepoints though, but I think the=
y're
>>> more for developers than users.
>>>
>>> Regarding Sage's email, I think there are different aspects to this:
>>>
>>> 1. Debug logs
>>> There's a compromise between ease of use and performance that has to be
>>> made. For debug logs, we currently use plain text logging, which is the
>>> simplest mechanism, but it's not very efficient. Moving to a "third-par=
ty"
>>> tracer for this might be risky since it requires the cluster admin to
>>> actually deal with the tracer (LTTng or other) or make Ceph and the tra=
cer
>>> work closely together (enable tracing, manage the trace, etc.). A poten=
tial
>>> hybrid solution for Ceph would be to rework the current logging subsyst=
em to
>>> be more efficient. For example, we could move to compact binary format =
such
>>> as CTF [3]. This would make internal logging much more efficient in tim=
e (no
>>> locking or string handling required) and disk space.
>>>
>>> 2. rbd top and rados top
>>> I don't know enough about what this feature implies to add anything to =
the
>>> discussion, but from what I understand, tracing might not be a good mat=
ch
>>> for it. Do we really need tracing to get the top consumers of ops in th=
e
>>> cluster? If we want the full history and the ability to replay, then su=
re.
>>> Otherwise, it might be more efficient to just do the bookkeeping intern=
ally
>>> (similar to perf dumps). Maybe I'm missing something or misunderstood t=
hese
>>> features?
>>
>> Just to fill out the context here, when we talk about "rbd top" it's a
>> reference to some mechanism like
>> (http://tracker.ceph.com/projects/ceph/wiki/Live_Performance_Probes),
>> or any other mechanism that lets people see their system activity
>> broken down by which client is most active, which rbd image is most
>> busy, etc.
>>
>> The tracing relevance comes from the proposed underlying mechanism,
>> which is to sample the ops on the OSD (and MDS for cephfs) and then
>> aggregate them based on what the user is interested in (i.e. those
>> per-client, per-image, etc) counts -- that's what makes it a tracing
>> system, albeit with a very small number of tracepoints.
>>
>> John
>>
>>>
>>> 3. Distributed tracing (Jaeger/OpenTracing)
>>> I agree with John that this might add significant infrastructure comple=
xity.
>>> However, it could be that instrumenting the code according to the
>>> specification is enough, and let the user take care of plugging their t=
racer
>>> and infrastructure to it. I'm happy to do more research and see how thi=
s can
>>> be used in Ceph.
>>>
>>> Any thought on these points?
>>>
>>> [1]
>>> https://github.com/ceph/blkin/commit/ad1302e8aadadc1b68489a5576ee2d350f=
d502a3#diff-d470631b3b4002102866f0bcd25fcf5eL61
>>> [2]
>>> https://github.com/ceph/ceph/commit/9049a97d414332d0d37a80a05c44d76b8dd=
5e8a0
>>> [3] http://diamon.org/ctf/
>>>
>>> Mohamad
>>>
>>>
>>>
>>> On 01/22/2018 05:07 AM, John Spray wrote:
>>>
>>> On Fri, Jan 19, 2018 at 7:52 PM, Sage Weil <sweil@redhat.com> wrote:
>>>
>>> I think we need to take a step back and reconsider our approach to
>>> tracing.  Thus far, it has been an ad hoc combination of our
>>> home-brew debug logs and a few lttng tracepoints.  We have some initial
>>> integration of blkin tracepoints as well, but I'm not sure if anyone ha=
s
>>> actually used them.
>>>
>>> I'm looking at opentracing.io (see e.g.
>>> http://opentracing.io/documentation/) and this looks like a more viable
>>> path forward since it is not tied to specific tracing tools and is bein=
g
>>> adopted by CNCF projects.  There's also the new Jaeger tool that is (fr=
om
>>> what I gather) a newer dapper/zipkin type tool that will presumably be
>>> usable if we go this path.
>>>
>>> I was on a call recently with a partner and they mentioned that their t=
ool
>>> would consume tracepoints via opentracing tracepoints and that one of t=
he
>>> key features was that it would sample instead of pulling an exhaustive
>>> trace.  (From what I gather this is outside of the opentracing library =
in
>>> the application, though--it's up to the tracer to sample or not to
>>> sample.)
>>>
>>> One of the looming features that we'd like to work on now that the mgr =
is
>>> in place is a 'rados top' or 'rbd top' like function that samples reque=
sts
>>> at the OSDs (or clients?) to build an aggregate view of the top consume=
rs
>>> of ops in the cluster.  I'm wondering whether it makes sense to build t=
his
>>> sort of functionality on top of generic tracepoints instead of our own
>>> purpose-built instrumentation.
>>>
>>> Given that the main "top" style stuff all comes from a single
>>> tracepoint per daemon ("handle op"), it seems like the actual tracing
>>> library is a relatively unimportant piece, unless there is something
>>> special about the way it does sampling.  If the "top" stuff can use a
>>> generic tracing library then that's probably more of a bonus than a
>>> driver for adoption.
>>>
>>> For the central aggregation piece, I'm a little suspicious of packages
>>> like Jaeger that back onto a full Cassandra/Elasticsearch backend --
>>> while they claim good performance, I don't know how big those database
>>> servers have to be for it all to work well.  For something to be "out
>>> of the box" on Ceph (i.e. not require users to think about extra
>>> hardware) we need things that will work with relatively constrained
>>> system resources.
>>>
>>> It's definitely worth investigating though.
>>>
>>> John
>>>
>>>
>>>
>>> Is there anyone who is interested in heading this effort/investigation =
up?
>>>
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
