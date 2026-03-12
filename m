Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C0401A29;
	Thu, 12 Mar 2026 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345960; cv=fail; b=rvxAGvbJdNus6yK0TXmLf/GF69+uMkJUZt4fUv0Gl5Vv/HH2vqNJnuPdKvE44CVvEc7cAyt5bU6a6UMtjydAuQB3axZ3H31ID66cDbyjTRuUH7gyfLv9Mux6xkz7wJikxfPKVndinVDtK99l6HBcrevdjV8YK5l1dZ/RKcksq88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345960; c=relaxed/simple;
	bh=M83IoE38+AVfUKATVrc1EMtpo9jZNBPa/NHmv8pd+KU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=A8uu+WMIlw81BOoIu/kdfc+GApyAqwS9czkyP/VSw5uXuAf8RChnmY613vrik+d7RNN7iJXGb/af+a2rb0iS+Loaz/VpfZOgYFHpiCYPxayqLRYebFvgRW09eUvcqkb2G5edAmgsibHrCqZMrrq3rQ85EFBXN30Oz+gqmUOoakQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rXvHlZAU; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rXvHlZAU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CDHjPZ2279034;
	Thu, 12 Mar 2026 20:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=M83IoE38+AVfUKATVrc1EMtpo9jZNBPa/NHmv8pd+KU=; b=rXvHlZAU
	lL+oeVkBZLwWzjun9DQ/bLCMz72rELNwT2xtWq/qVzTwYUHY/dFyNfAhFg54sN4j
	ZSu+HKIQZQbWQ8J8gj3SaXOsgpym940t3BjgEIKqcanScMng7g2KdQg6comCq6zb
	nG3B2aknSrp6NCFsJaGPEXRir2GFfarD7BcHM92itORuOnf9I/bIxk2vVjpWeTe6
	Gmz2Dz3wNhLxaovQWJe/9Giz4HzwDT3vUb7RKugy/oBQ8sDsVU+PZwBnVTzewDVm
	H5m47w0ry2aBEzJvMA8N1jDVP2mS2Tq031FD4ATt/07tk0IdxkS7NGQbo74Ok78b
	xc9YjnuuXwbfPQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91mnd6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 20:05:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1S6+RGytwPt0Oen0DQesqN0dtnnpNxfG7Q5KsTBpGMVtFCZzVTG2jeDHxmBDTVvyyFkB1ZaMUfGk36rc+bXGfUF30l2a+9OKUw1BiGMfP1FiQbPvmWzQ9651ft5OKIdFryZlLjnBQFFK92lxOGboeDvy3tNcVe1eLXtR5KUJAPv41SuQrNGOC+CfRZ8hqGKvi5Bb3Q2maCPD9GY1wteA+fkc2g35STwLGKawv9G9CqHUqcxNo+mcyyLj8r6HJOnt25kJ7K48qNtDs/QBTu/eOXaRjkHdgUzWMxjWdSETd/zp8DoG3hoQt0981dxQ8QmPBkFFhDbKuVZiOByQPpksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M83IoE38+AVfUKATVrc1EMtpo9jZNBPa/NHmv8pd+KU=;
 b=PQfKElQ1asEG6yTqPPwnEnBapZrYTASgZxlJ7bFrSRCGPnBv/MhdFuXraNmbqT+283hL6ZKnlut237AKK/b/+yuPwCBcBSX1yHjmrM7E1kpSDzCBQeV9vpfxCcu3/pehshjdVUHAFahSOsHIVNrDAn8DEC6DfNWm7UcvNJ9yNaejvI2io027Eg9EX3+r8KPgfoFZPHDw9adgyPHSltYadhnlb0zkaesYNMSa+psNviV9IkXIlzld8DQiKcOyeJeGvxJzS1G18/dkigyt5Jd5GA9RNSP7gl4r89dfLlgYokQK+K6h9gWaNmjXJEZmtuQ9+ymp+6FUbzBQN0GDnvIRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BLAPR15MB3746.namprd15.prod.outlook.com (2603:10b6:208:27e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 20:05:48 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 20:05:48 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "ionut.nechita@windriver.com" <ionut.nechita@windriver.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
Thread-Topic: [EXTERNAL] [PATCH v1 09/13] ceph: make remaining I/O lock
 functions killable
Thread-Index: AQHcsfkuMRJdfRfYBESjtr0idiiKU7WrU0iA
Date: Thu, 12 Mar 2026 20:05:48 +0000
Message-ID: <7e83c399a7b30a861cb229597f8ce4298932e0b3.camel@ibm.com>
References: <20260312081619.40854-1-ionut.nechita@windriver.com>
	 <20260312081619.40854-10-ionut.nechita@windriver.com>
In-Reply-To: <20260312081619.40854-10-ionut.nechita@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BLAPR15MB3746:EE_
x-ms-office365-filtering-correlation-id: 066a7921-9375-4f72-7cf6-08de8072c10a
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 Ls2/dbpyA6+irnTPIE6JjBk62l7lUNt15Gux82r9et3uH+SPjV7V7iyEhOni+D8Lx5d3R0J0m4mjhT6urAdxzFZgNt2tIC/GZHrOHvnNuP0dMaZJ4P8HX/cweGFT2p5CYaiT5v8pVUeQBcJOzl0X4mgf7sBC4UDGa6VnLA+aNGTv3txaE6UhWXWgOGU/hQJSNUKJfyDis6PSyxqNgixUOoy8Plf0nuy4OEeTkOEDXe1E/3k8zuj2iGcjIskZzVYu/1lnFV8Zc6vf3uT3K4kOPYVusKFRzufAGQIRF6FridnqPkDJaSSeVsxzn29n9VeGAIHWCwWJhEAcC80i2ZvCUjAOdy2nI5pbZPRLieXl+Cf3cKa8MOQBoR8cSi2hsYwCzqieKjZmVTtGAYbmpSjAJ7AwedDBFS9AelE62gf+0RbgaUROAoBDt0wCvCZrUEZUV9ukljJG+mxwQdkx+CvfG+umPdYXWVYg+mT90iwBQbuwkd1fxR+6DqanCQBrJAO2rU3+dMaoUVEv29r8yl9Fuw/J9+LD57szPniLtX1QSzYExpSXQ3ZQvd9be/aCBO0oYhkG1yGw4ustK/b6A15uQ0LIdb0OAXnKZu+Gx+KUz+7D0Ipj79zpr4Q38uwtTG9Vs/VT2W7BcQz8PILwd8WbXH26Y6ZkAEA4F8x2FnrNGl9Dl00JdNwehn+CilKLfRoE3KKJLlCwVDZBys+Cj3dMS46VRwzj7LZ0e8atNUcPUjTOdgCtv6x+eZYXcbmjr56h
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkFEM2dyM05VWUpRcXk5Z1p0SE9mOUpteTRGekpHcllocGh6SjgvOWJMZEY5?=
 =?utf-8?B?SGpMT2s0UVpCRmhSMzFvL0VZU0NkeHFUZktZYVR1ZHFLWXYwWlY5U21YV2Qv?=
 =?utf-8?B?anc3ZHZPaUVaMFcyY2laQXdaNWJoN3JUc1YyeTlqSlpGeVBaK2lCYmJnUjhx?=
 =?utf-8?B?Q0tvblVuVFVucGp6RmFieTZJK0p3N3FUZFpoZ0E4MWluWEVBam1kUHMyOFRq?=
 =?utf-8?B?Z0N6QWdzNWl5VGxMdXloaHV0a3lheTlZMVZQSlVVeFFQa2RPZU9KTDV1bDBM?=
 =?utf-8?B?SU8yamszM3V4MVYzbTNqSHdrUCtPdnRKbStGYWw0alB3RW9vR1l5T0FuS2pT?=
 =?utf-8?B?cUFrZ1YzVkNVVmkzMnpZbmhVc3ArY3JxWU9kbzlCZkdmc0FVTjNVOTNOSGZT?=
 =?utf-8?B?clQ5dk9FclR4b0tEbFdDUWRFYmI4dG5OVHRHQ2JJRW9ScUtHd0tJQjRHSFk1?=
 =?utf-8?B?NlhaM0RMSFRxdTI0M0V0d2F1Qml0SUExT0xYdWJ4TzFUVllNVUx6TGhGb1J1?=
 =?utf-8?B?Q3F3WlFNLzYybjZCQTNFZ3JEWUw0cjhTYSs2K0lIekFyeWJTS05iR0NaelVW?=
 =?utf-8?B?dlA3RHFPZHk5RzF1VWhKeStWZ00xQWdQUXMyNGZ4OFhYV095SHVRWG1CYVUw?=
 =?utf-8?B?eHhjNThlN2NucHF6Y0hEeEJmTWJZNitXTHg4NHhOaUM4T2VjRXp1UnEyREE4?=
 =?utf-8?B?S1hDZzRlV3ZUOXhpVmpBVEZTejQwcFh4OHpleFBDdXgxajlRSWJHTTNkblRX?=
 =?utf-8?B?N1dETmhhT1VuYi8vaytJNUVNdFQ4UERQTm5rMmVVWnBFT3Q4S1VFL1podWdN?=
 =?utf-8?B?akt5QXZkem5xVUx6eTc5L3cxRVp5Y2xZc2NnbTlJbHBPZEFURUg5WXd4NlhU?=
 =?utf-8?B?NzUwc3VVVzRMc0RyUytXdXVBWVJmQ3pGcVF3ZnorZWZONXJIYVZrb1VXWlJy?=
 =?utf-8?B?QytUWElVWUNvWUpLOVNuOW1jUUFuL2M2NEZEekYxRGlnaVNTWkEwMzVUZ2Y2?=
 =?utf-8?B?Sll1dDJtSHR3dTlJYVNVUnh6NHBVMDZNOCtzK0Vwa0lYUUlOL0VTUkk2dCt3?=
 =?utf-8?B?SThySklmNkNOV3hnUDY0NzA0MytzNUdiZ1hUYitVNmgzUnhpUGQ2V0hIMTAv?=
 =?utf-8?B?YWloRVhWR0RnVWo4ZWYzWWVJRTFzQTVLVm5sSjN3L3l2aVloOG50WjVHcmNN?=
 =?utf-8?B?VVR6bE1lVWdFSjFTYmsxWGJvTXM3Ukl0SGhveWN0eW9wMTg3Q2xDQXVvYzM0?=
 =?utf-8?B?UE02clkzYzUydXgyemcyS01HOVl2aWx4SXpaT0hJUlNPMG5abnk3dFRpaHFG?=
 =?utf-8?B?S215b0YyRGJyUTFJbU9BdlhTSjBuZXdyc3I1a2pMc0pmdzVVS2tpcmU4ZVEy?=
 =?utf-8?B?Z25vMm9qelk5RHp6bHlGSkhtZ1FwL3lXM01NZ2JudlNyR2t1TXFqOVZIelJv?=
 =?utf-8?B?VDcxdVdHUXc1aW1XVDR4dW5UZzZNOEYrS2dRbklYaTVqTUhCcTZqQU10S3cv?=
 =?utf-8?B?TjFnQnNXUlF0QlIxUWFNcDFiTGtWQjlCSkJKNm9RcGFqNWcvZXFWTFdMeFFD?=
 =?utf-8?B?NUpEWVNJRjBEMHcydnAwYmxWMGxmdjNVZWx2ZDdmODUrZ1JPZWdQTXJKcUFw?=
 =?utf-8?B?WkxzYTNhSkxMalJUUTlMdHJKSEREdnFVMzJGbjNwSFphOXRlT1hFbHlPUk9k?=
 =?utf-8?B?UXZNUFNCQkxlR3ZHSkJFWmhlb1dKVjQ1VnNXak8vQmo0WVRWMTFvcnRrb0hz?=
 =?utf-8?B?U2tSMnN3SUo2eTY4OXc4SHRhSE1PdnFYZWNNbGRlSkJyemhRK0FOL091czc5?=
 =?utf-8?B?UmR0RW93bVpQNFZuVHVJR0IzWWJLd3VzOWRRNVdIVXM4RFNwY0xoajdHV2dJ?=
 =?utf-8?B?Zkplbm1iNGtXN2VJNkI0WGJWRzMzdG5DYUNNY1p3MHNiS0pwdGh6Z1hCVUVs?=
 =?utf-8?B?NDJ2Rm1BcUo2dGlQYTJ3K2hIVGM2c2pXa1Q4dk9xZWV5MnNRME1vRVJDeEZG?=
 =?utf-8?B?L2V5YjN0RmV3eUFLZk5xazBlN3Y2TVFaWjR4ak5zSUZENVNmdk9BdHMzQVd0?=
 =?utf-8?B?Zk96VlR6WVE5U1JTV0RTbG94a2F0WmdVbW1MVGQvd1ZHVkZ5bG1VR3g1RGVC?=
 =?utf-8?B?ZnFBZ0REWGJEa3NPZ2cwdWZqdFJDdE9Jd1YvWDZEVWM2YXlDYnlPL29FZVI2?=
 =?utf-8?B?NW9YRnQzcFNZeHlmdTYwbVQ5bTIrOGRvSWxPb3Y4SitSSW1icFVjWWxpa0Nw?=
 =?utf-8?B?dlpGd3ZkdHNtVFpKUW1VNU91SjkvUjBoK21QRld3WHdJT0JWQW9oalhkbFl4?=
 =?utf-8?B?SkIzbFMwVTNPS2QvclhSaU1IcXVFMmUvT1EyNXRzY2g0b1NxczNXNm5ScXlR?=
 =?utf-8?Q?0btV+XbZR+rNtkepiKxew2Jaaz9aPB4OA0eqU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CD078799C520844968536FE4755341D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	k0dZweLMD5V5k2SJcvWcVSlS634+U6yxP/qBkyCAvK1Z0tfmgIjUhmJfq4bbCFVwlO5o8BIP6ye7KYo+dxa1HvK1MoWKm52q4p80hucd4QwwG+lFPwNsymJpxEPBNVU5vQsHV77lHr175G2sDCUDerDFPo8p49lRT+FtyunCIjioQFQbVUaB0aSvDUWWo5Ial0sLzO5cOcnMlS3sTVr0H7+bWQOyCEamcaWVBKPdIEUQYzNniUqUshyvEf4abtcWhkiil613pchWCZK7yhkIPdHVpK+YzcnRFkgHoGaEH9ed+Kng2QbWUaIxunhsYrwU3gFoLDdvrSISY/pKI56VJw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066a7921-9375-4f72-7cf6-08de8072c10a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 20:05:48.5463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gy7MaS2njNf+6dFuNWZzfjsT84zz9v9v7sgv9Z3uq+Cw5N+zqeRK8sulEjKDsN20wNmBkRJV3BzTmNk+asKA3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3746
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 0yhSPAzOfLZh9KWOMgCyESHFVsq76ih9
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b31ca5 cx=c_pps
 a=CnS1ju6qDdjTg6bRefQovg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=P-IC7800AAAA:8 a=t7CeM3EgAAAA:8
 a=9TeWN7KsdMaUCuVybZwA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE2MiBTYWx0ZWRfX5cJGLZYHeuf3
 9C6jxs11ys0322ZB6LbHuDBGGmziTQrbbXzMKgtswl5XrQa6lOnFpq4+Tv3HhlrXgYJd45i9ZES
 +5iTCXdTbZkgn84tw1aEciJjiFY0Y2Nt9MY7+SRzrQETog/hlwpzSRDOUQPyrlBwSSTGO7KScM1
 t/Viixk+N7/Sh6DDXcbcDf+VPSCs9AGJ+/EFeIwbWBhs/em224aMEVr00E0Aau0NnaB4zXKbnB5
 Gc0FNQyokC1xRBWAPe6gMeRphl9KiQKy0Yxnlhz/27UDoQR8TW6Nh7C/PCMwCTMR1OtWKGwT7bt
 VSeuW1otTR/iMCsiejfzSvM/x0aS0RGp8n6Ffe/k00MlxBn62u6CLEM8E3QvAEZIrQMAJpr5QXB
 QYz/PQdamM/tdB7/MZLYfJn/StvIp/Xz3NZFYFwV34I2gyeWSSeCY1cEj2dKhx69SShf26IMFEL
 U53rtsGsJWsA3nkCjpQ==
X-Proofpoint-ORIG-GUID: 5jl68qJ4XLVsCs0FMRcDI013OfeK-X5v
Subject: Re:  [PATCH v1 09/13] ceph: make remaining I/O lock functions
 killable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120162

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDEwOjE2ICswMjAwLCBJb251dCBOZWNoaXRhIChXaW5kIFJp
dmVyKSB3cm90ZToNCj4gRnJvbTogSW9udXQgTmVjaGl0YSA8aW9udXQubmVjaGl0YUB3aW5kcml2
ZXIuY29tPg0KPiANCj4gRm9sbG93aW5nIHRoZSBzYW1lIHBhdHRlcm4gYXMgY2VwaF9zdGFydF9p
b193cml0ZSgpLCBtYWtlDQo+IGNlcGhfc3RhcnRfaW9fcmVhZCgpIGFuZCBjZXBoX3N0YXJ0X2lv
X2RpcmVjdCgpIGtpbGxhYmxlIHRvDQo+IHByZXZlbnQgaW5kZWZpbml0ZSBoYW5ncyB3aGVuIHdh
aXRpbmcgZm9yIGlfcndzZW0gZHVyaW5nDQo+IE1EUy9PU0QgdW5hdmFpbGFiaWxpdHkuDQo+IA0K
PiBUaGlzIGNvbXBsZXRlcyB0aGUga2lsbGFibGUgbG9jayBjb252ZXJzaW9uIGZvciBhbGwgY2Vw
aCBJL08NCj4gc3RhcnQgZnVuY3Rpb25zLCBhbGxvd2luZyBibG9ja2VkIHByb2Nlc3NlcyB0byBi
ZSB0ZXJtaW5hdGVkDQo+IHdpdGggU0lHS0lMTCBpbnN0ZWFkIG9mIGhhbmdpbmcgaW5kZWZpbml0
ZWx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSW9udXQgTmVjaGl0YSA8aW9udXQubmVjaGl0YUB3
aW5kcml2ZXIuY29tPg0KPiAtLS0NCj4gIGZzL2NlcGgvZmlsZS5jIHwgMjcgKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tDQo+ICBmcy9jZXBoL2lvLmMgICB8IDI4ICsrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0NCj4gIGZzL2NlcGgvaW8uaCAgIHwgIDQgKystLQ0KPiAgMyBmaWxlcyBjaGFu
Z2VkLCA0MSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9mcy9jZXBoL2ZpbGUuYyBiL2ZzL2NlcGgvZmlsZS5jDQo+IGluZGV4IDAxZTRmMzFiMWYyZjMu
LmM4Mjg1NTJkNTE5MjAgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvZmlsZS5jDQo+ICsrKyBiL2Zz
L2NlcGgvZmlsZS5jDQo+IEBAIC0yMTIyLDEwICsyMTIyLDE1IEBAIHN0YXRpYyBzc2l6ZV90IGNl
cGhfcmVhZF9pdGVyKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICp0bykNCj4g
IAlpZiAoY2VwaF9pbm9kZV9pc19zaHV0ZG93bihpbm9kZSkpDQo+ICAJCXJldHVybiAtRVNUQUxF
Ow0KPiAgDQo+IC0JaWYgKGRpcmVjdF9sb2NrKQ0KPiAtCQljZXBoX3N0YXJ0X2lvX2RpcmVjdChp
bm9kZSk7DQo+IC0JZWxzZQ0KPiAtCQljZXBoX3N0YXJ0X2lvX3JlYWQoaW5vZGUpOw0KPiArCWlm
IChkaXJlY3RfbG9jaykgew0KPiArCQlyZXQgPSBjZXBoX3N0YXJ0X2lvX2RpcmVjdChpbm9kZSk7
DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArCX0gZWxzZSB7DQo+ICsJCXJl
dCA9IGNlcGhfc3RhcnRfaW9fcmVhZChpbm9kZSk7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1
cm4gcmV0Ow0KPiArCX0NCj4gIA0KPiAgCWlmICghKGZpLT5mbGFncyAmIENFUEhfRl9TWU5DKSAm
JiAhZGlyZWN0X2xvY2spDQo+ICAJCXdhbnQgfD0gQ0VQSF9DQVBfRklMRV9DQUNIRTsNCj4gQEAg
LTIyNzgsNyArMjI4Myw5IEBAIHN0YXRpYyBzc2l6ZV90IGNlcGhfc3BsaWNlX3JlYWQoc3RydWN0
IGZpbGUgKmluLCBsb2ZmX3QgKnBwb3MsDQo+ICAJICAgIChmaS0+ZmxhZ3MgJiBDRVBIX0ZfU1lO
QykpDQo+ICAJCXJldHVybiBjb3B5X3NwbGljZV9yZWFkKGluLCBwcG9zLCBwaXBlLCBsZW4sIGZs
YWdzKTsNCj4gIA0KPiAtCWNlcGhfc3RhcnRfaW9fcmVhZChpbm9kZSk7DQo+ICsJcmV0ID0gY2Vw
aF9zdGFydF9pb19yZWFkKGlub2RlKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0K
PiAgDQo+ICAJd2FudCA9IENFUEhfQ0FQX0ZJTEVfQ0FDSEU7DQo+ICAJaWYgKGZpLT5mbW9kZSAm
IENFUEhfRklMRV9NT0RFX0xBWlkpDQo+IEBAIC0yMzU3LDkgKzIzNjQsMTMgQEAgc3RhdGljIHNz
aXplX3QgY2VwaF93cml0ZV9pdGVyKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVy
ICpmcm9tKQ0KPiAgCQlkaXJlY3RfbG9jayA9IHRydWU7DQo+ICANCj4gIHJldHJ5X3NuYXA6DQo+
IC0JaWYgKGRpcmVjdF9sb2NrKQ0KPiAtCQljZXBoX3N0YXJ0X2lvX2RpcmVjdChpbm9kZSk7DQo+
IC0JZWxzZSB7DQo+ICsJaWYgKGRpcmVjdF9sb2NrKSB7DQo+ICsJCWVyciA9IGNlcGhfc3RhcnRf
aW9fZGlyZWN0KGlub2RlKTsNCj4gKwkJaWYgKGVycikgew0KPiArCQkJY2VwaF9mcmVlX2NhcF9m
bHVzaChwcmVhbGxvY19jZik7DQo+ICsJCQlyZXR1cm4gZXJyOw0KPiArCQl9DQo+ICsJfSBlbHNl
IHsNCj4gIAkJZXJyID0gY2VwaF9zdGFydF9pb193cml0ZShpbm9kZSk7DQo+ICAJCWlmIChlcnIp
IHsNCj4gIAkJCWNlcGhfZnJlZV9jYXBfZmx1c2gocHJlYWxsb2NfY2YpOw0KPiBkaWZmIC0tZ2l0
IGEvZnMvY2VwaC9pby5jIGIvZnMvY2VwaC9pby5jDQo+IGluZGV4IGY5YWM4OWVjMWQ2YTEuLjdi
ZDU3ZGUyZDk2ODEgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvaW8uYw0KPiArKysgYi9mcy9jZXBo
L2lvLmMNCj4gQEAgLTQ3LDIwICs0NywyNiBAQCBzdGF0aWMgdm9pZCBjZXBoX2Jsb2NrX29fZGly
ZWN0KHN0cnVjdCBjZXBoX2lub2RlX2luZm8gKmNpLCBzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KPiAg
ICogTm90ZSB0aGF0IGJ1ZmZlcmVkIHdyaXRlcyBhbmQgdHJ1bmNhdGVzIGJvdGggdGFrZSBhIHdy
aXRlIGxvY2sgb24NCj4gICAqIGlub2RlLT5pX3J3c2VtLCBtZWFuaW5nIHRoYXQgdGhvc2UgYXJl
IHNlcmlhbGlzZWQgdy5yLnQuIHRoZSByZWFkcy4NCj4gICAqLw0KPiAtdm9pZA0KPiAraW50DQo+
ICBjZXBoX3N0YXJ0X2lvX3JlYWQoc3RydWN0IGlub2RlICppbm9kZSkNCg0KV2hpY2gga2VybmVs
IHZlcnNpb24gZG8geW91IGhhdmU/IEkgY2FuIHNlZSBkb3duX3JlYWRfa2lsbGFibGUoKSBhbHJl
YWR5DQphdmFpbGFibGUgaW4gY2VwaF9zdGFydF9pb19yZWFkKCkgZm9yIHYuNy4wLjAtcmMzIFsx
XS4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNClsxXSBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC92Ny4wLXJjMy9zb3VyY2UvZnMvY2VwaC9pby5jI0w1OQ0KDQo+ICB7DQo+ICAJc3RydWN0
IGNlcGhfaW5vZGVfaW5mbyAqY2kgPSBjZXBoX2lub2RlKGlub2RlKTsNCj4gKwlpbnQgcmV0Ow0K
PiAgDQo+ICAJLyogQmUgYW4gb3B0aW1pc3QhICovDQo+IC0JZG93bl9yZWFkKCZpbm9kZS0+aV9y
d3NlbSk7DQo+ICsJcmV0ID0gZG93bl9yZWFkX2tpbGxhYmxlKCZpbm9kZS0+aV9yd3NlbSk7DQo+
ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gIAlpZiAoIShSRUFEX09OQ0UoY2ktPmlf
Y2VwaF9mbGFncykgJiBDRVBIX0lfT0RJUkVDVCkpDQo+IC0JCXJldHVybjsNCj4gKwkJcmV0dXJu
IDA7DQo+ICAJdXBfcmVhZCgmaW5vZGUtPmlfcndzZW0pOw0KPiAgCS8qIFNsb3cgcGF0aC4uLi4g
Ki8NCj4gLQlkb3duX3dyaXRlKCZpbm9kZS0+aV9yd3NlbSk7DQo+ICsJcmV0ID0gZG93bl93cml0
ZV9raWxsYWJsZSgmaW5vZGUtPmlfcndzZW0pOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiBy
ZXQ7DQo+ICAJY2VwaF9ibG9ja19vX2RpcmVjdChjaSwgaW5vZGUpOw0KPiAgCWRvd25ncmFkZV93
cml0ZSgmaW5vZGUtPmlfcndzZW0pOw0KPiArCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICAvKioN
Cj4gQEAgLTEzOCwyMCArMTQ0LDI2IEBAIHN0YXRpYyB2b2lkIGNlcGhfYmxvY2tfYnVmZmVyZWQo
c3RydWN0IGNlcGhfaW5vZGVfaW5mbyAqY2ksIHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+ICAgKiBO
b3RlIHRoYXQgYnVmZmVyZWQgd3JpdGVzIGFuZCB0cnVuY2F0ZXMgYm90aCB0YWtlIGEgd3JpdGUg
bG9jayBvbg0KPiAgICogaW5vZGUtPmlfcndzZW0sIG1lYW5pbmcgdGhhdCB0aG9zZSBhcmUgc2Vy
aWFsaXNlZCB3LnIudC4gT19ESVJFQ1QuDQo+ICAgKi8NCj4gLXZvaWQNCj4gK2ludA0KPiAgY2Vw
aF9zdGFydF9pb19kaXJlY3Qoc3RydWN0IGlub2RlICppbm9kZSkNCj4gIHsNCj4gIAlzdHJ1Y3Qg
Y2VwaF9pbm9kZV9pbmZvICpjaSA9IGNlcGhfaW5vZGUoaW5vZGUpOw0KPiArCWludCByZXQ7DQo+
ICANCj4gIAkvKiBCZSBhbiBvcHRpbWlzdCEgKi8NCj4gLQlkb3duX3JlYWQoJmlub2RlLT5pX3J3
c2VtKTsNCj4gKwlyZXQgPSBkb3duX3JlYWRfa2lsbGFibGUoJmlub2RlLT5pX3J3c2VtKTsNCj4g
KwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiAgCWlmIChSRUFEX09OQ0UoY2ktPmlfY2Vw
aF9mbGFncykgJiBDRVBIX0lfT0RJUkVDVCkNCj4gLQkJcmV0dXJuOw0KPiArCQlyZXR1cm4gMDsN
Cj4gIAl1cF9yZWFkKCZpbm9kZS0+aV9yd3NlbSk7DQo+ICAJLyogU2xvdyBwYXRoLi4uLiAqLw0K
PiAtCWRvd25fd3JpdGUoJmlub2RlLT5pX3J3c2VtKTsNCj4gKwlyZXQgPSBkb3duX3dyaXRlX2tp
bGxhYmxlKCZpbm9kZS0+aV9yd3NlbSk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsN
Cj4gIAljZXBoX2Jsb2NrX2J1ZmZlcmVkKGNpLCBpbm9kZSk7DQo+ICAJZG93bmdyYWRlX3dyaXRl
KCZpbm9kZS0+aV9yd3NlbSk7DQo+ICsJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gIC8qKg0KPiBk
aWZmIC0tZ2l0IGEvZnMvY2VwaC9pby5oIGIvZnMvY2VwaC9pby5oDQo+IGluZGV4IDk0Y2UxNzZk
Zjk5OTcuLjk0MzJiOGI2MDc2NTAgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvaW8uaA0KPiArKysg
Yi9mcy9jZXBoL2lvLmgNCj4gQEAgLTIsMTEgKzIsMTEgQEANCj4gICNpZm5kZWYgX0ZTX0NFUEhf
SU9fSA0KPiAgI2RlZmluZSBfRlNfQ0VQSF9JT19IDQo+ICANCj4gLXZvaWQgY2VwaF9zdGFydF9p
b19yZWFkKHN0cnVjdCBpbm9kZSAqaW5vZGUpOw0KPiAraW50IGNlcGhfc3RhcnRfaW9fcmVhZChz
dHJ1Y3QgaW5vZGUgKmlub2RlKTsNCj4gIHZvaWQgY2VwaF9lbmRfaW9fcmVhZChzdHJ1Y3QgaW5v
ZGUgKmlub2RlKTsNCj4gIGludCBjZXBoX3N0YXJ0X2lvX3dyaXRlKHN0cnVjdCBpbm9kZSAqaW5v
ZGUpOw0KPiAgdm9pZCBjZXBoX2VuZF9pb193cml0ZShzdHJ1Y3QgaW5vZGUgKmlub2RlKTsNCj4g
LXZvaWQgY2VwaF9zdGFydF9pb19kaXJlY3Qoc3RydWN0IGlub2RlICppbm9kZSk7DQo+ICtpbnQg
Y2VwaF9zdGFydF9pb19kaXJlY3Qoc3RydWN0IGlub2RlICppbm9kZSk7DQo+ICB2b2lkIGNlcGhf
ZW5kX2lvX2RpcmVjdChzdHJ1Y3QgaW5vZGUgKmlub2RlKTsNCj4gIA0KPiAgI2VuZGlmIC8qIEZT
X0NFUEhfSU9fSCAqLw0K
