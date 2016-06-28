From: Nathan Cutler <ncutler@suse.de>
Subject: jewel -> master upgrade
Date: Tue, 28 Jun 2016 10:26:55 +0200
Message-ID: <075b96eb-bee1-8618-74a3-a10da327fef2@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56703 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383AbcF1I05 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jun 2016 04:26:57 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 75E8AACAE
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 08:26:55 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have been working on http://tracker.ceph.com/issues/14995 which has 
been causing lots of failures in the upgrade suites, and now I think I 
know why.

At the moment, the highest tag in jewel is v10.2.2, while in master the 
highest tag is v10.2.0 - this can be verified by doing "git describe" in 
both branches.

Since the version numbers of all the packages are derived from "git 
describe", we now have a situation where the package managers (rpm, 
dpkg, etc.) consider master packages (i.e. packages built from the 
master branch) to be _older_ than jewel packages.

The solution, I guess, would be to add a v11.0.0 tag to master.

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
