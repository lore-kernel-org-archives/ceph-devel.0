Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417B2475CF
	for <ceph-devel@vger.kernel.org>; Fri,  9 Oct 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562097; cv=none; b=CAlxD5yeXObRqUPWPjwJb2Errs9utIMv6kJw+IKRPy46x2YDJhygrSH2EP/IO8xAC/Xwid7QY5RAIyGFCtoEVS1cAA42mDjJu5Cm0zCSY5BWRHF5ZtBkswbSWKW8jkS8b025A6u58d0smwnZiQLqCUKAX2z5fykfcR+IS/HU8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562097; c=relaxed/simple;
	bh=oajs1o90Z7DvpjetYXFnYzAFXe5/xjr1tOD78zxYGVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WoIUwxbwcdnWFPu/3dx1hnE5m8sLGL7dm3YLSjLa7998tDj1VADkx2RbthCyDDaNB7guJleeOA9Bs2lPU5HRXbT+woaIeHOhtXwY3m04Al+fneGrm2+I/Y/eWQTuErMa6q7yxpYtTVL6val8pddOuSS5Hf3Z/70GjCJwqdptjis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G504b4JG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8qsUcyR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G504b4JG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8qsUcyR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791562095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IWrtzyGPsRsgtebIlEEK9WNdl0sfweG06xbPe2HSTXw=;
	b=G504b4JGsDuAlzLbGdFxeE0EP1HvukXC6sQ/VS2cHdX65FuKXgLqQ87blQJoiQPick5x9q
	w3dIjdotbwhkws7/VlagABJF+Hhn4YqcmPZo0zESV9OxbdLpWmndL7k83sGXXMUAs0fTds
	UfVsI925ZQ3wkjho76WzJBwDx95WOCg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-3UQlPrruPLWKepRULq_SoA-1; Fri, 9 Oct 2026 16:08:14 +0000
X-MC-Unique: 3UQlPrruPLWKepRULq_SoA-1
X-Mimecast-MFC-AGG-ID: 3UQlPrruPLWKepRULq_SoA_1791562093
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5352436cd78so69996041cf.0
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2026 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791562093; x=1792166893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IWrtzyGPsRsgtebIlEEK9WNdl0sfweG06xbPe2HSTXw=;
        b=F8qsUcyRgpRlG6kBMMUcpjwynQLvHQZtbTzqAowudVrmmTsc6DnPMgb6qAVElzXsvu
         I+4vfdSZ/qqAhbmzYDGTXJc2o07OIR8twJT49T9zwhGjr4LyQTzOGJ1ufeshqx4cKoQI
         rLf4JtNvZH1mg5Grl49/M+sBm8/ershfU4UXkhNIsiooU5wSaCzAnH5LjOec+bYLkJu/
         K5OHic8S+EKAobz4f6CkAJ1nugmtZPrxVSooGAvn4DbJQ8CfiSuzi+Djf2dMGJ+bXg2V
         5w5nly4Pi4tuIDPo3i96cTiIiF70IvGwEA+Aj0B4eoBczWeAbJaVwlSmkV4SpEQ1D+uu
         xiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562093; x=1792166893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IWrtzyGPsRsgtebIlEEK9WNdl0sfweG06xbPe2HSTXw=;
        b=fztvtYRFkRRsX4RHMv7myTfi11veZLxVe00H/U/cKKjCUTgbjr3lsoqvWOK6Bkyw2+
         IH3jCZOixJmG7jrNEkaOa55yCKteiftq7OmNRejKROgUBkI2Z1upJPIw2m/nY26uqO7x
         FuyYAOvHNEfl3OCM/TeXPxD3Sjpj2LibYM1Cjk6o6f7GwqXJ12WNzzFfrwzyJHVbu8xs
         CLsbHh21z+RCbW2ReSSv2VSQbu0GqbL6Nb1sWnTmuNg3039rzcO1vKCWm+m2h3+GiWSc
         Vzj5tB0RV2rgWLvkymHUrbqaZozbnJ7Z5ucN+Coz4vGSUIYW+WqTeH7y4aB63DG5fssg
         77Pw==
X-Gm-Message-State: AFuF++m0S3Us5MRrzOMxAc+E7+fVLb3WkFJEYhgACEaDxPJ/3R37Lj0o
	RlRKrALdqzgwtq+l9PA9DlaObgx77nab9i+Cla/L5/JR1yBdLOILTm2liITF9ffuO5rD0jUWj6D
	Kod/bLHHbxN8JlFQ9asBHYPXbQi7QGf/jrTBfNvHWdLFoDdZJ7OnrG59uJFg1fZw=
X-Gm-Gg: AYBFou3hi+A6RXRXRA6KFN1kibF5TYnDLWKpGlGbWmqcGNVxg/gqOXX4m4GmzPh67eA
	MJcmzjLzwZlsc0u91yBvX/wCmqg1Vj9kwtNYJhCtRqrp/EocUBPcg8T6XtDn9iebqJMrueNTf8Q
	YhOPrkbNiw6VPuKjUmy1kDFQCElFPECjkCDcBaK9I+RIwy7vCb2DeQ5jIKd4qm5uh5i98isYIV4
	526Cdfi7Vl/tt1tGkGMt3Hou96RMa+sKK7H+8BNJK/dPBD3+fH6ukxWnNUyjh3pRK9RZXiFMAzb
	2cBSo2wST16wU0Q4Q6ibck+hflAdNWtyF5tlrV50Xs8ZhnVm5JYKc2kCd2U7334dEXV/tQguilW
	1eU2M8mil5+y78m3/9pGl1VDgGogfXfxhyXFXGjVkwvWE4KLUB6Kj7hHukZTP7FqADIKnNDg7r/
	/+v9Kp+tbYH8xLBw==
X-Received: by 2002:a05:622a:598b:b0:533:8a63:1c52 with SMTP id d75a77b69052e-5359fb7159cmr34753721cf.49.1791562093213;
        Fri, 09 Oct 2026 09:08:13 -0700 (PDT)
X-Received: by 2002:a05:622a:598b:b0:533:8a63:1c52 with SMTP id d75a77b69052e-5359fb7159cmr34752971cf.49.1791562092510;
        Fri, 09 Oct 2026 09:08:12 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b6fbdcasm21186091cf.5.2026.10.09.09.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:08:12 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: NeilBrown <neilb@ownmail.net>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH 0/3] cephfs: prepare for changes to VFS locking
Date: Fri,  9 Oct 2026 16:08:06 +0000
Message-Id: <20261009160806.2457654-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929025331.1436824-1-neilb@ownmail.net>
References: <20260929025331.1436824-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Neil,

NACK. Please respin.

-EWOULDBLOCK from d_alloc_trylock() just continues, so that name is left
out of the readdir cache and skipped is not incremented. We still set
DID_PREPOPULATE, and a later dcache readdir can drop the name. Treat it
like the security skip: skipped++; continue; so DID_PREPOPULATE is not
set and dir_release_count is cleared.

-- 
Alex Markuze

