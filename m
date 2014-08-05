From: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=CE=99nstrumenting_RADOS_with_Zipkin_=2B_LTTng?=
Date: Tue, 5 Aug 2014 19:18:01 +0300
Message-ID: <CACDi=Kpt2dX8YnOCdw+M7z4u3QdvWOLnNzPOtJh9dCC9XD+wDA@mail.gmail.com>
References: <CACDi=KpbvTNNEL-59Fej9rvShO9HOdsEPDueTD4uw9nWOYaByg@mail.gmail.com>
	<CAFu9Dv1voDfq_K06UozLPQ8Fg7p=+0X0-j0xKuK+DNTAm9FrNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52160 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755678AbaHEQSD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Aug 2014 12:18:03 -0400
Received: by mail-vc0-f174.google.com with SMTP id la4so1944664vcb.33
        for <ceph-devel@vger.kernel.org>; Tue, 05 Aug 2014 09:18:02 -0700 (PDT)
In-Reply-To: <CAFu9Dv1voDfq_K06UozLPQ8Fg7p=+0X0-j0xKuK+DNTAm9FrNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Crume <adamcrume@gmail.com>
Cc: ceph-devel@vger.kernel.org, Vangelis Koukis <vkoukis@grnet.gr>, Constantinos Venetsanopoulos <cven@grnet.gr>, Filippos Giannakos <philipgian@grnet.gr>

Hello Adam,

>I'm a developer working on RBD replay, so I've written a lot of the
>tracing code.  I'd like to start out by saying that I'm speaking for
>myself, not for the Ceph project as a whole.
>
>This certainly is interesting.  This would be useful for analysis that
>simple statistics couldn't capture, like correlations between
>latencies of different components.  It would be even more interesting
>with more layers, e.g. including RGW, RBD, or CephFS.
>

Your are absolutely right. Tracing requests across different storage
layers was the main reason for creating this infrastructure. We are
using RADOS as a storage backend for Archipelago [1], our custom
storage layer similar to RBD and RGW and as you can see here

http://snf-541212.vm.okeanos.grnet.gr:8080/traces/1a5a85354acb719c?serviceName=bench

we can trace the requests from their creation in the upper layers till
they are finally served by RADOS. In the above link 'bench', 'vlmc',
'mapper' and 'radosd' are Archipelago layers. 'radosd' is the layer that
uses librados and  communicates with the RADOS backend. Of course,
one could replace Archipelago with RGW, RBD, CephFS or any other software
layer on top of librados.

>We do have different goals in tracing.  Your work (as I understand it)
>is intended to help understand performance, in which case it makes
>sense to capture details about suboperations.  Our work is intended to
>capture a workload so that it can be replayed.  For workload capture,
>we need a different set of details, such as the object affected,
>request parameters, and so on.  There's likely to be a good amount of
>overlap, though.  The tracing required for workload capture might even
>be a subset of that useful for performance analysis.

Although our main goal was indeed live, cross-layer performance tracing,
it now seems that this infrastructure can cover more generic needs as
well. According to Dapper logic each traced information (annotation)
should belong to a group of annotations (span). There are two different
kinds of annotations, timestamp and key-value. Timestamp annotations are
used to trace specific events, while key-value annotations are used to
log extra trace information. So, the information you are asking for
could be traced as a key-value annotation, e.g. "Operation"="read".
To demonstrate the above, you can take a look at the key-value
annotations of the "Handling op" span of the primary osd (osd.0) by
clicking on it. There, we have logged the object that is affected by
the traced request. We could do the same thing with the information
needed for the workload to be replayed and filter by any criteria
desired, like read or write requests for example.

In addition, using this methodology saves us from manually correlating
the traces, since they are already grouped in parent-child relations. Then
we can access them easily either from the Zipkin UI or from the SQL-interface.

>
>It seems like separating reads and writes would be a huge benefit,
>since they have very different behavior and performance.  Capturing
>data size would be helpful, too.

As mentioned above, this information can be captured as key-value
annotations and can be easily filtered either from the Zipkin UI
or using the SQL-interface. And yes, we should definitely add the
data size too, it's rather trivial.

>
>By the way, that Zipkin UI is pretty slick.  Nice choice.

As you noted, the traces you require for the workload capturing seem to
be a subset of what this infrastructure can trace, so it would be
great if we dug this further and see if we can even join efforts on
this. Combining your RADOS expertise with our work with the LTTng
community and Zipkin could probably result in something really
interesting. What do you think?

Comments from the rest of the Ceph community are also welcome, of course.

Thanks a lot for your feedback,
Marios

[1] https://www.usenix.org/system/files/login/articles/02_giannakos.pdf

2014-08-01 23:54 GMT+03:00 Adam Crume <adamcrume@gmail.com>:
> I'm a developer working on RBD replay, so I've written a lot of the
> tracing code.  I'd like to start out by saying that I'm speaking for
> myself, not for the Ceph project as a whole.
>
> This certainly is interesting.  This would be useful for analysis that
> simple statistics couldn't capture, like correlations between
> latencies of different components.  It would be even more interesting
> with more layers, e.g. including RGW, RBD, or CephFS.
>
> We do have different goals in tracing.  Your work (as I understand it)
> is intended to help understand performance, in which case it makes
> sense to capture details about suboperations.  Our work is intended to
> capture a workload so that it can be replayed.  For workload capture,
> we need a different set of details, such as the object affected,
> request parameters, and so on.  There's likely to be a good amount of
> overlap, though.  The tracing required for workload capture might even
> be a subset of that useful for performance analysis.
>
> It seems like separating reads and writes would be a huge benefit,
> since they have very different behavior and performance.  Capturing
> data size would be helpful, too.
>
> By the way, that Zipkin UI is pretty slick.  Nice choice.
>
> Adam
>
> On Fri, Aug 1, 2014 at 9:28 AM, Marios-Evaggelos Kogias
> <marioskogias@gmail.com> wrote:
>> Hello all,
>>
>> my name is Marios Kogias and I am a student at the National Technical
>> University of Athens. As part of my diploma thesis and my participation in
>> Google Summer of Code 2014 (in the LTTng organization) I am working on a
>> low-overhead tracing infrastructure for distributed systems. I am also
>> collaborating with the Synnefo team (https://www.synnefo.org/) and especially
>> with Vangelis Koukis, Constantinos Venetsanopoulos and Filippos Giannakos (cc)
>>
>> Some time ago, we started experimenting with RADOS instrumentation
>> using LTTng and
>> we noticed that there are similar endeavours in the Ceph github repository [1].
>>
>> However, unlike your approach, we are following an annotation-based tracing
>> schema, which enables us to track a specific request from the time it enters
>> the system at higher levels till it is finally served by RADOS.
>>
>> In general, we try to implement the tracing semantics described in the Dapper
>> paper [2] in order to trace the causal relationships between the different
>> processing phases that an IO request may trigger. Our target is an end-to-end
>> visualisation of the request's route in the system, accompanied by information
>> concerning latencies in each processing phase. Thanks to LTTng this can happen
>> with a minimal overhead and in realtime. In order to visualize the results we
>> have integrated Twitter's Zipkin [3], (which is a tracing system
>> entirely based on
>> Dapper) with LTTng.
>>
>> You can find a proof of concept of what we've done so far here:
>>
>> http://snf-551656.vm.okeanos.grnet.gr:8080/traces/0b554b8a48cb3e84?serviceName=MOSDOp
>>
>> In the above link you can see the trace of a write request served by a RADOS
>> pool with replication level set to 3 (two replicas).
>>
>> We'd love to have early feedback and comments from you guys too,
>> so that we can incorporate useful recommendations. You can find all
>> the relevant code
>> here[5][6]. If you have any questions or you wish to experiment with the
>> project please do not hesitate to contact us.
>>
>> Kind regards,
>> Marios
>>
>> [1]https://github.com/ceph/ceph/tree/wip-lttng
>> [2]http://static.googleusercontent.com/media/research.google.com/el//pubs/archive/36356.pdf
>> [3]http://twitter.github.io/zipkin/
>> [4] https://github.com/marioskogias/blkin
>> [5] https://github.com/marioskogias/babeltrace-plugins
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
