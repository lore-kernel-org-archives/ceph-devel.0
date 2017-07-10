From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: proposal : read/write threads and handles separation in civetweb and rgw
Date: Mon, 10 Jul 2017 17:17:26 +0530
Message-ID: <CAP3mxSxpaAoVFsNusx9E6eudVtK_hYcN7HcwuCr27YcoHrPsaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f176.google.com ([209.85.213.176]:35175 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753649AbdGJLr2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Jul 2017 07:47:28 -0400
Received: by mail-yb0-f176.google.com with SMTP id p207so27054771yba.2
        for <ceph-devel@vger.kernel.org>; Mon, 10 Jul 2017 04:47:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

TL;DR
---------
The proposal is to separate out read and write threads/handles in
civetweb/rgw to reduce the blast radius in case of an outage caused
due to one type of op (GET or PUT) being blocked or latent. Proposal
PR : https://github.com/ceph/civetweb/pull/21

Problem Statment
------------------------
Our production clusters, primarily running object gateway workloads on
hammer, have quite a few times seen one type of op (GET or PUT) being
blocked or latent due to different reasons. This have resulted in a
complete outage with rgw becoming totally un-responsive and unable to
accept connections. After root causing the issue, it is found that
there is no separation of resources, threads and handles at civetweb
and rgw layers, which causes a complete blackout.

Scenarios
--------------
Some scenarios which are known to block one kind of op (GET or PUT).

* PUTs are blocked when pool with bucket index is degraded. We have
large omap objects, recovery/rebalancing of which is known to block
PUT ops for longer duration of times ( ~ couple of hours). We are
working to address this issue separately also.

* GETs are blocked when rgw data pool (which is front-ended by a
writeback cache tier on a different crush root) is degraded.

There could be other such scenarios too.

Proposed Approach
---------------------------
The proposal here is to separate read and write resources in terms of
threads in civetweb and rados handles in rgw which would help to limit
the blast radius and reduce the impact of any outage that may happen.

* civetweb : currently in civetweb, there is a common pool of worker
threads which consume sockets from a queue to process. In case of
blocked requests in ceph, the queue becomes full and civetweb master
thread is stuck in a loop waiting for the queue to become empty [1]
and is unable to process any more requests.

The proposal is to introduce 2 additional queues, a read connection
queue and a write connection queue along with a dispatcher thread
which picks sockets from the socket queue and puts them to one of
these queues based on the type of the op. In case, a queue is full,
the dispatcher thread would return a 503 instead of waiting for that
queue to be empty again.

This is supposed to limit failures and thus improve the availability
of the clusters.

The ideas described above are presented in the form of a PR here :
https://github.com/ceph/civetweb/pull/21

* rgw : while the proposed changes in civetweb should give major
returns, next level of optimisations can be done in rgw, where the
rados handles can be separated again based on the type of op, so that
civetweb worker threads dont end up contending on rados handles.

Would love to hear suggestions, opinions and feedback from the community.

PS : Due to lack of a proper branch which keeps track of latest branch
of civetweb and as per the suggestions received from the irc channel,
the PR is raised against wip-listen4 branch of civetweb.

1. https://github.com/ceph/civetweb/blob/wip-listen4/src/civetweb.c#L12558

Thanks
Abhishek Varshney
