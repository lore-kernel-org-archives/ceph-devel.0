Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A14E46C82E
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661495; cv=none; b=CTHR/fr1LjtA1jj2LrcrEz1gZ3N75SSeF9+oH0c34Qc56vwJwsa/a7ZALdo5JBJwETCRLCusHDvc/8SUOvLxFbRQWSsbEkCTjJBq8CWCRMS2NzyVF7Ke8g9ysWkyz0o+3EYTZ5KX4qbDpBbMIRlZLe61pRk4lwHbIxvWPFmNzJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661495; c=relaxed/simple;
	bh=2T5xt5xYrpTJyBgK2/2s4xYsC/gVfV/XaGADRVOUklQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOYdJii2SwFISJ5s+F/nn5MvOs02ln2192SqBTOfiI7rwt707c+zBbw+b0ty9cxxEQYllgb/lbS5NvtvNrNFRp0Bi/GvDqED3OgsSM+8ImbZFdKHTNsTZ7hM5k64LyVmJIg2iFagzVPz/II1C4qRsVkZYuXMOXNkF3Z05l1QQDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=lS95z2dP; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=HNAJGtAq; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="lS95z2dP";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="HNAJGtAq"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PAZnwh1172671
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 08:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=lQP/
	Qacua2ze2fSXiT7UWYPKU3vKsxnZs5GxskwVoY0=; b=lS95z2dPV2Clg7Jkme23
	2kncIJBjzQyE21m3aB352V4jF6O5aTBDwhyl1DCecWFBRVBvi5+dM0oYImpzS9Lt
	eQU0hdTpz3//8FTnjcZAMXOG1dvcY91lihf/te76A/FR+PkL5DHPDLEjuPjX/fzS
	4oDr9F4n3jSdmFUVOHKuuQtI4a/SbQo+8bhPyiu87FbrU2kX2OPj4H/vQt/1wVp+
	ZbHkddkH+z+Y9HpObyRqKJkhzun912SjG0lJawS0J4rqvpVk9IHsoCLZwHuqGuXC
	SClWGqMqhxFDiO45GjXRpdHjJOSD334EGsSknHd7d9RFi3bJWBxXq8l80rHze2D/
	wg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g8u38464y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 08:29:27 -0400 (EDT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7819910f85fso108744137.0
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787660962; x=1788265762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lQP/Qacua2ze2fSXiT7UWYPKU3vKsxnZs5GxskwVoY0=;
        b=HNAJGtAqJuJ5R/PnD1lUPsxT6n9QHqxfYRVg0DuOViIM5KLS1ODjjvAh3ijIPNSvio
         /oInS6NxNgYVwkU6fc2+a3YCz+0+ugozDhf7bG1w4kdCSZJs5TP7DtIjL/0RSIBxBH7+
         vAM9QdJ9nWYdrkdoGtVqagPsgclQbvUHX30Ctd7ZGp7Monupv/5OCD7XHOarPjcAm0uj
         jjtqhhId3Zpv3WNIRIfZJQJMcYTcN7gYqe/I5Jixkg65S5bvGJJCK67ciqwy9L70NLus
         WhHXcmS+SgCznIzpparKGm/l3YzEHoTuAWi92S2lEDN9zZTMqOWvtCU2dAFpAJ/qoqQL
         eBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787660962; x=1788265762;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQP/Qacua2ze2fSXiT7UWYPKU3vKsxnZs5GxskwVoY0=;
        b=hHFKegDvFBQaPysMUww/srLmptDt4f1uSpqom6DLp8uTgrjoIAf4LbZi9RmR8nl6Vs
         JOeElTTuJnioaJOWVt5sUIcptM0mwzoM4N1Tw9ZZCyrRDFXUa+W+sRvsmu/RdwWcu3OW
         5VA/6eGyn7JE+FY2J/3To12JdNrTrxccOwx0OqtGNFkJ/7mab6jYau/rZbyEKG+SQAz7
         Denfk2M2FHjJH7La+87How8TQrCoYeEXtAWQI40jqHNuYs3BA6hpRZhOa/Opfd44TTSa
         YLdvsPiaBT1rvFvC31VxD8m9YiHWHHyYlJTAbRpx/9k8JlnMSK4ZhniUJd2kF8ydpGmP
         3+dQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUpgkLwu28dpXpn7/eMTLi0wrO8djgL4b3kS9tHwvPcnRM0Q0mowWfa1XEbgR7L2guCoVCWldGabav@vger.kernel.org
X-Gm-Message-State: AFuF++lIQAw1siwluDSl/ETMec2F7F1cMYT44EABCHCzsVPiP75hiVsP
	6rC4P6/54IwpVBF/pXvBdoY30YUHz/GBQnWZluX4k60qyzNVkfeCAeQwnlUxP7KzF94gPFXrUEc
	MeMUuy4S4oBn7b6ChL4u66R4chi4SPIVXk92MW0ul+MCMw7zyWqx1zx8JGJs=
X-Gm-Gg: AR+sD12wwNCsvV9i3bcVZT9JmmcqEcdnxsEnyV1C3CmwRUtcJUzabl556LuMeQlvPTv
	cLcs21D/WvZu+gNsQsrNUkvSPTbyXnwPSzXLYMX7EFDk2e+ReCwz7ZiHuhL9MTzaEqX3UKHu8kD
	uHYtVAHmGs9hTGtdVkhzVEm6AjzuxH6WYVfW5r7XunEkuKxw0WXY62GMeUp5NuQ2nNi/ROufB7+
	XukzM6UUbUGW9aiXYS27RKJ7UqJBBKRlst7EdWru63XMxKtafNxYXRurICQHdrzMWLK1MxSVD0z
	UHe4Va3DdcKffzNVKPlNXYMIrIlvTYUSOK0oHSJkClzJcu+jhCM+aYMq9Zrmy34/NNgpN2IpJpD
	vTb17BLKR57JIRmMp+bOSf6LsM6vQ3wjTrzHdexfgh5XoK20Hs5RfKsVcVn0Ouqg=
X-Received: by 2002:a05:6102:162a:b0:77b:28c1:210e with SMTP id ada2fe7eead31-77fe6152fc3mr2320073137.1.1787660962348;
        Tue, 25 Aug 2026 05:29:22 -0700 (PDT)
X-Received: by 2002:a05:6102:162a:b0:77b:28c1:210e with SMTP id ada2fe7eead31-77fe6152fc3mr2320053137.1.1787660961894;
        Tue, 25 Aug 2026 05:29:21 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:85d9:8007:d045:f143:2579? ([2a00:a040:199:85d9:8007:d045:f143:2579])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e1aeab9sm15243570a12.22.2026.08.25.05.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:29:20 -0700 (PDT)
Message-ID: <2de18fd2-08e2-40e6-ba97-4138be672cc9@columbia.edu>
Date: Tue, 25 Aug 2026 15:29:19 +0300
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ceph: fix page vector leak on encrypted netfs read EIO
 path
To: Alex Markuze <amarkuze@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260825092934.2605898-1-amarkuze@redhat.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260825092934.2605898-1-amarkuze@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KsR9H2WN c=1 sm=1 tr=0 ts=6a8d8aa7 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=IK5w7ozgSBlwG0T9EBUA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: 6lb3drV8JYhhP5AifAMdFHDBV7j7wcMT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEwNSBTYWx0ZWRfXyT8IXFNoob09
 bR2TsJ8CHKabauBDU7uqtpZKUjL6SZcieJGVMY7RpdfarL7EhQEQUQ8Chnijm3WwaVUt0B5kuzi
 VGpX9DFt/WJXFkBww30l5QmBa1AAt1ewvVkHoeZ7nSr77cJF6mBfpRmRe0wnXaXnVEdlXaWAaht
 PGH6cTFb1j5lZHDZ7h3SQlOUeUz3cZQw7gNuq2zAbh9mjOcMs4UtaQHHLYp0/3WGabvhHup42UU
 IzU0tHcVcTuk9MswMiAG0aWLwgNMUT9ES2KRnC8SaOgNXL0sYlcpukwduR6gtVB9QqE726Vup1e
 pHh4OqAVoNdfEqkQPCptK2edu7p6Yw5naRje5g+r9me+PbSNV6hMxn9qquddi/IBPSsHuTsk1PF
 zP6VXWjRGK5dFpj9yYDmAaqvF2g/PVDGsVxSOvurSv4repPUjM/ZSle2S+DjcC59kOTeLLTMlpH
 4jzaTHm4msLaGk27vGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEwNSBTYWx0ZWRfXyJla7ulYGSpM
 aWM/6NjvBRM1Ik24TaQgWG2UnAdGzVVrb0fD5Mk2EXije+FNnQmq1xebl+7aVhzHlMkfh6vFtPe
 zCSszlKNtjc5rGjMnT7PSvS8G9QsViy95rH4mkktTPOz7I0hbyU0
X-Proofpoint-ORIG-GUID: 6lb3drV8JYhhP5AifAMdFHDBV7j7wcMT
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11885
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=10 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=10 lowpriorityscore=10 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250105

On 8/25/26 12:29 PM, Alex Markuze wrote:
> ceph_netfs_issue_read() pins pages with iov_iter_get_pages_alloc2() for
> encrypted inodes and attaches them with own_pages=false. If
> ceph_inc_osd_stopping_blocker() then fails, the request is dropped
> without calling finish_netfs_read(), so the page array and the
> references taken on those pages leak: ceph_osd_data_release() only
> frees pages when own_pages is true, and __free_pages() would be the
> wrong destructor for GUP-pinned pages.
> 
> Release the vector with put_page() and kvfree() on that error path,
> matching finish_netfs_read(). Unencrypted ITER reads are unaffected.
> 
> Fixes: 1464de9f813e ("ceph: wait for OSD requests' callbacks to finish when unmounting")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>

Reviewed-by: Tal Zussman <tz2294@columbia.edu>

> ---
>   fs/ceph/addr.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index c05bdf5d7273..8b009e354d30 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -442,6 +442,17 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
>   		osd_req_op_extent_osd_iter(req, 0, &subreq->io_iter);
>   	}
>   	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
> +		struct ceph_osd_data *osd_data =
> +			osd_req_op_extent_osd_data(req, 0);
> +
> +		if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
> +			int num_pages = calc_pages_for(osd_data->alignment,
> +						       osd_data->length);
> +
> +			for (int i = 0; i < num_pages; i++)
> +				put_page(osd_data->pages[i]);
> +			kvfree(osd_data->pages);
> +		}
>   		err = -EIO;
>   		goto out;
>   	}
> -- 
> 2.34.1
> 

