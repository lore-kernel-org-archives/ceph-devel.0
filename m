Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A53246E8;
	Fri, 28 Aug 2026 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787946661; cv=none; b=bzuOJ8oEWg08GCPPDt1uqVgZ/SDsPb/anLVPQDfKSYRWJpfmlm+KC1s1qPuP3kzX4t7/Q14EIumixB6nXrvcX4AhLTNc7+lMsNiqeLB2NPQxVpXvch00YnAWaZyTO8qOHhZaEN5jxL6fzFqGKh14seDHKzP4+IO1rXZBFDgXOJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787946661; c=relaxed/simple;
	bh=z20JNJNj1z5tFMlLVR5HMitqmX7m+ysOrzx+dMXY/n8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U/Zi3ZHnewGP9r6LHKIcvPEBrZt+HeQyqlVxSbW2OeHrrJYTMKFNeGBzwprTOkLZKmdHvrGvP6Dnr6sPoNV7RUO6RI2T/CC9xUrbrMyDeCOKCcCsUivEx0MXkLMGKdNFoZEVnrhEuz2nwoOKlQF/Q+j+TiUBfJwtEffQ6qqSDEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lE/AGcvy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE/AGcvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A371F000E9;
	Fri, 28 Aug 2026 19:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787946660;
	bh=alDadVQtcA7qipLVl3EdwlUwIf8hFMs7YVt0GOMAQw4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=lE/AGcvy7+AizgcezQdHQhUBeueXYHXr3g6lLR5ebb52WQd6lFgyhD7FqF24bCeWg
	 3XQUy0y241FgH7YpqnNjDJggwrEsVHM5ZsAAL0rVj8qGZFIjB8kQGnf/0Mvxvc93IW
	 kGaftrAUmIr2S1t+YwSA0z5jzhOrpwpCm13z6mtCcN+m5XV1Lo2bm6/G5FlECX1esY
	 SXRGZHi+Np3GY/yxiiCnY639dp28ZdI8zSR18dOWOrDLFpi6KH6JUWO12tgM08ATSU
	 vRJEPf+cD/Z8L3Tt3ABpzX0AU8nDJVwRa6MO+zlWAUFVYYtrWplCWti5X/14uyLVzQ
	 8zLP1Xh8ZjW4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56900380AA69;
	Fri, 28 Aug 2026 19:50:06 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260828182122.1668032-1-idryomov@gmail.com>
References: <20260828182122.1668032-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260828182122.1668032-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-7.3-rc1
X-PR-Tracked-Commit-Id: 8fdf946445732c2bcd685abc8bd0e509d2ebc158
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 548e7bcd0c5460ddcbca9600cea603ebeebf4da7
Message-Id: <178794660481.2763027.3381236812906388840.pr-tracker-bot@kernel.org>
Date: Fri, 28 Aug 2026 19:50:04 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Aug 2026 20:21:20 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/548e7bcd0c5460ddcbca9600cea603ebeebf4da7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
