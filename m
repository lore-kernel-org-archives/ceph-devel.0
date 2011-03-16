From: Sage Weil <sage@newdream.net>
Subject: Re: Configuration of OSD
Date: Wed, 16 Mar 2011 10:00:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103160958460.1176@cobra.newdream.net>
References: <AANLkTim5_ndO0VNeZneEb7PEsHBp=BPr7Bjrf3v2o=n+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1115027872-1300294837=:1176"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50332 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab1CPQ6L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2011 12:58:11 -0400
In-Reply-To: <AANLkTim5_ndO0VNeZneEb7PEsHBp=BPr7Bjrf3v2o=n+@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1115027872-1300294837=:1176
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 16 Mar 2011, Sylar Shen wrote:
> Hi,
> I have a question about OSD as follows.
> I have a server as OSD which contains 4*1T disks.
> Therefore I should set OSDes like this in ceph.conf......
> =A0=A0 [osd0]
> =A0=A0 =A0 =A0 =A0 =A0 host=3Dceph1
> =A0=A0 =A0 =A0 =A0 =A0 btrfs devs=3D/dev/sda1
> =A0=A0 [osd1]
> =A0=A0 =A0 =A0 =A0 =A0 host=3Dceph1
> =A0=A0 =A0 =A0 =A0 =A0 btrfs devs=3D/dev/sdb1
> =A0=A0 [osd2]
> =A0=A0 =A0 =A0 =A0 =A0 host=3Dceph1
> =A0=A0 =A0 =A0 =A0 =A0 btrfs devs=3D/dev/sdc1
> =A0=A0 [osd3]
> =A0=A0 =A0 =A0 =A0 =A0 host=3Dceph1
> =A0=A0 =A0 =A0 =A0 =A0 btrfs devs=3D/dev/sdd1
> My question is, if I have many servers(maybe larger than 200) and each
> server contains 12*1T disks.
> Should I set my ceph.conf like this pattern?

Right.

> I mean, if I have 200 servers, I will have to configure 200*12=3D240
> OSDes manually?
> That will be a hard work....:p

Well, you can write a simple perl or bash script to generate the conf for=
=20
you (or some fragment of it).

> Can I set like this instead and the system could do the rest for me?
> =A0=A0[osd0-osd3]
> =A0=A0 =A0 =A0 =A0 =A0 host=3Dceph1
> =A0=A0 =A0 =A0 =A0 =A0=A0btrfs devs=3D/dev/sda1
> =A0=A0 =A0 =A0 =A0 =A0=A0btrfs devs=3D/dev/sdb1
> =A0=A0 =A0 =A0 =A0 =A0=A0btrfs devs=3D/dev/sdc1
> =A0=A0 =A0 =A0 =A0 =A0=A0btrfs devs=3D/dev/sdd1
> I am not sure if this makes sense or not. I just happened to have this
> thought....:p

Yeah, that won't work.  :)

We don't have any plans to make the configuration parsing more complex at=
=20
this point.  This problem is probably best solved by a separate tool (not=
=20
ceph itself).

sage
--557981400-1115027872-1300294837=:1176--
