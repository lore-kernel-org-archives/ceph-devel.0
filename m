Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233E03446DA
	for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2026 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972182; cv=fail; b=nL8WPOId3uqLQLImklGdW92wCken0cb1qebM6Q1/DDz+h8ilLZ8MiVqRWGYaAuLkr3PIUQ494LHyI/09HSggWVI7bi8YN12jQqoN+mXnoxkkiSrJv99ugndr4V2MJHUyqmg3lGMLu0kxgdqZMfm1ZVMnJosw1S9apAHtJ7jMsBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972182; c=relaxed/simple;
	bh=MbtY0cFRIEJ1KPGX5O/grnVFN1oNjgYLoq6nyB/H6aI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=aSyxBNflhkTlen0Mh1z7KeTJaHsKJ8ChVwg6yWCNbjr2knWvuuCAB3+zzZ3JBtz8y7nfKM2p3qXVtX4mdk+oQ5QngElAoNODL5s6gAnydPynzgVD3WB3udqfKllyrUBe3T0Ddrg0oc4ZklJ/i90XPR/DtiF3DTLnlpoJ6KHAKgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g1FXL1zj; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g1FXL1zj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OKu25e2735258;
	Tue, 24 Feb 2026 22:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=MbtY0cFRIEJ1KPGX5O/grnVFN1oNjgYLoq6nyB/H6aI=; b=g1FXL1zj
	mXnRFLHN6ltM6TKrpl4kWRIw5tFWP36qv/xK4jPBM9wAUir5MpnVWJFzJSGuZLZH
	kYMAA8p2rQu9BW6au4P6LWfhdAjnnQHCRdJbc3M/J+yN3qbPJwZ4Gt/VRQoABW8W
	NfJVJn6HGHnf34VEtzzBJuwaAMwx+q9kol5Q/c5gSlHlpceRTCClBjwgxPpg0iPh
	tw4pDwvBN5shxqdusKqS14YQS0ta+3DJ/42nud8CNR1gM0kc+E7CMdLLLd4j1fjN
	wm1OG6BKHzIUkItoEfy7uB2082KVQRyY2dVC8Y5n5Fe0LFvuWJCvBDnQkgPC+F85
	20qcrl4M5P4Gqg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cqwrjh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 22:29:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqgS3BdZ5F3H9mVlIl9R6ZDo3Oc2xT7xrUElGr8a2LDEqa4ydFfF6aOTBkiSIfQhc28tjGsO2KA9QQ+NuSi613BAejEQRr/AwMt9hLv6UneIR0x1vicuXh7pElGpeEpvk064rcZMIAGFTYp4YHW2mBSoYTx43amQk5FzKp3ujFNtotEPVcHPD6z4DxDchM2mYxepB61D5D9w9XYj59P6HflRG/PmxQAGI90mwftYwpoqE2/zh/c0cIzxhl8jrYTUXewFRCDNgl1uFkadzm8MYFk8XvfgDY/AzRAfnDv3PzAV5Rl0CGuxM2Axy0FN1mOywfcEI+XWBh40QtVnBsx42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbtY0cFRIEJ1KPGX5O/grnVFN1oNjgYLoq6nyB/H6aI=;
 b=u4vMkFqiJ4wDYPdm8f57GGWhLH9WVjwFg7Bx9pVVbTLWyNOdl88ighwTEUzs04vmlDhlhAcZ9Ivw/8cIJymn0CUkPE2L+KZgfRWWS0nYJnkZHYYyu64fYTBYCSPj1Y+uX5OkOKUkZs/hDcZk9PP1m1N62pFbt0zN9xm0DExllL2XtIv8PdsXKWUY9JugBlK42FLvEECkXmSYdbfZaoLaeXOSsk3grs5WdiTGasIG2cTJZMBkkXRyawDaRMLfhvMGiP0oQFuYCX/CdlK0QXk1kcq8HtgdF2dynnkNMRrjw9embYvSPIEgO/z1gGVJO6KHkSdKhlezE0W+zJZjWjy5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ4PPF79F217BCC.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::8ae) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Tue, 24 Feb
 2026 22:29:28 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 22:29:27 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: Use u32 for non-negative values
 in ceph_monmap_decode()
Thread-Index: AQHcpdSn0ytv0S9Iek6xyX+2XViKl7WSbmcA
Date: Tue, 24 Feb 2026 22:29:27 +0000
Message-ID: <33b979d14984a7b12cda3fb6cc9471f742801c23.camel@ibm.com>
References: <95b6e21f-0bfd-4d39-93c1-757f3706590f@tu-ilmenau.de>
	 <03568ee4e42923e939a77b7d04244070122d89bd.camel@ibm.com>
	 <fd907fc2-8449-4576-82ec-43a8be28cc3a@tu-ilmenau.de>
In-Reply-To: <fd907fc2-8449-4576-82ec-43a8be28cc3a@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ4PPF79F217BCC:EE_
x-ms-office365-filtering-correlation-id: 5c267e25-788f-44af-392a-08de73f42b81
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnljWmxQL2RrY0NRSlBPNGkvYnVaeEk2aU1TNVUrTzJka0lhUmUrUHAzN2Ji?=
 =?utf-8?B?NkowZGh2VzczZ1ZmcG9XOFJ5R1lBenlaL3FsVjYzaW8zb1N0Z0NzRjBnZHVr?=
 =?utf-8?B?a2I0bm51QWFIMEZRNjkrdFFOQW1aRzNqU1BFWXQwaFBKK1VpMXVjTWZQTmd3?=
 =?utf-8?B?a0tERDd6Smp0OWRBWXVZQ290QlhGUE1pQVN4MFYrRVE4QW5WZUl5eE9qdlQ1?=
 =?utf-8?B?dU1tbnd0cnUvRElmaTZUdC85Z0FOVVRXUVVxQndkQllxNjg3Y0JaVVN6Z2xD?=
 =?utf-8?B?RkUxWlBFV1pjODRac3RUTjhsSEF3MWxqdDNXbjRXN1FiRzZBSlBJY3BaTGYx?=
 =?utf-8?B?N0M0aXBXRUJJV3dEQVcvR3lPc1dOdzU1SExJSDRPeEJXTzdsRFJmN3BRcHo0?=
 =?utf-8?B?cHlVMGl6d1ZNV0QxT21kdUorS2hZdkdzenpqWTdXYVRjNkZ0dFUzNjIweVZx?=
 =?utf-8?B?TDBLSG0vRVdpa0JNNE9kbGlxNzdGd1hmeFYxeWl5cXlHYTEvSnBjZEt3b0s2?=
 =?utf-8?B?cS9tY2FxVjJqeWQvMDExdktBUzJ6TmthNC9kOHVvWURTNE45UG90M1hCS01p?=
 =?utf-8?B?bVk1RlNrZFo2bGJDdHgwSGxuYmtTdE05TkJkUEQ4ZjhsNUNXa29YVFNsWlNH?=
 =?utf-8?B?R2ZHTERML2ZyRVlnNmhqbVNQNkF1STZhWmdxRVpEZDA0TENScUd0a3piMDUz?=
 =?utf-8?B?ZURBVVhvbGJ6dDhXVkVLeDVmN2crQmZBWFpvbXczOTRhWjg1c2YxK2h6YjM3?=
 =?utf-8?B?Q0pLdTVYcStxaEhHL1hOU3dCbTVQNDBJdFdwODVJVHErZktteWMrSVVmaEhr?=
 =?utf-8?B?NTYvaHRQRFFBZUFVeVQ3eWtyMlFUejNIcXhMTlBweUxKY0ZBNUJqL2RLVDhs?=
 =?utf-8?B?ZWd5YjdZY09WOGVxYTN3VGVEUjBTMTk4dnUzbzlHLzhkbDIyN1FydzBzcUtE?=
 =?utf-8?B?UVlXekRHcHdUVjNnT1laQ1ErWkhYejVLampSK28xQVdMRjlWVktNSlIwYXNI?=
 =?utf-8?B?YmprcFFjOFVaVmFiWUw4LzQwbEMvbFUwNmRZNnRCaVFacmtaSU1KaUlZZVQv?=
 =?utf-8?B?YWs1eXRQQ0kyTVpaZmMwU3h5bkNTcW5TY0hkMllJcFZGclF6Q25tNjR1YnJF?=
 =?utf-8?B?MXFxdjBaT0xpd1N4R1ZTeFM5VHR0OFdkZmtUSlAwbXlQZW8xQzJBUW14YVht?=
 =?utf-8?B?b3ljZVhER0JHOU1EYXhZRENPVVM4RkVkV2ZBWVNnWUFkOUlia2dOa1ppUjh6?=
 =?utf-8?B?WlhzZkdkRDFTK2ZDM2FQNVVBeStkcjc4Yk9GWUx2R2gwQU8yb25oZnFBMGEw?=
 =?utf-8?B?TXkzOEZ1NXpncGtzM2dmck8rbFVzbTZnM1JrSzVqOEtMSHEycE5xa2JyMm8y?=
 =?utf-8?B?WGRzb1U2TG8vUXdrL0lEMG0yYzlrNWNjM3V3OTZJdzEwclZQc2ZTZmMxd1Nz?=
 =?utf-8?B?V243OHUxa2MyZEtCd1NidDJLVG5GZ3dqQVk2K0Npa21HeHkxeGRZNmNjbHZp?=
 =?utf-8?B?bWRvMFlkTmk3WDZYZ2RTU0lSb3B2TmRMMmFiNER0ZGE0bzZkZmNGUHFmQ3Yv?=
 =?utf-8?B?R0ZaQVg5dlpRYU5kSXByWGkyc0dGOE1uWVRyNjFaWlYyYkpwYUdGTVpZM3Uv?=
 =?utf-8?B?eFU0SUJxQ0NPV1BXUnlRYmd5VE9wckZhc1VBbGp4RHBLTG1UOTJPenBNUW1h?=
 =?utf-8?B?OG4yMmVFT0ljblJDOWRvaEU5QWRuVzFMYXJWQkdoKzRxd3N4ZnVBRjg2UUd3?=
 =?utf-8?B?SjdVeEFrK1k1MVhEQjhxQVRNRHNqbHZuTEJzdXpnNVAzREowOTBOVGxqeHY2?=
 =?utf-8?B?Y1pGd1A5NmZFSWFqZmJ5ME5FRGx6NEdNQ2JSUGQxOHdXejhNNVZNblhvaWZF?=
 =?utf-8?B?NDdkU3pIMTM1d1dTdG02NWhBZ0pTaHcrY1Jsc3BPMWI4VmJRdlZUUHlmK0JG?=
 =?utf-8?B?c1BSWi80WXdlTTA5WWpVVkRNclBuSHUvcmdHUndwMExrZThCd2lRTHdYczc5?=
 =?utf-8?B?RkFPZUFSaHNCYjlWck1Dd1lQZkhxZ1NaaVNwQnhibWRlRzUybHkrS2h2MzVp?=
 =?utf-8?B?TTZCVEJGL1JhTEwyRGFCZ2tsQi9hNlJDS1JnMmxHc1ZGdnZHUkw2dk83M1RT?=
 =?utf-8?Q?z2tM0uc+3YPiSR9C/Cv9IAH6K?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVNKWnk0QlBDQlAwOXF2bjJVOWV1RzQxNis4WTBSR2xaRUQvWlJkSEtZbXJa?=
 =?utf-8?B?S01iMnZselpLWXd2am0zV25wTEtGU3FFTkQzRkN4MUVHd2RmWXZ2NHhGQjVJ?=
 =?utf-8?B?cCttYWhMSTROd3ZjMG1mbHVvNm0xMjR0dWtaZUxnbUt5V3kvMlAzYktJZkpy?=
 =?utf-8?B?Sm9aU3c5SXJiYXBlaTg3THpxV0EyM1ZJWkdKR0ZRK0JyK05SZDRzM1RXTDEy?=
 =?utf-8?B?SEhzYUhiUUdqZGNjTVo5cWtjVUs0Vk5LVWtFNjBjeU1CYXVram9RWDhSZW9p?=
 =?utf-8?B?ZzN0d0pPYVYxTkJ4TzVwVWoxbFhock1Ma3VCRDg4UGhZQmxHTzlVQTBqUTQ5?=
 =?utf-8?B?R05oOEJiQWNnZnBzMXhYWkt5M2lneDVrRUkxTC91WXhJQ0NZK0pjWHNmV2dQ?=
 =?utf-8?B?TG9KSXRCV3VMVUc3VHUreDd6NVNHTC9rb1Ezdk1ZS1JieFdKMlgwOGYza0NO?=
 =?utf-8?B?bHM0SXl0WW5wa3loZTNGL1FPd05UMzhET3kwOHBTRVJnbnVKc3dRK2grTVFu?=
 =?utf-8?B?UWhwb0s5OUtRVUFzS2M2QzRBaFBCVkxCeXpoY2xnWHhvOG0yQVIxTHBXQng1?=
 =?utf-8?B?TEJ6bUduM2lrUnJWcytMTUZuckZEMWVGMHlYdUJZT0dpbXJGN29JczRMRWo3?=
 =?utf-8?B?K2lycUJ4dTJpSnM0RWFoa21SeGNqdzBZWWpxUzZHTVl2Q2pCYjVYcmNkWkNo?=
 =?utf-8?B?cHIwc2FEd2s1aDdyME9LS1g2SHU3TUxiYUdFai9xNmZsQ1NGMXU2KzE3SGlY?=
 =?utf-8?B?aUtWSU5hMHJYYkxPa1oyQVQrbWlXNThMa3VFNHBmVGZwZWJtYmJ6ZjllWnVw?=
 =?utf-8?B?VitPY1B1cnFKazd4VEhnWFIyc01BSHRuQ3V1bXF2YXQ3KzYzb2FNcTk1cWxt?=
 =?utf-8?B?eHZuZjRaSFRFK2tlMk1GWVVrK3ZwUS9yeGhqZzE0cGx2cklWTzcycVM0ZG96?=
 =?utf-8?B?SkVLOGJ4cEk3MS9SL1V3NzFoaUQwNGhybGhrWFJpMWJmTU9iMVNkdzd0MmdF?=
 =?utf-8?B?TVJ0MlZKNVBzanpxQ1dZd25Wa210SzQrTW5BQTBoL2tmZExIOFBPR0JVNmFt?=
 =?utf-8?B?L1BDbFpuaHVGYit6V3B3R0NqZENFVFJYOEdiWVhkblZSazFHNEl4UXdzeDY3?=
 =?utf-8?B?ZFRoTlZzSjk0UGUzOFRwcmFoRU8zeU03dWlrYm50ckNsaXpvdnR3akxTMkU4?=
 =?utf-8?B?eUl2WEJsdkRzajBQa3ZsaTBzZmZLM1ZUQ09sUUEremtZdENGNkZjRkN5Sjln?=
 =?utf-8?B?eTgyMWp2SzhhWUFKS0RjdXBCYWpQc0V5MkVXclZ6c24ybDVMWWhxeExydzh6?=
 =?utf-8?B?TWRnOVNqOWxKMCtpMm1Wb2NMMkcrSGF0ZzlXZGRVODdNRU15L2NVLytiay9t?=
 =?utf-8?B?REZOa1p5MmU2Y0JhY2puLzdReHhvb3ExcklEekovWldpVlZub3pydXY5eEJK?=
 =?utf-8?B?ZW5CUS9CU0hNM0JXY1lZKzhQZE9zckx5V2tVenJYNTFCenRjZGtJanRqQysx?=
 =?utf-8?B?amJhd21ocTRGb042MUZMTGE4enlxVWhJNk9BbGd6SUptWnBlQWFhRHZSQzN2?=
 =?utf-8?B?MklHc0VtK2NjeDNNandwU0ZCMVk2c3hZYU8xcFBjL2czcEJsa0VXd3YyUVZn?=
 =?utf-8?B?UC9xK0ZFallTZ2NhWXk5WE5mRnZLMjRoajJ6SVhjVWJxNlVNS2dFYWM2YVZX?=
 =?utf-8?B?cllVV1pkeXdrS0x6YnUvbXB4UVcydzZId3VTK2lCV25JeGhOSjNsTmhhUHlL?=
 =?utf-8?B?Ty9UcGRPTG5mV2c0aUwwKzhUbk01bWxNQlVXZmFzdlpxdll5V0F2YVNmaWVP?=
 =?utf-8?B?bVR3QnFIb08wcTYwZ1hhY3krRjRRSVFmVnJ4VjFYSnlkSGpCckdLQWNiYXhG?=
 =?utf-8?B?ZWdxVC9xVFV2ZllVWStnMnZJUWdaR3RQN0I1SEZBLy9nOWVNcmk0MlpmRkMy?=
 =?utf-8?B?WlNJSU4yYk95K3Z0RjZ5ekdBOFY0UGJUKzZrMXViVmN1SVI4SGREWklCNTh0?=
 =?utf-8?B?YVVBT2pFU1M5bkFyZVVxY20zVnFGNnpuK3BsVjNQR1U2Y1QyTmZnb2xtbmcw?=
 =?utf-8?B?a0VwTk5YRG4xK2RXREppSGt1cGYrRnZEa3NSK2NzMnpBVEU3bVgySlpjREJl?=
 =?utf-8?B?L3M3RG5nN0J0Rk0zNEhxWjE5akgwNlRzRWZnc0hVTlkvOExjMlg1d3h5TFd6?=
 =?utf-8?B?ZVpaSWJkYjZZWWtya3VWd2F5NDhTQXpudnA2TWlrSElWNmQ1TkZSa0VXUit1?=
 =?utf-8?B?a1pyQkdXcVVJcnFLQWdPT0gzWXpNcEJlSVI1Zm1wSXdkS3ptR0JCM1I3S1Jl?=
 =?utf-8?B?WnJqZFZOeU00LzVIU0Q3NWpsOFk5dEQ4VGYzRWxyUGlIYnMxWjZwZUlpMkJB?=
 =?utf-8?Q?ZergVH0/xGffnVy+SmW8o11/mc0DYBmJd+I7f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9AF4DEB09C6864881DF24E183C19B17@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c267e25-788f-44af-392a-08de73f42b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 22:29:27.1995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzmf5fQzcSehJhbjkI/YBI9aIMX9O2RjAD5unVYbKskfyeC6hPqKsgF1se4FDW+1MQTehqSXuoUdVACrteyVOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF79F217BCC
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: BEJ--D2btHfyb6A0ZpB7z5uXaBFzsat6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE5NCBTYWx0ZWRfX7oG/s8U2tnlG
 MRc3O8+P8cwXj2sxLxH1Cp8tOd9fTpyZ1PxfF3MGntLSA+7HvEaYSEvUloLC0x1ck8jqOUSOl6D
 2Eqilf7o4CZolVRDfa3IxJbeqYzhRLjqCkF/n7q7ec1g0I1SyTVz6xxKqhjdHFvQfDNK4hDcBUS
 CVikMxlgHxm7FVt4VTBOdj41M0fBHBf6bdiJOQemSw2YOd9actw+mRjlS+7RDMY11zcc5X9EDiV
 KXYVC9Jwc4iHUamxhCZRktwuekW+rIMWfkb0fH2pwBIbMzdR2AWeeCjB+ZYuRIt90eXdBiZR/zq
 a5+uQbYWegtIwNPQrKHUWyEHAxNlAoVEFUjoT8V12cAtbMnsyIcQcNH/SJ5hfsLvOj7KlJo1T5L
 txgATSYH3lqbzmAe839MHIjscbhlerPT5+lR9TwrrnLMO3BT7JKuWMyihsGXnuGZB/CB/yHLiG/
 2ln5zppnEBQNseYzQyg==
X-Proofpoint-GUID: Ayhd2305cMuJfUrCiyKWdnbVY0PLaVJ8
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699e264c cx=c_pps
 a=OocfSUbDEXyHRS7ToLrH+Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=P-IC7800AAAA:8 a=6jkldolAB9IZ5I6zHQAA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
Subject: RE: [PATCH] libceph: Use u32 for non-negative values in
 ceph_monmap_decode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240194

SGkgUmFwaGFlbCwNCg0KT24gVHVlLCAyMDI2LTAyLTI0IGF0IDIyOjI5ICswMTAwLCBSYXBoYWVs
IFppbW1lciB3cm90ZToNCj4gT24gMi8yNC8yNiA4OjMxIFBNLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gT24gVHVlLCAyMDI2LTAyLTI0IGF0IDE2OjM4ICswMTAwLCBSYXBoYWVsIFpp
bW1lciB3cm90ZToNCj4gPiA+IFRoaXMgcGF0Y2ggZml4ZXMgdW5uZWNlc3NhcnkgaW1wbGljaXQg
Y29udmVyc2lvbnMgdGhhdCBjaGFuZ2Ugc2lnbmVkbmVzcw0KPiA+ID4gb2YgYmxvYl9sZW4gYW5k
IG51bV9tb24gaW4gY2VwaF9tb25tYXBfZGVjb2RlKCkuDQo+ID4gPiBDdXJyZW50bHkgYmxvYl9s
ZW4gYW5kIG51bV9tb24gYXJlIChzaWduZWQpIGludCB2YXJpYWJsZXMuIFRoZXkgYXJlIHVzZWQN
Cj4gPiA+IHRvIGhvbGQgdmFsdWVzIHRoYXQgYXJlIGFsd2F5cyBub24tbmVnYXRpdmUgYW5kIGdl
dCBhc3NpZ25lZCBpbg0KPiA+ID4gY2VwaF9kZWNvZGVfMzJfc2FmZSgpLCB3aGljaCBpcyBtZWFu
dCB0byBhc3NpZ24gdTMyIHZhbHVlcy4gQm90aA0KPiA+ID4gdmFyaWFibGVzIGFyZSBzdWJzZXF1
ZW50bHkgdXNlZCBhcyB1bnNpZ25lZCB2YWx1ZXMsIGFuZCB0aGUgdmFsdWUgb2YNCj4gPiA+IG51
bV9tb24gaXMgZnVydGhlciBhc3NpZ25lZCB0byBtb25tYXAtPm51bV9tb24sIHdoaWNoIGlzIG9m
IHR5cGUgdTMyLg0KPiA+ID4gVGhlcmVmb3JlLCBib3RoIHZhcmlhYmxlcyBzaG91bGQgYmUgb2Yg
dHlwZSB1MzIuIFRoaXMgaXMgZXNwZWNpYWxseQ0KPiA+ID4gcmVsZXZhbnQgZm9yIG51bV9tb24u
IElmIHRoZSB2YWx1ZSByZWFkIGZyb20gdGhlIGluY29taW5nIG1lc3NhZ2UgaXMNCj4gPiA+IHZl
cnkgbGFyZ2UsIGl0IGlzIGludGVycHJldGVkIGFzIGEgbmVnYXRpdmUgdmFsdWUsIGFuZCB0aGUg
Y2hlY2sgZm9yDQo+ID4gPiBudW1fbW9uID4gQ0VQSF9NQVhfTU9OIGluIGxpbmUgMTE3IGRvZXMg
bm90IGNhdGNoIGl0LiBUaGlzIGxlYWRzIHRvIHRoZQ0KPiA+ID4gYXR0ZW1wdCB0byBhbGxvY2F0
ZSBhIHZlcnkgbGFyZ2UgY2h1bmsgb2YgbWVtb3J5IGluIGxpbmUgMTIwLCB3aGljaCB3aWxsDQo+
ID4gPiBtb3N0IGxpa2VseSBmYWlsLiBJbiB0aGlzIGNhc2UsIGFuIHVubmVjZXNzYXJ5IGF0dGVt
cHQgdG8gYWxsb2NhdGUNCj4gPiA+IG1lbW9yeSBpcyBwZXJmb3JtZWQsIGFuZCAtRU5PTUVNIGlz
IHJldHVybmVkIGluc3RlYWQgb2YgLUVJTlZBTC4gRm9yDQo+ID4gPiBjb25zaXN0ZW5jeSwgdGhl
IHR5cGUgb2YgdmFyaWFibGUgaSBpcyBhbHNvIGNoYW5nZWQgdG8gdTMyLCBhcyBpdCBpcw0KPiA+
ID4gYWxzbyBvbmx5IHVzZWQgZm9yIG5vbi1uZWdhdGl2ZSB2YWx1ZXMuDQo+ID4gDQo+ID4gSSBh
Z3JlZSB0aGF0IGJsb2JfbGVuIGFuZCBudW1fbW9uIHNob3VsZCBiZSB1MzIgYmVjYXVzZSBpdCBt
YWtlcyB0aGUgY29kZSBtb3JlDQo+ID4gY29uc2lzdGVudC4gQnV0IGRvIHdlIHJlYWxseSBuZWVk
IHRvIGNoYW5nZSB0aGUgaSBjb3VudGVyIGZyb20gaW50IHRvIHUzMj8gV2UNCj4gPiBhcmUgdXNp
bmcgdGhpcyBjb3VudGVyIGhlcmUgWzFdLiBBbmQgd2UgY2hlY2sgdGhlIG51bV9tb24gaGVyZSBb
Ml0uIFNvLCBpdA0KPiA+IGNhbm5vdCBiZSBiaWdnZXIgdGhhbiAzMSBbM10uIFNvLCBpdCdzIGNv
bXBsZXRlbHkgc2FmZSB0byB1c2UgdGhlIGludGVnZXIgZGF0YQ0KPiA+IHR5cGUgZm9yIGNvdW50
ZXIuDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFNsYXZhLg0KPiA+IA0KPiBIaSBTbGF2YSwNCj4g
DQo+IEkgYWdyZWUgdGhhdCBpdCdzIGNvbXBsZXRlbHkgc2FmZSB0byBsZWF2ZSB0aGUgaSB2YXJp
YWJsZSBhcyBpbnRlZ2VyLiBJIA0KPiBpbmNsdWRlZCBpdCBiZWNhdXNlLCBmb3IgbWUsIGl0IGxv
b2tlZCBtb3JlIGNvbnNpc3RlbnQgdG8gdXNlIHRoZSBzYW1lIA0KPiBkYXRhIHR5cGUgZm9yIGFs
bCB2YXJpYWJsZXMgdGhhdCBhcmVuJ3Qgc3VwcG9zZWQgdG8gdGFrZSBuZWdhdGl2ZSANCj4gdmFs
dWVzLiBCdXQgaWYgeW91IHRoaW5rIGl0IHNob3VsZG4ndCBiZSBjaGFuZ2VkIHdpdGhvdXQgYSBz
cGVjaWZpYyANCj4gcmVhc29uLCBJIGNhbiBleGNsdWRlIGl0IGZyb20gdGhlIHBhdGNoLg0KPiAN
Cg0KSXQncyBub3QgcHJpbmNpcGFsIHBvaW50LiBCdXQsIHVzdWFsbHksIGV2ZXJ5Ym9keSB0cmVh
dHMgaSBjb3VudGVyIGFzIGludGVnZXINCmRhdGEgdHlwZS4gQW5kIGl0IGNvdWxkIGJlIHByaW5j
aXBhbCBpZiBzb21laG93IHRoaXMgY291bnRlciB3aWxsIGJlIHVzZWQgZm9yDQpkZWNyZW1lbnRp
bmcgKHJldmVyc2UgdHJhdmVyc2luZykuIE9wcG9zaXRlbHksIHUzMiBkYXRhIHR5cGUgd2lsbCBi
ZSB0aGUNCmNyaXRpY2FsIHBvaW50LCBpZiB3ZSBuZWVkIHRvIGFjY291bnRpbmcgc29tZXRoaW5n
IGJpZ2dlciB0aGFuIElOVF9NQVguIEhvd2V2ZXIsDQppdCdzIG5vdCB0aGUgY2FzZSBoZXJlLiBT
bywgSSBhc3N1bWUgdGhhdCBpdCB3aWxsIGJlIG1vcmUgc2FmZSB0byBrZWVwIHRoZSBpDQpjb3Vu
dGVyIGFzIGludGVnZXIgZGF0YSB0eXBlLg0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiBCZXN0IHJl
Z2FyZHMsDQo+IFJhcGhhZWwNCj4gDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJhcGhh
ZWwgWmltbWVyIDxyYXBoYWVsLnppbW1lckB0dS1pbG1lbmF1LmRlPg0KPiA+ID4gLS0tDQo+ID4g
PiAgICBuZXQvY2VwaC9tb25fY2xpZW50LmMgfCAxMCArKysrKy0tLS0tDQo+ID4gPiAgICAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4g
PiBkaWZmIC0tZ2l0IGEvbmV0L2NlcGgvbW9uX2NsaWVudC5jIGIvbmV0L2NlcGgvbW9uX2NsaWVu
dC5jDQo+ID4gPiBpbmRleCBmYThkZDJhMjBmN2QuLjhjZWQzYTkyOTdiMyAxMDA2NDQNCj4gPiA+
IC0tLSBhL25ldC9jZXBoL21vbl9jbGllbnQuYw0KPiA+ID4gKysrIGIvbmV0L2NlcGgvbW9uX2Ns
aWVudC5jDQo+ID4gPiBAQCAtNzIsMTIgKzcyLDEyIEBAIHN0YXRpYyBzdHJ1Y3QgY2VwaF9tb25t
YXAgKmNlcGhfbW9ubWFwX2RlY29kZSh2b2lkDQo+ID4gPiAqKnAsIHZvaWQgKmVuZCwgYm9vbCBt
c2dyMikNCj4gPiA+ICAgICAgICAgICBzdHJ1Y3QgY2VwaF9tb25tYXAgKm1vbm1hcCA9IE5VTEw7
DQo+ID4gPiAgICAgICAgICAgc3RydWN0IGNlcGhfZnNpZCBmc2lkOw0KPiA+ID4gICAgICAgICAg
IHUzMiBzdHJ1Y3RfbGVuOw0KPiA+ID4gLSAgICAgICBpbnQgYmxvYl9sZW47DQo+ID4gPiAtICAg
ICAgIGludCBudW1fbW9uOw0KPiA+ID4gKyAgICAgICB1MzIgYmxvYl9sZW47DQo+ID4gPiArICAg
ICAgIHUzMiBudW1fbW9uOw0KPiA+ID4gICAgICAgICAgIHU4IHN0cnVjdF92Ow0KPiA+ID4gICAg
ICAgICAgIHUzMiBlcG9jaDsNCj4gPiA+ICAgICAgICAgICBpbnQgcmV0Ow0KPiA+ID4gLSAgICAg
ICBpbnQgaTsNCj4gPiA+ICsgICAgICAgdTMyIGk7DQo+ID4gPiANCj4gPiA+ICAgICAgICAgICBj
ZXBoX2RlY29kZV8zMl9zYWZlKHAsIGVuZCwgYmxvYl9sZW4sIGVfaW52YWwpOw0KPiA+ID4gICAg
ICAgICAgIGNlcGhfZGVjb2RlX25lZWQocCwgZW5kLCBibG9iX2xlbiwgZV9pbnZhbCk7DQo+ID4g
PiBAQCAtMTEyLDcgKzExMiw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2VwaF9tb25tYXAgKmNlcGhfbW9u
bWFwX2RlY29kZSh2b2lkDQo+ID4gPiAqKnAsIHZvaWQgKmVuZCwgYm9vbCBtc2dyMikNCj4gPiA+
ICAgICAgICAgICB9DQo+ID4gPiAgICAgICAgICAgY2VwaF9kZWNvZGVfMzJfc2FmZShwLCBlbmQs
IG51bV9tb24sIGVfaW52YWwpOw0KPiA+ID4gDQo+ID4gPiAtICAgICAgIGRvdXQoIiVzIGZzaWQg
JXBVIGVwb2NoICV1IG51bV9tb24gJWRcbiIsIF9fZnVuY19fLCAmZnNpZCwgZXBvY2gsDQo+ID4g
PiArICAgICAgIGRvdXQoIiVzIGZzaWQgJXBVIGVwb2NoICV1IG51bV9tb24gJXVcbiIsIF9fZnVu
Y19fLCAmZnNpZCwgZXBvY2gsDQo+ID4gPiAgICAgICAgICAgICAgICBudW1fbW9uKTsNCj4gPiA+
ICAgICAgICAgICBpZiAobnVtX21vbiA+IENFUEhfTUFYX01PTikNCj4gPiA+ICAgICAgICAgICAg
ICAgICAgIGdvdG8gZV9pbnZhbDsNCj4gPiA+IEBAIC0xNDEsNyArMTQxLDcgQEAgc3RhdGljIHN0
cnVjdCBjZXBoX21vbm1hcCAqY2VwaF9tb25tYXBfZGVjb2RlKHZvaWQNCj4gPiA+ICoqcCwgdm9p
ZCAqZW5kLCBib29sIG1zZ3IyKQ0KPiA+ID4gICAgICAgICAgICAgICAgICAgaWYgKHJldCkNCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBmYWlsOw0KPiA+ID4gDQo+ID4gPiAt
ICAgICAgICAgICAgICAgZG91dCgiJXMgbW9uJWQgYWRkciAlc1xuIiwgX19mdW5jX18sIGksDQo+
ID4gPiArICAgICAgICAgICAgICAgZG91dCgiJXMgbW9uJXUgYWRkciAlc1xuIiwgX19mdW5jX18s
IGksDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgIGNlcGhfcHJfYWRkcigmaW5zdC0+YWRk
cikpOw0KPiA+ID4gICAgICAgICAgIH0NCj4gPiANCj4gPiBbMV0gaHR0cHM6Ly91cmxkZWZlbnNl
LnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19lbGl4aXIuYm9vdGxpbi5jb21fbGlu
dXhfdjYuMTktMkRyYzVfc291cmNlX25ldF9jZXBoX21vbi01RmNsaWVudC5jLTIzTDEzMCZkPUR3
SUNhUSZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhOSnUxX1JHbW5RMmZN
V0txNFk0UkFrRWx2VWdTczAwJm09V1dsNzM1akp1dnlpTEtjUnNJVWg5X3ZmY2VvcW1sM0xlaVF4
czkyLXE5YWlSZjJYOU9NNE5LdkZsaWJSWFI0TyZzPU1BMTRKV2pZNmpZQ1BCX1FKOGFjOVlseE40
eXAxX3JTSFEzZklzbkpmb1EmZT0gDQo+ID4gWzJdIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBv
aW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZWxpeGlyLmJvb3RsaW4uY29tX2xpbnV4X3Y2LjE5
LTJEcmM1X3NvdXJjZV9uZXRfY2VwaF9tb24tNUZjbGllbnQuYy0yM0wxMTcmZD1Ed0lDYVEmYz1C
U0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJmTVdLcTRZNFJB
a0VsdlVnU3MwMCZtPVdXbDczNWpKdXZ5aUxLY1JzSVVoOV92ZmNlb3FtbDNMZWlReHM5Mi1xOWFp
UmYyWDlPTTROS3ZGbGliUlhSNE8mcz00QlJDbjBGT0o5M192M3hndXNTb2RITndtM0wzcTBjWkxC
R053M1E5T1BZJmU9IA0KPiA+IFszXQ0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50
LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fZWxpeGlyLmJvb3RsaW4uY29tX2xpbnV4X3Y2LjE5LTJE
cmM1X3NvdXJjZV9pbmNsdWRlX2xpbnV4X2NlcGhfY2VwaC01RmZzLmgtMjNMMzUmZD1Ed0lDYVEm
Yz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJmTVdLcTRZ
NFJBa0VsdlVnU3MwMCZtPVdXbDczNWpKdXZ5aUxLY1JzSVVoOV92ZmNlb3FtbDNMZWlReHM5Mi1x
OWFpUmYyWDlPTTROS3ZGbGliUlhSNE8mcz1LNlJ2R1pxaFYzdHZyNk81NFRZN1FFVFExamE4RFNK
akw1emNJV0pKS3hrJmU9IA0K
