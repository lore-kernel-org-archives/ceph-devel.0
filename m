From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: librados write operation
Date: Wed, 29 Jun 2016 13:58:03 +1000
Message-ID: <CAF-wwdHdLb4LYRnvv5+KHKufT4ogr+5GZHdAM5oGL3Wh3=zhqQ@mail.gmail.com>
References: <CAG0LszkAibL2q=1XF+iXjJZBGYUgLbfeq1H5-dsYN75FZOMpmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33661 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbcF2EFP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 00:05:15 -0400
Received: by mail-wm0-f53.google.com with SMTP id r190so30734774wmr.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 21:05:09 -0700 (PDT)
In-Reply-To: <CAG0LszkAibL2q=1XF+iXjJZBGYUgLbfeq1H5-dsYN75FZOMpmg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sugang Li <sugangli@winlab.rutgers.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Using strace we can see that sendmsg is used for communications to the OSD.

$ gdb -q --args bin/rados -p rbd put test /etc/hosts
Reading symbols from bin/rados...done.
(gdb) set follow-fork-mode child
(gdb) catch syscall sendmsg
Catchpoint 1 (syscall 'sendmsg' [46])
(gdb) r
Starting program: /home/brad/working/src/ceph/build/bin/rados -p rbd
put test /etc/hosts
Thread 11 "ms_pipe_write" hit Catchpoint 2 (call to syscall sendmsg),
0x00007fffe5aa12fd in sendmsg () at
../sysdeps/unix/syscall-template.S:84
84      T_PSEUDO (SYSCALL_SYMBOL, SYSCALL_NAME, SYSCALL_NARGS)
(gdb) bt
#0  0x00007fffe5aa12fd in sendmsg () at ../sysdeps/unix/syscall-template.S:84
#1  0x00007fffef5c8603 in Pipe::do_sendmsg (this=this@entry=0x1067000,
msg=msg@entry=0x7ffff7fa1730, len=len@entry=9, more=more@entry=false)
at /home/brad/working/src/ceph/src/msg/simple/Pipe.cc:2227
#2  0x00007fffef5db03c in Pipe::connect (this=this@entry=0x1067000) at
/home/brad/working/src/ceph/src/msg/simple/Pipe.cc:951
#3  0x00007fffef5dfa02 in Pipe::writer (this=0x1067000) at
/home/brad/working/src/ceph/src/msg/simple/Pipe.cc:1728
#4  0x00007fffef5e26bd in Pipe::Writer::entry (this=<optimized out>)
at /home/brad/working/src/ceph/src/msg/simple/Pipe.h:63
#5  0x00007fffe5a985ca in start_thread (arg=0x7ffff7fa4700) at
pthread_create.c:333
#6  0x00007fffe20f6ead in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

So now we know we send via Pipe::connect -> Pipe::do_sendmsg -> sendmsg.

(gdb) f 2
#2  0x00007fffef5db03c in Pipe::connect (this=this@entry=0x1067000) at
/home/brad/working/src/ceph/src/msg/simple/Pipe.cc:951
951       rc = do_sendmsg(&msg, msglen);
(gdb) p ntohs(peer_addr.u.sin.sin_port)
$5 = 6789

6789 is the MON so we need to find a connection to an OSD.

(gdb) del
Delete all breakpoints? (y or n) y
(gdb) b /home/brad/working/src/ceph/src/msg/simple/Pipe.cc:951
Breakpoint 3 at 0x7fffe614f9ff:
/home/brad/working/src/ceph/src/msg/simple/Pipe.cc:951. (2 locations)
(gdb) c
Continuing.

Thread 12 "ms_pipe_write" hit Breakpoint 1, Pipe::connect
(this=this@entry=0x7fffbc000dd0) at
/home/brad/working/src/ceph/src/msg/simple/Pipe.cc:951
951       rc = do_sendmsg(&msg, msglen);
(gdb) p ntohs(peer_addr.u.sin.sin_port)
$3 = 6789                <-------------------------------- 6789 is a
MON so move on
(gdb) c
Continuing.
Thread 16 "ms_pipe_write" hit Breakpoint 1, Pipe::connect
(this=this@entry=0x1071750) at
/home/brad/working/src/ceph/src/msg/simple/Pipe.cc:951
951       rc = do_sendmsg(&msg, msglen);
(gdb) p ntohs(peer_addr.u.sin.sin_port)
$4 = 6800                <-------------------------------- 6800 is an OSD
(gdb) bt
#0  Pipe::connect (this=this@entry=0x10719a0) at
/home/brad/working/src/ceph/src/msg/simple/Pipe.cc:951
#1  0x00007fffef5dfa02 in Pipe::writer (this=0x10719a0) at
/home/brad/working/src/ceph/src/msg/simple/Pipe.cc:1728
#2  0x00007fffef5e26bd in Pipe::Writer::entry (this=<optimized out>)
at /home/brad/working/src/ceph/src/msg/simple/Pipe.h:63
#3  0x00007fffe5a985ca in start_thread (arg=0x7fffccff9700) at
pthread_create.c:333
#4  0x00007fffe20f6ead in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

Now in Pipe::Writer we make the following call.

1798          // grab outgoing message
1799          Message *m = _get_next_outgoing();

Remember that, it'll come in handy later :) So we know how the write
actually happens in the writer thread but not (yet) how the queue gets
populated.

Now, here's the entire stack where we do the actual put (took a lot of
reading of the code to work out where to put the breakpoint).

(gdb) bt
#0  Pipe::_send (m=0x10761e0, this=0x1073da0) at
/home/brad/working/src/ceph/src/msg/simple/Pipe.h:304
#1  SimpleMessenger::submit_message (this=this@entry=0x105ff60,
m=m@entry=0x10761e0, con=con@entry=0x1073120, dest_addr=...,
dest_type=4, already_locked=already_locked@entry=false)
    at /home/brad/working/src/ceph/src/msg/simple/SimpleMessenger.cc:449
#2  0x00007fffef48eb51 in SimpleMessenger::_send_message
(this=0x105ff60, m=0x10761e0, con=0x1073120) at
/home/brad/working/src/ceph/src/msg/simple/SimpleMessenger.cc:140
#3  0x00007fffeef13182 in Objecter::_send_op
(this=this@entry=0x1061ee0, op=op@entry=0x10733b0,
m=m@entry=0x10761e0) at
/home/brad/working/src/ceph/src/osdc/Objecter.cc:3104
#4  0x00007fffeef14340 in Objecter::_op_submit
(this=this@entry=0x1061ee0, op=op@entry=0x10733b0, sul=...,
ptid=ptid@entry=0x7fffffffb878) at
/home/brad/working/src/ceph/src/osdc/Objecter.cc:2364
#5  0x00007fffeef18694 in Objecter::_op_submit_with_budget
(this=this@entry=0x1061ee0, op=op@entry=0x10733b0, sul=...,
ptid=ptid@entry=0x7fffffffb878, ctx_budget=ctx_budget@entry=0x0)
    at /home/brad/working/src/ceph/src/osdc/Objecter.cc:2197
#6  0x00007fffeef1892e in Objecter::op_submit (this=0x1061ee0,
op=op@entry=0x10733b0, ptid=0x7fffffffb878, ptid@entry=0x0,
ctx_budget=ctx_budget@entry=0x0) at
/home/brad/working/src/ceph/src/osdc/Objecter.cc:2164
#7  0x00007fffeeeddee6 in librados::IoCtxImpl::operate
(this=this@entry=0x1072a50, oid=..., o=o@entry=0x7fffffffbb30,
pmtime=pmtime@entry=0x0, flags=flags@entry=0) at
/home/brad/working/src/ceph/src/librados/IoCtxImpl.cc:693
#8  0x00007fffeeee3214 in librados::IoCtxImpl::write_full
(this=0x1072a50, oid=..., bl=...) at
/home/brad/working/src/ceph/src/librados/IoCtxImpl.cc:636
#9  0x00007fffeeea7e6e in librados::IoCtx::write_full
(this=this@entry=0x7fffffffbd90, oid="test", bl=...) at
/home/brad/working/src/ceph/src/librados/librados.cc:1200
#10 0x0000000000417121 in do_put (use_striper=false,
op_size=<optimized out>, infile=0x7fffffffe44a "/etc/hosts",
objname=<optimized out>, striper=..., io_ctx=..., this=<optimized
out>)
    at /home/brad/working/src/ceph/src/tools/rados/rados.cc:441
#11 rados_tool_common (nargs=std::vector of length 3, capacity 8 =
{...}, opts=std::map with 1 elements = {...}) at
/home/brad/working/src/ceph/src/tools/rados/rados.cc:2079
#12 main (argc=<optimized out>, argv=<optimized out>) at
/home/brad/working/src/ceph/src/tools/rados/rados.cc:3433
(gdb) l 308
303         void _send(Message *m) {
304           assert(pipe_lock.is_locked());
305           out_q[m->get_priority()].push_back(m);
306           cond.Signal();
307         }

So that's where the message finally gets added to the queue.

Now remember _get_next_outgoing()?

313     Message *_get_next_outgoing() {
314       assert(pipe_lock.is_locked());
315       Message *m = 0;
316       while (!m && !out_q.empty()) {
317         map<int, list<Message*> >::reverse_iterator p = out_q.rbegin();
318         if (!p->second.empty()) {
319           m = p->second.front();
320           p->second.pop_front();
321         }
322         if (p->second.empty())
323           out_q.erase(p->first);
324       }
325       return m;
326     }

It's busy reading the queue we just populated.

HTH,
Brad

On Wed, Jun 29, 2016 at 7:06 AM, Sugang Li <sugangli@winlab.rutgers.edu> wrote:
> Hi everyone,
>
> I am looking into the ceph src code about how the write is
> implemented. When I am using rados bench to perform write operation,
> I can see that "void write(uint64_t off, bufferlist& bl, uint64_t
> truncate_size, uint32_t truncate_seq)" in Objecter.h is called for
> every write, and this operation is put into a queue named "ops". My
> understand is that, another process/thread will dequeue this
> operation, and look up the CRUSH maps to find a primary OSD and push
> it the data (or ask it to pull the data). If this is the case, what
> exactly function is doing this? If this is not the case, then what
> will be the following operation?
>
> Thanks,
>
> Sugang
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
