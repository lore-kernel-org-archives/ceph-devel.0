Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39A14534BB
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992449; cv=none; b=ef0J/JU6apfwlF9/EF3xKr6tzXlDUA3yHgyb0QzjqpKplb+RsYWmundUj2eg90FjnHDYvnMAxYbOhnp2iv3qwFKi+TZbrNNg2v8SE7o9QzJM7vNqZNzDwKP01N9rvHS7n26GAvUxNiRoA0rMfqtNFbSKc8QCC/IajHHsLzzEXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992449; c=relaxed/simple;
	bh=pDG+LUYfWE/lg9GV3EwC7bNAC2luO8YmosElSYurcVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rf/CrFY1HbZFsxzOlfP23sOJqzjQIVUOv+pXca+d7uSu4WJQhNDPNoxJrxQhsGuHc+oGKMaZCGzlfDM1UTmm004YPNqN6AH8Akpx2MMvejmsl4g1AgnFX4FLfZsTc6XDR7/x0z+fTNY0pBuQ+SPJKYp7nlFCvKV5AI6ipCfrjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7mGMgTG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWzbS3mZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7mGMgTG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWzbS3mZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782992447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
	b=B7mGMgTG8j9DOP/hjFSQX/N7osC+0aV2R/iRjmg7HCVKY8cwrbBvAg3BgloaKaGz64+c9y
	gK51SsOu8/M4V3Mzv8vXV4tJ5jmJvPhZDXA2f77wkatQSiXkZE7s6DPynrgJ0WSxMW5GKF
	PxRTq3w2FXFTlFxn+VWFLWs8GJLkxkc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-m5kVjIBdO16qjXVdpsd_4A-1; Thu, 02 Jul 2026 07:40:46 -0400
X-MC-Unique: m5kVjIBdO16qjXVdpsd_4A-1
X-Mimecast-MFC-AGG-ID: m5kVjIBdO16qjXVdpsd_4A_1782992446
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7ead32f5c6aso980203a34.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 04:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782992446; x=1783597246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
        b=dWzbS3mZPR9wl6ml75H2oV3iUXquyHthprZ3gYGqC1SMBRdQOFAaiFMdGm+ohkf6rY
         vN1I7iQ4mM0cA/bS9hMESEbq0RgPCJVko9LfjCHiwhFtkPhm2VFy4Hu5QYnQB+4N5BZC
         +EGGfl9auTzCrgjmMnYCQPo3bwgQ62nYUu4Wvz+BONb3xaUssYGgY0GgucOgl3a3kCjh
         Cdj3Fs5P+dYV8MYj6tMuVYLL2rDzM2+UijzFwTdAH42X3CQl5R16W6H0/Xnh3923DHD6
         AWMyvT6Ilu9758Ea3ACCO3V3Q7t9+k7lAGiqKCWnpkQT9uPs7U22THBn71gXSoNyjFXZ
         zg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992446; x=1783597246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
        b=F9cB4q4XLozs6vF38ngpO2bczc36MOqFxIzZkB8EWkyL+2+N5p76/ZYYHeekYorktx
         Y0RmJA0CYuiI1NJMUi09ti+XkBKIET7fL5mKfdcoaDAgI8PhYPIMdYBKSLldgL3ijBq5
         2JulVQh/wfBFifQ6vaT6RRZHJkeTmthfcHuQuao4DzHw2BWUpeSR/qaSiWEHdCGUgtai
         bNrbfASUQEdTsSudaYUQi3U4ddPB/5eP/jjLi0ucIZ3bxSDAqhVob6wYxkMc7yLVFBTG
         gnH6s9haCUZmUzoNW3PvPMQNHJIGOkq7UrAjOhE2uVrZ7qRPIKFg1tqRezt1Uvg7ZfC/
         9lZw==
X-Forwarded-Encrypted: i=1; AFNElJ+IIrQpMwJpWuezWDn/2zAu0ba2RZIyTKkI7zZOl6LDhXTcxyeOcJXtsGzGoG24I7spTsLtED2/gvDJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyohJEg9J61rA9L77iQ8Ohe/uLqJyznlKgirfSfrXBNKbV+TUhn
	VqXbfw15rjZRiPbCyzYZRUFJLh49wuTXccOjnxL7DqePNro5fz3TwMXQ2wfM7NK1JbMLx80lBQC
	/IOOYzKpfMLyzxu8veeDML3hqE7FUrs3ubg2fkDRE9Hc8A7GGpaaBLARgHHacefA=
X-Gm-Gg: AfdE7ckYs/T7CsGELUJh4sjbpfQUkro1lITRCToOHiHfCZAT5xZ0d3ZjqYVNOCSEwUA
	2mn8s0FqAZFlUpR3qvrYCAq5qwLocLzfvhA9lAHNhicyn89o+xu7y4TcQF9yltmg2txBIZq8Aq5
	OOgeaMA+RDbwbmSmvE8095bltz79D/eWl6Jye0ICOnZsRW6f1dXBjNJ13sm3bhziIEjMoPTq9Rd
	ZoIGBgSpf3ZBAp6F+MJCIZAFroYWFrJ8JT14kzj5jX1xpQMy8XoFZ9Jmcs4ZEx5xYHeovcraIU9
	/YgXF8dzMvP0eTG+PxiURNi9gg8ZKPjfzYekvLHMGU5pH9caLkARkQAhG62+p6jOb3NMf9rQ/6i
	cnunh
X-Received: by 2002:a05:6830:440c:b0:7e6:e349:539a with SMTP id 46e09a7af769-7eb4cc0dc89mr3389049a34.21.1782992445836;
        Thu, 02 Jul 2026 04:40:45 -0700 (PDT)
X-Received: by 2002:a05:6830:440c:b0:7e6:e349:539a with SMTP id 46e09a7af769-7eb4cc0dc89mr3389036a34.21.1782992445423;
        Thu, 02 Jul 2026 04:40:45 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb545515casm2206351a34.27.2026.07.02.04.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:40:45 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [net] libceph: bound pg_temp/pg_upmap osd list length to CEPH_PG_MAX_SIZE
Date: Thu,  2 Jul 2026 11:40:24 +0000
Message-Id: <20260702114034.917507-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609044009.2564543-1-xmei5@asu.edu>
References: <20260609044009.2564543-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiang,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

