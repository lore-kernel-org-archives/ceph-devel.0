From: Sage Weil <sage@newdream.net>
Subject: Re: ping_pong test of ceph
Date: Wed, 28 Sep 2011 08:48:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109280845130.13650@cobra.newdream.net>
References: <CAMwsgzPBzcwnJTkhDPAanQemwUirHe-yTHVHE4hMpjc4sgVkKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1098993713-1317224898=:13650"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43454 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830Ab1I1PsT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 11:48:19 -0400
In-Reply-To: <CAMwsgzPBzcwnJTkhDPAanQemwUirHe-yTHVHE4hMpjc4sgVkKw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mowang da <whooya.xxl@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1098993713-1317224898=:13650
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Sep 2011, mowang da wrote:
> hi all:
>=20
> l used ping_pong tool to test ceph, as shown below :
> 1.If it supports coherent byte range locks between cluster nodes
> 2.How fast it handles lock contention
> 3.If it supports coherent read/write IO between nodes
> 4.How fast it handles contended IO between nodes
> 5.If it supports coherent mmap between nodes
> 6.How fast the mmap coherence works
>=20
> the ping_pong code is here:
> http://junkcode.samba.org/ftp/unpacked/junkcode/ping_pong.c
>=20
> l start by running ping_pong on just one of the kernel client mount
> point like this:
>=20
> ping_pong /mnt/test.dat 3
>=20
> it lock very fast :
>=20
> T02-OSD161:/usr/src/ping_pong# ./ping_pong /mnt/test.dat 3
> =A0 =A01664 locks/sec
>=20
> but when l start a second copy of ping_pong on another kernel client
> node in my cluster, there have been some errors:
>=20
> T02-OSD186:/usr/src/getosd# ./ping_pong /mnt/test.dat 3
> lock at 0 failed! - Interrupted system call
> lock at 0 failed! - Interrupted system call
> lock at 0 failed! - Interrupted system call
> lock at 2 failed! - Interrupted system call
> lock at 1 failed! - Interrupted system call
> lock at 2 failed! - Interrupted system call
>=20
> ls this a bug of ceph ,or l do something wrong?

It's a bug.  We've seen isolated reports, but didn't have an easy way to=20
reproduce it.  This tool looks like exactly what we need!

Added info to http://tracker.newdream.net/issues/1150

Thanks-
sage
--557981400-1098993713-1317224898=:13650--
