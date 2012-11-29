From: Andrey Korolyov <andrey@xdel.ru>
Subject: parsing in the ceph osd subsystem
Date: Thu, 29 Nov 2012 10:45:14 +0300
Message-ID: <CABYiri8PnWR=LNPuR1bqpuPGp55diHYPsAhdUtd7dNC9=UJTRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36843 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab2K2Hpf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 02:45:35 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so12756510obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 28 Nov 2012 23:45:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

$ ceph osd down -
osd.0 is already down
$ ceph osd down ---
osd.0 is already down

the same for ``+'', ``/'', ``%'' and so - I think that for osd subsys
ceph cli should explicitly work only with positive integers plus zero,
refusing all other input.
