From: kefu chai <tchaikov@gmail.com>
Subject: payload of MPing
Date: Thu, 7 Sep 2017 12:00:02 +0800
Message-ID: <CAJE9aONuZZeDut2boHFU-nWXstCqXEaSEHT+KfGE0xJqJm=SaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35416 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdIGEAD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Sep 2017 00:00:03 -0400
Received: by mail-oi0-f50.google.com with SMTP id n18so52286468oig.2
        for <ceph-devel@vger.kernel.org>; Wed, 06 Sep 2017 21:00:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Joao Eduardo Luis <joao@suse.de>

hey Joao,

while reviewing https://github.com/ceph/ceph/pull/17269, i found that
there is no consumers of the payload of MPing replies. but apparently,
we stuff it with the health status on purpose. do you happen to
remember why we are doing so? if the feature/functionality depending
on it is deprecated or removed or not implemented, probably we can
just drop the logic to stuff the payload of MPing?


cheers,

-- 
Regards
Kefu Chai
