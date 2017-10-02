From: Two Spirit <twospirit6905@gmail.com>
Subject: Encrypted over WAN?
Date: Sun, 1 Oct 2017 23:18:44 -0700
Message-ID: <CAKRxpuuFHUgoQh8MfhS=vK9f6NVRbAWyccMWWGwJM9UCnw8dtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:43173 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdJBGSp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Oct 2017 02:18:45 -0400
Received: by mail-io0-f172.google.com with SMTP id k101so3941484iod.0
        for <ceph-devel@vger.kernel.org>; Sun, 01 Oct 2017 23:18:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

>The Ceph Object Gateway supports server-side encryption of uploaded object=
s, with 3 options for the management of encryption keys. Server-side encryp=
tion means that the data is sent over HTTP in its unencrypted form, and the=
 Ceph Object Gateway stores that data in the Ceph Storage Cluster in encryp=
ted form.

It sounds like OSD to OSD traffic is unencrypted.

1) Does "stores data in the cluster in encrypted form" mean *only* if
the --dmcrypt option is used?

2) Does that mean the zone  to zone copy across a WAN is also unencrypted?
