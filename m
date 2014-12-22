From: Andrew Shewmaker <agshew@gmail.com>
Subject: Status of BlkKin (LTTng + Zipkin) tracing patchset
Date: Mon, 22 Dec 2014 14:20:07 -0700
Message-ID: <20141222212007.GA20840@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36183 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910AbaLVVUL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Dec 2014 16:20:11 -0500
Received: by mail-pd0-f178.google.com with SMTP id r10so6572137pdi.9
        for <ceph-devel@vger.kernel.org>; Mon, 22 Dec 2014 13:20:11 -0800 (PST)
Received: from localhost (host-69-145-59-76.bln-mt.client.bresnan.net. [69.145.59.76])
        by mx.google.com with ESMTPSA id ml5sm18135700pab.32.2014.12.22.13.20.09
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Dec 2014 13:20:10 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I wanted to let the list know that I've been working on rebasing
the V2 BlkKin patchset on top of Ceph master. Unfortunatley, my
basic tracing tests are failing. A 'rados put' spits out:

2014-12-22 09:13:32.172182 7f083019d700  0 -- 128.114.53.124:0/1013940 >> 128.114.53.124:6808/13201 pipe(0x7f081c00cc20 sd=31 
:0 s=1 pgs=0 cs=0 l=1 c=0x7f081c00b170).fault

ceph-osd is catching signals and aborting. From out/osd.0.log:

 1: ./ceph-osd() [0xa0c165]
 2: (()+0xfc90) [0x7f24f366dc90]
 3: (gsignal()+0x37) [0x7f24f1773d27]
 4: (abort()+0x148) [0x7f24f1775418]
 5: (()+0x2fbd6) [0x7f24f176cbd6]
 6: (()+0x2fc82) [0x7f24f176cc82]
 7: ./ceph-osd() [0x5ed618]
 8: (OpTracker::trace_event(TrackedOp*, boost::shared_ptr<ZTracer::ZTrace>, std::string const&, boost::shared_ptr<ZTracer::ZTraceEndpoint>)+0x126) [0x6be236]
 9: (TrackedOp::trace_pg(std::string)+0x83) [0x6bea23]
 10: (OSD::handle_op(std::tr1::shared_ptr<OpRequest>&, std::tr1::shared_ptr<OSDMap const>&)+0x15b8) [0x647b18]
 11: (OSD::dispatch_op_fast(std::tr1::shared_ptr<OpRequest>&, std::tr1::shared_ptr<OSDMap const>&)+0x1ce) [0x6482fe]
 12: (OSD::dispatch_session_waiting(OSD::Session*, std::tr1::shared_ptr<OSDMap const>)+0x98) [0x648568]
 13: (OSD::ms_fast_dispatch(Message*)+0x230) [0x648920]
 14: (DispatchQueue::fast_dispatch(Message*)+0x6e) [0xbc590e]
 15: (Pipe::reader()+0x1cd7) [0xbe6967]
 16: (Pipe::Reader::entry()+0xd) [0xbef17d]
 17: (()+0x80a5) [0x7f24f36660a5]
 18: (clone()+0x6d) [0x7f24f183777d]

I didn't see anything else interesting in the OSD logs, even with debugging 
turned on, but I probably don't know what I should be looking for.

I commented out the BlkKin changes to OSD::handle_op() and Pipe, but the failures
still happened. So, I've been splitting the BlkKin patches up further to try
narrow the problem down. I haven't made much progress yet. Partly because I
ended up wasting time a bit of time on segfaults. It turned out I was causing
them because I left out one of the BlkKin initialization function calls.

At this point I'm thinking I'll add some douts to the BlkKin wrapper macros
to try to find the problem. But I would welcome any ideas on how to debug
this.

Thanks,

Andrew
