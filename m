From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Kernel warnings in CEPH
Date: Thu, 18 May 2017 17:06:13 -0700
Message-ID: <20170518170613.5e1d924f@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34117 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbdESAGV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 May 2017 20:06:21 -0400
Received: by mail-pf0-f172.google.com with SMTP id 9so31189903pfj.1
        for <ceph-devel@vger.kernel.org>; Thu, 18 May 2017 17:06:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>
Cc: ceph-devel@vger.kernel.org

Building kernel with CEPH and warnings enabled shows several missing
prototypes and unused variables. Please fix.


net/ceph/ceph_common.c:62:13: warning: no previous prototype for =E2=80=98c=
eph_file_part=E2=80=99 [-Wmissing-prototypes]
net/ceph/messenger.c: In function =E2=80=98write_partial_message_data=E2=80=
=99:
net/ceph/messenger.c:1580:8: warning: variable =E2=80=98need_crc=E2=80=99 s=
et but not used [-Wunused-but-set-variable]
net/ceph/mon_client.c: In function =E2=80=98ceph_monmap_decode=E2=80=99:
net/ceph/mon_client.c:46:6: warning: variable =E2=80=98version=E2=80=99 set=
 but not used [-Wunused-but-set-variable]
net/ceph/auth_x.c: In function =E2=80=98process_one_ticket=E2=80=99:
net/ceph/auth_x.c:146:19: warning: variable =E2=80=98blob_struct_v=E2=80=99=
 set but not used [-Wunused-but-set-variable]
