Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CC434CFC7
	for <ceph-devel@vger.kernel.org>; Mon,  7 Sep 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795699; cv=none; b=TVcjZE896wre7A3P1C0lLoIP8X6+ciO6Aj/upDK0dS3QH7HOyaMRGVMxW3VkKCgtGlTXroFS+bGZxIUANGFYYe6h9+5/q0kfp4zHyc0zkA5DsSor/ayUkykg+tbP1NdKRCOdtGGSdqpi361t6gGMbi+kP0vdNHC63fBZzZa8UpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795699; c=relaxed/simple;
	bh=sn9pdu77hKCkp9lKuDctkKWt4DiwgzukJq1BRnJq1Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NMkWZF0m2M/jTvtTB+zmsPeJeOYdQCfaCkbagN48if9k0LcuGa8zmGK+pdwl7EwbVzTnDSrNSqhJg558lKxYLrGK+Z+yyyxgxYUC4nItcB4GdKAZXs1Ipib2L6LUERIibLLigGPzZn0orwlzOXU84Tl0uiOROlpM4/GWZOFiE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPooyks+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTFFQThY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPooyks+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTFFQThY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788795697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3p7EuNQM4V9aKvixs/bbf+GgeD9SYUcN+MCH3zJUelw=;
	b=XPooyks+6uFdr/bcqM6J4st1MUH2jUyNjhfUO8LviBaF7G+Gp3GlY66tUPCzSXyhdxK7tS
	Vi0GlVXXb9hUDSLh/sXixfmJKzavVfscdalw4lR1jXWj9sV2Hj3E3uf0WhhIbqAhJSuuqy
	r0MyYXtN/PqCyR5zCIRo9BwnWOk+XDc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-r7fYt7MxP3ilaxfJ1Hqc8g-1; Mon, 07 Sep 2026 11:41:35 -0400
X-MC-Unique: r7fYt7MxP3ilaxfJ1Hqc8g-1
X-Mimecast-MFC-AGG-ID: r7fYt7MxP3ilaxfJ1Hqc8g_1788795695
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1f548718d0so410215166b.0
        for <ceph-devel@vger.kernel.org>; Mon, 07 Sep 2026 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788795695; x=1789400495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3p7EuNQM4V9aKvixs/bbf+GgeD9SYUcN+MCH3zJUelw=;
        b=BTFFQThYcKaMKn79sj7W3zUa9sKVQZ7chhVWjzwhRTIe/tq0CYEFnYGOjr8JMFz8cR
         2FqldOP5Uin176TlN/PXeZWdp1qIxaPuwLjVBYorSqVhI5XBGCSP93qlhwhwMdtghYbk
         er/RyzdZnjvaHTm5iSg4a5nCpM7WcCGVhLUknzbJX4UzjcatkZ/mlPuj5J3QUBnCsqNI
         c5F4xlkXyCrn2ryGN4c9edUTlbrFb1rN6xDPB7fBgFKfAWd8DbTJabbgWcc1ZIElDG2O
         rjzJLYAhQQQ3pTKL1EcgYBcd18KzKEQyjbbryFMfP18j9RJBRk+C5RHwTaZ4ysyhpjy5
         DcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795695; x=1789400495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3p7EuNQM4V9aKvixs/bbf+GgeD9SYUcN+MCH3zJUelw=;
        b=Afg+GAxxu7wDCSKWfKCiZRneR7uGvGZFSbtvOxHCip/FxRyyiAvJeKeNQApdVHuhxA
         zK7o46la93gp8DaV1gFvuyFnrjJ2WAJrT4+EPfHLumsWdayVKb6KA7GixU/p7tJjwQqu
         FXIebB/akbAF1wqVFjQg8ckZrAN7ol9RDkRor5k1+Hy8ftjUjJhGwOo8he4+cldDCbJ1
         GJaOtrWDXAesd+Iojv3Zy7nad9jigbfy44AnHZWQV3OgcX7IAejBiNo2RPU2NR5huZtT
         97s/HP7IgjEDcTDFKrg+NRsfmafyfUbhzwoDixUYxXS48i5LNwBxWzfB22yGCwZCODo+
         v4ig==
X-Gm-Message-State: AFuF++mwzprtJtsZ7ZCO//yZ8yY7R5O9+oFEx9svRXxd4v1bxpbdRPNo
	VbNaBfLIsrveRlzyi6BOSkT5SnmLLbdVI2toWh3WfZiSH6wkOQzbLyX3YBdo6mlfe+vKknuXWd1
	nHKXcj+dx9LLShAwKvp/V8POVjX0QgIWhkBIfuHnDdbzo3U0klcW2SvO+tUe54mMYaZYoSfapuQ
	==
X-Gm-Gg: AYBFou0Cauft94KCIIKMzFdTnA5rU+atTIS7WcvsHlKzlN/tadbYunhAODVZIL+cYam
	tm66WH7ELVvMONy+QuRDUOj49MlwvcwwPZpj/7k9rJBKsdJnTE6+nRXOb4WJu/D+zPD0Qp9XSaN
	Tl5P7HtCcyXPK6o/eL4R4ldx8iovmS9960nKKrx3A41fl4MaFHsBv9CB+H8+pUukDa2fTRKHRnp
	8VCHtCM2KpWGKKBySKyZ142XuVfUt5qe97XetFm4Iqx3u7eA53h6Hfa/lNhkFry8HaCGI+pkVbb
	q36AdXMezmKnh/kFmPaKEOdcT50dvgo8w4KZp2z77HSQzXf8MzfuSNBYCQex5YShK9Gnafw+VO4
	fSP2tLpiryScKo9auNeer9pEoKtE/72zmuJxvQp8QZJVeosvEfp9p9iYzH8tlZ9i4K99p1py7dj
	Mtd7MHjyDDgBbilA==
X-Received: by 2002:a17:906:c151:b0:c26:19de:912c with SMTP id a640c23a62f3a-c2619dea162mr866986666b.31.1788795694780;
        Mon, 07 Sep 2026 08:41:34 -0700 (PDT)
X-Received: by 2002:a17:906:c151:b0:c26:19de:912c with SMTP id a640c23a62f3a-c2619dea162mr866985266b.31.1788795694475;
        Mon, 07 Sep 2026 08:41:34 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5768c2sm480630266b.39.2026.09.07.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:41:34 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: use iov_iter_extract_bvecs() for direct I/O
Date: Mon,  7 Sep 2026 15:41:32 +0000
Message-Id: <20260907154132.3699535-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905-b4-ceph-extract-bvecs-v1-1-b1cf2c92b671@columbia.edu>
References: <20260905-b4-ceph-extract-bvecs-v1-1-b1cf2c92b671@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tal,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

