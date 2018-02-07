From: Theofilos Mouratidis <mtheofilos@gmail.com>
Subject: RadosGW cache ldap auth
Date: Wed, 7 Feb 2018 11:43:09 +0100
Message-ID: <CA+9pRwQKvWT615YsfUoYE-iU+JPHjAt77+ZjCh7PaSH=FJyqoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:39776 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753853AbeBGKnK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Feb 2018 05:43:10 -0500
Received: by mail-qt0-f170.google.com with SMTP id f4so556911qtj.6
        for <ceph-devel@vger.kernel.org>; Wed, 07 Feb 2018 02:43:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello cephers,

In CERN, we would like to use the ldap authentication of the S3/Swift
radosgw api, for its.
features. I did some tests and I found out that for every request by
the same user,
the radosgw redirects the authentication to the ldap server. In case
this goes public,
it might cause a DDOS to the ldap server. We would kindly ask for it
to be implemented.
If this is not feasible right now, can you point us the way to create
a PR for this?

(Some change around "/src/rgw/librgw.cc:528", use rocksdb?)

Thanks,
Theofilos Mouratidis
Storage Group, CERN
