From: Meyers Mark <markmeyers.mmy@gmail.com>
Subject: =?UTF-8?Q?a_question_about_=E2=80=9Clease_issued_to_client=E2=80=9D_in_cep?=
        =?UTF-8?Q?h_mds?=
Date: Wed, 30 Aug 2017 19:40:29 +0800
Message-ID: <CACd4YjdHJJpGdtOQ_qDr0sLT4=suUFCHX+_QGbeKn2YoNg3mxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34114 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbdH3Lkb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Aug 2017 07:40:31 -0400
Received: by mail-wr0-f175.google.com with SMTP id z91so17743234wrc.1
        for <ceph-devel@vger.kernel.org>; Wed, 30 Aug 2017 04:40:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi:

        I want to ask a question about "lease issued to client".

        In ceph source, src/mds/Locker.cc: Locker::issue_client_lease:


        if(... &&

               (!diri->filelock.can_lease(client) &&

                (diri->get_client_cap_pending(client) &
(CEPH_CAP_FILE_SHARED | CEPH_CAP_FILE_EXCL)) == 0) &&

                 dn->lock.can_lease(client)) {

                ...

                // issue a dentry lease

               ClientLease *l = dn->add_client_lease(client, session);

                ...

                LeaseStat e;

                ...

                e.duration_ms = (int)(1000 *
mdcache->client_lease_durations[pool]);

                ...

        } else {

                // null lease

                LeaseStat e;

                ...

                e.duration_ms = 0;
                ...

        }

        So my understanding is:

        If parent directory has no lease, but has CEPH_CAP_FILE_SHARED
mask, then the dentry can get a lease of 30s(caculated from
duration_ms).

        Else if in other conditions, then the dentry get a lease of 0s.

        I am confused here, in what situation does the parent
directory and the child dentry share a lease?

        And in what situation does the child dentry have no
lease(lease of zero seconds?)?

        Could you please explain further?


Thank you for your reading, I really appreciate your response. Thanks.
