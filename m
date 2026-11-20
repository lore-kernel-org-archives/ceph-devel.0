Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160132;
	b=2pDbq6jXF7dBPlFaMKTVCRPEDmyUILetzdt2ZSjiyWRzu6UfJwzgH6ufwHL+IXCn0kXk
	 cL57X1xU9T+LaXairU/OHfI6W2nrYMpKSzpeVySv3fWJhPt7mVcL6xC3Hwg3BqYXVINP1
	 0OcdgKg+owz0o5DhOk4OP6pGQCAzHe/F55kWz8JmI7sRvGaXautxZy7L8ol9sP02qfBTB
	 k7K7eFrPPT7EZEX6uTNVek4CdAs8OJXyiHtpXXrXNCkQp0NUNLZRfVAdF/uzaDTtd5S1j
	 EzuYtQC3G2hPAo8NdGZcAK8dth/dSg1WV4Y0qOd0hbM7fmElBVDZ2JrRdg7fexU2J4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160132;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Zya3GB5IX4kX97UMprzbAM0YjNq5L4VfQllR62Y5UXM=;
	b=15jlKwvzP6QS1d/S5Nexcsn9ObIDLJd0BTJuGzzcymN9/ipcq5rgnzkndmOEP9Holp+A
	 obxrWdd6wLxRiO+OczvAlWDsNu0SwHN3ateFGl7tHzmALqmld1NNjNLMYjnSlACrnpQC5
	 +pvTr4rejKAwzGWOPa79Bxu1JbNT9dvP8rubLBs1+AODR8rjEAYNQA81TBUh5KLZgcNua
	 iZnyAAEWI+tJcdej7mshD66/g1OxtwMU9ypuzlvSzuRKbZopuzJd3E5ZvWsOhhwjhLhgF
	 dEVQ0nA/YzHpj7Ky33on7r+l1uMDerYM11XqUiM4dNigBSjEr/WWjYRpZY9Go2AwlXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=ZHJbffbk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BAA606A337;
	Fri, 20 Nov 2026 07:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2BAA606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=ZHJbffbk
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3TRQe245230;
	Fri, 20 Nov 2026 07:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Zya3GB5IX4kX97UMprzbAM0YjNq5L4VfQllR62Y5UXM=; b=
	ZHJbffbk5ZLx391RtY51OiD9cdTmptjmIkIJs9UsNSlr8YgG6CNcGBrUH8tKczlD
	S88oWA9ngPPAJ0tboPbxqcpqdJes6IVfgKQv6ObcgVtQtJc3H96DoqtSjkQb2P5n
	a+Y2UyjqCJ+XsZMuj6wZHpq0xKW0UKeSOwqFe+93XP5bYhXLuiHOppNc0i1+N2Xc
	Sbrda50MGTTV4wmG0u+DWkRlEuE6ZvfDy2ZIyWtds8szs8tT8RcLyuXk9Lqp0pEb
	DN3Wh907bvxMevhC5TN+WYhI3RdmVXBrPbd7gV4PXTgpYrj7TFls2VlyqsKXJ2T4
	he4RphStVWdpXHfDxiKsXg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022131.outbound.protection.outlook.com [52.101.53.131])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvh8b27-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:35:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9ESJdLHMYLzMoqWb7pMbInUe+sjMTBa9oZY1ZaRIEkOVq7otXh3m77nfSL2X5P6CJBQ/c0y5iBgkiq6gk6lZbEkrJ8/ywIVdLWs6pCHqanbrrB7Cm1uMdJ48WunESGSIWuzCX1SAUyy6RfzWqiAeoklzEpP0ulPEWiI2ATagP21X2IeUjkdq7D5pr7Mkr11UoUFjFuhdL/p/gajXKmp2ZdwYC1pcy2rFOioMq/z7vGB1icGpkJil1O/6moL/v82JBEGIij5BMjBlaa2NEad0JH0mr7B3MhO0D6B09UtIavplB6iu8kZJeq4LjyZ6b5BJFdLBxke2xBT1JiP7I6H+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zya3GB5IX4kX97UMprzbAM0YjNq5L4VfQllR62Y5UXM=;
 b=qZySsl6faeOyQyfSa/39tM0Smr8aWAb0DDiDTl81Q1gs31mDk+kYO4t1W3SPYY0g3daphNl2SI8mQi4JpkdoWrIbecMos+FMvWJDzF4azHQqKnQXyoEnWhSEO6llyl213JzwOm5AAQniGKCu2ME7dEezMZ6eVGW+0nobJUJkMn5k9Hpncv+4h7yXakohQRon4YUE057kG4ypKXVYgn8T/R71Q8epPDB5VR0adzQbM88Sq5cG9lR7+wr9i26jxaTB80kkaQPzrnMenxfb1DQGhyXJhzpU6vVj4zCL0uT1RhJo45+3/s1nTH7VxkKTysYtmDXDeCbaG4hIgxXZdYPyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DSWPR11MB9821.namprd11.prod.outlook.com (2603:10b6:8:4e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 07:35:02 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 07:35:01 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubo.li@clyso.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] ceph: bound the safe-completion wait in ceph_lock_wait_for_completion()
Date: Fri, 20 Nov 2026 09:34:20 +0200
Message-ID: <20261120073431.53636-5-ionut.nechita@windriver.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DSWPR11MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: e245543d-7c52-446f-889b-08df46d8c951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|52116014|366016|1800799024|261022105027099003|10067099003|11063799006|56012099006|261009223027099003|261021123027099003|261102123227099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TQl+XVf4Ch/e/77QUwDpjYy0DhSFwoZvG41PfxIc5RfpdaviPmmgVdNKKiIfY5P7vCdJyBa1Ii0nY/STOilgLE3cYdAY1nWlWtwDbz5eY6EPLEdeMlwsF87c97xjLrExKXCtxgNIQR34ThpY2R9+scrXHul+Q5Eodf6VBvAyURZudjbBDmh87u6f7YJtBU0+PpZLTjNe9fkaukV+cNRjWkvqEZmmQjTviE7kFQX1yXjNWnPVjA0o75Zw0aWQsM5uhmxuFzKrIesO4Ic6iJ5p6L1E+j/QS4nReAHpgxPU8Hab8cl4ONrHU7s12jf6dMjFXdvZEHF4Jrgv/gxQsZ92J4D2HgmmvfJ/jHmyQZ1+M0cmUQ29zCZ77h3qsBQJRbL8uTBlury9u4QJeRiMnGFTiWDOZpGf1mbvsIpTBZmiP2G0anB0MK5fhOGbSd9OdnXkKwTNaHSYGNtrUhi9GeQ28h6ylC0U8wOoefUupQFiqwXcwtor3dqXvzjK+eWb9xLjWi5oP3WV0NIcfohF+R4JFHGX5sf10Rv0lHp90+2jvK7ivDdhyUtIQ3/YkGghBzlNEfJpxEOoXSXxFSFYZBPjw//lHY9MZjIBY5GMOpL/8d0M7C38cRQxQ7mUmao+K8Y6HS2U/YjnmzUP+13zzg212MBR/IlJOvrQmMN88JxsZH8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(52116014)(366016)(1800799024)(261022105027099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QZquiepn7KowD0+c9/6y4Wd1gXUtoyb/9c8s3jdYK0yjdEloDqniQHYod5t6?=
 =?us-ascii?Q?Ui8IpjDa1gD2AG0DAj2hzRIbLa07WZcufF7SXVP4fBg/vKZ/hyLOl0u+aK6N?=
 =?us-ascii?Q?5Mgz2CkOZop01I4my0RMIwfcq2YJVD1q/MYKBGjxD6czWB+EvNtFKscmURfg?=
 =?us-ascii?Q?iPlHdPgfO0X2id5O+Aw5skB5HaPi6gRzRk0dBjxqQgOY+QhkJrk2pO3wxlyP?=
 =?us-ascii?Q?jzzSTnF9bk5q8eDznKn1BNg+nYEIUkXKS5wqsfukG/l+GI1pIMpxgJlaWC4K?=
 =?us-ascii?Q?bhwsVR+WYssztxuu35q83qZiA10foxnEFLG0peYdqqFiHzC253Mtpi1pAq6I?=
 =?us-ascii?Q?J24yryTu7xMNkhT0kzQp56V76RTiycoIscj9NzmZV1vJF1AFjwniibZQ7fsg?=
 =?us-ascii?Q?2OwIblxIDL5D62E0ZCLeJhyMPayMEvFBXlSn2+9+1w9V98OVKj8ML+uW5whw?=
 =?us-ascii?Q?AmuwZU7kJqhGtagNyi61Cbpcduaeia3oIFS8ZUSBel2KiBFof0YHsJo2AYC8?=
 =?us-ascii?Q?bcNdztzF8DNWeHrzeNtMinIanH8Met3+y4xwGKj21ZV5j6ZTMNjcTrg8GJKu?=
 =?us-ascii?Q?NlNkWV4SrS123Dhxg6kE+wJRetKpjTusYoFlDYxT+MVcb3TOLZ3Lc/Y6W9/+?=
 =?us-ascii?Q?4HuPku6/E11Pb4mRCuwYTYogeO9EotZoml82YjPA9gK+0s8EzD77e5knrc+c?=
 =?us-ascii?Q?pKj2Fz4JiDtoE52m9mUGrd9EROcEAvCVf440OUgBNcGLtzZGyUtrx23MMkzH?=
 =?us-ascii?Q?jFBtMpgYO+P4BMfYWo5bXIAeRmXsu/XKoa2T1MrzYPN5SAe0+fCqLLsWqP5V?=
 =?us-ascii?Q?d7hRxjRzbXY5p1beSCqtZtADHYzKw8fmdocEaVL32EIAKP1UtdI79AvitLdA?=
 =?us-ascii?Q?47h47r5o0qxxSrey9RYwXKfw8SXFhVIrk2nRFt4orwGC6hjBDFJ3LGwILKRc?=
 =?us-ascii?Q?jgm03RIjy8bMtWmv73yUTbDN3Gjx6NXWqqPeAxdCIpfDyI9Y2TFCofSvCjDg?=
 =?us-ascii?Q?sCb7CM8zc1XYU/oPRYn3Et+iPhMrf8WxfFAfNPrmxIkpKpZU5n7ydSsyUBCd?=
 =?us-ascii?Q?dwegOOuP6KPrkm3Gu4vY7TJ8srXoz9ut+ZDHlFqkxVNIUQVzTiXR0jdt3dwJ?=
 =?us-ascii?Q?R18WOr4bmgWrmFHUa/aqZUcy/Q46odlYQkXYmEvxYlGzweROA2BEGO9F8HE7?=
 =?us-ascii?Q?2dowsCC97KoeGRXfxKGd9R2SYARXDSBwmyBfqmH6PKMtYIUNqLSJD0hYCHDJ?=
 =?us-ascii?Q?Y1UOvHrZu/ncDnBoL+TlwISc4uWMHH8rOwRUKByOaPjm0wHwBckBjWewaMX6?=
 =?us-ascii?Q?s7aZjXLq4sCfnD74n8OyC0YKWeKf4NbHeO+XYinr+UcSnGL/5agb8S0XRfgh?=
 =?us-ascii?Q?5V0r7WfuLmSWaGeNFQAPdA7/oe+PYDQCD+XGIo9TdYLv/Iq2yIFlaL+DJf/6?=
 =?us-ascii?Q?kUXC6AiM5P+Yjytt1VukvKCMpuyxynnqyWZIxYApzwyTEuswCs9jC6j/XwbG?=
 =?us-ascii?Q?VZEPcgUVvlZ1yAjcD7USRHuGa1GW1n58t7COUc9BAUxYfFWukzV7ux3Qec5u?=
 =?us-ascii?Q?qHwH1F/USmQhXWr2gb/W67rhgfQk+CD6J5UqX6PPWr1MlYC2DcUyrcRbwJ4D?=
 =?us-ascii?Q?jPTvhKPeWj4soP1INlnTzQSHnSvEVmOSDSucTl/BZctpjLlnaTIlt4WGr7A0?=
 =?us-ascii?Q?1g3HEKCkMcE7vI7ZpCXhB2X6wXn394RLbscf9hsdIfcT6c6/+lVPgpA5al5Y?=
 =?us-ascii?Q?issiQ/kJblyyU7JES3q/Db86/xJ17ww9vOWkF4F/Wn7pUD5Jte+qegDptYNL?=
X-MS-Exchange-AntiSpam-MessageData-1: YIZG05ZQbc3Q/iXxLy3rt5HeKHqWmqFysy8=
X-Exchange-RoutingPolicyChecked:
	DxAV8uBgU7h7zDN1fA9D7COGDDIqLkRJzfFSX/kMRcYpwp11mAM7C2IBvCrLFF3NgaH+mPXjxy9RWUVfKHqKvwFVoLEK3FqmYrAlUN28mRDPQzAXdMnuO81G2ixs7bD3cnQt0/K3UMxhgWKdvCHnFIsWU5NrquGJdAS9JjJaOIX58UdOeqmv7FT6hpaKiSiF1qVdSAWf8yjG0F0CbDcxoj2pe8FXrZiviGLa8P0fxHc34jt0swe7XKcOFAgnP934W0+DEuUJ12+gozmOJvnKPAv4TxbQ7dP9vJZHAeuFIf4/1L2OFMqODTe05HdSbzy+p0GfFAZxnINlGR+60N/5OQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e245543d-7c52-446f-889b-08df46d8c951
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:35:01.7439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwXu0RFHbDPT0qBoakBnT9u7KRqU5ugHPueLlARCxjfbwJ3QBGXttonN8Ocl8mkcdqz1eJJ39b7Tl2RHPUJyrWi5jl7CPd9ck6fWRHD+cZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9821
X-Proofpoint-GUID: aGKucz7-GXqfzIYY0yUoWNffo7U-i4H1
X-Proofpoint-ORIG-GUID: aGKucz7-GXqfzIYY0yUoWNffo7U-i4H1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX/Y0zzvMzUwyx
 +aWWR2hhgFhrDWyYZv+PAkHsiPBJbGfQaW5KIPYj5c7xeVDuWiuy+GCWC6ovbJu7xmqkjogZZQA
 HE9EyJSb1SvOQ+fxerxPW3jq1hUoQGERamN05Vu6TLQN1X5M3SljG5zWWDrE4X6t+E+fS/KTePS
 g7WO9CgAa/PtpSSi91kwcutu9Nvc2kot8MClUnQCHifOE6jmEmobNhXn/5upCEsyYpboT/WP0I2
 4vLUkGfkVCoaqWzYhe9AtRBmTwj1rqHN7/EdufY8FzSohFjbn971Cw654YbslX+G/WBetwSra0s
 iswQ7dUvXR9DsZwfPIGrAD6IUEnI54xzWzoixjsgBPiSNSZOlYWjb8aqP61cFkF3dP5mg7zZz8E
 REJeGalF/SVxgqzzv2/EmrNcMUWc9HyEUbKCZ1CtHdQvGyLgPcAcPf/pgGfmL9VgJ2Yt9RU+r4r
 D9YbsstMfr40q9OhO+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX7/vRaiPb/VR7
 E/7kvmfVtJwaTn8yPucdw+FAWO6DZNo5nGTpkMi8lXKBGg6xIkZl8t45kLqo2nHRtP6nRZKq76C
 Dmh2gTHgWLUB9LcKO9/gtIv8GteM4cmdtjayASnadFW9yr/umzpw
X-Authority-Analysis: v=2.4 cv=GNCdgeNK c=1 sm=1 tr=0 ts=6afff828 cx=c_pps
 a=6tOaaN1fXmJE/LdyR88bKQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=kiiYn__vwDNCVcd8uBgA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200029

When a blocking lock request is interrupted,
ceph_lock_wait_for_completion() sends an unlock request to cancel it
and then waits for the original request's r_safe_completion with no
bound.  If the MDS goes away at
that point the task hangs in D state:

  INFO: task flock:12345 blocked for more than 122 seconds.
  Call Trace:
   wait_for_completion_killable
   ceph_lock_wait_for_completion
   ceph_flock

Bound the wait by mount_timeout and return -ETIMEDOUT; the original
request has already been marked CEPH_MDS_R_ABORTED at this point.
mount_timeout=0 keeps waiting forever.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/locks.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 677221bd64e01..b4faf112b3f84 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -158,9 +158,11 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
                                          struct ceph_mds_request *req)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	unsigned long timeout = ceph_timeout_jiffies(cl->options->mount_timeout);
 	struct ceph_mds_request *intr_req;
 	struct inode *inode = req->r_inode;
 	int err, lock_type;
+	long left;
 
 	BUG_ON(req->r_op != CEPH_MDS_OP_SETFILELOCK);
 	if (req->r_args.filelock_change.rule == CEPH_LOCK_FCNTL)
@@ -219,10 +221,15 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 	if (err && err != -ERESTARTSYS)
 		return err;
 
-	err = wait_for_completion_killable(&req->r_safe_completion);
-	if (err)
-		return err;
-
+	left = wait_for_completion_killable_timeout(&req->r_safe_completion,
+						    timeout);
+	if (left < 0) {
+		return left;
+	} else if (left == 0) {
+		doutc(cl, "request %llu safe completion timed out\n",
+		      req->r_tid);
+		return -ETIMEDOUT;
+	}
 	return 0;
 }
 
-- 
2.56.0

