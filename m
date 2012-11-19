From: liu yaqi <liuyaqiyaqi@gmail.com>
Subject: some snapshot problems
Date: Mon, 19 Nov 2012 09:13:27 +0800
Message-ID: <CABFZihu6ejRzLfDa_hqw=5iNG4c1dQjtgxu9cgU+J93DANjghw@mail.gmail.com>
References: <CABFZihudrA640nD9N60b8w0ccQvmaduGmceBf2uHrpLbShtjig@mail.gmail.com>
	<alpine.DEB.2.00.1211050139280.14104@cobra.newdream.net>
	<CABFZihtEgUMPeBROQVCjMFHaw0-u7k7dfk=O+32EUcV-BaJpLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:37523 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab2KSBN2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Nov 2012 20:13:28 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so2903381qat.19
        for <ceph-devel@vger.kernel.org>; Sun, 18 Nov 2012 17:13:27 -0800 (PST)
In-Reply-To: <CABFZihtEgUMPeBROQVCjMFHaw0-u7k7dfk=O+32EUcV-BaJpLA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

---------- Forwarded message ----------
=46rom: liu yaqi <liuyaqiyaqi@gmail.com>
Date: 2012/11/12
Subject: Re: some snapshot problems
To: Sage Weil <sage@inktank.com>
=B3=AD=CB=CD=A3=BA ceph-devel@vger.kernel.org, ctpm@ist.utl.pt, josh.du=
rgin@inktank.com




2012/11/9 Sage Weil <sage@inktank.com>
>
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
directory=A1=AA=A1=AAmaybe because metadata and data not in the same po=
ol, would
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
