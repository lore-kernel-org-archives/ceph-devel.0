From: Ryan Nicholson <Ryan.Nicholson@kcrg.com>
Subject: RE: rbd create issues - like the bug...
Date: Wed, 1 Aug 2012 02:05:14 +0000
Message-ID: <F5955DC568F9AF4DB00BE0F7E950BE0C0E9097B4@BLUPRD0411MB438.namprd04.prod.outlook.com>
References: <60E83269D669544E8069A09CB69135EA011D62@GDC-CLDMBX-P02.whq.wistron>
 <5018515D.7000909@inktank.com>
 <60E83269D669544E8069A09CB69135EA012278@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:50556
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753053Ab2HACFa convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 Jul 2012 22:05:30 -0400
Received: from mail110-co1 (localhost [127.0.0.1])	by
 mail110-co1-R.bigfish.com (Postfix) with ESMTP id C9FF12019A	for
 <ceph-devel@vger.kernel.org>; Wed,  1 Aug 2012 02:05:29 +0000 (UTC)
Received: from CO1EHSMHS020.bigfish.com (unknown [10.243.78.243])	by
 mail110-co1.bigfish.com (Postfix) with ESMTP id A1C88C4004D	for
 <ceph-devel@vger.kernel.org>; Wed,  1 Aug 2012 02:05:23 +0000 (UTC)
In-Reply-To: <60E83269D669544E8069A09CB69135EA012278@GDC-CLDMBX-P02.whq.wistron>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

All: I cannot get this to work:

	Rbd create testImage --size 2000

My ceph.conf. file contains

#
[osd]
	osd_class_dir = /usr/local/lib/rados-classes
#


I've added /usr/local/lib/rados-classes to my ld.so.conf
I've done a ldconfig.
libcls_rbd.so & so.1 & so.1.0.0 are in the cache. (ldconfig -p | grep ...)

However, I'm still getting the error noted here http://ceph.com/docs/master/dev/osd-class-path/

	[librbd: failed to assign a block name for image]

Not sure where to go next...

Thanks, for any help.

Ryan Nicholson

