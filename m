From: Ryan Nicholson <Ryan.Nicholson@kcrg.com>
Subject: RE: rbd create issues - like the bug...
Date: Wed, 1 Aug 2012 05:47:07 +0000
Message-ID: <F5955DC568F9AF4DB00BE0F7E950BE0C0E9099B4@BLUPRD0411MB438.namprd04.prod.outlook.com>
References: <60E83269D669544E8069A09CB69135EA011D62@GDC-CLDMBX-P02.whq.wistron>
 <5018515D.7000909@inktank.com>
 <60E83269D669544E8069A09CB69135EA012278@GDC-CLDMBX-P02.whq.wistron>
 <F5955DC568F9AF4DB00BE0F7E950BE0C0E9097B4@BLUPRD0411MB438.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:57685
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753173Ab2HAFrM convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 Aug 2012 01:47:12 -0400
Received: from mail46-co1 (localhost [127.0.0.1])	by mail46-co1-R.bigfish.com
 (Postfix) with ESMTP id C6926660130	for <ceph-devel@vger.kernel.org>; Wed,  1
 Aug 2012 05:47:11 +0000 (UTC)
Received: from CO1EHSMHS006.bigfish.com (unknown [10.243.78.247])	by
 mail46-co1.bigfish.com (Postfix) with ESMTP id 6F772D40044	for
 <ceph-devel@vger.kernel.org>; Wed,  1 Aug 2012 05:47:09 +0000 (UTC)
In-Reply-To: <F5955DC568F9AF4DB00BE0F7E950BE0C0E9097B4@BLUPRD0411MB438.namprd04.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ryan Nicholson <Ryan.Nicholson@kcrg.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Nevermind. One OSD node was missing the lib.

Cheers!

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Ryan Nicholson
Sent: Tuesday, July 31, 2012 9:05 PM
To: ceph-devel@vger.kernel.org
Subject: RE: rbd create issues - like the bug...

All: I cannot get this to work:

	Rbd create testImage --size 2000

My ceph.conf. file contains

#
[osd]
	osd_class_dir = /usr/local/lib/rados-classes #


I've added /usr/local/lib/rados-classes to my ld.so.conf I've done a ldconfig.
libcls_rbd.so & so.1 & so.1.0.0 are in the cache. (ldconfig -p | grep ...)

However, I'm still getting the error noted here http://ceph.com/docs/master/dev/osd-class-path/

	[librbd: failed to assign a block name for image]

Not sure where to go next...

Thanks, for any help.

Ryan Nicholson

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html


