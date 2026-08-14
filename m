Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9C490C12;
	Fri, 14 Aug 2026 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729438; cv=none; b=b+dCRpQ9Co3zfeZp19T9swOmL/eOcES5+ZfVxFTN6pBxvYRy1db6QmvHfIhig01jYVBr9KVfI2liOIgN6IjW/gOb4TNedxTTlMdyfWnFnZ6N+3cuH+fcIFZ9sUlQsGBayj1vkwV/rwUa/gt1xLqQd2VJduZcrOJ+4FDxDn6tMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729438; c=relaxed/simple;
	bh=L+oFTl8pmbldfyTVBSJqcfZeT/j1FPcZe9uCwO0ptpc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t6aN76prpXOOYbkh3Z0AcY84Gvn5oikDCYtY6cYH3oiqgR1lyKSK6wZtHtkxnVVPWUMFyGzrk9rmZ5JWw5jrqReDklsYqOpiqZ0tIF2YKjviscXOMPo0KouLxfY/AWr7hGKUyKPvDIT86wVRnAPRP9mJlaTg6QwiXOSbeHGtlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqaqbcFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqaqbcFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3E61F000E9;
	Fri, 14 Aug 2026 17:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729437;
	bh=LoEJ4xyebmaOa5mM1lSFUqQ5W5F/KEtjmPvzt+uukcw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=CqaqbcFqv5kx9nVWbZXjOyBJ7m2ZyibB3IhD0gso2e+NBNXXOFtLcPZOijDd9sQnb
	 fGC8fyyOWtNN2S+Ta2hve9c2M9P3PMo4eAORg14LDRqL11yp797iARXfE2+mOMuzTn
	 5kNawPY1qjFWYJBNzS84ZsCOsm2c22mKErGoDK5g56K+BEN2/46YetTis+B4qxBmob
	 I+/40EsaS68EmfMM9bdSs8JRnTIPaao0cmydvV2Pjr6auWLLt1418YvOGuKx/apv2y
	 LWUoFdghjlGbgcJh7I4qEF1NtoCzLd/nCIgBeAj2Z/xcH6Nuo64BK079cmPT6kjrtz
	 UCM0HFO9RqyHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CD43924457;
	Fri, 14 Aug 2026 17:43:12 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 7.2-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260814171705.995932-1-idryomov@gmail.com>
References: <20260814171705.995932-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260814171705.995932-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-7.2-rc8
X-PR-Tracked-Commit-Id: 91880e4a7fac45bc407771bc57bbaf4f37e9b4c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5890ac6d55c3d13e2d17817fec6676941ef08ee
Message-Id: <178672939154.3893955.335236548945491471.pr-tracker-bot@kernel.org>
Date: Fri, 14 Aug 2026 17:43:11 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 19:17:02 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-7.2-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5890ac6d55c3d13e2d17817fec6676941ef08ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
