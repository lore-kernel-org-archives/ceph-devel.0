Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FC22C235E
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834402; cv=none; b=CPiUi9xb8kN5607/THozHGxRc9Vb79fqGvF3MvjFQCYqagqdXC2GZbw8vYHrekFnekm2/G0Pt9vMEwGxttkb5hiXsgsQU5/Av4HVM7IRodVfeJHi1utLykI5FOeN/sbU98LxTy9N+EhsiTpppe7+bUIHkZHxExrroVEigJZcjYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834402; c=relaxed/simple;
	bh=4zB8WcX9WxDmk/SB3QlvrNdk8zy4ZJBVJaR7VkFHKSU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qQeMQ0deGv/m/zYmsnlTLOen75BEG3a418+sXjBUNQ05R2AtZTtd0FkscPdy1kIGgdNofozMN7py3ppcoH+kuwdKamTesDPB2zqlYnawlMpujtkLPs0XArvo4PMFqQgJZl91QCeH6EzZ3UzAkP/aNkjeJayUOnr5C3ynsFEaXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=mxxrzyNw; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="mxxrzyNw"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-664eb8cb631so2063819d50.3
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782834400; x=1783439200; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGNd7GPkzQIYT8vDl++CNMzGqeXanXou+THVXO3QoO4=;
        b=mxxrzyNwfFteOT0dqJzd+6ZvXmzfbN1cEge9CEja1JKhzud7g1TI1lYTM61nEOzarE
         BbuU6zo69anrk24HDkkBmCJEyxsIPZWke2Kj5oACrTmpoI51r4O1UZ6PtYva25h4GjJ9
         E7pxJmlr22BI29CHryiV3pp+hRz6rh1UBkXALb9mEHHdIB6gXCz3nHI06nwNotda+2cF
         DEM0bHwY2Jm7ZNCCtojEGKXwl+5sPVtNy8bqG4PNYfAlUomNyx8f7Zo/laHvkyr4Ui8/
         bIWc7KZHHRBmJUJr4GajgioBR42nDzudKbgMLVNKdajIwy0OAQ8+2kRsSqpKlTB2KEAJ
         iuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834400; x=1783439200;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGNd7GPkzQIYT8vDl++CNMzGqeXanXou+THVXO3QoO4=;
        b=WnTUST+8Qs57C3hCrJoZDZfZGuJ5xvpgVYe19Ctg+5GHuh+o2nMgUwRKm3MWKDR0cz
         FQvtm6Eb+Ol6CezK5L/vxqxdmGI4IgMd/KptnSBlxo9LsZQDZadFbfLu7+isaaEGyz1+
         3JqOpFhQsaeRdXKRY6fUVoSwfP/8X1ChcjEqli1XY3RRLNgz79fspIdMJBaTudhbEnh3
         sfWINe/EnEP24AYwuEwUaGpWGAYDJ7eB8eFpMmuRpk0XAnAVKq1P9fKKgtN43Ce3ozER
         Hhsf7xelnV0l9UGZ8o+SKH9XFffJrAIoLum8iIm45EX5qdMzQqxi1p8VLuQHTTIj3OS2
         0hgg==
X-Forwarded-Encrypted: i=1; AHgh+RoLwpgmhHLjjZARy78frMNxE8g0aePQBpUCdTgfPWn+ichSL/TlL8WwvZ2UgJ6jYjh5TcWOqPjPCFsf@vger.kernel.org
X-Gm-Message-State: AOJu0YygMBGjgKg4aeWxXC5XFGLZv1Q3OxcRfqaOx9PTt0vKFVuFZxns
	NlsW4p2qmHLJKv1VKfdGb6qf1l4rIjdehqckyj6GDcZKUqwvf+CGnEBSbi9xnkdYpGg=
X-Gm-Gg: AfdE7ckya66MvzbcAJ6UlIGbKK3HbtZdeAGX3UXFvbM+s0z3D4dAtyK/drRUxRRRGqn
	UMy8Obj4OanukCWLx4DIuVpxy0YKt6xl8y2b2b28zHg3NIUQ+KN6j0Ky5lMr0urHDjlOP8oRsZn
	FhGlOQRkYyppsNGG1F06XFWJsul9nmosQ5w1f5Q9YTBLlditMCiGzvq2GaajodcRnojv5kW6MVj
	bWYuhFiu2Hlwth2B7zCzEPkMgutBhxsZGFWc7oXr5+GXbPWBkW3XqyqIzxubBqg+9LMhrRqQWQP
	JzM8OcUU3c8ypmi8G35SIXa4AqwlmX+vNRVrizls584SmczbHjNr/oL6D5BuTGvBcfsYuTI3JtI
	dXRA7SKMII0CCzAZWkSuclXPRHxTv9VnR9TCGYNH66dR45PJwITsNILN14VW5qMPe56g82rWsBS
	oyKubjAxvNW9+6N/dyBDM57lLAIdkJcr0K26wT3ZCUJkhx0rQsERCcF671NLp3+5WEtU5Da81Iz
	4C0COnae6zqP2nHTxfHynVfrmvbnWTvvR5DN8NnwISpetvxvOWc/NMGxz85MYIDVJkovBYHbJdr
	6K9YAbY=
X-Received: by 2002:a05:690e:4885:20b0:660:86e7:e6cd with SMTP id 956f58d0204a3-664f9728792mr3147156d50.7.1782834399850;
        Tue, 30 Jun 2026 08:46:39 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-665006a8c03sm1092688d50.9.2026.06.30.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:46:39 -0700 (PDT)
Message-ID: <c9c879b2a91d029e9d7aad5c31b40b99a5caaaf5.camel@dubeyko.com>
Subject: Re: [PATCH 01/12] fs/ceph/super: remove unused field
 `i_cap_migration_resv`
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 30 Jun 2026 08:46:37 -0700
In-Reply-To: <20260612165204.86137-2-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
	 <20260612165204.86137-2-max.kellermann@ionos.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-12 at 18:51 +0200, Max Kellermann wrote:
> This field was added 17 years ago by commit de57606c23afd ("ceph:
> client types") but it was never used.
>=20
> This reduces the size of `struct ceph_inode_info` by 8 bytes.
>=20
> Fixes: de57606c23afd ("ceph: client types")
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> =C2=A0fs/ceph/super.h | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index afc89ce91804..6aec40955387 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -448,7 +448,6 @@ struct ceph_inode_info {
> =C2=A0	wait_queue_head_t i_cap_wq;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* threa=
ds waiting on a
> capability */
> =C2=A0	unsigned long i_hold_caps_max; /* jiffies */
> =C2=A0	struct list_head i_cap_delay_list;=C2=A0 /* for delayed cap
> release to mds */
> -	struct ceph_cap_reservation i_cap_migration_resv;
> =C2=A0	struct list_head i_cap_snaps;=C2=A0=C2=A0 /* snapped state pending
> flush to mds */
> =C2=A0	struct ceph_snap_context *i_head_snapc;=C2=A0 /* set if
> wr_buffer_head > 0 or
> =C2=A0						=C2=A0=C2=A0=C2=A0 dirty|flushing
> caps */

Removing the dead field makes sense to me.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
