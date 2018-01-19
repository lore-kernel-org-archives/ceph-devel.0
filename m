From: Sage Weil <sweil@redhat.com>
Subject: opentracing
Date: Fri, 19 Jan 2018 19:52:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801191944190.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51904 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756071AbeASTwP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 19 Jan 2018 14:52:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0ED5CC047B65
        for <ceph-devel@vger.kernel.org>; Fri, 19 Jan 2018 19:52:15 +0000 (UTC)
Received: from ovpn-112-18.rdu2.redhat.com (ovpn-112-18.rdu2.redhat.com [10.10.112.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A421060BE3
        for <ceph-devel@vger.kernel.org>; Fri, 19 Jan 2018 19:52:14 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I think we need to take a step back and reconsider our approach to 
tracing.  Thus far, it has been an ad hoc combination of our 
home-brew debug logs and a few lttng tracepoints.  We have some initial 
integration of blkin tracepoints as well, but I'm not sure if anyone has 
actually used them.

I'm looking at opentracing.io (see e.g. 
http://opentracing.io/documentation/) and this looks like a more viable 
path forward since it is not tied to specific tracing tools and is being 
adopted by CNCF projects.  There's also the new Jaeger tool that is (from 
what I gather) a newer dapper/zipkin type tool that will presumably be 
usable if we go this path.

I was on a call recently with a partner and they mentioned that their tool 
would consume tracepoints via opentracing tracepoints and that one of the 
key features was that it would sample instead of pulling an exhaustive 
trace.  (From what I gather this is outside of the opentracing library in 
the application, though--it's up to the tracer to sample or not to 
sample.)

One of the looming features that we'd like to work on now that the mgr is 
in place is a 'rados top' or 'rbd top' like function that samples requests 
at the OSDs (or clients?) to build an aggregate view of the top consumers 
of ops in the cluster.  I'm wondering whether it makes sense to build this 
sort of functionality on top of generic tracepoints instead of our own 
purpose-built instrumentation.

Is there anyone who is interested in heading this effort/investigation up?

sage
