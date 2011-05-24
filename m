From: Simon Tian <aixt2006@gmail.com>
Subject: Re: using librbd in my application
Date: Tue, 24 May 2011 09:58:53 +0800
Message-ID: <BANLkTiniw1KXkSw0yX1UoEg5K0cn_6BUPw@mail.gmail.com>
References: <BANLkTimz7_cahNvxF4N7FVpW1hBs9N=rDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57728 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab1EXB6z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 May 2011 21:58:55 -0400
Received: by wya21 with SMTP id 21so4631100wya.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 May 2011 18:58:53 -0700 (PDT)
In-Reply-To: <BANLkTimz7_cahNvxF4N7FVpW1hBs9N=rDQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

If call wait_for_complete() and release() every time, the It will seem
like just a synchronized mean..Ha ha,
So I think the callback function should pass the return value in, and
the completion should be released as soon as possible. This will make
the performance better.

So I modified some code:
librbd.hpp:
typedef void (*callback_t)(completion_t cb, void *arg, ssize_t rval);

librbd.cc:
void AioCompletion::complete_block(AioBlockCompletion
*block_completion, ssize_t r)
{
  dout(10) << "AioCompletion::complete_block this=3D" << (void *)this <=
<
" complete_cb=3D" << (void *)complete_cb << dendl;
  lock.Lock();
  if (rval >=3D 0) {
    if (r < 0 && r !=3D -EEXIST)
      rval =3D r;
    else if (r > 0)
      rval +=3D r;
  }
  assert(pending_count);
  //put_unlock();
  int count =3D --pending_count;

  if (!count) {
    done =3D true;
    cond.Signal();
    if (complete_cb)
    {
      complete_cb(rbd_comp, complete_arg, rval);
    }
    lock.Unlock();
    librbd::RBD::AioCompletion * comp_temp =3D
(librbd::RBD::AioCompletion *)(rbd_comp);
    comp_temp->release();
  }
  else{
    lock.Unlock();
  }
}

I apply this, when aio reading, segment fault comes:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x410a3940 (LWP 8913)]
0x00007f2c622a5b54 in librbd::AioBlockCompletion::complete
(this=3D0x7f2c5c006ea0, r=3D0) at librbd.cc:1231
1231	      memcpy(buf + buf_bl_pos, data_bl.c_str() + bl_ofs, extent_le=
n);
(gdb) bt
#0  0x00007f2c622a5b54 in librbd::AioBlockCompletion::complete
(this=3D0x7f2c5c006ea0, r=3D0) at librbd.cc:1231
#1  0x00007f2c622a5e66 in librbd::rados_aio_sparse_read_cb
(c=3D0x7f2c5c008520, arg=3D0x7f2c5c006ea0) at librbd.cc:1342
#2  0x00007f2c61e7d832 in
librados::RadosClient::C_aio_sparse_read_Ack::finish
(this=3D0x7f2c5c0060b0, r=3D0)
    at librados.cc:470
#3  0x00007f2c61ea62af in Objecter::handle_osd_op_reply
(this=3D0x612bd0, m=3D0x614420) at osdc/Objecter.cc:801
#4  0x00007f2c61e58922 in librados::RadosClient::_dispatch
(this=3D0x60ebf0, m=3D0x614420) at librados.cc:751
#5  0x00007f2c61e589e6 in librados::RadosClient::ms_dispatch
(this=3D0x60ebf0, m=3D0x614420) at librados.cc:717
#6  0x00007f2c61e9bd77 in Messenger::ms_deliver_dispatch
(this=3D0x6102c0, m=3D0x614420) at msg/Messenger.h:98
#7  0x00007f2c61e82907 in SimpleMessenger::dispatch_entry
(this=3D0x6102c0) at msg/SimpleMessenger.cc:352
#8  0x00007f2c61e805f5 in SimpleMessenger::DispatchThread::entry
(this=3D0x610748) at ./msg/SimpleMessenger.h:533
#9  0x00007f2c61e93582 in Thread::_entry_func (arg=3D0x610748) at
common/Thread.h:41
#10 0x000000312be064a7 in start_thread () from /lib64/libpthread.so.0
#11 0x000000312b6d3c2d in clone () from /lib64/libc.so.6
(gdb) p buf
$6 =3D 0x7f2c583fe010 <Address 0x7f2c583fe010 out of bounds>
(gdb)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I guess releasing is too early for reading, is it right? Can anyone hel=
p me?

Thx!
Simon

2011/5/21 Simon Tian <aixt2006@gmail.com>:
> Hi Sage,
>
> =C2=A0 =C2=A0 =C2=A0I have two question about using librbd:
> =C2=A01. There always two clients, Client A and B are both developed =
with
> librbd, and running on different hosts.
> Scenario (1): Client A open an image for read and write, Client B ope=
n
> the same image for read.
> Scenario (2): Client A and client B both open the same image for read=
 and write.
>
> For scenario (1), I did some test today, glad to tell that two client
> are both working safely.
> I didn't do a test for scenario (2). =C2=A0I am not very familiar wit=
h the
> librbd code yet.
> I want to know, would clients in scenario (2) working safely? Will
> data writing at the same object be serialized?
> And reading delayed? Seem that the phd thesis mentioned that multi
> client write will be serialized by rados.
> Hope I got the right understanding.
>
> 2. =C2=A0I need to use the callback of aio_write and aio_read in my c=
lient:
> =C2=A0typedef void (*callback_t)(completion_t cb, void *arg);
> =C2=A0At here, what is the completion_t cb mean? how to utilize it?
> =C2=A0I need to use the return value in the callback function other t=
han
> call get_return_value() after wait_for_complete(). How can I get the
> value?
> I guess maybe I can do this in the callback function:
> callback_t my_cb(completion_t cb, void *arg)
> {
> =C2=A0librbd::RBD::AioCompletion *comp =3D (librbd::RBD::AioCompletio=
n *)c;
> =C2=A0int ret =3D comp->get_return_value();
>
> }
> Hmm, Is it right?
>
>
> Thanks!
> Simon
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
