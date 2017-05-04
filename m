From: qi Shi <m13913886148@gmail.com>
Subject: Blustore data consistency question when big write.
Date: Thu, 4 May 2017 11:32:48 +0800
Message-ID: <CAN=xyVWmpqkzeqCziuxaY=qYeQBNBm6h+vqj0Ur31Az6uaXh4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:38253 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932497AbdEDDcu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 3 May 2017 23:32:50 -0400
Received: by mail-it0-f53.google.com with SMTP id e65so1629675ita.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 May 2017 20:32:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

when bluestore bigwrite it divided into two steps:
1, alloc a disk space and write data to it.
2, update the metadata to the database(rocksdb).

How to do data consistency?

Will the following error occur?
when write data to device sucess Osd process crushed .
But metadata is not update to rocksdb.

So I think there are legacy data in the disk,this can cause data
inconsistencies.
