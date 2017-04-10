From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Forwarding Rocksdb to a new sha
Date: Mon, 10 Apr 2017 22:13:15 +0200
Message-ID: <323ff1df-e8c4-8fff-9fe0-81e5c45d22dd@suse.cz>
References: <efe3e212-13b9-c4b6-9abd-f95a6803123a@digiware.nl>
 <alpine.DEB.2.11.1704101334321.2999@piezo.novalocal>
 <21ce1351-d892-90ed-d902-fb043af3d87e@digiware.nl>
 <alpine.DEB.2.11.1704101350380.2999@piezo.novalocal>
 <ef64e486-92ce-a470-a92f-9f69351ef2bf@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39799 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752045AbdDJUNR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Apr 2017 16:13:17 -0400
In-Reply-To: <ef64e486-92ce-a470-a92f-9f69351ef2bf@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

>>> There is not that many updates to RocksDB, And my PR-commit is the
>>> current HEAD: 04abb2b2ddc308ab03f55ea9a1e08b62667d6e39
>>>
>>> So how do I forward the submodule to this SHA?
>>
>> Yeah, that makes sense!
>
> Right,
>
> But that did hot answer the penultimate question:
> 	How to do it?

According to .gitmodules, the src/rocksdb submodule is taken from 
https://github.com/ceph/rocksdb so the first thing is to get the commit 
into that repo.

Once it is there, you set the submodule to that commit and then open a 
PR (against ceph/ceph.git) changing the SHA1 that the src/rocksdb points 
to. IIRC the trick is that when the submodule is populated you can just 
"git add src/rocksdb" and git "does the right thing".

I've done this before, so it can't be too difficult ;-) I think I read 
this: https://git-scm.com/book/en/v2/Git-Tools-Submodules

Here's what a commit changing the src/rocksdb submodule looks like:

smithfarm@wilbur:~/src/ceph/smithfarm/ceph> git show 
f4fb59896ccb0d8ac01434cd4cf6ad67776fb0a0
commit f4fb59896ccb0d8ac01434cd4cf6ad67776fb0a0
Author: Nathan Cutler <ncutler@suse.com>
Date:   Mon Aug 22 20:56:38 2016 +0200

     build/ops: bump rocksdb submodule

     Fixes a FTBFS on ppc64le

     Fixes: http://tracker.ceph.com/issues/17092
     Signed-off-by: Nathan Cutler <ncutler@suse.com>

diff --git a/src/rocksdb b/src/rocksdb
index fa98456..92749e8 160000
--- a/src/rocksdb
+++ b/src/rocksdb
@@ -1 +1 @@
-Subproject commit fa98456ccbd860120127ac2e91a2088fb222606e
+Subproject commit 92749e88f5d9c8dc6e6aba1ff297f21f1e7ea811

HTH,
Nathan
