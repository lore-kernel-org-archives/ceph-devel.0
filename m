From: Sage Weil <sage@inktank.com>
Subject: RE: debugging librbd async - valgrind memtest hit
Date: Fri, 30 Aug 2013 08:23:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308300820380.24783@cobra.newdream.net>
References: <6035A0D088A63A46850C3988ED045A4B664B63F0@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56488 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163Ab3H3PXz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Aug 2013 11:23:55 -0400
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B664B63F0@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Sylvain Munaut (s.munaut@whatever-company.com)" <s.munaut@whatever-company.com>

On Fri, 30 Aug 2013, James Harper wrote:
> I finally got a valgrind memtest hit... output attached below email. I 
> recompiled all of tapdisk and ceph without any -O options (thought I had 
> already...) and it seems to have done the trick

What version is this?  The line numbers don't seem to match up with my 
source tree.
 
> Basically it looks like an instance of AioRead is being accessed after 
> being free'd. I need some hints on what api behaviour by the tapdisk 
> driver could be causing this to happen in librbd...

It looks like refcounting for the AioCompletion is off.  My first guess 
would be premature (or extra) calls to rados_aio_release or 
AioCompletion::release().

I did a quick look at the code and it looks like aio_read() is carrying a 
ref for the AioComplete for the entire duration of the function, so it 
should not be disappearing (and taking the AioRead request struct with it) 
until well after where the invalid read is.  Maybe there is an error path 
somewhere what is dropping a ref it shouldn't?

sage


> 
> thanks
> 
> James
> 
> ==25078== Memcheck, a memory error detector
> ==25078== Copyright (C) 2002-2011, and GNU GPL'd, by Julian Seward et al.
> ==25078== Using Valgrind-3.7.0 and LibVEX; rerun with -h for copyright info
> ==25078== Command: /usr/bin/tapdisk.clean
> ==25078== Parent PID: 25077
> ==25078==
> ==25078==
> ==25078== HEAP SUMMARY:
> ==25078==     in use at exit: 6,808 bytes in 7 blocks
> ==25078==   total heap usage: 7 allocs, 0 frees, 6,808 bytes allocated
> ==25078==
> ==25078== For a detailed leak analysis, rerun with: --leak-check=full
> ==25078==
> ==25078== For counts of detected and suppressed errors, rerun with: -v
> ==25078== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 4 from 4)
> ==25081== Warning: noted but unhandled ioctl 0xd0 with no size/direction hints
> ==25081==    This could cause spurious value errors to appear.
> ==25081==    See README_MISSING_SYSCALL_OR_IOCTL for guidance on writing a proper wrapper.
> ==25081== Syscall param ioctl(FIBMAP) points to unaddressable byte(s)
> ==25081==    at 0x75F1AC7: ioctl (syscall-template.S:82)
> ==25081==    by 0x4088DF: tapdisk_blktap_complete_request (tapdisk-blktap.c:150)
> ==25081==    by 0x40802C: tapdisk_vbd_kick (tapdisk-vbd.c:1441)
> ==25081==    by 0x40E684: tapdisk_server_iterate (tapdisk-server.c:211)
> ==25081==    by 0x40E864: tapdisk_server_run (tapdisk-server.c:334)
> ==25081==    by 0x4039BF: main (tapdisk2.c:150)
> ==25081==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
> ==25081==
> ==25081== Invalid read of size 8
> ==25081==    at 0x7044DB6: librbd::AioRead::send() (AioRequest.cc:106)
> ==25081==    by 0x7076EDE: librbd::aio_read(librbd::ImageCtx*, std::vector<std::pair<unsigned long, unsigned long>, std::allocator<std::pair<unsigned long, unsigned long> > > const&, char*, ceph::buffer::list*, librbd::AioCompletion*) (internal.cc:3096)
> ==25081==    by 0x7076330: librbd::aio_read(librbd::ImageCtx*, unsigned long, unsigned long, char*, ceph::buffer::list*, librbd::AioCompletion*) (internal.cc:3032)
> ==25081==    by 0x703EF75: rbd_aio_read (librbd.cc:1117)
> ==25081==    by 0x41FDA4: tdrbd_submit_request (block-rbd.c:540)
> ==25081==    by 0x42004A: tdrbd_queue_request (block-rbd.c:659)
> ==25081==    by 0x40602A: tapdisk_vbd_issue_request (tapdisk-vbd.c:1244)
> ==25081==    by 0x4062FA: tapdisk_vbd_issue_new_requests (tapdisk-vbd.c:1340)
> ==25081==    by 0x407C27: tapdisk_vbd_issue_requests (tapdisk-vbd.c:1403)
> ==25081==    by 0x407DBA: tapdisk_vbd_check_state (tapdisk-vbd.c:891)
> ==25081==    by 0x40E62C: tapdisk_server_iterate (tapdisk-server.c:220)
> ==25081==    by 0x40E864: tapdisk_server_run (tapdisk-server.c:334)
> ==25081==  Address 0xfe79b38 is 8 bytes inside a block of size 248 free'd
> ==25081==    at 0x4C279DC: operator delete(void*) (vg_replace_malloc.c:457)
> ==25081==    by 0x7046859: librbd::AioRead::~AioRead() (AioRequest.h:74)
> ==25081==    by 0x70426E6: librbd::AioRequest::complete(int) (AioRequest.h:41)
> ==25081==    by 0x7074323: librbd::rados_req_cb(void*, void*) (internal.cc:2751)
> ==25081==    by 0x5FD191A: librados::C_AioComplete::finish(int) (AioCompletionImpl.h:181)
> ==25081==    by 0x5F907E0: Context::complete(int) (Context.h:42)
> ==25081==    by 0x6066CEF: Finisher::finisher_thread_entry() (Finisher.cc:56)
> ==25081==    by 0x5FB81D3: Finisher::FinisherThread::entry() (Finisher.h:46)
> ==25081==    by 0x62C89E0: Thread::_entry_func(void*) (Thread.cc:41)
> ==25081==    by 0x7308B4F: start_thread (pthread_create.c:304)
> ==25081==    by 0x75F8A7C: clone (clone.S:112)
> ==25081==
> ==25081== Invalid read of size 8
> ==25081==    at 0x7044DBA: librbd::AioRead::send() (AioRequest.cc:106)
> ==25081==    by 0x7076EDE: librbd::aio_read(librbd::ImageCtx*, std::vector<std::pair<unsigned long, unsigned long>, std::allocator<std::pair<unsigned long, unsigned long> > > const&, char*, ceph::buffer::list*, librbd::AioCompletion*) (internal.cc:3096)
> ==25081==    by 0x7076330: librbd::aio_read(librbd::ImageCtx*, unsigned long, unsigned long, char*, ceph::buffer::list*, librbd::AioCompletion*) (internal.cc:3032)
> ==25081==    by 0x703EF75: rbd_aio_read (librbd.cc:1117)
> ==25081==    by 0x41FDA4: tdrbd_submit_request (block-rbd.c:540)
> ==25081==    by 0x42004A: tdrbd_queue_request (block-rbd.c:659)
> ==25081==    by 0x40602A: tapdisk_vbd_issue_request (tapdisk-vbd.c:1244)
> ==25081==    by 0x4062FA: tapdisk_vbd_issue_new_requests (tapdisk-vbd.c:1340)
> ==25081==    by 0x407C27: tapdisk_vbd_issue_requests (tapdisk-vbd.c:1403)
> ==25081==    by 0x407DBA: tapdisk_vbd_check_state (tapdisk-vbd.c:891)
> ==25081==    by 0x40E62C: tapdisk_server_iterate (tapdisk-server.c:220)
> ==25081==    by 0x40E864: tapdisk_server_run (tapdisk-server.c:334)
> ==25081==  Address 0x5555555555555555 is not stack'd, malloc'd or (recently) free'd
> ==25081==
> ==25081==
> ==25081== Process terminating with default action of signal 11 (SIGSEGV): dumping core
> ==25081==  General Protection Fault
> ==25081==    at 0x7044DBA: librbd::AioRead::send() (AioRequest.cc:106)
> ==25081==    by 0x7076EDE: librbd::aio_read(librbd::ImageCtx*, std::vector<std::pair<unsigned long, unsigned long>, std::allocator<std::pair<unsigned long, unsigned long> > > const&, char*, ceph::buffer::list*, librbd::AioCompletion*) (internal.cc:3096)
> ==25081==    by 0x7076330: librbd::aio_read(librbd::ImageCtx*, unsigned long, unsigned long, char*, ceph::buffer::list*, librbd::AioCompletion*) (internal.cc:3032)
> ==25081==    by 0x703EF75: rbd_aio_read (librbd.cc:1117)
> ==25081==    by 0x41FDA4: tdrbd_submit_request (block-rbd.c:540)
> ==25081==    by 0x42004A: tdrbd_queue_request (block-rbd.c:659)
> ==25081==    by 0x40602A: tapdisk_vbd_issue_request (tapdisk-vbd.c:1244)
> ==25081==    by 0x4062FA: tapdisk_vbd_issue_new_requests (tapdisk-vbd.c:1340)
> ==25081==    by 0x407C27: tapdisk_vbd_issue_requests (tapdisk-vbd.c:1403)
> ==25081==    by 0x407DBA: tapdisk_vbd_check_state (tapdisk-vbd.c:891)
> ==25081==    by 0x40E62C: tapdisk_server_iterate (tapdisk-server.c:220)
> ==25081==    by 0x40E864: tapdisk_server_run (tapdisk-server.c:334)
> ==25081==
> ==25081== HEAP SUMMARY:
> ==25081==     in use at exit: 1,356,131 bytes in 2,964 blocks
> ==25081==   total heap usage: 182,178 allocs, 179,214 frees, 37,367,183 bytes allocated
> ==25081==
> ==25081== For a detailed leak analysis, rerun with: --leak-check=full
> ==25081==
> ==25081== For counts of detected and suppressed errors, rerun with: -v
> ==25081== ERROR SUMMARY: 3 errors from 3 contexts (suppressed: 13 from 7)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
