Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AD537AA8B;
	Tue, 17 Feb 2026 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771372253; cv=none; b=b2dLTd++pDnMsnd52LW3jRhmmDzt75A1INyBta2TMDlEmTRS5e3Qf/sAiWBIkTet6C6x9lWNzOhlqywqe3IHD39WQ3rmLg8k5br/9nftuKVYCiVUpEhVmuMo5zzB+JU1DlzLxhXJpdndl8Y/PnbrleEfLwqmd6hIVuuGtwPsfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771372253; c=relaxed/simple;
	bh=oVG8hh+Gus5uL+lz8iR1fcdgRuppE0reTg/zTYsAyZQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HVfmSZ2oitzHP62E0GL7CwFWgyzLtpDXAzKy+BKXQCMOOsWYh/zZX3E9/4xlatcGnfBN2oHzSFKB4+ZD5+WnR+tZhxfauTQtnraJcGBtxUmHwPT1GHHkvO9tEGcg+3ef1+vzLFezyzee4JIkHeMQrcXfLG3UF2KaPwZySpAOs2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVd32Uw8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVd32Uw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5066C19423;
	Tue, 17 Feb 2026 23:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771372253;
	bh=oVG8hh+Gus5uL+lz8iR1fcdgRuppE0reTg/zTYsAyZQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IVd32Uw8jEnm0BztA1f90kS4QNCOX+QoVZX+bKBdzvEZhDJPaXM9HO1EDM+hBbWcX
	 F/H7yiRgUXE2gR3oadkBvqgqn7qfhBCnucZzdAv3rQRYkR2MzZQoAbbmYlCSg/CHGK
	 zQrjkv5nA66RXXVUll4ymCbrQ9jCSIx8dUJVYqTGvmazutsISDtgfXgbpoKhc5XL0Y
	 PaLtEvWxt8S8iBVPOuGKrTPyeSB6r/yrUgJZ16v6ErwHz3MDJuWHdb1BOIRUY5lZV4
	 /i7TieFy3DmTqPqxq1uCov4LKJQ5UffvZLowrLt9imS0KMJKJDi7ebs+9cDraCnz/I
	 KaxPNVQVY5lug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADA3E380AAF9;
	Tue, 17 Feb 2026 23:50:46 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph updates for 7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260217173743.1840319-1-idryomov@gmail.com>
References: <20260217173743.1840319-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260217173743.1840319-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-7.0-rc1
X-PR-Tracked-Commit-Id: cfdde144ae455b8612a756fe7419d57c9b7833c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87a367f1bffadf1db5def15bd0cd2148acd057ad
Message-Id: <177137224544.738845.3694865717084205762.pr-tracker-bot@kernel.org>
Date: Tue, 17 Feb 2026 23:50:45 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 17 Feb 2026 18:37:40 +0100:

> https://github.com/ceph/ceph-client.git tags/ceph-for-7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87a367f1bffadf1db5def15bd0cd2148acd057ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
