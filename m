Return-Path: <SRS0=UwT+=CG=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA38C433E6
	for <ceph-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B0120825
	for <ceph-devel@archiver.kernel.org>; Fri, 28 Aug 2020 19:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598644717;
	bh=pLb6YgNF7r3bbleGDfeo95EUv/ZD6PP1am1Rc1qaHEw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jMLMOC+MAAkuVeVc2oOtx+8EL4yJnzAZ8c+WtO6CB3CRjarmY4HyE9AHvuuv+S5Lo
	 il07XIntZbfAOvwA8iULDdgN87S+EqlOxon3v6+9Ok7V3hqVC4at0QdmkJ16LHJZ7j
	 zrD7wyoEKeo04FRlR50uhqZ8+u64XqzsP2DJqrNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgH1T6f (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgH1T61 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:58:27 -0400
Subject: Re: [GIT PULL] Ceph fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598644706;
        bh=pLb6YgNF7r3bbleGDfeo95EUv/ZD6PP1am1Rc1qaHEw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WNvieWsCHkjhFMxOAq++arN8DhylzssYhW26Fj96bVvW26MLd245Oz5UK02GI6/3Q
         zKRoP9cnjWUoT7IjZFzj235T+B1sZ6DavFmGS76K3wgwL2X90vI+xq4+dcfKSWTKgP
         DjY9dGLd6gE69OGLrJDNvuhRHNsi5wTDDTKZxETo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200828122000.1422-1-idryomov@gmail.com>
References: <20200828122000.1422-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200828122000.1422-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.9-rc3
X-PR-Tracked-Commit-Id: 496ceaf12432b3d136dcdec48424312e71359ea7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0bfd5eca956c498b8f9c7ec4a25f355f793f24e
Message-Id: <159864470692.31636.7304735457148606684.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Aug 2020 19:58:26 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Fri, 28 Aug 2020 14:20:00 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0bfd5eca956c498b8f9c7ec4a25f355f793f24e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
