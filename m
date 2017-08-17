From: Jin Cai <caijin.laurence@gmail.com>
Subject: Ceph RDMA module: OSD marks peers down wrongly
Date: Thu, 17 Aug 2017 17:50:45 +0800
Message-ID: <CAGRcXKZkhwm=5mPtDzp73Pk0pwBZpAPmS3SDQqOyS_G0VELGug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:38569 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdHQJur (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Aug 2017 05:50:47 -0400
Received: by mail-lf0-f52.google.com with SMTP id y15so27230345lfd.5
        for <ceph-devel@vger.kernel.org>; Thu, 17 Aug 2017 02:50:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, haomai@xsky.com

Hi cephers,
     I am testing the rdma module of ceph.
     The test environment is as following:
          Ceph version: 12.1.0
          6 hosts and each host has 12 OSDs.

      Error is injected into the cluster by hand:
          1. kill all OSD daemons in one host
           2. restart all the OSD daemons killed just now.

       The problem is that  OSDs in other hosts cannot get heartbeat
reply from each other and marked down by the monitor wrongly.
       By analyse the log, I found that the OSDs from other hosts
sents heartbeat to their peers, but the heartbeat could not be sent
successfully because there doesn't have enough buffer:

        RDMAConnectedSocketImpl operator() no enough buffers in worker
0x7fd839c18d00

       The memory buffer in RDMADispatcher will be released by the
RDMADispatcher::polling() function.
       But when I killed all OSD daemons in one host and restarted
then,  the ratio of memory buffer release became slow and finally the
number of inflight chunks reached 1023(max value is 1024):

       2017-08-15 20:15:42.383778 7fd82641b700 30 RDMAStack
post_tx_buffer release 1 chunks, inflight 1023
       2017-08-15 20:15:42.384151 7fd82641b700 30 RDMAStack
post_tx_buffer release 1 chunks, inflight 1023
       2017-08-15 20:15:42.538885 7fd82641b700 30 RDMAStack
post_tx_buffer release 1 chunks, inflight 1023


      I think the root cause is related to the memory buffer release
when error is injected.
      Do you have any ideas about this? Expect your response and
thanks in advance.
