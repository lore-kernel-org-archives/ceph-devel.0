From: ramu eppa <ramu.freesystems@gmail.com>
Subject: Re: How to write data to rbd pool.
Date: Wed, 3 Oct 2012 04:55:06 +0000 (UTC)
Message-ID: <loom.20121003T065313-927@post.gmane.org>
References: <loom.20121001T173732-275@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51461 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754366Ab2JCE4G (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Oct 2012 00:56:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TJGzs-0001Kx-I8
	for ceph-devel@vger.kernel.org; Wed, 03 Oct 2012 06:55:48 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 06:55:48 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 06:55:48 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

   When map rbd to /dev it's giving error,
"rbd map /dev/mypool/mytest "

add failed: (22) Invalid argument
 
How to map rbd volume.Please help me.

Thanks,
Ramu.

