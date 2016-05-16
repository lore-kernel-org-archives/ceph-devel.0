From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: v0.94.7 Hammer released
Date: Mon, 16 May 2016 16:20:09 +1000
Message-ID: <20160516062008.GA11172@onthe.net.au>
References: <alpine.DEB.2.11.1605131020340.20416@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:40609 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbcEPGUN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 May 2016 02:20:13 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1605131020340.20416@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

On Fri, May 13, 2016 at 10:21:51AM -0400, Sage Weil wrote:
> This Hammer point release fixes several minor bugs. It also includes =
a=20
> backport of an improved =E2=80=98ceph osd reweight-by-utilization=E2=80=
=99 command for=20
> handling OSDs with higher-than-average utilizations.
>=20
> We recommend that all hammer v0.94.x users upgrade.

Per http://download.ceph.com/debian-hammer/pool/main/c/ceph/

ceph-common_0.94.7-1trusty_amd64.deb    11-May-2016 16:08  5959876
ceph-common_0.94.7-1xenial_amd64.deb    11-May-2016 15:54  6037236
ceph-common_0.94.7-1xenial_arm64.deb    11-May-2016 16:06  5843722
ceph-common_0.94.7-1~bpo80+1_amd64.deb  11-May-2016 16:08  6028036

Once again, no debian wheezy (~bpo70) version?

Ubuntu Precise missed out this time too.

Oddly, the date on the previously released wheezy version changed at th=
e
same time as the 0.94.7 releases above, it was previously 15-Dec-2015 1=
5:32:

ceph-common_0.94.5-1~bpo70+1_amd64.deb  11-May-2016 15:57  9868188


Cheers,

Chris
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
