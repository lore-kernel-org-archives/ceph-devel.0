From: Mark Meyers <MarkMeyers.MMY@gmail.com>
Subject: Can I omit acquire_locks in getattr handler of mds?
Date: Sat, 10 Feb 2018 08:15:45 +0000 (UTC)
Message-ID: <2073248911.84014.1518250545543@mail.yahoo.com>
References: <2073248911.84014.1518250545543.ref@mail.yahoo.com>
Reply-To: Mark Meyers <MarkMeyers.MMY@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sonic310-48.consmr.mail.ne1.yahoo.com ([66.163.186.229]:38592
        "EHLO sonic310-48.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750775AbeBJITz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 10 Feb 2018 03:19:55 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph-users <ceph-users@ceph.com>, "ceph-devel@lists.ceph.com" <ceph-devel@lists.ceph.com>, Ceph-devel <ceph-devel@vger.kernel.org>

I found ls command costs extremely long time (form 30s to 3mins).
So I tried to remove acquire_locks in mds's getattr handler: handle_clinet_getattr.
Everything looks just good:
First, the size of files get updated in time.
Second, the read and write to file from clinets works ok.

So, please, can I just omiit acquire_locks in mds getattr handler?(if client request doesn't requier or have Fwb caps)

Code:

diff -- git a/src/mds/Server.cc n/src/mds/Server.cc

--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -3021,7 +3021,10 @@ void Server::handler_client_getattr(MDRequestRef& mdr, bool is_lookup)
    if ((mask & CEPH_CAP_FILE_SHARED) && (issued & CEPH_CAP_FILE_EXCL) == 0) rdlocks.insert(&ref->filelock);
    if ((mask & CEPH_CAP_XATTR_SHARED) && (issued & CEPH_CAP_XATTR_EXCL) == 0) rdlocks.insert(&ref->xattrlock);
-   if (!mds->locker->acquire_locks(mdr, rdlocks, wrlocks, xlocks))
+   dout(20) << __func__ << " mask " << ccap_string(mask) << " issued " << 
ccap_string(issued) << " " << !is_lookup << " ." << dendl;
+   if(!(mask & CEPH_CAP_FILE_WR) && !(mask & CEPH_CAP_FILE_BUFFER) && !(issued & CEPH_CAP_FILE_WR) && !(iissued & CEPH_CAP_FILE_BUFFER) && !is_lookup)      
+     dout(10) << "no Fw/b in mask " << ccap_string(mask) << " or issued " << ccap_string(issued) << " " << !is_lookup << " ." << dendl;+   else if (!mds->locker->acquire_locks(mdr, rdlocks, wrlocks, xlocks))
      return;


    if (!check_access(mdr, ref, MAY_READ))
