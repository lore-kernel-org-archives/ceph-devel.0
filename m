From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH 0/6] blkin (LTTng + Zipkin) tracing
Date: Wed, 12 Nov 2014 16:19:29 -0700
Message-ID: <20141112231929.GA6892@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:51104 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbaKLXTc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Nov 2014 18:19:32 -0500
Received: by mail-pd0-f173.google.com with SMTP id v10so13148467pde.4
        for <ceph-devel@vger.kernel.org>; Wed, 12 Nov 2014 15:19:32 -0800 (PST)
Received: from localhost (host-69-145-59-76.bln-mt.client.bresnan.net. [69.145.59.76])
        by mx.google.com with ESMTPSA id zr9sm23150165pab.44.2014.11.12.15.19.31
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 15:19:31 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The following patches are a cleaned up version of the work 
Marios Kogias first posted in August.
http://www.spinics.net/lists/ceph-devel/msg19890.html
The changes have been made against Ceph 0.80.1, and will be 
moved forward soon.

With them Ceph can use Blkin, a library created by Marios Kogias and others,
which enables tracking a specific request from the time it enters
the system at higher levels till it is finally served by RADOS.

In general, Blkin implements the tracing semantics described in the Dapper
paper http://static.googleusercontent.com/media/research.google.com/el/pubs/archive/36356.pdf
in order to trace the causal relationships between the different
processing phases that an IO request may trigger. The goal is an end-to-end
visualisation of the request's route in the system, accompanied by information
concerning latencies in each processing phase. Thanks to LTTng this can happen
with a minimal overhead and in realtime. In order to visualize the results Blkin 
was integrated with Twitter's Zipkin http://twitter.github.io/zipkin/
(which is a tracing system entirely based on Dapper).

These patches can also be found in https://github.com/agshew/ceph/tree/wip-blkin

In addition to cleanup, I've written a short document describing how to 
test Blkin tracing in Ceph (without Zipkin). See doc/dev/trace.rst

Note that I have a question in to Marios concerning a compiler warning for
ignoring the return value of write() in Message::init_trace_info().
The same calls also use a hardcoded file descriptor 3. I'm guessing this
code was just used by him for debugging Blkin and can be removed, but 
I've left it for the moment.

In the immediate future I plan to:

 - push a wip-blkin branch to github.com/ceph and take advantage of gitbuilder test/qa
 - move the changes forward to ceph:master
 - add Andreas' tracepoints https://github.com/ceph/ceph/pull/2877 using Blkin
   and investigate how easy it is to select the level of tracing detail

Questions:

1. Did I split the patches into sensible groups?

2. How low is LTTng's overhead? Is it entirely eliminated when not enabled?

Do we need to take advantage of something like the Linux kernel's CONFIG_DYNAMIC_FTRACE
trick, where a special mcount() function is converted back and forth between 
a NOP and trace calls? See http://lwn.net/Articles/365835/ for a little more 
detail.

3. Also on the topic of performance, does the API for adding keyvalues need versions
of annotations that used tracing functions with vectorized arguments? For instance,
when many details about an event are required (e.g. read vs. write, length, etc.) 
or if multiple types of events are created simultaneously?
