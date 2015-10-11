From: Nathan Cutler <ncutler@suse.cz>
Subject: Distro support in infernalis and above
Date: Sun, 11 Oct 2015 21:20:44 +0200
Message-ID: <561AB68C.2030107@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39999 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbbJKTUq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 11 Oct 2015 15:20:46 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 75444AABB
	for <ceph-devel@vger.kernel.org>; Sun, 11 Oct 2015 19:20:44 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

I recently noted that infernalis no longer supports RHEL 6. Does this
extend to the ceph-common package?

If so, we could greatly simplify the spec file . . . something along the
lines of https://github.com/ceph/ceph/pull/6225

Regards

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
