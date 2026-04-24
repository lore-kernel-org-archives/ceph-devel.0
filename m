Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C03FBECB;
	Fri, 24 Apr 2026 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063931; cv=none; b=FoZ0GdhzOlGgvtTROI4D1LFdc0TLHzHdXIV/ctnk5p8J8uHJOw3aeHLo4wc+xaYqGvcogCxsDWxqv/n+juZGrFO2Atbyk1Q/g3WJ9GTgO6NJ0PL8/et6XjaOhM7N+EOBikT1df+KLbe1ZKEerbdgYyypA3EHseGMNXzOJsKHOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063931; c=relaxed/simple;
	bh=htl+jRKEG24wjAJOXuqY0JtG6Mceg6O+IQGXXDGn6ok=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=twOxFhMo7MLKZn4N3F33MHVbZINT+i/NgHrw0f3rVG16ikmkYx9EiYXdXi6V+j1tsjLDy7nWXZoFSvQ1H+kkFHnybkmekT9C2eJKdjNwNB/uvnLThv44/gr9ATTCtr3iSB4li+e859rItYx1CANKMVzZLghCX9EOK31b3YKG3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgX+z18x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgX+z18x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C717C19425;
	Fri, 24 Apr 2026 20:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063931;
	bh=htl+jRKEG24wjAJOXuqY0JtG6Mceg6O+IQGXXDGn6ok=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KgX+z18xczQDTGMpYq4uoYrkXs+kz216/zfXrRCk9Qs++kceBu8y6xS3hsiikhdrF
	 JrOogJkFJVD5nyLXGwpUnucOHM1zbHWfE5QHIypUNMDQ1jT/UbrhameAxTbdnSRY2e
	 u6e3bKJoQlqHQ/1VhGhsbWW51IAfnW0CcrAD06T/MpYF0uAqNcklUih48rrdL3VS/3
	 PBLBNL1E9m4u+5xv5Gk35PPiiYu7Ov4g7hY/wed4M+DqYCK6GoO1tpZUVApwJICjfG
	 c3Q0AEq4yEq9CS/gdlnSEZZo3mSFHxf2QN+MKhmdEoz4gNzZyzmIIosIu4bUmcwV/b
	 Czto5kWE9PHow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DD738119C3;
	Fri, 24 Apr 2026 20:51:33 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph updates for 7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260424175320.279295-1-idryomov@gmail.com>
References: <20260424175320.279295-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260424175320.279295-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-7.1-rc1
X-PR-Tracked-Commit-Id: b1137e0b3d4bad1cad73fa9bac763c74ddd1813d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac2dc6d57425ffa9629941d7c9d7c0e51082cb5a
Message-Id: <177706389150.1712010.7094257860540352712.pr-tracker-bot@kernel.org>
Date: Fri, 24 Apr 2026 20:51:31 +0000
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Apr 2026 19:53:19 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac2dc6d57425ffa9629941d7c9d7c0e51082cb5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
