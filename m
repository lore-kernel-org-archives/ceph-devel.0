From: Owen Synge <osynge@suse.com>
Subject: ./ceph-deploy gatherkeys $HOST failing on master?
Date: Tue, 22 Nov 2016 14:32:22 +0100
Message-ID: <f6e89a41-294b-9538-f4dc-d5c026920477@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:52615 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755150AbcKVNcu (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 22 Nov 2016 08:32:50 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Dear all,

Yuri and I have been playing timezone ping pong on the subject of:

http://qa-proxy.ceph.com/teuthology/teuthology-2016-11-20_11:50:01-ceph-deploy-master-distro-basic-mira/565105/teuthology.log

Unfortunately this is not a good week for me to move into the western
hemisphere timezone.

I consider the significant issue to be:

 /usr/bin/ceph --connect-timeout=25 --cluster=ceph --name mon.
--keyring=/var/lib/ceph/mon/ceph-mira061/keyring auth get client.admin

Where "ceph-mira061" is the mon service name on the local node.

Which seems to be failing on master.

I do not see this with older releases. But until I can replicate this
bug, I do not yet raise it as a bug.

Do others see this on master or any other release?

It should be easy to replicate with:

    ceph-deploy mon create-initial

Or more directly (and easier to see) with:

    ceph-deploy gatherkeys $HOST

Best wishes

Owen

