From: Giorgos Kappes <geokapp@gmail.com>
Subject: Problem with SGID and new inode
Date: Thu, 22 Nov 2012 23:00:14 +0200
Message-ID: <CAHcbcZcM1r93ybgSEC4fiCvF8FSm=XVsRp7fLmp9FzdxDjTSHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55052 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932578Ab2KVVAQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 16:00:16 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2521370iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 13:00:15 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

=C7=E9,

I was looking at the source code of the ceph MDS and in particular at
the function
CInode* Server::prepare_new_inode(...) in the mds/Server.cc file which
creates a new inode.
At lines 1739-1747 the code checks if the parent directory has the
set-group-ID bit set. If
this bit is set and the new inode refers to a directory then the new
inode should also have
the set-group-ID bit set. However, as I understand, at line 1744 the
set-group-ID bit is set
at the local variable [mode |=3D S_ISGID] and not on the inode.
Shouldn't this line be
[in->inode.mode |=3D S_ISGID;]?

To illustrate the above problem I tried to create a new directory
inside a directory that has
the set-group-ID bit set:

root@client-admin:/mnt/admin# mkdir mydir
root@client-admin:/mnt/admin# chmod +s mydir
root@client-admin:/mnt/admin# ls -l
total 1
drwsr-sr-x 1 root root  0 Nov 22  2012 mydir
-rw-r--r-- 1 root root 13 Oct 19 08:05 myfile.txt
root@client-admin:/mnt/admin# cd mydir
root@client-admin:/mnt/admin/mydir# mkdir newdir
root@client-admin:/mnt/admin/mydir# ls -l
total 1
drwxr-xr-x 1 root root 0 Nov 22  2012 newdir

=46inally, I would like to note that I am using Ceph 0.48.2 but the
above problem also seems
to exist in the v0.54 development release.

Best regards,
Girogos Kappes

-----------------------------------------------------------
Giorgos Kappes
Website: http://www.cs.uoi.gr/~gkappes
email: geokapp@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
