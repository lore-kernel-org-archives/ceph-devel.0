From: Amit Tiwary <tiwaryamt@gmail.com>
Subject: Re: assertion failure while stating an object (librados::IoCtx::stat)
Date: Fri, 4 Apr 2014 18:04:07 +0000 (UTC)
Message-ID: <loom.20140404T195141-120@post.gmane.org>
References: <loom.20140404T115508-66@post.gmane.org> <alpine.DEB.2.00.1404040812400.22715@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44043 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753609AbaDDSEU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Apr 2014 14:04:20 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1WW8TS-00068M-1M
	for ceph-devel@vger.kernel.org; Fri, 04 Apr 2014 20:04:18 +0200
Received: from ABTS-North-Dynamic-160.13.161.122.airtelbroadband.in ([ABTS-North-Dynamic-160.13.161.122.airtelbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 04 Apr 2014 20:04:18 +0200
Received: from tiwaryamt by ABTS-North-Dynamic-160.13.161.122.airtelbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 04 Apr 2014 20:04:18 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil <sage <at> inktank.com> writes:
> 
> Hi Amit,
> > 
> > common/Mutex.cc: In function 'void Mutex::Lock(bool)' thread 
7f615f275700 
> > time 2014-04-04 09:03:22.128731
> > common/Mutex.cc: 93: FAILED assert(r == 0)
> >  ceph version 0.67.4 (ad85b8bfafea6232d64cb7ba76a8b6e8252fa0c7)
> >  1: (Mutex::Lock(bool)+0x1d3) [0x7f61576ac763]
> >  2: (librados::IoCtxImpl::operate_read(object_t const&, 
ObjectOperation*, 
> > ceph::buffer::list*)+0x17b) [0x7f615765069b]
> 
> This Mutex assertion usually triggers in use-after-free cases where the 
> pthread mutex id is invalid (because it has been deallocated).  My guess 
> is that your IoCtx has been freed, or the shutdown() method has been 
> called on the cluster handle... is that possible? (Obviously not with the 
> code fragment above, but I'm guess that isn't a straight copy+paste from 
> your code?)
> 
> sage
> 
Thanks Sage for your input. I would look into the code to figure out if they 
are any calls to IoCtx::close() or Rados::shutdown(). However, on closer 
inspection I find lot of pthread_create() failing (refer log below) with 
error 11 (EAGAIN) indicating "insufficient resources to create another 
thread, or a system-imposed limit on the number of threads was encountered". 
Could Mutex assertion failure be a side effect of this?
-------------------------------
Thread::try_create(): pthread_create failed with error 11
common/Thread.cc: In function 'void Thread::create(size_t)' thread 
7f615f275700 time 2014-04-04 08:57:03.511877
common/Thread.cc: 110: FAILED assert(ret == 0)
 ceph version 0.67.4 (ad85b8bfafea6232d64cb7ba76a8b6e8252fa0c7)
 1: (()+0x36004f) [0x7f615783804f]
 2: (SimpleMessenger::connect_rank(entity_addr_t const&, int, Connection*, 
Message*)+0x17b) [0x7f61577c9b9b]
 3: (SimpleMessenger::get_connection(entity_inst_t const&)+0x244) 
[0x7f61577ce824]
 4: (Objecter::get_session(int)+0x1d1) [0x7f615765b391]
 5: (Objecter::recalc_op_target(Objecter::Op*)+0x336) [0x7f615765c0d6]
 6: (Objecter::_op_submit(Objecter::Op*)+0x43) [0x7f6157665993]
 7: (librados::IoCtxImpl::operate_read(object_t const&, ObjectOperation*, 
ceph::buffer::list*)+0x2dc) [0x7f61576507fc]
 8: (librados::IoCtxImpl::stat(object_t const&, unsigned long*, 
long*)+0x185) [0x7f6157653b05]
 9: (librados::IoCtx::stat(std::string const&, unsigned long*, long*)+0x58) 
[0x7f6157628498]

Regards,
Amit Tiwary

