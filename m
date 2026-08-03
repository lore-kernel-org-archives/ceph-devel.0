Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6807C3B42F6
	for <ceph-devel@vger.kernel.org>; Mon,  3 Aug 2026 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785755030; cv=none; b=nvOh+155kFlYtGuZkHO0z+jiDb/qCeMkUc5axLdJEclnZ6lvMd99/K9DvPAcQadrtoIhxQeTCDZSclqQHmrHK76nYKV7VWSdsmyYzGZsPXHMh/cL4/LsZ7MIqQySKrVKqHoWRn13lwy9qLH7J2ni9qZEWRoHx+mMA+U6cSx4ft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785755030; c=relaxed/simple;
	bh=EcUm1EZpbOH7hDMFYcgFDbbz1hSfyheIni/Kbqi18G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGLYtqaR9UEvVD0pk38WHrN6RxrMkvTtBya6wp72pw0C4tWWLhTR1E0SBZwgfY4cTtEFcUTk6uU71QuV9XPlHRqDW/vv4hRuKDl9N1k4ub1tWkZvmozP+hEj91cU9Zx/wR7KFDWlBEAD3pfuYbYeuIY/8ixQTSZZe/C2EOcyGQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=FsuiiLhk; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="FsuiiLhk"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6738Z28O1766300
	for <ceph-devel@vger.kernel.org>; Mon, 3 Aug 2026 07:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=1Ldi
	kCzHnIi62dfq8/K9AYncVOh5mbXj++hGhsLbls4=; b=FsuiiLhkIM09zlFAK1ZR
	JVBQqODgbbTmdK7mFuJSxhXTopBvkbrNFB/WpquLaWIsitYZYWCYXiXaXCfDtTT5
	GdrzCPLsWv6MkkNF+diFTM7EQ6q3jHrYEA0waXyQA+2pz0m76GgQ25G09ifvp2YJ
	TK7Z3mOqNsAxOL4Gm4JGj7cTkndGZrsaU+Rr6SST3K3fa/ONGFVF75rtAhEsCE3w
	5Gd1vyctR+V1kpokQCyeQE9iNs/46Ok3e0MT7tHdxbGNunrFuWPXSPeDLPf+sLUp
	q3Cg85erO9ZtUBIb+jMtk4enoDZODaZH7tGUGX1CRUaZACL2E6BH1fyvMKzP5cnr
	mw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ftcjqt99w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2026 07:03:41 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51ebdfceddcso35960321cf.3
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2026 04:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785755021; x=1786359821;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1LdikCzHnIi62dfq8/K9AYncVOh5mbXj++hGhsLbls4=;
        b=MBuwO912HXOl5bmojTKXTeS+7oCl+vgZBtehyXrPs5OlNCuewzqlzq993UnnkJ+ICl
         gKsjgFf/0gcf7BZYLjxtXZ1pnUOQD8QTVWmsCiwJAvaPMJ8JOswVhV/cYgm/r2Bw65pP
         RnzJRLCxSM1TgLnYaq5/uNG2c2wee+a4iBHRpin9/TieCDkX//y733Bgue4wbfx7o4qR
         kugaUmz0lecfPV0Xt2JOXtaG/zHVj2ls+2IaB9Y+MXyD77agrO56btitku2ob/gknZOU
         mUmqNyRurOzoPEclzvpJM8WudfTX1LNk4QDzkjSRK7Y71VcYeXca09TwflbuZXrtZLc+
         N6iw==
X-Forwarded-Encrypted: i=1; AHgh+RpJKFGj/k68nu0AiGkFSB7Rosk/Jtd6bk1mkxjzfgHdaH6uljGGMTs62gPC5uP+l330pxmqEhG96nul@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/+UPCw+VRMJaaO7QprNs+9SWlDsxQgw8dEe4ecWsvPwcx86o
	ZZGJXnEQh+6O7g9Hymbviqn2TgO8lvszv0Xx+C5HFh4CIqgxANFu/0tcIAq9Fhjs7ijo7kbP2bx
	SuoUlhODCm8q6QBO7J/X34bG67rO4bLIKcthn5PtlytHCi/1TLpB3gZ+DfjM=
X-Gm-Gg: AR+sD112AbahzuuAYEsBfUgjLihu1AVnEXcG+2Ib7E9D8i+BG3HjNLYsLM1R2E92ukQ
	CsqUOmKex99UVfmKp54u51N/wpqPmi1w2mPMtq91ze9IWMnU8NSMRq2XGi/4bLTObHL3/soD/Tr
	/znHwJ6eHBXXi8n5Ds73qWVtLcftPsNzITwM3kijLsyLimPlNfoh71chHelQAHRh0W/9rXoY46T
	f1yBYN1e7btQsccZTrXeXxU6L6Av+Wmv3jnkkue+NbQDJzHJw8G44rGaQZj7VY+yL7FgNDjAg0P
	e85YJm/9GnCU4Ip2SXYANnjW/Ff3h0Oht4Z3BMwTC/oxRXy4sOJFlvrxzexMzJfk4P9ZFrLx1Ly
	Jh08sm/1QO9LyhU6bQ6Q+7POUwzsrLp5xhP5WwmDxW4QuH4Cz//AlbCFB
X-Received: by 2002:ac8:5fc8:0:b0:51c:1532:ae84 with SMTP id d75a77b69052e-52b5669dca5mr178425541cf.6.1785755021068;
        Mon, 03 Aug 2026 04:03:41 -0700 (PDT)
X-Received: by 2002:ac8:5fc8:0:b0:51c:1532:ae84 with SMTP id d75a77b69052e-52b5669dca5mr178424591cf.6.1785755020521;
        Mon, 03 Aug 2026 04:03:40 -0700 (PDT)
Received: from [10.100.102.30] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d0064sm30745913f8f.5.2026.08.03.04.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 04:03:39 -0700 (PDT)
Message-ID: <08c19cc8-c28e-4098-b137-fc9721deebbb@columbia.edu>
Date: Mon, 3 Aug 2026 14:03:37 +0300
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ceph: remove page_snap_context()
To: Matthew Wilcox <willy@infradead.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
 <20260802-remove-wait-on-page-writeback-v1-4-6c35d6b3ad36@columbia.edu>
 <am_3oyOJAoFeBFTC@casper.infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <am_3oyOJAoFeBFTC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5OCBTYWx0ZWRfXwAFsDzwfRZMV
 Eu/9WniwidPPzm04txRiJcdHvmyZAX8Q038OyUO1RLDo0GAK4E370gow5LBm50KXAe901d/bl0Q
 SzOplSKtiLZjyVn1UYUpjLr81TjgtVNsue+M95Fw9dbzSr1CzrZjaVJ7A3J9Ir/SZE/oc/OFiiR
 VEp5P7H8YlwrR+a6iBCKa5v/eiFp/T6YX9oJNuY8ojBMk8IVsaC7ORNc/KtBYjFne/sGcYPSQU6
 R3dhNCYfiaSf89ogRClmwrC0XyONwo6zSTvLmRVDNfCifhqSrTQdCqKxhTVyC0R7L4fPsc4gKBg
 Tp7dYmOPQA/qKZ9e1Q95q/D+chTdcQrWO8cvfMcpjc+A3HkpKe/EnvFcTvnHPTIvnm4sGp3P2Gx
 iECkNlTGxZ7Th6g5JC3Jt1or1zqCtiii+VO8G6AD2v6zLFOMlQWfLboqnIJo+ycl4upfpvLykCf
 SZ+iME2SjvJpFcAYhJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5OCBTYWx0ZWRfX1npO5I8ocofO
 CFKeqmMsV2Y/p72tBOUy8mgv+ZUUQAdrGKZqaiNHEk23f6RwGVSgavZQegj5BFjljMssyJBzB2g
 MjiqZyFGJpcQAdcEuKoKy6224V0YzPHdrnNhpy69Je/4JJV1J1lM
X-Proofpoint-GUID: ZctKbBaukEDzlGsFNoYO9PBQWrEB82RI
X-Proofpoint-ORIG-GUID: ZctKbBaukEDzlGsFNoYO9PBQWrEB82RI
X-Authority-Analysis: v=2.4 cv=ZLTnX37b c=1 sm=1 tr=0 ts=6a70758d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=tvZamFcuqidHLa0JVA0A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=10 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 priorityscore=1501 bulkscore=10 lowpriorityscore=10
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030098

On 8/2/26 10:06 PM, Matthew Wilcox wrote: 
> On Sun, Aug 02, 2026 at 12:50:05PM -0400, Tal Zussman wrote:
>> Convert the final caller in get_writepages_data_length() to use a folio
>> and ceph_folio_snap_context(), then remove page_snap_context().
>> 
>> This drops the last open-coded use of page->private in ceph's writeback
>> path.
> 
> This one I'm deeply conflicted about.  It's adding an extra call to
> compound_head() ... and we're not getting much for it.
> 
> I'd feel better about it if it started with::
> 
>   static u64 get_writepages_data_length(struct inode *inode,
>                                         struct page *page, u64 start)
>   {
> +	struct folio *folio = page_folio(page);
> 
> and then we had a ceph_fscrypt_pagecache_folio() function and
> ceph_fscrypt_folio_offset() (we already have a fscrypt_is_bounce_page())

If we're adding these, I might as well do a few more conversions...

> That way we'd have this function entirely converted except for its
> argument, and a future patch can do the conversion with little fuss.
> And we'd get rid of one of the four remaining calls to
> fscrypt_is_bounce_page()

I'm tempted to convert the argument as well, offload the page_folio
to the single caller (ceph_submit_write), and be done with this function
in one go. Although now that I look at it again, ceph_submit_write can
also be converted with the fscrypt helpers (albeit with a healthy dose
of page_folio() due to ceph's pages arrays...).

