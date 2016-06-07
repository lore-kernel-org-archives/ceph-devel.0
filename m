From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: un-even data filled on OSDs
Date: Tue, 7 Jun 2016 13:02:09 +0530
Message-ID: <CANA9Uk4NH7H4kQjEzeNp26bvar5DRWvnNdPff-wCJDRfb1be_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35805 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbcFGHcK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jun 2016 03:32:10 -0400
Received: by mail-oi0-f49.google.com with SMTP id s139so24582829oie.2
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jun 2016 00:32:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: ceph-users <ceph-users@lists.ceph.com>

Hello,
I have aorund 100 OSDs in my ceph cluster. In this a few OSDs filled
with >85% of data and few OSDs filled with ~60%-70% of data.

Any reason why the unevenly OSDs filling happned? do I need to any
tweaks on configuration to fix the above? Please advise.

PS: Ceph version is - 0.80.7

Thanks
Swami
