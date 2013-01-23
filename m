From: Sage Weil <sage@inktank.com>
Subject: Re: Will multi-monitor speed up  pg initializing?
Date: Wed, 23 Jan 2013 05:05:58 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301230505040.17536@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC5E4A14@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1488354798-1358946358=:17536"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47726 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062Ab3AWNF7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 08:05:59 -0500
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5E4A14@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1488354798-1358946358=:17536
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Jan 2013, Chen, Xiaoxi wrote:
>=20
> Hi list,
> =A0=A0=A0=A0=A0=A0=A0=A0 When first time I start my ceph cluster,it tak=
es more than 15 minutes to get all the pg active&clean. It's fast at firs=
t (say 100pg/s) but quite slow when only hundreds of PG left peering.
> =A0=A0=A0=A0=A0=A0=A0=A0 Is it a common situation? Since there is quite=
 a few disk IO and network IO during this time, what stop osd from faster=
 initialize?
> =A0=A0=A0=A0=A0=A0=A0=A0 Can multi-monitor do any help with this?

How many PGs and OSDs?  Do the OSDs come up at the same time, or is there=
=20
a small number of OSDs that initially get all PGs?

sage
--557981400-1488354798-1358946358=:17536--
