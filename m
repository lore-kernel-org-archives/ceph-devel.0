Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8AD47A896;
	Wed, 14 Oct 2026 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969359; cv=none; b=s9orJ1iTyfWR+Li0aFPpK85qwZX2zQQZ++lrKcoXPfpoyg30yEj0OackFOA18tNefPE9DkQLfI0hmAKFD8YNlSRnj1OhBvYNWFADq1l8YmnjuNB6/4yA9mzNlyKquFUlSTmxRLfSToG0RghP32y03/vYUrJ7kV4DiaeQfpSwnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969359; c=relaxed/simple;
	bh=e919eHiL2hk9s8y/2sLgNs+4hZlY0H7NUJCoZdoR0ys=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=mPgU0qUzjuyTapyOsqcmKfr/pq+lAyGUToxY/fDDvakmCpRDbLS33Qiqe0aBzZ1nikbF6ESqPXSIVAidpkreTK/JhSpX6FSFg6dfWUniTrtyQOvvh9DChg+Y9DMJT+6sI+EDZaoLBzHmFKW3HBK2rNS8htTuwpwrhgzgDYOkgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lo74346y; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lo74346y"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=c7h9NxStB8mf6X4Y/eI/3zCHuR0TNvRC4PQVRQV+NTM=;
	b=lo74346yIJYG8jO9noful8X6rE1E05c49P+qSzFmhZuudFkeqsCHmy87zR2BWwGqo8IyUf/xj
	qdatEVS0twwzejPi0q26La0Q4lKkkrkd/jhAdmamBqcMSxdK3AkpBujAS1WEI6i5fUSRTJyxJHx
	fNUMKcf9bBeHvk4q59z5XKg=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j4QGq1H0kz1prM0;
	Wed, 14 Oct 2026 17:03:31 +0800 (CST)
Received: from whupemp100017.china.huawei.com (unknown [7.152.184.120])
	by mail.maildlp.com (Postfix) with ESMTPS id D523D4056D;
	Wed, 14 Oct 2026 17:15:50 +0800 (CST)
Received: from [10.67.108.208] (10.67.108.208) by
 whupemp100017.china.huawei.com (7.152.184.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 14 Oct 2026 17:15:49 +0800
Message-ID: <b8c135bf-927e-454e-8bca-cbdbae133d51@huawei.com>
Date: Wed, 14 Oct 2026 17:15:37 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "chenyuxi (D)" <chenyuxi19@huawei.com>
Subject: Re: [PATCH v4 0/3] ceph: don't unregister an MDS session before
 removing its caps
To: <max.kellermann@ionos.com>
CC: <amarkuze@redhat.com>, <ceph-devel@vger.kernel.org>, <idryomov@gmail.com>,
	<linux-kernel@vger.kernel.org>, <xiubo.li@clyso.com>
References: <20260904150304.49104-1-max.kellermann@ionos.com>
In-Reply-To: <20260904150304.49104-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemp100017.china.huawei.com (7.152.184.120)

Hi Max,

Do you have any plans to move this series forward?

Patch 1/3 completes the fix for CVE-2026-89654 (use-after-free
in check_new_map()): the earlier fix ee611a750955 still leaves
the UAF in place.  We are tracking this CVE in our
downstream kernels, so we'd really like to see the series land
in mainline.  The thread, however, has been quiet since
Sep 8th, when 3/3 picked up Xiubo's Reviewed-by, and the
patches are in neither the ceph-client testing branch nor
mainline yet.

Is there anything still holding the series back that we could
help with?

Thanks,
Chen Yuxi
