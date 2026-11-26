Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.242
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795663864;
	b=gZTadW7Z3E/egu2TlHXbPiAuutc+Tfl9i45NHebnnPyYvngB4KS84sgI7pYkp7DTVJy3
	 dV9sU4KxmAVtDnh3rbn+voqTeSY3F3r62XsBIpvsl81dzHzGnozNIRD8Lpb64/rzWyJaJ
	 OAihPNeiAT5mjYKmsDxUZ618FMF2O7TBehedtGNH2UJrJ6ho+iMyJIaXy07wo4G19AKnH
	 tBDbWKtNr66DG5UcrKvsOXv28QGXcg35+vt4ry6TO7lNwm0Jk21BJNkHHfjaifPVhwkPU
	 7XL/glcoVTZSMAk9eDMUxqb9A+2wVj+X0R4q5m5c/rxi0A7INivCo7NRckBCyibAWeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663864;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=N+P3dYoO5kNdjktkieB+BYanGibwmSgEVeuarspyJBc=;
	b=gfzmATtJQzWtgvlVq+/Qpf2oMOhUOiDeB9Xv9+vkJBFMhzutZW4x6aBjci78qoTxk18T
	 MGH40RKnhgnpCY/txMWGWKfkHo93tiQENS2S80ztmbJDsDt3iY896qwj0mnKjdBjktYKn
	 PwE0TbbJSAaOD9v9fVX5QphHr8y1g1DYd+GZByjnuZSrCOJnZQj6VbjAVOY/rsEi+hNxf
	 QOVf6J3/zN/YsJIey9BNRrVwYfwJVlm5atIFDKnwNNmGq9f7tsXjnof03AmsmIvWnYLVz
	 satIvgV1mzA09Wb+EKv3U1jyqiLCPrUNDr08JKTIJBXk+VkRGVtBNCWq7ff1HLx+RGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=COd8mw49;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=JiuSLZDI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.153.242
Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55500606A323
	for <ceph-devel@vger.kernel.org>; Thu, 26 Nov 2026 03:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55500606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=COd8mw49;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=JiuSLZDI
Received: from pps.filterd (m0562594.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APNVXq8258364
	for <ceph-devel@vger.kernel.org>; Thu, 26 Nov 2026 03:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=N
	+P3dYoO5kNdjktkieB+BYanGibwmSgEVeuarspyJBc=; b=COd8mw49C9yb8fluf
	eIy7xKCBDO2NqfQ6VAl1RZHBzlf3A8FWyBtI3QxWFYNXNWK75UJvvtc7WdlZ1IzN
	ER90msZ/mgmPX13hDztWwhQhgTZAaeDPxvEGwJ5v6lcUUP7NQoNQ10EMIznCVmWn
	LyC7TFQf6f+c6Gf8fjBcklYPSlrNRmr0kGQYalOnkV6wCDxAZO75UbPrcv24KW1D
	fGJurblv5FqeYMvRTWR++vxeUGMg3UkbZIovuagYiuGAzqaMCE4+8wRcoF2yLRaN
	ocn7fTwSIEMocOHL9pSTNoaoB5kEeXupx5YwAHVqcXLhow01S2zYSYc01cIrZ7im
	+jwHg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4j69e4t413-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 26 Nov 2026 03:31:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386c3309469so2496802eec.0
        for <ceph-devel@vger.kernel.org>; Wed, 25 Nov 2026 19:31:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795663862; cv=none;
        d=google.com; s=arc-20260327;
        b=hgcPrjdXcKk51iWKH7v7wG/ZGXpTP1I1uHLkbhbboC6yUwqg0PjiuzUaP0XEYC7JTa
         lamj8kCwTQLieVzvFV6Vb6M2AX69RNt9HGglmYkaziHhxcfFkysEs5lrnvPcfYsk+lJG
         tLsVQjZhsn85/CXksz+3n6gcZLJDkYm4WqXCZvrrjxHwE6knJ0c04tUiqv9K3/nr+sG9
         M+lXUtiwBk+IzMAJYypH0EAymgrw6mYMc1iAohsE4oTGQOEaxdY+fm8y2A6QcpNwB6YE
         dj8QSi0TRgang9m7uIMdWdH0+ml+TKXW0X6j+sQu3tnUQLPbO3J3BDQAhzBgSKHraRwW
         l6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N+P3dYoO5kNdjktkieB+BYanGibwmSgEVeuarspyJBc=;
        fh=KnPH6J+IWiHohNm3zAcVv/2/ZFg26MPDragvcZRoLks=;
        b=hGWs9V7s1McfG0IrUFdrTMOjZg9nTCNKF0+X/8a0qgiw+mwcKbz3y+rxTK23zHc1QM
         msZZrukKaQA76VW7O/k7WYru4hf6JZ6yLuulyJDBFDhec0ryMR/x3/LuohgOu/M38amh
         IwXDlLo5NKHTDX11RwuDRNoZYL0vB+xYzYUCsA4mPzwjxNZtiLsoa648U5SZspX6d98v
         wUE4BIaSi2t04LqPBAfryHFLPc/kII4oGQ0q/4YlxFHuWcn1K+nHyMy6h/9EVquQZslW
         o0Ct1qaWVjLbPFaH0VPIP96NOSjNGmxykrBR5ElAPr6EgvpKAc2ETOZHgxKFgBv7+8tf
         Pp5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1795663862; x=1796268662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N+P3dYoO5kNdjktkieB+BYanGibwmSgEVeuarspyJBc=;
        b=JiuSLZDImeXzsqgLNJRNnubrt/KHtLo+zGC+u700XKldyjRDyaauQv0cvlJ6SWaBKn
         q9y5vmDFMZQDa5P6gqtCrGhtvTxcUl/yUTYSPwnq7zZJEK5BBElpXeoKok4F/Ks/Sa5E
         7wN5aOOrALqravaHGYmt8TFat99+3aML3njfkzmcmxMaMHneCmQUagYp7xrkw9DRZf3L
         BUwINFVvQjIblpglMLi+yxVgWfE2ICRIW6bOvG2l3hDzUjD3Lc2Il18ndBxHWglpBZnL
         sSo2MewM7TRYrhPigOUejjzpzDKEH6oj3dSxG+KGaLIJxpGWpUGDQAL/5QIdBlkrEja4
         M8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663862; x=1796268662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N+P3dYoO5kNdjktkieB+BYanGibwmSgEVeuarspyJBc=;
        b=G+nTwvSU4kYfok+xYDn84ps3PT8d4RQfLxsQuN5tfpQVYIAvQuTGEgIWRf08gjBeLV
         srqlDG67LhuEXKcdZ5gOmUyMXC8qMrbIGHODDn4EX2eC41yuhInlpA4Y2iuPcCLFsit4
         LdJyga5swLzu9hSwrx0SVMvqMGA2drExC4pHPQfHL+0YdCWb9QdCcSpm23fFbVm232bA
         7M1jwrQ1XKVWg4SLRP+VeNHjli61vwrR9ITBHKClqV6lYRtwIVb4mkJq3KImLRIBmL7e
         1fcVxWa4n9U4ucmpcHjzn5TCIlyszBuFM8MRWA0nawNn2cyMMvo2jsaZmtFEnxwubMc0
         QTtQ==
X-Forwarded-Encrypted: i=1; AL+hErFsTl/QeiDgwqzK9zJQRJUlOjiGwnA01hy5x/lCBrk3qL0q7AH3HhNzG5I9HyJ2Bi+yZqPMvI5n/BRg@vger.kernel.org
X-Gm-Message-State: APuU4Z/0+VPfGktSvpGO7z0/KUPFZOs9S2cYmFEbRwdTNS/t+ou2j4qa
	/H9GuUemmpysBSijBcYpUxwg1/DKC930i1ZCNndg5nys/8NPQMkUZq6EU5go2Xy395+OFsEUwTU
	ZuQKGkxctrw4Y6sdKmayjTBg2r45L4rs8SWGsVySvI/4rggzv9M3+iciRFsu9clIsCRWjbOQKVG
	SzfTpWEGrDFlEOO+TdqNh0Y+26F1dWaeZ3LTw=
X-Gm-Gg: AZFdTZcxtiSp+Cbz5SVx/sWiGZ31VoKJCl94cG51cDYTTmSF3lZBAqFdVHrR1VtDY3M
	YKm0FGW0hDdwrm8MrNg4IZ0Mof9DlR0frXbn82jozUstRuRecaNEMFApJdMKbHAKa8TQiw8vuHZ
	Nrf6auRKJhR9uaF7FZtQUDUHhoApbBOz5NYS/br8zr8hD6GaLcjtaUzK3zcQ==
X-Received: by 2002:a05:7301:391c:b0:384:df31:69fd with SMTP id 5a478bee46e88-3856fb6a672mr23198239eec.14.1795663861927;
        Wed, 25 Nov 2026 19:31:01 -0800 (PST)
X-Received: by 2002:a05:7301:391c:b0:384:df31:69fd with SMTP id
 5a478bee46e88-3856fb6a672mr23198198eec.14.1795663861013; Wed, 25 Nov 2026
 19:31:01 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123050440.223436-2-kj2864@nyu.edu> <20261124113412.2078323-1-amarkuze@redhat.com>
In-Reply-To: <20261124113412.2078323-1-amarkuze@redhat.com>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Wed, 25 Nov 2026 22:30:49 -0500
X-Gm-Features: Aa3M54o04nhg0P2_1uYOfzaZLCGV6LCP0jYuR67VeYdioWcby2Gl3ug3k86xqRo
Message-ID: <CAPqbLS0EbbsQ6Z8P_vep-nMfDKbe8S9cKiOS5fWp8qQdFTp_eA@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: Use unsigned types for snapshot split counts
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubo.li@clyso.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        co+408fcc361565713f@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: DKcjDeqikNok8blSUjWTaQZoO-iB82Pe
X-Authority-Analysis: v=2.4 cv=KpnYSmWN c=1 sm=1 tr=0 ts=6b07a7f6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=Ea0mjXp3HgiUWvWh_zl4:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=GzGT0hU59dN0ITKBXqQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: DKcjDeqikNok8blSUjWTaQZoO-iB82Pe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAxMiBTYWx0ZWRfXzJQvkylEm4m3
 949Tm3tjIGVtHWo+yxy1zFRufobQ/GQnAwSLqckj395gJ6+fjnxswePgY94j/65Lmq26T/uMPeY
 1lcXNOygP0eQpVQaiEOdp5oUOAA4zBupEuXdE8mq1iqy9/1pV8kYBIPy7+An7VyKPwx7Niw6hz4
 vHn8LsZLyrECXTIfcvoNa3uGZmpEK9zlwS9gG2c7qu4dLNQnBEE629Ij60c16jj1mmxmEGjFE4a
 RNnGGSJSVsf7er/SFUU/ik8d+2wcrCapAKt6EHHSbV5t3QPOOL48C3BxKafBa7sLWvhVrZj+4lZ
 hX2HS1eRFiDJ3Rke1vecWjohjvocwV/d84MJLsKu5ri8/FURlx7XFvpFESoACkaWEcRxIwHeOiD
 C/Wx25/ltiOkqK45wepag8pBaaGZPyP9KS0c4J5oaYtIJOumgudLNeFB1kkhHvXYsrk/c4A1dRR
 RCHoBGatNetaQkykXwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAxMiBTYWx0ZWRfX3RsgqR2Q0v5x
 HazWTwihQIiqm7XWSvyASBQXpAcXhPhmZSvJm2+ginBkFYeHL7eaXS36eCDjjlnCwJhB7e8UnzL
 S76IuH0wf+EobbN8kQLgUpc4E+66MnE=
X-Orig-IP: 74.125.82.199
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260012

Hi Alex,

I've looked through your request and created a new patch for it.
Please tell me if any issues arise or any other changes I need to
make.

v4 has been proposed:
https://lore.kernel.org/all/20261126032756.265377-2-kj2864@nyu.edu/

On Tue, Nov 24, 2026 at 6:34=E2=80=AFAM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Hi Kaho,
>
> On a malformed SPLIT, the failure path calls ceph_monc_blocklist_add()
> with snap_rwsem held. If the blocklist command succeeds but the subsequen=
t
> OSD map version or map does not arrive, cached snapshot lookups can remai=
n
> blocked on that lock.
>
> After the blocklist call returns, ceph_mdsc_close_sessions() can queue a
> close request and wait for it from the MDS connection worker that is
> running this handler. The worker cannot send the request or process its
> reply until the handler returns, so with mount_timeout=3D0 the wait can b=
e
> indefinite.
>
> Please move the blocklist/map and session-close waits out of the MDS
> connection worker, and avoid holding snap_rwsem while waiting. Keep the
> client fenced, prevent further stale-context submissions and account for
> writes already on the wire before releasing session authority; retain the
> required references until the deferred cleanup finishes.
>
> Thanks,
> Alex
>
