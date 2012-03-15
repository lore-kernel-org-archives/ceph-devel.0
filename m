From: madhusudhana <madhusudhana.u.acharya@gmail.com>
Subject: Re: ceph -w command output in newly setup cluster
Date: Thu, 15 Mar 2012 17:56:36 +0000 (UTC)
Message-ID: <loom.20120315T185537-592@post.gmane.org>
References: <loom.20120315T183916-860@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37929 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031199Ab2COR4t (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Mar 2012 13:56:49 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1S8Eut-0007XK-K6
	for ceph-devel@vger.kernel.org; Thu, 15 Mar 2012 18:56:47 +0100
Received: from Static-180.119.99.14.tataidc.co.in ([Static-180.119.99.14.tataidc.co.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 Mar 2012 18:56:47 +0100
Received: from madhusudhana.u.acharya by Static-180.119.99.14.tataidc.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 15 Mar 2012 18:56:47 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

All,
I got the issue. I forgot to add firewal rules for 6789 port. After adding the 
rules, everything worked like charm.

Thanks
__M



