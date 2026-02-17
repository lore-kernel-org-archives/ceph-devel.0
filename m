Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECADA3002CF;
	Tue, 17 Feb 2026 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365157; cv=fail; b=FOdeQpQe43J3KVJ2qq/AWWQnwz1pdFZUx6wVYRu/VHm/1TqFYLIpUNPMhvLM/rsCuEkim/o1uA4R+rCfUOG2AhLzzgK6bLWD0U/Gs6SpsK5QW1UNoF3/47NaUItHLgpPuGYyPx1+wCROAPRa5fuCqpsX3ExYCtIG0+anWtzFsWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365157; c=relaxed/simple;
	bh=LU+aarj0MT+ewYu2z265eDtuSDCemmfQMY5y4NfiI9g=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qEH0LD8qYltyo0q8bD10WcusAsvIE0lUX2bp3RLthg7vd4uh4OngYrLi9n3vebWXGBqR1i/hN/v1LDepnL5p4CE7bq/7vJ3BCs1eu9tv3h0r8eS6+LMuw7uOZK8wgKWaEyxFNuhnSTXh9Q4R2aZv32DDHMP9xTZVLHnHGM2OCEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=So0O2Dnp; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="So0O2Dnp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HJHFUn3665841;
	Tue, 17 Feb 2026 21:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=LU+aarj0MT+ewYu2z265eDtuSDCemmfQMY5y4NfiI9g=; b=So0O2Dnp
	mjx6WbzIk5AD73Bgv1GCLdNd67r7lIxjDWSLVaqqD+gsACcOvWf2Du6RvE0sGNjB
	6N1cIPWIQaKEnSspzvbbSyqAmruXxbkboWV0pKaUXwFZMdEs//YCancna3OV1HuZ
	9CWcZJIu6Jp0q/U4NLuAksIadb7wBMCpSGuIt7K+pDb01+nMpHEvgTY5rGh8qQhp
	0n3WyjIMuWGrt0qY8pP+LH2n+jSxK593/huV93Ihk+riQXiSuRro7/B6bc0DDHHG
	a3EO5vfrDQkaweb18J7cCzKM1dpjZ8SzRDmZ89rU+aU+Rq2jLdvO19gw8hcl/jdK
	17Nn0F3CLacPQA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj645s9j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 21:52:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sapg1A7XhBk6mNo4OYMlmxZM/bo/PoBRErclCCkBETNygn73Z1rV86IyS6l0dLXYNJD3ARypFocEReZrxavIoC4BU9KYoGT6YPfxlDzeuMKBMaMOYCbZXKq6Dz6NeYX3y0Yoe9AZ2L8saWfGysph8jVFOSNWTnIYfzfGmSCJ7W55HxCugZywCcw7yOvLiUMOjPcziI1qsuFKuWk0+Zl+pQZGCvHMOjefWqs5B4ZL/KlbEEje4BY2Pdi1Rp1wHpGlIF9Mld8EXO+Cn/jbs1xZaH/oJZK/L2WCJ7J1pQG3Qwt5iFIkd4s/QrVBWy579c8ZhdqwFZtzbXgTrDLe/SIWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU+aarj0MT+ewYu2z265eDtuSDCemmfQMY5y4NfiI9g=;
 b=XDLTKYu5dqZdrLutMsq6dFDeea8Masa7wYADGDeaTnbsjqgJy7tUYT6E1eL3Ej1zwE6a+Jy6jNTxrgWCNhY8vRbZlSyL1Abb3HtkAGF3xflGO7OzDBuYva6JbrzzLt7+hPYnjlYOf4swopbY/daE6jXLcAA3QDBbqS7w1LXrWkSySbopIUxJzdyiacp4OIS04Cy/rdt8FPB6o0w5qLUxE41SFbiZTgX67g+Tyi7oQwO+Fz2cGHy9KBbZtbtt1x+zCKsnlDrLWD4rurt26ofnEmKx5OdDpug7xU7xgj5Sz7RMUC9SYfCb7lwB4zly0Gs+EBC9KnQegkoczq0sUuLllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4719.namprd15.prod.outlook.com (2603:10b6:510:8d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 21:52:00 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 21:52:00 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "ionut.nechita@windriver.com"
	<ionut.nechita@windriver.com>
CC: "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>,
        "sage@newdream.net"
	<sage@newdream.net>, Xiubo Li <xiubli@redhat.com>,
        "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
        "jkosina@suse.com" <jkosina@suse.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Alex Markuze <amarkuze@redhat.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>,
        "clrkwllms@kernel.org" <clrkwllms@kernel.org>,
        "superm1@kernel.org" <superm1@kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: add timeout protection to
 ceph_mdsc_sync() path
Thread-Index: AQHcnL2tgXlJSMDACkeX8MuLfGlFGrWHdcyA
Date: Tue, 17 Feb 2026 21:52:00 +0000
Message-ID: <fe346c26386a4fc85cfa27e669dffd13191e7ea4.camel@ibm.com>
References: <20260208131819.37276-2-ionut.nechita@windriver.com>
	 <20260213075111.32886-2-ionut.nechita@windriver.com>
In-Reply-To: <20260213075111.32886-2-ionut.nechita@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4719:EE_
x-ms-office365-filtering-correlation-id: 2ac51f75-729b-428c-4898-08de6e6ec76b
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2Z3TitLc2hwd09JYXdlamNtL1Vaa2RTT0NCMFlBK3VSTFJFU3NrMDFNVlpT?=
 =?utf-8?B?TEdXcGkvL0RGT1FDZVVXcm90RHNES1VNVVVVSk9sNytlZnpSU2g0R3g1M0Nr?=
 =?utf-8?B?SDdIdCsvZ0JiRWRVZ00xUmR5MHZzOXcwYklCVlJSQnJwUVdzT2N2cll5SC8y?=
 =?utf-8?B?aWNSVU5pVmtnVktvcWRJdlRZdUhycnhGM2cweWIvbVhtcEpMODl0b2paeVVS?=
 =?utf-8?B?aHNPZUdKN0gyTmYyZTZTd0dsai9YVkVDSythQzJtbG1LV29HeFRaZUR6SXZ5?=
 =?utf-8?B?R29pZDRxN25MdVNQWW0xTmlNY3AzVmRnSWNuZTJsYXl3bzdMSEkwMkR4WXdP?=
 =?utf-8?B?VTdUTVNxWWowRUY2MkVDUU43cXUwQzY2S1I4T0NLdFdxS2ptd3Y3OWFlc3hI?=
 =?utf-8?B?R3oxNXJTYncxcEZ2QytBdnJDRnhQZTdFT1E2QUtWL1lnSUpxTElJN0t2V3Er?=
 =?utf-8?B?WngyVzc5NFI2cUJFZ04zL01wa0pmY2MxNkJIZUxPaEFjQzJrV01yNjl4djcv?=
 =?utf-8?B?YmlOME9YL2l4a1JNNmxjOEl5LzFPYkJlclpwVjF4ZFloTWRwL2ZtdW4rSis0?=
 =?utf-8?B?T05aaVlxemNSRlg4RWFwZlpnL2EzMDh2a1BwR0N1OEZuR0ZVZkNYay9OWisr?=
 =?utf-8?B?T1U2a0RzMEd4Y3Ewb0VlR1pWL3I3Si9YdlQ4R1lSdXJEVnNTdlRselEvZE1X?=
 =?utf-8?B?ZmdIOGxibjFOL2FQbHBHV1M2YWpaNGNzZkZuSFRNenhJZ2IzZlo1YkRzR1Jq?=
 =?utf-8?B?SmNEUjVxVDZqVVlOUXc4Y1FuenVadFVDdENrZzhPTHFGVVdaVzFwSFg1OE1G?=
 =?utf-8?B?T1hFdDZETytmR1hjdU9uK1dJaERLdlFpVWVoSGJkdDA1bkFVSHhiaUREYXFH?=
 =?utf-8?B?K1dyWmV6Z2FOYzdtZ3M4TmV5L2R5OGRLMEVwcmI4aHhvKy9NOEpqRWJycUha?=
 =?utf-8?B?NDRRMFp5N2RLMFh0MFJrV0MxUW55VXVvbGIwOUVtVk5vTU42M1FwaGFjTWFY?=
 =?utf-8?B?T245N1QwQmQ4ZjVHL0FQT295WG5CWjlMY0RqSjZEbHlnNHh3QXFjMW5ENnFW?=
 =?utf-8?B?WUhTYlAreGNnM2Y2M2tTcHVnK2N3RHlOQ1MwbENqL1lkcEY4M1hPM3JtbkZj?=
 =?utf-8?B?dklpeFBLeHd1VEdWdi9hN0NpWHNhaEkyV3dOV0ZyR0cycno4R3Z5MnNXWlFv?=
 =?utf-8?B?VEpTOUpyS2N6dU5kanhyVytvc1U2ajJQaDlUVTJQQjVSbmNIZE55aDBXTUM4?=
 =?utf-8?B?UEZxSitvV1YzT29MdDVKSjVsdE83M0VPbEVQTktzK04xVGI1dWNaSWFLWjhS?=
 =?utf-8?B?Q1d2YlZoTVBodlJSR2xkbHhZdG9sUmVHRlVMRDdwdzhtNmJCOGRpZjlOcEo1?=
 =?utf-8?B?OVhjVE1sNHNDSVV3eU9IR1ZZMDBEMW93K00vcnYweTN4aCtxR1JaZk1FQ21R?=
 =?utf-8?B?My9rQVhSLzA5dHdwUnk5M2lKNFpjVGN2M0duT1dwd0pyYkVEK3k1SGszSFJV?=
 =?utf-8?B?Tjd0VUEwWmMrVEJhZEhKZk9kdU16MEFwc1BDN2RiUWc4TkdjQ1FsaWJuM083?=
 =?utf-8?B?TlFYeVJOOTZtdldjNkx5Wlg4VWtoQ1N0N3k3REZMUzVxV3RiTU5QR3o4dnVx?=
 =?utf-8?B?ZnZpMVpjbGI2cmZ2SmZrNFhJRHhXK01pS2VBL1B6TExTOS83dmdUU0xIYk92?=
 =?utf-8?B?WUhvZ3NFMU5Pc1I2UmR5YWQ3cGw5dEpKeHdmQWlVeWwwYmp5VU1NbWF2dU5G?=
 =?utf-8?B?TUc3YTZ5YWZ5VnNEb0VTa3kra2REL0NodjJxSTdqUzRxbUtuYWp1YktpUG9l?=
 =?utf-8?B?WVNOODl3b29vcldLTlFXZG1mak5pMnFlSDA3R0FTcUxIYWVqOUJNbkFpaUVH?=
 =?utf-8?B?elVjTGo1VXBpZmliUEc3UWROWjBaMUIvNFR2VkJTMWczMkp6RTlBU256dXVR?=
 =?utf-8?B?U0M0Z0hkZmlJQjFHeFZGYnpIWU5xeEU1NElBbDh5MVBvSCsrRC94SWVhTnB1?=
 =?utf-8?B?N0JwVHhqSW1aL01JYVB6djY5UzdFWFBHNHhPY1ZiVkxKM3NnV1hqVmZwNjdP?=
 =?utf-8?B?R214eE1nRzNJbGI0K2dLT0NJRXpGM1piQkxZRW9hQ2pUZ0dEemJ6MDJuZ0pr?=
 =?utf-8?B?ZXRaZGJ6NXR3NnFPeHRLVXJRelpaWEoyR05VTkpTK1lBdG1FdEl1eXB0cFZr?=
 =?utf-8?Q?lfdxuxlKjGDpnyOHtfz0+0I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUZGSDYxMWtiVDk5RElpRVVMTDlUUWhUcjVhSFg3dFFzSnZOUE1aYWNSbWd2?=
 =?utf-8?B?MzZSam5NNUZMcWJBNG8rZ1pmMmY1cHc0OU5Uc09PclZXOFRFaXc1cTU3Qitz?=
 =?utf-8?B?REkrWnRSTEFNdW4zcVlsTi9yaU15ZFd2bUZ4b3dvZmtDMGNtdEdFd1FPQ05R?=
 =?utf-8?B?MEpzZGNmT3kwVGV5ZkljZi9tSDU4aitQc1Q0eXRzb3lnTklKM0FvVXZrSWYr?=
 =?utf-8?B?ak8zMlB1MFpxSVRYTjMrR3J1NHJmaWxVY0hyMS9BdGJsU2o4Rk9rZjJyZmc2?=
 =?utf-8?B?bGNWT2Y4RzBEcis3c2xqZWhLL0oyTVFjSm9IOVVWaUlvZEZsdWE0bUZWaEtL?=
 =?utf-8?B?YjM2MXBrVm9IMkhNZWZYTU5tbEZFSXp4enZXS2VwNC9Tdm9CcGx0MWJVQTZ1?=
 =?utf-8?B?QlZOTC9JbEIyYmFOVVpwY09zMmNvWURnb2JkNWFhWHVPYUZzenlxRTlsYlZl?=
 =?utf-8?B?Q3BFMDl3Q0Nnc3NzaVJyRDBSSE5EL1J0VDBHRk9PRFhCSExMWG9FeUo3NUZH?=
 =?utf-8?B?Zmp1MkN4QXBIem5xdVN6M2p2QTg5bGFGc25JbFF5ZHlYT21xK1RLaGp5ZU9U?=
 =?utf-8?B?RE9oTkpHN2lGUnJhRExOYUc0VWFCQmNac3p6cDh4MGdMc200NGRKakoxUjY3?=
 =?utf-8?B?ZXNiYnJwMUtaTFNBSHJXb0U2bXE4aDRsYlFxNlhYd2JEQlBBRDhQd3NpVmpO?=
 =?utf-8?B?VlBqNGp5eWJCRG1QcTM0YWpPbWRiUnBaSzlwZ3VIaE9XcjFuUUdwSStKYUVB?=
 =?utf-8?B?czhucE9QMFl2elBvc0l5WFhBd1pDRTY3cGhMcG1TZW5UQ1RHd05wZ01TTUQx?=
 =?utf-8?B?dm5kYkkxOHRxUnNZUHQ3bnk3WkV1NWd5Nmx6d3pHdzVCR1VEU1ArZkRhWW1J?=
 =?utf-8?B?NXhTdHFCMVBHY3c4OUNXWjhBQXN6MVgzVDVPTmZMVC9KNUZTdUN0M1VMRjdX?=
 =?utf-8?B?c3F3YUlwQURpdnIyOGl6NkExNzlyZFBSaDZUTnczTm1uL3NwU0RQUEtQdlg4?=
 =?utf-8?B?WnZXbXBSZmV2Y3BYOUE0eHg3T0x3c293R0xBRTNSckpOZ0NnUkUxNTZCY3oy?=
 =?utf-8?B?dHRRa3lyL1pmaVBMczFza2gxVXZzYjkzMk1Vb1A0TGpnZzNZclUyUitKRmpz?=
 =?utf-8?B?TW9Sa3RQV29ySlhRRVNlZ1lSL1ZTQXg3ZjZkNEhQMytNdERDRjNYNGtibk8v?=
 =?utf-8?B?djByMWR4Nmx0NnBVaEttUDl1V1Vrd05TUGR1SmRRTmdwUXdzVzltNGtyL0dC?=
 =?utf-8?B?TnhRVEhxQmdqa2FLbGMzWHRKVHJ6a21IT1RSbWZFNUtVOWxjLzBjRnNWWHJz?=
 =?utf-8?B?dThIMzN2dzlodEV5RTdMamlOS01aVk41K0RhcGRkN0tIY0V4ejdSL1J6SkVy?=
 =?utf-8?B?bVlRaFVsMkxlV1I1UVVoNDFGNkVsbjN0RTQ5QnpyM1NvUW1RV3I4bnRUb2Fy?=
 =?utf-8?B?QzlZZGZLN0owVzhDOGoxa2dicUordXMyUkpibWhPd0hIM3AxS0kxVnplb2Ji?=
 =?utf-8?B?TElUemFZaHpyeTlscW8xNnV0RkFlSkEycWNzMWlZazF1N1lGQ2Evblc5WUsy?=
 =?utf-8?B?aHJKcktNTkJZaS9WNGFwMUxlZy9Id3hBb0NWb0VxSGxCMHBHYVVDRGpyZ0ZX?=
 =?utf-8?B?YlM5MDdBUmdaTUdpb1RIYTU2VVBtVWdRb1Q4azBxNnJXdy94c01BblVPWlMx?=
 =?utf-8?B?OGhtb1AxWW9sMXBxRFZydTdHdXVhVXRhTzRncGJIbzF0VzdBMkFEOU1BTXhs?=
 =?utf-8?B?bnRJR0JIWS9iaGlHdmt2UThhb25tV285eDJwc3NPZEJDRzRuQU54Y1RSN2J6?=
 =?utf-8?B?RXB6TENiUUk0eTJmY1NUd3FHNXFxWFVvY1BjaEpQcWRsNEptaE0yNUZDZVQ5?=
 =?utf-8?B?blRVV2lOMWN5UjJJSStLSHc1Yk1TaThvVVBSRXFxS1cxcWdUK1JHbUhYSzNo?=
 =?utf-8?B?LzJMMCtJQUxIenFLY1AvaktzM1BzelcwQkJBcW95Y1VnemtEUFBWREZZM3dJ?=
 =?utf-8?B?VzlFMjRNWW1rVnYrWVFtTVJrQUtUaWRneHo5NFNZYjluN0NtMGxrY2NmY0dn?=
 =?utf-8?B?TU4wSkgyRnFJY2lic0lLaHlobzVFMzF0eW8vS0NWTzBSelh4RlJScTNHaTZG?=
 =?utf-8?B?Y0tCc3VtMTBUcUFrUzYvS1hqK2FJQTVYQ3lmeXIrTTIrQytBeVZLd0h1THJL?=
 =?utf-8?B?OTBlUVpTeU5MZGlDWTdLZVcxUUxJVm9XQ3NGZXJ0V2FsNElKK2FEeWxNOG1M?=
 =?utf-8?B?VHU0SEM4SDZoQitPV1lRTkNCZkl3cXRyTlR5Ty82NkV4alUraElQUmpiaDVZ?=
 =?utf-8?B?YjZDanMwZUlXV0hWbjI0UFowTmxNdSs4UDhpSHNYVGNCZnJvUWxwTVJCSVF0?=
 =?utf-8?Q?jwhdGRDX1VovUXwrgrn+tj/cWQtOzlICC1tFU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B437E2A8D271441A3077358DC6AD698@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac51f75-729b-428c-4898-08de6e6ec76b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 21:52:00.3809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYWLN3S7LjUZbKqXi8iRzl+m10P3QgvklvyzCrdX8+3eIIfNMIYK8L/obgNC+MqDvfzz9OmrLNj50L11gQIoDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4719
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Ack_LWEexcXrg4cYBLPcVQdgDJomASQI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE3OCBTYWx0ZWRfX0ASPwUp1UJaE
 N11KLNVYsZeDLKZLlSarAtA6NZ9ZbOlPog+jq1KNOkkxv7VJlwj9InJCGUtIU/8UUf9kxdtf6sh
 D/sRyv/z9YuSQsqQb7BxgKZv2nuujCnM2U39ya0H7i7NYdJ5wuVlLewLbRs8nfH9ik+YCk5FeQo
 QNhBdfRnLdNqLSj3HldyNVPBEvXzsrowy7CjXCopDkIzCDh01F+yrID2zf1xWsbeKdQf88SiA57
 3VrBJPunSQ6jeYAN0WGhY2ubj6EbXtn0/8kA6le+buel/eN5od66SWuxhu2AEUM/59MLJL1ltAm
 ldHnU7zjCnUftOp2OAIx3r9ECKI8YwfP+w+WllFBUp/1562sftobIbPRvJxxipa2nxi0St59I3S
 sxK08sQjDYXu69YJZF8z2+3Gtqvpx+KuZlZrjqIssGSx6zgd4CnnydNe1DcWbNL8RRn6uTDH5AW
 qo5EDT0sFriyiOTbwDw==
X-Proofpoint-GUID: t0xbBpLzs4sVW4I_57OC_-Q2uHv3ZuB8
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=6994e303 cx=c_pps
 a=jJEkL6Umpl9hNhu6gfQ4Mg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=4u6H09k7AAAA:8 a=hgX1MGmMiHxEovtLhyoA:9
 a=QEXdDO2ut3YA:10 a=5yerskEF2kbSkDMynNst:22
Subject: RE: [PATCH] ceph: add timeout protection to ceph_mdsc_sync() path
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170178

T24gRnJpLCAyMDI2LTAyLTEzIGF0IDA5OjUxICswMjAwLCBJb251dCBOZWNoaXRhIChXaW5kIFJp
dmVyKSB3cm90ZToNCj4gSSBhbHNvIGNyZWF0ZWQgYSB0cmFja2VyIGlzc3VlIGZvciB0aGlzIG9u
IHRoZSBDZXBoIGJ1ZyB0cmFja2VyOg0KPiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9p
bnQuY29tL3YyL3VybD91PWh0dHBzLTNBX190cmFja2VyLmNlcGguY29tX2lzc3Vlc183NDg5NyZk
PUR3SURhUSZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRBWE16YzhOSnUxX1JHbW5R
MmZNV0txNFk0UkFrRWx2VWdTczAwJm09b1ZRM1hYbm5PWFlkUWgxWEx3M3RGN05RdFZuMlJic3BL
Ujg3eEtNWDlPYVh3eE1lRzUtajlOWnFsNk9WUGhpMSZzPVJDbXJwVjZTTVZmanVyaGl2ak15SFJt
X2JEZWtWRVFsX3VJaEQ1aGJ0bm8mZT0gDQo+IA0KDQoNCkl0IGxvb2tzIGxpa2UgdGhhdCBJIHdh
cyBhYmxlIHRvIHJlcHJvZHVjZSB0aGUgc3ltcHRvbXMgb2YgdGhlIGlzc3VlIGJ5IG11bHRpcGxl
DQpydW5zIG9mIGdlbmVyaWMvMDEzIHhmc3Rlc3RzJyB0ZXN0LWNhc2U6DQoNCiMhL2Jpbi9iYXNo
DQoNCndoaWxlIHRydWU7IGRvDQogIHN1ZG8gLi9jaGVjayBnZW5lcmljLzAxMw0KZG9uZQ0KDQpG
ZWIgMTYgMTU6NDY6MzAgY2VwaC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0Njg5NV0gSU5GTzogdGFz
ayBmc3N0cmVzczoxNDQ2Ng0KYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMiBzZWNvbmRzLg0KRmVi
IDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDc5OTVdICAgICAgIE5vdCB0
YWludGVkIDYuMTkuMC1yYzgrDQojMTANCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2VybmVs
OiBbIDE4NDUuMzQ4NTMwXSAiZWNobyAwID4NCi9wcm9jL3N5cy9rZXJuZWwvaHVuZ190YXNrX3Rp
bWVvdXRfc2VjcyIgZGlzYWJsZXMgdGhpcyBtZXNzYWdlLg0KRmViIDE2IDE1OjQ2OjMwIGNlcGgt
MDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk0MjZdIHRhc2s6ZnNzdHJlc3MgICAgICAgIHN0YXRlOkQN
CnN0YWNrOjAgICAgIHBpZDoxNDQ2NiB0Z2lkOjE0NDY2IHBwaWQ6MTQ0NjQgIHRhc2sNCl9mbGFn
czoweDQwMDE0MCBmbGFnczoweDAwMDgwODAwDQpGZWIgMTYgMTU6NDY6MzAgY2VwaC0wMDA1IGtl
cm5lbDogWyAxODQ1LjM0OTQzOF0gQ2FsbCBUcmFjZToNCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAw
MDUga2VybmVsOiBbIDE4NDUuMzQ5NDQxXSAgPFRBU0s+DQpGZWIgMTYgMTU6NDY6MzAgY2VwaC0w
MDA1IGtlcm5lbDogWyAxODQ1LjM0OTQ0NV0gIF9fc2NoZWR1bGUrMHhlOGEvMHg1N2YwDQpGZWIg
MTYgMTU6NDY6MzAgY2VwaC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0OTQ1N10gID8ga2FzYW5fc2F2
ZV9zdGFjaysweDM5LzB4NjANCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2VybmVsOiBbIDE4
NDUuMzQ5NDY2XSAgPyBrYXNhbl9zYXZlX3N0YWNrKzB4MjYvMHg2MA0KRmViIDE2IDE1OjQ2OjMw
IGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk0NzFdICA/IGthc2FuX3NhdmVfdHJhY2srMHgx
NC8weDQwDQpGZWIgMTYgMTU6NDY6MzAgY2VwaC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0OTQ3NV0g
ID8NCmthc2FuX3NhdmVfZnJlZV9pbmZvKzB4M2IvMHg2MA0KRmViIDE2IDE1OjQ2OjMwIGNlcGgt
MDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk0ODVdICA/IF9fa2FzYW5fc2xhYl9mcmVlKzB4N2EvMHhi
MA0KRmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk0ODldICA/DQpj
ZXBoX21kc2NfcmVsZWFzZV9yZXF1ZXN0KzB4NmEzLzB4ODgwDQpGZWIgMTYgMTU6NDY6MzAgY2Vw
aC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0OTQ5N10gID8NCmVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJf
aHdmcmFtZSsweDc2LzB4N2UNCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2VybmVsOiBbIDE4
NDUuMzQ5NTAyXSAgPw0KX19rYXNhbl9jaGVja193cml0ZSsweDE0LzB4MzANCkZlYiAxNiAxNTo0
NjozMCBjZXBoLTAwMDUga2VybmVsOiBbIDE4NDUuMzQ5NTA3XSAgPw0KX19wdl9xdWV1ZWRfc3Bp
bl9sb2NrX3Nsb3dwYXRoKzB4YjA0LzB4ZjgwDQpGZWIgMTYgMTU6NDY6MzAgY2VwaC0wMDA1IGtl
cm5lbDogWyAxODQ1LjM0OTUxNF0gID8gX19wZnhfX19zY2hlZHVsZSsweDEwLzB4MTANCkZlYiAx
NiAxNTo0NjozMCBjZXBoLTAwMDUga2VybmVsOiBbIDE4NDUuMzQ5NTIwXSAgPyBfX2thc2FuX2No
ZWNrX3JlYWQrMHgxMS8weDIwDQpGZWIgMTYgMTU6NDY6MzAgY2VwaC0wMDA1IGtlcm5lbDogWyAx
ODQ1LjM0OTUyNV0gID8NCl9fY2FsbF9yY3VfY29tbW9uKzB4Mzg2LzB4MTRiMA0KRmViIDE2IDE1
OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk1MzJdICBzY2hlZHVsZSsweDc1LzB4
MmYwDQpGZWIgMTYgMTU6NDY6MzAgY2VwaC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0OTUzOF0gIHNj
aGVkdWxlX3RpbWVvdXQrMHgxNmQvMHgyMTANCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2Vy
bmVsOiBbIDE4NDUuMzQ5NTQyXSAgPw0KX19wZnhfc2NoZWR1bGVfdGltZW91dCsweDEwLzB4MTAN
CkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2VybmVsOiBbIDE4NDUuMzQ5NTQ4XSAgPw0KX19r
YXNhbl9jaGVja193cml0ZSsweDE0LzB4MzANCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2Vy
bmVsOiBbIDE4NDUuMzQ5NTUzXSAgPw0KX3Jhd19zcGluX2xvY2tfaXJxKzB4OGIvMHgxMDANCkZl
YiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2VybmVsOiBbIDE4NDUuMzQ5NTU5XSAgPw0KX19wZnhf
X3Jhd19zcGluX2xvY2tfaXJxKzB4MTAvMHgxMA0KRmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBr
ZXJuZWw6IFsgMTg0NS4zNDk1NjVdICA/IGthc2FuX3NhdmVfdHJhY2srMHgxNC8weDQwDQpGZWIg
MTYgMTU6NDY6MzAgY2VwaC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0OTU2OV0NCndhaXRfZm9yX2Nv
bXBsZXRpb24rMHgxNGEvMHgzNDANCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2VybmVsOiBb
IDE4NDUuMzQ5NTczXSAgPw0KX19wZnhfd2FpdF9mb3JfY29tcGxldGlvbisweDEwLzB4MTANCkZl
YiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2VybmVsOiBbIDE4NDUuMzQ5NTc3XSAgPw0KX19rYXNh
bl9jaGVja193cml0ZSsweDE0LzB4MzANCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2VybmVs
OiBbIDE4NDUuMzQ5NTgyXSAgPyBfX3BmeF9tdXRleF91bmxvY2srMHgxMC8weDEwDQpGZWIgMTYg
MTU6NDY6MzAgY2VwaC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0OTU4N10gIGNlcGhfbWRzY19zeW5j
KzB4NGI0LzB4ZTgwDQpGZWIgMTYgMTU6NDY6MzAgY2VwaC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0
OTU5M10gID8NCl9fcGZ4X2NlcGhfbWRzY19zeW5jKzB4MTAvMHgxMA0KRmViIDE2IDE1OjQ2OjMw
IGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk1OTddICA/DQpjZXBoX29zZGNfcHV0X3JlcXVl
c3QrMHgzOC8weDc3MA0KRmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4z
NDk2MDNdICA/IGNlcGhfb3NkY19zeW5jKzB4MWNiLzB4MzUwDQpGZWIgMTYgMTU6NDY6MzAgY2Vw
aC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0OTYwOF0gIGNlcGhfc3luY19mcysweGEwLzB4NGMwDQpG
ZWIgMTYgMTU6NDY6MzAgY2VwaC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0OTYxMl0gIHN5bmNfZmls
ZXN5c3RlbSsweDE4Mi8weDI0MA0KRmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsg
MTg0NS4zNDk2MThdICBfX3g2NF9zeXNfc3luY2ZzKzB4YWMvMHgxNjANCkZlYiAxNiAxNTo0Njoz
MCBjZXBoLTAwMDUga2VybmVsOiBbIDE4NDUuMzQ5NjIzXSAgeDY0X3N5c19jYWxsKzB4NzQ2LzB4
MjM2MA0KRmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk2MjldICBk
b19zeXNjYWxsXzY0KzB4ODIvMHg1ZDANCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2VybmVs
OiBbIDE4NDUuMzQ5NjM1XSAgPyBfX3g2NF9zeXNfb3BlbmF0KzB4MTA4LzB4MjQwDQpGZWIgMTYg
MTU6NDY6MzAgY2VwaC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0OTY0MV0gID8gX19rYXNhbl9jaGVj
a19yZWFkKzB4MTEvMHgyMA0KRmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0
NS4zNDk2NDddICA/DQpmcHJlZ3NfYXNzZXJ0X3N0YXRlX2NvbnNpc3RlbnQrMHg1Yy8weDEwMA0K
RmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk2NTVdICA/DQpfX3Bm
eF9fX3g2NF9zeXNfb3BlbmF0KzB4MTAvMHgxMA0KRmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBr
ZXJuZWw6IFsgMTg0NS4zNDk2NjFdICA/DQpfX2thc2FuX2NoZWNrX3dyaXRlKzB4MTQvMHgzMA0K
RmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk2NjddICA/IGtzeXNf
d3JpdGUrMHgxYTMvMHgyMzANCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2VybmVsOiBbIDE4
NDUuMzQ5NjcyXSAgPyBfX2thc2FuX2NoZWNrX3JlYWQrMHgxMS8weDIwDQpGZWIgMTYgMTU6NDY6
MzAgY2VwaC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0OTY3N10gID8NCmZwcmVnc19hc3NlcnRfc3Rh
dGVfY29uc2lzdGVudCsweDVjLzB4MTAwDQpGZWIgMTYgMTU6NDY6MzAgY2VwaC0wMDA1IGtlcm5l
bDogWyAxODQ1LjM0OTY4Ml0gID8gZG9fc3lzY2FsbF82NCsweGJmLzB4NWQwDQpGZWIgMTYgMTU6
NDY6MzAgY2VwaC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0OTY4N10gID8NCmZwcmVnc19hc3NlcnRf
c3RhdGVfY29uc2lzdGVudCsweDVjLzB4MTAwDQpGZWIgMTYgMTU6NDY6MzAgY2VwaC0wMDA1IGtl
cm5lbDogWyAxODQ1LjM0OTY5Ml0gID8gX19rYXNhbl9jaGVja19yZWFkKzB4MTEvMHgyMA0KRmVi
IDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk3MDVdICA/DQpmcHJlZ3Nf
YXNzZXJ0X3N0YXRlX2NvbnNpc3RlbnQrMHg1Yy8weDEwMA0KRmViIDE2IDE1OjQ2OjMwIGNlcGgt
MDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk3MDldICA/IGRvX3N5c2NhbGxfNjQrMHhiZi8weDVkMA0K
RmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk3MTVdICA/IF9fa2Fz
YW5fY2hlY2tfcmVhZCsweDExLzB4MjANCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2VybmVs
OiBbIDE4NDUuMzQ5NzIwXSAgPw0KZnByZWdzX2Fzc2VydF9zdGF0ZV9jb25zaXN0ZW50KzB4NWMv
MHgxMDANCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2VybmVsOiBbIDE4NDUuMzQ5NzI0XSAg
PyBpcnFlbnRyeV9leGl0KzB4YTUvMHg2MDANCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2Vy
bmVsOiBbIDE4NDUuMzQ5NzMwXSAgPyBleGNfcGFnZV9mYXVsdCsweDk1LzB4MTAwDQpGZWIgMTYg
MTU6NDY6MzAgY2VwaC0wMDA1IGtlcm5lbDogWyAxODQ1LjM0OTczNl0NCmVudHJ5X1NZU0NBTExf
NjRfYWZ0ZXJfaHdmcmFtZSsweDc2LzB4N2UNCkZlYiAxNiAxNTo0NjozMCBjZXBoLTAwMDUga2Vy
bmVsOiBbIDE4NDUuMzQ5NzQwXSBSSVA6IDAwMzM6MHg3OTJmYjFkMWJhNGINCkZlYiAxNiAxNTo0
NjozMCBjZXBoLTAwMDUga2VybmVsOiBbIDE4NDUuMzQ5NzQ1XSBSU1A6IDAwMmI6MDAwMDdmZmMz
ODQ0ZWI1OA0KRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDEzMg0KRmVi
IDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk3NTJdIFJBWDogZmZmZmZm
ZmZmZmZmZmZkYSBSQlg6DQowMDAwMDAwMDAwMDAwMDAwIFJDWDogMDAwMDc5MmZiMWQxYmE0Yg0K
RmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk3NTZdIFJEWDogMDAw
MDAwMDAwMDAwMDAwMCBSU0k6DQowMDAwNTkwNDU2MTBiNDQwIFJESTogMDAwMDAwMDAwMDAwMDAw
NA0KRmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk3NTldIFJCUDog
MDAwMDAwMDAwMDAwMDAwNCBSMDg6DQowMDAwMDAwMDAwMDAwMDI2IFIwOTogMDAwMDdmZmMzODQ0
ZTk4Ng0KRmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk3NjJdIFIx
MDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6DQowMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDAwMDAw
MDAwMDE0OQ0KRmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk3NjVd
IFIxMzogMDAwMDdmZmMzODQ0ZWJhMCBSMTQ6DQowMDAwNTkwNDJkZTlkMGIzIFIxNTogMDAwMDAw
MDAwMDAwMDE0OQ0KRmViIDE2IDE1OjQ2OjMwIGNlcGgtMDAwNSBrZXJuZWw6IFsgMTg0NS4zNDk3
NzFdICA8L1RBU0s+DQoNCmwgKmNlcGhfbWRzY19zeW5jKzB4NGI0DQoweGZmZmZmZmZmODJjZGRi
ZTQgaXMgaW4gY2VwaF9tZHNjX3N5bmMgKGZzL2NlcGgvbWRzX2NsaWVudC5jOjU5MTYpLg0KNTkx
MSAgICAgICAgICAgICAgICB9DQo1OTEyICAgICAgICAgICAgICAgIGRvdXRjKGNsLCAid2FpdCBv
biAlbGx1ICh3YW50ICVsbHUpXG4iLA0KNTkxMyAgICAgICAgICAgICAgICAgICAgICByZXEtPnJf
dGlkLCB3YW50X3RpZCk7DQo1OTE0ICAgICAgICAgICAgICAgIHdhaXRfZm9yX2NvbXBsZXRpb24o
JnJlcS0+cl9zYWZlX2NvbXBsZXRpb24pOw0KNTkxNSAgICANCjU5MTYgICAgICAgICAgICAgICAg
bXV0ZXhfbG9jaygmbWRzYy0+bXV0ZXgpOw0KNTkxNyAgICAgICAgICAgICAgICBjZXBoX21kc2Nf
cHV0X3JlcXVlc3QocmVxKTsNCjU5MTggICAgICAgICAgICAgICAgaWYgKCFuZXh0cmVxKQ0KNTkx
OSAgICAgICAgICAgICAgICAgICAgYnJlYWs7ICAvKiBuZXh0IGRuZSBiZWZvcmUsIHNvIHdlJ3Jl
IGRvbmUhICovDQo1OTIwICAgICAgICAgICAgICAgIGlmIChSQl9FTVBUWV9OT0RFKCZuZXh0cmVx
LT5yX25vZGUpKSB7DQoNCkkgYW0gbm90IHN1cmUgeWV0IHRoYXQgcmVhc29uIGlzIHRoZSBzYW1l
Lg0KDQpUaGFua3MsDQpTbGF2YS4NCg==
