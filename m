Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4358D3112A5;
	Fri,  6 Feb 2026 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770419398; cv=none; b=aacHRnlA3TmdiVef7nMc2GbfZdaXXj5aDPwt2lKK3IsVnqy9ateGCxKoxFi39ApdgXv1ZDB7koN22qeNCgcFlx8mV8Az8VRbIlff6cNNt0kJpLYrKwqRtzTyj4UR/WFn3upZs4QeaYYySI9KnQs2c4ynHzA/3VcN24+uc2y6EfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770419398; c=relaxed/simple;
	bh=1i3DMeZOrcU6VCJDLILaxQZbUBHe6g2iXUTywriIHxE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ffSo8S8FW5Flaz60aAft+Eh9d/QUaWLtlSaAipY5biXHVvSouHET4IOdKQn7U8pZ1kiaFOO+U7xgh9cLWSO2cJae+yQqTvC7A452GSszChr7iEuGaf0sMkwb93nfwZe3ew6B2mYQ3apDIgaD8QT0JLvADdYfJAhDGUpaxE3sjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2Qga4ke; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2Qga4ke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2727DC116C6;
	Fri,  6 Feb 2026 23:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770419398;
	bh=1i3DMeZOrcU6VCJDLILaxQZbUBHe6g2iXUTywriIHxE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U2Qga4keKQ8FsGM8iLb7mISYxBEuD61EtA02qM4M0hwHRq3XwutuWxAzGYgJzwePv
	 4d1iE8FktR1mpP+/Fs7vabUe4DfxYZ9CKP3AQZkX8bZGKaUUaNw9s9QD5Vkp0UYxbp
	 X/dVCC/8ion4UhJpF70lk4Hnna6fO1AK0IGN3MgTGKvdkmVfoid6m3z1I1qPTD3VZ4
	 Ft+jP5ZhzMEo7A5stwvZ/Bk3Zg7js50FBduO6V4fILQXWK34pBLuckoysspa0i2Rwh
	 uFVm54gNdmjsE5KT9Ju/ynHlarzuU/5GjZgUaHr/eFyNTHyiQrIH6SD1ZqZbBcbepi
	 HBxrUkhvNErUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 853903809A17;
	Fri,  6 Feb 2026 23:09:56 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.19-rc9
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260206154605.1369203-1-idryomov@gmail.com>
References: <20260206154605.1369203-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260206154605.1369203-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.19-rc9
X-PR-Tracked-Commit-Id: 7987cce375ac8ce98e170a77aa2399f2cf6eb99f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 240b8d8227468344e814c6bc7eb8ae532e3b8a09
Message-Id: <177041939517.1109628.4018189849494879307.pr-tracker-bot@kernel.org>
Date: Fri, 06 Feb 2026 23:09:55 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  6 Feb 2026 16:45:32 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.19-rc9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/240b8d8227468344e814c6bc7eb8ae532e3b8a09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
