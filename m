Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90F41A91D
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109348; cv=none; b=M3ZT/2QQGOHCs+Fd/7mu8yxhI6XPcRdH7L+fSZpC0G4tnu43RZtn+Sym5HRJgVXdWOltg0NDbuegF8K88Sj5ZlqkkyJjzDT2x2I1T2RWEFASIGIhEV/cTyqiQv7Puslo5QVzL1HekIg81siRvZY3uFuT8rln3jWCf1oq9ctbCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109348; c=relaxed/simple;
	bh=oYK+gCC914eqIrK4ZTZTIe7d267fdW8UbM2mRCte3qY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRM1LizXgeTuHdCyeTaLODGiFmvxkI1PVsFznYhEODAeOs6+8nSGa/xYoPYikL5RNN5QzNX48Et2cV90goFQSt9Z+1dypbKgG1d6bkYsGX/QAwcXE0CBKlOiI9P4FSjmnsg26IBz4ETIRhle0UhdLhuU8e7cePjoAtl58WFAZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCp3mLEE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCp3mLEE"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4720f3bf164so266577f8f.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109345; x=1784714145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kc0K293/4fM80/O9eYHRM16XnwLDqdrVKGEztVuHn7g=;
        b=gCp3mLEEO5emdRvK+Mcxzal8uQ5nSs0lNsoCvBYx7BFRYtQj9q3Ap4ozosrJPewL7p
         1NcV6TDMSL0F7R9qyGfrVqYEvd7UCP+V8IEj8UC8z0Ou7aaIFbB0oQiDKjVDdRZzZxN7
         xmRehmZ63NwVwDbUuxRuDJK5v29sXi0F11ZrFo3qr7/QvW0kFc4qwqaG7MR5y7W/Mk6h
         vVhyyTZRfMFHrDvSccOwtJ23lmo8vPa3OcqHlabmOe2J29JzLyEf6GjFaOifVt3G3NyT
         GXN8T8+fEjoWIGrz4KRLoTqqV2N9Y5eKHS5hZwkiFnnnyfrhkB+s3zI8qPMp4jJ2Pi9X
         UrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109345; x=1784714145;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kc0K293/4fM80/O9eYHRM16XnwLDqdrVKGEztVuHn7g=;
        b=TuH15t5a2qLergXo/oCxvAxxt6xbKjNrPWh6O9s45/kRsY5ODcqq0ZXwfQCGq6egsn
         0ZtPO/jkk1nnvrAhPRi+51BMVR/CN076U9zNuFS5nXXZ0xKFihM2lLKI1YdGnBuTvI90
         JBUPLOarTyib2EUcpdsVcn2incBlKdhfIJ9pPUG4qoLravmwr0s9vbNlY0KvAkqfmzcO
         SBN7Kq6XIEh0Gqwvxm0gdUeyN9bKCuOgxiCuDzVg7NvtbRCO6l4Fz45JCAJONPuBgJXl
         Pkr400bae84LDuyRvjEh9GL2tJQkvlgfmuEyZrAa9DOug9QtcDdAosgX4Z4MhfJwz2Qx
         x2dg==
X-Forwarded-Encrypted: i=1; AHgh+Roy8+06qUQ9OZy+bwAj9o3gj1YEV4Ur0iaqycJCPewoRDQnu06lZFBm0xFKy5a5KEferJxCAJS8hcFH@vger.kernel.org
X-Gm-Message-State: AOJu0YzDnoF0TvFmQn/wM2EwJ8RmAc2nJo2jaLYMKE6PX1gEeRw5qhpV
	gNL1s29l2YwJps0LhJ8Hu3f2xxZ1RXl2S54cTJ9DHkeCAoywiGaSgG1w
X-Gm-Gg: AfdE7cliQw3x+uFlDFPzICjsdChYUbWR4BwTuGjTafneszKBcPlXzq4rUCDV58OvWDY
	7UqZ46bIv2yqDNUIM9tt7LnAtqqr0GWk2ZeVU00kS12sdsqcDpARmm110mZt0GNl00EbJQumCvu
	RsrvgVjOjC5SquUb5lsr72cXD1HJn7UpxcnAJIrH80EWhkP/T6E8AFrRqOId2UImjOGU3KiPIES
	LjaR9FADMiqgdry10cpyNwHWiuCtp5Xy9N+sZLBQkWK1kwEyoLoPws/ux1IJQM+Lv0wlguHsW/m
	cUEAoLkhZUU9rluTZhhp2Pd5K5PPL0I9XboyD+q7W/g4tqkcLyGZ7FiqEJ2ZIT3d3Ba84mb4mnF
	dgHR7bWiMuaLyWa35Ke9Z/3SRmCrudCqlqENhjvj1YHdRnndkKlysGAeC6SdDElWkBGcBKq3fFW
	WzQiXq9VKOXitIdT3K5WkqncCvc4z6OBgnk1/Y46nTJqAAnIYJ4g==
X-Received: by 2002:a05:6000:22ca:b0:470:b344:22e3 with SMTP id ffacd0b85a97d-47ef697ee3dmr26100855f8f.18.1784109345131;
        Wed, 15 Jul 2026 02:55:45 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96cfsm15407548f8f.20.2026.07.15.02.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 02:55:44 -0700 (PDT)
Date: Wed, 15 Jul 2026 10:55:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Cc: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
 <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] ceph: convert oldest_tid to atomic64_t
Message-ID: <20260715105543.1e58cc13@pumpkin>
In-Reply-To: <20260713-ceph-mdsc-mutex-optimization-v1-1-9ae5ac135c34@clyso.com>
References: <20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
	<20260713-ceph-mdsc-mutex-optimization-v1-1-9ae5ac135c34@clyso.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 17:46:07 +0800
Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org> wrote:

> From: Xiubo Li <xiubo.li@clyso.com>
> 
> The oldest_client_tid sent in the MDS request header is advisory:
> a stale value is harmless -- at worst the MDS may resend a reply
> we already have, or skip one we still need (which will just be
> retried).  With the plain u64 read, however, the compiler is free
> to split or cache the load, which is undefined behaviour when the
> write side runs under mdsc->mutex on a different CPU.
> 
> Convert mdsc->oldest_tid from u64 to atomic64_t so that reads
> are guaranteed to be single-copy atomic on all architectures.
> This removes the one remaining reason __prepare_send_request()
> and __send_request() needed to be called under mdsc->mutex, so
> drop those comments as well.
> 
> All write sites (__register_request, __unregister_request) still
> run under mdsc->mutex, so use atomic64_set() for clarity.

If the read side doesn't hold the lock then it makes little difference
whether the write side holds it.
It the write is split (eg on 32bit) then even an atomic read could
get an invalid value.

On 64bit this change probably has no effect.
But some 32bit architectures cannot do atomic 64bit read/write so
they are expensive operations.
x86-32 now requires the 64bit 'compare exchange' that can be used
for 64bit load/store so they are only moderately expensive not
stupidly expensive.

	David

> 
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
>  fs/ceph/mds_client.c | 21 ++++++++-------------
>  fs/ceph/mds_client.h |  2 +-
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 9f84ef2ac6e4..98d0a5baff70 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1235,8 +1235,9 @@ static void __register_request(struct ceph_mds_client *mdsc,
>  	if (!req->r_mnt_idmap)
>  		req->r_mnt_idmap = &nop_mnt_idmap;
>  
> -	if (mdsc->oldest_tid == 0 && req->r_op != CEPH_MDS_OP_SETFILELOCK)
> -		mdsc->oldest_tid = req->r_tid;
> +	if (atomic64_read(&mdsc->oldest_tid) == 0 &&
> +	    req->r_op != CEPH_MDS_OP_SETFILELOCK)
> +		atomic64_set(&mdsc->oldest_tid, req->r_tid);
>  
>  	if (dir) {
>  		struct ceph_inode_info *ci = ceph_inode(dir);
> @@ -1257,14 +1258,14 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
>  	/* Never leave an unregistered request on an unsafe list! */
>  	list_del_init(&req->r_unsafe_item);
>  
> -	if (req->r_tid == mdsc->oldest_tid) {
> +	if (req->r_tid == atomic64_read(&mdsc->oldest_tid)) {
>  		struct rb_node *p = rb_next(&req->r_node);
> -		mdsc->oldest_tid = 0;
> +		atomic64_set(&mdsc->oldest_tid, 0);
>  		while (p) {
>  			struct ceph_mds_request *next_req =
>  				rb_entry(p, struct ceph_mds_request, r_node);
>  			if (next_req->r_op != CEPH_MDS_OP_SETFILELOCK) {
> -				mdsc->oldest_tid = next_req->r_tid;
> +				atomic64_set(&mdsc->oldest_tid, next_req->r_tid);
>  				break;
>  			}
>  			p = rb_next(p);
> @@ -1693,7 +1694,7 @@ create_session_full_msg(struct ceph_mds_client *mdsc, int op, u64 seq)
>  	ceph_encode_32(&p, 0);
>  
>  	/* version == 7, oldest_client_tid */
> -	ceph_encode_64(&p, mdsc->oldest_tid);
> +	ceph_encode_64(&p, atomic64_read(&mdsc->oldest_tid));
>  
>  	msg->front.iov_len = p - msg->front.iov_base;
>  	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
> @@ -2759,7 +2760,7 @@ static struct ceph_mds_request *__get_oldest_req(struct ceph_mds_client *mdsc)
>  
>  static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
>  {
> -	return mdsc->oldest_tid;
> +	return atomic64_read(&mdsc->oldest_tid);
>  }
>  
>  #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
> @@ -3438,9 +3439,6 @@ static void complete_request(struct ceph_mds_client *mdsc,
>  	complete_all(&req->r_completion);
>  }
>  
> -/*
> - * called under mdsc->mutex
> - */
>  static int __prepare_send_request(struct ceph_mds_session *session,
>  				  struct ceph_mds_request *req,
>  				  bool drop_cap_releases)
> @@ -3555,9 +3553,6 @@ static int __prepare_send_request(struct ceph_mds_session *session,
>  	return 0;
>  }
>  
> -/*
> - * called under mdsc->mutex
> - */
>  static int __send_request(struct ceph_mds_session *session,
>  			  struct ceph_mds_request *req,
>  			  bool drop_cap_releases)
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 731d6ad04956..3b614b5df18c 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -532,7 +532,7 @@ struct ceph_mds_client {
>  	spinlock_t              snap_empty_lock;  /* protect snap_empty */
>  
>  	u64                    last_tid;      /* most recent mds request */
> -	u64                    oldest_tid;    /* oldest incomplete mds request,
> +	atomic64_t             oldest_tid;    /* oldest incomplete mds request,
>  						 excluding setfilelock requests */
>  	struct rb_root         request_tree;  /* pending mds requests */
>  	struct delayed_work    delayed_work;  /* delayed work */
> 

