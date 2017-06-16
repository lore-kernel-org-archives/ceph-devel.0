From: Alfredo Deza <adeza@redhat.com>
Subject: ceph-lvm - a tool to deploy OSDs from LVM volumes
Date: Fri, 16 Jun 2017 10:25:44 -0400
Message-ID: <CAC-Np1yoYZ2AEda=c4a4SYLs9M2Adwu_tJ7P3=t_yK0Lwm4JiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37219 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbdFPOZr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Jun 2017 10:25:47 -0400
Received: by mail-wm0-f54.google.com with SMTP id d73so25315435wma.0
        for <ceph-devel@vger.kernel.org>; Fri, 16 Jun 2017 07:25:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hello,

At the last CDM [0] we talked about `ceph-lvm` and the ability to
deploy OSDs from logical volumes. We have now an initial draft for the
documentation [1] and would like some feedback.

The important features for this new tool are:

* parting ways with udev (new approach will rely on LVM functionality
for discovery)
* compatibility/migration for existing LVM volumes deployed as directories
* dmcache support

By documenting the API and workflows first we are making sure that
those look fine before starting on actual development.

It would be great to get some feedback, specially if you are currently
using LVM with ceph (or planning to!).

Please note that the documentation is not complete and is missing
content on some parts.

[0] http://tracker.ceph.com/projects/ceph/wiki/CDM_06-JUN-2017
[1] http://docs.ceph.com/ceph-lvm/
