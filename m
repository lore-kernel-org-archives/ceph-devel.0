From: liu yaqi <liuyaqiyaqi@gmail.com>
Subject: Re: some snapshot problems
Date: Mon, 12 Nov 2012 15:02:11 +0800
Message-ID: <CABFZihvH6Cs0YD_Rbn1goUz5q1P0EUEvnN0poq1YKvw4Lm-wAw@mail.gmail.com>
References: <CABFZihudrA640nD9N60b8w0ccQvmaduGmceBf2uHrpLbShtjig@mail.gmail.com>
	<alpine.DEB.2.00.1211050139280.14104@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:37927 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab2KLHCM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 02:02:12 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so3596887qcr.19
        for <ceph-devel@vger.kernel.org>; Sun, 11 Nov 2012 23:02:11 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211050139280.14104@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

2012/11/9 Sage Weil <sage@inktank.com>

> Lots of different snapshots:
>
>  - librados lets you do 'selfmanaged snaps' in its API, which let an
>    application control which snapshots apply to which objects.
>  - you can create a 'pool' snapshot on an entire librados pool.  this
>    cannot be used at the same time as rbd, fs, or the above 'selfmana=
ged'
>    snaps.
>  - rbd let's you snapshot block device images (by usuing the librados
>    selfmanaged snap API).
>  - the ceph file system let's you snapshot any subdirectory (again
>    utilizing the underlying RADOS functionality).

I am confused about the concept of "pool" and "image". Is one pool a
set of placement groups? When I snap an image, does it mean a snapshot
of one disk?

I think snapshot is used to preserve the state of directory at one
time, and I wander if there will be a situation that I preserve the
data of the directory, but does not preserve the metadata of the
directory=97=97maybe because metadata and data not in the same pool, wo=
uld
this happen?

When snap directory, I trace the code in mds, there is snapinfo added
to inode, but where and when to create the content of the snap? What
is the data sturcture of the snap content? When client set inode
attribute, if snapid=3D=3DNOSNAP, return, does this mean if the inode h=
as
been snapped, it can not be changed? So, snap not using the
copy-on-write method(create snap, then change the content of snapfile
when set inode attribute or write the file)? If not copy-on-write,
what's the snap workflow for directory?

There are multi metadata nodes, one directory may  spread over multi
servers, one server has one part of the dir, how ceph resolves this
problem? This also cause clock problem.

Thanks
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
