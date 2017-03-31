From: Dan Mick <dmick@redhat.com>
Subject: Teuthology users: you must now include at least one mgr daemon in
 your roles
Date: Thu, 30 Mar 2017 20:18:08 -0700
Message-ID: <e7e2fb13-83a4-5361-c038-4331066ba97a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753528AbdCaDSJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Mar 2017 23:18:09 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, "sepia@lists.ceph.com" <sepia@lists.ceph.com>

As of

578b0f7 Merge pull request #13617 from liewegas/wip-mgr-commands

merged today, all teuthology jobs that use a ceph command (pretty much
all teuthology jobs) need to include mgr daemons, because some of the
key ceph commands now are handled by that daemon.

If you have custom job yaml, you will need to add one or more mgr
daemons to the roles lists.

See 271a758 for how this was handled in qa/suites.

-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
