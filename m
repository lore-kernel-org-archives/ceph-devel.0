Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F231A317D
	for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2026 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136044; cv=fail; b=EZlMD17H7XvkxBFXhy5EJiow/WfZZYdflA54G5NnbO6I1uQe169Dfao6CpeX06m5RfWmkVU8duR0Ay7fQtqur5AIGIco2Hs2Kr3cLbOqmkpWfeBTKDPPv/8dwWgrFy/VSfshEU7bYIPG1fGvJQa7KtV1sF+2yrrtj4tZRylLt+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136044; c=relaxed/simple;
	bh=wdJpPordv/ExOpC3zr0LoqudxJ1+9B7kedrRHjcrPqw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=cNCsSU3yqb/E7pXZe+CmIGKnPvrfnYrIddlWGdCgIg1bhQivK0vm4/0BiMTsDr3dKq84jB/ypDB4s9c+C7dUt/yk/D52zmEBpgN46o7B7P79s+lTB/0edCP02yr5m9CtrNuA4gvWDqtyahJQHnGJvSmWVD1fdetKSSUHxZkuM5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gb7b8fMl; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gb7b8fMl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QIfWPm2760220;
	Thu, 26 Feb 2026 20:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=wdJpPordv/ExOpC3zr0LoqudxJ1+9B7kedrRHjcrPqw=; b=gb7b8fMl
	02q66r8xv1MAZFOvs3t7y3nLyWckAG9c7jjhScW4ebShrqagsd50afd7c8TJNJGv
	BzNu6+Nu0xIgKiOG+trvYrqa348JW2OK2SMzZtj6Jit21SQRhk893DYhT0weB7jM
	f136vCSo2nE9Ho1F/z3N7alVJpEbDAkIgLRPAm9kdwYKqlj9nEFr+0svJprNwUQl
	QYn9s1Ycm5CuCMyiz1dT5UGj8O1z/rU+jqrlvPKS/3LtzNo+CLolc8Ueq7wUWsec
	nBsmzjILRydt1EwqpBnaxYGNHp8pqrO51PvQrdbdwKspTTV9R0YJer8hqaLmKb5D
	5iUzkJX0XASZMA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34cfvhg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 20:00:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBdvaxDR/2xJ44ygi74mjdC3DW408kocuWWu4Rdeu1T5FRLNprpjRlhorSx3VYk5VlmMDyaLXMOFc2DbSQbnPDZx9P5ben2SR0Da7YJJmvKrPFJOnY5BTDgnWC/hRkNUd3ld6OScCuTiLarMadO3jNc5GpMVPWlq3XAVGdH6sDfQPDJheXOt2BnZGQirgsrxSJiGTQbqRgWWAhXMjD3JeRbJIqyv6al/7sEqzgBbEiTYoyebPdDkmNvW5+cQtNp1r9XSEVxdudHNMivNUyQ/qNuzQysM3R+CdltUmTgv/lVDEzfeirMa1unMwS3yk30bI0h1LtlKmC9miSRsX8XFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdJpPordv/ExOpC3zr0LoqudxJ1+9B7kedrRHjcrPqw=;
 b=dJuhKtKb6+kuNT1lnZVDPchYh/ELM/WW11rXnLBv1d/k6Dm2LYdP781l4DycdnqsXGVWfoTfWqhVVFCdSiZdzWlJIfITeXnxOdD1qtjaB4RKd33ehUZkinhi03o7qCOHoazE7fP6uxqcIsjEhfc5X4R9kR/Cg5x0oMiu+v0mwyDinCu/RfzzOkkpK3/4BLz7OTnP5EE4L3MYH5vFV6YIfWNbB/7TVY8afxEuBzgPEp3Oc+SlyLftrg0ue+hB3H05zeGIWhQbOv8cgNzEZZOFH5DStALp3HpjtLYH76oLtPPKgVf4GLrO0fkRfxJ9UmBhuDIoOCBjqqGuugAcRTIevQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4629.namprd15.prod.outlook.com (2603:10b6:a03:37a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 20:00:23 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 20:00:23 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v3] libceph: Use u32 for non-negative values
 in ceph_monmap_decode()
Thread-Index: AQHcp1nXzrnLiSy1w0WkeU9oNrxNF7WVZmAA
Date: Thu, 26 Feb 2026 20:00:23 +0000
Message-ID: <9fc9e9ebeef1049a0de420a2dd25fe91db5f3504.camel@ibm.com>
References: <20260226150731.1257332-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260226150731.1257332-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4629:EE_
x-ms-office365-filtering-correlation-id: 4b3ab503-ddd8-4f41-c022-08de7571ad5b
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 DXc3SoNQyK1U9CljJelvEz4Xy9ovFMyLHRK8kX/jB79GUFm1mYVxEgq+bL79tC9MC9ClW0Dso0OS8UYB6vZSQGDmy4UvCrj2sC4xxYbNRyhnNpDO3XlOm0+m1r84P5UZiTHYP67eA0aMKl+a142/vWUCBIAEu2IKKb6si7iT8FsaG1B0lD+Np7Yu6cwL5Mw1Oh8bzLG04NuCkx7xAkTWWlfT2pFYwiKWDnmVt50gVv7nhRZJ/brsKIgQLh0qEUEW/ZX3dD0R2uAU+jOPIh30vrOFIJaBhhvh9kVvz6SUF3anhJ0BbheStfOCm1kPInsRSmS7I3xjDDizSw+hORnUpA/qZso+mx/3T8DFC4thK12+9Gj9y2ob64tycqOHPzcQLn0KRwXzknn3+BTFWCRDt+whAw78yoCyq2nzlrcUh8qobH1CjoCWJL6aJtVROFmKLkKwkleJBYXwBBCD2INnqPPwalW9OYZQ9SJXWcRqnWUi96p7P4CoduUW49FNhXfeJ6W2r0Tr8CYDp/rh/rEZKq9de2YqEyYnW7y9BnW6SrQUVBYZJB7kmJflMJptzowAy9nLpClywqfdCgDHAdZyAaHNIm8b38nx1z1YPNruKyy1kPESeaDbepKoI2wpHb4cHa4j4iiSHXWAqFIIN9CMEwyVvm0XTUbXryB2BLAxbwXypyl/6w5qIpWVFDHzQz156hbyLU6QJlprl+Xlk+fPqH0qamr7DH2D1o9Y48e7HkX5+3p6F4sw/sbsTi8GVkZykiKK6P769tphMp6vD/RvSxLHsV3sfyxl/yQEzBHDluU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NTNaR3RONS9Edk83eXhEc2N2SUpvVkdmY1lBY3RCVWtINkFZWHFjcGJmd2pm?=
 =?utf-8?B?ejBkUVl2blBUeTN4NnFPQVJFTFQyOGRFRGNyTWoxV1d5b1k2Ym1kRFNkcHVY?=
 =?utf-8?B?T2wxWlhsZ2VIa0VpL2xCVmN5SWpyTDlpRm91TkUxZ0NOaGRVOUhiNEl6UVl0?=
 =?utf-8?B?VHJ0dEFzVjJUQWFvWHQvRytVOUJkV01aK0hkY3g5K043QjFibTY5ak4waTE2?=
 =?utf-8?B?ekRESUVBQ3RwNjNOZnVkVk00bklzMkM5QzRoRk1qcTJxWTJrb3MzM2FPWXBu?=
 =?utf-8?B?Z0pKTStHYjgybWdMS3hLb0QxVlkwMmlLdnNsOVV2NlZFdFZVQ2NCUDF3aXVo?=
 =?utf-8?B?UjdnNERZWXI5S2ZLZGxzRzRwUkZiaGRuMHhGRGpjUnN5MDhiNlY2WlRvUTZi?=
 =?utf-8?B?c2ZPbTVYSEY5MUJsTDZDaVdUYi90L2VPK2ZZQkZHYmRUcFdPeVJNQjQzWkkw?=
 =?utf-8?B?a2VjMDFJMllRMFUzUjhpaHBlZEwrOE9MdlVGL21DRnRXTmUvS2gvR0FiV1I2?=
 =?utf-8?B?bkNWMjU5SHpUVCtVQVhNUmZPK0QvSTE2R1JIU3NFVVRFQWRyZFBzczg2LzFH?=
 =?utf-8?B?WGx2dHZSS2hUVG5tdDRMMG9rcHlyMCtyRTJTZFNzbEV6NGNIOXJxcHZ1TnFR?=
 =?utf-8?B?VTdWQlAydE9Tdk5JbDZLOTRteHdkbGNleTF2MVJjYkdIdGFHTGVhcjRNSmJY?=
 =?utf-8?B?TXphcE9TUDI5VVN0emRaTVFqc0doM0FwWSttRHMwaGYzZkVaQ0kvc3VBUnR6?=
 =?utf-8?B?UTY3YkJSd3BwSnJLUEdSb2FZRVRQWElzRnlkZGFIcm9BUjk5Z05uQzA3ZEpZ?=
 =?utf-8?B?SkdyaXEzSUhROHZ2SEJ2VUdiNEQ1UFBuRnZjNEUxMENldHRTZkxJOGRGNXV3?=
 =?utf-8?B?bjAwTHFvR2w5M2VnYzVQTVFvbTl0YzJYUGVJUEZLZWtZcGliOFlDMlZwRGRB?=
 =?utf-8?B?RDNpVjViVFQ5cmhKU1pUOGN5c2xDNk16aWcweFBRTlp3ckcyNDU2QVdXOHRD?=
 =?utf-8?B?VFVScXdsczlIQkFVOHZta0RLeGl3bFFMVzk5eFBSVERndDRBYkg1TVlFTng3?=
 =?utf-8?B?K2xaRlZYeWdONSt1UWltN3VXTTNQSVgzUDZLU0RYUnlCU01MakV5Rjd3YU9a?=
 =?utf-8?B?T2FFdVhPMHRjcEoyd1dLMnhiUGhzWnYySlR0U3YwTU14M0wrbmlhM3N3MHZu?=
 =?utf-8?B?NlU1RytqWWZNZ01UNGpGQ1FsYnlSWnV2UWN1TzlLT3pCRElIbnVOalc0akRS?=
 =?utf-8?B?ZkN1SnZwRCtrRmwzTHlOdVlaMnYxZ3QvRDlSRUJuWHpBb1o1WVJoNTJFRFd1?=
 =?utf-8?B?T2VmVzdoUjZNdi8xUmdOWVVFK0Y2bDU0VUg1Z2RIWENQdk1JY1JLOUxETUwx?=
 =?utf-8?B?V21WWlVFQm54bThoUTViaXpxc3hkUndXMmp3R0NNM1JOKytCdjMvQlI2NTFS?=
 =?utf-8?B?YmZ0NHVCb1BwSHRoRmdVbTNaNVY2eE5sZG9JWXk1UVR0NThFNzVkaE0vNmFB?=
 =?utf-8?B?Nzg1YTBnVkx3SUNUNmExUFd0WFZaR1M1clZYZTRPZ09MVFAwaUwvaFpydDN1?=
 =?utf-8?B?TVBFMC9QcXVxcjlaWmRWVWFvUGNzWElTYUhVTnlqV1U3UmE0ZHRZaHIrbnZB?=
 =?utf-8?B?alN2NmszenI2bWZpSERGcFB4TWFUMFNyQlE2Y0dkSnoyMUZkUVQzZUR2T2Ns?=
 =?utf-8?B?bDdTa1o4Z243R0R3dm9kUlhyN2wxVW5CcGhEVk1aRlJMSllUUUZZQ01HRDY2?=
 =?utf-8?B?bi9TcVpzYjFwbnl3M3NPd0FmcngvakJ5MWdjZlJpUEVMT2VZcTEwZ0M3d1ZX?=
 =?utf-8?B?TlVoZ091VEtaTWN5dEQ0eTkxTlpiNHBHUnVCMVVtVlRDYWhqc3BwT1lPbnRI?=
 =?utf-8?B?cDE1a0NLaDR6YkFqWE05T3Z4K2theVhMM0JCaHFZU2RKZGl2bEwxVGI2WFJD?=
 =?utf-8?B?UDZhbExvcjJJbUJOR3BaMWx6a0RyZFhCaHA4YjNUSzBsVGRSbWpzTU5CM2VC?=
 =?utf-8?B?STV4UUVwd1hkbUt2Y1I1SHZEbWZrSlorQ0FiSGRPQWd6WDNDSVFzNld4N0pY?=
 =?utf-8?B?MUdmVk04S0RrSXZ6bmg3elE2cEgxMzZwQlpJYlhsaEJtQWl0ZWxxL25jQVlz?=
 =?utf-8?B?RVZ3bUZ6QzlHRUNUdWNIN2tuMlo3YjF5ckEyZWlYZHY0TnFlN00vL25US0pX?=
 =?utf-8?B?eWZtMkZSUE9PazVDRy9SY1NCZ01KeXpEeXFGOUF3OGZPbnNJNElxdjk1a241?=
 =?utf-8?B?cDA4MFZtb0FPY0s1SXl0Zy9Md29hUXBNZ3ZsbEZwRFpEUDFOdy9mcHpBQXZI?=
 =?utf-8?B?TTRNRmEyTzZ5MWQwS3BNMEJTbGhFcGdWbW90MHJNaTVNVnlrVHI2RnhFZ2NJ?=
 =?utf-8?Q?KpbkRx7JCZKv8A9rVNsxDO2Y22bC/GM93nerW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D26A1483384710469A99EC39AE3AAC26@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3ab503-ddd8-4f41-c022-08de7571ad5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 20:00:23.2993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RU9JzhezK4jCM8K8pE4ZZ3AgRio+/v0XJm0b8VnN4QkfrpXs4jrNIsPn/Mkda4e3USCOEFMUrEdMbIfT5JTuuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4629
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE4MCBTYWx0ZWRfX20T7sEG3J8Dv
 Ttg110GjeJCcLYvG/8IUFtr4QrUrrHP21894CELGmFIdW0tf53VJLJ9d8vOPzRpPmUM2gxIQKuq
 dDHy19jV3S3PeJT1GbMHLG6CyJnhc2Wfaz9HQDDk0IDXJjNnq/nI0WxNo+/QcSnfF2d6rSOSa81
 z8+d+DBc2qKBdphgLnLLYacgbUrxWMJqWHM1ZrgO7HuOoxVQBxJ3v+5AQt5guEAaGcbxI71q240
 uzNXOiq1r+2ao5t6/ompNSRf4/5sOZeqN3Udd2liJTvFAggFMpbL+WDbXiziLqqmwJlFHYyX1AW
 WgrP9lxNW50GeFRNAUXobQy6vTGMFCLdpxDa82Cs5WqR3iqGMZ41AhnsqU9AwGgT2x3OgwmFqk2
 ZguamOHjk2fm2sGX8l3r5akEALDVffGvRiIrndE4C/CFdkoNqMexLcthIhPnpOwCe8uKyDSvisk
 DZtoT9H8cqt5K4Hlknw==
X-Proofpoint-ORIG-GUID: HTuWk2XK4gsxr9wpxl880ljqVyjcrz8y
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=69a0a65a cx=c_pps
 a=oYvfaNmKcCZhiE/ts8qH8g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=0sdVyAEcWtogGtTMQVAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: A0tsc8lmdX7SqT0kUO96CqA8jeCKfWfm
Subject: Re:  [PATCH v3] libceph: Use u32 for non-negative values in
 ceph_monmap_decode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602260180

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDE2OjA3ICswMTAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gVGhpcyBwYXRjaCBmaXhlcyB1bm5lY2Vzc2FyeSBpbXBsaWNpdCBjb252ZXJzaW9ucyB0aGF0
IGNoYW5nZSBzaWduZWRuZXNzDQo+IG9mIGJsb2JfbGVuIGFuZCBudW1fbW9uIGluIGNlcGhfbW9u
bWFwX2RlY29kZSgpLg0KPiBDdXJyZW50bHkgYmxvYl9sZW4gYW5kIG51bV9tb24gYXJlIChzaWdu
ZWQpIGludCB2YXJpYWJsZXMuIFRoZXkgYXJlIHVzZWQNCj4gdG8gaG9sZCB2YWx1ZXMgdGhhdCBh
cmUgYWx3YXlzIG5vbi1uZWdhdGl2ZSBhbmQgZ2V0IGFzc2lnbmVkIGluDQo+IGNlcGhfZGVjb2Rl
XzMyX3NhZmUoKSwgd2hpY2ggaXMgbWVhbnQgdG8gYXNzaWduIHUzMiB2YWx1ZXMuIEJvdGgNCj4g
dmFyaWFibGVzIGFyZSBzdWJzZXF1ZW50bHkgdXNlZCBhcyB1bnNpZ25lZCB2YWx1ZXMsIGFuZCB0
aGUgdmFsdWUgb2YNCj4gbnVtX21vbiBpcyBmdXJ0aGVyIGFzc2lnbmVkIHRvIG1vbm1hcC0+bnVt
X21vbiwgd2hpY2ggaXMgb2YgdHlwZSB1MzIuDQo+IFRoZXJlZm9yZSwgYm90aCB2YXJpYWJsZXMg
c2hvdWxkIGJlIG9mIHR5cGUgdTMyLiBUaGlzIGlzIGVzcGVjaWFsbHkNCj4gcmVsZXZhbnQgZm9y
IG51bV9tb24uIElmIHRoZSB2YWx1ZSByZWFkIGZyb20gdGhlIGluY29taW5nIG1lc3NhZ2UgaXMN
Cj4gdmVyeSBsYXJnZSwgaXQgaXMgaW50ZXJwcmV0ZWQgYXMgYSBuZWdhdGl2ZSB2YWx1ZSwgYW5k
IHRoZSBjaGVjayBmb3INCj4gbnVtX21vbiA+IENFUEhfTUFYX01PTiBkb2VzIG5vdCBjYXRjaCBp
dC4gVGhpcyBsZWFkcyB0byB0aGUgYXR0ZW1wdCB0bw0KPiBhbGxvY2F0ZSBhIHZlcnkgbGFyZ2Ug
Y2h1bmsgb2YgbWVtb3J5IGZvciBtb25tYXAsIHdoaWNoIHdpbGwgbW9zdCBsaWtlbHkNCj4gZmFp
bC4gSW4gdGhpcyBjYXNlLCBhbiB1bm5lY2Vzc2FyeSBhdHRlbXB0IHRvIGFsbG9jYXRlIG1lbW9y
eSBpcw0KPiBwZXJmb3JtZWQsIGFuZCAtRU5PTUVNIGlzIHJldHVybmVkIGluc3RlYWQgb2YgLUVJ
TlZBTC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhcGhhZWwgWmltbWVyIDxyYXBoYWVsLnppbW1l
ckB0dS1pbG1lbmF1LmRlPg0KPiAtLS0NCj4gIG5ldC9jZXBoL21vbl9jbGllbnQuYyB8IDYgKysr
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL21vbl9jbGllbnQuYyBiL25ldC9jZXBoL21vbl9j
bGllbnQuYw0KPiBpbmRleCBmYThkZDJhMjBmN2QuLjk0YTdhODJjYTQ3NSAxMDA2NDQNCj4gLS0t
IGEvbmV0L2NlcGgvbW9uX2NsaWVudC5jDQo+ICsrKyBiL25ldC9jZXBoL21vbl9jbGllbnQuYw0K
PiBAQCAtNzIsOCArNzIsOCBAQCBzdGF0aWMgc3RydWN0IGNlcGhfbW9ubWFwICpjZXBoX21vbm1h
cF9kZWNvZGUodm9pZCAqKnAsIHZvaWQgKmVuZCwgYm9vbCBtc2dyMikNCj4gIAlzdHJ1Y3QgY2Vw
aF9tb25tYXAgKm1vbm1hcCA9IE5VTEw7DQo+ICAJc3RydWN0IGNlcGhfZnNpZCBmc2lkOw0KPiAg
CXUzMiBzdHJ1Y3RfbGVuOw0KPiAtCWludCBibG9iX2xlbjsNCj4gLQlpbnQgbnVtX21vbjsNCj4g
Kwl1MzIgYmxvYl9sZW47DQo+ICsJdTMyIG51bV9tb247DQo+ICAJdTggc3RydWN0X3Y7DQo+ICAJ
dTMyIGVwb2NoOw0KPiAgCWludCByZXQ7DQo+IEBAIC0xMTIsNyArMTEyLDcgQEAgc3RhdGljIHN0
cnVjdCBjZXBoX21vbm1hcCAqY2VwaF9tb25tYXBfZGVjb2RlKHZvaWQgKipwLCB2b2lkICplbmQs
IGJvb2wgbXNncjIpDQo+ICAJfQ0KPiAgCWNlcGhfZGVjb2RlXzMyX3NhZmUocCwgZW5kLCBudW1f
bW9uLCBlX2ludmFsKTsNCj4gIA0KPiAtCWRvdXQoIiVzIGZzaWQgJXBVIGVwb2NoICV1IG51bV9t
b24gJWRcbiIsIF9fZnVuY19fLCAmZnNpZCwgZXBvY2gsDQo+ICsJZG91dCgiJXMgZnNpZCAlcFUg
ZXBvY2ggJXUgbnVtX21vbiAldVxuIiwgX19mdW5jX18sICZmc2lkLCBlcG9jaCwNCj4gIAkgICAg
IG51bV9tb24pOw0KPiAgCWlmIChudW1fbW9uID4gQ0VQSF9NQVhfTU9OKQ0KPiAgCQlnb3RvIGVf
aW52YWw7DQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29A
aWJtLmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=
