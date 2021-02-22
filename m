Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A67C433E9
	for <ceph-devel@archiver.kernel.org>; Mon, 22 Feb 2021 21:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E1364E25
	for <ceph-devel@archiver.kernel.org>; Mon, 22 Feb 2021 21:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhBVVhM (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 22 Feb 2021 16:37:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232042AbhBVVgn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:36:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8D50364DFD;
        Mon, 22 Feb 2021 21:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614029719;
        bh=Z24T9u9/rfG0KTMBK35qAWmxZtMFnTwyDEEyYgFmPxQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uIyZE0JUJUui3M3CEOQsH+mRNKEAkfpzrHJ9QrD38n04cX8kq7sRqQvG97/Cq1dMs
         bKmf+NSfR1oRqlS1k24HM2HBONuCzPo9ZoPuIAPYkYmqZ1swIpbLv6irZ6oEwO/BtE
         7CzLzuichTcWmRjD5sIz/+/jMZh80SPYFCCQKlIPjvjSAPnWxKA1G68alDpIIQlIsj
         dz5LxsjHrELzUNrVo8OZkDi2beB8E9qbwV4Ui2BAaFbTQT/GnnGw1vZovqgBeMmHj/
         1mxwxpIQiRu+Q3EBXFhFy1FqZQh1iUaJXd6skYCYMh206d5Iu6aiTBrUHMIdHtM8QT
         mbtkl3li5GJlA==
Subject: Re: [GIT PULL] Ceph updates for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210222142107.20046-1-idryomov@gmail.com>
References: <20210222142107.20046-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210222142107.20046-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.12-rc1
X-PR-Tracked-Commit-Id: 558b4510f622a3d96cf9d95050a04e7793d343c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20bf195e9391195925dac4a50e4c2c8165c1b9c5
Message-Id: <161402971955.2768.11975227127596571143.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 21:35:19 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 15:21:07 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20bf195e9391195925dac4a50e4c2c8165c1b9c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
