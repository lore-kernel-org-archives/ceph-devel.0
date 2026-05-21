Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C218C327BFB;
	Thu, 21 May 2026 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779400398; cv=none; b=E5Ge4GJfjm2sNry1vPtZ532vThEo66yZX4E2ae6nbBwR9Ae7l+MLqhOSyhKf2MZv43o9znJTdn1lNY4aBfK2mtvsP/QosPui68BEgmDuOSNdcbquMiD87NUa99FvR6bC//m/mxW2dee/jn5Z0XjC4eMOP4lM7DX7UhXymceal6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779400398; c=relaxed/simple;
	bh=MgLY+jKOg5qjwC4VIbBDyHg8FaWqLlwij5xjBBmnswU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ROf3beNMAMhlT/vcJvQ4bvuAh0JWdRmGP49EBaxdDtEFdre267JgMJ0cbFpE7M4Q3WLvLhghrxe7al3n+KljvgXuVZM7nTrsG/TXJtkDq5gea8I9O+wH8iAUxpCbA4ymhzNZjH7PR3L/LaxtEFagusf9RdyAD/0TDCfooCKq+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeFaQvvi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeFaQvvi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98851F000E9;
	Thu, 21 May 2026 21:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779400397;
	bh=SVcyUnes7FkFA4lgAefftt9GAV8kE/hdicd7LuxtwZI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=QeFaQvviufcyiDupE8aRO5UGsodrw/zz9EJ/bZSXMVZflwgmWlFDXpus0PnYjLzBY
	 9HOwpo7NAhPg38kp4/76s6JCLqOTQQFRPg+nUouPpoBb+U4NwcOSieMRCwWRwdZ+Vm
	 5tTfwpJwgXZQJi/fptZYwxffdMkSEEa0q1TZ0qMqqdqTN3tDvTgBhHYDlYSOaDKWFP
	 tzo4h9ZMbOm3l3Fi/zpBugHNK22EMiDsOeaKAayJ0bHspDpR0hfz44neNX6oNUKrzQ
	 qAkGyJIzMh8Sd7lGuRjFsdz405q0vSeh0SntUkmZFH8dnGpJaNd7MSJ270j7/TIvGF
	 YzvsmvQBihN8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A53930E3C;
	Thu, 21 May 2026 21:53:28 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fix for 7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260521170235.1584548-1-idryomov@gmail.com>
References: <20260521170235.1584548-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260521170235.1584548-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-7.1-rc5
X-PR-Tracked-Commit-Id: 9fc75b71fdd38465c76c6f6a884cdd4ae3c72d90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d3b2673e1fd553395933b6f2bc88c9e9d2a2bc5
Message-Id: <177940040708.527128.1508668579847865931.pr-tracker-bot@kernel.org>
Date: Thu, 21 May 2026 21:53:27 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 May 2026 19:02:34 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-7.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d3b2673e1fd553395933b6f2bc88c9e9d2a2bc5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
