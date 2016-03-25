From: Victor Araujo <vear.91@gmail.com>
Subject: End-to-end performance visualization
Date: Fri, 25 Mar 2016 04:14:43 +0200
Message-ID: <CALak7DMSaedbD9ChAnnQkipGW4S7RojdkzG-C6yLaU3sTAkkxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33844 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbcCYCOp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 22:14:45 -0400
Received: by mail-ob0-f171.google.com with SMTP id kf9so45550578obc.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2016 19:14:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I am prospective student for GSoC, currently on the first year of my
master's degree and interested in the performance of distributed
systems. I'm interested in the End-to-End visualization project and
have been talking to the mentor of the project Ali Maredia about it.

The project would build on previous efforts that use the blkin library
[1] and Twitter's Zipkin [2]  to trace and visualize the performance
of the components that are used to serve Ceph requests. The traces
form trees of spans annotated with timestamps for tracepoints within
each request, which are useful to analyze timing breakdowns of
correlated calls between different components. A plan has been run
through with Ali to rebase blkin tracing to the master branch and fix
bugs for the tracing and for the plugin that translates the traces to
Zipkin's format.

The result would be documented and integrated with the Ceph
Benchmarking Tool (CBT), to generate tracepoints while the benchmarks
are running and to show end-to-end latencies with Zipkin. It can also
be integrated into Teuthology, to generate tracepoints if defined in a
job.

Any suggestions from the community are welcome! In particular, ideas
about the parts of Ceph that
would be of interest to be further instrumented for tracing, as well
as ideas about the way such end-to-end tracing functionality could
help Ceph's development processes.


Best regards,

Victor Araujo


[1] https://github.com/marioskogias/blkin
[2] https://github.com/openzipkin/zipkin
