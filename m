From: Sugang Li <sugangli@winlab.rutgers.edu>
Subject: running ceph cluster (built from source) from multiple machines
Date: Fri, 24 Feb 2017 10:24:39 -0500
Message-ID: <CAG0LsznANAmgEZJxQv+Gw6Vj=Fyzy-i0-eVCozYkN4UWfviagQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:35501 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbdBXPYm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2017 10:24:42 -0500
Received: by mail-wr0-f173.google.com with SMTP id g10so13445038wrg.2
        for <ceph-devel@vger.kernel.org>; Fri, 24 Feb 2017 07:24:41 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

Recently I modified the source code a little bit and I am trying to test
its benchmark performance on multiple machines (one VM for client, one VM
for mon, three VMs for OSDs). I realized that vstart.sh script seems only
runs cluster on the local machine, so I am wondering is there a way I can
do it on multiple ones, which is similar to ceph-deploy?

Thanks,

Sugang
