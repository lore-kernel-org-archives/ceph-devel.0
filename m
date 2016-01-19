From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: /var/lib/ceph/*/*/config
Date: Tue, 19 Jan 2016 15:48:41 +0000
Message-ID: <CY1PR0201MB1897F9EED05D5243BF010003E8C10@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1601191009320.28274@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0083.outbound.protection.outlook.com ([207.46.100.83]:55332
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932168AbcASQWN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jan 2016 11:22:13 -0500
In-Reply-To: <alpine.DEB.2.11.1601191009320.28274@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yes a step in the right direction.

Allen Samuels
Software Architect, Emerging Storage Solutions 

2880 Junction Avenue, Milpitas, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Tuesday, January 19, 2016 7:15 AM
To: ceph-devel@vger.kernel.org
Subject: /var/lib/ceph/*/*/config

I think we should add an optional 'config' file location to the config search path.  This would allow you to put customized options for an individual daemon in the daemon data directory.  Or, you could avoid putting a config in /etc/ceph entirely, so that the daemon data is completely self-contained on the device.  That would streamline boot disk failure (just reinstall OS and ceph package) or drive swaps between failed host hardware.

What do you think?
sage

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
