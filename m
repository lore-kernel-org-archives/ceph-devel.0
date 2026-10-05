Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35A47F3C7
	for <ceph-devel@vger.kernel.org>; Mon,  5 Oct 2026 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201687; cv=none; b=QLs6hcc7OAMRacaIfgnefegWPYnOOlw6hAV4fr25uWNwLvQyQItTGCSCAVcfM/57Dfzrb3cBipA0q02DMpr5iQYFEj+BlTx/thbc/ZgHB72xJI8/Kt2yR00UAk2ldhK3ELzPrJ3ZDJPgUJS4ghj48x/zZ7j01p+LZqggLDd934U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201687; c=relaxed/simple;
	bh=onU/5/kT1hiHwApG8rwpT3PI4XbL2fj4IPsBDnGXyqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gueyJbjbT4YSP//uSx7kyozMOMsK7ChuiO6tw+cKUsDZ09Z0sGTsXlZdcznJ2nRVbRj6ui6vRaesoUziXrSynYMGXW6Si/qiB79tL3BNApG1tPAaeqr4567wXDYYeZ4FI8wuZmAWUhbXvf6UDgdxWUubNw1sBg5P851ow/sxQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYVjw2au; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4qrIYfI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYVjw2au";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4qrIYfI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791201684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
	b=HYVjw2aub0AftHO7fNUUbZmWfAPa/S5jlThWWNjkncBi3fx3i6Ft6ttXYamH6Qe/5F1dIK
	SelqfEV1f0STisL3LWG4lgQKGJNsgY55aKqVOn1TR7HcWAnWuHqCroZEk23QdmQyyGQe6N
	omJVNdiOpniI5qKkUGytmcdgyq+z9as=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-0xMqtxuJP_yVZv-LUckXqA-1; Mon, 05 Oct 2026 08:01:23 -0400
X-MC-Unique: 0xMqtxuJP_yVZv-LUckXqA-1
X-Mimecast-MFC-AGG-ID: 0xMqtxuJP_yVZv-LUckXqA_1791201682
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2e77b7738cso162216866b.0
        for <ceph-devel@vger.kernel.org>; Mon, 05 Oct 2026 05:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791201682; x=1791806482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=K4qrIYfI9cNXWjnryqTzfiY4kuxC+MKUYh9JJDObne3y9vwBmR15xWofqHr8TD3SyF
         Y/kN+pz9sKrILsefsqGNTUFvOCNOTjZPSPxjmG9zWOHSQaN8XnydEolUPRa4TjmYmf5d
         PYauJUK5YX6RbQYos32wjA0RDYKV/tu6dg+VYqmq+fz7M77YeSrJrLT3rbh7P/t/HMM5
         /EfKhR1l+jU50u2FouGx+9CI3TPsy5DQRnrLvF0f/pyp7qDRgSqe3ZsJR4p9okm96uuy
         EeTx/kw/1LiGMilZ1JdoxHqoy3ZsIRNOLer4sD4GGHG0UwRX7AHxa8OjN5/qj4fSM3ZK
         Pusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791201682; x=1791806482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=xREU7i3S3YNeGMKx5zC9712+TJWhM5Q8lE0zRQ67wj8Oq/kXepR+ZJasitbxa97441
         pMm9HDTQNwOaq/vo5+v1aXsCaSK2+g/1kUZA13tWTL/4qaiNRBkwiST4CnCa8QNjcQmO
         ljjO256PoIjl5rcx8iEyVAzgv5j/ZiIo0JqdlxjklVGCzgi+oSc5ms+3JNveeBcTgWS3
         1Rzq7zsiyERwbX229ZUo56pH5He4X6oFM23N/w2AUsVgTFWRlBK0xOJiGv/7hLkrOoz+
         VdIw2lSyAoiwBu6uV8o8oGFOsalVE4iYfEArVGlELG613btvt+nNNswUdOGeTayi0t7A
         VNVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhvHK1UuUCU72dgcalFk3WbXzJJVukhZWXvVdkUgkuWTv/8z9zcnIRx76axixc04uEMKXGTPWHSj2U@vger.kernel.org
X-Gm-Message-State: AFuF++lP963Wv1DmxqbVhdOOFmkJX3KmCz+GFjaA6UHo02g8RXWww8Xm
	oHioVXt3sLyfEAwp0RUcqtNiTWcYkXFHlcCCxJdApKE28ydI60K2CNT0Fho61L8Relirnk38h+h
	VxUItpQQ6ApQCHv6GuYvpXjMngYpFI0xNM4qSXPYkvX95XtYdLDWgxequ/QAwWew=
X-Gm-Gg: AYBFou3xIJW2W4sZGyn/Te2k03FNWLoHOCxig7aW3LMiNMUjxDqrGrfOvrVf5/Z9ROx
	MS3E9s+hD2WWHtiQntwMhcO54uB9GMPlrFLH0vP807ymRf5vdzNKeRCE1yzMEOyVYH6IPvr15Yp
	+6rPMeMQ7EB/oaGnc7IkFrbi7ByUZJ5q5rSzc7zKNa0nOkwt5Wy7/VBv06UvPHtyvmFr3CGpBGB
	fwpOSFNHFg4gajBZucoKuXegHgIwxn9I3NBwGFID8UV0hFbos+7hhSQrx9U4Z1N1D1ve456cMBH
	njWoMVH+Ahe+VRfSIvkZ95wwSPMf+WKtonA3PSX5hZFHkSl/bVLWRSWLv+PU4pK7qVcllSkQTSp
	wWO1Bg/jTeLWe7LR1vcSMoRoB3sKz+i1YbqBER4Jo5YfDALwTBNLq2h/usK2BnKQJ5biTitsX+q
	WFjrznFgQTU+kW2w==
X-Received: by 2002:a17:907:daa:b0:c26:1649:47b2 with SMTP id a640c23a62f3a-c2e4af9af5bmr947230866b.40.1791201679128;
        Mon, 05 Oct 2026 05:01:19 -0700 (PDT)
X-Received: by 2002:a17:907:daa:b0:c26:1649:47b2 with SMTP id a640c23a62f3a-c2e4af9af5bmr947221766b.40.1791201677701;
        Mon, 05 Oct 2026 05:01:17 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31562dad3bsm66678866b.40.2026.10.05.05.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:01:17 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: libceph: Only allocate new front segment for oversized reply messages
Date: Mon,  5 Oct 2026 12:01:16 +0000
Message-Id: <20261005120116.1913226-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929141042.80544-1-raphael.zimmer@tu-ilmenau.de>
References: <20260929141042.80544-1-raphael.zimmer@tu-ilmenau.de>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Raphael,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

