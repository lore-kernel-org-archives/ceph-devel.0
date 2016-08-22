From: Jaze Lee <jazeltq@gmail.com>
Subject: why rbd journaling first write journal to journal pool and then write data
Date: Mon, 22 Aug 2016 16:46:04 +0800
Message-ID: <CAKZcxgdqLtdyLPF-dXczMu1hWjbtoF3i2iugDJH1ngtmqNLNNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:32855 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbcHVIqF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2016 04:46:05 -0400
Received: by mail-io0-f172.google.com with SMTP id 38so103429511iol.0
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2016 01:46:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all:
   I found that rbd journaling first write journal and then write data.
   Why we not first write data and then write journal? Is there some
considerration
   for which is first ?

   Thanks a lot.

--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
