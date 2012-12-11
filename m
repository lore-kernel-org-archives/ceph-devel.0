From: Bryant Ng <bryantng@gmail.com>
Subject: Crush and Monitor questions
Date: Tue, 11 Dec 2012 12:23:54 -0800
Message-ID: <ka84oo$sa3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41766 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176Ab2LKUY5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 15:24:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1TiWNz-0005No-QH
	for ceph-devel@vger.kernel.org; Tue, 11 Dec 2012 21:25:03 +0100
Received: from 50-76-54-11-ip-static.hfc.comcastbusiness.net ([50.76.54.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 11 Dec 2012 21:25:03 +0100
Received: from bryantng by 50-76-54-11-ip-static.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 11 Dec 2012 21:25:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm pretty new to Ceph and am just learning about it.

Where are the CRUSH maps stored in Ceph? In the documentation I see you 
use the 'crushtool' to compile and decompile the crush map.  I 
understand that if a single monitor comes online, it can talk to the 
other existing monitors to get the cluster map but how does it work on 
initial startup?  Or if the entire Ceph clusters goes down b/c of power 
failure or something.

What is the recommended hardware configuration for monitors?  In the 
Hardware Recommendation page it says "A monitor requires approximately 
10GB of storage space per daemon instance."  per daemon instance is 
talking about the monitor daemon, not the osd daemons?

Also further down on that page, it list some hardware examples where it 
mentions a ligher configuration for monitors.  I am assuming that is the 
Dell PE R510 which contains 8 x 2 TB drives.  Why does the monitor need 
so much space if it's "10GB of storage space per daemon instance".

-Bryant

