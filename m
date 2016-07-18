From: Samuel Just <sjust@redhat.com>
Subject: new async messenger crash
Date: Mon, 18 Jul 2016 09:25:01 -0700
Message-ID: <CAN=+7FUY4QD+119vMYHpkb99x_NWgO9BxdJ_sHVcUWNpwK503g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36513 "EHLO
	mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbcGRQZI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jul 2016 12:25:08 -0400
Received: by mail-qt0-f171.google.com with SMTP id 52so94542800qtq.3
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jul 2016 09:25:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Haomai" <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm seeing a new async messenger segfault: http://tracker.ceph.com/issues/16714
-Sam
