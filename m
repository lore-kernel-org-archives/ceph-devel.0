From: ramu eppa <ramu.freesystems@gmail.com>
Subject: Re: How to build ceph upon zfs filesystem.
Date: Thu, 30 Aug 2012 03:54:29 +0000 (UTC)
Message-ID: <loom.20120830T055024-954@post.gmane.org>
References: <loom.20120826T033818-148@post.gmane.org> <503A2142.2000505@inktank.com> <loom.20120827T063044-980@post.gmane.org> <loom.20120829T153702-223@post.gmane.org> <503E1E25.6060704@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58558 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab2H3Dyn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Aug 2012 23:54:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T6vq6-00038H-RX
	for ceph-devel@vger.kernel.org; Thu, 30 Aug 2012 05:54:43 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 05:54:42 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 05:54:42 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Wiessner,

   Actually I created zpool and this is mounted to /dev/sdb and then set a 
mountpint to osd.The space showing is 144GB.But the osd's are going down after 
rbd image is while running.

Thanks,
Ramu.

