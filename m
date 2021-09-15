Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0761C433EF
	for <ceph-devel@archiver.kernel.org>; Wed, 15 Sep 2021 13:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE12961242
	for <ceph-devel@archiver.kernel.org>; Wed, 15 Sep 2021 13:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhION2S (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhION2R (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:28:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10BDC61209;
        Wed, 15 Sep 2021 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631712418;
        bh=0/0yOJZ3LFKYnbsywbDFs/TJqgbYqsuaNIsyOUZivlU=;
        h=From:To:Cc:Subject:Date:From;
        b=mR9QfPPBnXkXZj6OIgy+1KzJuaNExJWVIWBhau2j1WWPcuitgTHPTbn4Jp10Qsu9M
         bt1UnK+3jEqJITD2LFXNEzGx5xOc4rpfezcDP+DX/trz8NIFAtvbHZv+t8rxTAOe6s
         w8Y7PplPrurS+UPoPsXusauWo23ITuvYPkQjJ63VYqFvIWgxfnEtVrZA1x5Hi7P7fo
         3clcTain0V0kFZq4YLHBlTIpKtpLIoM61h9Dhr4CWS/w+tx1iBPQPHQwYSqGZxd/iQ
         sczhaS2JzJ4VjYXNNxFlN+DQGkoISEIX58K+eGUxytNc2nGcEUkkqdgq2IEaqdm7gV
         qybkRAg94hegA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, mnelson@redhat.com
Subject: [RFC PATCH 0/2] libceph: submit new messages under spinlock instead of mutex
Date:   Wed, 15 Sep 2021 09:26:54 -0400
Message-Id: <20210915132656.30347-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Several weeks ago, I was chatting with Mark Nelson and he mentioned that
his testing showed that the kclient would plateau out at a much lower
throughput than the hardware he was using was capable of.

While I don't have any details about the bottleneck he was hitting, I
noticed that libceph is heavily serialized on mutexes, the con->mutex,
in particular. This patchset is is an attempt to get the con->mutex out
of the outgoing message submission codepath.

In addition to potentially helping performance, this may also help to
close some potential races in the cephfs client. Right now, we have to
drop some spinlocks in order to send cap messages, but this may allow
us to avoid doing that.

My main concern with the set is whether this might open up some races
wrt changes to the con->state. I didn't hit any problems like that in
testing, but it's possibly an issue. We should be able to work around
that if it's a problem though, possibly by adding a new list_head to
stage submissions before adding them to the out_queue.

I've done some performance testing with the set, but the results were
inconclusive. I suspect my home test rig is hitting other bottlenecks
before con->mutex contention becomes an issue. It would be nice to do
some testing on a setup that allows for higher throughput to see if it
helps.

Comments and suggestions welcome...

Jeff Layton (2):
  libceph: defer clearing standby state to work function
  libceph: allow tasks to submit messages without taking con->mutex

 include/linux/ceph/messenger.h |  2 ++
 net/ceph/messenger.c           | 48 ++++++++++++++++++++--------------
 net/ceph/messenger_v1.c        | 35 +++++++++++++------------
 net/ceph/messenger_v2.c        |  5 ++++
 4 files changed, 54 insertions(+), 36 deletions(-)

-- 
2.31.1

