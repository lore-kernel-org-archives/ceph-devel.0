Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.24.179.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389130;
	b=5QrgqgLHq/QRmyl3WmdJI0FPwId+E6c4LDR60cCxPo8FHAcrXZ+kBmVs8vH1Roon3pSC
	 33Q0o/5IwfVE5Rftua+OE+9a+rumclUGoG3UOUgTGi0GmCPGZwxIbqeUGV84Jbfr24qIq
	 viLo1VE6dCpjWxUjy7soTitahEqQuS6+C45rlgQYCuRqu6IXgQP5vK46/py+CYWrO9d5I
	 iVfeoLEPAvSB1xFRHGqnAj21IqcnLZJ47Llg+6sbhjVkPAl5dNiBkpoiF1Ou9L65/ZtU3
	 5BABGB/xXoFBMrhnH87OBbUvfBGz5WxCNibatfPiCIh6/VYGxI/363Jj/ir9DmvvY6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389130;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+WZcGvLxQshkYZfLE/BvNL4fpFJlVGBbsEy+D7qPg/0=;
	b=0EJe3Z+OsZNGEGQxr6TWCI/9Uj5zbDVXs1hHiXeKhpk5tnq3HxqiWu+rTVPmK6Roa37D
	 lr4NRYC1o/uZlr1/fIF3lBl+LRIgpTIA7soIQfvI61jfjYNsD6Fmq1fx3/NMDxcj0ptAV
	 dVqw43b/UWy65LuxyiQkpWcKZsa7zqLCJDhXjaWzRvSdxslvod9HFRy1eViHK7favDVFp
	 Y8ktIpAMzES+76f7jKarDTHpr/y71bECDOYhO6LEFAm+BOmG/YaIVkp1u3zIMLpIzP+U1
	 rrR8IvY09uXtPjmaULTfBCjFV0A6Uk5bhBDYrcxchrXGgMFtpfbOdxMskGzl+XIYCrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-ilmenau.de;
	spf=pass smtp.mailfrom=tu-ilmenau.de;
	dkim=pass header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.a=rsa-sha256 header.s=tuil-dkim-1 header.b=dlRgTmSI;
	arc=none smtp.remote-ip=141.24.179.34
Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B107606A324
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 09:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B107606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.a=rsa-sha256 header.s=tuil-dkim-1 header.b=dlRgTmSI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1794389121; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=0c8nQJY1EwGY58kQ+tclmz5nR5SZVHL7abLJPMoQSwA=;
 b=dlRgTmSIYEHXGEW4GRHpIoWB/RQ2tTiZaUf/la3v3ba7SVhSQl/HmGWSquM4FEpwTQbw0
 WfSxMl+nDJ14S0474ZSgsPfBXsb7tyc6amNeSq+rrwFWdMYkMXVLVCCyVCfhZaAS12mPeTX
 kmhTEKvJ98WD6QjrsR+TLubOJhD+ArgA4P+8iN7ysrwV0p3npy4DnduIhgDFhZIQNQ+kvV2
 wycDnYPLnn6VGBrRj/nhPVGnIbI0UmxPBVTF6AqJ3fMFl440ODG+jNTQQUNS/Bp55qzNMaZ
 XQcbFCRHNTKzTalDw8bRe1gDSXPoaf95VZEgI9bwnaiwxBfpA/ZHQ09OAgSQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id DE9155FD57;
	Wed, 11 Nov 2026 10:25:21 +0100 (CET)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id BBB385FB59;
	Wed, 11 Nov 2026 10:25:20 +0100 (CET)
Message-ID: <5a84c2e1-da59-461e-b1ed-f2ea3962f283@tu-ilmenau.de>
Date: Wed, 11 Nov 2026 10:25:20 +0100
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rbd: Handle overlarge result codes in rbd read replies more
 gracefully
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
References: <20261104153659.1117700-1-raphael.zimmer@tu-ilmenau.de>
 <20261110115013.3268036-1-amarkuze@redhat.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20261110115013.3268036-1-amarkuze@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.11.26 12:50 PM, Alex Markuze wrote:
> Hi Raphael,
> 
> NACK. Please respin.
> 
>   1. drivers/block/rbd.c:2902: Overlarge read result is completed as a full success without filling the tail
>      Raphael is right that a malformed OSD reply should not `BUG()`.
>      If `*result > obj_req->ex.oe_len`, fail the object with `-EIO`
>      (keep the warning if wanted).
> 

Hi Alex,

I would like to know your reason for wanting to fail the object read
with -EIO. I went for this solution to keep the handling consistent
between the read and write path. For writes, a reply message isn't
allowed to have a data payload. Therefore, the result code should always
be zero for success or a negative error code. Positive result codes are
handled by simply resetting them to zero and treating the reply as
success. In my opinion, this behavior is similar to accepting overlarge
result codes for read replies as success. I think we also only deal with
a wrong result code here, because if the actually received data were too
large, the incoming message would already have been discarded by the
osd_client.

In the solution proposed in this patch, the result code is also reset to
zero directly after the WARN_ON_ONCE, and the reply is processed
normally afterwards. For me, returning an error here would appear like a
behavioral mismatch between the read and write path. However, I'm happy
to change my approach if you have a reason for doing it differently.

Best regards,
Raphael

