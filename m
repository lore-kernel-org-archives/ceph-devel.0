From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Huge lookup when recursively mkdir
Date: Fri, 20 Oct 2017 00:49:05 +0800
Message-ID: <CAEYCsVLCS5aPC8M8PAU5UTS0pKzhp1aWBW6L72ZwvUEetbstpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:43254 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754736AbdJSQtH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Oct 2017 12:49:07 -0400
Received: by mail-io0-f173.google.com with SMTP id 134so10507910ioo.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 Oct 2017 09:49:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>, "Yan, Zheng" <ukernel@gmail.com>

Hi,

      I am seeing a lot of lookup request when doing recursive mkdir.
      The workload behavior is like:
          mkdir DIR0
          mkdir DIR0/DIR1
          mkdir DIR0/DIR1/DIR2
          ....
          mkdir DIR0/DIR1/DIR2......./DIR7
          create DIR0/DIR1/DIR2......./DIR7/FILE1

      and concurrently run on 50+ clients, the dir name in different
clients may or maynot be the same.

       from the admin socket I was seeing ~50K create requests, but
got 400K lookup requests. The lookup eat up most of the mds capability
so file create is slow.

       Where is the lookup comes from and can we have anyway to
optimize it out ?

     Xiaoxi
