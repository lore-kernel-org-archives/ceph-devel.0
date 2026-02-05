Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82D1DFD96
	for <ceph-devel@vger.kernel.org>; Thu,  5 Feb 2026 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770332803; cv=fail; b=aP8oU7lgbw/e9tzPxyY4nFSNjDbosbhWpsKAhCRva1ifSDSjZZD93OtuBRExdW1oI7W96BQMmfZKzuOaVAZOf49ua1AzyrI4QIdokFRvZkZ8oAuahh74lzPEY19FAB3wZOrryIHoGM+ssh27RNQhTBAld80myPSE6E0Pi8H6iF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770332803; c=relaxed/simple;
	bh=VIs0UQ1ZnYAe187ZDfAXMzuwUpofHY0afPHM+xCQscM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g0I6XYELCIskt3UrUJ7qlk6UwNuZvkO0aJfrjZpkfghd65DGZZhbcGnto2XWh0jfFV3/zoCSetmrtaxB3E564Tdl98ljd9EwLWYQxwySdGb3CwWYJMg9M+sBOwRUqxpoBTqu2RbjGGzdywETBFU/O00P+5u8ZgngP17C0fat2bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FoG2htqj; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FoG2htqj"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 615Ltvdl006101
	for <ceph-devel@vger.kernel.org>; Thu, 5 Feb 2026 23:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=VIs0UQ1ZnYAe187ZDfAXMzuwUpofHY0afPHM+xCQscM=; b=FoG2htqj
	ZmDhVdxkun+vjjcowRftA7jVFxhTtHKkDLLiaIGzH8k4Gjvidw5k6M5g6aOqfPaY
	sXnDmNQdMtBELxDT3BM3wvG5sHi45UAH4KffiocaEdEppOliZIusxfThHsalf6ID
	wTrIOxtTQ0hlson124GwKB9qOJp6vaIEga37eZZ97xk37mBgeMqfSC/eh/PtaRDo
	omkfW+fOtQ57UIl6ZnVw3YgSgzmawJ4eofNG7OsuqiIWjI/8oxURELawFzIJBsv9
	B9/tJk+PlovKna9YjYLe8xcdHJjZBmQR5K8rkKwNJ3wBnJR3qVkCL9W7YReg/kiC
	Vk5l7JqDn2lWuA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013064.outbound.protection.outlook.com [40.93.201.64])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6s867-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 05 Feb 2026 23:06:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaiviX4PSi8gWnyx39hYKW+IZJvNNPih/6awaEDPL17vzpT041vqr1lBIoYVZ+OGFOxz/S5fj2y3n/0aKBI3R0hhIjxko6X1IPcWoieHhfnFXHeLyVTtOt1+RtvwkMIqldigzIjNdN4WFNblC0X4sS7j3NCm1CMjAneOCZvHL6x0WpDwFDlu8UuEFpLXhMLRROZdqm4mjymd8CtwvA++w5ortotQWvq8XORWRdctfxwiDFzDIEXhcK94kN3R4vqo0uSMCAGPWTt0q2FWAeVkpsuQM+SDgdpPsoH/oQh5C6OxdKVd2Y/SoR+hGuisaq/gYW0KVWxaUKSLelr42nM3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIs0UQ1ZnYAe187ZDfAXMzuwUpofHY0afPHM+xCQscM=;
 b=QzoesMFmxuTfg0ace1odQwb4CIkWhnGjNSzL/GWgrlz8iLcFPw+pQkMBKxEvOzwNvYE7YsCjEe4CpxLPqmYMDAtH364QPYIszb9mpmWzRLE/7GCj3dsk2XCbqwvWFNLGGMX1w8fH+0DdS2J5qNEU5uz3939Jt3PeW45sStjcrSa1CNRCnWq4dBEgTjx6Jshl+wlgfNVVUJxfC19hI6ahaZKm1pRTl4EaF8lMTTOqiK9rjp8sY5KciPuFbtcjCnQaUAsEr9GHGi84lxihOF0ZpVr6phQbi4GTE/3j4gSbBbEr39sNK9Pv6MYLEk5WTWqVmaAkWmpt1CBbnrVyCp2vbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB5511.namprd15.prod.outlook.com (2603:10b6:208:419::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 23:06:38 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 23:06:38 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ojaswin@linux.ibm.com" <ojaswin@linux.ibm.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
CC: Greg Farnum <gfarnum@ibm.com>, Patrick Donnelly <pdonnell@ibm.com>
Subject: Re: Exploring supporting fallocate() in ceph
Thread-Topic: Exploring supporting fallocate() in ceph
Thread-Index: AQHclfmmyvmNBelf3EmXDJYPlcs1G7V0vDWA
Date: Thu, 5 Feb 2026 23:06:38 +0000
Message-ID: <d0325ea755f153558ac2c8e8501a3cd9980b4ea8.camel@ibm.com>
References: <aYN-TBrwARmBBuHM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
In-Reply-To:
 <aYN-TBrwARmBBuHM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB5511:EE_
x-ms-office365-filtering-correlation-id: 1d42c623-f425-49ca-83b7-08de650b3765
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0V6VnoycjVkN0k0bzBOT25NdVBSZ3FENUtSMFpkczc5dUQ5Sk5RQ2VsRmd4?=
 =?utf-8?B?SkZiY3NiVFpYdnc3RHlob2NMNTZPMWlsMWdGMW5kMzNsMHdRTUJwT3FPZGhj?=
 =?utf-8?B?UVhSSUZIRVlqczZzYjJsZUVSeWdyNkprb3NyN1NZRU1Qb2VRVFI0M1BkV2RB?=
 =?utf-8?B?SCt4WVF6NjU1ekl4YlpVR2lPUEJSL1NyL3NFODVKUFBoc2lNUGVmWUIySUVV?=
 =?utf-8?B?TG4vTHNmVnU0bXVPUnJKMUxuWFk5TXpZNTRTUGRSK0dqeDhNZTg5WW1lQW1L?=
 =?utf-8?B?OERFcitNbjR1ejl3a0U3SUF3MWsrZUxVWUlGa21LS2VVcE5CZHlCQlJHbHNH?=
 =?utf-8?B?N1ZCcllLRkVKT3B2TGJnaGN1NDJhUEt5UERxdm9pVW5lbDhYdkU3S1lEZXI5?=
 =?utf-8?B?aVkvN0FzM051NE4ySEt0dDFobDVVMm0wY000dUdoOEdlRnNGRG5ZQXBBcWtv?=
 =?utf-8?B?Z0FDaGptTm5Nb2hyWnc2Slh5ZFBtUWI5KytWcXFzYVNPSHBNMG5xZmF5eGw1?=
 =?utf-8?B?c0RkMFg1ZlRpczJ2RW95dy93T1BRY0ZvUjBxR3J6SzVQTjBaNnlNWW8wNG96?=
 =?utf-8?B?NDc1NG4zVVYxaHhlbEJXTXpodTQySnNLK0VJeVovTXBQb1RsVmtqV1hDWDhx?=
 =?utf-8?B?OS8wS08reWhQbkpkek9kUWdnUVBURHJpbW8vUlZXbjZnVWZvTkEwdFRITXFY?=
 =?utf-8?B?ZFBYM3hnQWUya3VoeW1hRU55d1hUNlVrN0IwTHdWWG11RWJhVHV3Vlc3eERS?=
 =?utf-8?B?SGVoblZVY3NjMk5RdG9LSVZZTUhueFd5QWJ6dS9Dc2tYSEs1NmxTNmJXc3Av?=
 =?utf-8?B?WmpGQ3dxaTNQNWRVNEJ2WWtNTzdjekZFMlMreGMrRHNuVnJmTFNyRlRVNlA2?=
 =?utf-8?B?MWRZSHI2ZlNCQXIvTytJOEZDQ2hYcFNKVUJVTVY2Wk1mK0tSMGtnNXlZVkRu?=
 =?utf-8?B?aGFtRmhTV2pDSHBPMFo5TFZ6RlFONk1kbjhCL2hENC9xZVZpN2VtaDJkSUI0?=
 =?utf-8?B?TWpGS21UYUZwcWNQRUl3ZWJMZjhEb2oyWHI0UGt0Q1dpNHlyODVSWm5pWSsr?=
 =?utf-8?B?eUlVQVpBVENnMVNSd1ZZWTZLTmYwTXJhaTZXZk5NbVhKMG40dGZ4UldqZGky?=
 =?utf-8?B?anVHZnQ0aGx2TmwyM3B4WUxBa1dsSDgxY1RFMVVmZ3M0OFJtYjFHVXJTdE1Q?=
 =?utf-8?B?OFFEeVIrYW9sbzA1VURZVVVHZzdTajFPd1B6R1Y1aUR2TTZrYnhpc1E3TlpD?=
 =?utf-8?B?VFY1SVFTMWNYZU50d3FGd2JqdlFiQURVYXd2TnNRTnpzcnNZZE9zKzVTc0Zn?=
 =?utf-8?B?dXRxZVFic1dBUGM3OVlxb25ZQ1ZnanpCN0F0cmR1OGpFWDZvQldzUnprL3k1?=
 =?utf-8?B?R2dud3Y2Tmx3ZUU0RXAzcVYvNFovRGs1dkU4bUZBWk5Ha2tOSm9nOERJcnlq?=
 =?utf-8?B?L1FCakJ0bE9PcGs5SkNobXBGMkJmOGQzWm9nUGpSZWtNcjdXNjdjczVOV0hC?=
 =?utf-8?B?eDZicEN0blhmdWpSQk8zb2ptQ0k5SHNSZDhsekZONnhtOE5xNW1UTmc3K2g5?=
 =?utf-8?B?UkFPRXA5Z0FRYXdFQUtxRVBycTJ1Mkp0L0pRdThWRFBzUmZJOFh5b3V3eDc0?=
 =?utf-8?B?UDRGaHk4NW5YLzEycThQNWhsOUlHMjloQnM0S3QyZExnWnJDRGg3VjhNUTZj?=
 =?utf-8?B?Qi84NXFjR1VEN1NrRXZkM1JrMi9Cdit6QS9IQkpPc0ZQbGNYd0dnTFV1NU5R?=
 =?utf-8?B?Zlc0V0c2aHpoYUhrZytGT2Y0VG1tSUJxOVp3K0pxRmdOTGEvUERCVmxQSXVQ?=
 =?utf-8?B?VDFYdUhZZW5qcE9GbUp2RmhmZ253cEJsTGMvZ20rY0dpU1NoNHZNOE1NT2c4?=
 =?utf-8?B?NGhVempNMVdKdVNtZ0g1TjlOM2hlU0FZT0tkUGpnQzNrWCtmazFqWlRGV2U2?=
 =?utf-8?B?SXpSdkp5aHRxQitlOWNxb2tnQ1czemNwam42NlhEQmhsR0RsU1JmRGUrK1VM?=
 =?utf-8?B?MUYvNHhBcnh1Q0hrSEkyTFZWNVJCVEtFTFNHK3lYYTdKNGRkUUUxZmM4L2tm?=
 =?utf-8?B?dS9ZbWNja0NVc3dnNDRWTGJDb2ZCS0pLdWpOeXJoVlVGcGtEYk9LVWZXWklI?=
 =?utf-8?B?Q0EvWWYzTHVWcGluejQvU2lmQXJXOFFUMnkxcS9BTkFTeTFVemt6T0JNWlF2?=
 =?utf-8?Q?Cd12RkBohJ0Z2GDNhcOXR5w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEpYSkxqOUpiNmR6Q2tYTmNDZkVleUw5YUYxbnUvY2VBc0MvL2lSd3o5dUxY?=
 =?utf-8?B?M3p3eldlRUZoY240K2sycWl6MHRvbis4R0RSNHhQNCtWeHFKTTNaMkxBd2F6?=
 =?utf-8?B?K0YwMDdlY1RUZ1RFcnpOajIxVnZ3UGZXUXVybFlYTnI4NFhXdEVsYlkramxV?=
 =?utf-8?B?RlZGaGNXSWRHVmNmaG1JV0ZEemM3MFpEeFM3eGxKQlBhQUIvNWVITUYxQUxv?=
 =?utf-8?B?ZmJ1L3Q3TnV2ZjZ5SS9QY3dycmZHOXVSRHMxbHhrZDNRL09rRzd6SzZFdWM1?=
 =?utf-8?B?d1ZDMWVSTlJiN1hOR2tEL0xjWkpXQ1VZRGpGZml4WjJudGF6cmZZdzJNZWl0?=
 =?utf-8?B?NVVZZDErK2VwbTJNZVN2T1JhZ2JSTlpENnZtWjVxNGVINTBDVUJQdEtZd3p1?=
 =?utf-8?B?OUtwZzY0RFhQNklxemF0bkNncERMb2hPaFZFekZqS2RBSTBWTWxOL2dRa0pS?=
 =?utf-8?B?NktDN1ZKTVV0cWQyMnZJek5PQ3JoQ1FvZ2oxMFNvZGc3TTB0QkdxcmlLVDJN?=
 =?utf-8?B?M0VKK2ZSODRaM0ZqdzdWS1prNUFMbFFWU01jYXdsdll6L0Y5YVZCbnFiRFBl?=
 =?utf-8?B?TnV1L2c4V0k4a0MwN0FucVd0ajhabmZYMnRyTTZ0Z2Vka0F0d3pSZWpZYTI0?=
 =?utf-8?B?ZGQxcEFOUWF2eUw1WlJDbVJuVmZ0ekNSRDY1MFJSNmxuSzRCejN6SWE2d0hQ?=
 =?utf-8?B?OWlUakZjemJQSDd3ekVjNDg0RjcyRWl0SW1PT2wrcHpSWlBycmdJVTkwVDd0?=
 =?utf-8?B?eWtHckhZd1hCeDExck5IV21CVWpBSHRDZzMzTDZtVGlEM1F6ZnlKeHpIWmp3?=
 =?utf-8?B?UDJlNGdIbmFMWE1EMmVFZVk0dGVSbEZBZ085TWR4LytIbWdFUXdyQk92N2tE?=
 =?utf-8?B?ZnVFTUxsaEcrWnpKRXVyTXVDcHNYN0Y5L3BvcGsyWURXbHFmTzZscUN2WnZ0?=
 =?utf-8?B?bHk3emJadWIwVXNVQ0FDcFJqM3RCTEFaWFU1T0JJd1lYRXJyblFPKyt5SFhR?=
 =?utf-8?B?amZEcjdaT0kvV0ZQSS8wcURWUHFTOFB3NDhkZVBQZjBDd2dRRDZ3ZlVoajI1?=
 =?utf-8?B?NStreEdQZU9OTmpSWmJid3BJbnNTUFpwOWRha1RHQ3FMVlEzcXJlWFpCamc0?=
 =?utf-8?B?VGZMV2RPdnlsUjVBbkJhZXVQZTZYME9yUms5ajUzMmVLdmh0aDJGL1N5NmV0?=
 =?utf-8?B?MVpCVE8rYmE3OVlqRUljRkNUd3pKRW1KOGIvbU1BYUtUQi9FUFBnTld1RFFV?=
 =?utf-8?B?MTRkUExSNmF1ZEEyVW1KM1VCcFVlY2dka2VxbVZ3K2F3WG4rR3Y4NkFSRm1V?=
 =?utf-8?B?OGpUeDJqUmI5MWNKT01tNGtnQTFXL2dEazhaUkoybW81WkRtWlkzSHdaZzBH?=
 =?utf-8?B?LzhEMnFSbnVNWGlqMUR1czM4WXBzQmlhY3p2TWVoVVdZaytLMHlCai9OUFcw?=
 =?utf-8?B?NW9VaFhsY3RzdVFhaExJa05udkFYTDJ3TzZ3ck8yK2pUWVZtNzVKUVlKQjA2?=
 =?utf-8?B?RFJlVmhIeG9zVFFPWUNMWVQ0ZFMzUWprMDA5eC9lMGhJZ1IyMEM4TDA4NVlC?=
 =?utf-8?B?eFFBRnlnTXNvZDVsK2VoVi9pc2IzdHRvaUsvOUVpL2NwV0RDWUZ2S0Vmai9t?=
 =?utf-8?B?R09xMDRrbk0wWDJpdGxmRS9zZXZSN3hROWw5K2FlNnBwNUFzU1ZFUlVFREdD?=
 =?utf-8?B?elJHelcwSGUwMG10NUtWMmVEZnlLcEh4SDhIUWx4Vm5HNkE3ZUhkV01aaERS?=
 =?utf-8?B?TzYxcXQ0WTZvWHdKYjR4WUthTGI4VEZFZUNjMnFielNXSnByL0F4L3R0YmZQ?=
 =?utf-8?B?ckVjZldjS29PNUxEdFIyNTEyd0VZRDZTZGFLa2dnckI1WjV6a0xSUS9GajhJ?=
 =?utf-8?B?eXkzOGMvWjJYNUhnRk5lVFA5azdVYWVPbHM0UWhEekVTa3daK0dqQzc1NDZj?=
 =?utf-8?B?NExITjRSNFV4b21KVVRMMVBKS3RTSVNRNndGZ2JMYXZURldHc3RCOUtaTS9v?=
 =?utf-8?B?TTlxbzVORVdSa2F2MUk4enEvYWRqZnN6YzVBNzVuMUdkdmQ5MmlYNStJTk9a?=
 =?utf-8?B?MmdhcFRwNDZOaGEyeStydlRwa1p5b0F5MkVTcGNxT29DTEM0SVlSeGRQdWQw?=
 =?utf-8?B?eU9pbklNWi9xRkt3OXJINjJyNjdVRk1TUTExMERZL01oZjM1RUdwY0Z4N21L?=
 =?utf-8?B?b203K1JEaVhJT29CR2xaUE9lbzhTZWFhN2tvUDBIS3B1djRFUmJWaVdFMWZX?=
 =?utf-8?B?YXFLVXVlRFRGVEhOZXpTMFV0dGNmNTQwM013S0tEdGFqMjdDc0hLdEVGSmd3?=
 =?utf-8?B?eXcxbWlqRmdYTWt5Zkc3WTFsVlk3WFh6V0hwV3JvT0U3bGVyYStVcU1BbmZQ?=
 =?utf-8?Q?6hNERyLIORnW7t1PjIGQgX+NZlcnnv/wC4yfJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91AAE464B6C08F498D9AE11657D2DC6A@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d42c623-f425-49ca-83b7-08de650b3765
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 23:06:38.1095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6JjMYpb5lzpTtFAP3aoZ2KiHotPsB4eRheUnaNUPFsO/dMhD5h88DO5hbI++WFbNULWMKOvBkmjZUsWkSnX1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5511
X-Proofpoint-GUID: pCvARyFmnpYk8Cy_89U3O7T3PBD7Rq0W
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=69852281 cx=c_pps
 a=ff0lUGClKvTotTGlvMT8aw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=4u6H09k7AAAA:8 a=rapodAk7H_SXf8VwBKYA:9
 a=QEXdDO2ut3YA:10 a=5yerskEF2kbSkDMynNst:22
X-Proofpoint-ORIG-GUID: pCvARyFmnpYk8Cy_89U3O7T3PBD7Rq0W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE3NSBTYWx0ZWRfXxIrVGEDj901o
 0dOSCtDQWt2vjnS1j637Fc2dJoPF5xQSdPOjS5t44tywlWXfNSgQLlmZ2SG6+MDYwtBRB/Qi2Hj
 Oz+r/UF3FcQPGh/2PE8b5rb0Zn9XeUgmv3zV1qqOfAfWlOAbrrcH/NmeFssICG5C9DGlsW8MDw9
 9LEOjtOnlqS94zeDTPg540maUncdKHqWAcU6FtEiSd8svyKqyjCN0GHkSEtrEHe2sdZUkuSCSq7
 cvdeDPGUBFMkH91mGjYyT4dLdfrRItqFBXmmP+7v9y7qXNVQqF3op3lQBazK0YlQJ1ZVAJ7JV2P
 jv3WQfVXl9KC2n2NBcMPQ3bm1QEjnzpTycWIifbbmcePM1tBcxqSRcutU6vymxhfYcTu7PkVZDg
 snTKDG5wbpTSEn/InJVjrY+/wkzRMbxgRC+69x7gBC3TyOS2z4G6iVcBStw77GO05j1SRbCVTKH
 Z6OIleulH7tJV3exCMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_06,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050175

Y2MgUGF0cmljayBEb25uZWxseSBhbmQgR3JlZyBHcmVnIEZhcm51bQ0KDQpPbiBXZWQsIDIwMjYt
MDItMDQgYXQgMjI6NDMgKzA1MzAsIE9qYXN3aW4gTXVqb28gd3JvdGU6DQo+IEhpIHRlYW0sDQo+
IA0KPiBTbyBJJ3ZlIGJlZW4gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgY2VwaCBhbmQgY2VwaEZTIGFu
ZCBhcyBhIHBhcnQNCj4gb2YgdGhhdCBJIHRyaWVkIHJ1bm5pbmcgeGZzdGVzdHMgb24gY2VwaC4g
T25lIHRoaW5nIHRoYXQgc3Rvb2Qgb3V0IGltbWVkaWF0ZWx5DQo+IGlzIHRoZSBhbW91bnQgb2Yg
dGVzdHMgKH4xNTApIHRoYXQgd2Ugc2tpcCBqdXN0IGJlY2F1c2Ugd2UgZG9uJ3Qgc3VwcG9ydCAN
Cj4gZmFsbG9jYXRlKCkgYW5kIGZhbGxvY2F0ZShGQUxMT0NfRkxfWkVST19SQU5HRSkuIA0KPiAN
Cj4gVGhpbmtpbmcgaW4gdGhlIGRpcmVjdGlvbiBvZiB3aGF0IHdvdWxkIGl0IHRha2UgdG8gZW5h
YmxlIHRoaXMgaW4gY2VwaCwNCj4gSSBjYW1lIGFjcm9zcyBbMV0gd2hpY2ggc3VnZ2VzdHMgdGhh
dCB3ZSBkaXNhYmxlZCBmYWxsb2NhdGUgYmVjYXVzZQ0KPiBpdCB3YXMgbm90IHRyaXZpYWwgdG8g
bWFrZSB0aGUgc3BhY2UgcmVzZXJ2YXRpb25zIGtub3duIHRvIGNlcGguDQo+IA0KPiBTZWVpbmcg
aG93IGZhbGxvY2F0ZSBpcyBhbiBvcGVyYXRpb24gY29tbW9ubHkgdXNlZCBieSBhcHBsaWNhdGlv
bnMgZm9yIHZhcmlvdXMNCj4gdGFza3MsIEknbSBqdXN0IHdvbmRlcmluZyB0aGF0IHdvdWxkIGl0
IG1ha2Ugc2Vuc2UgdG8gZXhwbG9yZSB0aGUgcG9zc2libGl0eSBvZg0KPiBlbmFibGluZyBmYWxs
b2NhdGUoKSBhbmQgRkFMTE9DX0ZMX1pFUk9fUkFOR0UgYWdhaW4gaW4gY2VwaC4gQSBmZXcgYXBw
cm9hY2hlcw0KPiB0aGF0IEkgY2FuIHRoaW5rIG9mIGFyZToNCj4gDQo+IDEuIEV4cGxpY2l0bHkg
d3JpdGUgemVyb2VzIHRvIHJlc2VydmUgc3BhY2UuIFRoaXMgaXMgbm90IGlkZWFsIG9yIHBlcmZv
cm1hbnQNCj4gYnV0IG1heWJlIHdpdGggbW9yZSBhbmQgbW9yZSBoYXJkd2FyZSBzdXBwb3J0aW5n
IG9wdGltaXplZCB6ZXJvaW5nIGxpa2UNCj4gbnZtZSBXUklURV9aRVJPIG9yIHNjc2kgV1JJVEVf
U0FNRSBjb21tYW5kcywgdGhpcyBtaWdodCBub3QgYmUgdGhhdCBiYWQuDQo+IEFsc28sIGl0IGNh
biBiZSBhcmd1ZWQgdGhhdCB0aGlzIG1pZ2h0IGJlIGJldHRlciB0aGFuIG5vdCBoYXZpbmcgYW55
dGhpbmcgYXQNCj4gYWxsPw0KPiANCg0KSSB0aGluayBpdCBpcyBub3QgZ29vZCBpZGVhLiA6KSBC
ZWNhdXNlLCBzdG9yaW5nIHplcm9zIGFuZCBrZWVwaW5nIHplcm9zIGluDQpzdG9yYWdlIGRldmlj
ZSBpcyBub3QgdmVyeSBnb29kIGFwcHJvYWNoLiBFc3BlY2lhbGx5LCBpdCBpcyBub3QgZ29vZCBm
b3IgU1NEcy4NCg0KPiAyLiBTaW5jZSB0aGUgaXNzdWUgdHJhY2tlciBpcyA3IHllYXJzIG9sZCwg
SSdtIGp1c3Qgd29uZGVyaW5nIGlmIGl0IGlzIHdvcnRoDQo+IGxvb2tpbmcgYXQgdGhlIGNlcGgg
aW5mcmEgdG8gc2VlIGlmIHdlIGNhbiBzdXBwb3J0IGZhbGxvY2F0ZSBpbiBhbiBhbHRlcm5hdGUg
DQo+IHdheS4NCj4gDQoNClBhdHJpY2ssIEdyZWcsDQoNCldoYXQgaXMgb3VyIHBvc2l0aW9uIHJl
bGF0ZWQgdG8gRkFMTE9DQVRFPyBXaHkgaGF2ZSB3ZSBkaXNhYmxlIGl0Pw0KDQpUaGFua3MsDQpT
bGF2YS4NCg0KPiBJIHdvdWxkIGJlIGludGVyZXN0ZWQgaW4gZXhwbG9yaW5nIHRoaXMgaG93ZXZl
ciBzaW5jZSBJJ20gbmV3IHRvIGNlcGggSSBqdXN0IA0KPiB3YW50IHRvIHJlYWNoIGZvciBhbnkg
aW5zaWdodHMgb3IgcG9pbnRlcnMgZnJvbSB0aGUgY29tbXVuaXR5Lg0KPiANCj4gY2MgQFNsYXZh
IHNpbmNlIGhlIGhhcyBiZWVuIGhlbHBpbmcgbWUgb3V0IHdpdGggY2VwaA0KPiANCj4gWzFdIGh0
dHBzOi8vdHJhY2tlci5jZXBoLmNvbS9pc3N1ZXMvMzYzMTcNCj4gDQo+IFJlZ2FyZHMsDQo+IG9q
YXN3aW4NCg==
