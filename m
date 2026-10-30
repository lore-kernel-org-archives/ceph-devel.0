Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401830;
	b=1nK3QhD0jf5e0dE7E2q0t+c9Uj+ozasmwJs8HKV7AG+Fe1PaxHZQdDlVqogdWmfZa8Hq
	 jIEpjdK7Xg2P22+0cf36TcGbmiZwdDx9GDixaXFLqPX7vNrQT680zkTqena9CVd9nWqtr
	 a0qtpI/UANwYeOHwFGhPhMw0Ll5e6qsti0/K3mMX332/6R01Sv4Hyv/068Em1Xyr77v26
	 bh+xva/v4TQUo8vOpKBRy4AwR56pytFxCBVzOAdGdx52XvwETNCO0nrHriniegYsQvwdh
	 icpEiNsAhM9snD8OJ3m4gk+NPJO0QhK9nE7jsw8k9Y/L6F6mdn4YQs9tf/xJTqWyVbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401830;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=Nu1qYdfUglxxaOl3sv/a5XvkfRAaNcveQm32/o6/7qQ=;
	b=eSGZwK/TCEWzucggOOXfHEfVXSEV+WBTccmiqUmAXo9augNsDUEH21GSNC/7IAm9yI2r
	 yB8zYxn5j20jS9FoofqxsJcQYHkhFBkSznXZloFSfU28Rh/gbAPhHDj4rBJ8LTtImuIKu
	 HqwEWxD5e3c9m7w06i20eOytS5dPEzouj+yOMZ6BcRQJmyKbFL9M+t0zvfwkjEJp6+Sln
	 kobZf8bzMLR1yj5mXxnCBrZhpq8V1F4PQxVRCq3BjMJ2F8IrEpFOvmsKZMM/h/b0NvhTa
	 B7os6+EGWagA5tUY5X/JdE7DpkMxGJpo+SDfhe865y8THYja3gHowOALh5LganZv/pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqZQVkVO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33026606A323;
	Fri, 30 Oct 2026 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kqZQVkVO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6931F00A1A;
	Fri, 30 Oct 2026 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793401830;
	bh=Nu1qYdfUglxxaOl3sv/a5XvkfRAaNcveQm32/o6/7qQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=kqZQVkVO71TzoVOB1MlLgAbOJXQwYVjO1Y617G51AGzX+xx0/eFeMll0z2BbtjEj1
	 /LpvDR0+C5n3yHoIl+3PaqKxee5vqSk12+XiR8e3Ue3x1Lev7PnG+P2zg8TGYXkuMo
	 +aVMNtIilwvdz3KKj7HJ+HGqtMKLE6Fv0SOwx6gzmPg4riqrN20MFqDg/6/RHJSTZV
	 SSLKRwPyoO2eGbjJ7suGJ/R0THcA4V80NMTR9ieZbiPrYwafTxasWca2HflwwAVKFM
	 D3YNPucBtKeEJKEJR9BADLkM1/AHwthAWyBDl05YHF12GUKrFrcI+Otm7jMVSqqERX
	 +9nU4c6S4jqHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 031393800478;
	Fri, 30 Oct 2026 23:10:30 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph updates for 7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261030181734.3806816-1-idryomov@gmail.com>
References: <20261030181734.3806816-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261030181734.3806816-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-7.4-rc1
X-PR-Tracked-Commit-Id: 823d21c78453fcdf58dbd8ecefbb41f4f3eb6540
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fe8e62f432f0a7a0292a328a73c6912b9a2b73b
Message-Id: <179340182957.1820250.9168968253349959140.pr-tracker-bot@kernel.org>
Date: Fri, 30 Oct 2026 23:10:29 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 30 Oct 2026 19:17:28 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fe8e62f432f0a7a0292a328a73c6912b9a2b73b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
