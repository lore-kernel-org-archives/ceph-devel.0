From: Zhen Cao <juehuiconst@gmail.com>
Subject: Ceph PG Number
Date: Wed, 30 Nov 2016 16:22:10 +0800
Message-ID: <CAOmt5rK42=8DcdrkeHgqsY6o2NjaQ+5wWOeZToZNsPd0GtS2ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f174.google.com ([209.85.217.174]:34621 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbcK3IWM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2016 03:22:12 -0500
Received: by mail-ua0-f174.google.com with SMTP id 51so205638969uai.1
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 00:22:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
I am reading the RADOS paper,but i could not understand why more PGs
per OSD result in a more balanced distribution.I konw the mapping
procedure between oid and osd=EF=BC=8Cbut it is neverless difficult to
understand for me.
Thanks for your help!
