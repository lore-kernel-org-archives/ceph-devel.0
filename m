From: Nathan Cutler <ncutler@suse.cz>
Subject: How are you dealing with hammer -> jewel upgrades?
Date: Tue, 10 May 2016 17:29:36 +0200
Message-ID: <5731FE60.1090704@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54252 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbcEJP3i (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 May 2016 11:29:38 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 08B18AB5D
	for <ceph-devel@vger.kernel.org>; Tue, 10 May 2016 15:29:37 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Regarding $SUBJ, the release notes [1] provide instructions for manually 
changing the ownership of the directories in /var/lib/ceph

I am exploring ways to automate the ownership change. The 
/var/lib/ceph/osd tree seems to be the most problematic because it could 
contain a very large number of files/directories.

Before I try to come up with a solution for automating it (perhaps by 
hacking "ceph-disk activate", I thought I'd ask here if anyone has 
already done any thinking/work in this area.

[1] https://github.com/ceph/ceph/blob/master/doc/release-notes.rst#L257-L295

Thanks!

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
