From: Axel Dunkel <ad@dunkel.de>
Subject: radosgw: bad content length
Date: Fri, 30 Jan 2015 16:22:43 +0000 (UTC)
Message-ID: <loom.20150130T152219-712@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49643 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643AbbA3QZH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Jan 2015 11:25:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YHENU-00034G-BX
	for ceph-devel@vger.kernel.org; Fri, 30 Jan 2015 17:25:04 +0100
Received: from soc.dunkel.de ([soc.dunkel.de])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 17:25:04 +0100
Received: from ad by soc.dunkel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 17:25:04 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

there are issues with radosgw and large file transfers without using 
multiparts (like with "s3cmd --disable-multipart put") which seem to be 
somehow known, but unsolved. 

Things run fine if the request takes no longer than 180sec. If it takes 
longer, rgw_rest.cc (line 1236) gives the error "bad content length, 
aborting" AFTER the request has been fully completed (so no timeout 
issue). If the s3cmd runs less than 180sec things go through fine, if it 
takes longer, the same command fails. 

This error is given if the variable Content-Length can not be parsed - is 
it possible that some timer causes this variable to get corrupted? I did 
not find any 180sec timer, though...

This is with ceph version 0.87 (c51c8f9d80fa4e0168aa52685b8de40e42758578), 
Ubuntu 14.04.

Best regards
Axel Dunkel


