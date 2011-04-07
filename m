From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: how to increase small file writes performance in ceph
Date: Thu, 07 Apr 2011 12:56:49 -0700
Message-ID: <4D9E1701.7090902@dreamhost.com>
References: <BANLkTinj4RYa0gQ5Nyshv2_oKEei-kaU+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:32808 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756883Ab1DGT4u convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 15:56:50 -0400
In-Reply-To: <BANLkTinj4RYa0gQ5Nyshv2_oKEei-kaU+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 04/07/2011 06:55 AM, huang jun wrote:
> hi=A3=ACdevelopers
>       Recently=A3=ACi test ceph's performance of writing small files,=
but the result
> seems not so good.
>=20
> i have 4 OSDs (on two hosts,each have two cosd process), and 4 client=
s,
> 3 of them execute the zq.sh script,and 1 writes small files :
>   for i in {1..30000}; do
>           dd if=3D/dev/zero of=3D$i.txt bs=3D10M count=3D1
>       done
> and write speed is  about 7MB/s~12MB/s

I'd expect better performance, but this depends on your cluster setup.
We have some guidelines for improving performance on the wiki:

http://ceph.newdream.net/wiki/Troubleshooting#Performance

Another thing that may be causing problems when writing many small file=
s
is the MDS cache, if it's too small. You can set the size of this in th=
e
mds section of your ceph.conf:

    mds cache size =3D 300000

> my ceph version 0.24.3
> linux kernel version 2.6.35
> i want to know that does the cluster size matters our write speed?
> does our filesystem good at small files writing?
>=20
> thanks!

Ideally, write speed is limited by client bandwidth, but there are ofte=
n
bottlenecks in other areas. For example, you could have too few OSDs to
handle the amount of data you're writing. Writing lots of small files
will involve more metadata operations, which should be handled well wit=
h
enough MDSs. There's ongoing work to make this more efficient for
directories with large numbers of files, but it's not quite ready to be
used yet.

-Josh Durgin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
