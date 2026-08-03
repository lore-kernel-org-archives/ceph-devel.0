Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F235F5ED
	for <ceph-devel@vger.kernel.org>; Mon,  3 Aug 2026 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752281; cv=none; b=eBLKgK/9i3ayPPp2KSAt5OYoWSk3DjxTeb1Udf2/5O+4ylacQQ8FaA47MaKu3oWfh6NBqN9sXRq75piX3gDMwIqsLOTUvRdEnnhQA4DxbcxqCWW5E6cQuumujBedT0yRvmVJhjeBeVWXWGW/mGQ5F0lFGzpmo9siIgrCZV0+gCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752281; c=relaxed/simple;
	bh=yfbd/LnUFzyVONAmL0nHdpEjPTuPclVvtcKxtlccaJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkEjEKCG/sqyUo8KuaSuC+7hy0++f3Vn7KeQeGLxJrBjXGUoNPSdyJjK0rj5QRjIJMw8QMqU99jc1y0DQoRbOn3JjNyipbc/xDEOoae0AE4O5yDoczxvrfMJXYTS7jCoCtln4v0v5yE+Et6j42XBT9/q6n5/bWsYr4SB8tgtKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=MBFfMPgB; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="MBFfMPgB"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6738Yrwo1754709
	for <ceph-devel@vger.kernel.org>; Mon, 3 Aug 2026 06:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=VKXo
	9RLOepuEerEoxhJYp3T5k/j3I7Y2xiV7gulHRd0=; b=MBFfMPgBbJ0yIGiWLH2v
	HB974bvrFxozlgqRWYxtC15s3RvfcdcK7vMveioJv4/C7D/+tmmTbthOnGWq4iqG
	iaMzBppt/rCsVLj4QwUmnu9Z70FgaJ4zh/UtDVEKXNCVD0vhuS/6kISKvNu6Yi9t
	YB+jitHakUElGsDL5MYNCeCk+MW+cWXoaD9zNZ2upz7slZWy0NDnpN129HCoClgB
	PbFDi8IJwjggoLhMuQgI+97joQrvWB4tmkayC4vEYVT29APN0xU0omTcgHNgKqvY
	x5WVsSdct5qh/ibjzkQFrgYyi3fQqAHbk0ErQJYGCrBToTEr2h2jzPeQz2ZVv+U6
	oA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ft85433qy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2026 06:17:57 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1b4d961dso23955561cf.1
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2026 03:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785752277; x=1786357077;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VKXo9RLOepuEerEoxhJYp3T5k/j3I7Y2xiV7gulHRd0=;
        b=sw8JiX3ZWArrbi3GZbaHRSiR2QExPUCSNp6+JDmRtw3winASgHeuYKXokOM4K2oBw/
         U7vh0NMz/bTQ2pgAFx+O0aqTbtoOVrD3458/2T01o9P7BJEmLe7ri01Cjb5AZbcJ9uJH
         HjlPPKB8WtWYHrNxH2oXA94+E46WT1EhuvO76LxL0vq+X9B53jw6gQkFVMZn9EuYk86B
         56QtMLQ7bfYyl9is2UfWF36i4OAwV+TmEIMDghA+bVkr8I937MQxBmpWdtJhtDqfvCCR
         /lIvNT+30dFBsfJ8gwjR9Sy+90+z10ouh9WPcRCjE+Lpw5WglvCLdV/6MD5PAuOu5WFj
         zDxA==
X-Forwarded-Encrypted: i=1; AHgh+RpzCElFFLKqZwfuQbSpLk1278pQlsA+wqSLAPaduE0pPTrBKf4n97NUTbgRxYZlJKokyUAhrOkAYNaI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8LZwzpL5fbbf6f/s0GZJh/F13soJ+YcPEPyS6tbLiLXC6X5SP
	2KsIPd21ZB1A9ImEYMTo28FCQStMVSlrDygFyag1+OmRjbxmsWv2+ggk3pueh2RsrXBCdfYM9Xw
	8XWkrCwlEWYWCLOkQJ6fPZmXWnxHTWvv76iAtdJVWhx83qPFj7xeIZPnYxlg=
X-Gm-Gg: AR+sD10YB+JH2zWDOqnFVY1YWPTp6k1pSvPHey1qdKI3xs6+RtuittBFTSCK3KbjLQr
	9zPQuuEVA+oV1KqyImhsKSb7pBBrXEYzgFfb3V/dGuCNCEsA7VE+UWe3Ta3106XGY2WIgbziBpX
	0/VgXbATbC/2UenC54jyx7/3PqDxr10jKLZnHu/QiMEGuJszut8sYWCfVbPGwic7okygqu45vDG
	u7DFCZmcokgOvHaBrWU+9eLivkuCdIgBzXdaKJKJlAN6mU/X5VN5BUrjpC7hmQvi3RzpU3BUEn+
	i3arRF5F6HZxgRgIy8MkVg2v0/IM/KdYwGhnslqz67uG8fmWvOeswIGbWom93XE6xTL2Ssr5Q8K
	RxlRP0/DExShLO5CziVJgdn9BAJf/2jB/7F01RwjbkyyfomM3e4dfUyQL
X-Received: by 2002:ac8:5850:0:b0:516:d83d:b28 with SMTP id d75a77b69052e-52b4c5ac831mr165492461cf.17.1785752277204;
        Mon, 03 Aug 2026 03:17:57 -0700 (PDT)
X-Received: by 2002:ac8:5850:0:b0:516:d83d:b28 with SMTP id d75a77b69052e-52b4c5ac831mr165492101cf.17.1785752276751;
        Mon, 03 Aug 2026 03:17:56 -0700 (PDT)
Received: from [10.100.102.30] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a5a4sm32063433f8f.20.2026.08.03.03.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 03:17:55 -0700 (PDT)
Message-ID: <f404ed75-2b9f-42a6-8ee7-b4564f3624b8@columbia.edu>
Date: Mon, 3 Aug 2026 13:17:53 +0300
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ceph: add ceph_folio_snap_context()
To: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
 <20260802-remove-wait-on-page-writeback-v1-1-6c35d6b3ad36@columbia.edu>
 <am-8AaWEHm7I9b7N@casper.infradead.org>
 <DKETLELGS8KI.1B0MCAPS99CXH@nvidia.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <DKETLELGS8KI.1B0MCAPS99CXH@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5MSBTYWx0ZWRfX876VxpPuzk/b
 lkc+A1cAPiEMKcYzspVgU5KbVvq4ap0AttpLQAf3sGgJMxLJawbhknP6NwDuV+r908H4rt376rx
 OcEwoVMquhiuRhTpkrdNXUNRJteW2zPD3rysh0p0F4auclfWGjxG1oOJ0+76EJKe/vmLJ3dgsuP
 vqF1l/zquKaMCTDajF7bWD7YbZVEU3KsmZz76zQAvwi+kw1V2rsARci4eM4t1jOD7VLkd9ezK20
 l5A7+H4Iq4qyTN64wgwSdlSyP5Anox+ogNxa0E9+3JDIh2fGvFvvXRq7LGQBItkgrpU/0NKDs5r
 +ksijGVLORqkkkx+cBQD64pNlX1P6M1xUP7mli2gbpBx2eaG1feg5Q6zF/Sl9BzMJSGUVfCkjc+
 7rbzAGH6gUWWoXwRxLbg5c2sv6/Po1283TuQ+xf6wSuQXnD2oGwaJBazYFxnkQcxHOEKv3IXu6O
 1lElyCa+sGL2F305SAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5MSBTYWx0ZWRfX/SZbpQc55xkq
 qCinOISx5XpGASahhaUSattaE8fCfGhLSThagEkJpTUv7EFKMVPFe3M2LCG/JXJFUTUWmjt5+Yv
 dmzCf8ikFlxeks56LqypxgIul9vYFbrFqSGitTeZ5zeJSIC86RcB
X-Proofpoint-ORIG-GUID: J0zFeHbOD39B9g49goDSXCYt9JYXsOzg
X-Authority-Analysis: v=2.4 cv=Uc1hjqSN c=1 sm=1 tr=0 ts=6a706ad5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=DIPjSMOhCAX6BCWRsZYA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: J0zFeHbOD39B9g49goDSXCYt9JYXsOzg
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=10 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=10 lowpriorityscore=10 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030091

On 8/2/26 6:44 PM, Zi Yan wrote:
> On Sun Aug 2, 2026 at 5:52 PM EDT, Matthew Wilcox wrote:
>> On Sun, Aug 02, 2026 at 12:50:02PM -0400, Tal Zussman wrote:
>>> +static inline struct ceph_snap_context *ceph_folio_snap_context(struct folio *folio)
>>> +{
>>> +	if (folio_test_private(folio))
>>> +		return (void *)folio->private;
>>> +	return NULL;
>>> +}
>>
>> Filesystem folios _ought_to have folio->private as NULL when PG_private
>> is unset and PG_private set when folio->private is non-NULL.  Now, ceph
>> could be doing something Bad (I believe hugetlbfs does not honour this
>> for various reasons), but it looks like it's using
>> folio_attach_private() / folio_detach_private() appropriately.
>>
>> So I think we should just do:
>>
>> static inline
>> struct ceph_snap_context *ceph_folio_snap_context(const struct folio *folio)
>> {
>> 	return folio->private;
>> }
> 
> Yes, please. So I do not need to handle another exceptional user when I
> am trying to remove PG_private[1].
> 

Sounds good, will do.

