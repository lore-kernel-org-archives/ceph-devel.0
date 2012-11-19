From: Gregory Farnum <greg@inktank.com>
Subject: Re: some snapshot problems
Date: Mon, 19 Nov 2012 14:59:19 -0800
Message-ID: <CAPYLRzg9-mh8cfXdPRx73JPsCVW07QmY1drYwm3W0Gz7qY2vsw@mail.gmail.com>
References: <CABFZihudrA640nD9N60b8w0ccQvmaduGmceBf2uHrpLbShtjig@mail.gmail.com>
	<alpine.DEB.2.00.1211050139280.14104@cobra.newdream.net>
	<CABFZihvH6Cs0YD_Rbn1goUz5q1P0EUEvnN0poq1YKvw4Lm-wAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:58490 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab2KSW7U convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 17:59:20 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so3783531iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 14:59:19 -0800 (PST)
In-Reply-To: <CABFZihvH6Cs0YD_Rbn1goUz5q1P0EUEvnN0poq1YKvw4Lm-wAw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liu yaqi <liuyaqiyaqi@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Nov 11, 2012 at 11:02 PM, liu yaqi <liuyaqiyaqi@gmail.com> wrot=
e:
> 2012/11/9 Sage Weil <sage@inktank.com>
>
>> Lots of different snapshots:
>>
>>  - librados lets you do 'selfmanaged snaps' in its API, which let an
>>    application control which snapshots apply to which objects.
>>  - you can create a 'pool' snapshot on an entire librados pool.  thi=
s
>>    cannot be used at the same time as rbd, fs, or the above 'selfman=
aged'
>>    snaps.
>>  - rbd let's you snapshot block device images (by usuing the librado=
s
>>    selfmanaged snap API).
>>  - the ceph file system let's you snapshot any subdirectory (again
>>    utilizing the underlying RADOS functionality).
>
> I am confused about the concept of "pool" and "image". Is one pool a
> set of placement groups? When I snap an image, does it mean a snapsho=
t
> of one disk?

A pool is a logical namespace into which you place objects. Placement
groups are shards of a pool.
Snapping an image makes use of the self-managed snapshot
infrastructure, and takes a snapshot of one RBD volume (so yes, if
that's what you meant by a snapshot of one disk).

> I think snapshot is used to preserve the state of directory at one
> time, and I wander if there will be a situation that I preserve the
> data of the directory, but does not preserve the metadata of the
> directory=97=97maybe because metadata and data not in the same pool, =
would
> this happen?

The Ceph filesystem builds a bit more on top of the RADOS snapshots =97
metadata and data are almost never in the same pool, and the metadata
snapshots don't use RADOS snapshots anyway.

> When snap directory, I trace the code in mds, there is snapinfo added
> to inode, but where and when to create the content of the snap? What
> is the data sturcture of the snap content? When client set inode
> attribute, if snapid=3D=3DNOSNAP, return, does this mean if the inode=
 has
> been snapped, it can not be changed? So, snap not using the
> copy-on-write method(create snap, then change the content of snapfile
> when set inode attribute or write the file)? If not copy-on-write,
> what's the snap workflow for directory?

You want to look into the code surrounding SnapRealms to see how the
metadata for snapshots is managed.

> There are multi metadata nodes, one directory may  spread over multi
> servers, one server has one part of the dir, how ceph resolves this
> problem? This also cause clock problem.

It's not easy, but again, look at how the SnapRealms are dealt with.
The MDSes will do synchronous notifications to each other.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
