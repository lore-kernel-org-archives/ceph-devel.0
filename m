From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH V5 0/7] BlkKin (LTTng + Zipkin) tracing patchset intro
Date: Mon,  2 Mar 2015 16:35:09 -0800
Message-ID: <1425342915-12553-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33970 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbbCCAfJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Mar 2015 19:35:09 -0500
Received: by pdjg10 with SMTP id g10so43797495pdj.1
        for <ceph-devel@vger.kernel.org>; Mon, 02 Mar 2015 16:35:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: agshew@gmail.com, marioskogias@gmail.com, chendi.xue@intel.com

The following patches are a cleaned up version of the work
Marios Kogias first posted in August.
http://www.spinics.net/lists/ceph-devel/msg19890.html
This patch is against HEAD as of March 2nd at 4:30pm Mountain.
It can also be found at https://github.com/agshew/ceph/tree/wip-blkin-v5

Thanks to Josh Durgin for walking through the V4 patchset with me
and helping with all of the issues described in the changelog below.
And thanks to Sage for discussing the problems associated with
the messenger_end trace event.

Outstanding issues:

I've seen OSD startup failures, which are probably due to the blkin patchset
moving the call to global_init_daemonize() to earlier in ceph_osd.c:main().
Sage had already warned that moving OSD daemonize is not safe, so I attempted
to not move it. Unfortunately, this leads to a segfault. Either blkin needs
initialized sooner as Marios had done, or certain tracing calls needed to be
made conditional on blkin's initialization.

So, I then attempted to modify blkin's ZTracer::create_ZTraceEndpoint(), which
valgrind pointed at, to only create the endpoint if blkin_init() had been
called. But that patch resulted in bad health as reported by './ceph status':

     health HEALTH_WARN
            mds a,b,c are laggy
     ...

For now, I've continued with Marios' original global_init_daemonize() move.


After fixing the outstanding issues:

 1. push a wip-blkin branch to github.com/ceph and take advantage of gitbuilder test/qa
 2. submit a pull request
 3. add Andreas' tracepoints https://github.com/ceph/ceph/pull/2877 using Blkin
    and investigate how easy it is to select the level of tracing detail

Changes since V4:

  * removed messenger_end trace event
    In Pipe::reader(), when message is enqueued, it will be destroyed.
    Naive pointer checks don't work here. You can't depend on
    pointers being set to null on destruction. It may be possible to wrap
    trace event with m->get() and m->put() to keep it around, or put this
    trace event in dispatch paths, but just removing trace event for now
    in order to move forward.
  * removed mutex in aio_*_traced() methods
    A mutex was carried forward from Marios' original patch while rebasing
    when it should have been removed.
  * removed Message::trace_end_after_span
    Message::trace_end_after_span did not ever appear to be true, so
    it has been removed
  * added asserts for master trace and endpoint checks
    Tried to use asserts in more places, but they prevented execution.
    Tried to use douts and ldouts instead, but they didn't work.
  * added parens around macro pointer args
    parens make it safer to use pointers passed as arguments in a macro

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
