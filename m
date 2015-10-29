From: Nathan Cutler <ncutler@suse.cz>
Subject: civetweb upstream/downstream divergence
Date: Thu, 29 Oct 2015 10:19:33 +0100
Message-ID: <5631E4A5.9020003@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35555 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbbJ2JTf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Oct 2015 05:19:35 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 3428AAC77
	for <ceph-devel@vger.kernel.org>; Thu, 29 Oct 2015 09:20:04 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ceph:

The civetweb code in RGW is taken from https://github.com/ceph/civetweb/
which is a fork of https://github.com/civetweb/civetweb. The last commit
to our fork took place on March 18.

Upstream civetweb development has progressed ("This branch is 19 commits
ahead, 972 commits behind civetweb:master.")

Are there plans to rebase to a newer upstream version or should we think
more in terms of backporting (to ceph/civetweb.git) from upstream
(civetweb/civetweb.git) when we need to fix bugs or add features?

Thanks and regards

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
