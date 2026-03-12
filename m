Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A563AC0C8;
	Thu, 12 Mar 2026 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343970; cv=fail; b=QQ1xo8s4r8cq9V/yf6X8ViiSRLhqDk9+UHDTojYGownPBZdvHkrtMLGa8kxPhRdV60b8NMkRG98ECZ0EdifQS1KdDbvx3XbZ5Cx+YIj+j3VpVauCc9b6a5R0jR2vFsXiGkG7t9sOpKoUO+gB4sw1HrjEIlTo2zzp617ESzgDt6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343970; c=relaxed/simple;
	bh=8GfcTeU2mvqhbkppmGfvI4iPIzbdomguNm2yHhl4VxY=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=lVKBwUr7CD7nOdejVnGGeHi2YHJE0kLGW3mqRFn85Wxq2cjg2mLsAJP9OfTaTa9WIAknTbe7IHQCjH2Vz0WaA+SAlfGwzu2hu7T8cjF+QTAl6yTBkusWri+qsjbMSw9E9CkHU6cQMBWm7TON2YpmKb0QgWAntRblKR5vwuD1sDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fhegAq52; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fhegAq52"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CEPJET2279935;
	Thu, 12 Mar 2026 19:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=8GfcTeU2mvqhbkppmGfvI4iPIzbdomguNm2yHhl4VxY=; b=fhegAq52
	bBMVwcKc+m0J+UsyoTVxy1BUX2vozJkNw2QlKoAtng0yDEaTUl+f8fm8+IhhVM/Z
	w34vfEqHIy4v+So3RE2wP+huUJ8ml4JZ8QkCaL6ePzFKLww1YerVgp0Ou/nNK74p
	Nu0niPT0yDgRSok3SmCe2BmKMXPaNoXCIju2A075b6e4gOHHrf/lpYaxvV2cVyxA
	aRrNGcrR58C/ZGDuv+E5BF+UKfag4bCVL1ZWnHwsRY3VHycry6p68JebZ3/vCbAH
	sZevC+Yje0zXMvZt/GvOAqB5mHFxHLoDrhjLV05Frb7+cDGv7gbSpinqeggSY8Pp
	icdtqQF32zJBww==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91mhsk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 19:32:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2hIQXK4vB+KE+nLGSp/IR5wtyLhpJKl2I0cDKMjXXcQCYc9qFx6WE9RnuwIjrQ8dwBNkpFrhWRqaKbYBsG+X9v0y0Eueklg1X9WMAl6UXDq/O1Hm+cMFDqW6SUxdKp3CMgXVlPG8buVRargJKWcQeYqQiHVLM5uFiij9xEgSux1cvru1cWIJYnRdFwZNH3SeOymtLVWPvKQ4R2iBmISY6LV4dKMGWlUccnHrpL1qXAT9Aw3S3KtGnvjCK1qGt5+jA8bs8OiT5m2HtNSJMraqpr0V85ZXplWJKEaAb2tHwDNxxv31GR6Yf/OqvLJms4yEzhg+QuIeVtQRSq7Et+a1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GfcTeU2mvqhbkppmGfvI4iPIzbdomguNm2yHhl4VxY=;
 b=Q0cr+T5gTeGKLaN7Mxu1FQgFVIZzRlXcDQQSzhi6iU5f1C4QPOV9mv30NDruEhC5JYMq79rcnly2S+isVNArUANKzSc4ZulJRiNQ5R36BOpF9TB30DpMQnxbXIAQIDWM4EgwvzhxlSUfgfEc/biFfwfC4pb97U/5vB8kHn3mWQtLDfel3cLUaiwLyAcIxcyLl+XQ/JPgKmjYY31NrbqB16QBUExzuwJspCPQZgATt46UhA4fB4NisNZX491nlrcD11u9IMePMSIiX9SkWDd5lOA++Jbs/nB+qSkS53hqQaMTCOpt9C88k57kK7+f6B5uAkal0iKidn8lgX7qEw6l2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM3PPF7C02900D4.namprd15.prod.outlook.com (2603:10b6:f:fc00::424) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 19:32:41 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 19:32:41 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "ionut.nechita@windriver.com" <ionut.nechita@windriver.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>
Thread-Topic: [EXTERNAL] [PATCH v1 04/13] ceph: fix race condition in
 cleanup_session_requests()
Thread-Index: AQHcsfibfxgRYXJlMEyNw3zeF0F+P7WrSgiA
Date: Thu, 12 Mar 2026 19:32:41 +0000
Message-ID: <c04ac668137d1ff6cd76565c0450eb2e02e2d265.camel@ibm.com>
References: <20260312081619.40854-1-ionut.nechita@windriver.com>
	 <20260312081619.40854-5-ionut.nechita@windriver.com>
In-Reply-To: <20260312081619.40854-5-ionut.nechita@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM3PPF7C02900D4:EE_
x-ms-office365-filtering-correlation-id: d4258acf-f135-4056-0ff5-08de806e2075
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 68e2e0lm8zE5dZ2Hdb+LHqKNiBuKvAEHnJKuvXaEjcNTPCBP05AiGKH+7QNKIHgB8kgAk2BXDIrTlvpHPXZ6mIZ1JpeHN36Gp+650hUv6CS98brs5dUPfBJX7Wul2fBTZCTd1F4aCZYRIPXMNADMyOMSvCoTrwRScZ4kArf8H2tfmK4n+JaigbDGnAhWEREaEPntf7BpabwKP1YvqJw86S2o0M5X69ky0w/h5uRt7MLZw4S0CLJqYhOU1XoX3VbKCceGy0bafTELCYyeWxFmVxqHpgCsd9LuXtnfIjcjoEH+rtToHwbD0+j/D+RIuP3eigVmyW1+LWLYJFLuw3tms7BXcj1XdD92T2VdMk6Fr7ymLmgRAdFk81yOrncOMnfjTyAKzVT2q8Ko6NvBfYLwbszbAzflgAbd3+sIipeQnx+iUhcAnPjWDWqs8kEWge5as5sbgF+DCnAGwhbRW1MFrkxa6yg97qNH0wYeXi0BsgGtUtv7fD3ZB4E5D6xER7z/2FDCj93qKULR7sgPvErE6nnXYpJb7ixxZJ7qMLAxeo/o8iWbNqwlp1l7MaaFIIpZeGVJkF/f62jtkRgfFZTNUL7ym5HBGpqNcrXhBmHIYV+ptUAihfgpp6AoYetDGtPkGIFyijnKhCwH133sa4RG2IAZsCrLTQ4pMtCjNL3SmDsXDEAthaDFAV1fhWHdwbj1jG164qlpgne6Q8C6s8ORAFKHK/mTfe8i2x2N7hvYFH5vtUrkp+/UjZ2iIeN5sROpLnX3X+EuKxWjl6i939U0TEWWrad4fCQUk8EAobb+nGs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V25BYit6bzU0eHRhejRjbEVLS3hDb01nSFhBZWdhL0F4dEw0MFBPQk8xdFBF?=
 =?utf-8?B?clZNUGI3TnREOUQrQU9za0JYOWtFOHlxdU5TaVMvYWcvSWhNZEVNNGwwYThD?=
 =?utf-8?B?eDJNVXp6QkIxNU1XV3dxMEM2MzkzcHdSNU5XMlViejlnVmlxRGF3UFdxRzZB?=
 =?utf-8?B?SWdkUG1UMVYrMHo3VC85M3FhVmljU3VUT0h6WkU3TFA5UDZqZmFMSExIVHEw?=
 =?utf-8?B?S1dFNmdjOHNiZ0FGZmV6ZzkyeUU0a1NoU1hVNkRMQ1ZqaWw3R3pSb1FyOWdK?=
 =?utf-8?B?UVowbExGSXBuVTIzU2RSdmowS1p3eG5Lc2pJQWgxdVk5eWkvcjVQdmRheGl6?=
 =?utf-8?B?dnN4UGs2OGVwb3ZQVmNzUTB2OEhmU2J6NWFzdVFXS3lJMkpQeHd3eHhhdVJt?=
 =?utf-8?B?RkJwZGhmYlFNL1V2SHpyUndBOXk2Zlo2a0ZHemI4d0ZNL1V2b1RqRDFpWGw5?=
 =?utf-8?B?dGhFN1I3SWN4Ni9pVDRaU0gwdlNBVHFDNHNFM1VHUlVqeUNTSk8xOG9wMkhZ?=
 =?utf-8?B?c0E3RzZBNzdadWFnSDVkdjNzZzczb1lFUGpoeVJTb1hxNk9aSCtNaUZzeS9h?=
 =?utf-8?B?TVJneGVPMWN4a2lqTjAwcUFJeVNMbXNDZ2ZQWEVHT3Evc05haEM2eGlLd2dE?=
 =?utf-8?B?WTRxaHBJTmVHWEo3OFR1Y0VIQmE3V3dJeXZWR0taUjFLZUwxdnNzT3lIZjAw?=
 =?utf-8?B?TzMxNEZxcTh5ckVRd2JjSlQ1UzM4TEI5VTZVQ21aK21UcmwrK003K1g4MHlv?=
 =?utf-8?B?TU9qUjlsby82akVCNGl1UytTNHcxejRJdEFwUW9uOUIvb3A2SkpRWXV0N210?=
 =?utf-8?B?Q1hCT0pRTlJBdmpnMDIraWxic1NUYTZ2d05mUHh2OHRWOVFNMk9pTWdqQk51?=
 =?utf-8?B?b3owL3gxdDRiR3RORlBTQ1QzZ0JDdy9WOUVIVFBsenNoa3ZjWUZMaEFCSFNQ?=
 =?utf-8?B?K241eWRhdHQrYWs0Zk9GSGJDM2JUcnZUdmdBM3hxTU42TDd1TzFTOUZWMlEy?=
 =?utf-8?B?T1RFVGoxaDVzcDFGelhJeEtpL2NmNG1XTDVUaHRnVEl2OXJKc3ljYUZjd3JS?=
 =?utf-8?B?dVlrSDdBNy9lNzMrU04zVC9DSHpvMWRMQlpWZVM3d1BHVVFRSzJFYVdGL1Rx?=
 =?utf-8?B?ZnpOZzl5d2FmakpPSmtDUENRa0RIUUhZUml5T2lkK3FlN3Nzc2pndzN6cERr?=
 =?utf-8?B?N3lycXlqRVUrSGxRR3ZEQ2dCU1d6bUUyUGxhMnBnbzhUT2Fxb1ZOeE4wbjcr?=
 =?utf-8?B?a2NYalk0ZzMxZHdnSG5veFM4RGFlTWY3M0NLWXVGcmRJYnJwUElnV2ZJYkli?=
 =?utf-8?B?dE1UT2Vpc0FYbVFOVGRDeTRjU1Fua3JoYk1QYmU5VVNrZDRlUjMyYkNNSjlH?=
 =?utf-8?B?YTY1c3RjVGI3bGVJRWI4eGRJRXVmTWFmRXRwTEJGeHZRcHBPRGRCSWl5VGJ3?=
 =?utf-8?B?VmxRVFp0TXErcHUrOVBYZ2tyVkxqWWJEV1ovQzd1NzhSVjZnWGF4bGsreUh5?=
 =?utf-8?B?aFkrMzNKeGdBVXFqcGRrNzZ3dGdaNlNoS3JSTDFra3A0MHdINjFyYTNVYUdo?=
 =?utf-8?B?QnJPbmlyNGxGOGJhZGRuWEtTRTBsVEo1NTl3eG9OUzArZ2c5dXNmejFNZFgy?=
 =?utf-8?B?N293Y0xDK0NreGNnTlRNSlgrcE5oYmhmUTZmQzhCdXBZL3BqTGFPZlZDdmpS?=
 =?utf-8?B?WFpEa1RVTGZVOVQvQVYrRXJnMlIrOVdIZ2tleE9zRUZBL3Bvc0Z5QStNRGFy?=
 =?utf-8?B?aFYrdHJocEd0dlJiT0JZenZmZHZWd3dmUkZsMTR3WmJzRG1BQWh4K2Q3S1pD?=
 =?utf-8?B?SUgxTFNRRXkvcXRkVzh0bXpOMDhmUjZXSkVUcXFOTVRHMHkzdFZlcjExbWJi?=
 =?utf-8?B?TTlDelRnelNMNlQ0K0ttY2Z3YXRxRDZoYk5ya0Q0cWVuM1RlQmhtWTZxNVNS?=
 =?utf-8?B?SnkyRDZtQU1JTjVIZ282SG9HQnY3d2dydklYdFpGWG1nYm9Jc2gvb0JzNnpx?=
 =?utf-8?B?RUE0ZTBGTjBEL0xNblBSMSswWURlL3NzcTJqWGZQMU5ZRngvdG90NHNoa2JS?=
 =?utf-8?B?dVRNZGxDVFBZeEJ0aE4xSlFJVU1wRjIyVEs3aEpIM1dwUWh6dTh3UU5qK1Bh?=
 =?utf-8?B?SkFlSVVuQThWdzFiWWtuQkhDV01SUi9US1FGUU92ejhsODIxampXc0R4SEJr?=
 =?utf-8?B?RGZmZ296dmY5aE9ZTThVMjE5aCtqT2JUeTJBL3QzSWZsa2xmMng4RDM0Si95?=
 =?utf-8?B?RXQxZ0RTZUZ0SERKR0JwdUl6LzRaMmQxWmtFWHdUZXF0Z1lyb2U0UXJCSGJD?=
 =?utf-8?B?YXZ3VG15SW1KUE9FVDRwN2JmME1CTWhuME9UWGtjZDN6VitDZ3ZJQ2M2c3JF?=
 =?utf-8?Q?4muq23gRtL4HRlJtpQ22IP8ChQV0PjwazrE6s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB9AD82822DB8540B01163F556CFF0CD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mTu1Pu/To7PtYeRZP1tlRZYGl2zPyghYPfX2/or3OpuMfCnpDnfynCAesgHzQHcTScEnBai5xLdu8A9QpJtlALEhBUFPQwP18Xh4BH+ge20HmJBgixwDCUvZ+uZv92cebv+fpo7VvFlMbQ5uucATEjmo6DVoslReuZoQeo96kszJRRX3exfVM47+ykJXorpOq2IFfcqXFFLEelz5zxyWYvm7p8tRyxQCN4CES00lpPqqc5DT8N6gURVkApOg15riaKHsGZfCuYLbNC00fPCQfLTwpU2sGe4IfLnDE/Or0NL+bgiAZrQCbSJ85I39KNXwOZNDRMIiAyq1eXaC7kp2TA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4258acf-f135-4056-0ff5-08de806e2075
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 19:32:41.2186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivjeTLJyPtmBrlyCx9JlmNAyV8jr5VVOduZHNSKXa7LgCxIO++POmP2x0HRuAsIrlqrj5eIg31P1BYGM3KP9Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF7C02900D4
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: rdDzO_oE1oNoTGKOr5s5Ih36UspUik6P
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b314de cx=c_pps
 a=u7VgDZIRhFIHkGP5DPkLlQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=t7CeM3EgAAAA:8 a=VnNF1IyMAAAA:8
 a=9TeWN7KsdMaUCuVybZwA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE1OCBTYWx0ZWRfXwjI+iGSgHpDF
 gWi4SctdskVuW1j/U4H8x8eMoYdfoXoySIBxNsgE4XwKF4G0KGCvYzcTnd8Gx1qHtlM9T5YwugF
 HYJMn5PePXFKduesEzd6f+wfrhkMxAQIPoEEUtsh86+YfmauLbCWqAFYEoHyH+5AyhVvIyolQgG
 PJ/OcYvxKKKsZODGwkilxxS8Se+kmxVs6fpF8PmOvI3wOhs3gWi5MBn+q/GUD6Y+RvkecsJyoAr
 eVeeS+t1RVCIVDI7OEfZiuvyvfDGffVSJhRRW6rPw8Jl79giXfroOUBZiI218Obox01TMajofMd
 NcyqYldlyST4Lbbna2lEilx5RYzPo43xS7xo/8jQ/R+crjAV7ZIy6ZLyz4RyRNaFfnfycSh6CsS
 UZNV/aIm6SKLGOCCAEC5FrQ6IulxLiAqK58bsXETFBgqv0WFc0+GGxtLZqebEEJ+EzzSlCLjJ8O
 eSoK1s5DulmAXZz9EmA==
X-Proofpoint-ORIG-GUID: NmNAwAsDfrnwG5MPhU7HKCDUR-j9q1Fj
Subject: Re:  [PATCH v1 04/13] ceph: fix race condition in
 cleanup_session_requests()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120158

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDEwOjE2ICswMjAwLCBJb251dCBOZWNoaXRhIChXaW5kIFJp
dmVyKSB3cm90ZToNCj4gRnJvbTogSW9udXQgTmVjaGl0YSA8aW9udXQubmVjaGl0YUB3aW5kcml2
ZXIuY29tPg0KPiANCj4gV2hlbiBhbiBNRFMgc2Vzc2lvbiBpcyBjbG9zZWQgb3IgcmVzZXQsIGNs
ZWFudXBfc2Vzc2lvbl9yZXF1ZXN0cygpDQo+IG9ubHkgdW5yZWdpc3RlcnMgcmVxdWVzdHMgdGhh
dCBhcmUgb24gdGhlIHNlc3Npb24ncyBzX3Vuc2FmZSBsaXN0Lg0KPiBIb3dldmVyLCByZXF1ZXN0
cyBhcmUgb25seSBhZGRlZCB0byBzX3Vuc2FmZSBhZnRlciByZWNlaXZpbmcgYW4NCj4gInVuc2Fm
ZSIgcmVwbHkgZnJvbSB0aGUgTURTLg0KPiBUaGlzIGNyZWF0ZXMgYSByYWNlIGNvbmRpdGlvbjog
aWYgYSB3cml0ZSByZXF1ZXN0IGhhcyBiZWVuIHNlbnQNCj4gYnV0IHRoZSBNRFMgYmVjb21lcyB1
bmF2YWlsYWJsZSBiZWZvcmUgc2VuZGluZyB0aGUgdW5zYWZlIHJlcGx5LA0KPiB0aGUgcmVxdWVz
dCB3aWxsOg0KPiAgIC0gSGF2ZSByX3Nlc3Npb24gc2V0IChwb2ludHMgdG8gdGhlIGZhaWxlZCBz
ZXNzaW9uKQ0KPiAgIC0gQmUgaW4gdGhlIHJlcXVlc3RfdHJlZQ0KPiAgIC0gTk9UIGJlIG9uIHNf
dW5zYWZlIGxpc3QNCj4gICAtIE5ldmVyIGhhdmUgcl9zYWZlX2NvbXBsZXRpb24gc2lnbmFsZWQN
Cj4gTWVhbndoaWxlLCBmbHVzaF9tZGxvZ19hbmRfd2FpdF9tZHNjX3Vuc2FmZV9yZXF1ZXN0cygp
IGl0ZXJhdGVzDQo+IHRoZSByZXF1ZXN0X3RyZWUgbG9va2luZyBmb3Igd3JpdGUgcmVxdWVzdHMg
d2l0aCByX3Nlc3Npb24gc2V0LA0KPiBhbmQgd2FpdHMgb24gcl9zYWZlX2NvbXBsZXRpb24gZm9y
IGVhY2ggb25lLiBTaW5jZSB0aGUgcmVxdWVzdA0KPiBpcyBub3Qgb24gc191bnNhZmUsIGNsZWFu
dXBfc2Vzc2lvbl9yZXF1ZXN0cygpIHdvbid0IHVucmVnaXN0ZXINCj4gaXQsIGFuZCB0aGUgY29t
cGxldGlvbiBpcyBuZXZlciBzaWduYWxlZCAtIGNhdXNpbmcgYW4gaW5kZWZpbml0ZQ0KPiBoYW5n
Lg0KPiBUaGlzIHdhcyBvYnNlcnZlZCBpbiBwcm9kdWN0aW9uIHdoZW4gcnVubmluZyB4ZnN0ZXN0
cyBnZW5lcmljLzAxMw0KPiBpbiBhIGxvb3AsIHdpdGggc3RhY2sgdHJhY2VzIHNob3dpbmc6DQo+
ICAgSU5GTzogdGFzayBmc3N0cmVzczoxNDQ2NiBibG9ja2VkIGZvciBtb3JlIHRoYW4gMTIyIHNl
Y29uZHMuDQo+ICAgQ2FsbCBUcmFjZToNCj4gICAgIHdhaXRfZm9yX2NvbXBsZXRpb24rMHgxNGEv
MHgzNDANCj4gICAgIGNlcGhfbWRzY19zeW5jKzB4NGI0LzB4ZTgwDQo+ICAgICBjZXBoX3N5bmNf
ZnMrMHhhMC8weDRjMA0KPiAgICAgc3luY19maWxlc3lzdGVtKzB4MTgyLzB4MjQwDQo+IEZpeCB0
aGlzIGJ5IGV4dGVuZGluZyBjbGVhbnVwX3Nlc3Npb25fcmVxdWVzdHMoKSB0byBhbHNvIHVucmVn
aXN0ZXINCj4gcmVxdWVzdHMgdGhhdDoNCj4gICAtIEJlbG9uZyB0byB0aGUgY2xvc2luZyBzZXNz
aW9uIChyX3Nlc3Npb24tPnNfbWRzIG1hdGNoZXMpDQo+ICAgLSBIYXZlIE5PVCByZWNlaXZlZCBh
biB1bnNhZmUgcmVwbHkgKENFUEhfTURTX1JfR09UX1VOU0FGRSBub3Qgc2V0KQ0KPiAgIC0gSGF2
ZSBOT1QgcmVjZWl2ZWQgYSBzYWZlIHJlcGx5IChDRVBIX01EU19SX0dPVF9TQUZFIG5vdCBzZXQp
DQo+IFRoZXNlIGFyZSByZXF1ZXN0cyB0aGF0IHdlcmUgaW4tZmxpZ2h0IHdoZW4gdGhlIHNlc3Np
b24gZmFpbGVkIGFuZA0KPiB3aWxsIG5ldmVyIGNvbXBsZXRlLiBVbnJlZ2lzdGVyaW5nIHRoZW0g
c2lnbmFscyByX3NhZmVfY29tcGxldGlvbiwNCj4gdW5ibG9ja2luZyBhbnkgd2FpdGVycy4NCj4g
UmVxdWVzdHMgdGhhdCByZWNlaXZlZCBhbiB1bnNhZmUgcmVwbHkgYnV0IG5vdCB5ZXQgYSBzYWZl
IHJlcGx5DQo+IGFyZSBhbHJlYWR5IG9uIHNfdW5zYWZlIGFuZCBoYW5kbGVkIGJ5IHRoZSBleGlz
dGluZyBjb2RlLiBGb3INCj4gdGhlc2UsIHdlIHByZXNlcnZlIHRoZSBvcmlnaW5hbCBiZWhhdmlv
ciBvZiByZXNldHRpbmcgcl9hdHRlbXB0cw0KPiB0byBhbGxvdyByZS1zZW5kaW5nIHdoZW4gdGhl
IHNlc3Npb24gcmVjb25uZWN0cy4NCj4gRml4ZXM6IGUzZWM4ZDY4OWNmNCAoImNlcGg6IGNsZWFu
IHVwIHVuc2FmZSByZXF1ZXN0cyB3aGVuIHJlY29ubmVjdGluZyBpcyBkZW5pZWQiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBJb251dCBOZWNoaXRhIDxpb251dC5uZWNoaXRhQHdpbmRyaXZlci5jb20+DQo+
IC0tLQ0KPiAgZnMvY2VwaC9tZHNfY2xpZW50LmMgfCAyNCArKysrKysrKysrKysrKysrKysrKyst
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvbWRzX2NsaWVudC5jIGIvZnMvY2VwaC9tZHNfY2xp
ZW50LmMNCj4gaW5kZXggMzc4OTk0NjQxMDFmNy4uNDVhYmRkZDdmMzE3ZSAxMDA2NDQNCj4gLS0t
IGEvZnMvY2VwaC9tZHNfY2xpZW50LmMNCj4gKysrIGIvZnMvY2VwaC9tZHNfY2xpZW50LmMNCj4g
QEAgLTE3OTIsNiArMTc5Miw4IEBAIHN0YXRpYyB2b2lkIGNsZWFudXBfc2Vzc2lvbl9yZXF1ZXN0
cyhzdHJ1Y3QgY2VwaF9tZHNfY2xpZW50ICptZHNjLA0KPiAgDQo+ICAJZG91dGMoY2wsICJtZHMl
ZFxuIiwgc2Vzc2lvbi0+c19tZHMpOw0KPiAgCW11dGV4X2xvY2soJm1kc2MtPm11dGV4KTsNCj4g
Kw0KPiArCS8qIEZpcnN0LCBoYW5kbGUgcmVxdWVzdHMgb24gdGhlIHVuc2FmZSBsaXN0ICovDQo+
ICAJd2hpbGUgKCFsaXN0X2VtcHR5KCZzZXNzaW9uLT5zX3Vuc2FmZSkpIHsNCj4gIAkJcmVxID0g
bGlzdF9maXJzdF9lbnRyeSgmc2Vzc2lvbi0+c191bnNhZmUsDQo+ICAJCQkJICAgICAgIHN0cnVj
dCBjZXBoX21kc19yZXF1ZXN0LCByX3Vuc2FmZV9pdGVtKTsNCj4gQEAgLTE4MDMsMTQgKzE4MDUs
MzAgQEAgc3RhdGljIHZvaWQgY2xlYW51cF9zZXNzaW9uX3JlcXVlc3RzKHN0cnVjdCBjZXBoX21k
c19jbGllbnQgKm1kc2MsDQo+ICAJCQltYXBwaW5nX3NldF9lcnJvcihyZXEtPnJfdW5zYWZlX2Rp
ci0+aV9tYXBwaW5nLCAtRUlPKTsNCj4gIAkJX191bnJlZ2lzdGVyX3JlcXVlc3QobWRzYywgcmVx
KTsNCj4gIAl9DQo+IC0JLyogemVybyByX2F0dGVtcHRzLCBzbyBraWNrX3JlcXVlc3RzKCkgd2ls
bCByZS1zZW5kIHJlcXVlc3RzICovDQo+ICsNCj4gKwkvKg0KPiArCSAqIEl0ZXJhdGUgdGhyb3Vn
aCBhbGwgcGVuZGluZyByZXF1ZXN0cyBmb3IgdGhpcyBzZXNzaW9uLg0KPiArCSAqIFJlcXVlc3Rz
IHRoYXQgaGF2ZW4ndCByZWNlaXZlZCBhbiB1bnNhZmUgcmVwbHkgeWV0IHdpbGwgbmV2ZXINCj4g
KwkgKiBjb21wbGV0ZSBvbiB0aGlzIHNlc3Npb24gLSB1bnJlZ2lzdGVyIHRoZW0gdG8gc2lnbmFs
IHdhaXRlcnMuDQo+ICsJICogUmVxdWVzdHMgdGhhdCBnb3QgdW5zYWZlIGJ1dCBub3Qgc2FmZSBh
cmUgaGFuZGxlZCBhYm92ZSB2aWENCj4gKwkgKiBzX3Vuc2FmZSBsaXN0OyBmb3IgYW55IHJlbWFp
bmluZywgcmVzZXQgcl9hdHRlbXB0cyB0byBhbGxvdw0KPiArCSAqIHJlLXNlbmRpbmcgd2hlbiBz
ZXNzaW9uIHJlY29ubmVjdHMuDQo+ICsJICovDQo+ICAJcCA9IHJiX2ZpcnN0KCZtZHNjLT5yZXF1
ZXN0X3RyZWUpOw0KPiAgCXdoaWxlIChwKSB7DQo+ICAJCXJlcSA9IHJiX2VudHJ5KHAsIHN0cnVj
dCBjZXBoX21kc19yZXF1ZXN0LCByX25vZGUpOw0KPiAgCQlwID0gcmJfbmV4dChwKTsNCj4gIAkJ
aWYgKHJlcS0+cl9zZXNzaW9uICYmDQo+IC0JCSAgICByZXEtPnJfc2Vzc2lvbi0+c19tZHMgPT0g
c2Vzc2lvbi0+c19tZHMpDQo+IC0JCQlyZXEtPnJfYXR0ZW1wdHMgPSAwOw0KPiArCQkgICAgcmVx
LT5yX3Nlc3Npb24tPnNfbWRzID09IHNlc3Npb24tPnNfbWRzKSB7DQo+ICsJCQlpZiAoIXRlc3Rf
Yml0KENFUEhfTURTX1JfR09UX1VOU0FGRSwgJnJlcS0+cl9yZXFfZmxhZ3MpICYmDQo+ICsJCQkg
ICAgIXRlc3RfYml0KENFUEhfTURTX1JfR09UX1NBRkUsICZyZXEtPnJfcmVxX2ZsYWdzKSkgew0K
PiArCQkJCWRvdXRjKGNsLCAiIGRyb3BwaW5nIHBlbmRpbmcgcmVxdWVzdCAlbGx1XG4iLA0KPiAr
CQkJCSAgICAgIHJlcS0+cl90aWQpOw0KPiArCQkJCV9fdW5yZWdpc3Rlcl9yZXF1ZXN0KG1kc2Ms
IHJlcSk7DQo+ICsJCQl9IGVsc2Ugew0KPiArCQkJCXJlcS0+cl9hdHRlbXB0cyA9IDA7DQo+ICsJ
CQl9DQo+ICsJCX0NCj4gIAl9DQo+ICAJbXV0ZXhfdW5sb2NrKCZtZHNjLT5tdXRleCk7DQo+ICB9
DQoNCk5pY2UgZml4Lg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5E
dWJleWtvQGlibS5jb20+DQoNClRoYW5rcywNClNsYXZhLg0K
