Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D437E5D9
	for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2026 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481751; cv=none; b=OdrF8e2vCBBEXr9V4Ip5M9RSRE/ur6aeS7EfwOFuYU3FRJmeRscGBAAqmVSqgpfb1nutiBaJsn/N2IA1IeKNyxPWL8qUlSw/3gTVXxDqc3ADEvYg4tfLWUuSoDdOntIbcUi/VA60vRAS/x/8jP2sKn+DMyReyjrKscpinZ5zI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481751; c=relaxed/simple;
	bh=pDG+LUYfWE/lg9GV3EwC7bNAC2luO8YmosElSYurcVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rViCmrxj2jal5eLVCulW2Y9WvCfBFXf5/PrcIohrCFz3SZbn3cdf0wqvCXbER2/KrkwoOEOVCU0wQKBZKiEESmatgugf8gYQ7fVD/4zpnsNuEs6Pf4QT9YP9CGPJzlOE73O4hZZTKX9xoVhbwiA5NHNUoaYIKPJNgD6mcLF6ay8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ur26cBfw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fghsZbQI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ur26cBfw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fghsZbQI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789481748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
	b=Ur26cBfw/sUGDZVxXetnepJvA8SZZOFfK2n1+Imgy8TOB+CCWsUoKR5SLc3hygI11Y0HV3
	XN+GGm4ASqVedOoUZ0iYZQbS152Xjvv32PRA2d76wRcdNOXk7aSHe7GLN03tvGEKUIcfyM
	TjPcJbPXiWsq3iKlOxGy344EHMSKmb0=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-AoYkI__EMNOZRlab4sTD8A-1; Tue, 15 Sep 2026 10:15:46 -0400
X-MC-Unique: AoYkI__EMNOZRlab4sTD8A-1
X-Mimecast-MFC-AGG-ID: AoYkI__EMNOZRlab4sTD8A_1789481746
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-97e9e1dd7fbso3445373241.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2026 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789481746; x=1790086546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
        b=fghsZbQIARSoRkm+8E9i4+hn7g7mpXQe6tu3Adia9t2ZmyGSVuz3vNDxC2MaDvhGL9
         kzKGUASIVIU0QqyoxOyS4XoYNhq94YChW+Acu139mgVEhvMEuXZKy09LX++tqJ0ZbvuV
         Vip0xl4zs8bvJmhv9Y1Ej+5Ae8TZqZLB6ZQ7egrke0mfVpsAtwkYprl/7gElvQPN+4LR
         8rY73OGx4wGNw9TtVwtRJWNsmoTVqrz+kfj2pd1PFoFgY9a8LHXc17MA0YDL9qsSX2JN
         AXAg3qqYcJSuGqbalBqLLZscV8Ij5HjlzDmCqvdZ4uhlFbN8i8tYvMfbc/A8OFQV2ZcB
         L2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481746; x=1790086546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AZghb44QKWgY5PpxdFfd4Kvsv/MN9iR1QhBDgr3BDCM=;
        b=lUgLzFQ0zj0LSVknq5TU/gRdAIv2HouaYFu6xWozZZ3LvoUOG736RRispMbRqwl/hX
         Gl34aGaqt5zqEbZUbCH4xXQyFJeFxyQkKbJifTNd6Zhx2+ZVlswPy+JyEuGTnCnINYmE
         I1y1nqefifaN0VWJzNRYkF7PsGEHA7qGKJIAo+dhCnMmI/2RjL+KdkYQohwP53RaIvKw
         qjThW5FUNc+CN9JKusPcNxUy+72tQ1wHXATCdbD0Ka5+P7LRumfoGG7o7k5RvPoDWQ8o
         gyrm+0X+XmHew+nOxkZrPlCDV5ebHsE36VnvpoIdwLGqBnEz2Ne5Q2xbwv60fTD1QCdy
         gzPw==
X-Gm-Message-State: AFuF++ll13qTb92j5nziNwHX/WyNG2fwiwAs0jW84KYMjQc9qy9ZS06x
	5zU80AWU65dOkFDr/f87i9KNSnRz/8lsgab0FW7j4aAS8zV82rpuF4GQ5otFVBUsTzUrfOs2fMQ
	vw3ApYUScQ24VMHxlql0xnsaEOLazjbkjPucKJV/nq9nx/KKEhIyx3hVCSZp22MuYRIW9jtulIA
	==
X-Gm-Gg: AYBFou1I2TK62PAqjNETFHu9o3XBfuG6q5J42KkyNMEZj6V3yCZxhe8Vc+zHxiGWODx
	RSNhqcXrHduiuMsYVSxnUCcNO02xFZs0u3dE5lcXfSUSxbncLr/LoCLsH5n5NkuRC0xfzAZ63dq
	4XtMLU+Gr3JDR8gtgjuE63k2nXFpEWUuh5mO3sOlZvvtnchEgfeXeerf0RdypKZgoMpcrbNEHaB
	Gp2YlRXN5Ccf0HjL7wDdi/QOfZI/8bnDGXn5z1m8Snn0NGzqrrGVVsJW0GClnw1VuNyQtmfMMzE
	ii6vFLSmmVoL1KmCrFDu9Nv3Ul/zJinyJ17l9xNpD4jgm1G49SkpTEJa65pNN+JUfmqJ3cstynW
	BLcfGKpty8xlF/DegC/A+ebecqzbgGILF2OtDqU3VofWoi2gQVh6lIg8J+CNc15ObjbDhcH5/pZ
	nXx5Ga/I/GVlkd5Q==
X-Received: by 2002:a05:6102:548a:b0:79b:dfbd:d0f7 with SMTP id ada2fe7eead31-79bdfbded2bmr7251041137.0.1789481745719;
        Tue, 15 Sep 2026 07:15:45 -0700 (PDT)
X-Received: by 2002:a05:6102:548a:b0:79b:dfbd:d0f7 with SMTP id ada2fe7eead31-79bdfbded2bmr7250961137.0.1789481745303;
        Tue, 15 Sep 2026 07:15:45 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-912334f822esm27377556d6.25.2026.09.15.07.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:15:44 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: reject mdsmaps that claim more than CEPH_MAX_MDS ranks
Date: Tue, 15 Sep 2026 14:15:41 +0000
Message-Id: <20260915141541.241857-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915051924.737109-1-xmei5@asu.edu>
References: <20260915051924.737109-1-xmei5@asu.edu>
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

