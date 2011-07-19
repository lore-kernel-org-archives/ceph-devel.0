From: Fyodor Ustinov <ufm@ufm.su>
Subject: looks like a bug
Date: Tue, 19 Jul 2011 11:32:53 +0300
Message-ID: <4E254135.70603@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:58662 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab1GSIdC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jul 2011 04:33:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 17C2860048A
	for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2011 11:32:59 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yo+MF7FduO33 for <ceph-devel@vger.kernel.org>;
	Tue, 19 Jul 2011 11:32:58 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 2091C600485
	for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2011 11:32:55 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

root@stb1:~/src# cat a.c
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>


int main(void) {
int fd, rc;
char *s;
struct stat buf;

fd =3D open("/mnt/aaa",O_RDWR|O_CREAT|O_APPEND,0666);
if (fd =3D=3D -1) {
printf("Unable to open test file!\n");
exit(0);
}
rc =3D fstat(fd,&buf);
if (rc !=3D 0) {
s =3D strerror(errno);
printf("stat rc =3D=3D %d\nError =3D=3D '%s'\n",rc,s);
exit(0);
}
rc =3D write(fd, "kuku", 4);
if (rc =3D=3D -1) {
s =3D strerror(errno);
printf("write rc =3D=3D %d\nError =3D=3D '%s'\n",rc,s);
}

}

root@stb1:~/src# gcc a.c
a.c: In function =91main=92:
a.c:16:7: warning: incompatible implicit declaration of built-in=20
function =91exit=92
a.c:22:7: warning: incompatible implicit declaration of built-in=20
function =91exit=92
root@stb1:~/src# mount -t ceph 10.5.51.230:/ /mnt
root@stb1:~/src# ./a.out
write rc =3D=3D -1
Error =3D=3D 'Bad file descriptor'
root@stb1:~/src#
root@stb1:~/src# uname -a
Linux stb1 3.0.0-rc6-ufm #1 SMP Sun Jul 10 14:12:13 EEST 2011 x86_64=20
x86_64 x86_64 GNU/Linux
root@stb1:~/src#

=3D=3D=3D=3D=3D=3D=3D=3D=3D

P.S. In cfuse a.out just hang.

WBR,
=46yodor.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
