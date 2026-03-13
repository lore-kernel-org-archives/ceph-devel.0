Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C3381B13;
	Fri, 13 Mar 2026 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436052; cv=none; b=Nvjf9c8TgN29JzKk6B2Pnhy2kL6f5noE5to1KEQhSju5W3RdKtV4kox+P+KbfjtxlhP21JdlEnaAkiiHCyiyWJFPDYDwdBfqtK9v+rOW2FNhgYVJnMusE6MTv/qC9xCNjJsMwVVKqsdqTluBzHldfc4zb68V6T0v60PTEt3EKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436052; c=relaxed/simple;
	bh=SlFj1W+KC4wzNwaZ8L/g9Fe+Sk1yCyeh2JhUAq9W/ac=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TCEXby5JsMFw31OyyAlCw4WxSoY7MA1GscPVGlYpKGRT/UHLVeWlLhj2Bazdap1+ALjkH/yPwDL01Kz5MgMCKBUYKAFMNanhyS0zTTlD8ZSFY8IJ7HrqBl//nEl7wRpa0t/0IaT44RnKgJ2JN/dGAP7FKvSVrJZp/+rwaPu5hNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzruf/Qh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzruf/Qh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33E6C19421;
	Fri, 13 Mar 2026 21:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773436051;
	bh=SlFj1W+KC4wzNwaZ8L/g9Fe+Sk1yCyeh2JhUAq9W/ac=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rzruf/QhGBHJtEW5qR3MQ8SPfBkAbWysbI1DKrh9KttFYP7KxNPcODNAfqMrwfOIF
	 g4KXY65W9wEruBpmU5b8PJJNv6H6gUC6c2FHCkKsdAWKoGAG4lQNd28rxpAifq11Jy
	 AIfQBSUbKZXWhn21kGIRnq3S2np0uKdhTTifpyGtCt+nJLuQXb1QoIgzIAsLMXuXPx
	 p4oiFQgtzzPyZxo3EhW1KRaGHH4RQyICGK1FgDELIIKcLnq/cptxMdstFymoM3V7QD
	 iAbOhYPp5g09PRrCaRysucL4Lb1JfxVMienyrjup7Iw/Dwar8bCimVmd5w1klsJa/G
	 CseuOEpiyJ69g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1E83808200;
	Fri, 13 Mar 2026 21:07:27 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 7.0-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260313191403.1075765-1-idryomov@gmail.com>
References: <20260313191403.1075765-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260313191403.1075765-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-7.0-rc4
X-PR-Tracked-Commit-Id: b282c43ed156ae15ea76748fc15cd5c39dc9ab72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c361c9b7f452cf5331fe0d1230ab23c374a1fd2
Message-Id: <177343604634.1505832.4273315072474584033.pr-tracker-bot@kernel.org>
Date: Fri, 13 Mar 2026 21:07:26 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Mar 2026 20:14:02 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-7.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c361c9b7f452cf5331fe0d1230ab23c374a1fd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
