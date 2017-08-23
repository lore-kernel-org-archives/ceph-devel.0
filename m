From: Myna V <mynaramana@gmail.com>
Subject: Object Size distributions
Date: Wed, 23 Aug 2017 23:09:50 +0530
Message-ID: <CAGvpcHau9eG-ehLEuUd_J2OVz=TuSMrQF3XARbCVA5Giz=hg3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35125 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbdHWRkb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Aug 2017 13:40:31 -0400
Received: by mail-pg0-f43.google.com with SMTP id u191so2807852pgc.2
        for <ceph-devel@vger.kernel.org>; Wed, 23 Aug 2017 10:40:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello All,

We are running repair time, network traffic evaluations for a erasure
code we implemented using Ceph. We were trying to get a good
understanding on the workload patterns/distributions.

What are the usal distributions used on file sizes while modeling RGW
workloads ? What is the mean and variance of such distributions ?

For RBD workloads, is the object size always fixed to 4MB or can it be
set to 64MB size. What advantages/disadvantages does this have ?

Thank You,
Myna.
