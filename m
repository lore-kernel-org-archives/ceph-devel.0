From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH V4 0/7] BlkKin (LTTng + Zipkin) tracing patchset intro
Date: Wed, 25 Feb 2015 12:59:21 -0800
Message-ID: <1424897967-879-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:39267 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbbBYU7d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 15:59:33 -0500
Received: by pdjy10 with SMTP id y10so7558567pdj.6
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2015 12:59:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: agshew@gmail.com, marioskogias@gmail.com, chendi.xue@intel.com

The following patches are a cleaned up version of the work
Marios Kogias first posted in August.
http://www.spinics.net/lists/ceph-devel/msg19890.html
This patch is against HEAD as of February 25th at 10am.
It can also be found at https://github.com/agshew/ceph/tree/wip-blkin-v4

Thanks to Chendi Xue for help with some added documention, bug
squashing, and moving the patchset forward. Thanks to Marios for
answering questions from both of us.

Outstanding issues:

Moving the Blkin patchset forward from Ceph 0.80.1 to the current
head has been held up partly due to Blkin tracing functions needing
guards to ensure they are operating on valid pointers. It must still
be missing a few cases where new code paths are missing the Blkin
trace creation calls in older paths, or some Blkin trace functions
are missing valid pointer checks or callsites need to be moved.

 * rados ls shows memory corruption and hangs
 * rados bench rand and seq show a segmentation fault on one thread

A question that needs to be discussed is how can Blkin be made less
brittle without incurring the overhead of pointer checks and
debugging statements? Perhaps the debugging statements can be
removed once the patch stabilizes, but then maintaining the Blkin
patch might require re-adding them as code changes.

After fixing the outstanding issues:

 1. push a wip-blkin branch to github.com/ceph and take advantage of gitbuilder test/qa
 2. submit a pull request
 3. add Andreas' tracepoints https://github.com/ceph/ceph/pull/2877 using Blkin
    and investigate how easy it is to select the level of tracing detail

Changes since V2:

  * WITH_BLKIN added to makefile vars when necessary
  * added Blkin build instructions
  * added Zipkin build instructions
  * Blkin wrapper macros do not stringify args any longer.
    The macro wrappers will be more flexible/robust if they don't
    turn arguments into strings.
  * added missing blkin_trace_info struct prototype to librados.h
  * TrackedOp trace creation methods are virtual, implemented in OpRequest
  * avoid faults due to non-existent traces
    Check if osd_trace exists when creating a pg_trace, etc.
    Return true only if trace creation was successful.
    Use dout() if trace_osd, trace_pg, etc. fail, in order to ease debugging.
  * create trace_osd in ms_fast_dispatch

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

A short document describing how to test Blkin tracing in Ceph with Zipkin
is in doc/dev/trace.rst
