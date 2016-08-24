From: Jaze Lee <jazeltq@gmail.com>
Subject: rbd cannot enable mirroring in the current pool mirroring mode
Date: Wed, 24 Aug 2016 18:06:05 +0800
Message-ID: <CAKZcxgcKKzt0G0wAj3NwoEY38nprmtSrfUKqFUvhbS3G9NMW5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:37439 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbcHXKGH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 06:06:07 -0400
Received: by mail-it0-f52.google.com with SMTP id f6so24897348ith.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 03:06:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, all
   I first test pool mode. After that, i want to try image mode.
I first stop rbd-mirror, and then disable pool mode, but i can not set the =
mode
to image.

[root@docker-0 ~]# rbd mirror pool disable rbd
[root@docker-0 ~]# rbd mirror image enable rbd/test
2016-08-24 12:23:27.578209 7f0d295b4d80 -1 librbd: cannot enable
mirroring in the current pool mirroring mode
[root@docker-0 ~]# ceph -v
ceph version 10.2.2 (45107e21c568dd033c2f0a3107dec8f0b0e58374)


May be i missed something?


--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
