Received: from hsmtpd-dty-c1101.xspmail.jp (hsmtpd-dty-c1101.xspmail.jp [210.130.137.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF437BE7F
	for <ceph-devel@vger.kernel.org>; Fri,  7 Aug 2026 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.137.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121811; cv=none; b=IHf6M/w3pHzrWUZVApF6sOXskOS90YUtsV5ZLXup7aRZQpj4OQUIDn8UROvg6og8GZVam8Wt+Ntd3e4hpO4/vg280CLuSJJVapT//VR9XiLOGD/p6pteGHSvc+mWuq2E7eQ3P2VchZUybNquDyNf9psm9y8ENq2enNMUbN5GPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121811; c=relaxed/simple;
	bh=IHq2sJRmxAPa1t1rWZYvR3jiSf9dO+lqiF5T2N3MKPo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PFu13PRsUZNicFHkCMZ9fxmmAaAvBcnQQPEWga1DwL3gs4YSBrKZVKJNa9nJt6hHBWkw0vWHMa+XsgbfyQ1OFaG34qapGj1jMaMZhWIaMTiN0NOGQfggGeh7FrDV+yMcaXlbW87ZoAWOXZDm5gEwlxZMgC1xIZYp5qTyiKRNnvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaia.eonet.ne.jp; spf=pass smtp.mailfrom=gaia.eonet.ne.jp; dkim=pass (2048-bit key) header.d=gaia.eonet.ne.jp header.i=naoto1014@gaia.eonet.ne.jp header.b=RrFjF4xU; arc=none smtp.client-ip=210.130.137.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaia.eonet.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaia.eonet.ne.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaia.eonet.ne.jp header.i=naoto1014@gaia.eonet.ne.jp header.b="RrFjF4xU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786121800;
	d=gaia.eonet.ne.jp; s=x02; i=naoto1014@gaia.eonet.ne.jp;
	h=content-transfer-encoding:content-type:mime-version:message-id:date:subject:
	 to:from:reply-to:from;
	bh=IHq2sJRmxAPa1t1rWZYvR3jiSf9dO+lqiF5T2N3MKPo=;
	b=RrFjF4xUK53SyrAnwnyQ5w2YPGZ/C8uW9dZILItsF9OdeCRmzuaWRoGgOFjDvw14/Wq25AvBVOeC1
	 DR54fbRbpsRHlSfp58CTHesSu1yt4YvKSJbTJpwcroAt4SG0XVYNFF/1eMUHStkgDLGVCrecF7sfa6
	 KC5bCZ3bm1ZzXCcST1/KTWWWf/RR8PRzUs3qH/IDAeKtkT/nhpqWvK3QkqRWoOb4Axltpsp81Gzjac
	 cYfqP/3S83nw+3CuyBizw0gRlET8kX2R20X5wYpKvQWV/eXdzDVk2zHyigZkkLYhfybe85c/PEZhky
	 PhXGrDtK4/z+V6qhd5IGldEr8Y0x4jA==
X-Country-Code: JP
Received: from gaia.eonet.ne.jp (unknown [89.187.161.5])
	by hsmtpd-out-2.kopt.c1101.xspmail.jp (Halon) with ESMTPSA (TLSv1) tls TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
	id f34e69b3-254c-423c-bf85-fa4312dd019c;
	Sat, 08 Aug 2026 01:56:39 +0900 (JST)
Reply-To: Baozhai Zhang <baozzhaihang@gmail.com>
From: Baozhai Zhang <naoto1014@gaia.eonet.ne.jp>
To: ceph-devel@vger.kernel.org
Subject: Kindly acknowledge for details
Date: 07 Aug 2026 09:56:38 -0700
Message-ID: <20260807090804.E4428ECC6B7F70BE@gaia.eonet.ne.jp>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am Baozhai Zhang. I came across your contact details and would like to di=
scuss a=20
project proposal with you. Kindly reply if interested, and I will provide f=
urther=20
details.

Regards,
Baozhai Zhang
