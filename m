Return-Path: <SRS0=9r1d=D4=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6789C388F9
	for <ceph-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C2D721D24
	for <ceph-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603305314;
	bh=6pfdDd9LUsr4MJJUdLQcKwdlYiWeJ4Wqw+YmASrGlGs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=z5Zc3sQ6ub5K6Xz8zRN4KsKP/ll3qu0cgbV+y3Id0528JSiT2Ufi5UiF+ucs1xa7E
	 uqDLCqKrePFnnUw6ybJrtrPEe8wwECkjJBTltA0awTUs2pazujGdXRPpsAs1QbS1dt
	 j2UxRrK4LPy7vpUTaus39NKpwuWy1RG29c5kLxSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504200AbgJUSfN (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392431AbgJUSfL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:35:11 -0400
Subject: Re: [GIT PULL] Ceph updates for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603305310;
        bh=6pfdDd9LUsr4MJJUdLQcKwdlYiWeJ4Wqw+YmASrGlGs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E6n1QIuLAwXuyAZ+rwxzqr8gvL2z0ZqG6r6zlFVGvGMxBB2KcROQ6Al/qPqpzMmtJ
         KJfIVzlBgNUkHxEKQf+zZUV4fllpJ/0utf71Mb82nsh6ALT0MstGdy09rJNwTaeZI9
         mGLDW4utJizs7T4A/4PYYO2fqzUHIDMzqYSKx3tg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201021133733.22298-1-idryomov@gmail.com>
References: <20201021133733.22298-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201021133733.22298-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.10-rc1
X-PR-Tracked-Commit-Id: 28e1581c3b4ea5f98530064a103c6217bedeea73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed7cfefe4443dcc811e84b345a3fb122eeb47661
Message-Id: <160330531052.16606.12386987392574797918.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Oct 2020 18:35:10 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Wed, 21 Oct 2020 15:37:33 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed7cfefe4443dcc811e84b345a3fb122eeb47661

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
