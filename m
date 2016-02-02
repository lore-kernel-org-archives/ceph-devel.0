From: Nathan Cutler <ncutler@suse.cz>
Subject: ceph-0.80.11.tar.bz2 missing at http://download.ceph.com/tarballs/
Date: Tue, 2 Feb 2016 12:53:42 +0100
Message-ID: <56B098C6.90803@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49957 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755073AbcBBLxo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Feb 2016 06:53:44 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 8F2F4AC86
	for <ceph-devel@vger.kernel.org>; Tue,  2 Feb 2016 11:53:42 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I just noticed that, while all the previous firefly releases have both 
.tar.gz and .tar.bz2 available, for 0.80.11 the latter is missing. It 
seems like a bug to me, so I went ahead created a tracker:

http://tracker.ceph.com/issues/14604

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
