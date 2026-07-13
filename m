Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90F381E8F;
	Mon, 13 Jul 2026 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942512; cv=none; b=cm6FEOx296U0luGWTz/zDXWzdUieZ4yDK3sU4ygS75FA4fe0/+E2hlMZCRIvjJy+QjvGjj0YM/3LF25MUDCgteQ3+1yK4Pwd1YtGf+RjwjR3ig+vaz6uOBA4SqygV1woWVpVm/GAeSNzCo1GSlrdoQv1InJKqqtsfwlphwfE/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942512; c=relaxed/simple;
	bh=LLBoGs+5OjljHKgcIDOAZf2qfHuE2y8SQj/UDT2FA9U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Uq/pKeiFCOWtK1udZ83eh06Wdv3WYZFv4z4InSJSQIHMlH9oZp/l3PHbi1x3wc71lAtB3fsCv2anVgTHpyNkQlZg3H3WuE6pUS1a/6qXYZsWMlqHyWqAr8AtIkT+IIfM3uOWmnSaLYoKCVF5FSNuqVIgKehOo+rdL5WAviu3Bro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mrkDVkbv; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mrkDVkbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783942503; x=1784547303; i=markus.elfring@web.de;
	bh=/P9go5fW3hSq6oZsnJDeRWaFNKujnK1siD7WG3lNLX0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mrkDVkbvtJm+n9kKQ8hb5DchvOnRY1AkpALJx/tdqM6haTmM0Xc8Qnk5VbgZebBP
	 7zKxycaX6bSKjPCfddCrLLajEtbUCnPwA5IdUK+YsqKWVcdufBs468vKrFjeqAQBd
	 OIqzQBLphx+MhWNesYCvrNDgj8EBf2GZTOXFSUHbPjhd1lwYE4AtQs1W8PL5f8aj9
	 V/OWT6pMBJIC+u/uAjAv81dCVxaetECLwyXf7/42HF6TWzCm/ACx675oWgGCxT+IC
	 qw4j7oXNAy+wlLXNzlnUs1k6kkbgFQeUxNM+3T1YyXeA2m2ZKkqefzOWxlvz/n+xh
	 anhflgbyQx/84Cv/qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSFY-1wVTGr1niI-00VNkW; Mon, 13
 Jul 2026 13:35:03 +0200
Message-ID: <5010d7d4-e321-4999-aca6-1caa040f3037@web.de>
Date: Mon, 13 Jul 2026 13:35:01 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ceph-devel@vger.kernel.org, Alex Markuze <amarkuze@redhat.com>,
 Helge Deller <deller@gmx.de>, Ilya Dryomov <idryomov@gmail.com>,
 Kees Cook <kees@kernel.org>, Viacheslav Dubeyko <slava@dubeyko.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ceph: Move a variable assignment behind a condition check in
 __ceph_remove_cap()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dw0CuXB0vBUdArzNxguiQA/upugsWQgKkab+XYDSPXcUOsuFLDP
 eeavfxb0KXT/ZbLV/Ahi2XasmQamG3dzpikGBWjQhBW2IbyOJBr8vuWLBOYaCNXAqpgdbHV
 zhwA3HfjyHCMRwloL38I/KLcQJnk4KAdtvB1+tJEPIcsSlBL4DMWKlqvvRDNrQSyMMkuJKi
 jRLBfGBK2qhBc6sPNUuHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Co1HuXdkwP0=;bkzwnZ/QQBKUBDyy8Poj2IQGvVS
 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
 =

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 13 Jul 2026 13:21:29 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9C__ceph_remove_cap=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cinode=E2=80=9D behind a condition check.

This issue was detected by using the Coccinelle software.

Fixes: 38d46409c4639a1d659ebfa70e27a8bed6b8ee1d ("ceph: print cluster fsid=
 and client global_id in all debug logs")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ceph/caps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 4b37d9ffdf7f..5b6640707949 100644
=2D-- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1124,7 +1124,7 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool qu=
eue_release)
 	struct ceph_mds_session *session =3D cap->session;
 	struct ceph_client *cl =3D session->s_mdsc->fsc->client;
 	struct ceph_inode_info *ci =3D cap->ci;
-	struct inode *inode =3D &ci->netfs.inode;
+	struct inode *inode;
 	struct ceph_mds_client *mdsc;
 	int removed =3D 0;
=20
@@ -1135,7 +1135,7 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool qu=
eue_release)
 	}
=20
 	lockdep_assert_held(&ci->i_ceph_lock);
-
+	inode =3D &ci->netfs.inode;
 	doutc(cl, "%p from %p %llx.%llx\n", cap, inode, ceph_vinop(inode));
=20
 	mdsc =3D ceph_inode_to_fs_client(&ci->netfs.inode)->mdsc;
=2D-=20
2.55.0

