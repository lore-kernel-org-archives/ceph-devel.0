Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4C3C10BB
	for <ceph-devel@vger.kernel.org>; Wed, 24 Jun 2026 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310934; cv=none; b=ZDlxFUNXbzHghoHySKEIC5ri5iogsoZ+f45eUMGFwvFYeGOUdIRogupjt6GcUuhNWetY7LeD6+0W7dRghsGeP4Iqe12gJEc8owvrO60WZ8rnqAOrVKDRNgzxa/RK3C350H/x2prigarsQrzsM6jhmIzic+kanyqulXqxUdS1rjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310934; c=relaxed/simple;
	bh=y0WSRs6Vh+isvBOVaKjWmGYlW5InK7L0Oy01ck/WyV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZ1L6/aVe0AGcGg3N+eVU56Mcpaf+hQp14qYPll+2wBMpzACNK1cxlGqY0pfFkJX3oioT+mWhS6gC3T6dNK51OBzhC1FaZZ9y6WeduowzKOkEZ2YIDbxa/ntGu68WAGdDqeoyJjzYyQNz+kn8qCjD5KMp8HWpKjNqyKNh53OxzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=OwC9CVCg; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="OwC9CVCg"
Message-ID: <d9b48d39-21ba-4aaf-b9f0-bcc6db4c3088@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1782310920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X245tY1zwiXnNIdJCiKRYM3XjdPZBSqBqKOMlxQZ5pk=;
	b=OwC9CVCgHcLToeXHcQhSsamSOuZtMZlgWNH4swYuXPIyq7nJhDM2pF08l0FE9ppJb0LrOq
	VIVA3/+V5UpfGwyijI8wAoKkmvi5bKg0h/vvUoN2x89AwvfeNCvw1BZKxm2/dMwChdZWa/
	o9VMBtZoI5Lh/JmGRGwjGasAne9aPhuOMg8QbPMMeQGAv4/hZPvbQhYxMp6hsmFUeg6CTz
	o2l1LlYjxieTzmWivDHjKktdk7uqvqLIyvUxlhq+vuSKE3AKhwknsILlCONN6YQCBmQ+a4
	j7qZGKqHPOtSfgJKB6bpFisXyWXAEXhZ4AUGilMq7UHSzOI/3PHtr9KQY8XZXA==
Date: Wed, 24 Jun 2026 22:21:45 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 14/14] netfs: Fix DIO write retry for filesystems
 without a ->prepare_write()
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
Cc: Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com,
 hongao <hongao@uniontech.com>, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>
References: <20260624115737.2964520-1-dhowells@redhat.com>
 <20260624115737.2964520-15-dhowells@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20260624115737.2964520-15-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Looks good. Feel free to add:

Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Tested-by: ChenXiaoSong <chenxiaosong@kylinos.cn>

在 2026/6/24 19:57, David Howells 写道:
> Fix netfs_unbuffered_write() so that it doesn't re-issue a write twice when
> the filesystem doesn't have a ->prepare_write().  The bit of code that does
> the first issue should just be removed as everything it does is done again
> when the loop it's in goes back to the top.
> 
> Reported-by: syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3c74b1f0c372e98efc32
> Tested-by: syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: hongao <hongao@uniontech.com>
> cc: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/netfs/direct_write.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
> index 25f8ceb15fad..1ff1789016b8 100644
> --- a/fs/netfs/direct_write.c
> +++ b/fs/netfs/direct_write.c
> @@ -190,12 +190,6 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
>   			stream->prepare_write(subreq);
>   			__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
>   			netfs_stat(&netfs_n_wh_retry_write_subreq);
> -		} else {
> -			struct iov_iter source;
> -
> -			netfs_reset_iter(subreq);
> -			source = subreq->io_iter;
> -			netfs_reissue_write(stream, subreq, &source);
>   		}
>   	}
>   
> 

-- 
ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Chinese Homepage: https://chenxiaosong.com
English Homepage: https://chenxiaosong.com/en

