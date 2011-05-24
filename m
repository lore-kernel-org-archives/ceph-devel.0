From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: using librbd in my application
Date: Tue, 24 May 2011 16:44:28 -0700
Message-ID: <4DDC42DC.5080208@dreamhost.com>
References: <BANLkTimz7_cahNvxF4N7FVpW1hBs9N=rDQ@mail.gmail.com> <BANLkTiniw1KXkSw0yX1UoEg5K0cn_6BUPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:37375 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757689Ab1EXXo2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 May 2011 19:44:28 -0400
In-Reply-To: <BANLkTiniw1KXkSw0yX1UoEg5K0cn_6BUPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 05/23/2011 06:58 PM, Simon Tian wrote:
> Hi,
>
> If call wait_for_complete() and release() every time, the It will seem
> like just a synchronized mean..Ha ha,
> So I think the callback function should pass the return value in, and
> the completion should be released as soon as possible. This will make
> the performance better.
>
> So I modified some code:
> librbd.hpp:
> typedef void (*callback_t)(completion_t cb, void *arg, ssize_t rval);
>
> librbd.cc:
> void AioCompletion::complete_block(AioBlockCompletion
> *block_completion, ssize_t r)
> {
>    dout(10)<<  "AioCompletion::complete_block this="<<  (void *)this<<
> " complete_cb="<<  (void *)complete_cb<<  dendl;
>    lock.Lock();
>    if (rval>= 0) {
>      if (r<  0&&  r != -EEXIST)
>        rval = r;
>      else if (r>  0)
>        rval += r;
>    }
>    assert(pending_count);
>    //put_unlock();
>    int count = --pending_count;
>
>    if (!count) {
>      done = true;
>      cond.Signal();
>      if (complete_cb)
>      {
>        complete_cb(rbd_comp, complete_arg, rval);
>      }
>      lock.Unlock();
>      librbd::RBD::AioCompletion * comp_temp =
> (librbd::RBD::AioCompletion *)(rbd_comp);
>      comp_temp->release();
>    }
>    else{
>      lock.Unlock();
>    }
> }

I'm not sure how much this will help. Can you measure the difference
once it's working?

> I apply this, when aio reading, segment fault comes:
> =======================================
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x410a3940 (LWP 8913)]
> 0x00007f2c622a5b54 in librbd::AioBlockCompletion::complete
> (this=0x7f2c5c006ea0, r=0) at librbd.cc:1231
> 1231	      memcpy(buf + buf_bl_pos, data_bl.c_str() + bl_ofs, extent_len);
> (gdb) bt
> #0  0x00007f2c622a5b54 in librbd::AioBlockCompletion::complete
> (this=0x7f2c5c006ea0, r=0) at librbd.cc:1231
> #1  0x00007f2c622a5e66 in librbd::rados_aio_sparse_read_cb
> (c=0x7f2c5c008520, arg=0x7f2c5c006ea0) at librbd.cc:1342
> #2  0x00007f2c61e7d832 in
> librados::RadosClient::C_aio_sparse_read_Ack::finish
> (this=0x7f2c5c0060b0, r=0)
>      at librados.cc:470
> #3  0x00007f2c61ea62af in Objecter::handle_osd_op_reply
> (this=0x612bd0, m=0x614420) at osdc/Objecter.cc:801
> #4  0x00007f2c61e58922 in librados::RadosClient::_dispatch
> (this=0x60ebf0, m=0x614420) at librados.cc:751
> #5  0x00007f2c61e589e6 in librados::RadosClient::ms_dispatch
> (this=0x60ebf0, m=0x614420) at librados.cc:717
> #6  0x00007f2c61e9bd77 in Messenger::ms_deliver_dispatch
> (this=0x6102c0, m=0x614420) at msg/Messenger.h:98
> #7  0x00007f2c61e82907 in SimpleMessenger::dispatch_entry
> (this=0x6102c0) at msg/SimpleMessenger.cc:352
> #8  0x00007f2c61e805f5 in SimpleMessenger::DispatchThread::entry
> (this=0x610748) at ./msg/SimpleMessenger.h:533
> #9  0x00007f2c61e93582 in Thread::_entry_func (arg=0x610748) at
> common/Thread.h:41
> #10 0x000000312be064a7 in start_thread () from /lib64/libpthread.so.0
> #11 0x000000312b6d3c2d in clone () from /lib64/libc.so.6
> (gdb) p buf
> $6 = 0x7f2c583fe010<Address 0x7f2c583fe010 out of bounds>
> (gdb)
> =======================================
>
> I guess releasing is too early for reading, is it right? Can anyone help me?

Your change shouldn't cause this crash - 
librbd::AioCompletion::block_complete isn't called until the end of
librbd::AioBlockCompletion::complete.

If you're using the C++ interface, how are you initializing the
bufferlist you pass to Image::aio_read?

If you're using the C interface, make sure your beffer has enough space
for the length of your read.

Josh
