Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BE3B7B6B
	for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787738259; cv=none; b=YMwmnXSY68LVv/U7B03BWdSMpADLvVpEUfg5mFdxHyhZO4W8zCNiQkuunSkC27tfhxk1gGhh14gA1NE/ax9RfYgUnf5fuGssdckJb/84+ID+EvwzNBIgzifSPpFWudQPIvoWN7j5SBgSeH5kRiTzi9SOrOWNyg+M1Mj76lhSnFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787738259; c=relaxed/simple;
	bh=TEEw6J58mI8aEHab9qu4628apeUqWjnrQZQoHMvNtIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BoL2GAsRFbCoHBR+aEWOutrWmBDdatzA5Um3dJvOUqEmMNjlOL/cidTnhj7HERqV++NRog9bsl3q/U17Ku8Bdqsn6oH6HJNvHyjiLa2L+QaS8dO+uUKM6gy8AI6Zxn1oBaXQPSLGW75SRcCln99C1s1kWlNQ2izi3cGh4zn5Qm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=n7sKmHpa; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=fbKu4j0x; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="n7sKmHpa";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="fbKu4j0x"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q9TNKq3701236
	for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 05:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=zlYg
	tHXx/2U+yufCBzJ9ciqYu+gFIerMt7aE4Zm/Scg=; b=n7sKmHpatrv9FHgWls4+
	jhO8qHfitdHp5JpcrnWhrJyoOeV+NXLUhXVfy6CuYUt5iBu14t9iZjxeJ2CUWnrn
	2ZyEe/5rD6WFLKMgOXAnq55AOkNgJB2S7TOwNXSp1JWKRgVne1AD9i7siA839PZu
	BJDZSI1XWxBW0ZtXgtiafEYROoyBIm9wzQHTkIO1FoZBfPPQLDNM+VFOxY1NkNDV
	YneAZhgpxmv3PCCTFH91091GLbquE6BfL0D02RKvFPU797W3BV6+KRqfMlUEH3nH
	eqN7Vl+nCCSeGYsVDyQkels1CfkAAuE7KbwBmDGdwbZeGIAPv5GJ0tSfrDcUNDaX
	aw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4g9ec3vhd8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 05:57:35 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52ef04756caso863861cf.1
        for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787738255; x=1788343055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlYgtHXx/2U+yufCBzJ9ciqYu+gFIerMt7aE4Zm/Scg=;
        b=fbKu4j0xB4NJ6V0GW9NCIbL6JtfrouXIHhIl+KxgMKQwEpeokn8vDI4XygUcyA/Zjj
         0kTWUlAMyVBEQtyxO4vyE4l2jOEWwpZRXK/bvTNdqoIwXHyD40LyLIwOFZbu/daz7aky
         vSlfetXnVh594E0cRgysqtBHyYVsVPhegWJCixKF72PClH92/9vx0sy9ffoOcvSchHu3
         G5rBrLopwdTqbjaO0N+yKZB/ni08bjMnP6EuyodX7hrbAM0iZNOG8ha8J8HQ/afIzBMg
         wae7PWRrLngePSFpH748vD44pdO9f/S2SnAHND4hK418l2BMC1YjZOEjQuXiDM6UAnDk
         J2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787738255; x=1788343055;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zlYgtHXx/2U+yufCBzJ9ciqYu+gFIerMt7aE4Zm/Scg=;
        b=sp8/udUzz7U2OZhbqaM1IdKQUyBvZ0Cn4fHylQibb/U/0eXjwJKhCCQTiZ0iUSRQ65
         uzaqgqaq74ze+i61MJYaTF2EI/ZnoGK8f20DtvZ+ZaSwhS3WcvQY3aQh+rX5L8XBFfTB
         dCroc02HPEy2DlLbYMRdxAF0ieIXtFEIY8XpNdlOGPhNp1i77V+KvAapw1EmrnN80zoV
         BNjEKEjJGCAlJr4AUfHTcZDbA7/77dANWA9kp7D+J+uK+XnGUv0G/Gp86imRe7PUORdU
         WiZJeJzCpjynr9cGj1SEu29NYRCtP1dI725FMeQvcayhY5g+insSJsQjObR5enHZ8HI7
         7FjQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDNxnUz0fQyJWocP254AsFFzX9nIvtz1N6xlHFmeeIVVM7D2jA/pUaHgP/03nwFqStcIlnJyB/hAYQ@vger.kernel.org
X-Gm-Message-State: AFuF++l2E1h8v5eDjDQG9mw6+C3Jkq39+nMN9AUrJSfn/qTUV0G5xl8H
	4qOBOZj/graNS//w9JVMNH4q6+41hYaPwxjwAmS2JFfTu+adLXWcZyX0IBUwXKJdSqwTnLoTpt2
	fUpIyZRrqeM7wUPq55Dvb6LtHPbovzHQEEOj922FYlmoNQP8/5m8qvdD7hhE=
X-Gm-Gg: AR+sD13N5zTiJPyc2ivWPWqFdNNN6lCf6XjcPi7NwmMqaxnQBKyFtM+qVND07xFgjtq
	SvC8kVtFnbZs6kW0pn7ZzRMi8u/mqWhukBpCqcB+XKbR6eQgwTaq4WM6s12r6dRxbywG6sUYyyY
	iyOOipzUEh4ujC+5OPSSyPfIJvC5tzDxIfM3w56Z0+bvVbgxLIjzjFlMqLbbKMJENXubAbmeDoL
	NwTo2jhFCDRYlKVe12pJd30VLDMGwqcYMngemB6kd59iWbqLRjEjH+qFR5Yxys7ky8Hh2ruQ7Xd
	TKJYUXYeTcovntb2/RCWA5xYSiAk7ACV96HBA30LbXL3fTinftT+fyJps6S4WF03Is92gKx/xjg
	8xc7jt76j6TO4rhNSDvD+xlDz9fJf0yHZTsFftgr+EoB6me8=
X-Received: by 2002:a05:622a:2cb:b0:52e:2d4e:8ef5 with SMTP id d75a77b69052e-52e4204e8a2mr51065991cf.0.1787738254529;
        Wed, 26 Aug 2026 02:57:34 -0700 (PDT)
X-Received: by 2002:a05:622a:2cb:b0:52e:2d4e:8ef5 with SMTP id d75a77b69052e-52e4204e8a2mr51062861cf.0.1787738253848;
        Wed, 26 Aug 2026 02:57:33 -0700 (PDT)
Received: from [192.168.0.175] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a88a928sm441850266b.33.2026.08.26.02.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 02:57:32 -0700 (PDT)
Message-ID: <a9d2ba2c-36c2-4771-b4d2-6f4587e7ae36@columbia.edu>
Date: Wed, 26 Aug 2026 12:57:30 +0300
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] ceph: convert the inline data paths to folios
To: Xiubo Li <xiubli@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
 <CAOuZWzxWz062Xhzrc5iasq+irppRCG2SfriYEnGPOQXuM6HOMg@mail.gmail.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <CAOuZWzxWz062Xhzrc5iasq+irppRCG2SfriYEnGPOQXuM6HOMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4MiBTYWx0ZWRfX9dQi+GR2N2Nt
 6VjSeXpEbgFofdgEWDkGz5AXLTO/vrAKDU7i/KXA45KknU37zBrZIGARd+1QXxpLZJsBTXx9CSC
 b5dJiR6Z7N/Zv5NLGm+sjudrrkNNw7O2If1u7xOUerm87w+N6NCiOKTIlXZevTeBdEOhxOoT+mP
 iX3kFwX0mjt+cUDIH0yeB5/7F4+2P3e4SWGiZy3FuDMN3kXUGIxhBoJ2TerpHeFKCfuzJbOxAWa
 +6TVbzSlD8yCE8BoWbSepuRndlO8a1OCtRDAP7pTtr2YfCf2UB5/+QFc1Dt9sGivSFkrWHrnMbG
 E2i2WTnZ6PvbjMosXmcs4hz6wqC2KZcbGLcDJzOiEG1oPCf8IQ+eOckvYhLDmwbtXqIqBD8PPK7
 WU53uXPQu/BIgR86HN8jh/RB/OwCXrkkrsiSe6WX9VXs9LVfhEzNrDrK162zw4w9Gf3dRpQSFNE
 hV3PCw68/b0UgD02OYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4MiBTYWx0ZWRfX6whqhylPpdpU
 usYNj+vRoBehI2UnteLo4WgkzCtrvQbVEEYSvh8YH7EljO41ct8aCAKOZ8UOVVMHplhGV1agGLg
 C308DarBkFbEl9wumv++2hQK61Tfd3FNPYs0NSGxSl/aKRCmQ1Se
X-Proofpoint-GUID: ZaQuzMkTBDbHxh7AQB-Zpf7tdTNIB039
X-Authority-Analysis: v=2.4 cv=J6OaKgnS c=1 sm=1 tr=0 ts=6a8eb88f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=VwQbUJbxAAAA:8 a=m4ctf-qRAAAA:8 a=JkJlR3H6xUv8mVj8YEwA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=j2jfHXP1PwAwKcBWPe_Y:22
X-Proofpoint-ORIG-GUID: ZaQuzMkTBDbHxh7AQB-Zpf7tdTNIB039
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11886
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=10 impostorscore=10
 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260082

On 8/26/26 5:52 AM, Xiubo Li wrote:
> Hi Tal,
> 
> Thanks for your patches. BTW, we are removing the inline code please
> see https://lore.kernel.org/ceph-devel/20260729-b4-ceph-remove-inline-data-v2-1-db0c92dab8ee@clyso.com/.
> 
> BRs
> Xiubo
> 

Hi Xiubo,

Thanks, that's good to know.

I see that the patch you sent gates the inline code behind a config option
for a transitional period rather than removing it immediately.
In that case, I think it's still worth merging this series, as it removes
usage of some deprecated mm APIs that I'd like to remove in the next cycle.

Sashiko found some pre-existing issues with the inline data path, but if it's
being removed I'll leave them alone for now.

Thanks,
Tal
