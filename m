Return-Path: <SRS0=co+E=BW=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC4AC433E0
	for <ceph-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1312080C
	for <ceph-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597262316;
	bh=/7Bk9fuqzAFYs/VR5uZFZG+3sjnlPtCH4x3J5AJMndg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rkYnuYAM1s3r3qr3bimSu1dfw6oWinOuUh/3nyGEKrsJG5hRJcdZT8MUhfVGEcd3u
	 uB41KH17faPiUDsVlRu3SoDHYbnpuG+w6r1i7die9vwfveMZCspbSk7+ohVhktRHJn
	 SnmrydZwoaORsPb7LTzOeLVQEMtkv35vS/r1L/hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgHLT6f (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgHLT6e (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:58:34 -0400
Subject: Re: [GIT PULL] Ceph updates for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597262314;
        bh=/7Bk9fuqzAFYs/VR5uZFZG+3sjnlPtCH4x3J5AJMndg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dIdPEdCcXfFdom4H9mF1jwahOIYVoeQpDTKQ63YHyfEo+cQjzykizIXCxDhNeEy2k
         wcMSMKVeC24UA0JKB0mMxxMfLu1aX0SxY8wHrIkyvLM9SR1C3PA5nPBF0g7wyvNb+p
         dGeCg48DFxMSsrlTPKuqvnG4PQneVa1fbtP37JPA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200812171949.2882-1-idryomov@gmail.com>
References: <20200812171949.2882-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200812171949.2882-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.9-rc1
X-PR-Tracked-Commit-Id: 02e37571f9e79022498fd0525c073b07e9d9ac69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c2a69f610e64c8dec6a06a66e721f4ce1dd783a
Message-Id: <159726231395.30367.6401621092754472790.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Aug 2020 19:58:33 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Wed, 12 Aug 2020 19:19:49 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c2a69f610e64c8dec6a06a66e721f4ce1dd783a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
