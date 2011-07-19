From: Sage Weil <sage@newdream.net>
Subject: Re: looks like a bug
Date: Tue, 19 Jul 2011 07:31:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107190729150.5656@cobra.newdream.net>
References: <4E254135.70603@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42093 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab1GSO2X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2011 10:28:23 -0400
In-Reply-To: <4E254135.70603@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Hi Fyodor,

Which commits are you running on the server and client side?  There was a 
bad protocol version number in master branch for several days (fixed now), 
and some open intent stuff in ceph-client.git that wasn't quite right a 
bit further back.

thanks-
sage

On Tue, 19 Jul 2011, Fyodor Ustinov wrote:

> Hi!
> 
> root@stb1:~/src# cat a.c
> #include <stdio.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <string.h>
> #include <errno.h>
> 
> 
> int main(void) {
> int fd, rc;
> char *s;
> struct stat buf;
> 
> fd = open("/mnt/aaa",O_RDWR|O_CREAT|O_APPEND,0666);
> if (fd == -1) {
> printf("Unable to open test file!\n");
> exit(0);
> }
> rc = fstat(fd,&buf);
> if (rc != 0) {
> s = strerror(errno);
> printf("stat rc == %d\nError == '%s'\n",rc,s);
> exit(0);
> }
> rc = write(fd, "kuku", 4);
> if (rc == -1) {
> s = strerror(errno);
> printf("write rc == %d\nError == '%s'\n",rc,s);
> }
> 
> }
> 
> root@stb1:~/src# gcc a.c
> a.c: In function ?main?:
> a.c:16:7: warning: incompatible implicit declaration of built-in function
> ?exit?
> a.c:22:7: warning: incompatible implicit declaration of built-in function
> ?exit?
> root@stb1:~/src# mount -t ceph 10.5.51.230:/ /mnt
> root@stb1:~/src# ./a.out
> write rc == -1
> Error == 'Bad file descriptor'
> root@stb1:~/src#
> root@stb1:~/src# uname -a
> Linux stb1 3.0.0-rc6-ufm #1 SMP Sun Jul 10 14:12:13 EEST 2011 x86_64 x86_64
> x86_64 GNU/Linux
> root@stb1:~/src#
> 
> =========
> 
> P.S. In cfuse a.out just hang.
> 
> WBR,
> Fyodor.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
