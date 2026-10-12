Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069527FD74
	for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815550; cv=none; b=lxi6IUqlZVh6vmIRZDDmfigDZTyAG1qlqRB9pyQ/zlJ8pHnK9sTqB6HIC3yI+kqlft+/7H/awzD5dx+g+NxG6mbTRd4uzw4A2VhrEwiTmeyJoJFy3pn4clECdUVRIshdTdCgJTReipIS3njircxqW9Q/KxZBJiCuThQIsxTpiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815550; c=relaxed/simple;
	bh=e2fOhJrZ340BsVD9pUrjFaC9s7NoDhBvMGTtN3hwKpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpPUljomvEX80jSPkd5crEA+0UXMWzWL4UMZxptlGc7sEX8/0cqlmtajtdDPhOMHx06kENWERmzKT9QS2A2Q03nMaP4cdoHkE1D+3zmA0pif2gHceHztf5SJBVK2PfottvWJvl82s844iHZBtyt/cTvTlAyBEDAzGF8p8F5MMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOX44WZu; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOX44WZu"
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-49e2cb73ba3so751365fac.1
        for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791815548; x=1792420348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=unxLWtZDs1Hx2NMfpZvXZ8snLJuNugXErlhhpg0Cpho=;
        b=OOX44WZubmegOZIxaqGEetW5nW0bFfXYmvFHpX+jSSx0H0CfNuF33KNh1VQ0SJwoR+
         iieszOtfzLlsZ2coXPyAG6Tn5y9amMYdrHBvJgPDH7BqQKu4dAQ4uglP8I2BiGDuEMZS
         KP7kD+dsf9S/P8FGIJI7h8dNuZPeMz+9UbuRwKn6ZnUYocUsn2CaQP9AzUwovZ27jHcH
         9gnANZ+mKamFpZzk6ZfDDPeizhHmZiKvMO1LlMGF5VBs92WWlYrTMBRn3TDzXqd+53id
         QVO9IudiQO3UtdtXh0HFELFw8T6HUfZBeVnykhNsgCAxtPab35LGWYHAC2pybL6aS7XY
         7sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791815548; x=1792420348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=unxLWtZDs1Hx2NMfpZvXZ8snLJuNugXErlhhpg0Cpho=;
        b=tu6H1dBAuVG4br2/vG2aai/wztbfOZJpZPwXJSfcnF9fxIOPy2mw/ycQvdHx4BODCN
         n1OXBcSMTmZWIKFIaIf4phcX0dsxJS3u4gNi3qu7b7eKos0FDMJpls49i2qmlB5AHNi7
         Cj4LG78ZLcm1kgqgs6CaD/4OHBmC8xXpKZwYviKLMnClnjGlshHt3GV1n5oYPhlh4zTD
         kdayCI41I6WhEvx4nxYRpDTvmBBfcNW9ggt5wAfDQMf7TAoby865/9jwW1I2PEUM5d5M
         xvgmDXnmh/4e6xOUdAYpZxIIhZEA2ryOUJOK4YVDMgRSv2DUe7bJ4SlzvVtKMtftSMJi
         YplQ==
X-Gm-Message-State: AFq9FYLwBvkdvvE2jEEaYiVx2lwZUnoi4COcxHHvi5G9jXYHni6s6UBP
	iVDJmuYroLQsQCrSqlBcLGJTV3AWJbLO/JsB+cWvL5hZabk6U1lkHtGM
X-Gm-Gg: AYBFou0CAEmUB8vZ+WkztBUBk+9cWdbIAfWm853bhapgP7d2iCXWYbfhUh7EjnL+SFK
	QDyeXeOIZXamsYSkKM2wzBYHx0h+yrkAk73Fp3HTTjZ8CgRLE+Ue84lkIk8w9el1DawpzxzvaTR
	vy+65DFzHcFeLKUePdOHrNCsBDKGexuUuINB0BSDLFjbDJWkQEC18vm7l2ydh62Jb4UKmEzo0K8
	rgk0MswnoYMa8v4MWWITAIm5MKgHRtRD5jMJcF8Zl4YnyIIm7KwjqqWZrSIs0giXGfNqVZJ327m
	oJFkl2EQ2BM+BIqyHIQhNbTflPvRHAI9McojnW/j4pXObU86+QlUV+WGgN7VHQ6dgzoZC46ktwd
	yiyDvq+pKN49qtg2BulLIxtNYVrsZKO7r3GyTN7VMEXUsk4KMzymJgGwrZnAAxMU10Y9hrqCPB2
	xax1lKBsCqkROLU8cuh2vr4zi3EuNGr16UUGgRVBAXcVzOPxCAoB8655M1qmgHV1R5weg4hqlfA
	Nmnx1G+3aYyCmU7g1/Pn6kxA3ZVUlIb5A4o2yY=
X-Received: by 2002:a05:6809:c1:10b0:50c:8007:8ef2 with SMTP id 5614622812f47-50c800790b7mr5438318b6e.68.1791815547936;
        Mon, 12 Oct 2026 07:32:27 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.37])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1a325a38sm11578930b6e.12.2026.10.12.07.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:32:25 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libceph: fix client panic on MDS message with data but no data items
Date: Mon, 12 Oct 2026 22:32:10 +0800
Message-ID: <20261012143210.1681034-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261012072851.3431644-1-amarkuze@redhat.com>
References: <20261012072851.3431644-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alex,

Thanks for looking, but the skip you describe doesn't exist on the
MDS path.

mds_alloc_msg() (fs/ceph/mds_client.c:7384) leaves *skip = 0
unconditionally and never inspects hdr->data_len.  In v1,
read_partial_message() calls prepare_message_data() whenever the
on-wire data_len is non-zero (messenger_v1.c:1229); in v2,
__handle_control() routes any non-zero data_len to
prepare_read_data() (messenger_v2.c:1837).  Neither path compares
data_len to msg->data_length anywhere; I also found no such guard
in {mds,mon,osd}_client.c.

For an MDS message with data_len > 0 the first hit in
ceph_msg_data_cursor_init() is actually BUG_ON(length >
msg->data_length) with data_length == 0, one step before
BUG_ON(!msg->num_data_items); either way the client panics.

The check you have in mind is the OSD-side one, 98c4bfe9d89b2
("libceph: check reply num_data_items in setup_request_data()").
It validates reply items against the OSD request's preallocated
ops - MDS has no preallocated reply path at all, which is exactly
the sibling gap this patch closes.

Happy to move the rejection into mds_alloc_msg() (skip/reject
data_len > 0 there) if you prefer that over messenger-level
guards; I'd keep them since they also cover any future alloc_msg()
that allocates no items.

Regards,
Henry
