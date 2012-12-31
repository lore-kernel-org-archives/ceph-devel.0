From: =?UTF-8?B?SmVucyBLcmlzdGlhbiBTw7hnYWFyZA==?=
	<jens@mermaidconsulting.dk>
Subject: Re: Improving responsiveness of KVM guests on Ceph storage
Date: Mon, 31 Dec 2012 11:58:19 +0100
Message-ID: <50E16FCB.7050604@mermaidconsulting.dk>
References: <50E0745D.8050306@mermaidconsulting.dk> <CABYiri9A4LxEgjrGHRVfn_WSLR9_ztHKN_+GJBh7KButwa68JA@mail.gmail.com> <50E0CA52.9020909@mermaidconsulting.dk> <CABYiri8OFSpNMuHuNAzTLwkzG3kqE9bt1f=Lz8TO0dDZ18ivTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.stofanet.dk ([212.10.10.14]:46725 "EHLO mx04.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab2LaK6V (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 31 Dec 2012 05:58:21 -0500
In-Reply-To: <CABYiri8OFSpNMuHuNAzTLwkzG3kqE9bt1f=Lz8TO0dDZ18ivTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Andrey,

> As I understood right, you have md device holding both journal and
> filestore? What type of raid you have here?

Yes, same md device holding both journal and filestore. It is a raid5.

> Of course you`ll need a
> separate device (for experimental purposes, fast disk may be enough)
> for the journal

Is there a way to tell if the journal is the bottleneck without actuall=
y=20
  adding such an extra device?

> filestore partition, you may also change it to simple RAID0, or even
> separate disks, and create one osd over every disk(you should see to

I have only 3 OSDs with 4 disks each. I was afraid that it would be too=
=20
brittle as a RAID0, and if I created seperate OSDs for each disk, it=20
would stall the file system due to recovery if a server crashes.

> What size of cache_size/max_dirty you have inside ceph.conf

I haven't set them explicitly, so I imagine the cache_size is 32 MB and=
=20
the max_dirty is 24 MB.

 > and which
> qemu version you use?

Using the default 0.15 version in Fedora 16.

> tasks increasing cache may help OS to align writes more smoothly. Als=
o
> you don`t need to set rbd_cache explicitly in the disk config using
> qemu 1.2 and younger releases, for older ones
> http://lists.gnu.org/archive/html/qemu-devel/2012-05/msg02500.html
> should be applied.

I read somewhere that I needed to enable it specifically for older=20
qemu-kvm versions, which I did like this:

   format=3Drbd,file=3Drbd:data/image1:rbd_cache=3D1,if=3Dvirtio

However now I read in the docs for qemu-rbd that it needs to be set lik=
e=20
this:

   format=3Draw,file=3Drbd:data/squeeze:rbd_cache=3Dtrue,cache=3Dwriteb=
ack

I'm not sure if 1 and true are interpreted the same way?

I'll try using "true" and see if I get any noticable changes in behavio=
ur.

The link you sent me seems to indicate that I need to compile my own=20
version of qemu-kvm to be able to test this?


--=20
Jens Kristian S=C3=B8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
