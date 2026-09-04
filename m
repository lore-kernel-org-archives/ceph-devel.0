Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6752ED35;
	Fri,  4 Sep 2026 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788555693; cv=none; b=Lr7+ZIzOv7jEvktMns2eWQYT15VtcNPjFeXYIr4aaO8UCdLzpDgf58FKK2c+WghIAfFIKENhpDWM7lfs3/Fdo7Kvunqh2xuOVX1cB3b7Oq+cCgAKEnoO82UpfjQeOEwaJNTqo6PjAl21K7M77R+Ac0k4O86lapqpt5v4Qb5JydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788555693; c=relaxed/simple;
	bh=NUseQjNKXmk8J0qqEblObranqSGPlkupH6lC7peoaUE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PuwPbpX8nh+pD3x2uvdIb2/AJ3BWvKHItWTL4LeRr5GLecVsOpMuQFpnwSbX4X75DWiiSTAJJhS00Kl0ptbzfs8o2E2KnJwRudKlUMoY1RqLRz/AxqkKohD40wp8oIQNip+LEAlOWEXYzEcQ4uQrmN1m6LT6l4MerWFLerzj85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl8CXHf1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl8CXHf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8423F1F0155C;
	Fri,  4 Sep 2026 21:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788555686;
	bh=9KGEhtpTf14Adre3bC+3LPwIIpoOF8E6xhBnoE7NNmM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Fl8CXHf1txHmeCJIu2RI7/2qVLpwwOYUjZjgBSfPD3O0vWsdfah/EYRrDQU5X5i0N
	 fbii99zB2uwI1b+bXpy3LzRKmKs6hckQgoEh6zM8M08Oygy38jwwDWxbIjz8jjb/P6
	 B8KKNttqkamxt3PMUJM2P+gR/FHbB2T669ze+fP6n84C72BwxRWXS/ErPe6dQN/XaF
	 eQ/jUaq2xZftyxU4KbzrPXCj2UEvuX6fe4AgNvqvWfmkuUuo4RCepEqreRoti/g18f
	 3zQxWe3mde5+Nr94wwpI6jHzFqFGf71ZXzzugyKv/0zFNAZicUIf49Ll0FVW7VueL6
	 xU1fNmw5ybjUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6C2DC3924A72;
	Fri,  4 Sep 2026 21:00:28 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260904172941.1970111-1-idryomov@gmail.com>
References: <20260904172941.1970111-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260904172941.1970111-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-7.3-rc2
X-PR-Tracked-Commit-Id: dc173b37415e8f738fc4de477490056b479ddc9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 408802f1e61dad400ed5d2504165579189cc183f
Message-Id: <178855562725.966019.1501042839317123714.pr-tracker-bot@kernel.org>
Date: Fri, 04 Sep 2026 21:00:27 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  4 Sep 2026 19:29:38 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-7.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/408802f1e61dad400ed5d2504165579189cc183f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
