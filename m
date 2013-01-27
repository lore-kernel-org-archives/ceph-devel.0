From: Cesar Mello <cmello@gmail.com>
Subject: Re: libs3 build errors
Date: Sun, 27 Jan 2013 21:49:06 +0000 (UTC)
Message-ID: <loom.20130127T224449-450@post.gmane.org>
References: <32649264-9077-48F0-AF8B-B59EACDBD6B1@cs.ucsc.edu> <Pine.LNX.4.64.1205111652280.17928@cobra.newdream.net> <32072637-AF2C-48ED-9D35-1D8C20A28C4C@cs.ucsc.edu> <BFC8277B-88C5-46E1-9CA5-98AD0F4D27FF@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49605 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756545Ab3A0Vtt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 27 Jan 2013 16:49:49 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Tza71-0004oC-AB
	for ceph-devel@vger.kernel.org; Sun, 27 Jan 2013 22:50:03 +0100
Received: from 177.97.73.dynamic.adsl.gvt.net.br ([177.97.73.dynamic.adsl.gvt.net.br])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 27 Jan 2013 22:50:03 +0100
Received: from cmello by 177.97.73.dynamic.adsl.gvt.net.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 27 Jan 2013 22:50:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

> 
> I blew away libs3/build and then it caught the correct libxml2 paths on the
next build. This happened on two
> systems but I cannot reproduce it now :(
> 
> Thanks,
> Noah

Just happened the same thing in both my machines after I tried to build with
rest-bench (configure --with-rest-bench).

After deleting the directory src/libs3/build everything worked fine.

Thanks!

Best regards
Mello
 


