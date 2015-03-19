From: Xinze Chi <xmdxcxz@gmail.com>
Subject: keyvaluestore speed up?
Date: Thu, 19 Mar 2015 17:22:32 +0800
Message-ID: <CANE=7sUygGz67i-H+5v+ZmuwR4W9RuGzsWX6yhvJ=O9LKsyCSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33456 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbbCSJWd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 05:22:33 -0400
Received: by oifl3 with SMTP id l3so29781380oif.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 Mar 2015 02:22:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "sjust@redhat.com" <sjust@redhat.com>, Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

    Currently at keyvaluestore, osd send sync
request(submit_transaction_sync) to filestore when it finishes a
transaction. But sata disk is not suitable for doing sync request. ssd
disk is more suitable.

    So I think whether we could separate leveldb *.log file with *.sst
file and move *.log to ssd
disk, which is similar with journal file in ceph.

    But now, the original leveldb do not support to separate log file
and sst file.

    Wait for your comment.

    Thanks.
