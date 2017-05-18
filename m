From: fisherman <fisherman.dong@gmail.com>
Subject: A question about Ceph's paxos implication
Date: Fri, 19 May 2017 07:31:08 +0800
Message-ID: <CACRPdDQACqOdoFJQMpfNEDY7zgqc6-m+DWG2f8JMHDTu+2HqSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33139 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbdERXbK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 May 2017 19:31:10 -0400
Received: by mail-wm0-f41.google.com with SMTP id v15so15668448wmv.0
        for <ceph-devel@vger.kernel.org>; Thu, 18 May 2017 16:31:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, Sage and all Cepher

   I am reading Ceph's implementation of paxos and have a question about it.
   The question is given by an example below:

   Assume there are 5 monitor nodes: n1, n2, n3, n4, n5.

1) Node n1 is the leader,  all nodes are synchroined with
Last_committed=100, and there is no pending operation;
2) A client, say c1, sends a request R1 to n1;
3) Node n1 proposes a value v(for R1) with log version 101, stores
version 101 and pending_v =101 in its db. But it goes down before
sending anything to other nodes;
   Note: only n1 has pending_v == 101.
4) Node n2 becomes the leader(without n1) and the cluster become
active. Client c1 querys n2 for status, and the result shows R1 is
lost;
5) Node n1 recovers and becomes leader again;
6) Node n1 finds pending_v == 101 and log version 101, so R1 get
replicated and applied;
7) Client C1 queries again, and finds R1 has been applied.
    ==>inconsitent with the result of 4)

Am I right on this point?

Thanks
Fisher
