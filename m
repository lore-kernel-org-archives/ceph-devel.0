From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] Question about Backward compatible of different
 release
Date: Mon, 18 Feb 2013 20:29:49 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302182025190.21325@cobra.newdream.net>
References: <201302191155007357228@lecast.com.cn>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2028328757-1361248189=:21325"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54718 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757007Ab3BSE3u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Feb 2013 23:29:50 -0500
In-Reply-To: <201302191155007357228@lecast.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sally_wang@lecast.com.cn" <sally_wang@lecast.com.cn>
Cc: ceph-users <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2028328757-1361248189=:21325
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Sally-

On Tue, 19 Feb 2013, sally_wang@lecast.com.cn wrote:
> Hello All,
> =A0
> I'm a new user.=A0 I found that CephFS can't be distributed between dif=
ferent
> release versions.=A0 It will be=A0a potential problem in a producation
> environment when Ceph upgrades.=A0 Is there any workaround to keep Ceph=
FS
> working during the upgrading?

Every Ceph release for the last year or so has allowed you do to a=20
'rolling' upgrade in which one component/daemon at a time is upgraded to =
a=20
newer version while the system remains online.  There are some=20
restrictions with respect to the order things are upgraded, but those get=
=20
documented in the release notes.

If you're talking abot CephFS specifically, things are a bit less=20
clear-cut, if only because the file system component is not yet considere=
d=20
production ready.  Even so, the same rules will generally apply with=20
respect to upgrades.

Cheers-
sage

--557981400-2028328757-1361248189=:21325--
