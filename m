From: John Spray <jspray@redhat.com>
Subject: OSD leaks & selinux denials
Date: Wed, 7 Dec 2016 11:03:21 +0000
Message-ID: <CALe9h7c4UEeXznHF0KbghJGENEqd4KdAQEAAryVtp9yW67=M0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35723 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbcLGLDm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2016 06:03:42 -0500
Received: by mail-qt0-f169.google.com with SMTP id c47so374509194qtc.2
        for <ceph-devel@vger.kernel.org>; Wed, 07 Dec 2016 03:03:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sjust@redhat.com" <sjust@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

I generally ignore these on the assumption that they'd also be
appearing in rados suite runs, but since we're so close to Kraken I'm
flagging them:

['type=AVC msg=audit(1481075825.792:4517): avc:  denied  { open } for
pid=24997 comm="ceph-osd" path="/var/lib/ceph/osd/ceph-1/type"
dev="nvme0n1p3" ino=25 scontext=system_u:system_r:ceph_t:s0
tcontext=unconfined_u:object_r:unlabeled_t:s0 tclass=file', 't...
  http://pulpito.ceph.com/jspray-2016-12-07_00:24:14-fs-wip-jcsp-testing-20161206-distro-basic-smithi/612516

osd (Leak_DefinitelyLost)
  http://pulpito.ceph.com/jspray-2016-12-07_00:24:14-fs-wip-jcsp-testing-20161206-distro-basic-smithi/612548
  http://pulpito.ceph.com/jspray-2016-12-07_00:24:14-fs-wip-jcsp-testing-20161206-distro-basic-smithi/612640


John
