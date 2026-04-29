Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D53242CF;
	Wed, 29 Apr 2026 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484413; cv=fail; b=DCRQChHSxbndV9IGOa+1mvLiH7dVMY4IP8A623fwPLLASzp8HFUgsKHKw3n3Ar2mCZFP6+F+SJr5e8WRKFzqWmnbVwU3hwPH9kknoWDGhP1Ww9VgPfUJKAJSYEWDymkX4sSPaNS8azxmaDQMJB9evjG56XTRNC1PqeeRW89+ZDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484413; c=relaxed/simple;
	bh=0PJ9B2kmRNB0p1vztkKPJi+M4hK69CmYiOg9dYb1IzI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=H4iZ+xEZ3Kp5Ic37V+zlEnTba3T+zrU6R6o82T0WMtFzbCgZuHY8uBkx2zaPjJ/mzA7sE+RzXmbNlX5ZF4IDnQbH/u1txvmaHKh9GcQRecVfiXiDAyX5WmMtrTZcRCh4DH7ArOcg5xg6C5ZH6ixwBQV+/veO0MxCDQVjFZ/eMZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TI7KDirO; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TI7KDirO"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TC5SGE3289925;
	Wed, 29 Apr 2026 17:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=0PJ9B2kmRNB0p1vztkKPJi+M4hK69CmYiOg9dYb1IzI=; b=TI7KDirO
	pTjkRJcO4DeAaY89BbTAl7WFMep+oZMsAbUfISTfWYoCZvfCSheuZl0Wf9GtAhiG
	w3WqjC8qlAHSMZPaR+BBJI8hw5KQvyyakPpefGOTtvpXw7/7IvmybQzV3gSpCvri
	0D3OmbLc4XTy/azK5Vug4FIC3309VMladaugEMd5Q/Y8nOwUmmH06G81WAc9qaK9
	EumpK4zxYcyejOCK2E/T97pwG4vrfRluWa/YSs1dagCOCmGUReUpfrel5Rn6ekyA
	E2zDPEkhxj2NqPUyTctoow97HOY57ysiISexYSEAPzSdF01yUsvyMfmL/B/4v78S
	WlCImBvPviAQng==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9rbtm2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 17:40:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXlII7HVm9pCyWyv5jHyn1SH9+pWRxzSegbItQsNP+xaKDYDgAvm9Apo21cquTIReVILMgUCcOMmDq+Eskn3iPGBwg666c/MHTiuRdJfgae8nMutomplMd+5iBikIqfHy5LfpB/M5Ff2dJJoWVwcGMuqoIr7qqkBqKgsHILdvdzQg2xcKwSsqZ2PqqopUGsvjIdNb8YATkNIBOtdXAz6QpNZ+Ufmn0AaMAuO08YAk3aSEFAE4iffU3xbpv+v678ypbhSmfZ95EF5Zp5qG+z/VOvsdt0ftvr/4jZVVCah5mz8HyjSm0auA440OD29NAUIdqGfNDurXFrc81vqs0dM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PJ9B2kmRNB0p1vztkKPJi+M4hK69CmYiOg9dYb1IzI=;
 b=BWwWeJGS3X0Ka/OMTQaO5gdJansl2+zi5TwiliduQEUiu7AFqk2DcfcZI9otDf6DAKgOoK3ESVE1TcQ08x2UJkKLtqNsVs4ig97T1H+9tpY5MUMj+q/vOHVTy3wKE6n1gfQ6bEQniSirT9wiOfvzj0y8K/JPkivUJuZhJk0yeG8IGvQP5DBYS8Cfqnk4CMq1db9QwxQK4UvVOsVcEptJjntZXJuPhApjwyc4sjDHdFESFPJSV4ArZ0nn4sqQwe/D7mwbaPItV7Voo/nJa4TjpiucDsQHlUyVgHg6wqV1YUw59uemmDuyHAaJSRjN0iol91ehVjLeseS0NKK6EG4vNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ4PPF8956444A2.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::8b4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 17:39:55 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 17:39:54 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "lilei24@kuaishou.com" <lilei24@kuaishou.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "sunzhao03@kuaishou.com" <sunzhao03@kuaishou.com>,
        "noctis.akm@gmail.com"
	<noctis.akm@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] RE: Re: RE:  [PATCH] Revert "ceph: when filling
 trace, call ceph_get_inode outside of mutexes"
Thread-Index: AQHc1BvhpQJT1Qtc3USMj5s6uWaEfbXzV3IAgACg5QCAAMGpAIABnCeA
Date: Wed, 29 Apr 2026 17:39:54 +0000
Message-ID: <b4ae204ba4d5191cc9641180ad1193b9463a6beb.camel@ibm.com>
References: <20260418041241.17892-1-lilei24@kuaishou.com>
		 <8a17ed01f4d98c93ef53521e8ab3fc313678af70.camel@ibm.com>
		 <f5c1c6e44aa2bb1799ab67dd4569e15ddd443c06.camel@ibm.com>
		 <ACE74C42-7D08-4BB0-8ED1-D0468AE63DDD@kuaishou.com>
		 <62414b7cad425347fd6ea5f46d7d48dc4a4f0705.camel@ibm.com>
		 <37AC14F0-8B00-49A4-892C-B93AE6E9D79B@kuaishou.com>
	 <ab347a1021a5d1d32bf41f6f59cd56b6408516a7.camel@ibm.com>
In-Reply-To: <ab347a1021a5d1d32bf41f6f59cd56b6408516a7.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ4PPF8956444A2:EE_
x-ms-office365-filtering-correlation-id: a7ce1a66-b8e8-4b45-62d6-08dea6165300
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 vsruSoBtK/0FwVAg9C50UOtcC3qnvWMg7i7VbqFbEE98+BO8cc+9WHyNChvyKE8CNrdqfg6cUP8WwjjdqNh8kiFHpktOD2SEHHrfYTArW3rFR9K56izypRlRPBuDMhyYWrUqH1L4/YU8WEIjXaPRccnfCmsbEjzeDuCoZAzVUBXezFm86dCmzSMXQRde/aP+lHf/f1avEAXslcrD5e9uvAyHA3a/p7tf89Hnr6rLGpBE77haFWbd3QbfKo5HVFuDO7QuiLOj4+JuO02zzHz+Lx4DdC10rYsgjpc612byP+DgAHesNIIHFSfqa/nexC4YDU81IKlLs4DUiO83ygZ2y8G2gd6A3CSQHcyLDeqA1V/EvoLS1An6pBwZsfpEQ5j/FpSO9X9xZ3dOUqgHDww+mKz5rFlD/svhNNzNciCjzDtwBVHCgeqdUSxUVfeYCilCDF/C2d7vQLPSBRtnLUXuh0pmW6VlxXPX4E8jRUbi3sUKpS7XFSnRW6GIgt94NnECO8gRp3dSWl8VMeVGSAQ2p5JUNscyLQuiRvsJlfsllyubEFakcSid9hmpJ1KprgRmBs8I9guR1/30E+v6IaVn/iDnvLDvIHAIh2puB0Vi2Rb7oG804Seyu0ToizHl9ZwRxe4FaOwW6iUug+2pCQ4HFVPrVnGub29d/bxE98S+F3abksj/v4aW8zm+ccxxzVSWI4UIKMfx0A6hqXDbIJTMIz5ulRLQaaLYFJPDV5DKRK2Ct3RqwpWFWfckJe9kch7TjE3Zr+wJerDjWbqdvipM4qxl9TnI4tbDlQhnuW7J7kA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dENOWjZaa2pCdnZnNTJPdGdwSEhrNEpQb3FXSFVTT3BqOC9ET29QL2docFNU?=
 =?utf-8?B?R1hLVW9JRzFxeVBJSGVRMnR3U1BBZ2ltb2xxcG9EWWtvMThkS2dXeitKNGYx?=
 =?utf-8?B?TmszQU95RFpocDZqVmdMNGcyalVGemJPOTc1UHNZNGFBS21NVnJaK2V5emly?=
 =?utf-8?B?QVN1aDBmRmp5YU4wNUhKTHdRSG14VklLL3ZvT21GSHdjRms5K3ZRcUUvSXRm?=
 =?utf-8?B?bmgxYzBsanMyQ2diZFlzOVQ3Z3ZGSmN6QU94UUpKUnhXcXhtU3VnZDN1NXI5?=
 =?utf-8?B?ay92K1JkdXpweUR0aUtEb2JCNSt4MjcxTGh2eVE2ODhQL0lhYmZySGtJb1M5?=
 =?utf-8?B?Y1c0Nmo0UkFYR3U0MnI2b1pRU293TVQ1aG4yOTFTUmR4cDFNTm9VWDU0QUg0?=
 =?utf-8?B?eWxGM0NyR1ZNZWNoV1BnSVRobVhQWEhGbDZkOEpBeDU5UkNQc0V4bDFYd2U3?=
 =?utf-8?B?UUh1NjFCaklFcUNkZ0dLeXFqMm1yWUZRUGh6YWJOREZXQ09KSVcxejNXcDBE?=
 =?utf-8?B?MFdsRHVpWGNocjRxOVM1UWI2Q0ZLbE91QXFaRnRUdFNtbWVLb09KL2lnMXNt?=
 =?utf-8?B?Y1U3ZmxnUm4yOXhZQXJqeWE4MGFMMkhvYk1JT3dCNFJoKytpdmpCMEl4TWtB?=
 =?utf-8?B?WVpCMDdjUDI4T0JLeDFONHNUVkZBeWxBdkE1czhrYi91dUowejZaOEZtdXcw?=
 =?utf-8?B?Zm9GZDl3MFhMVVY5UHBLRWRYbW9kZmZnQitmZ3BBdDk3Mk9YNDZDNko4ODQ4?=
 =?utf-8?B?UTR5Vm1zVHZYalQ0bHdXREtUR0g4Q0R2N1R1N2tlNlc5SjBkSFFaa3N2VGRJ?=
 =?utf-8?B?ZTdzOWpsOS84ZmtMdklnb3YvNTUvSVZWdEZNT2gySHJwaURtNEtWTVB2d2ln?=
 =?utf-8?B?NGpldjNRLzMvcXhNTjNhSDY1UEhrdW8rOU1qMHpKMDUveTlHLy8rT0cyT0lX?=
 =?utf-8?B?MTUvMlZHakJvdndFRnF5cE5IVHdMSGdyamwzaUdnV0JTOUJjVmtDbWxlTmNE?=
 =?utf-8?B?MDMwbWx0RXdkWHhibXMwYitEL0ppQmVta3F6eHJZK1dEdjBWcEV5OWFxZStH?=
 =?utf-8?B?N0o4cHZXUXRKZHNmaDhpVm9BSWQ0eURLRzhCQVRyZVIyRTdhYStXQlRaeEI4?=
 =?utf-8?B?aWZ1S0lZOGJXYWV2U1Boa0UwMUwzVmRreThrVDEzVGIvem5ROWNBQ3djQmJS?=
 =?utf-8?B?djQvTEo3MW4vOERWU0lXdWRHT1RtaC85aC85ODZ2aExlaWRLR044cURzZGFl?=
 =?utf-8?B?VTFCRXFMWmtJTTFjOVdOK3k5cWVCcm5SWTlFWVNKY3MybEVtNGV0ZnpaNGow?=
 =?utf-8?B?Ni84ZFA4R3JlaitUdmVWZ0tyd0lDb3lpWHVEK2wvWVZmdmdQTWlEMjRzN1g2?=
 =?utf-8?B?WlhvcExYQXY4Rm8yLyt4ZlZ6dGdEMDhoQXIrWFVGTEFFL2tQQUZ6NTNLcWZz?=
 =?utf-8?B?UEdId2tRRjdtNGs1YzJRRHIrY3FJditDd0VnNjRRVnpvLzJjamRYcFRhME5Q?=
 =?utf-8?B?RmpyMHhvN3pDN3RvUU45NVJZRXlGZHRCOUFmSkFKaWRaTkhjQTB5SkdEOXEy?=
 =?utf-8?B?YjRYYWJ5VHllK0g5S1hVei9mbFgzVFQ4Ykxic3N4SnYxNEdaZUlXdG5KOE1x?=
 =?utf-8?B?bDJ0aWxtSzl5SjZLV3dpWGZJTkNxTDFZb0ZLTWZ5cElUK25UVllNcWEzcjl4?=
 =?utf-8?B?c2RUbzN2bjQyeU9TNmhvR05rTFhXMEhEZ0RSazJhVFUrOWJ1dGlZWkphcHJS?=
 =?utf-8?B?RDhOR25YZ3ROdnRSZklqN05aNmpvRzZ4azZtVXlKaVpxdERidzlFMWJJcVRR?=
 =?utf-8?B?eUo0WnpiQ0M4MTZ5MHdOUHpWanNIUGZKRkNua3RJL0JnUTJ1YmVsRXZTcnl2?=
 =?utf-8?B?cWx0elF2eXc0MmJaVkJTVUdlYkZaTUozUFl5RVRYRHAwbElMWDNXK3crWWZI?=
 =?utf-8?B?aElSQ1FQUU5GbEs0ZGU5Qy9LaFhOSkh4OGJvQ0RMY0c4ZjRSOTV3NmhhVkYw?=
 =?utf-8?B?UG8xVkRuQU1tT2RKWlBCN3RaOHBaVnE5NSt3VzBTTDZTMkVNQ1pMaTVWeng4?=
 =?utf-8?B?dTlKQ0pkN3NNYUVYRitjNnpaNFd2bGsxOEJqRXAvbENOczJwKzJhQUdEby9T?=
 =?utf-8?B?WlJ0anlpTGlKMkcrcEU4TjY0a2ZOQjB3UTV3NTdkV1VtVjVrREhjSTRUeWdn?=
 =?utf-8?B?SWg2RmpyRW80MEpyR05FMzR3dmJodXJOQjFxUFhKYXJmZGlELzZ2R2VyNmt4?=
 =?utf-8?B?TG1ndW5HeVMvVjhuT3VTWEh5ZFFmR0FuZlVVdFRycjg1Ym9CWGs0dmVzR3lM?=
 =?utf-8?B?eXRQQWtXbDNkRnFhNGhyN3UwUHpuajRhcnRaKzlNT1BzNmlKcmhINWlrK1M4?=
 =?utf-8?Q?Zf3UqTDAiZfrCjwM4ZEKLbQjLpRdPenGNX3mf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2858792E75242747ABBBB40D2B5DF40A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	GzKBOXRIkdUoHk3ngS+JkXFdmxLVP2IOBJVXMDmiCam42++A4XELc09SCUXvEj4bEnSdBDb7JDICrgVqeoYaeX7EZGZu+PJgTd+ScIfDxxScNQPrh52S0bgm6zU/h7HRQVubezZQsh5qBKKHCqU2StsqP5TP7CTmBw5TXATspahU+9sMJBdfmQlJsvVuQocs2z74fd3xHwtoWM9cWFpnCzoX39g7N5KoEi8jvTIB4/sdlbdwjfeahJfkxri2qVW3nNhfKWeRWmJsj5xnSfKR69FpSWWE8ZtxmERGtmJ9IGs7pyEpygb5cyKAhkEG+Yd+NCwiCco9ObLpv72CBw0J8g==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ce1a66-b8e8-4b45-62d6-08dea6165300
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 17:39:54.4669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Tn7QrwFAanwsTMcCHJKD1+D726mtDkPkDQqYidQFe8VHTIZR329JuXBYhmaswAtsfcGnPaFoTjWBni6whnhAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF8956444A2
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: nFX62aMRgYoZ5VmOATgSEGvQQ9Quks6P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE3NCBTYWx0ZWRfXxu+/lwNRoR1G
 XcueDD7P7MpUjgf7sYOfXacUE+0JT9OA7IauU8MyjMYHY5FX2iPzWtrZfke890l280MhcEhdKmj
 +DnbI4DTDV6yzM8Lw12n5GQ3OLPpEPdDKA75GXENTxjANnbfR/ITJSZ0BTxWyrp6SIAqJ0o8Cfv
 MNgDLcTujzJoDjd4sEC6KvJZMlASorkZTAhi8KGG1zowWAMR1tgWVV/NSIIOVWhDOp1yB/3wNjs
 pt8fkAxuHPrACh4DAGug5rGgdrmmMeZT3xPOFWMCDlVmXIC9WXAYm1A5Q8IEGAzZzowNNrX+tzs
 J4q8w19Xea9QpjxaZg+3yvvqNupY8mrjttWyShl5cjqxr1NfIfJeLLiSQQemqcWCJYyBlEDZmPr
 KmY3e1ydykWngDJO7IzYxyPgkEWp6YNWjkhvXwcDhx+fls9S6n40i5AJm18UWZsXzUlv1U614ek
 FKqxlqVe3O7W1HvVuaw==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f24270 cx=c_pps
 a=NgWOhXrokr2/NniB/8N7+Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=hiXvQZlH-DbLSgeI:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=M_MaUh1itky0x66yVCgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kNb4X0GsWbcV31MrCXyQN7DsuUxfbl1y
Subject: RE: Re: RE:  [PATCH] Revert "ceph: when filling trace, call
 ceph_get_inode outside of mutexes"
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290174

T24gVHVlLCAyMDI2LTA0LTI4IGF0IDE3OjA0ICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIFR1ZSwgMjAyNi0wNC0yOCBhdCAwNTozMSArMDAwMCwg5p2O56OKIHdyb3RlOg0K
PiA+IA0KPiA+ID4gPiANCj4gDQo+IDxza2lwcGVkPg0KPiANCj4gPiA+IA0KPiA+ID4gQXMgZmFy
IGFzIEkgY2FuIHNlZSwgSSB3YXMgYWJsZSB0byByZXByb2R1Y2UgdGhlIGlzc3VlIHdpdGhvdXQg
eW91ciBwYXRjaA0KPiA+ID4gYXBwbGllZC4gSXQgbG9va3MgbGlrZSBJIHdhcyAibHVja3kiIHRv
IHJlcHJvZHVjZSB0aGUgaXNzdWUuIEkgbmVlZCB0byB0YWtlIGENCj4gPiA+IGRlZXBlciBsb29r
IGludG8gdGhlIGlzc3VlLiBCdXQgeW91ciBwYXRjaCBpcyBub3QgcmVzcG9uc2libGUgZm9yIHRo
ZSBpc3N1ZS4gTGV0DQo+ID4gPiBtZSBzcGVuZCBzb21lIHRpbWUgdG8gYW5hbHl6ZSB0aGUgaXNz
dWUgcmVhc29uIGFuZCBlbnZpcm9ubWVudC4NCj4gPiA+IA0KPiA+ID4gSGF2ZSB5b3UgYWJsZSB0
byByZXByb2R1Y2UgdGhlIGlzc3VlIG9uIHlvdXIgc2lkZT8NCj4gPiANCj4gPiBJ4oCZdmUgdHJp
ZWQgZ2VuZXJpYy83MDEgYWdhaW4gZm9yIHNldmVyYWwgdGltZXMsIGJ1dCBubyBpc3N1ZXMgb2Nj
dXJyZWQuDQo+ID4gDQo+IA0KPiBJIGFzc3VtZSB0aGF0IHJ1bm5pbmcgb25seSBnZW5lcmljLzcw
MSB0ZXN0LWNhc2UgYWxvbmUgY2Fubm90IHJlcHJvZHVjZSB0aGUNCj4gaXNzdWUuIE15IHVuZGVy
c3RhbmRpbmcgaXMgdGhhdCB0aGUgd2hvbGUgYXV0byBncm91cCBuZWVkcyB0byBiZSBleGVjdXRl
ZC4NCj4gU29tZWhvdywgSSB3YXMgbHVja3kgZW5vdWdoIHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUu
IDopDQo+IA0KPiA+IEp1ZGdpbmcgb25seSBmcm9tIHRoZSBzdGFjayB0cmFjZSwgSSBiZWxpZXZl
IGl04oCZcyBhIGRlYWRsb2NrIGJldHdlZW4NCj4gPiB3cml0ZWJhY2sgYW5kIG1lbW9yeSByZWNs
YWltaW5nLiBUaGlzIGRlcGVuZGVuY3kgY2hhaW4gaXMgYXMgZm9sbG93cw0KPiA+IA0KPiA+IDEu
IFNldmVyYWwgRCB0aHJlYWRzIGFyZSB3YWl0aW5nIGZvciB0aGUgb3NkYy0+bG9jayB0byBiZSBy
ZWxlYXNlZC4gDQo+ID4gMi4gVGhlIG9zZGMtPmxvY2sgaXMgaGVsZCBieSBrd29ya2VyL3UzMjow
OjI0MTA5MiB3aGljaCBpcyBwZXJmb3JtaW5nIHdyaXRlYmFjaywNCj4gPiAgICBhbmQga3dvcmtl
ci91MzI6MDoyNDEwOTIgaXMgYXNraW5nIGZvciBjb24tPm11dGV4IHRvIHNlbmRfcmVxdWVzdC4N
Cj4gPiAzLiBUaGUgY29uLT5tdXRleCBpcyBoZWxkIGJ5IGt3b3JrZXIvNzo0OjMwODI5MiB3aGlj
aCBpcyBjdXJyZW50bHkgY2FsbGluZyBkb19zZW5kbXNnKCkNCj4gPiANCj4gPiBCZWNhdXNlIG9m
IG1lbW9yeSBzaG9ydGFnZSwgc3RlcCAzIGhhcyB0byByZWNsYWltIG1lbW9yeSBhbmQgd2FpdCBm
b3Igc3RlcCAyIHRvIHdyaXRlYmFjaw0KPiA+IEFuZCBmcmVlIHNvbWUgZm9saW9zLiBCdXQgc3Rl
cCAyIGlzIGJsb2NrZWQgYnkgY29uLT5tdXRleCB3aGljaCBpcyBhbHJlYWR5IGhlbGQgYnkgc3Rl
cDMuDQo+ID4gDQo+IA0KPiBJIGFtIGdvaW5nIHRvIHRha2UgYSBkZWVwZXIgbG9vayBpbnRvIHRo
ZSBpc3N1ZSB0b2RheS4gQnV0LCBwcm9iYWJseSwgb25lIGRheQ0KPiBjb3VsZCBiZSBub3QgZW5v
dWdoLiA6KQ0KPiANCj4gDQoNCkFzIGZhciBhcyBJIGNhbiBzZWUsIHRoZW4gbWFpbiBwcm9ibGVt
IGlzIHRoZSBtZW1vcnkgcHJlc3N1cmUgaXNzdWUuIEFuZCBpdA0KbG9va3MgbGlrZSB0aGF0IHRo
aXMgcGF0Y2ggY2FuIGZpeCB0aGUgaXNzdWU6DQoNCkZyb20gODQ1NzJmN2ZjYjdhYWQ0MjJjNzFj
ODdiNTJkZmVhODA1ZWViN2ZiZCBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCkZyb206IEhyaXN0
byBWZW5ldiA8aHJpc3RvQHZlbmV2Lm5hbWU+DQpEYXRlOiBNb24sIDYgQXByIDIwMjYgMTY6MDE6
MjAgKzAzMDANClN1YmplY3Q6IFtQQVRDSF0gY2VwaDogcHV0IGZvbGlvcyBub3Qgc3VpdGFibGUg
Zm9yIHdyaXRlYmFjaw0KDQpUaGUgYmF0Y2ggaG9sZHMgcmVmZXJlbmNlcyB0byB0aGUgZm9saW9z
IChzZWUgYGZpbGVtYXBfZ2V0X2ZvbGlvc2AsDQpgZm9saW9fYmF0Y2hfcmVsZWFzZWApLCBzbyB3
ZSBuZWVkIHRvIGBmb2xpb19wdXRgIHRoZSBmb2xpb3Mgd2UgcmVtb3ZlLg0KLS0tDQogZnMvY2Vw
aC9hZGRyLmMgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZm
IC0tZ2l0IGEvZnMvY2VwaC9hZGRyLmMgYi9mcy9jZXBoL2FkZHIuYw0KaW5kZXggMzkwZjEyMmZl
ZWFhLi4xMDExMGFmNzQ3MTUgMTAwNjQ0DQotLS0gYS9mcy9jZXBoL2FkZHIuYw0KKysrIGIvZnMv
Y2VwaC9hZGRyLmMNCkBAIC0xMzI5LDYgKzEzMjksNyBAQCBpbnQgY2VwaF9wcm9jZXNzX2ZvbGlv
X2JhdGNoKHN0cnVjdCBhZGRyZXNzX3NwYWNlDQoqbWFwcGluZywNCiAJCWlmIChyYyA9PSAtRU5P
REFUQSkgew0KIAkJCXJjID0gMDsNCiAJCQlmb2xpb191bmxvY2soZm9saW8pOw0KKwkJCWZvbGlv
X3B1dChmb2xpbyk7DQogCQkJY2VwaF93YmMtPmZiYXRjaC5mb2xpb3NbaV0gPSBOVUxMOw0KIAkJ
CWNvbnRpbnVlOw0KIAkJfSBlbHNlIGlmIChyYyA9PSAtRTJCSUcpIHsNCkBAIC0xMzQwLDYgKzEz
NDEsNyBAQCBpbnQgY2VwaF9wcm9jZXNzX2ZvbGlvX2JhdGNoKHN0cnVjdCBhZGRyZXNzX3NwYWNl
DQoqbWFwcGluZywNCiAJCWlmICghZm9saW9fY2xlYXJfZGlydHlfZm9yX2lvKGZvbGlvKSkgew0K
IAkJCWRvdXRjKGNsLCAiJXAgIWZvbGlvX2NsZWFyX2RpcnR5X2Zvcl9pb1xuIiwgZm9saW8pOw0K
IAkJCWZvbGlvX3VubG9jayhmb2xpbyk7DQorCQkJZm9saW9fcHV0KGZvbGlvKTsNCiAJCQljZXBo
X3diYy0+ZmJhdGNoLmZvbGlvc1tpXSA9IE5VTEw7DQogCQkJY29udGludWU7DQogCQl9DQotLSAN
CjIuNTMuMA0KDQpJIGFtIGdvaW5nIHRvIHJ1biB0aGUgeGZzdGVzdHMgd2l0aG91dCB0aGlzIHBh
dGNoIGFnYWluIHRvIGNoZWNrIHRoYXQgaXNzdWUgd2lsbA0KYmUgcmVwcm9kdWNpYmxlIGFnYWlu
Lg0KDQpUaGFua3MsDQpTbGF2YS4NCg==
