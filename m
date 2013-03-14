From: Sage Weil <sage@inktank.com>
Subject: Re: Direct IO on CephFS for blocks larger than 8MB
Date: Thu, 14 Mar 2013 08:20:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303140819420.11175@cobra.newdream.net>
References: <5A908216FB901F499F602F4F9CEF5B380FEA68C3@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1028020719-1363274441=:11175"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50888 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757837Ab3CNPUm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 11:20:42 -0400
In-Reply-To: <5A908216FB901F499F602F4F9CEF5B380FEA68C3@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Huang, Xiwei" <xiwei.huang@intel.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1028020719-1363274441=:11175
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Mar 2013, Huang, Xiwei wrote:
> Hi, all,=20
> =C2=A0=C2=A0  I noticed that CephFS fails to support Direct IO for bloc=
ks larger than 8MB, say:
> 			sudo dd if=3D/dev/zero of=3Dmnt/cephfs/foo bs=3D16M count=3D1 oflag=3D=
direct
> 			dd: writing `mnt/cephfs/foo: Bad address
> 			1+0 records in
> 			0+0 records out
> 			0 bytes (0 B) copied, 0.213948 s, 0.0 kB/s
> =C2=A0=C2=A0=C2=A0My version Ceph is 0.56.1.=20
> ??I also found the bug has been already reported as Bug #2657.
> =C2=A0=C2=A0=C2=A0Is this fixed in the new 0.58 version?=20

I'm pretty sure this is a problem on the kernel client side of things, no=
t=20
the server side (which by default handles writes up to ~100MB or so).  I=20
suspect it isn't terribly difficult to fix, but hasn't been prioritized..=
.

sage
--557981400-1028020719-1363274441=:11175--
