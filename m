Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004672AE78
	for <ceph-devel@vger.kernel.org>; Tue,  8 Sep 2026 02:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788835654; cv=none; b=axcZEAHEpSpDTNFOkP3juUCzswEBbKqtGNlc7PveEEu1r6Sk2s8Ljj8q072YSoheUGs06tZa9SeTG/q8OyoTEQmJpZOiDzjDmjgCGR88pYtsuSBRkE4CtR8h9gJUSqGlluJMMMdfObAjxU97nj28JhMlRA1GfG4aIADWt6L0bTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788835654; c=relaxed/simple;
	bh=vhgraUzZditP5m9BJrWijScOENWvYcl9X1wTzmB3DB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibOIcOW+y4yc4cZwovCmiS2GB08aNEIkmG3PIPg1wGkqN6QNKz33bsaoAMnh61elUa01uZYWWkqEfVueJxLB79nyJ8zT8IYcQYYw6q4suB4KgVfSNN+0JbfyBJPR4TtVxyjHsVftYg1hud/i1253EuChLgRoZyyIk2txxaeuBFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9c715542ab2f11f19a56ed5b684f684d-20260908
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:1cddc4d4-73a0-4029-8f9d-e634862d2242,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.19,REQID:1cddc4d4-73a0-4029-8f9d-e634862d2242,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:7db8b62,CLOUDID:bbdde46b8746025d7a079f1d86fc22b2,BulkI
	D:26090810472429RO4H3G,BulkQuantity:0,SF:10|64|66|78|80|81|82|83|102|127|8
	17|841|850|865|898,TC:nil,Content:-10|-8|-5|14|50|99,EDM:-3,IP:-2,URL:0,Fi
	le:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9c715542ab2f11f19a56ed5b684f684d-20260908
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 780445272; Tue, 08 Sep 2026 10:47:20 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: amarkuze@redhat.com
Cc: ceph-devel@vger.kernel.org,
	yijiangshan@kylinos.cn
Subject: Re: Re: ceph: fix longname buffer overflow in ceph_fname_to_usr()
Date: Tue,  8 Sep 2026 10:46:42 +0800
Message-Id: <20260908024642.163895-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260907150516.3696765-1-amarkuze@redhat.com>
References: <20260907150516.3696765-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> NACK. Please respin.
>
>  1. fs/ceph/crypto.c:433: NAME_MAX is the wrong bound for the readdir in-place dest
>     Jiangshan, the new `name_len > NAME_MAX` check covers
>     LOOKUPNAME/export, which allocate via
>     `fscrypt_fname_alloc_buffer(NAME_MAX)`. Readdir does not.
>     Save the dest size before decrypt (`dst_len = oname->len`) and
>     fail, or copy into a buffer that is actually that large (e.g.
>     `fname->name`), if `name_len > dst_len`. `NAME_MAX` alone does
>     not protect the in-place altname dest.
>
> -- 
> Alex Markuze

Hi Alex,

Thanks for the review and the detailed suggestion.

You're right — checking against NAME_MAX alone only covers the
LOOKUPNAME/export callers, and the readdir path points oname->name
straight at the altname in the MDS reply, whose capacity is
altname_len. I'll respin to save the actual destination capacity
(dst_len = oname->len) before the decryption overwrites it, and fail
with -ENAMETOOLONG when name_len > dst_len.

Will send v2 shortly.

Thanks
Jiangshan
