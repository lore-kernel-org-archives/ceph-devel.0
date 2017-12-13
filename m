From: Sage Weil <sweil@redhat.com>
Subject: seastar starting points
Date: Wed, 13 Dec 2017 16:34:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752811AbdLMQe2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 13 Dec 2017 11:34:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B19C649007
        for <ceph-devel@vger.kernel.org>; Wed, 13 Dec 2017 16:34:28 +0000 (UTC)
Received: from ovpn-112-42.rdu2.redhat.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 681357D91A
        for <ceph-devel@vger.kernel.org>; Wed, 13 Dec 2017 16:34:28 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We had a great chat yesterday with Avi Kivity @ Scylla about seastar in 
ceph, and were talking about where to start...  One candidate was to carve 
off the entire messenger and reimplement using seastar futures/promises.

Another thought that is somewhat trivial but probably necessary and 
smallish is the log/ framework.  This might be a good test case for the 
legacy <-> seastar communications infrastructure.  It's all one-way, which 
simplifies things a bit, and the implementation should be pretty 
straightforward?

I know we can't rely on the current debug stuff for 
tracing/instrumentation, but I don't think teh need for a debug log is 
going to go away.

Another question is how the logger/perfcounters will need to change in a 
seastar world.

sage

