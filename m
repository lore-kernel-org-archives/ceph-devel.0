Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB3346FAE
	for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2026 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614134; cv=none; b=tw1RoXHzInBKAAlQHVit7NJ0Q0LkK3ZPCrgj8VwoUN6amA+qtg7o8gjHGCtq5f5DCbQY1/e6xpv0b7Rv8/KDPcwmDPJwBNPE9Tx2Xq00y7bt8lCG66HzFC8sURDy2iYWR1hE41p6ZkCiN3vb9CYuay4QBbVX+DOMgYZ6khh+0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614134; c=relaxed/simple;
	bh=+BRhsPWDpZjoK0HsveNG5UGVmQHqK2OhhoOq5wslwZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvadN6JwjAdnIHDDri0IEOugyF6arjSHqnTQM2p5de3AIAuwsYOAzjLmBjyHGfWAtlgCLVbSgkgFpR/pAsUdU/wgtlFUqxKrfgXRqDlWLbrk3SS7sByZ7dqdI+bzzUyl0uVCoNQph6vviFaZLtJCjGHf9U+umqf/NeFfwnJrG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=DXl5YP4w; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="DXl5YP4w"
Message-ID: <b6b19c84-7734-42ea-b2ec-9ace1f36ad08@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1781614119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wv0+MgqNRvRce0wQH8tzVOBI1JIX52tUPZ58AWe7J8U=;
	b=DXl5YP4w2nX9zBF/auRW6duXvS9I+LFh6H72wP2z7tgKv4bVq1GepXsY8YwJgiuxk/3GYJ
	utsvh8oA1hM5Kec1L2eqj7x9jLuM39MuNcqFVWCQlxcbVvJf5UuT7X6eGlgcHbnkR/32DA
	5PNFdhWzOvpVWaJ/smJLv8N+zcFXXuBpa/tcwnDrn+6tX8vWPV0jrQwPKilpFVlwL6JsyU
	NgC8RocoDRsvVJelCGWkydzsykPdIiiMd9+HKmhv/CAAb0NJhfq7tp8HQgIgsnKJEnb/FJ
	zY3lj94Gbuc4hUnVoAKzBsLPkNkrQsg062VkaRzcyMkvx+Oemz6MzQHqkEjodQ==
Date: Tue, 16 Jun 2026 20:47:29 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 30/30] CHANGES
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>
Cc: Paulo Alcantara <pc@manguebit.org>, Jens Axboe <axboe@kernel.dk>,
 Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 Marc Dionne <marc.dionne@auristor.com>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260616100821.2062304-1-dhowells@redhat.com>
 <20260616100821.2062304-31-dhowells@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20260616100821.2062304-31-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Is this patch missing the subject and commit message?

On 6/16/26 18:08, David Howells wrote:
> ---
>   fs/netfs/iterator.c    | 22 ++++++++++++++--------
>   fs/netfs/read_retry.c  | 12 +++++++++---
>   fs/netfs/write_issue.c | 24 ++++++++++++++++++++++--
>   fs/netfs/write_retry.c | 23 ++++++++++++++---------
>   fs/nfs/fscache.c       |  3 ++-
>   fs/smb/client/file.c   |  2 +-
>   6 files changed, 62 insertions(+), 24 deletions(-)

-- 
ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Chinese Homepage: https://chenxiaosong.com
English Homepage: https://chenxiaosong.com/en

