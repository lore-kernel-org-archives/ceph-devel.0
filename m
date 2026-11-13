Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.240
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794539068;
	b=eWoFd+5M+t7Wb3aKY2VHzuoaJZnjI2R/eVrzB8CVib6xboGcEpTh9oZBe6MWc+umw2ox
	 /rGaVcZNggWlz6r2HkxOLeJ9KHLj1mJ7HChmCUAyDY2YqVIMjudwtzalJper5Q3BhDE+z
	 MJ627tX5S9alLT2bxxLZLLB3KH3qcPQy8IhOY9OyJK4FVX2T6JYDhVTAbcnDX9p+2g9y3
	 DNARlGetn6VSGmjsZpVsI0ACsR9BxmaFopdkNlbFaenyg55nljVgk/3OorgkZXUDukGo5
	 PNLLKe6hkPIvaG2q5tX/OkVTybyeQPPlQt3oTWj0jQS0ofGZLQH90RS2CC5SEPnCvQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539068;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=GmhdQpGdswduzF/2xD0IuaeRK/J2SvLotUiBA4mm4f4=;
	b=ICXPyvrXWtlNNUF5OzO0Zy/5vVb/BdcD0Gl4mvzCO/EmmLoBxwiYf45Xs56e5uj4+xnH
	 bXNmTEJkqa2f0+JWLbjtCIuB4uyjc/F8UTIzY6tG9hN4lViHfgGl6UgrErxME8/oC8NQp
	 O36tifznGviKvKD+sj+FCO0Pmg75qWC6PNpKMWruls2ZIBVuTl9l966QY3sw/jrsaO0Kr
	 i1NgQzKKw0ZsaXqHwN15cuBJIyCQczoWZj9pE6UjOf03kgSVMzaA3BTL///I5XwDCg18/
	 r1OkfANLqIcZMoxBZB5qahfLgbfwa75AMQTltFt0IWkYMoSRL50ugzCKeXRw6lEY4Eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=tPsmLIyV;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=W6w7REez;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.240
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920E9606A321
	for <ceph-devel@vger.kernel.org>; Fri, 13 Nov 2026 03:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 920E9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=tPsmLIyV;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=W6w7REez
Received: from pps.filterd (m0355795.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACMWCTa577450
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 22:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=G
	mhdQpGdswduzF/2xD0IuaeRK/J2SvLotUiBA4mm4f4=; b=tPsmLIyV5N9LbrCjK
	y/kJhmKki55kqypF5HyeUTxmGjlG1VgD8yz0dhCkeGdKa8iPhEu9yykyQuEGzdDm
	yIehzkFLhFvP089BJWGo1eAhv+pyg34OeoiBP1p+rCu5EZ/WcXI09qaWmZMpFjf0
	dVE34X04y3u/shxLNrl3282uW6lm/BH+dRSHorTDsjW36ffLhx4Bp7cvxPOulusu
	3HvotgAbEKSkngRmjH3RyV+W13uDT4SyHWGaAX8bWlxbyuZZPGLZdp8/XLKzYm2t
	WU6eCrmM/GKmOsx4sdy7DhIK/INDCOim/CYzTSfIxWR3Cf0qryuxr+C/D8ETp55r
	Q+rDw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hwjx36fsa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 22:04:26 -0500 (EST)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-375f0fd31f4so623598eec.0
        for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 19:04:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794539066; cv=none;
        d=google.com; s=arc-20260327;
        b=Zmx7RPpqOAr9WeCgUG5HSrjPOOsFlnLo/hWZQJwxtPBxM9LrKw6b2xsaqz50AJQ9l3
         nqf6rAWM3UQuQNgKY+41a4Xm49vpe7H83TZydEE2nAymFW8Gq+XW01lnKaeW5+JPF/yr
         qM0/6BavT7WMc5UPIdrZrcWXOLeAK7rjwkPvWRzYaR1c3iNPRAjJSUuNZGVUNxfzW7nw
         3D9lk+RjAXWue/5+3pnqFv10R/iyddZZOgzeHOdDShI866ifk1y4Bn4iI4832OWK8TRY
         LtIAx9fleuS6Wdl/EaB0XCPwnw/hnUV7CO+kD+lK011TNBVykQPK37mwKx2NMLtmmkSi
         R9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GmhdQpGdswduzF/2xD0IuaeRK/J2SvLotUiBA4mm4f4=;
        fh=hQi6YpzMrKHdVGOJqFCGpXSxcVpd3gX6nHHLy/HxlWY=;
        b=EgHIdMhyosVu5Rew/X5sHjKzoJ8ZnwLm3fSDM0FmFLiTffLXDe0Ult3hCeC9/tXfAJ
         QFjP2uFVj62kiiaRvSiLtsNs9OMm/VFu0znMPzbOMRKf35QuEqt0+O+uqt6Rdpeno4oe
         HIZcyNJJPDwEWx7F7I+TqACqoMXzFJexDWu/xVT8jVSQtszOIxOuzVMQIOdTwJgGHi0Y
         wvi6oRoj77PF7t9e5vpa3KYUaYbp9iaB/fAS2s2o+8HvInjhYKH9kPCYEMRRSfkgJagV
         Okf/sGNZD/dn6/whHFfJaFY/ebzh6up/KT/gSKwh3Tc1fVOPTuf9aBc6TK6K/vz3/afQ
         nPqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1794539066; x=1795143866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GmhdQpGdswduzF/2xD0IuaeRK/J2SvLotUiBA4mm4f4=;
        b=W6w7REezAMGGfzxGgt7jJB9EKaKguq5qIu4pJyGnWtQ+4RrrN+W5y1rMZX/029+f0y
         2lF4DpfGdkWIp00i1JimnlBZhT+n1v0Uz3OpyiXAQ+t2hOlfGX9JqUplhSpf/At/vsBx
         IrZdY37a3++dmIdSXtTAaJ3XXoBQY0s9FhUgastDW1xWO8Tez5TQHBr8iguGrdSs3K2K
         7rQEPU0pTwy8Z8WDYj+GNvI6Z31kQfOQTYlXj7HIJNZ7Y6/TkKJK3ufTk8djDEsPwtsJ
         kUWxc2siS7T9Tvath/wowTJta3EarpXVjiEoonw209ppE92DitZGIRFzltsGHDsYh0E0
         osOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794539066; x=1795143866;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GmhdQpGdswduzF/2xD0IuaeRK/J2SvLotUiBA4mm4f4=;
        b=tGO+kNGoYchHM5LgdJBq70RjPnEi5lSIqSgxN4gUL5YKja5HdTZKWfZtTSYh3PZh7J
         cduLirrQDruSTtkXNPEVWFRY5tzN/e43oUf2nxOusa8JDQSOaJTTZmiMxNR2UnWksfVA
         FabuPnxNTtV/WjvwgSFV/Z0+t2i4UWzpnrAbPYCzcBv3D621wLwbouo42T6sXHNgOFlH
         Ks4iZZIdjYbimltqNS8/SjKnmJELenFAfRqm35wfxV3MYLD+e32IwplqjhIAt/dzCyIh
         VXAuhslh2V2JxndWodD7ptk9WhTMqlJsCflLaJ8vQIH7xMheIraK70pOJz4WeVuhBvkm
         F3/w==
X-Forwarded-Encrypted: i=1; AL+hErGHvSzIaEuhqLwIDvYJ+Dcb4KPdtwFzJv2gKCi0tCQ2Qj0K9NkmGk2MxnWZM0zKWLRmaS4+4UQscj2Q@vger.kernel.org
X-Gm-Message-State: APuU4Z/pdT6MIoO9HNYSIG1hTb91XoR+Yp7ldq/6lkGfbDqD1kjN4VAh
	/mdpaIRRhuiZsLEi2gniiR4H9dDEbfohuDj42vBxufeEGwBXeDSe2xdqbHN2EgwuHlLuFX0KDAL
	FpPH95RimFKtK7iuQJg5BwOVomQPvIBjeDcv/TvLXwrryn5ZPgNWvjyHj9eJqYVK5+Mclcwu9hK
	YdwBl4185Kl64rI1eAw8fNZqvgoGgKBfhyHUA=
X-Gm-Gg: AYBFou2TdBC6cjRan3ydi7YNdugIGhgsOsfIt0BAqlgkqN0s70XiTdQylgBDrp7OaZf
	T16RFh3wXtW/FWmN9Nf4zBuKfHOXJ/rl/iExVdQBCDugHeroAxDTPQSfEUvtlK91LdEMW8E8uKE
	w+HiYPImdmLNNQhiQPEwupC63JCVKQ6oSr8AIylFFFhEv8NyeO77D+0RiVHw==
X-Received: by 2002:a05:7300:fb17:b0:36f:6d81:3f99 with SMTP id 5a478bee46e88-3796676fd59mr975904eec.7.1794539065985;
        Thu, 12 Nov 2026 19:04:25 -0800 (PST)
X-Received: by 2002:a05:7300:fb17:b0:36f:6d81:3f99 with SMTP id
 5a478bee46e88-3796676fd59mr975887eec.7.1794539065469; Thu, 12 Nov 2026
 19:04:25 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111033150.847104-1-kj2864@nyu.edu> <CAOuZWzyKFAfOFDu1p8O4M4qCS6WgvTXtoFq89wnZSx3OcCXz2w@mail.gmail.com>
In-Reply-To: <CAOuZWzyKFAfOFDu1p8O4M4qCS6WgvTXtoFq89wnZSx3OcCXz2w@mail.gmail.com>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Thu, 12 Nov 2026 22:04:13 -0500
X-Gm-Features: AclHuK84zNQZL-Vn9ypJzxeh0nfI2T8c8JoATz7C6GkFQJ099lS7ynWbrj7mP8I
Message-ID: <CAPqbLS2exums5i9PX6SA37MMdRcxsOZZqnEBJuYm+HsFGtPzGQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: Use unsigned types for snapshot split counts
To: Xiubo Li <xiubli@kernel.org>
Cc: idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+408fcc361565713f@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxMSBTYWx0ZWRfX0vHucnl91ijj
 ZbYAwp0uMCYt9klaGa2ynAmOjKC6sTTqwkP09W0SmD6utPfLhYJg/bEbS/9JxsEPGwOe5hbJkgM
 CocOKnw0KZ8Rlu5pYt3vqoeHILCLIRIgDuMKPm5FgpavLyoqckRBOU8qfBNutis77B9vWLwFM+v
 +PijpoWZLRiLtUZDnGe8KMOIyRG+lQAqA5uP8cHcIB38pX4VIpSh9ZO2/BU8XFaXgWvOQ+n675i
 TV+J61g/FETqSYpKCiAHek/dMjXMnlXDFOu0csI01j+KcTnX5UVkOrUL0fPX6Q4l+lZCacL7BcL
 HpT6N2KSfqefYDKVpyGxm7UQPjurIKKpLNU8lrYwWwg56Q++KeOIjlNGeH4x2Ukj5QIbQKkoswn
 rAezdAET02AgoYiIkqmNvrYHko/AuSW7YvB9vFOzSQV01FL+0BgNwgCQnj984atglAJSkefBY6T
 nPlaWIm2Q6KGojpCLQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxMSBTYWx0ZWRfXwBZmpjE9hLif
 rrKVWqsiOKF6d5GfwVMRpe1tAbj3Cv+xBif4D70hgG0xjTZWFr08rL7xwx6uFrswl6l8JS97sA9
 AVjzvsRIYpb5WvsohFUR3aPcXdRJHZw=
X-Proofpoint-GUID: 1Dv5JBTqWJ35erB-yX0dS07nzzlqXUKc
X-Proofpoint-ORIG-GUID: 1Dv5JBTqWJ35erB-yX0dS07nzzlqXUKc
X-Authority-Analysis: v=2.4 cv=Ju1kP84C c=1 sm=1 tr=0 ts=6af67e3a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=Lu3rmdZLeA08KL8VqJdF:22 a=VwQbUJbxAAAA:8
 a=zb_47FFdHMeEVrkQdFIA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Orig-IP: 74.125.82.199
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130011

Hi Xiubo

I've made the changes you've requested, please let me know if any
other changes are needed.

v2 has been proposed:
https://lore.kernel.org/all/20261113030257.1061200-2-kj2864@nyu.edu/

On Wed, Nov 11, 2026 at 8:31=E2=80=AFPM Xiubo Li <xiubli@kernel.org> wrote:
>
> Hi Kaho
>
> Thanks for your patch.
>
> The u32 change fixes the backwards move on 64-bit (I reproduced the
> KASAN slab-out-of-bounds with injected split counts and it is gone with
> this patch), but on 32-bit sizeof(u64) * num_split_inos is still a
> 32-bit size_t multiplication and wraps: 0xffffffe0 still moves p
> backwards, and 0x20000000 leaves p in place while the split loop then
> walks split_inos[] far past the front buffer.  Could you bound the
> counts before advancing p instead, like b3bf89767e3c does for the snap
> trace, e.g.
>
>         ceph_decode_need(&p, e, size_mul(num_split_inos, sizeof(u64)), ba=
d);
>
> for both arrays, and ceph_decode_skip_n() in the non-split branch?
> Also, please rebase onto the current testing branch.
