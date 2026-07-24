Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4D3264DF;
	Fri, 24 Jul 2026 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927070; cv=none; b=PCVG3cMa0moHfekcz6HPj6aCTYMm4mWa0LQQRCjboWJ7+Uvt4iRgyKBvKt7vWJWyJSIa4GNWmHgpCbNZILOy9kx0xxZ9/c9xigvunrZ5CHHfO5c/oLKiG40ibQaJOVUh/4O8epywzVG7SkcKqUpw25wPnIrDtM3WuXpj5kkcCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927070; c=relaxed/simple;
	bh=lGT4dPXODBXon54Hgq7RD1QPVdAiVUyX7CZ8Vvz60jk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dXqJpBI1KLNFJCcKB4rkUg4yXSk+bdWfAOpw0gLhyi7Gm1C7+w17xUVcfjt312P3HqMIMtXfcyVxyk9ZV/8gXFk2fVXgV7dPo8jbyqWfms+BsqcC1DT8ZoBqSAPJnNextAvQhdeyEAA7UmQd2aag1a81HD+Cq4ZHqBHk7NndXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rbjqo6FK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rbjqo6FK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD2C1F000E9;
	Fri, 24 Jul 2026 21:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784927068;
	bh=aiZBPnqUs7dsq9olpM8nXq9Sx0xFGm4I6BC1dGE5+CQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Rbjqo6FKOlFkL1OeEWlv4hLytf0l1kGASZmpf34ev4LYkDVD9xCbMc7P9VGrQhfN7
	 LuufwbpqIk7AhuNxGVSUkMhwEAh2o6jKT6VxjtTG7Oth+PvHZigEXIz7+ABZh0pLsJ
	 jCPa89rCwiG+B3VggTwK3bngaqAs61wtUBvVr+r+s91Ar/DB7x+5dG9EnntsrHbRRG
	 qZ2S6O17u1WAnN3qKM5GsLHmmi0BAbIM7bJk9PmCJ+3YqfqwYygR4nCnFTUN9hXCv8
	 FxnONI56vXxV9+XfHho0epN0qJceUM84OWf5h4sjpmJXwpnInaFU1USrbLGq7nSAM+
	 L85ip4NdO5S9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198D838111D2;
	Fri, 24 Jul 2026 21:03:57 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 7.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260724202014.1168527-1-idryomov@gmail.com>
References: <20260724202014.1168527-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260724202014.1168527-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-7.2-rc5
X-PR-Tracked-Commit-Id: 5b602344a49e039e792ce5a8923bcc61412ee134
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dad0a87d79ff3e7e4ef35ebd588fe4f115329964
Message-Id: <178492703559.3306475.3889917045439384667.pr-tracker-bot@kernel.org>
Date: Fri, 24 Jul 2026 21:03:55 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Jul 2026 22:20:13 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-7.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dad0a87d79ff3e7e4ef35ebd588fe4f115329964

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
