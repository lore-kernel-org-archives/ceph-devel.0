From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: debugging librbd async
Date: Sat, 17 Aug 2013 00:07:32 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B6649B8B2@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B66498C5D@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308152206200.1479@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B66498DAD@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308152242310.1479@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B66498EC6@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1308160856010.26808@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:56659 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab3HQAHt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Aug 2013 20:07:49 -0400
In-Reply-To: <alpine.DEB.2.00.1308160856010.26808@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Sylvain Munaut (s.munaut@whatever-company.com)" <s.munaut@whatever-company.com>

> > I'm also testing valgrind at the moment, just basic memtest, but suddenly
> > everything is quite stable even though it's under reasonable load right now.
> > Stupid heisenbugs.
> 
> Valgrind makes things go very slow (~10x?), which can have a huge effect
> on timing. Sometimes that reveals new races, other times it hides others.
> :/
> 

That's what I figured. It's run overnight with no hiccups so far under valgrind (helgrind - but no crashes under memtest either). The helgrind process on one tapdisk instance is running pretty hard, but performance is tolerable. I'll leave it go and poke at it occasionally to see if I can reproduce an actual crash.

So far helgrind has identified a bunch of possible races like:

==12478== Possible data race during write of size 4 at 0x913F250 by thread #1
==12478== Locks held: 2, at addresses 0x9119B80 0x913EF88
==12478==    at 0x5821D57: Pipe::Pipe(SimpleMessenger*, int, Connection*) (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x5838FC7: SimpleMessenger::connect_rank(entity_addr_t const&, int, Connection*, Message*) (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x5839414: SimpleMessenger::get_connection(entity_inst_t const&) (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x56D062F: Objecter::get_session(int) (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x56D0FAA: Objecter::recalc_op_target(Objecter::Op*) (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x56D6140: Objecter::_op_submit(Objecter::Op*) (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x56C4640: librados::IoCtxImpl::operate_read(object_t const&, ObjectOperation*, ceph::buffer::list*) (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x56C53D1: librados::IoCtxImpl::stat(object_t const&, unsigned long*, long*) (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x569B83E: librados::IoCtx::stat(std::string const&, unsigned long*, long*) (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x63E45BF: librbd::detect_format(librados::IoCtx&, std::string const&, bool*, unsigned long*) (in /usr/lib/librbd.so.1.0.0)
==12478==    by 0x63DCF6E: librbd::ImageCtx::init() (in /usr/lib/librbd.so.1.0.0)
==12478==    by 0x63F45C7: librbd::open_image(librbd::ImageCtx*) (in /usr/lib/librbd.so.1.0.0)
==12478==
==12478== This conflicts with a previous read of size 4 by thread #9
==12478== Locks held: none
==12478==    at 0x581E6A1: Pipe::tcp_read_wait() (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x581E96F: Pipe::tcp_read(char*, int) (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x581F965: Pipe::read_message(Message**) (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x583138B: Pipe::reader() (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x5834D5C: Pipe::Reader::entry() (in /usr/lib/librados.so.2.0.0)
==12478==    by 0x4C2B5AD: mythread_wrapper (hg_intercepts.c:219)
==12478==    by 0x6650B4F: start_thread (pthread_create.c:304)
==12478==    by 0x6940A7C: clone (clone.S:112)

But I don't think they are correct. There are also some races that appear to relate to memcpy.

Also I believe tapdisk serialises all callbacks and I don't know that helgrind is aware of that completely as it identifies some cases that just can't happen.

The last thing logged is:

==12478== More than 10000000 total errors detected.  I'm not reporting any more.
==12478== Final error counts will be inaccurate.  Go fix your program!
==12478== Rerun with --error-limit=no to disable this cutoff.  Note
==12478== that errors may occur in your program without prior warning from
==12478== Valgrind, because errors are no longer being displayed.

So I think maybe it's stopped being useful in that instance. I can post the full output if you want. It's only about 40kb

James
