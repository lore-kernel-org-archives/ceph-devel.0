Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481BF47D952
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992459; cv=none; b=Kx0UONHzfzWc+oX1lbieG3iUKySmhzrBmqrcdyxOjJzyzelIJotE0yW3uTKqULBXXENZe4weqhe3WfV69ULiJ5CCPJDWHztvmw99mH3Tty/YSag+8if5NJL+z08EgB3NfPtfEnyJvBN4Xw2aW0GaspkdBuAgjYJtSvWfPdfKl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992459; c=relaxed/simple;
	bh=GJT5i/pcR7HpM76168O1tAXqiA22p2T/SNbmtxsAclA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YKhUOUAk5XH+/kpFJ7rOVUlaQjj64OCUX/Im1sr9oW7OLpO2f/CjFXLvCgrJ6qn2ncpSqUbjiB09tnjuJLCU0HAv+qVDCKPIETIbTatcW+LnVYYCHJBoT1cdWIVHQWx/MObdqZC+7nQMUDdSfTnSoC0b8zc9waTuaEzhKLmvueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzX3M7TE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+C5hRhj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzX3M7TE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+C5hRhj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782992457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTi+Sx7N7fK09Cii1Asg9BCdIvBQJGxY4r2mNqrCbS4=;
	b=SzX3M7TEdwA8RovANsREvvJYiMh0ARJflAMlZBgzupcTgVGRMEPsCp0kUvCEhoANB5kCGA
	BfYHwyVxf4EM0AZTaoaCTk4CWhhoMPg6RTOzGvCFC54ofbBiIC03fGSoelrhHjjMtItRfF
	77eD9UJTBKJxiYPvUNItE7iWdNumbds=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-j3nY9-_pMV2_9vD7WkoWvw-1; Thu, 02 Jul 2026 07:40:56 -0400
X-MC-Unique: j3nY9-_pMV2_9vD7WkoWvw-1
X-Mimecast-MFC-AGG-ID: j3nY9-_pMV2_9vD7WkoWvw_1782992455
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7eb641eaf5eso159420a34.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 04:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782992455; x=1783597255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTi+Sx7N7fK09Cii1Asg9BCdIvBQJGxY4r2mNqrCbS4=;
        b=H+C5hRhjtDswXb+c1OUpHoMGWmqsISanNGs8+5imsfXRX9zcefpQgoljKIP0zUH74h
         bIMre0TGZXclBPKprHWK5h2XOGET3geccptby2iP0bAmO7De0xEfSMKVLcb6gx4LXqRv
         /LRRPqN2zCR6NTbe1NlSVQX2AFvy9kaeOY6DlKYvS18oyaZafOKMyYl3y1Hasv1B4ype
         2MvkUjt2yqUb7+8iR8wy+Yr/F0PRTom8PPT5KsLoEv+JYyYscj4MlfuDktjFU5skQBiW
         gCZnU+IE3E1uBFi562apfnNxY31vRBOS5a8gxvjLonE5nafLTPqyEgZVZDW2CL/wF8XF
         0k1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992455; x=1783597255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VTi+Sx7N7fK09Cii1Asg9BCdIvBQJGxY4r2mNqrCbS4=;
        b=qpHO0FeCwlx7wQwQ6Yopv8u+9nD1lCxZFi4zg9YELxGQD3P1m8xIq5AFQiXQvSvPeL
         modFf8Jqt26rF6S08SCRDouEfAyLYc0Pm9GaJ8AGjMsgs9AjS0RAJYoCK13hwP9nlDHX
         3t6VC2jQWrro9qGZoCryhLP5iYwtsDNlu0Utp0OJpCQihVXLvvu5mpgUagYEttAoAT8b
         SygsjUaA6ggiWJW/uqxumf6d6An2TFY2ep55fZfTLprYmvr28mJ0V/kWbVRsuGi4K1eC
         NZ7Yo75dPN+puTUjoNWTYC+TbYjrj7A71NuQC7sH8kmfcKvzSKb1bgken3vv6kObURo1
         Sk9A==
X-Forwarded-Encrypted: i=1; AFNElJ+sWF/GBo13CGrFXDt6xzhmrsS2gMNhdRbhBXcBQrMzp9yKs1bH9ABIYodHMG7QrHjaQ5/tpi230kEF@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAW7aYtkaiEsZH/PmPXlijsrRR7jft1j9x+bpercyDm5vaw2a
	XgDrl3dXlsd34zT0KFZb4d+FXgmNgW9GuBRaZznhbZ8cbFfvpqxrNzoJYd2PAemgrD4shvmFV//
	AkW8dDwYfnvmpzAkp9qF7+mVs79DyJ7yRQuAE07bJgg5RIH6ejhKrJsAokXlUChI=
X-Gm-Gg: AfdE7cn0/ExOuL+CpidGUT+jLQUeVHeNMbKlPKMmduuNulua72Q1r2T8N6XRKWmgUVw
	mMpTzOC5CmZB+DI3sSJOo6rkrFJzPZneAx95QBL+ZLnmKaYXU7dYQXuMpqLIRhX4VQxOGEF+AeH
	fDBXwQI+TGHwtX6v2Zt7Kr7xKMU57XuK5UXNOLCiJPKovE9AQ/ycHOYmLFZznm0QiW22G27Zzaz
	UgEg0AmnttdFPapqsonrrev9opnax2otS0VexWclSaNwCy7hKiddmIwh9fiJwrrndp8R13u0GCW
	Eql3ZypTvHp9shtHdGRvSZ6Njru0AEm8cp2bOt2NFKPK/5swKYlcFu017AXY1YUTYlm0nCXPBp5
	LeYAd
X-Received: by 2002:a05:6830:81d9:b0:7e9:ea18:d1ea with SMTP id 46e09a7af769-7eb505737eamr3184449a34.28.1782992455450;
        Thu, 02 Jul 2026 04:40:55 -0700 (PDT)
X-Received: by 2002:a05:6830:81d9:b0:7e9:ea18:d1ea with SMTP id 46e09a7af769-7eb505737eamr3184440a34.28.1782992455088;
        Thu, 02 Jul 2026 04:40:55 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb545515casm2206351a34.27.2026.07.02.04.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:40:54 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: pengpeng@iscas.ac.cn
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [v4] ceph: bound encrypted snapshot suffix formatting
Date: Thu,  2 Jul 2026 11:40:30 +0000
Message-Id: <20260702114034.917507-9-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409110001.1-ceph-v4-pengpeng@iscas.ac.cn>
References: <20260409110001.1-ceph-v4-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Pengpeng,

NACK for now: this patch does not apply cleanly to the current
testing branch or linux/master. Please rebase and resend a new
version.

I tested it with `git am -3` against both trees, and both attempts
failed.

-- 
Alex Markuze

