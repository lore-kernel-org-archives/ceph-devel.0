From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH] msgr: Correctly handle half-open connections.
Date: Thu, 2 Dec 2010 13:26:49 -0700
Message-ID: <1291321609.4879.193.camel@sale659.sandia.gov>
References: <1291318895-11879-1-git-send-email-jaschut@sandia.gov>
 <Pine.LNX.4.64.1012021157010.1982@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:55374 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab0LBU1B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Dec 2010 15:27:01 -0500
In-Reply-To: <Pine.LNX.4.64.1012021157010.1982@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Thu, 2010-12-02 at 13:02 -0700, Sage Weil wrote:
> Hi Jim,
> 
> On Thu, 2 Dec 2010, Jim Schutt wrote:
> > If poll() says a socket is ready for reading, but zero bytes
> > are read, that means that the peer has sent a FIN.  Handle that.
> 
> Hmm.  I think I saw a version of this a week or two ago.  Basically 
> tcp_wait() returned, and then I read 0 bytes.  I "fixed" it with commit
> 71369541ab4ac1752fca3a6134ea51f5cc0bea9f.  

Yes, I saw that one.  It had a comment "just loop" 
that made me suspicious when I saw the stacks below....  

> 
> It seems like, if that happens, we would loop back to poll(), and then get 
> a HUP, and then exit?  

It's not clear to me that poll() will necessarily
clear POLLIN after the first poll() on a 
half-open connection?   The original code didn't
test for POLLHUP....

> I guess I'm not seeing where the busy loop comes 
> in (I'm no socket expert)...

So I looked at the stack of one of those runaway threads I
mention below, via /proc/<pid>/task/<tid>/stack, and here's 
what I saw:

[root@an8 10702]# cat stack
[<ffffffff81002c95>] sysret_careful+0xd/0x10
[<ffffffffffffffff>] 0xffffffffffffffff
[root@an8 10702]# cat stack
[<ffffffff81002c95>] sysret_careful+0xd/0x10
[<ffffffffffffffff>] 0xffffffffffffffff
[root@an8 10702]# cat stack
[<ffffffff81002c95>] sysret_careful+0xd/0x10
[<ffffffffffffffff>] 0xffffffffffffffff
[root@an8 10702]# cat stack
[<ffffffff81002c95>] sysret_careful+0xd/0x10
[<ffffffffffffffff>] 0xffffffffffffffff
[root@an8 10702]# cat stack
[<ffffffff8103de13>] __cond_resched+0x2a/0x35
[<ffffffff810f898f>] might_fault+0xe/0x10
[<ffffffff810f89b1>] copy_from_user+0x20/0x35
[<ffffffff810f9048>] do_sys_poll+0x96/0x3a6
[<ffffffff810f93af>] sys_poll+0x57/0xb7
[<ffffffff81002c2b>] system_call_fastpath+0x16/0x1b
[<ffffffffffffffff>] 0xffffffffffffffff
[root@an8 10702]# cat stack
[<ffffffffffffffff>] 0xffffffffffffffff
[root@an8 10702]# cat stack
[<ffffffff8103de13>] __cond_resched+0x2a/0x35
[<ffffffff812cb32e>] lock_sock_nested+0x16/0x41
[<ffffffff8130c59a>] lock_sock+0x10/0x12
[<ffffffff8130ef5b>] tcp_recvmsg+0x2f/0x8e4
[<ffffffff8132928b>] inet_recvmsg+0x5f/0x7d
[<ffffffff812c682f>] __sock_recvmsg_nosec+0x2e/0x30
[<ffffffff812c7f47>] __sock_recvmsg+0x4e/0x5a
[<ffffffff812c84d0>] sock_recvmsg+0xab/0xc4
[<ffffffff812c8a1c>] sys_recvfrom+0xe0/0x14e
[<ffffffff81002c2b>] system_call_fastpath+0x16/0x1b
[<ffffffffffffffff>] 0xffffffffffffffff

I took this as a clue my runaway threads were
banging on recv(), and the only way I could
see that that would happen is the loop on
zero bytes read.

I think the busy loop is that when a FIN is received,
poll() will continue to return POLLIN as many times
as you call it, and recv() will return 0 every time.
Since we weren't testing POLLHUP, even if it was there
we wouldn't see it.

Then I looked at Stevens' Unix Network Programming V1, p. 170 2ed.
(at the bottom) and found this gem:

  When the read-half of a TCP connection is closed (e.g. a FIN
  is received), this is also considered normal data and a 
  subsequent read operation will return 0.

Since I'm not sure about how various flavors of Unix handle
this, I'm proposing to handle every possible variation.

> 
> Also, this worries me (see below)
> 
> 
> > 
> > One way the incorrect handling was manifesting is as follows:
> > 
> > Under a heavy write load, clients log many messages like this:
> > 
> > [19021.523192] libceph:  tid 876 timed out on osd6, will reset osd
> > [19021.523328] libceph:  tid 866 timed out on osd10, will reset osd
> > [19081.616032] libceph:  tid 841 timed out on osd0, will reset osd
> > [19081.616121] libceph:  tid 826 timed out on osd2, will reset osd
> > [19081.616176] libceph:  tid 806 timed out on osd3, will reset osd
> > [19081.616226] libceph:  tid 875 timed out on osd9, will reset osd
> > [19081.616275] libceph:  tid 834 timed out on osd12, will reset osd
> > [19081.616326] libceph:  tid 874 timed out on osd10, will reset osd
> > 
> > After the clients are done writing and the file system should
> > be quiet, osd hosts have a high load with many active threads:
> > 
> > $ ps u -C cosd
> > USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> > root      1383  162 11.5 1456248 943224 ?      Ssl  11:31 406:59 /usr/bin/cosd -i 7 -c /etc/ceph/ceph.conf
> > 
> > $ for p in `ps -C cosd -o pid --no-headers`; do grep -nH State /proc/$p/task/*/status | grep -v sleep; done
> > /proc/1383/task/10702/status:2:State:   R (running)
> > /proc/1383/task/10710/status:2:State:   R (running)
> > /proc/1383/task/10717/status:2:State:   R (running)
> > /proc/1383/task/11396/status:2:State:   R (running)
> > /proc/1383/task/27111/status:2:State:   R (running)
> > /proc/1383/task/27117/status:2:State:   R (running)
> > /proc/1383/task/27162/status:2:State:   R (running)
> > /proc/1383/task/27694/status:2:State:   R (running)
> > /proc/1383/task/27704/status:2:State:   R (running)
> > /proc/1383/task/27728/status:2:State:   R (running)
> > 
> > With this fix applied, a heavy load still causes many client
> > resets of osds, but no runaway threads result.
> > 
> > Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> > ---
> >  src/msg/SimpleMessenger.cc |    2 +-
> >  src/msg/tcp.cc             |   52 +++++++++++++++++++++++++++-----------------
> >  src/msg/tcp.h              |    2 +-
> >  3 files changed, 34 insertions(+), 22 deletions(-)
> > 
> > diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
> > index 97ed4c3..0c9a0bd 100644
> > --- a/src/msg/SimpleMessenger.cc
> > +++ b/src/msg/SimpleMessenger.cc
> > @@ -1875,7 +1875,7 @@ int SimpleMessenger::Pipe::read_message(Message **pm)
> >  	
> >      while (left > 0) {
> >        // wait for data
> > -      if (tcp_wait(sd, messenger->timeout) < 0)
> > +      if (tcp_read_wait(sd, messenger->timeout) < 0)
> >  	goto out_dethrottle;
> >  
> >        // get a buffer
> > diff --git a/src/msg/tcp.cc b/src/msg/tcp.cc
> > index c1be756..71d85f1 100644
> > --- a/src/msg/tcp.cc
> > +++ b/src/msg/tcp.cc
> > @@ -13,9 +13,6 @@ int tcp_read(int sd, char *buf, int len, int timeout)
> >    if (sd < 0)
> >      return -1;
> >  
> > -  struct pollfd pfd;
> > -  pfd.fd = sd;
> > -  pfd.events = POLLIN | POLLHUP | POLLRDHUP | POLLNVAL | POLLERR;
> >    while (len > 0) {
> >  
> >      if (g_conf.ms_inject_socket_failures && sd >= 0) {
> > @@ -25,24 +22,14 @@ int tcp_read(int sd, char *buf, int len, int timeout)
> >        }
> >      }
> >  
> > -    if (poll(&pfd, 1, timeout) <= 0)
> > +    if (tcp_read_wait(sd, timeout) < 0)
> >        return -1;
> >  
> > -    if (!(pfd.revents & POLLIN))
> > -      return -1;
> > +    int got = tcp_read_nonblocking(sd, buf, len);
> >  
> > -    /*
> > -     * although we turn on the MSG_DONTWAIT flag, we don't expect
> > -     * receivng an EAGAIN, as we polled on the socket, so there
> > -     * should be data waiting for us.
> > -     */
> > -    int got = ::recv( sd, buf, len, MSG_DONTWAIT );
> > -    if (got <= 0) {
> > -      //char buf[100];
> > -      //generic_dout(0) << "tcp_read socket " << sd << " returned " << got
> > -      //<< " errno " << errno << " " << strerror_r(errno, buf, sizeof(buf)) << dendl;
> > +    if (got < 0)
> >        return -1;
> > -    }
> > +
> >      len -= got;
> >      buf += got;
> >      //generic_dout(DBL) << "tcp_read got " << got << ", " << len << " left" << dendl;
> > @@ -50,26 +37,51 @@ int tcp_read(int sd, char *buf, int len, int timeout)
> >    return len;
> >  }
> >  
> > -int tcp_wait(int sd, int timeout) 
> > +int tcp_read_wait(int sd, int timeout) 
> >  {
> >    if (sd < 0)
> >      return -1;
> >    struct pollfd pfd;
> >    pfd.fd = sd;
> > -  pfd.events = POLLIN | POLLHUP | POLLRDHUP | POLLNVAL | POLLERR;
> > +  pfd.events = POLLIN | POLLRDHUP;
> 
> I'm not familiar with all of those flags, but we want to make sure we 
> error out when anything bad happens, and POLLERR | PULLHUP | POLLNVAL 
> certainly seem like they're in that category. 

Right.  But Linux poll manpage and Stevens agree that 
POLLHUP, POLLNVAL, POLLERR are output only flags?

>  And a few lines down 
> 
> >  
> >    if (poll(&pfd, 1, timeout) <= 0)
> >      return -1;
> >  
> > +  if (pfd.revents & (POLLERR | POLLHUP | POLLRDHUP | POLLNVAL))
> > +    return -1;
> > +
> 
> And will pfd.revents ever have POLLHUP or POLLNVAL if we didn't ask for 
> them above?

I think so, based on the manpage saying they are output flags.

-- Jim

> Thanks!
> sage
> 
> 
> >    if (!(pfd.revents & POLLIN))
> >      return -1;
> >  
> >    return 0;
> >  }
> >  
> > +/* This function can only be called if poll/select says there is
> > + * data available.  Otherwise we cannot properly interpret a
> > + * read of 0 bytes.
> > + */
> >  int tcp_read_nonblocking(int sd, char *buf, int len)
> >  {
> > -  return ::recv(sd, buf, len, MSG_DONTWAIT);
> > +again:
> > +  int got = ::recv( sd, buf, len, MSG_DONTWAIT );
> > +  if (got < 0) {
> > +    if (errno == EAGAIN || errno == EINTR) {
> > +      goto again;
> > +    } else {
> > +      char buf[100];
> > +      generic_dout(10) << "tcp_read_nonblocking socket " << sd << " returned "
> > +        << got << " errno " << errno << " " << strerror_r(errno, buf, sizeof(buf)) << dendl;
> > +      return -1;
> > +    }
> > +  } else if (got == 0) {
> > +    /* poll() said there was data, but we didn't read any - peer
> > +     * sent a FIN.  Maybe POLLRDHUP signals this, but this is
> > +     * standard socket behavior as documented by Stevens.
> > +     */
> > +    return -1;
> > +  }
> > +  return got;
> >  }
> >  
> >  int tcp_write(int sd, const char *buf, int len)
> > diff --git a/src/msg/tcp.h b/src/msg/tcp.h
> > index 31ae967..bccdbda 100644
> > --- a/src/msg/tcp.h
> > +++ b/src/msg/tcp.h
> > @@ -26,7 +26,7 @@ inline ostream& operator<<(ostream& out, const sockaddr_storage &ss)
> >  }
> >  
> >  extern int tcp_read(int sd, char *buf, int len, int timeout=-1);
> > -extern int tcp_wait(int sd, int timeout);
> > +extern int tcp_read_wait(int sd, int timeout);
> >  extern int tcp_read_nonblocking(int sd, char *buf, int len);
> >  extern int tcp_write(int sd, const char *buf, int len);
> >  
> > -- 
> > 1.6.6
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


