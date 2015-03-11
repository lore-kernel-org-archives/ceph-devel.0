From: Andrew Shewmaker <agshew@gmail.com>
Subject: (unknown)
Date: Tue, 10 Mar 2015 19:43:25 -0700
Message-ID: <1426041810-3942-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:47066 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbbCKCoE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Mar 2015 22:44:04 -0400
Received: by pdev10 with SMTP id v10so7159353pde.13
        for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2015 19:44:03 -0700 (PDT)
Subject: 
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: agshew@gmail.com, marioskogias@gmail.com, chendi.xue@intel.com

The following patches are based on the work of Marios Kogias, first
posted in August. http://www.spinics.net/lists/ceph-devel/msg19890.html
This patch is against HEAD as of March 10th,
commit 5d5b510810e96503b9323b010149f7bd5b45db7c.
It can also be found at https://github.com/agshew/ceph/tree/wip-blkin-v6

Thanks to Josh Durgin again for comments on the V5 patchset.

I think the blkin patchset is looking pretty good at this point.


Outstanding issues:

1) librados will need more general blkin tracing
currently it only has aio_read_traced() and aio_write_traced() calls

2) some work will need to be done filtering blkin events/keyvalues


To Do:

 1. push a wip-blkin branch to github.com/ceph and take advantage of gitbuilder test/qa
 2. submit a pull request
 3. add Andreas' tracepoints https://github.com/ceph/ceph/pull/2877 using Blkin
    and investigate how easy it is to select the level of tracing detail


Changes since V5:

  * put MOSDOp encode(features) statement back that was accidentally left out in V5
  * moved OSD daemonize call back to original spot
  * initialized blkin in ceph-mds (and moved all initializations to first patch)
  * updated aio_read_traced() and aio_write_traced() to match non-traced versions
  * improved blkin wrapper readability by removing unnecessary stringification

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
