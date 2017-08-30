From: sa514164@mail.ustc.edu.cn
Subject: A question about "lease issued to client" in ceph mds
Date: Wed, 30 Aug 2017 21:17:02 +0800 (GMT+08:00)
Message-ID: <57fe2cb1.40519.15e3349b553.Coremail.sa514164@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.ustc.edu.cn ([202.38.64.46]:50288 "EHLO ustc.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751326AbdH3NZI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 30 Aug 2017 09:25:08 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi:
      
        I want to ask a question about "lease issued to client".

        In ceph source, src/mds/Locker.cc: Locker::issue_client_lease:


        if(... &&

               (!diri->filelock.can_lease(client) &&

                (diri->get_client_cap_pending(client) & (CEPH_CAP_FILE_SHARED | CEPH_CAP_FILE_EXCL)) == 0) &&

                 dn->lock.can_lease(client)) {

                ...

                // issue a dentry lease

               ClientLease *l = dn->add_client_lease(client, session);

                ...

                LeaseStat e;

                ...

                e.duration_ms = (int)(1000 * mdcache->client_lease_durations[pool]);

                ...

        } else {

                // null lease

                LeaseStat e;

                ...

                e.duration_ms = 0;
                ...

        }

        So my understanding is:

        If parent directory has no lease, but has CEPH_CAP_FILE_SHARED mask, then the dentry can get a lease of 30s(caculated from duration_ms).

        Else if in other conditions, then the dentry get a lease of 0s.

        I am confused here, in what situation does the parent directory and the child dentry share a lease?

        And in what situation does the child dentry have no lease(lease of zero seconds?)?

        Could you please explain further?


Thank you for your reading, I really appreciate your response. Thanks.
