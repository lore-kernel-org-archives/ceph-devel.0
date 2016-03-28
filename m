From: Nathan Cutler <ncutler@suse.cz>
Subject: Fixes: lines in commit messages
Date: Mon, 28 Mar 2016 18:09:09 +0200
Message-ID: <56F95725.3040407@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47235 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922AbcC1QJM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Mar 2016 12:09:12 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 7F288AC32
	for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2016 16:09:09 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Greetings, Ceph developers:

As the number of GitHub pull requests rises (currently in the 8000s), we 
are starting have trouble with unrelated PRs getting closed 
automatically by the "Fixes: #...." lines in PR descriptions and commit 
messages.

For example, if you open PR#9534 that fixes tracker issue#8069, 
including a line "Fixes: #8069" will cause PR#8069 to be closed - 
obviously, this is wrong but it's the way GitHub works.

Sage suggested that we work around this by referring to the tracker 
issue by its full URL. I opened a PR changing SubmittingPatches to 
reflect this:

https://github.com/ceph/ceph/pull/8312

Any objections?

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
