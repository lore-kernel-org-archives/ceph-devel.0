From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] msgr: Correctly handle half-open connections.
Date: Thu, 2 Dec 2010 12:02:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012021157010.1982@cobra.newdream.net>
References: <1291318895-11879-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37089 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757709Ab0LBT55 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Dec 2010 14:57:57 -0500
In-Reply-To: <1291318895-11879-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

Hi Jim,

On Thu, 2 Dec 2010, Jim Schutt wrote:
> If poll() says a socket is ready for reading, but zero bytes
> are read, that means that the peer has sent a FIN.  Handle that.

Hmm.  I think I saw a version of this a week or two ago.  Basically 
tcp_wait() returned, and then I read 0 bytes.  I "fixed" it with commit
71369541ab4ac1752fca3a6134ea51f5cc0bea9f.  

It seems like, if that happens, we would loop back to poll(), and then get 
a HUP, and then exit?  I guess I'm not seeing where the busy loop comes 
in (I'm no socket expert)...

Also, this worries me (see below)


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

I'm not familiar with all of those flags, but we want to make sure we 
error out when anything bad happens, and POLLERR | PULLHUP | POLLNVAL 
certainly seem like they're in that category.  And a few lines down 

>  
>    if (poll(&pfd, 1, timeout) <= 0)
>      return -1;
>  
> +  if (pfd.revents & (POLLERR | POLLHUP | POLLRDHUP | POLLNVAL))
> +    return -1;
> +

And will pfd.revents ever have POLLHUP or POLLNVAL if we didn't ask for 
them above?

Thanks!
sage


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
> -- 
> 1.6.6
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
