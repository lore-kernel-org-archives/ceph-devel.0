From: Wido den Hollander <wido@42on.com>
Subject: Switch to RBD format 2 by default after Firefly
Date: Tue, 08 Apr 2014 14:47:48 +0200
Message-ID: <5343EFF4.9010808@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:56156 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756846AbaDHMr4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Apr 2014 08:47:56 -0400
Received: from [172.9.1.90] (unknown [61.8.155.149])
	by websrv.42on.com (Postfix) with ESMTPSA id B4DF7C05A3
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:47:53 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

With Ubuntu 14.04 now shipping with the 3.13 kernel it fully supports 
Format 2 in both librbd and krbd.

For RHEL 7 there will be a extra yum repo with a module which supports 
format 2, so isn't it that that after Firefly we change 
'rbd_default_format' to 2?

I still see a lot of images being created with format 1 and that will 
otherwise be hunting us for a long time.

I'd vote for making format 2 the default or at least patch the 'rbd' 
tool to create format 2 images.

-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
