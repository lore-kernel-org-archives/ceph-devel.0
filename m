From: mowang da <whooya.xxl@gmail.com>
Subject: O_RDWR bug
Date: Fri, 24 Jun 2011 10:45:09 +0800
Message-ID: <BANLkTi=cFLrrAUhSjVduvt48HD2CO-MA_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44453 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab1FXCpL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jun 2011 22:45:11 -0400
Received: by pwj7 with SMTP id 7so1566842pwj.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Jun 2011 19:45:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am currently testing Ceph , l write some code like this:

             size_t fd =3D open("/mnt/aaa", O_CREAT | O_RDWR | O_APPEND=
 , 0755);

then l can not write buffer to the fd, 1 think there is something wrong=
 in :

int ceph_flags_to_mode(int flags)

{

          ...

         if ((flags & O_ACCMODE) =3D=3D O_RDWR)
		mode =3D CEPH_FILE_MODE_RDWR;
	 else if ((flags & O_ACCMODE) =3D=3D O_WRONLY) //?
		mode =3D CEPH_FILE_MODE_WR;
	 else
		mode =3D CEPH_FILE_MODE_RD;

          ...

}

if change the "(flags & O_ACCMODE) =3D=3D O_WRONLY" to "(flags &
O_ACCMODE) =3D=3D O_ACCMODE", l can write success!

another problem, I am trying to use a Ceph cfuse client to mount Ceph
DFS(/mnt/) and

set up a samba server to share the mount point(/mnt),l find it not so
fast as expected=A3=AC l  analyse the log :

                   2011-06-24 09:25:43.677606 7f11cdecd700 --
192.168.1.110:0/7088 dispatch_queue.cond.Wait

                  2011-06-24 09:25:43.738812 7f11d130a720 client
method:getxattr path:security.capability

the SimpleMessenger thread  replyed the osd ,it wait ,the problem is
the next FUSE operation is very slowly,

why the fuse thread  and SimpleMessenger thread can not work in paralle=
l

anybody have the same problem with me?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
