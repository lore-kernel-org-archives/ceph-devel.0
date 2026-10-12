Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE84540855
	for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789524; cv=none; b=TIxNzk3XszexB3ZAPSH5m81PpuEpUI16SZyAY4x9UqfgFxdHAo8ceWY24ocbi4kQGubRAZVa8V7PUlSwYmDb7FU2nBVrZU0pDuYvps6Q/O8SGrZtt0PSWEFogaCBR+lcoL9veD1PSCb6qaO6wcdrXNe+4oJIVus3YFnO/9LR6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789524; c=relaxed/simple;
	bh=tANiSwK27Bb6N4lauLHQ/pG9GUgh81f8sQ6eq0lsUMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZgfEh/DpMoOV6Lr3rsL63L1QI1+fFEY+V9SCHOKXtotH7ersUPEDwbxRiMYZZ/6G8T3VNZ5Ickbt8K4fZ9ncseMYLxLj9ZdbG8ivXMCu3ENfeDyV7rgpVOll4VmsEe6QrAmC0yWag5oJ5GSfL+JXPyfpfHNlTWcPqNIGR3M8kO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWNWAjVV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVmMx8SD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWNWAjVV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVmMx8SD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791789521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTm1G+nUQsEnumVVtiDc0pNTDXZaMd53rlTRnX3gxUU=;
	b=gWNWAjVVk9rPdMh+B8jKPnwyRu7Da9UzNP98rotGXwkegMnDjcmUAVFpihzxwOcqjteXkx
	DD/HfUSsUieJ7ZNCGK0rSx096MjSVwQRl5UNbPPChIx51q2afMaPhPLshTos2dSWKc/Rsy
	2Cw46In9OdJkl3mqMTls8qGEwJFn81Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-PfJ1OMb8OV6RrdOGii5HHg-1; Mon, 12 Oct 2026 07:18:40 +0000
X-MC-Unique: PfJ1OMb8OV6RrdOGii5HHg-1
X-Mimecast-MFC-AGG-ID: PfJ1OMb8OV6RrdOGii5HHg_1791789519
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2e6cbb6152so151140466b.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2026 00:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791789519; x=1792394319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CTm1G+nUQsEnumVVtiDc0pNTDXZaMd53rlTRnX3gxUU=;
        b=LVmMx8SD4Bl8rRiDWoeRiGec0UwGqlYEUoMesQXYSIStzfuuiOi9gxw7KZLqNuk4X4
         q1GBfZIqW/8zkfo8JJMWNWG36KBNzqB+Kx71WtmDFFikUzMehhvT0hq+721fJQwcvqTD
         ge5lDwK1vcQUQjc+nW/ydUC6NBT18w2uMYtXoLFaqzFFLZNQn4z2MzfdV+UeuFMhbuwp
         2IFvcn0SVLxq703eDDC+DZbkaiiHhvw5I0wzf3kaG5u87JfgswhyI2RFQ7jtKkYEAQN5
         Ha9kdNeXjQszz9uMyU9mGqdhIong4wublqry+x6CG1/sbP0ZeVHcEeX7IuIyc8thoLkn
         wD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791789519; x=1792394319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CTm1G+nUQsEnumVVtiDc0pNTDXZaMd53rlTRnX3gxUU=;
        b=wTUJttnfJgqMwHK1U4XYVCR/UtTuEBLX4pIsLTQnEvpegvXHAa7ZeoQYfRuFv1Ko66
         Wx6NqCyDFLlglAm0R0wXnbBP21yG1tMkpte893N4cbvTaKJL5+frRnGZbp7QakEt/auB
         dlhaLwxqSNJY3Fyvo08W3b7ebHxfNO9U9maozf3mfiLBfHQ5bH6cy5UqkJWybLQOegTe
         szlHqJHcrZ4ubmWSkcF8cz3cWhJAqjP5+q2+qN4GJueFsoqBYnHJYb2kBrx4B11bUlPv
         dXwnWPp2/8FTT9X8Z38X5pZj3lQIOygqVUS1f63mp/ypKuh+TZQmDMQGLHMfJ7iZPKJi
         c5kA==
X-Gm-Message-State: AFq9FYIRWURV0C5G0fT0gF8FAwdo1yRtIOewg0hy2fn8vzjhwuAmdS9r
	5QXhpreSEGKgnUSr71SaXaVdlVTkMOZplLYRDb2a5CAjHqKPi0t+74UBPQRRh82oaskm0Qr1LWQ
	T7OuEtIXmQN4B0B6ZwFkDom+b3xnxVwbGELBLWnro1lYAzfcwq/qBFf2esEhdNn9Ws3cyA3AkeQ
	==
X-Gm-Gg: AYBFou1MCWXBZEspIkQx2KDCndPAgwFA8eb8kUZgjtaa5MtXdXSTfBzxpFTvuRuJ61Q
	1GkQBn1n5xv6ZmGyn+ejvvo92Ucw4jPFkbugLaKQwYzTC4Np4li5MUCtWjFwf8vJH+ZJDvWpZUv
	c3pIZ0iC/WMY5zSz2vH3Cz6E2MqeDOpajPOnA+tXrH6mz3JaaDqqEstTQ+8RSFp74AbUzY5BKau
	46bdCYTxwDFI94VMEW5mwfMThasjw/LUJCvCgsZtPKaCfrE+JsKNc5qsJ4PJX0yXz0NNW2HGHn5
	Fy0l98KDK48+M/EJ+AHmS/x2iSOTMZu0RV9HsQoxR+v0PPB7AYJMPb6a6gBZbV0mZbjSH3WPc0u
	itakdFJ7+xZuEfSvqXt95qG67rIr2mPSjv/eF5Ckq82T/o5vCvK+vK4cwN8UeVmJjknmHcEnNW9
	LPzCXXhle2BWoLCA==
X-Received: by 2002:a17:907:7b8a:b0:c2e:1e4c:35a0 with SMTP id a640c23a62f3a-c31a702fee2mr925554366b.14.1791789519417;
        Mon, 12 Oct 2026 00:18:39 -0700 (PDT)
X-Received: by 2002:a17:907:7b8a:b0:c2e:1e4c:35a0 with SMTP id a640c23a62f3a-c31a702fee2mr925552266b.14.1791789519024;
        Mon, 12 Oct 2026 00:18:39 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a9fffbsm426044466b.49.2026.10.12.00.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:18:38 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: validate MDS reply fragtree split array length
Date: Mon, 12 Oct 2026 07:18:37 +0000
Message-Id: <20261012071837.3427209-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008060725.183008-1-tjdqudcks0424@naver.com>
References: <20261008060725.183008-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sung,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

