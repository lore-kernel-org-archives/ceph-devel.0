From: Nathan Cutler <ncutler@suse.cz>
Subject: What to do with python-ceph-compat?
Date: Mon, 22 Aug 2016 11:27:42 +0200
Message-ID: <46719a38-0ab0-604d-89cb-50eeb6d32d3d@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54179 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752446AbcHVJ1o (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Aug 2016 05:27:44 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8130CAAF2
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2016 09:27:43 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

In the hammer release, the python-ceph package was split into three 
separate packages: python-rados, python-rbd, python-cephfs [1]. In rpm, 
a "python-ceph-compat" metapackage was introduced for backwards 
compatibility (with Provides: python-ceph), while in deb the python-ceph 
package was converted into a metapackage.

Now, in PR#9757 [2] we are exploring the possibility of dropping 
python-ceph-compat entirely, since we don't want to have it hanging 
around forever.

In preparation for this, a teuthology commit was merged [3] to modify 
the default package list (replacing "python-ceph" with the three 
post-split packages). This had the unintended consequence of breaking 
tests that start by installing firefly and then later upgrade to a more 
recent version (there are a number of these). This bug is tracked in [4].

I'm hereby seeking opinions on how to address this.

One way would be to override the package list in those tests, so it 
doesn't include any "python-*" packages at all. This would work provided 
none of those tests actually need to use the python bindings (?).

Another possibility is to override the default package list for those 
tests, replacing "python-{rados,rbd,cephfs}" with "python-ceph". That 
will enable firefly/dumpling installation to succeed, but I'm worried 
that at least those tests that upgrade to master (kraken+) would fail in 
the cleanup phase because it would be impossible to remove "python-ceph".

A third possibility would be to modify teuthology to make it aware of 
package splits, and enable it to automatically override the package list 
as needed.

Finally, we could just keep the "python-ceph" (deb) and 
"python-ceph-compat" (rpm) packages "forever", i.e. for as long as we 
have tests that start by installing pre-hammer versions.

[1] https://github.com/ceph/ceph/pull/3788
[2] https://github.com/ceph/ceph/pull/9757
[3] https://github.com/ceph/teuthology/commit/4543fb64
[4] http://tracker.ceph.com/issues/17075

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
