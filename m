Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160133;
	b=E1TElUydLb/LwFO4I1oMaxFcxA7I0RxXDBFaUmoHK7Fpxsr9mSjFvIIc5i+N8/PsISNO
	 QzPSvfF3rEfRnA7yFNjLjeT6T/s+fD0j3L2UjLdT9mJArgHtEREx7C9jiW22kDKogI1lJ
	 Jy3H2yvf4k0IWxVU2Sw4SVSskU2ALG88XN8gMKE3OePm6KJ1wqWiWunaq/B0nA0i0sAS0
	 xNzI/0qaT2iyn6bRANjm3ZRKmUq3GTzzN0N+8nUTdcl5V+MgZCLvJQnUmYb6LxFhpaOM9
	 1Um87Ymbebm5pFey5bbraercEJoIkYcYblwHYbAV/hZHCFZk1N7JrGND2JydbJGGpow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160133;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=QytxsnAJt3024BsXzlKeJhpV41wTQaSwPyf8xsHLi+g=;
	b=F37yirXk1UUnMqgFRroZydNPXYrNiSfjOlRNY5MTEadlhdKZTQyymPRo2kqOK/CKF++J
	 Bghee8/+cGRfoiStkczeUUsFAVUfgGmtY5D4r5XVt7ginNfg7X7OTPCBBuMvhDgvzTium
	 fXWF5GGlRwNQVq1sTtOVoxDDiIeWmdQA11R2xdUJF//nXz4rDXQWYTV9rmj0Y9TiDgfm0
	 QdG77bFqcNn8JVJdEvqpEwmS5VemFZs/ipcXUQfgz6UX8IEFQh1wTM3VJMgyYQuEcPi/E
	 p8x8V07Xqku5Gyfblf2Vgkif+3iTXMiB9U9L8oWv1bk29tGskmaHe/8b9BNcrofnTTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=rxyrW+13;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA77760A2615;
	Fri, 20 Nov 2026 07:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA77760A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=rxyrW+13
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3Tk6I3550304;
	Fri, 20 Nov 2026 07:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=QytxsnAJt3024BsXzlKeJhpV41wTQaSwPyf8xsHLi+g=; b=
	rxyrW+13l4NiMnSmpAdFBWhMo7tE2Ln8VEu8TfTnNa8SNumSGMvfv0X1BAyYoawZ
	Hg7yVhC4RbaJopB2/RL9t3pCfmJDbXfDKZx3c5iVd2EBRRtYBbYcPzeq/Xp0zc84
	JZQBVMuf4ASCK8FRAy4TETH38DL5RgMlUr58kuNrrNtl7ccoN2wg/RFeyHoci+NT
	nnjT3Wx+yC0grOBHl37zgjEeeM+iT8Wq4iTYdEkSX4PADz+N1sxGY3YsUYHOCvmi
	XXiMHKouz9XEC5c1gYX2+fgUVyULRwzcbat+Afs2MIeWZtV2BS0Itj6yFOaexJen
	Q0K4HY1V0syZwz7hiyVBrA==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021143.outbound.protection.outlook.com [40.107.208.143])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvkg737-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:35:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gf16p0gtS1MjFbbRporAsppqFDf2ZKVxwWXzLAbR8PBOTYWy5P0OjyVRAXFSXtaI6PB9SGZpoTvPApyVtlzp3fA+KwI2rl3PB9S4ViVAnuQ4I9mwzd4jq4sPFeW2KN9n3vD2jRbYm6hVnaJldeQCmkQYZU84gF0rnso+zYLL/PeU9mdxKL+RwLqPg0X1rddn3aF2FJsoTkmA7Fg1ZQruPakSNSexu/ZqwVo3T9jlf9lndYbgi7DbxrflpmtLLtk1CdowQaze4CbUzAWYfXCKpqQBjd72nsi7H/6IFR/KpsxW1EV0Y9Yw6FdwN2yvQTZD4Jj8H8TfHDeKFHXgPxd4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QytxsnAJt3024BsXzlKeJhpV41wTQaSwPyf8xsHLi+g=;
 b=d4KK5pR062cYYoqUHiNv5V7xBN4eI6jRgLHQTT5DZuTWUWFXm1WeDY7XnnsItrrSeEuYVyTmJnDR1Xz94cpyPOcGgSUlGI+9U89zzqEPCVlHiFasn8SzhZEFFbpHFA24e1nIEj01dVAcL61e7YeKrbJkrAPCNv8bi3MNIlWH7wPwSsL8/767DIOQxmjohhtXEH4oDj2rjS3O8UqG0zSy+Z03bgalaTpzZwX5TNCDWh5R6Qg3Z5yWDDT3AvqIAKPjHRKbn9vdhbhYpp+zgcj2vf8pyHGdJQcsWbFv8kr7jpbuR55/kP9TjInF4gRLwPzqzLX0uEZIFYLAWLdMZyVX6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 07:34:59 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 07:34:59 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubo.li@clyso.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] ceph: bound the ceph_osdc_sync() wait by mount_timeout
Date: Fri, 20 Nov 2026 09:34:19 +0200
Message-ID: <20261120073431.53636-4-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120073431.53636-1-ionut.nechita@windriver.com>
References: <20261120073431.53636-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI4PEPF00000142.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::89c) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH0PR11MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c244a77-e374-4f52-54cc-08df46d8c811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|52116014|366016|1800799024|18002099003|22082099003|11063799006|56012099006|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261009223027099003|261102130727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	z9RtprJy4TIa5AGp5Tqwc11xrGmKSDGJQ/pWAEVtsUKajDS9zirF/ctpDIMMYSiLfvKVH5L9+yKruX9ABlrvtxPCrAwRSgBvNFQHkZKpf4CO451IunQ1+u01CRYAxVNPfwrfyJh63GLKBCL0Xij7/6ViLCoYGVwly0czwGg6N8aKTSON2lKgpdpNL8/yzUi9eaT5HFeYXMtowlTroUBHQojQC8rC5y29VyaQlOV6TwP1phR1ZaFdcLPucz3gIZX07CFyw7ONw39Jp0E3N8bJAkLama+e44iF6rFLSaT6cbKiDbqxAOdjsD15MMFp9DyWVizamCL+GcarnhFcLfqvnBKfC8tZbiuzPe0qTRHAk7Bf+jbFLEvjmJ9B+19La9p5zU2GONfhHAU41L6f3UL0hx5wAdI3mvw4JTVwscW2gdxq2BFOn1TgJNjavp9n5x69A9wxip5h2WxTixebeELE//ZkFudNzeXonJtzxKEwQgHYt4IRgRWO6QzVToIjZ8NY+YSOXqN6X6/pfoQhWTqjBuc6l7xVZkGYnkOOng/M7wxXHuZQYPz9rmPEN3Tx7kjE5OCzv8aZFIWvsbMEqbx90w1OPJKY8Fm8i6oANzQVoHclhI/58Cofn+ZIoBPaC0hikSyrupU4praaePh41h3GGn/AFl+d+qX+PcDLXUsD/J8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(52116014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102130727099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qZ3FkT6eSlNRfYEvjSfk1kuhMzLir37S66zwV2w6bGIth2fXtfeYNjX1nD6F?=
 =?us-ascii?Q?eLy46yafoEK507x6GC6q0/mvaf4xtO20lysaouL+j6DWLfKYvygZJ67Qe7yx?=
 =?us-ascii?Q?/7pm5UePbiLx4eYycLfIy4hK2+ioi5VJxyvMNwalntcDSYvSoJGAnYo1joTo?=
 =?us-ascii?Q?1WnTXCf0q3c5xx80I4wfTTu4j7HqguJVCmy74slhGdPuuAtG89oeiqmjzA/+?=
 =?us-ascii?Q?ziQ6JXRxvsuOLWfl9yNwR5GO7SrUMxdMzZzGnEk8nqKws1MZS/9KqQJJrbw3?=
 =?us-ascii?Q?kuKx8UEZiHQx3kSL0iNQjUL7N/9HvKD6/z5goBrLhkM2Dr7jcZ4nZOfBw3OX?=
 =?us-ascii?Q?NOmU/UTomK1BjeG+2358eBXU91CPgW6nw4e1wyo8SzrX8I/qCqvmg61qiGdG?=
 =?us-ascii?Q?IizzQ63DClMQPx8JLqxHT/9/VOWtodRYu4Hq/fqpiJ2D2V69SQQjzvYgDRVD?=
 =?us-ascii?Q?U1FWXl5Pcy1Zw9MRMmAuAA67Ju0TYVtk6aVyQgqslRrRgmGpCOYW+bSkp3sh?=
 =?us-ascii?Q?iYGz7mkC64ZxYwlKLXQPpMqMudAXcvykIhAHikJMi3ROAdiZUoaohLfhIku2?=
 =?us-ascii?Q?oOsGIA4pZEPsnMx41ITLSfwSZWGr9OOeWUwUsACUn9cRA9H4grjKwL1TMW/S?=
 =?us-ascii?Q?66zg5jHFENCOMxPs1wv2qPWqeRXDyvDZmXI7wni5pxzGv1UiLEfiUTXEifg8?=
 =?us-ascii?Q?+l/siMVWLCTG4yA4q2G2EQ8eR1OAPWH1Kku8pBP/Lc43/VfLF0LS2oS/JKcD?=
 =?us-ascii?Q?CGEvRcrnLetU129pCvLjcLYbjzKKuAmEJ26stvTsteP85pVmiMwrVn6zDGD8?=
 =?us-ascii?Q?AIlgfQo/Qjj2dPsMpwKkC5vXQr+R8hjtyviIBVm99qCYyE1KK5l/rpGubPUB?=
 =?us-ascii?Q?wL4UzpuCCjf0TLSLEIiP9KHFuO3KOSCAJE4v4ZhMNML+EOAKPLAY0IeWXHWG?=
 =?us-ascii?Q?JmQBSzaDHTIXhK52HxZqWVbh0PFw0pSKRLQ7SKzTmk/3syh6noXTUzvJ9fQE?=
 =?us-ascii?Q?3atVyAJhWVHW/TjDPFhCDbLYsu48LxCPW23sQ5grE/rlXG4/B9NIoiP0H1/y?=
 =?us-ascii?Q?L0AoDX/PtKO8ukDOJvLa6W1Yb8BZHG+0q/T/qWAz9z2guLeiOJOUbPrPH4jr?=
 =?us-ascii?Q?CdmmOl99KTkuxNPmVJL3r1EoPpzVjKuRAdwOX5EWfHr1BbIrM8g+U2dqyJmx?=
 =?us-ascii?Q?du+8xBaTFjUd0nDHznI3Dlp71DljSzn3c0Uv1shQH1B1wgGUHCG2KLCNiP73?=
 =?us-ascii?Q?MLpSMsu5G7qCnI3guR8IRJ7c0EYSLZLNp+REvHeKzC1Sp+ImB36+zukwjgkA?=
 =?us-ascii?Q?Zf+0VacakXsQJo1S2tvqZcf4qebZF0OuIzy9YKYcPb0clsQ18BpAS0oM7mdk?=
 =?us-ascii?Q?mLQjPgLNetVv/hA+nkx+xyS8RedkepZekZiEi5gbPSpdzJeadZwK0wbnSVhj?=
 =?us-ascii?Q?TBov3zCdxv+cq4FenE8Zau+dDwcnF3+3aJq6S7aVLT9yMz06AfOZtiSWLuzY?=
 =?us-ascii?Q?pXx74EefnlvL3mjRwdukCZNxatNP9zsholnjQcPp/kLudzZvvaF8LuB3LCt1?=
 =?us-ascii?Q?VOz9nhnMzI2gzQjVM4ACyyAx90X/Vfst0AzbUnxLsq1rjbMBIU7ziMqf7/Iz?=
 =?us-ascii?Q?+d4i++EqEE1TBIBdFe+s3x/cxckDQpIk5kK1mYkB+W6p3wpvZGGKkCltc9/l?=
 =?us-ascii?Q?jOLt3lYceE51qbJmgFHYCoosHnDxPU465yAL+CJp+kl4aI4yzj2vXvQEKG1v?=
 =?us-ascii?Q?jm4uGApaOylReW2YtuBxRhbKbpRj/kSru1tC7BRl2bMBRqb2HWgEFdSz3BSm?=
X-MS-Exchange-AntiSpam-MessageData-1: bt+afVMZFRQoFLT5liGhLcRAlOiZBlHz0sM=
X-Exchange-RoutingPolicyChecked:
	hGjFHJgEQoZMOXm373o7La8875D7TD04GSg0W8/cR+qcq71r/QGd6G84yQ/3GG4DVLTdVVMuizqkYKo5dMX8St/r7ttzKPSir9vshiPv0CZO7kgIrdY6kxcvL91AEOoVEzcsKm+aqkQi1rAR3L7MJvmujyX+UyqIyB83S9VWMMWcAelxUWUZJlCRS+aDJIA3NGXYZLkh0IctkchVs6VHfOs0u5QJpBwFoYynb381nCs2nJx3j29qg9jviOiVodeVNHe+c7KBiGSYyngzCUjvNPOqY+Dt3+ttQcQ1/+HKSq8X0nokdQyz0KRX0167AE2HuZ/6NI2EpdTwSuiopbv7fg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c244a77-e374-4f52-54cc-08df46d8c811
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:34:59.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zd23GeM2zyI9v3l8J1mTMGlwOhadoTdi1jEcM3JAjeJNEoXnEl6jH+aAk2JR1S/NIv/lRxcwIVIvF8rdrpOb1EjCmN9qCfKJm5iKdDBWdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX+JQHhSvhzLJU
 Q7KpF2ocFzBrBpBjwj9faBT8E9NNBx3MmXVy+y4lcjRp9gWPc2FC87FcCpzqXEHKHlN+OOOzuN5
 ga6pmTGPYPS2H/bC5DpPGg+xX8+czsVz+kSNiseDNSdjKjSM0+Es
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfXyJbi1/r733sV
 AYcycnpo4NOp8oqqAxP2dx6AoLK9qW+LENMA6IlPzU7gF08za5le2G043ntpqFWQQ9DG4VOiev7
 1lHzZ9M1iroiX8SI/qkoL+2Oe79CvdqEAonULsqGT4ENRIYXbiwim7Mq9hIynmLbgvthXx52aZA
 QpmgW9/7NjyejRBUvHLmHg5r9bv3PDK3+LXqaYxvafnRaOdzY7keiq/jGiZXFZh0JcTHIWo150d
 AGU/KmdlCvdWl/D27Crb7KVZtqBcSVTZrLFWkyXMqgqPY/DSgBRCsIHG2AqVrUNwY7sRE5shIW/
 qoTMor1kjPQ/KRwD9c9w7B+340YtO7MlYageoe4Lbe7jRw9dMG0rt3YbMkpQcReuL/OXsVYOVqy
 2v931QUGTYsmhN4QF/2pfIcdSZ87Vn3j6aUfbEEEUgAIU0HpbG33TYQ7JxOGsg4JzPn3v9t2d4S
 /Ye/mfclLL4/eS1nybg==
X-Authority-Analysis: v=2.4 cv=OdYNnRTY c=1 sm=1 tr=0 ts=6afff82d cx=c_pps
 a=QMhPzt4RVFymwNJSNtbcTg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=WPZHdWTYe1UxAjlnSMcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: _1e0fvLczeK368HXMKgfQTbGE0UNBiDH
X-Proofpoint-GUID: _1e0fvLczeK368HXMKgfQTbGE0UNBiDH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200029

ceph_sync_fs() calls ceph_osdc_sync() before ceph_mdsc_sync(), and
ceph_osdc_sync() waits for every in-flight write with a plain
wait_for_completion().  With an OSD unreachable, sync(2) therefore
hangs there and never gets to the bounded MDS wait:

  ceph_osdc_sync [libceph]
  ceph_sync_fs [ceph]
  iterate_supers
  ksys_sync

Bound the wait by mount_timeout in the same way and propagate
-ETIMEDOUT.  The requests are not cancelled and complete once the OSD
is reachable again.  mount_timeout=0 keeps waiting forever.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/super.c                 |  4 +++-
 include/linux/ceph/osd_client.h |  2 +-
 net/ceph/osd_client.c           | 24 ++++++++++++++++++++++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 7936b76aa3cc0..166f6eb21f0af 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -137,7 +137,9 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
 	}
 
 	doutc(cl, "(blocking)\n");
-	ceph_osdc_sync(&fsc->client->osdc);
+	ret = ceph_osdc_sync(&fsc->client->osdc);
+	if (ret)
+		return ret;
 	ret = ceph_mdsc_sync(fsc->mdsc);
 	doutc(cl, "(blocking) done\n");
 	return ret;
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 7349ca09a227a..674dd9221d657 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -579,7 +579,7 @@ void ceph_osdc_start_request(struct ceph_osd_client *osdc,
 extern void ceph_osdc_cancel_request(struct ceph_osd_request *req);
 extern int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
 				  struct ceph_osd_request *req);
-extern void ceph_osdc_sync(struct ceph_osd_client *osdc);
+extern int ceph_osdc_sync(struct ceph_osd_client *osdc);
 
 extern void ceph_osdc_flush_notifies(struct ceph_osd_client *osdc);
 void ceph_osdc_maybe_request_map(struct ceph_osd_client *osdc);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 4479ec7a932b3..417374c95dc14 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4715,11 +4715,17 @@ EXPORT_SYMBOL(ceph_osdc_wait_request);
 
 /*
  * sync - wait for all in-flight requests to flush.  avoid starvation.
+ *
+ * Gives up with -ETIMEDOUT after mount_timeout (0 means wait forever),
+ * leaving the requests in flight.
  */
-void ceph_osdc_sync(struct ceph_osd_client *osdc)
+int ceph_osdc_sync(struct ceph_osd_client *osdc)
 {
+	unsigned long timeout = osdc->client->options->mount_timeout;
+	unsigned long deadline = jiffies + timeout;
 	struct rb_node *n, *p;
 	u64 last_tid = atomic64_read(&osdc->last_tid);
+	unsigned long left;
 
 again:
 	down_read(&osdc->lock);
@@ -4742,7 +4748,20 @@ void ceph_osdc_sync(struct ceph_osd_client *osdc)
 			up_read(&osdc->lock);
 			dout("%s waiting on req %p tid %llu last_tid %llu\n",
 			     __func__, req, req->r_tid, last_tid);
-			wait_for_completion(&req->r_completion);
+			if (!timeout)
+				left = MAX_SCHEDULE_TIMEOUT;
+			else if (time_before(jiffies, deadline))
+				left = deadline - jiffies;
+			else
+				left = 0;
+			left = wait_for_completion_timeout(&req->r_completion,
+							   left);
+			if (!left) {
+				dout("%s timed out on req %p tid %llu\n",
+				     __func__, req, req->r_tid);
+				ceph_osdc_put_request(req);
+				return -ETIMEDOUT;
+			}
 			ceph_osdc_put_request(req);
 			goto again;
 		}
@@ -4752,6 +4771,7 @@ void ceph_osdc_sync(struct ceph_osd_client *osdc)
 
 	up_read(&osdc->lock);
 	dout("%s done last_tid %llu\n", __func__, last_tid);
+	return 0;
 }
 EXPORT_SYMBOL(ceph_osdc_sync);
 
-- 
2.56.0

