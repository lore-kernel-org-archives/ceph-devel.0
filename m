From: "Snider, Tim" <Tim.Snider@netapp.com>
Subject: osd server hardware requirements
Date: Fri, 16 Nov 2012 17:40:08 +0000
Message-ID: <DC700C5A3AE74041B17F41EE35500AB90C8984EC@SACEXCMBX03-PRD.hq.netapp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.netapp.com ([216.240.18.37]:47546 "EHLO mx2.netapp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901Ab2KPRkL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 12:40:11 -0500
Received: from vmwexceht04-prd.hq.netapp.com (vmwexceht04-prd.hq.netapp.com [10.106.77.34])
	by smtp1.corp.netapp.com (8.13.1/8.13.1/NTAP-1.6) with ESMTP id qAGHe7oo005281
	for <ceph-devel@vger.kernel.org>; Fri, 16 Nov 2012 09:40:11 -0800 (PST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


I'm starting to look at Ceph and was wondering if anyone had a link to =
more specific OSD server guidelines WRT processor speed and memory requ=
irements.
My candidate server had an Intel processor =A02.13 GHz quad core proces=
sor and supports up to 24Gb of memory.
I'm wondering about the approximate number of OSDs that this type of pr=
ocessor and memory might support. The wording on the hw recommendations=
 webpage: http://ceph.com/docs/master/install/hardware-recommendations/=
 =A0is fairly generic.

Thanks,
Tim
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
