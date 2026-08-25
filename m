Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFD3488D9F
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694523; cv=none; b=bzsGqPvMAgSPWTlLjayHqQJvGOUL2yffHcUEDcBiFhYx7IzFzd8lMbQ6QDoBgp2s5HCV+udyoZmFNn8YA4TP1GTT8rXXbQ/TIsiwgDB0TrY6xlJEnraiP477SiOjhai7jGFvQvOhh68+5bRDAsiKIqZQIWvDC5+cZ3F9EAQZZ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694523; c=relaxed/simple;
	bh=8P0IP07UBeLTFoYx25sPxGAu84//vWX+hlsH8IveB2A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jo3MKq/4sT6KfCaU8GXtdUrEnrdNxxcDDahUcsRT9mCwvUjlP5ZsnqAMzA5hsnIYsqHpSt32MUxkjBGXyDFE8XxLhWiEEIWE215SSG3uKCfldP0H9yPVfjKsrgVuTyv83V+IEUIv1SA/y69H5HcX3uzrEg2w9ONkzj6/2IQOLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=d+gmRyp/; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=a3Y6TOw6; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="d+gmRyp/";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="a3Y6TOw6"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PKYJLU2398872
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=wiYZPet9b0aflmyUZYFQ6PIZhz
	rlzE+lDn7s+y/4jkw=; b=d+gmRyp/gSMZXZ/0oss6gm/iND7IZM+tQ23pRErVHj
	g0+5zSMHKehZFYzcIn9nYzHzlULqrcHmkhxtiNmR/yi1QFdIm0gHbGNzVYJbFwNc
	f2Q6lL8PRDyt4CX0PcURlJh6pCvTeYlO3MXx9JQTL0Uu5cQiXDgpmDVSenGnDbIc
	R67vZg0p/Np7G+g01I4kOTlmdiraC8pUFmdIp/xr+xgM6oQbaFldQ+fr3rmuOrSq
	qJyrOLjcCJJ5KClUZKqfYz1YAgFqrlA8gFihE7d1tz5JehCPXkKRuXFqR3zyae87
	upQbfIyoUX5/GE1tocGXE9EpU0olOIZ5Wk6GRYvQ0a4A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g9ch6ke35-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:31 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52d28f8737eso5386671cf.2
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 14:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787694511; x=1788299311; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wiYZPet9b0aflmyUZYFQ6PIZhzrlzE+lDn7s+y/4jkw=;
        b=a3Y6TOw68XEUsD+va6Lnl+xJ0/Cp7Wj42b9Zy3huRQe98SLVzX8natbGKXRNYYux+f
         l/F/IhI8Vf4GHss9rdneTtyspnVRU6yHPZ0jptGWmSebV0PhKhu9TZciDmqVKne5uwa1
         t4jR0GbwVppWLG4eYEQJL1DTl9BsQo5HztCqeMax3mB9/jYgXEIj7obXmOUwPWAdSSiy
         tEwzaGAFf/4nOTxC2pw3oNCPigThuUcFMdkemppMFiS2a9CGZL0NnD8CiQoHgHwA1eAZ
         7NwO1gdEj0CZA1122yD4bjC3rRaeyZTrT+80gmQMGYEOxizmiMabqd5bRe37EEJp7U0M
         QJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787694511; x=1788299311;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wiYZPet9b0aflmyUZYFQ6PIZhzrlzE+lDn7s+y/4jkw=;
        b=tRE4qi2Ty2mtWF+g+6VX1yLDyZyGGP6fK2CDlm64nVY7XTZ7U9itpfLdbnJR0uqaAg
         0QX9nMkvMmZVygY1r8xZ8Cs7FnIXJnMW9sxx9dXrLPrFXAHPhfTSV0k7eV9UBBrwP4ZK
         PvV5LEYhq4Pv+z66TZBKVq8sEgi0zaUkXo1QOCOqrDxgPJRUFecA5wjtzo2IG8JPGcYi
         5lehlfTDS3otM3bOT6leybDO/YQlDp+NF/Qsj13a/O5jABLjMDH00NgJMlqRw7WXFr0/
         FtoxhTD/eq7knggK2y/NcxCulPycoKZAn5KA9yQR0DiwPYv5bfrVWpaU6v+u/TjjaQTI
         +ibw==
X-Forwarded-Encrypted: i=1; AHgh+RoggZm2tWKqIClNbIBsugboBjdQOngUAn/k5Wj+YBuHkTtEujg0f2iF12ZDWzsxC057B1mt/z91MheV@vger.kernel.org
X-Gm-Message-State: AFuF++knDY+eav/ONGxdyY01NuG2gg4tbHBNv+AlGKO9TKb6HWOznWTe
	kClTkyTEo0is8Sd8CxuWp2c+tzqSpm2epid1KyNNznw/ZeuvBb0m1Z7N9VEGaqB8lbEMgZsuJc4
	NdzyEWBsLTzJB8TvEx3p5L9XiD+nh0W5+qeOCnPGhSicJM0QrTcL/rBYO7QqKG/1sCRhUhQ==
X-Gm-Gg: AR+sD13K1w9nvWqCxXKS1nMQ0Htjn8ERvXEEdWZ0D+dgR1Y++lgvCkP3NSprt4NNrHR
	vPmJU13CkusZrj1LeIgvo1h/3R+lVqqXuMUqLW5VIAGeypJD3Q5o3uPSES/zf7wYkJuYOSE1uEv
	xtYg6ua1EAvMduv32SOBadefjCFI8yBIrboAlWjjDoX95IBMihvLAu72sdqz6/PW9Qn70+geZBs
	sizIowuo9G7NVrjGFVfcdhf4HWOjTXiQE/s4HlyRDCuk4r7oXErviDhUazCbWxd6fVpaQpWrcV2
	bypvcCH6B0ZzVC2zE8Eu1XlPwpucdZxtSA0RLqUQHerBHgKOMrItOJ800/vu6DRxT7/fJs7JgNQ
	35rjD7f1MwA==
X-Received: by 2002:a05:622a:6189:b0:52e:2d4f:2219 with SMTP id d75a77b69052e-52e422daecemr25747861cf.9.1787694510982;
        Tue, 25 Aug 2026 14:48:30 -0700 (PDT)
X-Received: by 2002:a05:622a:6189:b0:52e:2d4f:2219 with SMTP id d75a77b69052e-52e422daecemr25747361cf.9.1787694510538;
        Tue, 25 Aug 2026 14:48:30 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.157.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9ef8ffsm139207566b.60.2026.08.25.14.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:48:28 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/6] ceph: convert the inline data paths to folios
Date: Tue, 25 Aug 2026 17:48:07 -0400
Message-Id: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcNjmoC/yXMTQ5AMBBA4avIrE0ymviJq4iF1mBEWmkRibi7Y
 vkt3rsgsBcOUCcXeD4kiLMRWZqAmTo7MkofDYpUQZXK0fA6odhFLOPgFnGYldr0WhFVOUHsVs+
 DnN+zaX+HXc9stncE9/0AO31uHnUAAAA=
X-Change-ID: 20260825-ceph-inline-folio-17bcdb200850
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787694507; l=1303;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=8P0IP07UBeLTFoYx25sPxGAu84//vWX+hlsH8IveB2A=;
 b=ctsY8X8cj4NGu1LApV8kQBkVrU4ej4aWAKjlQ8X06aVcJ/n1A9jfbHiLDvaTPO5h4VBrcJxF+
 1pqHgrQXLRABNWlmBulVw5LlPlhog7fEtnZaxVhA/cT8ZuzjmJFLw36
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX99rSZ66F3oM/
 7nLH4Z19Cxrj50V5i7sc4/XtXHxQLljK899CGiggovHp4vO6H77GOvFemT/H5wp2wR6wd1iXGes
 ft0N42yizHZP3SJFLCwnlVWp9QAB4QDEJgd00x2loU8tdIU2Edu2
X-Proofpoint-ORIG-GUID: j2lYBAnGdgcI3pepix_pH1UumiEF7-OS
X-Proofpoint-GUID: j2lYBAnGdgcI3pepix_pH1UumiEF7-OS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX+KXFvpZJ/dgU
 vZA48WD/r0WgQDba5/OOoExuyHweI8V8NIMw/8HPd6M1xn+MKW5fBOPyH+7RXvS58ud7eJciwCS
 GgC6nXj+80S+/Ds+D+zGYbmHMPSjzDszFAki3Ia6yjhLMaGrPYb6Iw92jT3nG4Ib7YnCXW/PU31
 0xfenqL0iYdCGUTmaQ9KwRtWgurZJWf8YD6qDOVYbPUip8+KkObbN+MASXB8kvyvvRtVN9cArDP
 SkMp8GqRYgAFDOrEa8nydGiQwiZX5b2FbCmFMKaNhKEjic/yJP1gQ6M1zVqNHg9poeiQzrUE6T0
 GNKV4OBJJaIFRKxFyDEkSr46rbhqdLVhV562ORKPrQKu6m5L7JaAC6kVM9UorG4v5tisMwLwWt2
 Hiwwn5azZGTFrybW1bg24AmDzUVr0zzU2h3N7vY+PGYQOs3+Q5SbyGbkR+tGW7Vi6j+DgZE6rdv
 ihIDF0BtgeryM/hWh2Q==
X-Authority-Analysis: v=2.4 cv=F9JnsKhN c=1 sm=1 tr=0 ts=6a8e0daf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=VsYqNs1x6zyujO4rtox2PQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=QmUrSfd_21LkD5da6y0A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11886
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=10 suspectscore=0 clxscore=1015 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250185

This removes the last ceph callers of find_or_create_page() and
find_get_page(), and one of the four remaining calls to
__page_cache_alloc().

The last patch converts the direct I/O put_bvecs() to folios as well.

The remaining inline data struct page use is the single-entry page array
in ceph_uninline_data(), due to the OSD client using page-based data
types.

Compile-tested only, as inline data support is deprecated.

---
Tal Zussman (6):
      ceph: use a folio in ceph_get_caps()
      ceph: use a folio in the inline read branch of ceph_filemap_fault()
      ceph: use a folio in the READ_INLINE path of ceph_read_iter()
      ceph: convert ceph_fill_inline_data() to take a folio
      ceph: convert r_locked_page to r_locked_folio
      ceph: use folios in put_bvecs()

 fs/ceph/addr.c       | 70 +++++++++++++++++++++++++---------------------------
 fs/ceph/caps.c       | 10 ++++----
 fs/ceph/file.c       | 32 +++++++++++++-----------
 fs/ceph/inode.c      | 14 +++++------
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/super.h      | 10 ++++----
 6 files changed, 69 insertions(+), 69 deletions(-)
---
base-commit: 86f405187248b7a5a2104eba07f941d27593893e
change-id: 20260825-ceph-inline-folio-17bcdb200850

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

