From: Nathan Cutler <ncutler@suse.cz>
Subject: apache/fcgi deprecation?
Date: Fri, 5 Feb 2016 05:12:22 +0100
Message-ID: <56B42126.7090106@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40642 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbcBEEMZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 4 Feb 2016 23:12:25 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 7DC95AB45
	for <ceph-devel@vger.kernel.org>; Fri,  5 Feb 2016 04:12:23 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I was just browsing the RGW documentation and noticed that parts of it 
are still apache/fcgi-oriented (with no mention of civetweb) even in master.

My impression was that civetweb is now recommended for RGW deployments 
as it is faster. Is that true? And is there a plan to deprecate/drop 
apache/fcgi support, or will it remain indefinitely?

Would it be a good idea to expunge apache/fcgi from the docs and point 
folks to civetweb instead?

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
