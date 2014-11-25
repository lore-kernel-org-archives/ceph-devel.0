From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH V2 0/7] BlkKin (LTTng + Zipkin) tracing patchset intro
Date: Tue, 25 Nov 2014 10:54:22 -0800
Message-ID: <1416941668-26150-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49920 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbaKYSyF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Nov 2014 13:54:05 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so1106894pac.36
        for <ceph-devel@vger.kernel.org>; Tue, 25 Nov 2014 10:54:05 -0800 (PST)
Received: from scruffy.soe.ucsc.edu (scruffy.soe.ucsc.edu. [128.114.53.124])
        by mx.google.com with ESMTPSA id i11sm2214692pat.3.2014.11.25.10.54.04
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Nov 2014 10:54:04 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The following patches are a cleaned up version of the work
Marios Kogias first posted in August.
http://www.spinics.net/lists/ceph-devel/msg19890.html
The changes are against Ceph 0.80.1, and will be
moved forward soon.

Changes since V1:
  * split build changes into separate patch
  * conditional build support for blkin (default off)
  * blkin is not a Ceph repo submodule
    build and install packages from https://github.com/agshew/blkin.git
    Note: rpms don't support babeltrace plugins for use with Zipkin
  * removal of debugging in Message::init_trace_info()

With this patchset Ceph can use Blkin, a library created by
Marios Kogias and others, which enables tracking a specific request
from the time it enters the system at higher levels till it is finally
served by RADOS.

In general, Blkin implements the tracing semantics described in the Dapper
paper http://static.googleusercontent.com/media/research.google.com/el/pubs/archive/36356.pdf
in order to trace the causal relationships between the different
processing phases that an IO request may trigger. The goal is an end-to-end
visualisation of the request's route in the system, accompanied by information
concerning latencies in each processing phase. Thanks to LTTng this can happen
with a minimal overhead and in realtime. In order to visualize the results Blkin
was integrated with Twitter's Zipkin http://twitter.github.io/zipkin/
(which is a tracing system entirely based on Dapper).

In addition to cleanup, I've written a short document describing how to
test Blkin tracing in Ceph (without Zipkin). See doc/dev/trace.rst

In the immediate future I plan to:

 1. push a wip-blkin branch to github.com/ceph and take advantage of gitbuilder test/qa
 2. move the changes forward to ceph:master
 3. submit a pull request
 3. add Andreas' tracepoints https://github.com/ceph/ceph/pull/2877 using Blkin
    and investigate how easy it is to select the level of tracing detail
