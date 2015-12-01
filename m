From: Nathan Cutler <ncutler@suse.cz>
Subject: Troublesome documentation link on http://ceph.com
Date: Tue, 1 Dec 2015 13:44:01 +0100
Message-ID: <565D9611.3000109@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59526 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbbLAMoD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Dec 2015 07:44:03 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id A216BAC01
	for <ceph-devel@vger.kernel.org>; Tue,  1 Dec 2015 12:44:02 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

So I go to http://ceph.com and click on the "Documentation" link. In the 
HTML source code the linked URL is http://ceph.com/docs but the HTTP 
server rewrites this to:

http://docs.ceph.com/docs/v0.80.5/

Could someone arrange for this to be changed s/v0.80.5/master/ ?

( Searching for Ceph documentation is already difficult as it is, 
because Google does not provide links to the master version, but only to 
old outdated versions - see for example the first two search results in 
a Google search for "troubleshoot pgs in ceph": http://tinyurl.com/nfuohss )

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037



