Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCEA13A3ED;
	Fri, 26 Jun 2026 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782517149; cv=none; b=Zt1+n5qAuEkdAziYq0XPdA3pHTDKmd5Xuw/k7bp1b0yHCJ4AQ+1TQcME1SgrJpQdsowTRhvnz/TeQpJ/pCknSPg0IIBdzL1lBVgxyyKnq22FgH4CEvHds624oEC495/pDKb04BQbkNus2sCRmJOBLoaMcYIyFNKO1pYu8+iYREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782517149; c=relaxed/simple;
	bh=JhaoGfgdhpvdf9WG1LWzW7uOl3wjiywGKRnnKPXCcn4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XfSQHQIpXCg6hsl4FghTdfdmZuiu9Ytg9BgWI7dKiWaHXYfMv0X5kAbjYMLWRiJt0srnUTfa0P7oR0DYkn+RHMur0k6a/TuN8leMaL8sxHMqKdAcfXwSLFZBJ14gRl9DWRG0pB4i5dMXJzIh8HWZXmsXtk5KiRL8JFySTFREVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrtAt/eD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrtAt/eD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5515A1F000E9;
	Fri, 26 Jun 2026 23:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782517148;
	bh=t8BF3HXdP8SR4w1U7icyBoiKZRBn45qLVEhMiDY77W8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=YrtAt/eD+x5sWO8rUiTeDfY49+qhgUUgWHBIZsgA0i6St+YCA52WpAaZnpm5WCeE8
	 C7FDpNg4Oanzj/wEnTVl7nA8ziJvNQNgMNmyOGg4ewZhP+8gv4crPQRj5dxr8yQmm0
	 umDrRYaQz1KW+QuPt8KzZW18rYdPUUcNfxEoQuU/Qzq4a2HYgjpP9KQ02IaYMMHh7D
	 UETvjBReHjiK6yF/ltW6LG4a7CFD1zG8tSTbg5c7Qx+NKCh8FwVe/NDFCzUdtmiHa1
	 pHLYyVWIvAN2MDtJd7XBehJ2odpnpFRWEJye9FrAutP/SnJdmW37xQhTd5dwEm4tKm
	 P6LkCei72vO0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19C1E3938C71;
	Fri, 26 Jun 2026 23:38:56 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph updates for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260626165429.2673444-1-idryomov@gmail.com>
References: <20260626165429.2673444-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260626165429.2673444-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-7.2-rc1
X-PR-Tracked-Commit-Id: 7e1f9e2cd2d0e780c394a4402c40e125109fec72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5422e496b313b9b0b2f6df068902d6c79925d5e9
Message-Id: <178251713457.1134171.3414319744452309174.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jun 2026 23:38:54 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jun 2026 18:54:28 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5422e496b313b9b0b2f6df068902d6c79925d5e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
