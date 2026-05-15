Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4C30E82D;
	Fri, 15 May 2026 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883237; cv=none; b=JxYbH3vigZdkVsNes6iiV4KiO//0eVetseNwpOjZXDLg+/AbgqummirWMwWQ1KTsJezcFnyxxLyl9MGGc0FWnFXh91QoPoUfOzqtDPpee9q2NFIkXoNRl7JlUMTqPm+3eEauZUWyW+u6yc2cq5PhR/jbp6lQensNyL1bnvd6f9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883237; c=relaxed/simple;
	bh=O/0JEwDeRsZzp7V7Bz4PL0G1pT0M56PxJYZ64rmUfPM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sq8dJU8zVkvblfYTfTztw55PE5lcAQjaUgPVRSNKSLOp5ZGKRTkq8lulQhT3zFzmaBXT7hpbgipN18PjaiJsBx3mxa9EIb4E4xL6SOO5J9JcL/I9U2TEk7wLyF/swEgDoFDb1opNtl/M9AIrDiasN50vqBcRC4yoNiDghpe6eRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaPX12Hz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaPX12Hz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19999C2BCB0;
	Fri, 15 May 2026 22:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778883237;
	bh=O/0JEwDeRsZzp7V7Bz4PL0G1pT0M56PxJYZ64rmUfPM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CaPX12HzUS4rAYVFrU6mw2jWcXyEs5yQFU6wS3RbmgOAyWDJRfVBfIfpAGtXCUzlq
	 cdzhvPnzv2JaN4uSp9Pj8wzIxipD1I/zACiRe4j9/07vxguT4YU+i0BWnRtjeMlCTg
	 CBA2oK1lZNPQC2sKUyeOagnIISLf1nRfZ/iDF/DavtF2rPQxIIGyuCUqhT3hbB4kcV
	 /jqVpZM9mnqn9nTL1TA1UyFsYv/SCm75sfiIhzvOLovULaN4VRbbThF49K1TtCCWDK
	 IlUhnqoQE4U2pPo7KuZcMsMgLPv9E/+fkvuZH9oFG52WWjf1wqTXWS1qs0MmHCD2N/
	 5y/XrvjCpwSaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C1D3930A12;
	Fri, 15 May 2026 22:14:11 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 7.1-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260515173702.1273592-1-idryomov@gmail.com>
References: <20260515173702.1273592-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260515173702.1273592-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-7.1-rc4
X-PR-Tracked-Commit-Id: 28b0a2ab8c82d0bbdeb8013029c67c978ce6e4bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcbf68d32ff732b78122690e862d260b000e19e2
Message-Id: <177888325029.173168.146786177745649321.pr-tracker-bot@kernel.org>
Date: Fri, 15 May 2026 22:14:10 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 May 2026 19:36:46 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-7.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcbf68d32ff732b78122690e862d260b000e19e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
