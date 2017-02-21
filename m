From: Weiming Shi <swmtrc@gmail.com>
Subject: Question on the limit of the number of buckets and the number of
 objects per bucket of Ceph object store
Date: Tue, 21 Feb 2017 13:39:33 -0500
Message-ID: <CAHS-Gt0bt7jt5KAOMGOJut2FztU9L=VVnOnG0HMRd-MdoVbSOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36076 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754226AbdBUSji (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2017 13:39:38 -0500
Received: by mail-qk0-f181.google.com with SMTP id x71so64674412qkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2017 10:39:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

Dear Ceph users and developers,

I am trying to understand the limit on the number of buckets and the
number of objects per bucket for Ceph object store. Which factors
determine the limits on these two dimensions?

If I would like to store 100 million files in a Ceph cluster,  what
would be the recommended data partition scheme in terms of the number
of buckets, number of objects per bucket? Are the information found in
an old discussion
http://lists.ceph.com/pipermail/ceph-users-ceph.com/2013-March/030002.html
still relevant ?

Thanks

Weiming
