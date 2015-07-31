From: Haomai Wang <haomaiwang@gmail.com>
Subject: Odd QA Test Running
Date: Fri, 31 Jul 2015 17:50:45 +0800
Message-ID: <CACJqLyY4kocnovRH0JTNtPWuB8CKbKZ3J_sT7yJUJ99pTXak1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36770 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbGaJup convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Jul 2015 05:50:45 -0400
Received: by pdjr16 with SMTP id r16so41069928pdj.3
        for <ceph-devel@vger.kernel.org>; Fri, 31 Jul 2015 02:50:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

I  ran a test suite(http://pulpito.ceph.com/haomai-2015-07-29_11:40:40-=
rados-master-distro-basic-multi/)
and found the failed jobs are failed by "2015-07-29 10:52:35.313197
7f16ae655780 -1 unrecognized ms_type 'async'"

Then I found the failed jobs(like
http://pulpito.ceph.com/haomai-2015-07-29_11:40:40-rados-master-distro-=
basic-multi/991540/)
lack of =E2=80=9Cenable experimental unrecoverable data corrupting feat=
ures:
ms-type-async=E2=80=9D.

Other successful jobs(like
http://pulpito.ceph.com/haomai-2015-07-29_11:40:40-rados-master-distro-=
basic-multi/991517/)
can find "enable experimental unrecoverable data corrupting features:
ms-type-async" in yaml.

So that's mean the same schedule suite will generate the different
yaml file? Is there something tricky?

--=20

Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
