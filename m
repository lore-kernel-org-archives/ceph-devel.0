From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH] msgr: Correctly handle half-open connections.
Date: Thu, 2 Dec 2010 14:06:39 -0700
Message-ID: <1291323999.4879.198.camel@sale659.sandia.gov>
References: <1291318895-11879-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:35206 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757575Ab0LBVGv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Dec 2010 16:06:51 -0500
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 1F542544B51
	for <ceph-devel@vger.kernel.org>; Thu,  2 Dec 2010 14:06:45 -0700 (MST)
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id oB2L6UXX011315 for
 <ceph-devel@vger.kernel.org>; Thu, 2 Dec 2010 14:06:30 -0700
In-Reply-To: <1291318895-11879-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi,

On Thu, 2010-12-02 at 12:41 -0700, Jim Schutt wrote:
> If poll() says a socket is ready for reading, but zero bytes
> are read, that means that the peer has sent a FIN.  Handle that.
> 
> One way the incorrect handling was manifesting is as follows:
> 
> Under a heavy write load, clients log many messages like this:
> 
> [19021.523192] libceph:  tid 876 timed out on osd6, will reset osd
> [19021.523328] libceph:  tid 866 timed out on osd10, will reset osd
> [19081.616032] libceph:  tid 841 timed out on osd0, will reset osd
> [19081.616121] libceph:  tid 826 timed out on osd2, will reset osd
> [19081.616176] libceph:  tid 806 timed out on osd3, will reset osd
> [19081.616226] libceph:  tid 875 timed out on osd9, will reset osd
> [19081.616275] libceph:  tid 834 timed out on osd12, will reset osd
> [19081.616326] libceph:  tid 874 timed out on osd10, will reset osd
> 
> After the clients are done writing and the file system should
> be quiet, osd hosts have a high load with many active threads:
> 
> $ ps u -C cosd
> USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> root      1383  162 11.5 1456248 943224 ?      Ssl  11:31 406:59 /usr/bin/cosd -i 7 -c /etc/ceph/ceph.conf
> 
> $ for p in `ps -C cosd -o pid --no-headers`; do grep -nH State /proc/$p/task/*/status | grep -v sleep; done
> /proc/1383/task/10702/status:2:State:   R (running)
> /proc/1383/task/10710/status:2:State:   R (running)
> /proc/1383/task/10717/status:2:State:   R (running)
> /proc/1383/task/11396/status:2:State:   R (running)
> /proc/1383/task/27111/status:2:State:   R (running)
> /proc/1383/task/27117/status:2:State:   R (running)
> /proc/1383/task/27162/status:2:State:   R (running)
> /proc/1383/task/27694/status:2:State:   R (running)
> /proc/1383/task/27704/status:2:State:   R (running)
> /proc/1383/task/27728/status:2:State:   R (running)
> 
> With this fix applied, a heavy load still causes many client
> resets of osds, but no runaway threads result.

Hmmm, no runaway threads, but harder testing with
  dd conv=fdatasync 
has at least one of my clients stuck -- not sure
if this patch caused the issue or exposed something
else:

[  982.608021] libceph:  tid 183 timed out on osd10, will reset osd
[  982.608119] libceph:  tid 114 timed out on osd12, will reset osd
[  982.608179] libceph:  tid 179 timed out on osd11, will reset osd
[  982.608237] libceph:  tid 162 timed out on osd1, will reset osd
[  982.608300] libceph:  tid 169 timed out on osd0, will reset osd
[  982.608357] libceph:  tid 204 timed out on osd4, will reset osd
[  982.608414] libceph:  tid 159 timed out on osd9, will reset osd
[ 1042.704025] libceph:  tid 114 timed out on osd12, will reset osd
[ 1042.704072] libceph:  tid 174 timed out on osd1, will reset osd
[ 1080.602058] INFO: task dd:3545 blocked for more than 120 seconds.
[ 1080.602063] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1080.602067] dd            D ffff88018e161610     0  3545   3542 0x00000000
[ 1080.602074]  ffff88018f647d18 0000000000000086 ffff88018f647e20 ffff88018e161610
[ 1080.602082]  ffff880199105840 000000008f647d78 0000000017c00000 ffff88018e090fa0
[ 1080.602088]  0000000000000000 0000000000018000 ffff88018f647c78 ffffffff81063032
[ 1080.602095] Call Trace:
[ 1080.602112]  [<ffffffff81063032>] ? timekeeping_get_ns+0x1b/0x3d
[ 1080.602117]  [<ffffffff810639cf>] ? ktime_get_ts+0x89/0x92
[ 1080.602121]  [<ffffffff81063032>] ? timekeeping_get_ns+0x1b/0x3d
[ 1080.602125]  [<ffffffff810639cf>] ? ktime_get_ts+0x89/0x92
[ 1080.602131]  [<ffffffff8136a76e>] io_schedule+0x3f/0x59
[ 1080.602136]  [<ffffffff810aaf1e>] sync_page+0x49/0x4d
[ 1080.602139]  [<ffffffff8136ac87>] __wait_on_bit+0x4a/0x7b
[ 1080.602143]  [<ffffffff810aaed5>] ? sync_page+0x0/0x4d
[ 1080.602147]  [<ffffffff810ab0cf>] wait_on_page_bit+0x74/0x7b
[ 1080.602152]  [<ffffffff8105b6c4>] ? wake_bit_function+0x0/0x2f
[ 1080.602156]  [<ffffffff810b3f18>] ? pagevec_lookup_tag+0x27/0x30
[ 1080.602161]  [<ffffffff810ab5d4>] filemap_fdatawait_range+0x79/0x15d
[ 1080.602165]  [<ffffffff810ab786>] filemap_write_and_wait_range+0x43/0x56
[ 1080.602171]  [<ffffffff8110b444>] vfs_fsync_range+0x35/0x7c
[ 1080.602174]  [<ffffffff8110b4f0>] vfs_fsync+0x1c/0x1e
[ 1080.602178]  [<ffffffff8110b525>] do_fsync+0x33/0x49
[ 1080.602181]  [<ffffffff8110b54e>] sys_fdatasync+0x13/0x17
[ 1080.602187]  [<ffffffff81002c2b>] system_call_fastpath+0x16/0x1b
[ 1102.800022] libceph:  tid 114 timed out on osd12, will reset osd
[ 1162.896023] libceph:  tid 114 timed out on osd12, will reset osd
[ 1200.602047] INFO: task dd:3545 blocked for more than 120 seconds.
[ 1200.602051] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1200.602055] dd            D ffff88018e161610     0  3545   3542 0x00000000
[ 1200.602062]  ffff88018f647d18 0000000000000086 ffff88018f647e20 ffff88018e161610
[ 1200.602068]  ffff880199105840 000000008f647d78 0000000017c00000 ffff88018e090fa0
[ 1200.602075]  0000000000000000 0000000000018000 ffff88018f647c78 ffffffff81063032
[ 1200.602081] Call Trace:
[ 1200.602089]  [<ffffffff81063032>] ? timekeeping_get_ns+0x1b/0x3d
[ 1200.602095]  [<ffffffff810639cf>] ? ktime_get_ts+0x89/0x92
[ 1200.602100]  [<ffffffff81063032>] ? timekeeping_get_ns+0x1b/0x3d
[ 1200.602105]  [<ffffffff810639cf>] ? ktime_get_ts+0x89/0x92
[ 1200.602114]  [<ffffffff8136a76e>] io_schedule+0x3f/0x59
[ 1200.602118]  [<ffffffff810aaf1e>] sync_page+0x49/0x4d
[ 1200.602122]  [<ffffffff8136ac87>] __wait_on_bit+0x4a/0x7b
[ 1200.602125]  [<ffffffff810aaed5>] ? sync_page+0x0/0x4d
[ 1200.602129]  [<ffffffff810ab0cf>] wait_on_page_bit+0x74/0x7b
[ 1200.602133]  [<ffffffff8105b6c4>] ? wake_bit_function+0x0/0x2f
[ 1200.602137]  [<ffffffff810b3f18>] ? pagevec_lookup_tag+0x27/0x30
[ 1200.602141]  [<ffffffff810ab5d4>] filemap_fdatawait_range+0x79/0x15d
[ 1200.602146]  [<ffffffff810ab786>] filemap_write_and_wait_range+0x43/0x56
[ 1200.602150]  [<ffffffff8110b444>] vfs_fsync_range+0x35/0x7c
[ 1200.602154]  [<ffffffff8110b4f0>] vfs_fsync+0x1c/0x1e
[ 1200.602157]  [<ffffffff8110b525>] do_fsync+0x33/0x49
[ 1200.602161]  [<ffffffff8110b54e>] sys_fdatasync+0x13/0x17
[ 1200.602165]  [<ffffffff81002c2b>] system_call_fastpath+0x16/0x1b
[ 1222.992057] libceph:  tid 114 timed out on osd12, will reset osd

.
.
.
[ 1944.144070] libceph:  tid 114 timed out on osd12, will reset osd
[ 2004.240027] libceph:  tid 114 timed out on osd12, will reset osd
[ 2040.602059] INFO: task dd:3545 blocked for more than 120 seconds.
[ 2040.602063] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2040.602067] dd            D ffff88018e161610     0  3545   3542 0x00000000
[ 2040.602073]  ffff88018f647d18 0000000000000086 ffff88018f647e20 ffff88018e161610
[ 2040.602080]  ffff880199105840 000000008f647d78 0000000017c00000 ffff88018e090fa0
[ 2040.602086]  0000000000000000 0000000000018000 ffff88018f647c78 ffffffff81063032
[ 2040.602093] Call Trace:
[ 2040.602101]  [<ffffffff81063032>] ? timekeeping_get_ns+0x1b/0x3d
[ 2040.602107]  [<ffffffff810639cf>] ? ktime_get_ts+0x89/0x92
[ 2040.602112]  [<ffffffff81063032>] ? timekeeping_get_ns+0x1b/0x3d
[ 2040.602121]  [<ffffffff810639cf>] ? ktime_get_ts+0x89/0x92
[ 2040.602126]  [<ffffffff8136a76e>] io_schedule+0x3f/0x59
[ 2040.602130]  [<ffffffff810aaf1e>] sync_page+0x49/0x4d
[ 2040.602133]  [<ffffffff8136ac87>] __wait_on_bit+0x4a/0x7b
[ 2040.602137]  [<ffffffff810aaed5>] ? sync_page+0x0/0x4d
[ 2040.602141]  [<ffffffff810ab0cf>] wait_on_page_bit+0x74/0x7b
[ 2040.602145]  [<ffffffff8105b6c4>] ? wake_bit_function+0x0/0x2f
[ 2040.602149]  [<ffffffff810b3f18>] ? pagevec_lookup_tag+0x27/0x30
[ 2040.602153]  [<ffffffff810ab5d4>] filemap_fdatawait_range+0x79/0x15d
[ 2040.602158]  [<ffffffff810ab786>] filemap_write_and_wait_range+0x43/0x56
[ 2040.602162]  [<ffffffff8110b444>] vfs_fsync_range+0x35/0x7c
[ 2040.602165]  [<ffffffff8110b4f0>] vfs_fsync+0x1c/0x1e
[ 2040.602169]  [<ffffffff8110b525>] do_fsync+0x33/0x49
[ 2040.602172]  [<ffffffff8110b54e>] sys_fdatasync+0x13/0x17
[ 2040.602176]  [<ffffffff81002c2b>] system_call_fastpath+0x16/0x1b
[ 2064.336040] libceph:  tid 114 timed out on osd12, will reset osd
[ 2124.432076] libceph:  tid 114 timed out on osd12, will reset osd
[ 2160.602051] INFO: task dd:3545 blocked for more than 120 seconds.
[ 2160.602055] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2160.602058] dd            D ffff88018e161610     0  3545   3542 0x00000000
[ 2160.602065]  ffff88018f647d18 0000000000000086 ffff88018f647e20 ffff88018e161610
[ 2160.602072]  ffff880199105840 000000008f647d78 0000000017c00000 ffff88018e090fa0
[ 2160.602078]  0000000000000000 0000000000018000 ffff88018f647c78 ffffffff81063032
[ 2160.602085] Call Trace:
[ 2160.602093]  [<ffffffff81063032>] ? timekeeping_get_ns+0x1b/0x3d
[ 2160.602099]  [<ffffffff810639cf>] ? ktime_get_ts+0x89/0x92
[ 2160.602104]  [<ffffffff81063032>] ? timekeeping_get_ns+0x1b/0x3d
[ 2160.602113]  [<ffffffff810639cf>] ? ktime_get_ts+0x89/0x92
[ 2160.602118]  [<ffffffff8136a76e>] io_schedule+0x3f/0x59
[ 2160.602122]  [<ffffffff810aaf1e>] sync_page+0x49/0x4d
[ 2160.602125]  [<ffffffff8136ac87>] __wait_on_bit+0x4a/0x7b
[ 2160.602129]  [<ffffffff810aaed5>] ? sync_page+0x0/0x4d
[ 2160.602133]  [<ffffffff810ab0cf>] wait_on_page_bit+0x74/0x7b
[ 2160.602137]  [<ffffffff8105b6c4>] ? wake_bit_function+0x0/0x2f
[ 2160.602141]  [<ffffffff810b3f18>] ? pagevec_lookup_tag+0x27/0x30
[ 2160.602145]  [<ffffffff810ab5d4>] filemap_fdatawait_range+0x79/0x15d
[ 2160.602150]  [<ffffffff810ab786>] filemap_write_and_wait_range+0x43/0x56
[ 2160.602155]  [<ffffffff8110b444>] vfs_fsync_range+0x35/0x7c
[ 2160.602158]  [<ffffffff8110b4f0>] vfs_fsync+0x1c/0x1e
[ 2160.602162]  [<ffffffff8110b525>] do_fsync+0x33/0x49
[ 2160.602165]  [<ffffffff8110b54e>] sys_fdatasync+0x13/0x17
[ 2160.602169]  [<ffffffff81002c2b>] system_call_fastpath+0x16/0x1b
[ 2184.528026] libceph:  tid 114 timed out on osd12, will reset osd
[ 2244.624049] libceph:  tid 114 timed out on osd12, will reset osd
[ 2304.720022] libceph:  tid 114 timed out on osd12, will reset osd
[ 2364.816021] libceph:  tid 114 timed out on osd12, will reset osd
[ 2424.912086] libceph:  tid 114 timed out on osd12, will reset osd
[ 2485.008021] libceph:  tid 114 timed out on osd12, will reset osd
[ 2545.104028] libceph:  tid 114 timed out on osd12, will reset osd
[ 2605.200026] libceph:  tid 114 timed out on osd12, will reset osd
[ 2665.296025] libceph:  tid 114 timed out on osd12, will reset osd
[ 2725.392028] libceph:  tid 114 timed out on osd12, will reset osd
[ 2785.488076] libceph:  tid 114 timed out on osd12, will reset osd
[ 2845.584033] libceph:  tid 114 timed out on osd12, will reset osd
[ 2905.680025] libceph:  tid 114 timed out on osd12, will reset osd
[ 2965.776024] libceph:  tid 114 timed out on osd12, will reset osd
[ 3025.872033] libceph:  tid 114 timed out on osd12, will reset osd
[ 3085.968032] libceph:  tid 114 timed out on osd12, will reset osd

I'm still trying to figure out why this guy gets
stuck.

-- Jim


> 
> Signed-off-by: Jim Schutt <jaschut@sandia.gov>
> ---
>  src/msg/SimpleMessenger.cc |    2 +-
>  src/msg/tcp.cc             |   52 +++++++++++++++++++++++++++-----------------
>  src/msg/tcp.h              |    2 +-
>  3 files changed, 34 insertions(+), 22 deletions(-)
> 
> diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
> index 97ed4c3..0c9a0bd 100644
> --- a/src/msg/SimpleMessenger.cc
> +++ b/src/msg/SimpleMessenger.cc
> @@ -1875,7 +1875,7 @@ int SimpleMessenger::Pipe::read_message(Message **pm)
>  	
>      while (left > 0) {
>        // wait for data
> -      if (tcp_wait(sd, messenger->timeout) < 0)
> +      if (tcp_read_wait(sd, messenger->timeout) < 0)
>  	goto out_dethrottle;
>  
>        // get a buffer
> diff --git a/src/msg/tcp.cc b/src/msg/tcp.cc
> index c1be756..71d85f1 100644
> --- a/src/msg/tcp.cc
> +++ b/src/msg/tcp.cc
> @@ -13,9 +13,6 @@ int tcp_read(int sd, char *buf, int len, int timeout)
>    if (sd < 0)
>      return -1;
>  
> -  struct pollfd pfd;
> -  pfd.fd = sd;
> -  pfd.events = POLLIN | POLLHUP | POLLRDHUP | POLLNVAL | POLLERR;
>    while (len > 0) {
>  
>      if (g_conf.ms_inject_socket_failures && sd >= 0) {
> @@ -25,24 +22,14 @@ int tcp_read(int sd, char *buf, int len, int timeout)
>        }
>      }
>  
> -    if (poll(&pfd, 1, timeout) <= 0)
> +    if (tcp_read_wait(sd, timeout) < 0)
>        return -1;
>  
> -    if (!(pfd.revents & POLLIN))
> -      return -1;
> +    int got = tcp_read_nonblocking(sd, buf, len);
>  
> -    /*
> -     * although we turn on the MSG_DONTWAIT flag, we don't expect
> -     * receivng an EAGAIN, as we polled on the socket, so there
> -     * should be data waiting for us.
> -     */
> -    int got = ::recv( sd, buf, len, MSG_DONTWAIT );
> -    if (got <= 0) {
> -      //char buf[100];
> -      //generic_dout(0) << "tcp_read socket " << sd << " returned " << got
> -      //<< " errno " << errno << " " << strerror_r(errno, buf, sizeof(buf)) << dendl;
> +    if (got < 0)
>        return -1;
> -    }
> +
>      len -= got;
>      buf += got;
>      //generic_dout(DBL) << "tcp_read got " << got << ", " << len << " left" << dendl;
> @@ -50,26 +37,51 @@ int tcp_read(int sd, char *buf, int len, int timeout)
>    return len;
>  }
>  
> -int tcp_wait(int sd, int timeout) 
> +int tcp_read_wait(int sd, int timeout) 
>  {
>    if (sd < 0)
>      return -1;
>    struct pollfd pfd;
>    pfd.fd = sd;
> -  pfd.events = POLLIN | POLLHUP | POLLRDHUP | POLLNVAL | POLLERR;
> +  pfd.events = POLLIN | POLLRDHUP;
>  
>    if (poll(&pfd, 1, timeout) <= 0)
>      return -1;
>  
> +  if (pfd.revents & (POLLERR | POLLHUP | POLLRDHUP | POLLNVAL))
> +    return -1;
> +
>    if (!(pfd.revents & POLLIN))
>      return -1;
>  
>    return 0;
>  }
>  
> +/* This function can only be called if poll/select says there is
> + * data available.  Otherwise we cannot properly interpret a
> + * read of 0 bytes.
> + */
>  int tcp_read_nonblocking(int sd, char *buf, int len)
>  {
> -  return ::recv(sd, buf, len, MSG_DONTWAIT);
> +again:
> +  int got = ::recv( sd, buf, len, MSG_DONTWAIT );
> +  if (got < 0) {
> +    if (errno == EAGAIN || errno == EINTR) {
> +      goto again;
> +    } else {
> +      char buf[100];
> +      generic_dout(10) << "tcp_read_nonblocking socket " << sd << " returned "
> +        << got << " errno " << errno << " " << strerror_r(errno, buf, sizeof(buf)) << dendl;
> +      return -1;
> +    }
> +  } else if (got == 0) {
> +    /* poll() said there was data, but we didn't read any - peer
> +     * sent a FIN.  Maybe POLLRDHUP signals this, but this is
> +     * standard socket behavior as documented by Stevens.
> +     */
> +    return -1;
> +  }
> +  return got;
>  }
>  
>  int tcp_write(int sd, const char *buf, int len)
> diff --git a/src/msg/tcp.h b/src/msg/tcp.h
> index 31ae967..bccdbda 100644
> --- a/src/msg/tcp.h
> +++ b/src/msg/tcp.h
> @@ -26,7 +26,7 @@ inline ostream& operator<<(ostream& out, const sockaddr_storage &ss)
>  }
>  
>  extern int tcp_read(int sd, char *buf, int len, int timeout=-1);
> -extern int tcp_wait(int sd, int timeout);
> +extern int tcp_read_wait(int sd, int timeout);
>  extern int tcp_read_nonblocking(int sd, char *buf, int len);
>  extern int tcp_write(int sd, const char *buf, int len);
>  


