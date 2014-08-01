From: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Subject: =?UTF-8?Q?=CE=99nstrumenting_RADOS_with_Zipkin_=2B_LTTng?=
Date: Fri, 1 Aug 2014 19:28:58 +0300
Message-ID: <CACDi=KpbvTNNEL-59Fej9rvShO9HOdsEPDueTD4uw9nWOYaByg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:36855 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaHAQ27 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Aug 2014 12:28:59 -0400
Received: by mail-vc0-f175.google.com with SMTP id ik5so7068350vcb.34
        for <ceph-devel@vger.kernel.org>; Fri, 01 Aug 2014 09:28:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Vangelis Koukis <vkoukis@grnet.gr>, cven@grnet.gr, Filippos Giannakos <philipgian@grnet.gr>

Hello all,

my name is Marios Kogias and I am a student at the National Technical
University of Athens. As part of my diploma thesis and my participation in
Google Summer of Code 2014 (in the LTTng organization) I am working on a
low-overhead tracing infrastructure for distributed systems. I am also
collaborating with the Synnefo team (https://www.synnefo.org/) and especially
with Vangelis Koukis, Constantinos Venetsanopoulos and Filippos Giannakos (cc)

Some time ago, we started experimenting with RADOS instrumentation
using LTTng and
we noticed that there are similar endeavours in the Ceph github repository [1].

However, unlike your approach, we are following an annotation-based tracing
schema, which enables us to track a specific request from the time it enters
the system at higher levels till it is finally served by RADOS.

In general, we try to implement the tracing semantics described in the Dapper
paper [2] in order to trace the causal relationships between the different
processing phases that an IO request may trigger. Our target is an end-to-end
visualisation of the request's route in the system, accompanied by information
concerning latencies in each processing phase. Thanks to LTTng this can happen
with a minimal overhead and in realtime. In order to visualize the results we
have integrated Twitter's Zipkin [3], (which is a tracing system
entirely based on
Dapper) with LTTng.

You can find a proof of concept of what we've done so far here:

http://snf-551656.vm.okeanos.grnet.gr:8080/traces/0b554b8a48cb3e84?serviceName=MOSDOp

In the above link you can see the trace of a write request served by a RADOS
pool with replication level set to 3 (two replicas).

We'd love to have early feedback and comments from you guys too,
so that we can incorporate useful recommendations. You can find all
the relevant code
here[5][6]. If you have any questions or you wish to experiment with the
project please do not hesitate to contact us.

Kind regards,
Marios

[1]https://github.com/ceph/ceph/tree/wip-lttng
[2]http://static.googleusercontent.com/media/research.google.com/el//pubs/archive/36356.pdf
[3]http://twitter.github.io/zipkin/
[4] https://github.com/marioskogias/blkin
[5] https://github.com/marioskogias/babeltrace-plugins
