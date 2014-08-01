From: Adam Crume <adamcrume@gmail.com>
Subject: =?ISO-8859-7?Q?Re=3A_=C9nstrumenting_RADOS_with_Zipkin_=2B_LTTng?=
Date: Fri, 1 Aug 2014 13:54:48 -0700
Message-ID: <CAFu9Dv1voDfq_K06UozLPQ8Fg7p=+0X0-j0xKuK+DNTAm9FrNA@mail.gmail.com>
References: <CACDi=KpbvTNNEL-59Fej9rvShO9HOdsEPDueTD4uw9nWOYaByg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:53700 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121AbaHAUyt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Aug 2014 16:54:49 -0400
Received: by mail-oa0-f52.google.com with SMTP id o6so3420630oag.39
        for <ceph-devel@vger.kernel.org>; Fri, 01 Aug 2014 13:54:48 -0700 (PDT)
In-Reply-To: <CACDi=KpbvTNNEL-59Fej9rvShO9HOdsEPDueTD4uw9nWOYaByg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Cc: ceph-devel@vger.kernel.org, Vangelis Koukis <vkoukis@grnet.gr>, cven@grnet.gr, Filippos Giannakos <philipgian@grnet.gr>

I'm a developer working on RBD replay, so I've written a lot of the
tracing code.  I'd like to start out by saying that I'm speaking for
myself, not for the Ceph project as a whole.

This certainly is interesting.  This would be useful for analysis that
simple statistics couldn't capture, like correlations between
latencies of different components.  It would be even more interesting
with more layers, e.g. including RGW, RBD, or CephFS.

We do have different goals in tracing.  Your work (as I understand it)
is intended to help understand performance, in which case it makes
sense to capture details about suboperations.  Our work is intended to
capture a workload so that it can be replayed.  For workload capture,
we need a different set of details, such as the object affected,
request parameters, and so on.  There's likely to be a good amount of
overlap, though.  The tracing required for workload capture might even
be a subset of that useful for performance analysis.

It seems like separating reads and writes would be a huge benefit,
since they have very different behavior and performance.  Capturing
data size would be helpful, too.

By the way, that Zipkin UI is pretty slick.  Nice choice.

Adam

On Fri, Aug 1, 2014 at 9:28 AM, Marios-Evaggelos Kogias
<marioskogias@gmail.com> wrote:
> Hello all,
>
> my name is Marios Kogias and I am a student at the National Technical
> University of Athens. As part of my diploma thesis and my participation in
> Google Summer of Code 2014 (in the LTTng organization) I am working on a
> low-overhead tracing infrastructure for distributed systems. I am also
> collaborating with the Synnefo team (https://www.synnefo.org/) and especially
> with Vangelis Koukis, Constantinos Venetsanopoulos and Filippos Giannakos (cc)
>
> Some time ago, we started experimenting with RADOS instrumentation
> using LTTng and
> we noticed that there are similar endeavours in the Ceph github repository [1].
>
> However, unlike your approach, we are following an annotation-based tracing
> schema, which enables us to track a specific request from the time it enters
> the system at higher levels till it is finally served by RADOS.
>
> In general, we try to implement the tracing semantics described in the Dapper
> paper [2] in order to trace the causal relationships between the different
> processing phases that an IO request may trigger. Our target is an end-to-end
> visualisation of the request's route in the system, accompanied by information
> concerning latencies in each processing phase. Thanks to LTTng this can happen
> with a minimal overhead and in realtime. In order to visualize the results we
> have integrated Twitter's Zipkin [3], (which is a tracing system
> entirely based on
> Dapper) with LTTng.
>
> You can find a proof of concept of what we've done so far here:
>
> http://snf-551656.vm.okeanos.grnet.gr:8080/traces/0b554b8a48cb3e84?serviceName=MOSDOp
>
> In the above link you can see the trace of a write request served by a RADOS
> pool with replication level set to 3 (two replicas).
>
> We'd love to have early feedback and comments from you guys too,
> so that we can incorporate useful recommendations. You can find all
> the relevant code
> here[5][6]. If you have any questions or you wish to experiment with the
> project please do not hesitate to contact us.
>
> Kind regards,
> Marios
>
> [1]https://github.com/ceph/ceph/tree/wip-lttng
> [2]http://static.googleusercontent.com/media/research.google.com/el//pubs/archive/36356.pdf
> [3]http://twitter.github.io/zipkin/
> [4] https://github.com/marioskogias/blkin
> [5] https://github.com/marioskogias/babeltrace-plugins
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
