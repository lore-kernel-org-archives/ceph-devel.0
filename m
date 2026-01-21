Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409F3EDAC6;
	Wed, 21 Jan 2026 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027071; cv=fail; b=D+UOMh+fZxDuckrfEcyMYvd4eWlsnH8wfqndMjMj/rF05wQa/z23oa7y5E5QuR8ZZXhb+AVofASOWyQ/po4iB3ev6cO1+P5nR4zD1gyuZuC7GiJhwWGOrqnN/OIHSC6aoAyFkJlJKfJAfQrjQQ2prGBtf4jTR+lhaWxg5Yo6TXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027071; c=relaxed/simple;
	bh=lA56jyegjqxEYVL+IDpk09LkhtFbRm8FmhtH/GrK75c=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=iz2D+Zzo/qCpmuzgLIAMoud+IzrUNGrCFIQZi7yCMo7nnevyKui18i6Zt/hdd/6pXDb/g66BWLWS6VhXS7ciT38oSILFaXjCDp0rdS20LHhsGgtG0uxulGtRpuTatRgsT+tYz4gIp73FJmSDM2PX6xO7pyalUHLQX6ut09/A6nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rrc5DXPt; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rrc5DXPt"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LD6cmv006239;
	Wed, 21 Jan 2026 20:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=lA56jyegjqxEYVL+IDpk09LkhtFbRm8FmhtH/GrK75c=; b=rrc5DXPt
	/8RigUJjYH2t4QNTNKT6repZB3Epadi/lLCOY4kwWXeW2xzhOwR5rtsWENE1SMUn
	0w4YfjuwtNgz+gIwjz5ArrZo1PdzmxF5j9nt0MhC2wE/9T9AvCFGA9QnLDVVcoXg
	eIPorIscYd/weP6Cf2oY6CFmW+sFGZvTjXeNXeWf5+pc+gIANcnTcuDlJX5roo1A
	pIfCL9tYcDyOE/d22Tefe6LzfowOwfiM+hXVgFxzUMi9BHdLrZbSCV7w/0uwU45d
	znID4rLkoQjr79cQPRt6cKYDMPWHcrK+BfIzLi/oLWvHIW4A2TMBXodyo+QRVOcc
	18e3sm9bmY6LTA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23s6e2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 20:24:20 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60LKOJje012702;
	Wed, 21 Jan 2026 20:24:19 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013052.outbound.protection.outlook.com [40.93.196.52])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23s6e26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 20:24:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+EkuFd75junbXXf+KdwHZTe7lLqMSiv/og/1Wuki7TuhPsFjiaKB6M4TCKFLUGwdUxAhjtjlu1hKhzkRUjPqJ7zHI7S+50YpHbDoJ3BcNq+tYXIvZOHHNM/r235SHA5HKtZzCBR4X/iyUBNkTsWrV+jqGOA7k8Yo8DQlFLcIcZhy928eV+I5tCGcsz6FP29HuB11FthW2vQP2ZPBSR+acb9NzJGPyBLu/yrz1sKgPydZ+STc/IaFPz0YrJIjpwfa+DeDZYPWsfnpewOVOSh4dDogp9AjJQr7CmR/jc5C2bvvoIDeSKEwYl1H+CudyFc8nnO0Vu7baoWFYBmmZmOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA56jyegjqxEYVL+IDpk09LkhtFbRm8FmhtH/GrK75c=;
 b=YuPbFFxK9nbu3hQFqyKS2tYubElrnzaDbo2fc6dxHowPvQxUJOavFWf5EQlDl1ID5v1+qarkBfVu4QXKvQoeU8fWlBouH56A1bw4ZL5GWFHf9UuZEYxD5h1SgZbIegk2tLNsIGCNfwbjMWniATtVwdVU+9K4/TZGvwjCXZ2bt7JEJwlNSBwh8pQp0gY0akeQRl6hKzqiW9Asc9FbHy5zQqzX/PK5Y5RbmMvi6fIMBIyRDX831PVfyNdm1JBQk+errnEOcvXZO4aQrOqVsepGFkNGX8U0GGwYpi0Zs/4J8E2uBWZxu5J66g1Scrnc1LVlwR0ZXDhM9vBKXmSCSTHsyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ4PPFFB312818C.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::8d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 20:24:17 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.010; Wed, 21 Jan 2026
 20:24:17 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "lilei24@kuaishou.com" <lilei24@kuaishou.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sunzhao03@kuaishou.com" <sunzhao03@kuaishou.com>
Thread-Topic:
 =?utf-8?B?W0VYVEVSTkFMXSDnrZTlpI06ICDnrZTlpI06ICDnrZTlpI06IOOAkOWklg==?=
 =?utf-8?B?6YOo6YKu5Lu2IeOAkVJlOiAgW1BBVENIIHYyXSBjZXBoOiBmaXggZGVhZGxv?=
 =?utf-8?B?Y2sgaW4gY2VwaF9yZWFkZGlyX3ByZXBvcHVsYXRl?=
Thread-Index: AQHciqgzOwe/bsjEVEiIjdz91mEu7bVdEoMA
Date: Wed, 21 Jan 2026 20:24:17 +0000
Message-ID: <e93388c77ebad3d32a7a851031e3aea6a6991d31.camel@ibm.com>
References: <20250808070819.18878-1-sunzhao03@kuaishou.com>
				,<1d51b68168de62cc852fc147fb5e2dc8fbd9373d.camel@ibm.com>
				,<409ca87f8add4a80a7927981059b3c5f@kuaishou.com>
			 <5af9d165d05d4dddbb6c5d6d9d312367@kuaishou.com>
		,<896a69bcc26e1d808e6dfe2d35e25c8b9f8b7f02.camel@ibm.com>
		 <df02fae47a2c45c284d5269a51a2ddd5@kuaishou.com>
	,<ebc291d2ae5cb3702f67831dd1da932d66177ae2.camel@ibm.com>
	 <26ab430040f0406087f4f6a2241525ce@kuaishou.com>
In-Reply-To: <26ab430040f0406087f4f6a2241525ce@kuaishou.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ4PPFFB312818C:EE_
x-ms-office365-filtering-correlation-id: c8c91598-9b31-4f11-386f-08de592b0d19
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVdrTFE5SURNUXhDRWY0N2NVUmdOT0ZGR0dwb3ZEZ29PaGowMVNGZGNIN2Vy?=
 =?utf-8?B?OHhoSVlJUEpiSzhZSGZpQmZtS1NFcDNzWEJVcHJBOEZrS2kwbDUvM25tY1hs?=
 =?utf-8?B?elU4SkhENzZrYm9ZYVY4Q0xSRlBKK0YzQ3V0MkkrZVpnQTBuclpEYmMvb1NT?=
 =?utf-8?B?bFZWaEc2aDJIaDVPdXhXZW5SRFphRmJTT2IxMGNMT3o5RFpxU1BoZWlTK0Nq?=
 =?utf-8?B?elJtcnJjdUJxeEZiRkhDcVU4ZWNyL2F1R3UzNGJSaWpzNFNKeGp3b1hseGdz?=
 =?utf-8?B?ZFBSMGlnU25TZ21PV3FCdGRkQktPZHJQTVNvVC9SL0MwS2dnWEViSmE0V3Iv?=
 =?utf-8?B?K0RVd1lOZjFEUCs2anAxa0ZDc1RMMytET1lFVmVnWlh4MnRNRlUvVHc3WWZp?=
 =?utf-8?B?ekVYd2kyaUIyc0JybkV2NFovUzMweUNaeDVTcFRObFQ2SG8yWEt3Zmx6ekVD?=
 =?utf-8?B?UWx5dkZwRkEwbUN4R0E2aTJJQkdSRFRQbmJvTzBXdjFmazA1M0lSTm9JdjVD?=
 =?utf-8?B?MFpFOUxES1RwRG91UlR5RWE3L1pQMldtTzVpTjZ1ejVWQk9EWUsvS0pwaW8y?=
 =?utf-8?B?ekQ4dDRsQ3ZUSnorZDZPdGh0NWhuRVhkYmRaRTVEWUs1MVVVd0FJWlhmbHpG?=
 =?utf-8?B?eFQyOTlyR1hVK1BVV3Z2Z1MwTHBNdUt4SGxTZEdIQzJzbFl3VVB2VjNSanVt?=
 =?utf-8?B?UlA1SXZhb2k2bEQ0bUFQSkZ5Q01BSXE5WTU5UDdVOHpRTGhQRjZYbEhjd1J5?=
 =?utf-8?B?aWY4cTVHbDRSSXplcDhRVFQ5dnc3TkppUFdPMkwwaHMrbEZUYXh6c1kraW0x?=
 =?utf-8?B?bE5xSWswemNUdk9ZblJhQVdobktEaG5UeHk2ajRaNHdxZHBSdDBSeU1UNEox?=
 =?utf-8?B?QzNVb1p2WDVIcU5WRVBNV2pPa1luc2Z1RXphdTRCTms4TS85QzIwSkxXbzVD?=
 =?utf-8?B?Y3VXNnEwaHJ1dmd2SVNnUUdkbkVSQlRiSVJxSVREOUdVcTlYbm9FYUlDTXky?=
 =?utf-8?B?a2YvYkdhTHRyTmpOZXhXZjVGMFl4NUhVeWZtdHhyWkphYzZ6b0FSTWJOZVJY?=
 =?utf-8?B?S3d2M0s5SDU2a040V3FOZXVuRzloTnNYTlBEQ2NmNExjNk4xcFE2K21zcmp6?=
 =?utf-8?B?WlYvSzZBaG5WOTIvaHBBQnRSL1U5Q1dBQURZTldEVldUakVRVE03K1dsYzJM?=
 =?utf-8?B?NXpiK1JUN2tBWm93cC96VEFvOGE4VGprYUovSjgwRDNJSkM0bWU2WGlMM0p5?=
 =?utf-8?B?VEN6d3pzbmhnREJXSkhLd0ZaaGlMLzlaNE9mWjlnOWNLMStDME1KRkM3YlQ0?=
 =?utf-8?B?aHNjVUh5QnUzRVVweGp6dVBiM3BOMGVrTEdpcC82OEtwaXprU05UdTRwSi9u?=
 =?utf-8?B?dmNTd3Q2M05kRkdMN2hmdmwrS1MzOUpjZlBBeHhSaEVELzlmYnBGVCtDZkpo?=
 =?utf-8?B?NjdoL3hxT29LWC90WkhGUjZnM2Q5K1hMYVVNbmU3TFByd3M2Q2FwMTc1V2xr?=
 =?utf-8?B?N2EyWG1BK1VFNnJKTEdnOG9RQ3BLWGprVzZCRkxPMTJuRVVmWlZpSjhpYzBy?=
 =?utf-8?B?eGIvTG9sRzRkeGJLSHFVTHgrSitKU09UcG1vUkNQaERGUFR6dmlKdGtXbTFz?=
 =?utf-8?B?YU9GWkZQKzFKSlJ3OTFFN0NJc3BVUHFNSmhpV05hUW9iMHhSRmlERFdpaXM5?=
 =?utf-8?B?TENVSVY5SWFLaGhHZTRCK3RlcWsxWW4yYjMzWXdjb2ZtOWdvR3RTZEJwUlpW?=
 =?utf-8?B?MHZCSUhmVHFMMG1oYWU0WERBTmNOeEhmZnhxSHR4N3JhVWhhY25TTGszRk9X?=
 =?utf-8?B?UGZqbitXckFRZ0VuQjdLMnZhMWRyY0dpaGNNYUlJU1VHeWhEdnBFTWxjY0Rr?=
 =?utf-8?B?MTRoOW5CdFhiZERvU3U3L1RlcjFtcnB1cG04ZDlCZSt6VXRRWVNZaFlKUCsw?=
 =?utf-8?B?bENlVWREK1RaWUl3cklRUUY4OHM0R0pkc0JzL1RLSUJyUlpQN1ZENDNKYjlh?=
 =?utf-8?B?a3RDakN4R0RJVlg1bEs1azBCRVloaWdsZmpQU0FSQ1B0ck5JdkdjNjg5b0JK?=
 =?utf-8?B?dThjYnFRWTg2YkJMTVdPK0lBVjhkenVHb2ZidDFxdzBnZlRIUTlUVWlOcUlp?=
 =?utf-8?B?YmRlL3JENnVlY3RuOEc2QXU5OFk4VGszdlltUk0rL1pWMUM5ekRpSmhBTFh0?=
 =?utf-8?Q?jiIRk+QJCEYm+05vTnFsYOw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjhmRVQ3ZWYvd3pzYmZkRlJBTXZwTkhMSFRMMkloQ3N5dE9aZjJxWW5tTlhl?=
 =?utf-8?B?cmVHa1pjYmJndXZNSFg3T2lqQlU0UkNwNHNyRllrdFhuUVBETjdHSjdLdW1m?=
 =?utf-8?B?bkxVNzlvazZFaDNaL0EweE8vcHppNmxLT0NHUkt5NENPRk1lSVNtUEpabzNt?=
 =?utf-8?B?bjZGQ0YzMU4vK25OeEs1ZnlIekRwcVlGZXpqS3hDUmhidjhkditwSVhRbFUz?=
 =?utf-8?B?WWV1SXJRVzNSRVdDSW9PN2RyMjBydHdiVTFjSTc2aU1sRXRwQ2xHWEVLWWFv?=
 =?utf-8?B?YTZQRGdoRERsL1psRW9BZjBJT1dkSHA0M2NReEo3MjRxMUwreWpaa3lxbGM1?=
 =?utf-8?B?UGhTRk1LNE14aTN2bHhPSnJodWVXTVdUT1VvdzRSZTV6Qzd6cGJDMVJOeVhO?=
 =?utf-8?B?Z1ZIak9DM09IU0FpTDdVcHdVY2lhY25MTVR0QnR0Zm5vY3drKzJMemNjaHNG?=
 =?utf-8?B?WjZ5eEx4d3liL3NxWk5sVE13bjdWazVLN2pnd1ltb3NtZmVyS0U1M3BhVEdS?=
 =?utf-8?B?N1JlbTZwTjhDbXUrZ3ZrbFV0TGVpQ3lGeElnQ1FZdUh5bndLb1l3SEFPbGtj?=
 =?utf-8?B?bFI1WWJVNzRSS0QyZ05kdGRNOUcyS0RxZ1pxSW9Qa0pWUlBXdy95a3hpUWda?=
 =?utf-8?B?WEtBcDJMNTVlNkJ3dlRhVkgrdWZqN1JDaHJqaTZxM0xnQXVHRDZYckVDVHNR?=
 =?utf-8?B?MVJLZStKcUxEWlNnRG1JV0hGUmRpZlpoTGM1RzlMYUFyYVc1c3UrQ1hvQmNW?=
 =?utf-8?B?ejd0SVY3QkFCUUFaTlg0ajllajRXanRHMXlWZVRTdDlDMzEzQ1F4Q2c1WWpX?=
 =?utf-8?B?eEZOb3BiUllCbXUxQ0k1TUsyK2g0TGRQZzYyUllvMmt3Vms1K094NE1RRCtY?=
 =?utf-8?B?Ykd0a05LMDRsUGRERWszQWJLbTNCbmpOMktyZEVYeHh6UllXTHRGSmtiNkZZ?=
 =?utf-8?B?M3hJNmt6Y3pjZEFpYWhjWEtoaU9YYThseE5jTnVVM2JReVNuYkh2MWFjSHha?=
 =?utf-8?B?NFF2MU85M0ZJWFhldkxwUW5vaTAvRE9HZlk5cEJmbnNDeU16Si90eVBYeXlr?=
 =?utf-8?B?ZjV4MERBSTF5Z2JaMlpJSWM2bVNDMVlxajdScUJ6dW5BNU41Q0dNNVk5MUM1?=
 =?utf-8?B?QkZ5N1pncnk0Y3pFRDB0eFVxS1Nhd2I1YXJOSnRLa01CcnJ6dkMxVlBiLzln?=
 =?utf-8?B?b2hqUnRmeVhvTmZXVHU5d2wzb0VHL3lEb01nWTBEckdDcDZMa0orWEVOT3ZC?=
 =?utf-8?B?VGFpZllHLytaK0l4VHNzdEh6cjhxTEcxL3ZNcTc0N0JiMFdSMmFsbkJLTGVP?=
 =?utf-8?B?aXRyVGRCRUhMaXZTZDFncW9XKzRuSG8wTWs3UERJOGFSNm5TVUpNS0ZMd2xC?=
 =?utf-8?B?WEdUdkx4cXczVXVFTGxIMVdIRCs2ZmVjSExySFFYNnIwQjZ3eTlrOUkxSDhx?=
 =?utf-8?B?ME5lY0xCd0NzK2dhbnIxb3FDVEFHSFhOYjVWYzhhN2VnUHI1NzRBQVZJUnl4?=
 =?utf-8?B?NDlnZzc1MXF0RWRXVGxqaThnRU1yTUdFMkl6VmhyVjNGMVU2cmF3TDQ5akxo?=
 =?utf-8?B?OHVoVWNpdENwdWxNWUduNWFvOHRnY2VYRWFpcVFwT2xsQ2JtdGVTQ1Jac3A4?=
 =?utf-8?B?eWZTWWRwV21WZXdtdDRxbUZPRkdRR0NwMzdUNDBxMHFXVjFqQVFXZkd0RlJZ?=
 =?utf-8?B?RHlVMndJS0VzMERRZEFYMjF5RmM0RGw4Nzh3YjNLMEU4cEhwTU13M1BKUWRO?=
 =?utf-8?B?YktDSjNpclpQdXZVYXNPWU1nVW5MekdocnZLRmpzZ1R0RjFYckVOSkpFZ3JF?=
 =?utf-8?B?RCs3a2ZzMGo0SEdQWGt2TzNHdVFKSTIyVkNXclhnTU5vcVFaMUNJb2ZqUXZj?=
 =?utf-8?B?WGlFTHNwWm15d29hck14OVE0THJNUlZvZmhpNkx0ZUlQVUlyM2VSSkN2ZUw3?=
 =?utf-8?B?dHRPcnJrdWJKbjBxa1BTdTBvSloxRjdnK2x3QXdXNmxMU3lEcnpqVkVob085?=
 =?utf-8?B?bHBXUlhVNWVlSk9HbmdXL014Uk5HTzJYakx2MWR6VnFLNkY4K3ExNTJvclNw?=
 =?utf-8?B?eWQ0d3M1eTIxZmNqSW1uaVlHMkp1dVZ2Sm5SWXIybmNTS3ROVFpJM2doMktK?=
 =?utf-8?B?bkxNdVRHb1NNUGU5djBGY1I3Y0U5NnVSR3pnK2RoQ0I3VllsdUJMMUgzMjBn?=
 =?utf-8?B?YWwvaDhFVmFBNHJIQUFJdWg4YlBrTVJxOWx4ZVRwRnNQU0FYL2VhZzdVNEZo?=
 =?utf-8?B?VkdCQVM0TzdBZDEwaU1Fa1RKT1JKQTRlL2FmWGRxTC9zVzBhQTY0WlU1UXRS?=
 =?utf-8?B?djcydVZjTkFKcFlSUVlFbzdza084UG1vMFhVQ1dNUGVSeWdKc0hoNVNSakU0?=
 =?utf-8?Q?RpDXgczOwhgdh+GODPVqLec4SmkXpEKGNAlP1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3DAD2DFD29D6649A7AB4988C3FF8AD4@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c91598-9b31-4f11-386f-08de592b0d19
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 20:24:17.1329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIAJC53BPt76I1CeuAJ8ncBO3GzN5XR4155a2wFYL4aRdC2umBigZGAaxncTXqRzcd2Ia4hBchGN3OjtjmH9fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFFB312818C
X-Proofpoint-GUID: RckenQdyP-E2GqgCx48VdlzSaYOc1CbR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDE2OSBTYWx0ZWRfXzoEtSOowPl5H
 Md2fE3Z93mUMFc95BAf07AcFpp7v9N3JkeNhjUb+OunDIO4QvvIeZfV2b05lHTVRnMmSN/H5T7j
 duwGqX6Lw3D0B3HgIKP5kgpLR1WoTy/YkVfG8eCPGXtcvB9KaEvHJaykHFC009qWIoSr7HPTnsM
 C4dgUDQV/yqebjLfrVqHrjsBFKVXpO6o997JQ0mAx5Gr5OHAbr3jw9JymHpKagGDFNHjTwx+xXp
 Doo4YsSF0WWGXa7djNkra/dyVZZXQKU1l0LdGI1wCncuNuBibhSgZz746qY8bFXcPAsovdVB4Hx
 flEb9mkhLWnTjsGd9Pmu1PPtilkSiNk5eEPV01okpoFeBQoMss5TP7qYXY6NS7XsC92aumI3a2t
 H6+n6gssroX/qyvE7P7o1Sq6UMjyW6sAcnOugUoHbCqEif/1JQx3kCCqHpD3oJYcv3m8FAcC7PZ
 1sXM2lr8S+e6G/N/FmQ==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=697135f4 cx=c_pps
 a=6cA/pxPA0XCUgbB+gUSklg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=5KLPUuaC_9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=nkuWdvzkExKtHNHgXKYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RPFLW4RuTBE3SmePUJpFe0LtPpmHZV6r
Subject: =?UTF-8?Q?Re:__=E7=AD=94=E5=A4=8D:__=E7=AD=94=E5=A4=8D:__=E7=AD=94?=
 =?UTF-8?Q?=E5=A4=8D:_=E3=80=90=E5=A4=96=E9=83=A8=E9=82=AE=E4=BB=B6!=E3=80=91?=
 =?UTF-8?Q?Re:__[PATCH_v2]_ceph:_fix_deadlock_in_ceph=5Freaddir=5Fprepopulate?=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601210169

T24gV2VkLCAyMDI2LTAxLTIxIGF0IDA3OjMzICswMDAwLCDmnY7no4ogd3JvdGU6DQo+IEhpIFNs
YXZhLA0KPiANCj4gWmhhbyBhbmQgSSBoYXZlIGZvdW5kIGEgd2F5IHRvIHJlcHJvZHVjZSB0aGlz
IGlzc3VlLiANCg0KU291bmRzIGdyZWF0IQ0KDQo+IA0KPiAxLiB0cnkgdG8gZmluZCAyIGRpZmZl
cmVudCBkaXJlY3RvcmllcyAoRElSX2EgRElSX2IpIGluIGEgY2VwaGZzIGNsdXN0ZXIgYW5kIG1h
a2Ugc3VyZSB0aGV5IGhhdmUgZGlmZmVyZW50IGF1dGggbWRzIG5vZGVzLiBJbiB0aGlzDQo+ICAg
ICB3YXksIGEgY2xpZW50IG1heSBoYXZlIGNoYW5jZXMgdG8gcnVuIGhhbmRsZV9yZXBseSBvbiBk
aWZmZXJlbnQgQ1BVIGZvciBvdXIgdGVzdCAoc2VlIHN0ZXAgNCBhbmQgc3RlcCA2KS4NCj4gMi4g
SW4gRElSX2IsIGNyZWF0ZSBhIGhhcmQgbGluayBvZiBESVJfYS9GSUxFX2EsIG5hbWVseSBGSUxF
X2IuIERJUl9hL0ZJTEVfYSBhbmQgRElSX2IvRklMRV9iIGhhdmUgdGhlIHNhbWUgaW5vICgxMjM0
NTYgZS5nKQ0KPiAzLiBTYXZlIGlubyBpbiBjb2RlIGJlbG93LCBtYWtlIGl0IHNsZWVwIGZvciBz
dGF0IGNvbW1hbmQuDQo+IGBgYA0KPiBAQCAtMzk1MCw2ICszOTUxLDEwIEBAIHN0YXRpYyB2b2lk
IGhhbmRsZV9yZXBseShzdHJ1Y3QgY2VwaF9tZHNfc2Vzc2lvbiAqc2Vzc2lvbiwgc3RydWN0IGNl
cGhfbXNnICptc2cpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0X2VycjsNCj4g
ICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgIHJlcS0+cl90YXJnZXRfaW5vZGUg
PSBpbjsNCj4gKyAgICAgICAgICAgICAgIGlmIChpbi0+aV9pbm8gPT0gMTIzNDU2KSB7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiaW5vZGUgJWx1IGZvdW5kLCByZWFkeSB0byB3
YWl0IDEwIHNlY29uZHMuXG4iLCBpbi0+aV9pbm8pOw0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBtc2xlZXAoMTAwMDApOw0KPiArICAgICAgICAgICAgICAgfQ0KPiBgYGANCj4gNC4gZWNobyAz
ID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzDQo+IDUuIGluIGEgc2hlbGwsIGRvIGBzdGF0IERJ
Ul9hL0ZJTEVfYWAsIHdlIHN1cHBvc2UgdG8gYmUgc3R1Y2sgb24gdGhpcyBzaGVsbCBiZWNhdXNl
IG9mIG1zbGVlcCgpIGluIGhhbmRsZV9yZXBseSgpLg0KPiA2LiBpbiB0aGUgb3RoZXIgc2hlbGws
IGRvIGBscyBESVJfYi9gIHRvIHRyaWdnZXIgY2VwaF9yZWFkZGlyX3ByZXBvcHVsYXRlKCkNCj4g
DQo+IFJlcGVhdCBzdGVwIDQgdG8gc3RlcCA2IGZvciBzZXZlcmFsIHRpbWVzICg1IHRpbWVzIGlz
IGVub3VnaCBJIGd1ZXNzKS4gQW5kIHdlJ2xsIHNlZSB0aGUgZGVhZGxvY2suDQo+IA0KDQpJIGFt
IGd1ZXNzaW5nLi4uIElzIGl0IHBvc3NpYmxlIHRvIGNyZWF0ZSBzb21lIENlcGggc3BlY2lmaWMg
dGVzdC1jYXNlIGluDQp4ZnN0ZXN0cyBzdWl0ZT8gSXQgd2lsbCBiZSBncmVhdCB0byBoYXZlIHNv
bWUgdGVzdC1jYXNlIG9yIHVuaXQtdGVzdCBmb3INCmNoZWNraW5nIHRoaXMgaXNzdWUgaW4gdGhl
IGZ1dHVyZS4NCg0KT0suIEkgc3VnZ2VzdCB0byBhZGQgdGhpcyByZXByb2R1Y3Rpb24gcGF0aCBh
bmQgb3RoZXIgYWxyZWFkeSBzaGFyZWQNCmV4cGxhbmF0aW9uL2FuYWx5c2lzIGludG8gY29tbWl0
IG1lc3NhZ2UgYW5kIHJlLXNlbmQgdGhlIHBhdGNoLiBDb3VsZCB5b3UgcGxlYXNlDQpzZW5kIHRo
ZSBuZXcgdmVyc2lvbiBvZiB0aGUgcGF0Y2g/DQoNClRoYW5rcywNClNsYXZhLiAgDQoNCj4gDQo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4g5Y+R5Lu25Lq6OiBW
aWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCj4g5Y+R6YCB5pe26Ze0
OiAyMDI25bm0MeaciDjml6UgMzo1OQ0KPiDmlLbku7bkuro6IOadjuejig0KPiDmioTpgIE6IEFs
ZXggTWFya3V6ZTsgaWRyeW9tb3ZAZ21haWwuY29tOyDlrZnmnJ07IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnDQo+IOS4u+mimDogUmU6ICDn
rZTlpI06ICDnrZTlpI06IOOAkOWklumDqOmCruS7tiHjgJFSZTogIFtQQVRDSCB2Ml0gY2VwaDog
Zml4IGRlYWRsb2NrIGluIGNlcGhfcmVhZGRpcl9wcmVwb3B1bGF0ZQ0KPiANCj4gT24gV2VkLCAy
MDI2LTAxLTA3IGF0IDE2OjAxICswMDAwLCDmnY7no4ogd3JvdGU6DQo+ID4gSGkgU2xhdmEsDQo+
ID4gDQo+ID4gVGhpcyBpc3N1ZSBpcyB2ZXJ5IHJhcmUgb24gb3VyIGludGVybmFsIGNlcGhmcyBj
bHVzdGVycy4gV2UgaGFkIG9ubHkgZW5jb3VudGVyZWQgaXQgZm9yIGFib3V0IHRocmVlIHRpbWVz
Lg0KPiA+IEJ1dCB3ZSBhcmUgd29ya2luZyBvbiBzYW1lIGhhY2tpbmcgbWV0aG9kcyB0byBzcGVl
ZCB1cCB0aGUgcmVwcm9kdWN0aW9uLiBJIHRoaW5rIGl0IHdpbGwgdGFrZSBtZSBvbmUgd2Vlaw0K
PiA+IGlmIGV2ZXJ5dGhpbmcgZ29lcyBzbW9vdGhseSBhbmQgSSB3aWxsIHNoYXJlIHRoZSBtZXRo
b2RzIGhlcmUuDQo+ID4gDQo+ID4gVG8gYmUgaG9uZXN0LCB0aGlzIHBhdGNoIHNob3VsZCBiZSBh
IHJldmVydCBwYXRjaCBvZiB0aGlzIG9uZToNCj4gPiANCj4gPiBjb21taXQgOiBiY2E5ZmMxNGM3
MGZjYmJlYmM4NDk1NGNjMzk5OTRlNDYzZmI5NDY4DQo+ID4gY2VwaDogd2hlbiBmaWxsaW5nIHRy
YWNlLCBjYWxsIGNlcGhfZ2V0X2lub2RlIG91dHNpZGUgb2YgbXV0ZXhlcw0KPiA+IA0KPiA+IEkn
bGwgcmVzZW5kIHRoaXMgcGF0Y2ggbGF0ZXIuDQo+IA0KPiBTb3VuZHMgZ29vZC4gSWYgSSByZW1l
bWJlciBjb3JyZWN0bHksIHRoZSBtYWluIGlzc3VlIHdpdGggdGhlIGluaXRpYWwgcGF0Y2ggd2Fz
DQo+IHRoZSBjb21taXQgbWVzc2FnZSB0aGF0IGRpZG4ndCBoYXZlIGdvb2QgZXhwbGFuYXRpb24g
b2YgdGhlIGlzc3VlIGFuZCB3aHkgdGhpcw0KPiByZXZlcnQgY2FuIGZpeCB0aGUgaXNzdWUuIFNv
LCBpZiB3ZSBoYXZlIGFsbCBvZiB0aGVzZSBkZXRhaWxzIGluIHRoZSBjb21taXQNCj4gbWVzc2Fn
ZSwgdGhlbiB0aGUgcGF0Y2ggc2hvdWxkIGJlIGluIGdvb2Qgc2hhcGUuDQo+IA0KPiBUaGFua3Ms
DQo+IFNsYXZhLg0K
