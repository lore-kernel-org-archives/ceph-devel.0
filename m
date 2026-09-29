Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428343D9020;
	Tue, 29 Sep 2026 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650499; cv=none; b=monbpmMQJ9cZZJmMyM8hcFp+ypKf/bEQ3bad4YlpmLIALnNJksZrJqOWzazRfdxauqZLgwhc4xu3bEhZqEE9CGOlmAL05LAQAiAQqqG03TlehRsB56aUZDL1wSSciB/qhbk0bEwA/iPUixHcbJZqnuozRFZKu0NVMSfJz63gn4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650499; c=relaxed/simple;
	bh=2aVL+SXZI14MPqWr4ZREBusaGXB8h3+E5VS6tDB5C6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3xzkU74D8dN/ymq0E4h9R5WO6nnRld7OHPGPt/TTyZp6yzrvoPbXqdD5gPVVHowt1xSkI5x/s5BqaAjbGWO3U71f9OyIwlM6zFqXchW2TUR525TtWeyj0TLoMi+rihIpG+kIOMxRzAQiiPghMQhc+Dvl+pdBvBdDEu5sS4SCtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Wq7eCyF5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OuqOJLdR; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Wq7eCyF5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OuqOJLdR"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 42A101D00125;
	Mon, 28 Sep 2026 22:54:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 28 Sep 2026 22:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1790650489; x=1790736889; bh=8IJSf5/6Ks
	2blZlCFNMgZrCOrzB80hMogn3HmQlwUPI=; b=Wq7eCyF5bR2gxwEA6Cpu5zvWJI
	7yaUSFhpPpkmqdmX0i4kiW5brwthzuxMjhdE29yDS+4ohjiPHLXOXS45EmFFT1Nx
	s8cwJUYXSdDAP3urqmVhWu30A5cS90Wv/gpmKNOZ92RFzDbpglapkpVQ6H8h0UoY
	Y6M5R1jGhLMYPe7CTyQOdbpU4xBtuQv0gwHWeBXZy0opb0iIXjWZUxDfztrgS0Dn
	T9Bc7TWYC7jsbPgMbofW+6B8ZP6t9LHi26QPV4PSeNaJyA1aQUio/KwywQEMvwQI
	oeRI0wfwY32Hfs6L07/MxKpXHSFXdpXUVJMHhVM00DkrZriXc8LTPWoc6ASw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790650489; x=1790736889; bh=8IJSf5/6Ks2blZlCFNMgZrCOrzB8
	0hMogn3HmQlwUPI=; b=OuqOJLdRLM6GrkUphVbQV3KUL6hFUPRgwEcONi7Iwm4a
	2Oh0rzGqelPBUL8CHLELsfU3r6fngsawhnrLWwq3c92+9Ie/FnRKUTVw/H4lSAZt
	7ZX8+6ws6zPGqS0wOwpI8PyU9SK9LbAcPp8ClJKYhBBREa0Ny+L+56b/NSMPdNvZ
	azBzbukhE4Nrdv9/fRYJa7uyAHCs/X7+Y/bgHbIRgquoxf1MOAfIYv6HCGX0tOG7
	b8ZIJ4qxw51J+5FS8LyIKx38FegBalqKotSIpE25sclQyJesCjO5ACyhif1cia7c
	1NKTs008N/4POCs3gl9RhjM5r6FyJ2GtoHViC8AiIg==
X-ME-Sender: <xms:eCi7amhYeyCYNioCdQhVotlfyycf7o9V_JSCbpAeLFEzKMW8mcr80g>
    <xme:eCi7alSaSrht3uH5zOhdkToL-GbbF1kOpkgaD551FuH5JgN5Yx6kjf-JmbfGJsa_z
    Q2tyU8uEa0hO5hHq7LC3xXac8yuEFPUAdMMm6hBCIU8tIkryGE>
X-ME-Received: <xmr:eCi7anZxKZOwFqIkVn1qBBgarlOFExNwMP3isMAn2TA-TOW-btgVN3INrAYEC10r0H5sdEtOGQT5yoEkzpsrSjj9qCTa-L0>
X-ME-Proxy-Cause: dmFkZTGa2GvpI0ntFIbOm4Ru6H4+Fc+J5+lg/jma+v3/7ggCRky6+zkaIHlc+Xr3emvaCz
    g1sfb0PCjRLePWBfFIzFi4+78xQ8tgJ981GHS8YwZEBeekIsID3CIEwAKDSCP1wyJb+0d2
    pjHZOIK9w/OUyq9nfQAyg6fkaFHHbtTtRpIrjsNJRWk95NGzxpv/sMAVO993w+p6Folj9M
    S2RzWVToOb7atYVPNFUqSnMTjWQN2xh+6j9FGUl+bOGggCPy7B85VA+pasI1L576WU/8wS
    o7HnjE+YxRfOrw5YA7r+hz/UJi6E+ZLeo8kRKmR7AbR6+XN9UN8Oo+1F6tJi3jRF+BeFfT
    0NjmMTRZgmW+Qd7reu95g3vfgydWHhqNlHznoAZwrEdDW+pBnJlEXlsVuJhGcF80xoxwCd
    or4QtEfHDAdT1dt55eCRBQe7i2f7f2Bi1X6PFLXdxJ5GiGiL3Dy85qwa95uu/jFtHdF+qM
    +CvkYJodv65HaGcortT15BzVSLwF7V7E2fiauojaxcix5c3AaeRcfQD0JzvUTBScbtKxd3
    xrhi0UDx2PgJdx905IaGprDGLmzscGKOAr/K1yLGMl/jtCiQ+QKYVzEwU8SalAd2oK007h
    hDjXNi9t5siy6htZUxmryUPiv8Rv9LW/eIm11+DYMtFmrOArSt2I9EuFOa0A
X-ME-Proxy: <xmx:eCi7aiQmQsh-QSaeuoVmX9CrfAZu8omp1KsRtAaYlU9zV63TUaylQw>
    <xmx:eCi7am-waePWXw9iIa9D59kccs8RmRRA7w0QkXxrFEKU_r80rheLTw>
    <xmx:eCi7aihECW4O7uZPJaQpMcGyKsmvaWnFHUNWDZAWLR_c-1wsw0se6Q>
    <xmx:eCi7anYuX3o_mBFHnQZkIUwiZQ_KfFG_Q7NtIv7JkxP0XC9ZDDdJ9Q>
    <xmx:eSi7asWuMhIIYyVzuDclAGynF54FFHZhfwFxcetHA31p8g1iUlpz-uxf>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 22:54:45 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] cephfs: prepare for changes to VFS locking
Date: Tue, 29 Sep 2026 12:47:38 +1000
Message-ID: <20260929025331.1436824-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I am working on changes to directory locking.  The medium term goal is
to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
can be run unlocked, and consequently cannot be called when ->i_rwsem is
held.

The requires:
 1/ that d_alloc_parallel() not be called while i_rwsem is held and also
    that d_alloc()/d_splice_alias() not be used (unless the filesystems
    doesn't support creating objects).
    cephfs uses d_alloc()/d_splice_alias() when priming the dcache from
    the results of readdir.  A new interface d_alloc_trylock()
    is now available and can be used instead.

 2/ a dentry must not be d_drop()ed while an operation is ongoing, as an
    unlocked d_alloc_parallel() would then be able to create a new
    dentry with the same name.  cephfs calls d_drop() in couple of places
    before d_splice_alias() but this is no longer needed as d_splice_alias()
    handles spliced aliases now.

Patch 3/3 isn't strictly needed here but I'd like to deprecate d_add()
in favour of d_splice_alias() as the latter now does everything the
former can do.  So the last patch removes uses of d_add() from fs/ceph.

The patches depend on patches recently added to the vfs tree.  I would
prefer these land in that tree too with an Acked-by or similar from cifs
maintainers.

Thanks,
NeilBrown

 [PATCH 1/3] cephfs: Use d_alloc_trylock() in
 [PATCH 2/3] cephfs: Don't d_drop() before d_splice_alias()
 [PATCH 3/3] cephfs: stop using d_add()
