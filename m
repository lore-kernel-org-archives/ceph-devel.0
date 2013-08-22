From: Mostowiec Dominik <Dominik.Mostowiec@grupaonet.pl>
Subject: bucket count limit
Date: Thu, 22 Aug 2013 16:09:34 +0200
Message-ID: <ADBDB4FFB0814748AF32D0A1EE6E10AF22835B2EFF@MXMBON06.grupa.onet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from onsmg02.portal.onet.pl ([213.180.131.212]:43789 "EHLO
	onsmg02.portal.onet.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab3HVOJi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Aug 2013 10:09:38 -0400
Content-Language: pl-PL
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi,
I think about sharding s3 buckets in CEPH cluster, create bucket-per-XX (256 buckets) or even bucket-per-XXX (4096 buckets) where XXX is sign from object md5 url.
Could this be the problem? (performance, or some limits)

--
Regards
Dominik
