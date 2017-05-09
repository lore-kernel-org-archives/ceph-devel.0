From: Florian Haas <florian@hastexo.com>
Subject: Heads-up: possible Jewel/Kraken RBD compatibility issue that might
 impact users doing rolling upgrades
Date: Tue, 9 May 2017 16:18:09 +0200
Message-ID: <CAPUexz9k-4qcpkB0x4FKuZfeLTUbLUq_=abSbKa9AjAGhzHuiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:37352 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbdEIOSu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 May 2017 10:18:50 -0400
Received: by mail-it0-f47.google.com with SMTP id g126so2370471ith.0
        for <ceph-devel@vger.kernel.org>; Tue, 09 May 2017 07:18:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi everyone,

just a quick heads-up on this issue: http://tracker.ceph.com/issues/19889

TL;DR: "rbd import" looks like it breaks when upgrading a cluster from
Jewel to Kraken (and potentially, Luminous =E2=80=94 not sure about that) a=
nd
before upgrading the client itself. In other words, this might cause
disruption in upgrades with clients using "rbd import"-like
functionality (such as OpenStack Glance).

Cheers,
Florian
