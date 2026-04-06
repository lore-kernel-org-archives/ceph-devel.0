Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79038CFFF;
	Mon,  6 Apr 2026 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501559; cv=fail; b=sz1Wb3lZpCLalXjKWF5MhNDG0/d53oPLQciSUsPxRHEv6zeUbIKdIbbOdx1kYW7HLbT1uWshgplX5V86wW/Rx3NqktPo41ZVFFFjYSSU4/Xoosgyh2bAmLtHr1cmrEO5IFg72fHjhu3IG/LraoM+LNuQbpScX7bKMmSR6J6o2Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501559; c=relaxed/simple;
	bh=cVfBbHDs0ZeuHRUUNjJgEy3neFu8yGEnoaYyi9V6HN8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=VKfuUGfyIiNH21z/ZG8kY85MDGX7+FeS+YldpNQ8tCiq2xkRcwUcCjS1HyR325yTnwUgPM8Ou8Y5PP7YLc9LrC95hJe+Y0sJt65KcUhvd/8eEw8YojX1AH7G+8GVNd0Ij/GKezFmL8qqJsdps1dmPDMJYbSS5ZAjG5eUELqcea4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MMZUj28n; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MMZUj28n"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636G74SR3532822;
	Mon, 6 Apr 2026 18:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=cVfBbHDs0ZeuHRUUNjJgEy3neFu8yGEnoaYyi9V6HN8=; b=MMZUj28n
	aqyGqCjgPioLJoFqPAnq9CCRbm0UYgkFRSAcqe+lO9HJ3TB1MQF/KzEEGfyV48V0
	8v/UlX/iv78UCpStPEG2i2mAVi5BUjrGk2dZ97iK5lr07GPiPxyoSUFfJDEFadDP
	cqzUXtACFX664LV7Uxet9ePsQfY54dWxrwRSNs3lKZRzsReG4OxBA0FlqqVPqhYR
	impx67v4RKwOLtdzRmIXKLTm6DSnD1DVhVxkD10180SElt1OQl99Fu6pKJaMWLTl
	t2p08MJC4iNgteo1mQih2hEd4asJDlgL1S89tTyYAw/S+FcwuWGa/XXfRqMKUaix
	tOjo+GFXhMICpw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2r205-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 18:52:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuKhV6IukmMKy4fu19QMGuWMFXbPvuEikxWBlWbm2WIFFHtPwUryH5OY3YkYg/fFfTb5Turpx6UiXoTIgGRmkc1A7+nPJoN+7oywhdAmgtGRsJ6v4B99mGhY8c6L7zeJQnRyQxqoMcmy06vCjaG0uIHADbFYXWedHM9eFgTN/r92F/OoLyCcRYeC6FpsnmbMOanWSVgKAEsEU2miyfQ3tE5vrs2afQAD1eQkh1zcBK1Z0fHp0FFh/kTbpKlOA/dxrsGovaGZ9ZMmOJno9k8ezs0cy81y/dDUoqyQT33QMJz/DwXge7JIug9pU4J5KKmMQ4tLGsecPdFblijRLyd1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVfBbHDs0ZeuHRUUNjJgEy3neFu8yGEnoaYyi9V6HN8=;
 b=VHFt2fIb/FE+c06c/O1ZjlwfHh9C4Eb+AgXQP/5bWMKhhPI0Tla25c2o9QYBh1eBGyXDoC/4NzaFNLIu2TLAWqsn+jC0paxHuhOVoCDHELKQ/SN8OKgzZzduEJQ20PMjAjMMXA8oRIN9u8RE1Vb4YKsMvG8gBT5RcuBKZwrT2m2up0rzUmd/MDpIOH3mINkdysP4SvMHugofcEP5wgLQmQAS8tTv/LmVwY8JA46xnttYP58pX+pzKzLyj0SU0WZL6fAokNeV19E3cYvpBKrPkmwtE7aA17kmfgYZ32MjBVjrUNcTWaeoZv0PZM00bjW9YyPUvQVEns+DlagqkkuwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by LV5PR15MB6898.namprd15.prod.outlook.com (2603:10b6:408:35b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 18:52:29 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9769.015; Mon, 6 Apr 2026
 18:52:29 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Alex Markuze
	<amarkuze@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] ceph: bound encrypted snapshot suffix
 formatting
Thread-Index: AQHcxBBJOj22caat1UaLHsQ3sYJTmLXSZOcA
Date: Mon, 6 Apr 2026 18:52:29 +0000
Message-ID: <8f5ae2014d421c293cdc74c849762566046375be.camel@ibm.com>
References: <20260404101003.3-ceph-pengpeng@iscas.ac.cn>
In-Reply-To: <20260404101003.3-ceph-pengpeng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|LV5PR15MB6898:EE_
x-ms-office365-filtering-correlation-id: 1e42f695-a6bb-4dde-03ed-08de940da753
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 ANewXIH9NsLm59mX1g01rkdE7LmwwN34cR0tyZoxqciNwTD0a9RY9RR0/WgzDdTD+rpnfN8QC5I14+gq4kd24Fk9bqs6NsTWexAKg8/LyDMsJvGRx1KqFzGS+zPfB2zRJPYdE++qRuoJQZbmKumwIIeeeXuQz6rLisk9ETmxbDZLYGwy2HLOSN2GfbdsPjkFcTJ7STSH+hqmyEX9XQZad7cdVN/xtDxQ5/+LN0UOgcVNP/lOUqTVSE5zLNGVMDtuSfoGhLzKWAtojPCZf+gWJ71D47VJh2JVNDGnMvDBa4SWHiPTfqLCOV5+avvZyOjZ2mhs8GetD9iVJIWbJTewh7kFMqi3+CBGTE2gdEiunoI3hltV8AN/O1SYJ6eduvOGrJv2G9yg3WuHrf/wlbJm9jPHPVszUGazbETSFUXMhQjE1tStqBIgFxmpA9GyFElaA3GLwLqUNSqk0WEeQrtQtLfxmhsnkuRBOSj274P3Vv54WXVbLAHm/z/IiiiygW0ae3WzYoz9FnNlh+ydXa2svHHPsXGYeSPRkF8cuTNHdhUOmA0WHcAqYJoo18cfzzf00GvidczQyvdQ8K+R7qeA5P0EfxQAmicdZSogwqjU6BnZyyz3UoJlREsFeMEipv5EDiNdifIVyVzgOVjZyg338dlpjrDoyJBjMaM1xFTfQ8FI0m9ye5yQpugdaVVDyWGW8h1C3CWdBmq7zvZaCLldCwaQJ3H+ThE1VothTcLzh+I2kL7XduxBGFz723Vu8Wob8FRG/nLJQFR5jc1qWpyuiN1EaYPKG0fid6WoysiIgUg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eE40SjFBNHJQeE9NdzFITWZOMGhFWmc0R3ZxTzNxZnU0TVBDa2JHbEs4a1JW?=
 =?utf-8?B?eHh5Rzlac0hXRTlNMTBua2lHQWtHd2x2QmxTRjdORzQ5Zk1QVmY4d1VLV3Y5?=
 =?utf-8?B?b0JHYWI4WjVvUFNRRTl1Nmt5amV5cnFiRjVmd2Z5MWZtL09MZ0pKUmE0R1Nx?=
 =?utf-8?B?Nno4b21vcVBod21SSFJLdEJzVnJ4SnE3YmJCZ1BlUGJ2SDhvajZDeXJSNkxS?=
 =?utf-8?B?eEp3UnpyS29EdEJkMGozdGFtWWFtM1BKR1lVMlFIS3c3MHRVU0pMQzk0YWhr?=
 =?utf-8?B?YlNFVGlQVlQ4SUxVR1FqK2JOSU9ZYUVWS01ZM0lvZS9lRUx5c1NuYjM2Vm1D?=
 =?utf-8?B?VGxwQ0U1YUlkaHBxN3Vsb0J4K1VVUGxSNmZTTHZuMGxVWHdEZjkxa29QSXlQ?=
 =?utf-8?B?MGRrdUhocFFjUDNha2hBV1ZKMEcwTWkzOVhDS2R0Q2M5YUs0T3d3TVAvNnVm?=
 =?utf-8?B?TFRCc1VyaVlOQ04wQ1FnUDY4cURsSlpJNlNtU3VJWnYzRkg5MEVKWk5iU251?=
 =?utf-8?B?WnJITVRCMlZVWk9MdllqbHFUeEFncWx3Uy8yWGUvLzhzSk81UTFESW5sTVgz?=
 =?utf-8?B?bnRnd00ybVk1REFxK0RZbnludTF4aElQeEJ6dVVYUDhIWG9rNmpjcWhiR3ZZ?=
 =?utf-8?B?UHFyRk9kOXphV2pFSVlvbGgwWDQvNWo3Sy9FK2pEeUdBdHdLRkt5a0pTMTNF?=
 =?utf-8?B?RFBpSTBMNHVhU3JlMjZ1eVRmOW1xOGZTL21Dc3EwamVDalVpbmhGYkEyMTZY?=
 =?utf-8?B?M3RnQmhTOGNSdW84bFcxblROUnlNZU8za1QvNHhxWk5xa2VwakZVT21zaGtk?=
 =?utf-8?B?dlczZVdNeXFiNW9uN1pMUlZnRzhYNXc3ajQ4djBicXVtSEdQTDNlazRyS2Qx?=
 =?utf-8?B?dmNXYm83RmRxMXJaOVcwZ2lGVnVOalZCdHhPd0VBdHBDeEg1aFZydDJBcXVt?=
 =?utf-8?B?NXZ4aXVzOUlWaGNNa3orTCtJb0hNaWZySXlMeTRTQ2FaY3ZNb2E2QUJib25s?=
 =?utf-8?B?OVJzNE5hYU44SEdESkhhdHZIazVaTmNMSS9jeFk5azd5ZFFaNTVrNlRVaDBO?=
 =?utf-8?B?YnE4SHNkRHlIdEk4ZHhKbCs5NGZ4RUNyS0dvRkw4Y0RaUXR6cVJsNVJySndZ?=
 =?utf-8?B?UXlGbWVMaEVRWDVIR3NnSkxQOEN1NW9UeS9sRDhrdFc5K0VWelJITTdEQzJ1?=
 =?utf-8?B?aUw5K1AvLzUvL1RESGhVR0hwZGpEZUhEeHR4YW91alowaDB5NVNmWU5DYkFt?=
 =?utf-8?B?SkdqT256WVpFNkZNTEhNUmZKWmRjSnJOZFp1c0pzQXZtOVRlU2Y1NWxvc0Jt?=
 =?utf-8?B?b241blhsZ2VRWXFYUjdsakxwNWt0bFM0dkhXdDBqMU85Mmt2clNxS3gxU1ZC?=
 =?utf-8?B?dzVKd2t6VHRadUlBU2toT081TDdZanU4VHVmNTZwcXlJeUxjYXF3ZDF1Mkhp?=
 =?utf-8?B?bllXaCttbG9STU81OFNBaEozKzNkUENCeVRzRzcyM3NmTlJ4UW0yOGt3M21T?=
 =?utf-8?B?bVVCa3NOc3NWWDJWTk1IbTF4SDZsK3FTbGFlNGVaaW5wRlAxYzh3d1Z3bWRB?=
 =?utf-8?B?MXVqdUNkakhLV0p6UVdZd0lvTXV6czVhTUtGSGJpNXZjbXUrQjhVVThWSnVD?=
 =?utf-8?B?QitlRE1DZHJKeFhaSnJJajFjdTl4SmkyaWhhZWRnaGRSbUpOMTA5UnZIUTdz?=
 =?utf-8?B?OGhtRDRtNTg0M1FDM3NYWm9Yazk5ZWRqaGpaSmVSbk44aWZac09uU200cEVj?=
 =?utf-8?B?eGhrZ3ZSQ2k4YmdRdlBVQXdsSlkvY1p0d3BjZzNYN3djS3VQaGVGR0xNZndn?=
 =?utf-8?B?NDBoOG0zLzhwRnIrQkhzZVUxak9VaXZVRHZtRHBlLzJWQUdHZjBoNXlTZEQy?=
 =?utf-8?B?WVN1eDFsTCs1eE0rNUdLWUV5OWxuQUNuRlJvKzM5b0FRQjdwTkxsdWFpNHht?=
 =?utf-8?B?TkgzaHRKNFBZNFNockZROFVQZU5tUFpWY0pTY2RqQ1JLakRaY0NOQlIyVXlo?=
 =?utf-8?B?ZXJYM1BNTzVhQ2FwdTdaWHhSVDE5WXBYRTRaeXdWclVUU3JyekpWOGtPc2Ur?=
 =?utf-8?B?cDgxWU1odUJ3VzRGa3h4NjBpR3BDbXFCaElFZlliYlQvV2pGeFBsM2grcTdy?=
 =?utf-8?B?VFNlTDFjL1hPSHpnV1BEeEFmcVNBVXptQ2xiWnhaNjU1R2pBMGlvalFLWGIv?=
 =?utf-8?B?b1dkZkx5bjRnZ25hMjNRV3daTjlPdUphempqajEwYWRLYzBxWVdjSVZyQW8z?=
 =?utf-8?B?Y1VWVjZqQzlpUFRlR2xMRXhSZHdjbUtYTmFycUdQUG5TZ1lvQndRcmtkb2l4?=
 =?utf-8?B?anZrYXlWWjUwN0hucEFpTSt5alBTZjRwblAvOXZPelo1QllwcWtzSEdXcHdS?=
 =?utf-8?Q?PUQ04+4tTrPDCsNjVm31aTvOWtCQ/dBM8U2Fx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBB3B110849C274EA644E324F7C5171F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ALIPGJh5SkKW2IOv0NXO5CzTyAxKMLzIKsDtYSIVeCGn5p82npKdRcWfaqxJSISlsYWUoNDfakBIQJk7zVW4mavoKIHguWuhFjcH/naV9bsjNDH0IJtCRJhzLMHyj6LnVplN04H36cYvpF+ggXeXbd4Scmvpa2Jm6eQDHjyR5cFiFD+y5Xoqa0sCKqN4mQiOFt0LG0UcfEq4t05NiHOvGeXHu4KwLu+p+uUl5kudX9qWsVyS8WE4FUgVPRKq4Jx9ZsjyBYCKzB2DKSFbYKr6Pad+ramQMoMv+OkiW/PNlBfjD4v4ARcRVJkeVAXIZlpvUsUb+edOPCRZfkHauvphvA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e42f695-a6bb-4dde-03ed-08de940da753
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 18:52:29.5645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hgl288x3NlHut5+8RoYKzShbIJGoAXbg8K79G99mdFH1TEUOO7wu7mSlFPhjL1b7DG9CdgKAZ+mCYlvArJleDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR15MB6898
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE4NCBTYWx0ZWRfX0nZw3ZmtyRRL
 NkVEKM6L75XoGahjZIo+bLmYo/KPCasIRQ1EiP9tSxJAXfypU1kpJcVCyzvvVDomq/hJxK8+mKx
 bv7wZrvZKxCGDgCcruGD+LJHuIqx2nIgR+XIWyyojqR8wODJHllUWBK2x6+QDXyMzB6vyJXlZLN
 6aOP4j1vfhKFxVFFGPEZ/woKDMA9Llv9Cv/qd0ZOtQ88cy7RgsR4UF8obsWZg4XKtWk/JASv1Yk
 ZUWc3FuteHNi0M5gc+/ncHszp0jnZKqF4k7R0dhciQE4E+KdeLi8h2L8So7DgtgOTFV+7iU81kS
 Tlp3jPwWGstlOAhRCtvE6Ye+AFKGw4Fzc3tNZ8BnILNL6lMQYhwq0ZzCtjtCGDp53cDjK+SQzLB
 AI7eh85U4Okc43xnF/p3/lmaZx7Lc/FdTk7hH9HoRwSdHZ28UdTf0yBN7fC1DB4c4jaFbzhQxJ2
 pHVQUoEKJANu9nNo3IQ==
X-Proofpoint-GUID: iuqDgkymLuBLHr5SSIky-fHAFQbAw2Wz
X-Proofpoint-ORIG-GUID: n28EHbi7htTK4dccfJi4NF2513jcS01I
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d400ef cx=c_pps
 a=iHXbSHwDNs+yH6wS+48/mw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=4qP7nSwmZFbDkw53LpUA:9 a=QEXdDO2ut3YA:10
Subject: Re:  [PATCH] ceph: bound encrypted snapshot suffix formatting
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060184

T24gRnJpLCAyMDI2LTA0LTAzIGF0IDE2OjU2ICswODAwLCBQZW5ncGVuZyBIb3Ugd3JvdGU6DQo+
IGBjZXBoX2VuY29kZV9lbmNyeXB0ZWRfZG5hbWUoKWAgYmFzZTY0LWVuY29kZXMgdGhlIGVuY3J5
cHRlZCBzbmFwc2hvdA0KPiBuYW1lIGludG8gdGhlIGNhbGxlciBidWZmZXIgYW5kIHRoZW4sIGZv
ciBsb25nIHNuYXBzaG90IG5hbWVzLCBhcHBlbmRzDQo+IGBfPGlubz5gIHdpdGggYHNwcmludGYo
cCArIGVsZW4sIC4uLilgLg0KPiANCj4gU29tZSBjYWxsZXJzIG9ubHkgcHJvdmlkZSBgTkFNRV9N
QVhgIGJ5dGVzLiBGb3IgbG9uZyBzbmFwc2hvdCBuYW1lcywgdGhlDQo+IHJldHVybmVkIGxlbmd0
aCBhbHNvIGluY2x1ZGVzIHRoZSBsZWFkaW5nIHVuZGVyc2NvcmUgdGhhdCBzdGF5cyBpbiBwbGFj
ZQ0KPiBhaGVhZCBvZiB0aGUgZW5jb2RlZCB0ZXh0LiBPbiA2NC1iaXQga2VybmVscywgYSBsb25n
IGlub2RlIHN1ZmZpeCBjYW4NCj4gcHVzaCB0aGUgZmluYWwgZW5jb2RlZCBuYW1lIHBhc3QgYE5B
TUVfTUFYYCBldmVuIHRob3VnaCB0aGUgZW5jcnlwdGVkDQo+IHByZWZpeCBpdHNlbGYgc3RheWVk
IHdpdGhpbiB0aGUgZG9jdW1lbnRlZCAyNDAtYnl0ZSBidWRnZXQuDQo+IA0KPiBGb3JtYXQgdGhl
IHN1ZmZpeCBpbnRvIGEgc21hbGwgbG9jYWwgYnVmZmVyIGZpcnN0IGFuZCByZWplY3QgbmFtZXMg
d2hvc2UNCj4gc3VmZml4IHdvdWxkIGV4Y2VlZCB0aGUgY2FsbGVyJ3MgYE5BTUVfTUFYYCBvdXRw
dXQgYnVmZmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGVuZ3BlbmcgSG91IDxwZW5ncGVuZ0Bp
c2Nhcy5hYy5jbj4NCj4gLS0tDQo+ICBmcy9jZXBoL2NyeXB0by5jIHwgMTcgKysrKysrKysrKysr
KysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvY3J5cHRvLmMgYi9mcy9jZXBoL2NyeXB0by5j
DQo+IGluZGV4IGYzZGU0M2NjYjQ3MC4uZWViYThmZmIwNTU0IDEwMDY0NA0KPiAtLS0gYS9mcy9j
ZXBoL2NyeXB0by5jDQo+ICsrKyBiL2ZzL2NlcGgvY3J5cHRvLmMNCj4gQEAgLTIwOCw2ICsyMDgs
NyBAQCBpbnQgY2VwaF9lbmNvZGVfZW5jcnlwdGVkX2RuYW1lKHN0cnVjdCBpbm9kZSAqcGFyZW50
LCBjaGFyICpidWYsIGludCBlbGVuKQ0KPiAgCXN0cnVjdCBjZXBoX2NsaWVudCAqY2wgPSBjZXBo
X2lub2RlX3RvX2NsaWVudChwYXJlbnQpOw0KPiAgCXN0cnVjdCBpbm9kZSAqZGlyID0gcGFyZW50
Ow0KPiAgCWNoYXIgKnAgPSBidWY7DQo+ICsJY2hhciBzdWZmaXhbMSArIDIwICsgMV07DQoNCkkg
cmVhbGx5IGRpc2xpa2UgdGhlc2UgaGFyZGNvZGVkIGNvbnN0YW50cy4gQW5kIEkgZG9uJ3QgcXVp
dGUgZm9sbG93IHdoYXQgMSwgMjAsDQphbmQgMSBtZWFucy4gV2h5IHRoZXNlIG51bWJlcnM/IFBs
ZWFzZSwgaW50cm9kdWNlIHRoZSBuYW1lZCBjb25zdGFudHMuDQoNCj4gIAl1MzIgbGVuOw0KPiAg
CWludCBuYW1lX2xlbiA9IGVsZW47DQo+ICAJaW50IHJldDsNCj4gQEAgLTI3MSw4ICsyNzIsMjAg
QEAgaW50IGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9kbmFtZShzdHJ1Y3QgaW5vZGUgKnBhcmVudCwg
Y2hhciAqYnVmLCBpbnQgZWxlbikNCj4gIA0KPiAgCS8qIFRvIHVuZGVyc3RhbmQgdGhlIDI0MCBs
aW1pdCwgc2VlIENFUEhfTk9IQVNIX05BTUVfTUFYIGNvbW1lbnRzICovDQo+ICAJV0FSTl9PTihl
bGVuID4gMjQwKTsNCj4gLQlpZiAoZGlyICE9IHBhcmVudCkgLy8gbGVhZGluZyBfIGlzIGFscmVh
ZHkgdGhlcmU7IGFwcGVuZCBfPGludW0+DQo+IC0JCWVsZW4gKz0gMSArIHNwcmludGYocCArIGVs
ZW4sICJfJWxkIiwgZGlyLT5pX2lubyk7DQo+ICsJaWYgKGRpciAhPSBwYXJlbnQpIHsgLy8gbGVh
ZGluZyBfIGlzIGFscmVhZHkgdGhlcmU7IGFwcGVuZCBfPGludW0+DQo+ICsJCXJldCA9IHNucHJp
bnRmKHN1ZmZpeCwgc2l6ZW9mKHN1ZmZpeCksICJfJWx1IiwgZGlyLT5pX2lubyk7DQo+ICsJCWlm
IChyZXQgPCAwKSB7DQoNClRoZSBzbnByaW50ZiBuZXZlciByZXR1cm5zIG5lZ2F0aXZlLiBBcmUg
eW91IHN1cmUgdGhhdCB0aGlzIGNoZWNrIG1ha2VzIHNlbnNlPw0KDQovKioNCiAqIHNwcmludGYg
LSBGb3JtYXQgYSBzdHJpbmcgYW5kIHBsYWNlIGl0IGluIGEgYnVmZmVyDQogKiBAYnVmOiBUaGUg
YnVmZmVyIHRvIHBsYWNlIHRoZSByZXN1bHQgaW50bw0KICogQGZtdDogVGhlIGZvcm1hdCBzdHJp
bmcgdG8gdXNlDQogKiBALi4uOiBBcmd1bWVudHMgZm9yIHRoZSBmb3JtYXQgc3RyaW5nDQogKg0K
ICogVGhlIHJldHVybiB2YWx1ZSBpcyB0aGUgbnVtYmVyIG9mIGNoYXJhY3RlcnMgd3JpdHRlbiBp
bnRvIEBidWYgbm90IGluY2x1ZGluZw0KICogdGhlIHRyYWlsaW5nICdcMCcuIFVzZSBzbnByaW50
ZigpIG9yIHNjbnByaW50ZigpIGluIG9yZGVyIHRvIGF2b2lkDQogKiBidWZmZXIgb3ZlcmZsb3dz
Lg0KICoNCiAqIFNlZSB0aGUgdnNucHJpbnRmKCkgZG9jdW1lbnRhdGlvbiBmb3IgZm9ybWF0IHN0
cmluZyBleHRlbnNpb25zIG92ZXIgQzk5Lg0KICovDQoNCj4gKwkJCWVsZW4gPSByZXQ7DQo+ICsJ
CQlnb3RvIG91dDsNCj4gKwkJfQ0KPiArCQlpZiAocmV0ID49IE5BTUVfTUFYIC0gZWxlbikgew0K
DQpUZWNobmljYWxseSBzcGVha2luZywgd2UgaGF2ZSBvbmx5IFdBUk5fT04oZWxlbiA+IDI0MCkg
Y2hlY2sgYmVmb3JlLiBCdXQgaXQNCmRvZXNuJ3QgcHJldmVudCBlbGVuIHRvIGJlIGJpZ2dlciB0
aGFuIGVsZW4uIFNvLCBwb3RlbnRpYWxseSwgdGhpcyBsb2dpYyBjb3VsZA0KYmUgZGFuZ2Vyb3Vz
IGVub3VnaCBiZWNhdXNlIHdlIGNvdWxkIGhhdmUgb3ZlcmZsb3cgaGVyZS4NCg0KVGhhbmtzLA0K
U2xhdmEuDQoNCj4gKwkJCWVsZW4gPSAtRU5BTUVUT09MT05HOw0KPiArCQkJZ290byBvdXQ7DQo+
ICsJCX0NCj4gKw0KPiArCQltZW1jcHkocCArIGVsZW4sIHN1ZmZpeCwgcmV0KTsNCj4gKwkJZWxl
biArPSByZXQgKyAxOw0KPiArCX0NCj4gIA0KPiAgb3V0Og0KPiAgCWtmcmVlKGNyeXB0YnVmKTsN
Cg==
