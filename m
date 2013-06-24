From: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>
Subject: Missing SLES11 packages
Date: Mon, 24 Jun 2013 14:20:41 +0200
Message-ID: <20130624122041.GA2789@upset.ux.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:28859 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab3FXMVG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jun 2013 08:21:06 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Dieter Kasper <dieter.kasper@ts.fujitsu.com>, Andreas Bluemle <andreas.bluemle@itxperts.de>, Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>

Hello Sage,

I'm trying to install Ceph on a SLES11 system using the packages from
  (a) http://ceph.com/rpm-cuttlefish/sles11/

When calling
  rpm -i ceph-0.61.4-0.x86_64.rpm \
         libcephfs1-0.61.4-0.x86_64.rpm \
         librados2-0.61.4-0.x86_64.rpm \
         librbd1-0.61.4-0.x86_64.rpm

I got the following dependency errors
  error: Failed dependencies:
          python-lockfile is needed by ceph-0.61.4-0.x86_64
          scsirastools is needed by ceph-0.61.4-0.x86_64
          libtcmalloc.so.0()(64bit) is needed by ceph-0.61.4-0.x86_64

The python-lockfile dependency is new with 0.61.4. But also the
scsirastools and libtcmalloc packages are not part of SLES11 and are
not listed below (a). So how to install Ceph on a SLES11 system?

Best regards
Andreas Friedrich
----------------------------------------------------------------------
FUJITSU
Fujitsu Technology Solutions GmbH
Heinz-Nixdorf-Ring 1, 33106 Paderborn, Germany
Tel: +49 (5251) 525-1512
Fax: +49 (5251) 525-321512
Email: andreas.friedrich@ts.fujitsu.com
Web: ts.fujitsu.com
Company details: de.ts.fujitsu.com/imprint
----------------------------------------------------------------------
