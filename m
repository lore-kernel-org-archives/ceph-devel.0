From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: v0.56.2 released
Date: Thu, 31 Jan 2013 10:02:40 +0100
Message-ID: <510A3330.5090807@bisect.de>
References: <alpine.DEB.2.00.1301301540030.6225@cobra.newdream.net> <510A2085.3080301@profihost.ag>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:38635 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753173Ab3AaJCx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 31 Jan 2013 04:02:53 -0500
In-Reply-To: <510A2085.3080301@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Am 31.01.2013 08:43, schrieb Stefan Priebe - Profihost AG:
> Hello,
>=20
> while compiling the bobtail branch i've seen this warning:
> mon/PGMap.cc: In member function =91void
> PGMap::apply_incremental(CephContext*, const PGMap::Incremental&)=92:
> mon/PGMap.cc:247: warning: comparison between signed and unsigned
> integer expressions
>   CXX    libmon_a-LogMonitor.o

=46or fix see:
http://ceph.com/git/?p=3Dceph.git;a=3Dcommit;h=3Db571f8ee2d22a389412020=
4bc5f119ff37e1de53

@sage: please cherry pick b571f8ee2d22a3894120204bc5f119ff37e1de53 to
the bobtail branch.

Cheers,

Danny
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
