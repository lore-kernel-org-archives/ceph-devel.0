From: zengran zhang <z13121369189@gmail.com>
Subject: ec performance in small random io testing
Date: Fri, 21 Jul 2017 17:26:52 +0800
Message-ID: <CALi+v18oLKMLcJWBG2BD2K7UzxTpZnYgf255BXUYv3Xr-RO-Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:37827 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753653AbdGUJ0x (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jul 2017 05:26:53 -0400
Received: by mail-io0-f177.google.com with SMTP id c74so20477766iod.4
        for <ceph-devel@vger.kernel.org>; Fri, 21 Jul 2017 02:26:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi :

   we found that the ec pool's iops is low in 4K randwrite test, I
think its because the append op will amplify most random small io, and
next small write on pending area will cause rmw and clone range...

    could we change the `append` to `write`, and change the `truncate`
to `unmap` when rollback?

    now the write io fall on one object will splite into one append
plus one overwrite at most, if we change to write+overwrite, write may
splite into many writes and overwrites that depending on how much
holes on the write range..

    now the UNMAP is not yet implemented=EF=BC=8Cwant to know wether it is =
hard to do?

    thanks and regards!
