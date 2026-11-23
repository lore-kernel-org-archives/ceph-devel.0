Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.240
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795410457;
	b=e87W94aGaB0i2y+8w9FsRr2wl2/o5rQpH/6WdYmv9DxJKQiqalnTaNIHG54tX6dfGIFe
	 zA555N4eX2wfjq+FJ2yoCyFdvydjtR8NaFF6lCTlTIj79jt+3BPXRTzax49qDzgZdF3wJ
	 XuhXq3l2e27OGLgxEJlgLedoabeXeoMgrVzaPUjdb96yZ+wW9eFVGUfWkkoL1zyO0IB8+
	 lAOLiyYJQVxdDvV+VSehqtQ6obvNEnbkFYUSe+NSRA/XpSZGD2liycaISNQgDUEvNU20o
	 ySzt/a0bRtpOGPfEs4ABOzhbs8mgbP6U4ftyJi2hmQX9b4etF7MxoCnVZy7hv5ZfI2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795410457;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=/81pZypqQSSDxn9bb2q+RIkTbulWDFUKFacUC3zJgzU=;
	b=c4E1jUb4ZlkwXELac0fnu+oM0aXolj0cuaaNgpBegHt7LsMuBNQk4Z3F4rHY1aSbH+cK
	 iQ1OGJMJkl/C6/MlhdyInqWI/zqyoR9GontUGODbGnXcPMX867iiAoREgxBFQjf46FEk6
	 OWYH4MXtxP7M7twFKNCkZcUAM2U2HIjRRxfgllGoEHZ/BBauUV0/mxvJ6YwhzYA6pl/0f
	 Z/be155r4CZB4WofrbY7uQG0CM0E5LXuiJFJZqnnoAXVs4ryYXbSW3+SP5ztlNZr5mYCs
	 Jpt0QTHf1tV7jg6kKJxBRRzLU8Qez5teBOCPoyZyiJ/GjxwsUHcbFxwvVuC+6S6v3rA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=SKecWwbz;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=tjp0B9dp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.240
Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA330606A320
	for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2026 05:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA330606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=SKecWwbz;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=tjp0B9dp
Received: from pps.filterd (m0142701.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN041a02372397
	for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2026 00:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=/
	81pZypqQSSDxn9bb2q+RIkTbulWDFUKFacUC3zJgzU=; b=SKecWwbzU2u9GAUzJ
	mrZL/kgVq6L2kvuwaF/YIfl+qgqmmDSt2sOblwR7tFCY6lTY3GflTsPF4J82l9S8
	/p2yQpxxeQeNG5+8UBqhhJtFdZON/7pPmq1hREBksdQPPU1XE16EcfELFmQVK4/k
	jUfHdceuuZXG/jzPGDDu3UeSJC/fMMqly7KA+mq4UdFy15bpBYRSTNt+4bgoGFDQ
	zOhDZCJBP7L9wwHWqG/Bqb8J046E5o7q8j0TlQB5JThmdcPeXBoFw6EUZXUtzBv7
	mR7gwOyl30KUO1K28KRK7E27EaHm4u0PngI/D1Rxc3zkaqVmP7m32oah8JmgFzbs
	RZxvg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4j4amb1xh0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2026 00:07:30 -0500 (EST)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386ad819860so1880943eec.0
        for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 21:07:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795410449; cv=none;
        d=google.com; s=arc-20260327;
        b=RUtwteZAC+AVsaH4SLVQO85o7ZvJDfNNqqQ/geB2FqFNX0YHTN5wG5RbLXoVq3s+ME
         efUDiTzDjDMosAT/0o+dXw7/LSffhXVXi8O5bbAATD6i68hgXFjVEvyFX1BaMgQkREhY
         Lq8I6u53R3ovj+PlfQxTL3SuwP2R4xcZL7NfSBWW/avdF7mGbCqOE6a2xy211t/Ot6Gz
         b/8ltyeV8d+XfYjfD0JwrBtBeaCBugT7dbrUPCWIBT5BF4MOjPa9JdPr9hjQmwz9SazZ
         53Q77BsahdOD97F4ekTcH8LbrgVSHiVyZxTCYhli2k+JHIHbb7d16YA8WWc9jxnwAQbl
         OCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/81pZypqQSSDxn9bb2q+RIkTbulWDFUKFacUC3zJgzU=;
        fh=8zenanObMaztJMAQrrr/yjuND9v/VLIlkkF+oYkSxgU=;
        b=FV4+X2te7qRN7aDjBUjjUwI1D/j661wgkSdSLoyRn/Kj1l43TLfMkitytdy9BtGx0Y
         lIanka2m8BhY8YS+aJCgAjKrUc8eNbTjaabxYva50Ux8ghJaZyFbQN30G+gT6UVuhft2
         8skNIDGheujHuZextosqqThKwprqEDyyFNkQjwf2RQNb5KzS2GwWoR8M9MtuEQJQkecq
         ck7WTpiDs8Cu/+DBfa1oUpuny6i6e5uEuhZca+IGEUQzRx+Nx9C5g+J5Kmea3PrUh1l+
         rs/vp7E+A0FZTtiCwA+0nba3AH5OeY4Ezr8/GQUHMcSl+4qMAqvtMxs6ABTBwR8j4MBi
         AwiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1795410449; x=1796015249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/81pZypqQSSDxn9bb2q+RIkTbulWDFUKFacUC3zJgzU=;
        b=tjp0B9dpUTtHvZKITdtIzMLBR9uWyBxF5CO7WT456ajRggZ+ouCiU+WUTOp4MPjit7
         Tfwv8gC8k9mf5IaIs2Nfyt/xc9S0zFOpCdkU97pMmpoe+PzOtgqsQ/lRn+F0u4Z5ij2v
         FDFaNXJR4/vigltQVf82L+OCqIsnh26t4TVrnxzpqlkNzrMqMSXbm76tRvW7sQVmi2YB
         D2oLamng2ZPNMsN5AkcsJAfpNrZE32FQ4ZKaPM8baj3rU2AHghyLbFzoD1a0C7MXCdpO
         Ql0tCtDMSJxXAtcSvnFZogHxSxj5FBbE5nUCDUy/0ORxXAnCFQuPYstSX2YY4O3dXoD/
         c1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795410449; x=1796015249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/81pZypqQSSDxn9bb2q+RIkTbulWDFUKFacUC3zJgzU=;
        b=CAsoELbiKM+RVm9cMj5cffbGfcF0HCh/6f1lrgGhJ8rzJ5AxISz5F//E77Yh9MSv6L
         aT3L0bCDCfgWHZQFTq7hbLPYCIouR7imj6W1lqNn+/Hz0UP28Pk6n9DZ+oPEifb3CRHI
         BTeSN6nT2klJRAl+sLN8EX6wrB3mwOJamjj1LfQhpcLRwp/z74YFDM5QrG637yjO7jaJ
         2Jr31umqnMHnHbNbr3BxvdP+Yr2NGLyO6ep1VQ2y17Aim9ltlTsRRQp8naSussV4AcyO
         nu/ZvpT3WT93s9Jo8Z/Cf5MxfFrVVm2OIFQxoeF7gTnxSZClT9AUjH7rVtZqlySW+FbS
         vzyQ==
X-Forwarded-Encrypted: i=1; AL+hErFg4xyiuIID0lJyZY4aQZC+co3lCg092iPNRNnmuGcCQPzAX1XCM/Wca+TfBzLdvhinaWBC/KtCmpQp@vger.kernel.org
X-Gm-Message-State: APuU4Z8O7nVqq5x0jAY6Hk0R0I5ZmSjIFSDeSbZFvrHm0IKa6An7zLIG
	3DhH3oRvsNKPaGfqEp5XozyvqySxyEyIH8BkMdnmwTlZnNZNjVl/KmrAvdrFAOfWYm/nl9vvkAO
	B2bK0SMAcyzh0Izkz+DgZ3if1W2fNgc/14lzNZypIdBFp68yDD8+ew+LCa++Pq3wZg+HFr/ii3f
	KZGQSBntIQB0MWPUqBXuuRntV8Bo8DtgBzvVE=
X-Gm-Gg: AZFdTZcLPYo/bAeQ8IOGxhmsMFPcIfBQTk3ydf5P61WmCMquMGXwFK/LO2zPaATUEnn
	LR5beRP4w2/Ss+wOzXdsV3526YiIyii5jpyeFowbIWMsrSPFVSCnqJaw3H3RU6riPbobBO1BuZg
	2zilHc43wCwi0wIyUrB7vD0hr2IZiGSWcFdUfwL5TDL+6uOfT5rlQ27KKNsA==
X-Received: by 2002:a05:7301:df48:b0:386:a5d0:15d9 with SMTP id 5a478bee46e88-386a5d018c8mr4769336eec.37.1795410449605;
        Sun, 22 Nov 2026 21:07:29 -0800 (PST)
X-Received: by 2002:a05:7301:df48:b0:386:a5d0:15d9 with SMTP id
 5a478bee46e88-386a5d018c8mr4769315eec.37.1795410449104; Sun, 22 Nov 2026
 21:07:29 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113030257.1061200-2-kj2864@nyu.edu> <20261122181622.1294305-1-amarkuze@redhat.com>
In-Reply-To: <20261122181622.1294305-1-amarkuze@redhat.com>
From: Jerry Jiang <kj2864@nyu.edu>
Date: Mon, 23 Nov 2026 00:07:18 -0500
X-Gm-Features: Aa3M54rDQBOKRDXbJgbB5JJzrGqttkv3os_tIAGF8WXn09halqO4jreeG9nkw0Q
Message-ID: <CAPqbLS1vgOhyXT8zLiDmf_1W3zVq3cgAcvu0AbmKCSUCstpqaA@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: Use unsigned types for snapshot split counts
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
        Xiubo Li <xiubli@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, co+408fcc361565713f@bugs.sh,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAxOSBTYWx0ZWRfX6i2TGmzkD4Wg
 txf3vp+hzUpuO0bPfyg5uiyQAqwLq2hHKnkW9anrMXrI7CeJqxu1oet+haKaie8nGIFQ4ZTUkm/
 OfV5Za84Ho/+ypxvHXmkx1+CUSFvgzRN1wIVBfd0fwyv/uRx+iNXEZtTwc6mhOX9maESxln8W8K
 PuaKI7NfDggBm1S03y088VjPZRZoHkeW5REwJqO0Scm3++jesu52AT2Kiv8WokPGu1lZg+Tv8Vt
 X1FxikMDOa1FrO68JUT/rCTAk+84anOaQj2NvrCHFk9loQKUlBy6vXvemlcTjuJfEqphxAYWVza
 SSXeKeKfgh5n5MfZQVUia05XYIT/wBulym7NWeiqnBTXetPIBDszZoWIAXxq07s5ovv85qZc2pI
 NL2ycBfOOW9EzZjgo4orcpzdHyYVbBaBes4gvosYSPzoGSuIqnZWxAS54kHNIw/1XhTPqexq4SJ
 7m8QK0YHji/aUOaVmTA==
X-Proofpoint-ORIG-GUID: -XzT8SUT0nofieDhgu5RZOKzevpMwPcT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAxOSBTYWx0ZWRfX3nXY4ZzSOzLS
 iGkYA67zkAXN5bpBRXQBalRmPbRIgLa//3wqSArsqcLwPoFvC4Ts/NN23C3wtRTAmXNynHjCDcg
 TonSL7hEeoo8pT1d71L+CCNzipKGOQs=
X-Authority-Analysis: v=2.4 cv=L9aI0OT8 c=1 sm=1 tr=0 ts=6b03ca12 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=CxnIfPQeirmdGRAfp5MW:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=ItuYklrUK8AZe7o1UmoA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: -XzT8SUT0nofieDhgu5RZOKzevpMwPcT
X-Orig-IP: 74.125.82.199
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230019

Hi Alex,

I've made the changes you've requested, please let me know if any
issues occur in my patch or anything further to fix.

v3 has been proposed:
https://lore.kernel.org/all/20261123050440.223436-2-kj2864@nyu.edu/



On Sun, Nov 22, 2026 at 1:16=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Hi Kaho,
>
> The new array-length checks return through ceph_handle_snap()'s bad
> label, which drops the message without fencing I/O. If the MDS sends a
> malformed snapshot update, the client can miss it and continue writing
> with an out-of-date snapshot context, risking snapshot contents.
>
> Please fence I/O on these failures and use the same blocklisting and
> session-close handling as for a corrupt snap trace.
>
> Thanks,
> Alex
>
