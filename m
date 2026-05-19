Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4B3438B9
	for <ceph-devel@vger.kernel.org>; Tue, 19 May 2026 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217118; cv=fail; b=ZSFMJkgB2hVJyP5iDNF3vLd/05TS3o8FbSUgXFx4iho2Py84v+dMps7v9LPBKqrMQV7m4vLtpGIrpqOZwRWuObJSh8huDOEDrtZGlMMwgcCa4jG3mEsyZHE92hOQKTUXRE1DjyXImaA1KUA8ZtWeI69xwEASoNUaxdR0v+hVd+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217118; c=relaxed/simple;
	bh=KjG95MPyP2DZeEvgsJXVspdzdkZXUy6ZAbiYUjRNijo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=CuBFf77fEvs0psOgnh/0h9h+OyL6g7u/XNFLDGa8rf4fjoOQdNcE+EF3bzmwmW7zVy+Tj3hRRr7Xyss/aECLWlOtAD7FUfraAOcug/XiNT+1qPUBBHoVbGyVPXsj4rcHj83GhKkmtZpIZWtlm75co4jXXQ6//EKeO3QH7wH4EPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MwNnNqGj; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MwNnNqGj"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JFp1sI1740149;
	Tue, 19 May 2026 18:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=KjG95MPyP2DZeEvgsJXVspdzdkZXUy6ZAbiYUjRNijo=; b=MwNnNqGj
	2WeBnOSsYjfwoPCrXNzbIVut8GsmytR9ZNvQd5YEtvGl0KVzCIKKLmfqIdffddkI
	AMCMvE38k517BS89BfUUTaL5W32au/B3g2OTtZ0ijxNNmEwMfJuGLwbCDy3t/OBM
	pUXrGXYonq30sWVo80yE8Kx2NGFw0SFqJ9r3tBYbe+KCLgQmkB/ITk7iVV+P6x1h
	MtEBvE053SDXxVqLMOf/JA7Dw9lME91VpDp/rbxGfArLGJHDFWzon7H69oXYkSuZ
	DSAp1e32Z02aD2YXjdqp/jG8KhmzGoB9kQEigIxC/Xb5Nlq/RdRcjfcuH3YEz1DZ
	MxCKAwT1dS8kgQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012041.outbound.protection.outlook.com [40.107.200.41])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h74xnx5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 18:58:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gc/aUEiQOM0JZdhON6OVfkGe6+gvllnphhvB3wUs3P7AohKS8ohuA7usU4LBt4H+7r6yBagKiUhuXC+fLriOZzA/fQgUsUYSOCibvZCF3uk85FMyTnEYz7yQmSlFKvvQ6dv1sw2foKU1NerC6frcL04n4qsXKgMSiNAzBJG8EgyR66DVZsCCJyM770dlOeFO/SX0llgqmwMc6x6yH2MxRa81e/dauVQyxuJpL6GOOHTHNrBKqK4uYt7iPO68Z2OHtSPUxaTgwhzXJMPuCOckJuYbMzg8XqknVX1fS29MztfcvpBEgT8ca4u8ngvIz2jWnmTVhQYrRfkYxyyH2C9Nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjG95MPyP2DZeEvgsJXVspdzdkZXUy6ZAbiYUjRNijo=;
 b=oLshAx5lWjPUbS7j3A0N+K18DfWhjn5H1HIoHkVxEasFAF+K58mFjuTjUSjQeaz2PYXusmv8HWXnqxhAhbBhW0CuLnnn6RYNOCM1yPqcjk9p3bUefpQzBa34cBUkeyDPwD5RACbDnmkBP4V6srdGBLPz+KvAFU+kJmyg4ZPOzhtIJMuLkwuUG8reLwsVNoVqZGC9+3cdFTmhSVJr4omGuTRUlB1PZGlUWoDV1eMHLPSm3N2qlY8ScvGF39KaYtVBNGDlZ/6xqcxBHwVWcXfgGXvo0Rp07NqWkUaOj6a08dAbt17QYIHfuG45BXwnm1P0+7MZIjud3n32b5IuJxmdIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH8PR15MB6156.namprd15.prod.outlook.com (2603:10b6:510:257::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 18:58:19 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 18:58:19 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] libceph: Fix out-of-bounds writes with
 oversized monitor reply messages
Thread-Index: AQHc54I27ah8Lzf53kSNw4mZuFgFZ7YVs+KA
Date: Tue, 19 May 2026 18:58:18 +0000
Message-ID: <1c2c36664428fb4066b096041f1cebdb984d0664.camel@ibm.com>
References: <20260519111407.2191040-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260519111407.2191040-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH8PR15MB6156:EE_
x-ms-office365-filtering-correlation-id: 013c90f8-d5e4-4029-4cb5-08deb5d89762
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|11063799006|38070700021|5023799004|22082099003|56012099003|18002099003|3023799007;
x-microsoft-antispam-message-info:
 OjfK3Fi1wo/ULjUu+CXfV4lTDt7dCN4hrP2ieXDFpaxj866Lkxg+Kpm4Gld128cw5T5JXKN9fYtVdXooCiVSbc56GO9nnCg7SUFHfsPDmbyGYTBl7bkWN1JIGdswv9dQD10b3ovrmK1DDpdFr6Pd9LFMDZhmrZ6sEUZ8R5bcGdT07qorzIWe/esDIbYiaLJ35RLATOKPRzw+TimZwAkBZOR3J9u1/m0mTnuJX4O0WuvlEPUF6t3SbcNevgJLxsePqmQEAD7Y5YzRtWGN4y6gnE+b4K0t8iz3pEqyJxU4dcrPN1OBpiMrbtPtzgXl8USMprqq1DhO2Z/AJAH8UbgoQ/05JYxZRyosJkp4DBM2/d9tUvyyd3IVW0N1+y1WS5cuEROaauxm6ZSvez5nbidxknVXzYUw/gNq8ZVGI6/I+RK51xmeJWm/VQ2WnAia5xRd2LSc/QB5HygpM1aKd/KrWo+83lHG0ZYyZQ8+tZYy7KuM76vPCNnR4FeAzFh2SXsiqQdQXR2Z7VqL6/WxwsLm8cH+oibUKtvXJc6r1ATH4RDMtxAcwkOC7NcBGFTKLqgqqBx9mwOWuUKfgaAlFy8acNULgWYMfatBM29BRKK9FL2+tSGRpkS3SDOwTvFeInOxX6I9BEf1ivhXr7M1OMjY+3dCxgAnd5CpcedHI28s4fN/kHMZvsGF6E+I6wxhTPX5z1xzPO0pwaM+3RJRz29OSA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(11063799006)(38070700021)(5023799004)(22082099003)(56012099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1RkYUpkSmxKNjVVQmd0SjFkR05xNnNKNVpxNFg2b29xbUh0ZzVaZFMyMkg0?=
 =?utf-8?B?ZWpIZ1dqaXBRZGR6Y0hKQmJBbmlDVy93b2ZjQVBJNGpMZ1dxUS8wUFNnNC9K?=
 =?utf-8?B?QXI0Q2hVUkZnSTJrbVZHd01DdTZjSHFSL2EwRUxYZEhrdGNaYmFQT3QzVjBw?=
 =?utf-8?B?WTQ3a2lvWTlrRVd4Q1NOSGhTYU9BL0k0cm03Yjd0OGVadE5yNjZBVUlwMnAw?=
 =?utf-8?B?VVJuV0NQWnBDYVB4dDE1dUNsVC82TlhySnhBTXRBMHFnc1pOeGpFZllnVU9H?=
 =?utf-8?B?dkFZUWJxd0w2Z2NVSU0xRGRyWXA3VjVTNjFtMmszaEdzYVN5QTRKUFpXbmF3?=
 =?utf-8?B?a3dtWlF3LzR6djByVllXeWk0Q3kxdmUrSEttVnd2ZVhKRkxwZzNqVm1IUSt3?=
 =?utf-8?B?RmFweUNtVDA2REZqa1BzVnNYVUIzRmpsQ1VQVkdxMnUya0FPRDZpb1lQMGd5?=
 =?utf-8?B?eFlBT2U5UEx0WFJGSUJJZVd1bkdEd2pNMHFiTUpXSXgvT1FJYXJzdlMxdTJ4?=
 =?utf-8?B?bDVxcDU1MzlFRDNrUFpXYTJVa1c1YnpjNkZIUGk0OUhQbjEwOGdpSFhCcG16?=
 =?utf-8?B?aWIweXhpSGhRbzRTUFUvV0Z5ZTljdU1aOHg1Vjg3TW55dmpzVnNLOUtHTXBu?=
 =?utf-8?B?Q1ZUL0dhc3ZmQzZYcURDdXZoRHNlNUN2ak0xS1VmdEI2bVQ1dG9nNm41R3RX?=
 =?utf-8?B?R043K2lUVmd0ZWlTalhFVCs2dExNM1IySG1oZWxiZG40Ulh0eE9nNkRrSmt2?=
 =?utf-8?B?WUtLRkttUnhsRE9ybElCSmJXZXRoMGhhQnEzNzQydVJwNjZnSlFtem1RNG5Q?=
 =?utf-8?B?UHlVOGJLNXM5VkxuN0Z3azR1dW1pd1NwTjdSSFRlQjhEckh4SnhQK2dXeW1h?=
 =?utf-8?B?MWh1MFRXTk5hMGpUdDAvWHl6d1ZMZWZCYjdna1VWZUZRSzRTT0dBOENTQkh3?=
 =?utf-8?B?RFdSNWI5TDMrZzhBRUpPVkp2bkpRYndWS1lKTDlUM3YzUHFpelppZFcyQmZk?=
 =?utf-8?B?WStXQXBGMFJibUxVaGt0OVZZd2pNQW9VRHlYZmdpL1BrczlRS1BRTFVjL01o?=
 =?utf-8?B?bFpOSENNdkV5R0g0UlB4aWZaQ1lOV2R4ZU1ybE1LV0J1VVczeUsrNFRHc242?=
 =?utf-8?B?bEY3MzZBTDNiMDVrSWgrSGVjbXdxZ3NwK1lSdlA5azROZS94RFdITU9Hb2kv?=
 =?utf-8?B?a3daSDV1WjcxU2ZPL0VyWDlic210ZFRHV3NNSmltaXZMUUxaRFZzZ0FKZUVi?=
 =?utf-8?B?UnFRWks4c1BPajE3S0tuUHY4RnY0SXZ2TzVCdTFKT0N3VlhEWUxIbGt1S1hU?=
 =?utf-8?B?R1Y5WncyWmEvcm5UTUlwUjVOL1luRk5aS2RwTFVFTWxXNGxuZ3BLRHVYZHZB?=
 =?utf-8?B?My9ONkRxODJkNTdVTmlMZXNJL3JCcTBRN1BCR2U5Y2lXR3g0UW00WXVHVDRP?=
 =?utf-8?B?d0NzVUkzSEt4V3dGU0Z6RzEyTE1zWnJ0WFM4M1MyQU9jaTZJSm5pQUxXSEEz?=
 =?utf-8?B?djBCNjNCK1o5dDdvNjV1clVrSldlNCtNUVkyUGoxL3pNQVdzL1JvdnFDSm1E?=
 =?utf-8?B?ekc2bmhOd1M3YlBUWWZ3SC92MXh3UndtVmRkdFllVDhiaDJRWGVvTElWR25r?=
 =?utf-8?B?Zm1OanRvYi9YUnZOSUMycC82dFdOVmN6Q05QZTd4S1pLeUdKN08vek9HdzAv?=
 =?utf-8?B?QlNZNHdjR3M2TGNjSGVTMDRpbXYxWVM0RXYwUGh2ZHNHQms3ZDNxb2hBUk5k?=
 =?utf-8?B?dE80YWdwai9MeEpZMDZ2dHZPZkhCTlVJQUFkNnhYY1lpbVpxaVI0eUx0bU5P?=
 =?utf-8?B?VmJZbmtLcFdRRTBZSGFEd29HQlpEaS9rVWRYNXZ6Smt2Q05YbzkwdjgreGJC?=
 =?utf-8?B?dnkyOW9iaTQxS28xZ3BQSGVLRysvTWlodlR4ZjlDQXNES0RzVm4rRWJ5bEFK?=
 =?utf-8?B?UzdHRk5wOXFvOTlPOEU5WEdWaU5YblhodlNONXNjQ3kxSk5XMVJ5UXl4Qzdw?=
 =?utf-8?B?QVlWYmNJejV5VDhPbG9hcU9MQjhGN3Qwcy93Rkdua0Q3Z05jR0hUY0ZDYS9j?=
 =?utf-8?B?dnUrVTVON3NwTWRxcDRCMW42UkVONGRyOEc4SytrT2xqQk5xODdHN0UwTXBR?=
 =?utf-8?B?OUZldHN1eEtBWk9BZkhEcnM1dUtqbXFPTDhxYmw4bERzS2lmNHVZY01RVmgz?=
 =?utf-8?B?NS9aMHA2bDFld0lFaHB1S0RDdTZXQ2Z4bkd6ODFVM2sxSkZCR1VzZlFDRXZi?=
 =?utf-8?B?clNGRVFxV3hEZzE5MWdGQ3E0NVU3TUlWb0F4endZUjF2NnRHaDZqM2F1c1Z3?=
 =?utf-8?B?cnhNSXRuVy9MQVhCbGtHWWcrdG8vM0U5dXhNZURmV2hkc3FvZ2lQcGlWWmQr?=
 =?utf-8?Q?AvXGNTIV54uK7VcFHKJ3pP0nqXxLn6ffI7E8E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FE1B3FD90D26B4593113080921A8E29@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	F2VZpCCZS4WxOGZj0WBxlVq5lQd+/nNk8zn1WpARuGl0jUOLKMqKfUYAZt1JVaGWj1IsKu9EW7hqUyVf2C0J+lSmpqLxXoCUv1d4jMrRZZPqI+VnhgBRO8OAStgpVSNHcYB0J3w+2ajvZs4h8MIihD2zEw4/vyXgzx3xka5iKzFy0WYhc8G1LbGacusS7eWpFIZYrmGfvjmsegig+JccKDj9M9bWXGYZU0UtN9d8+nlEl0RsKPtcHljEKBMWonxtXmRmOgLVp+pi1Q63NWfrhGSIXmU13w9MgdrN6vn+/q6mr/WmD3YtgZ9pqACATzu2EiwbayKIj54rZkByKGQsFA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013c90f8-d5e4-4029-4cb5-08deb5d89762
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 18:58:18.9884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPjcxiM/FnTgWtgvErCJVGjs/w4mbKAZYEIw6TzvS4akw2K345vgKBV0aL6ZhmHqYSNhhTnzzdhLb1S82o478w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR15MB6156
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0cb2cf cx=c_pps
 a=kwEYnkRUmkAH8qI+i8sEWA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=P-IC7800AAAA:8 a=zmwYvG6xEWX6s_cJiV4A:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: MgzO2MlzDjyMQbak4J0ZkJ0MKZbJN6Ls
X-Proofpoint-GUID: IemYOPUK9--uHxGFcGwLvyynuPEMbRB0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE4NiBTYWx0ZWRfXz4XVNNmEOFzC
 8zWVrR718XnW0Y9QDMXxU/YkcFFCXod/lkA+uV9bVJC+t7igLNXET1zo5UBQX0m6Xo6BSoYycLs
 wYeowl9ja1ocfmT0y8odwgwl20p35c4gUPrPs4AJeGBau6ID7ixYBUTKCw/O8lvhX291M7rJai9
 4mCfwSzvK6YYxvW/74MV43TWqo1eobP+r0AC7KU4RIqqJmeW8EanWRwyY1rwrMyEMQWYYSrVLUR
 seinN0N81eT+ZRUcjxCcgJx2zX5tTnl+DEK/AQUGLlpMGdbrWXnfr6dsdBKECLjUz2A75NQW2IU
 PIKSrRwaZztW9h2V27aSRtAWuvbk1/zjqT6woLDNmCMIjgu3epzJeu7HkpvNIHjPELRkGK1kc8Q
 GrhQAF5sg1fm6SPSlZdaPCtx5pVoeEefF1ulIFE4ljrRR32Q4GyWPxQmDIjhN1saRzvwCo9Qm7R
 CVtcv89cXs0PvaRqgKA==
Subject: Re:  [PATCH v2] libceph: Fix out-of-bounds writes with oversized
 monitor reply messages
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190186

T24gVHVlLCAyMDI2LTA1LTE5IGF0IDEzOjE0ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gV2hlbiBwcm9jZXNzaW5nIGFuIGluY29taW5nIHJlcGx5IG1lc3NhZ2Ugb2YgdHlwZSBDRVBI
X01TR19TVEFURlNfUkVQTFksDQo+IENFUEhfTVNHX01PTl9DT01NQU5EX0FDSywgb3IgQ0VQSF9N
U0dfTU9OX0dFVF9WRVJTSU9OX1JFUExZIG9uIHRoZQ0KPiBtb25pdG9yIGNvbm5lY3Rpb24sIGFu
IGFscmVhZHkgYWxsb2NhdGVkIHJlcGx5IG1lc3NhZ2UgZm9yIHRoZSBnaXZlbg0KPiB0cmFuc2Fj
dGlvbiBJRCBpcyB1c2VkIChpZiBleGlzdGluZykuIFN1Y2ggYSBtZXNzYWdlIGhhcyBhIHByZWFs
bG9jYXRlZA0KPiBmcm9udCBzZWdtZW50IHdpdGggYSBmaXhlZCBsZW5ndGggb2YgNjQsIDUxMiwg
b3IgMzIgYnl0ZXMsIGRlcGVuZGluZyBvbg0KPiB0aGUgbWVzc2FnZSB0eXBlIGl0IHdhcyBhbGxv
Y2F0ZWQgZm9yLiBUaGUgYWN0dWFsIGxlbmd0aCB0byByZWNlaXZlIGludG8NCj4gdGhpcyBidWZm
ZXIgaXMgcmVhZCBmcm9tIHRoZSBtZXNzYWdlLiBJZiB0aGlzIHZhbHVlIGV4Y2VlZHMgdGhlDQo+
IGFsbG9jYXRpb24gc2l6ZSwgZGF0YSByZWNlaXZlZCBmcm9tIHRoZSBuZXR3b3JrIGlzIHdyaXR0
ZW4gYmV5b25kIHRoZQ0KPiBlbmQgb2YgdGhlIGFsbG9jYXRlZCBidWZmZXIuDQo+IA0KPiBUaGlz
IHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSBieSBhZGRpbmcgYSBjaGVjayB0aGF0IGNvbXBhcmVzIHRo
ZSBuZWVkZWQNCj4gZnJvbnQgc2VnbWVudCBsZW5ndGggdG8gdGhlIHByZXZpb3VzbHkgYWxsb2Nh
dGVkIGxlbmd0aCB3aGVuIHJldHJpZXZpbmcNCj4gdGhlIG1lc3NhZ2UgYnVmZmVyLiBJZiB0aGUg
bmVlZGVkIGxlbmd0aCBleGNlZWRzIHRoZSBhbGxvY2F0aW9uLCBhIG5ldw0KPiBtZXNzYWdlIGJ1
ZmZlciB3aXRoIHRoZSBuZWVkZWQgc2l6ZSBpcyBhbGxvY2F0ZWQgdG8gcmVwbGFjZSB0aGUgcHJl
dmlvdXMNCj4gb25lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFwaGFlbCBaaW1tZXIgPHJhcGhh
ZWwuemltbWVyQHR1LWlsbWVuYXUuZGU+DQo+IC0tLQ0KPiAgbmV0L2NlcGgvbW9uX2NsaWVudC5j
IHwgMTMgKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9tb25fY2xpZW50LmMgYi9uZXQvY2VwaC9tb25f
Y2xpZW50LmMNCj4gaW5kZXggNjZjMGQ2ZDZiMzNkLi4yNjdkZmFkZmJmOGUgMTAwNjQ0DQo+IC0t
LSBhL25ldC9jZXBoL21vbl9jbGllbnQuYw0KPiArKysgYi9uZXQvY2VwaC9tb25fY2xpZW50LmMN
Cj4gQEAgLTcxMiw2ICs3MTIsOCBAQCBzdGF0aWMgc3RydWN0IGNlcGhfbXNnICpnZXRfZ2VuZXJp
Y19yZXBseShzdHJ1Y3QgY2VwaF9jb25uZWN0aW9uICpjb24sDQo+ICAJc3RydWN0IGNlcGhfbW9u
X2NsaWVudCAqbW9uYyA9IGNvbi0+cHJpdmF0ZTsNCj4gIAlzdHJ1Y3QgY2VwaF9tb25fZ2VuZXJp
Y19yZXF1ZXN0ICpyZXE7DQo+ICAJdTY0IHRpZCA9IGxlNjRfdG9fY3B1KGhkci0+dGlkKTsNCj4g
KwlpbnQgdHlwZSA9IGxlMTZfdG9fY3B1KGhkci0+dHlwZSk7DQo+ICsJaW50IGZyb250X2xlbiA9
IGxlMzJfdG9fY3B1KGhkci0+ZnJvbnRfbGVuKTsNCj4gIAl1MzIgZGF0YV9sZW4gPSBsZTMyX3Rv
X2NwdShoZHItPmRhdGFfbGVuKTsNCj4gIAlzdHJ1Y3QgY2VwaF9tc2cgKm07DQo+ICANCj4gQEAg
LTcyMSw2ICs3MjMsMTcgQEAgc3RhdGljIHN0cnVjdCBjZXBoX21zZyAqZ2V0X2dlbmVyaWNfcmVw
bHkoc3RydWN0IGNlcGhfY29ubmVjdGlvbiAqY29uLA0KPiAgCQlkb3V0KCJnZXRfZ2VuZXJpY19y
ZXBseSAlbGxkIGRuZVxuIiwgdGlkKTsNCj4gIAkJKnNraXAgPSAxOw0KPiAgCQltID0gTlVMTDsN
Cj4gKwl9IGVsc2UgaWYgKGZyb250X2xlbiA+IHJlcS0+cmVwbHktPmZyb250X2FsbG9jX2xlbikg
ew0KPiArCQlwcl93YXJuX3JhdGVsaW1pdGVkKCJnZXRfZ2VuZXJpY19yZXBseSAlbGx1IGZyb250
ICVkID4gcHJlYWxsb2MgJWRcbiIsDQo+ICsJCQkJICAgIHRpZCwgZnJvbnRfbGVuLA0KPiArCQkJ
CSAgICByZXEtPnJlcGx5LT5mcm9udF9hbGxvY19sZW4pOw0KDQpUaGVyZSBpcyBhIGRpZmZlcmVu
Y2UgYmV0d2VlbiBkb3V0KCkgYW5kIHByX3dhcm4oKS9wcl9lcnIoKSBvdXRwdXRzLiBVc3VhbGx5
LA0KQ2VwaEZTIGRvZXNuJ3Qgc2hvdyBmdW5jdGlvbiBuYW1lIGZvciB0aGUgY2FzZSBvZiBwcl93
YXJuKCkvcHJfZXJyKCkgZmFtaWx5IG9mDQptZXRob2RzLiBFdmVuIGlmIHdlIHdvdWxkIGxpa2Ug
dG8gbWFrZSBhbiBleGNlcHRpb24sIHRoZW4gX19mdW5jX18gY291bGQgYmUgbXVjaA0KY2xlYW5l
ciB3YXkuIEFsc28sIGl0IG1ha2VzIHNlbnNlIHRvIG1lbnRpb24gdGlkIHNvbWVob3c6DQoNCiJ0
aWQgJWxsdSwgZnJvbnQgJWQgPiBwcmVhbGxvYyAlZFxuIg0KDQpBbmQgSSB0aGluayB0aGF0IGRv
dXQoKSBjb3VsZCBiZSByZXdvcmtlZCB0b286DQoNCmRvdXQoIiVzIHRpZCAlbGxkIGRuZVxuIiwg
X19mdW5jX18sIHRpZCk7DQoNCkRvIHlvdSBrbm93IHdoYXQgZG5lIGlzPyA6KQ0KDQo+ICsJCSpz
a2lwID0gMDsNCj4gKwkJbSA9IGNlcGhfbXNnX25ldyh0eXBlLCBmcm9udF9sZW4sIEdGUF9OT0ZT
LCBmYWxzZSk7DQo+ICsJCWlmIChtKSB7DQo+ICsJCQljZXBoX21zZ19wdXQocmVxLT5yZXBseSk7
DQo+ICsJCQlyZXEtPnJlcGx5ID0gbTsNCj4gKwkJCW0gPSBjZXBoX21zZ19nZXQocmVxLT5yZXBs
eSk7DQo+ICsJCX0NCg0KSWYgSSB1bmRlcnN0b29kIGNvcnJlY3RseSwgdGhlIHB1cnBvc2Ugb2Yg
c2tpcCBhcmd1bWVudCBpczoNCg0KbXNnIGlzIG5vdCBOVUxMICsgc2tpcCA9PSAwOiBOb3JtYWwg
4oCUIHJlY2VpdmUgdGhlIG1lc3NhZ2UgaW50byB0aGlzIGJ1ZmZlcg0KbXNnIGlzIE5VTEwgKyBz
a2lwID09IDE6IFNraXAg4oCUIGludGVudGlvbmFsbHkgZGlzY2FyZCB0aGlzIG1lc3NhZ2UgKHVu
a25vd24gdGlkLA0Kb3ZlcnNpemVkIGRhdGEsIGV0Yy4pDQptc2cgaXMgTlVMTCArIHNraXAgPT0g
MDogT09NIOKAlCBhbGxvY2F0aW9uIGZhaWxlZCwgY29ubmVjdGlvbiBlcnJvcg0KDQogQlVHX09O
KCghY29uLT5pbl9tc2cpIF4gc2tpcCk7IFsxXQ0KDQpTbywgdGhlIGluaXRpYWwgaXNzdWUgd2Fz
IGZyb250X2xlbiA+IHJlcS0+cmVwbHktPmZyb250X2FsbG9jX2xlbi4gQW5kIGlmIHdlDQpjYW5u
b3QgcmVhbGxvY2F0ZSB0aGUgYnVmZmVyLCB0aGVuIGl0IHNvdW5kcyBsaWtlIHdlIGludGVudGlv
bmFsbHkgZGlzY2FyZCB0aGlzDQptZXNzYWdlIGJlY2F1c2Ugbm90IGNvcnJlY3QgbGVuZ3RoIG9m
IGJ1ZmZlci4NCg0KRG9lcyB0aGlzIGxvZ2ljIG1ha2Ugc2Vuc2U/DQoNClRlY2huaWNhbGx5IHNw
ZWFraW5nLCBpdCBpcyBwb3NzaWJsZSB0byBjb25zaWRlciB0aGlzIGFzIGFuIGFsbG9jYXRpb24g
ZmFpbHVyZS4NCkJ1dCB0aGUga2V5IGlzc3VlIGlzIHRoZSBpbmNvcnJlY3QgbGVuZ3RoIG9mIGJ1
ZmZlci4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gIAl9IGVsc2UgaWYgKGRhdGFfbGVuID4gcmVx
LT5yZXBseS0+ZGF0YV9sZW5ndGgpIHsNCj4gIAkJcHJfd2Fybl9yYXRlbGltaXRlZCgibW9uIGdl
bmVyaWMgcmVwbHkgdGlkICVsbHUgZGF0YSAldSA+IHByZWFsbG9jYXRlZCAlenUsIHNraXBwaW5n
XG4iLA0KPiAgCQkJCSAgICB0aWQsIGRhdGFfbGVuLCByZXEtPnJlcGx5LT5kYXRhX2xlbmd0aCk7
DQoNCg0KWzFdDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ny4xLXJjNC9zb3Vy
Y2UvbmV0L2NlcGgvbWVzc2VuZ2VyX3YxLmMjTDEyMDkNCg==
