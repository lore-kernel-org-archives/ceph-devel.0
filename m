Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBE9C433EF
	for <ceph-devel@archiver.kernel.org>; Thu,  2 Jun 2022 16:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiFBQHm (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 2 Jun 2022 12:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbiFBQHk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2022 12:07:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70557186281;
        Thu,  2 Jun 2022 09:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30169B81F1B;
        Thu,  2 Jun 2022 16:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED8CFC385A5;
        Thu,  2 Jun 2022 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654186057;
        bh=Rfi9j9iq4aaItGwa6XxM8mshUCfQ4E9dD4W3IZTyS/U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NuTzNpnEhxkMxFxl+qabmKlYx+payz30wQxHNWkSFZSJwDUYgeHVD7yhPiNnpXF0n
         +PZsUg4TLhMXtv82YEno3mUM6sU02iWcv5Rlagjr57iyk3TISlIrI4HzBXqkuRx9VS
         2OskCWBvRdHry07SkPeUsAL2aBxKU6DT3lR75acO83Owqdh1lHCDseP6RN36fgvsrg
         fqMiCKWGhh58ii7x7ktfZQjIYwaawbfPdPd4bmI/ypBFAJIqO/R7hKnuvDDNN+hZFM
         wXojv5J7sUjWkrgXu6BLRbl5MDIqBIAVfQTuwdDwG7+8Byo2oapvUJX394vY2bH0YR
         Lmw32G++b6HVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9830F0394E;
        Thu,  2 Jun 2022 16:07:36 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph updates for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220602131131.22117-1-idryomov@gmail.com>
References: <20220602131131.22117-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220602131131.22117-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-5.19-rc1
X-PR-Tracked-Commit-Id: af7dc8e5124daf017ebc85c8ea97212e1e2e62fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17d8e3d90b6989419806c1926b894d7d7483a25b
Message-Id: <165418605687.19639.4907674841426703948.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Jun 2022 16:07:36 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The pull request you sent on Thu,  2 Jun 2022 15:11:31 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17d8e3d90b6989419806c1926b894d7d7483a25b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
