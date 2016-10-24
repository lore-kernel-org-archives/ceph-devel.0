From: Andrzej Jakowski <andrzej.jakowski@gmail.com>
Subject: Deep scrubbing
Date: Mon, 24 Oct 2016 11:02:22 -0700
Message-ID: <CAOmo8DZHhJPD-uozsSk7djUxQBdfoBp6UDu7Ou1Bwc8vwHRtiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:39265 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757361AbcJXSCX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2016 14:02:23 -0400
Received: by mail-ua0-f170.google.com with SMTP id 20so2099488uak.6
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2016 11:02:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Wanted to learn more on what is the Ceph community take on the deep
scrubbing process.
It seems that deep scrubbing is expected to read data from physical
media: NAND dies or magnetic platters.
What in case if OSD is build on top of some kind of volume and the
logic in the volume manager prevents OSD scrubbing process to read the
data from physical media?

Thanks!
Andrzej Jakowski
