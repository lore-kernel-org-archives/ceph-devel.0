Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F16A34B662
	for <ceph-devel@vger.kernel.org>; Fri,  6 Mar 2026 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825094; cv=fail; b=fnj6TG8rOdFXBt5sUTF+5wdZ0XDvAzelVmfukR3xFEcxDZVmbmeUcmWSPmtUBvNSU7gHW5iIoO+l79Ex56/ppmgGI2cJ/z4937XRXpf6lOco5+WO3F+eS6vb4Ki/uLtvTQE42Xz/wIduzhtMcPRRJxrpKPwvmjbrrK2P7IOjdgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825094; c=relaxed/simple;
	bh=mu3ed3xOySL/hvXZvtacVR/2aVbmtvBi/Geif23bG60=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=pUNaSTGMkvIeqccYyEWja8QpyoNlO9DhhZjQ+yXSfoMLwg/FDs82PRYtrYS3/wBLYiWfAKXmEA7/eUNL0LvwqpSpOIoWaXwGePO8WB7Bqq/Ixna7Nrkqg/N1SlfkmNdPTwd2MtNyzc/mhjWbBiSu9FqTVLXN2MO0LukEPGvTNx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k+j+sit/; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k+j+sit/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626HJFuT2021635;
	Fri, 6 Mar 2026 19:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=mu3ed3xOySL/hvXZvtacVR/2aVbmtvBi/Geif23bG60=; b=k+j+sit/
	VEFKqLEFoWpox20WsZwNKVoqwuDNPZbwgmP8XE1RT3gPHvFgotNfkorORNWNXkPb
	e/7L5hpkt0RQ3A+ZOS9GqvgKIQoGjewGDOFCFunBWJUTaQoPTBZKZ0jtYMfJIW2p
	xqhnCQh9nPPfhKk3N8LTJtVJ/OnS6cPCXZAfjx2BoGcn6nFZX9aStV1EC4HZi6ZP
	cmG6BoENQ1RYKA8JSvuUdDBdCZcqx/nOHSK6DqLN0CC+8JEbthr3QbTzoYTNSy3H
	TEqmsfrZQRlfxs13fN7OyOi8E0FeaxoxuBcoRc65k2iIzXbyxtTjfkY0pFmVm9Zu
	cdDCGgrfeMBpaw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdt4hc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 19:24:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilLOcUSR90ya+CIWzsUt9+SyuTDxLMeUOwWu5RyvBRXaJYUwtsdWtDp+DyvH992EBXgl3H/68bUqtAhpRsk+uiikWMBIQfN8a150DbEqQNwUZzY/mF6a0aTCFNhYNuKrJAkhviR3jZE1oAHgr5UPwVMZL6DXPy8W9CV/UTEsK7mDRRqJybx5GaxnmXRPpH+H6W0HLVYYLK+R4w5aYRFvIpeup2O1PBMSYdXd5FdnGo1vQJIA/e8ofh4GSXM2ApR1L0s5fXGCf0l1k1q76T/b03otLLWcf6WNgFQBtR/uTzJQ0aeRPsls9DhoKBFVl3LBTvoJ7gv3YWdfVzSJ+dyseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mu3ed3xOySL/hvXZvtacVR/2aVbmtvBi/Geif23bG60=;
 b=QMIb83oYlKMXLMpqEAUfWmjFj991jIkfEzcoWwacODhBZ0X/sPkWNfvCennFe+5Lymt7BdXAijAg97BH04+DpFK5n17sWgRBHXVcUhIMu9TKZdeLb1vcZ5iW/OKGBKnDiS6q9ojUBQCm56x6UY4HjM62glMmlBdynAEWCzB9VCt50F6qNvgwwBQ69duvjW7P9LwzTmo+7fWHv0NNdBr5vGQEMy2YjeQd0UgBlWw7tUfPl60G7fzygnl3400d3MWoVpVxqu/ZbEo3HohyFHF3x2CX5FBw+Bobs2IrV6fpsrDC726p/tDzyYFQyiM1N3hFmJ/BF5DsQ4on7nByQeG/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB7015.namprd15.prod.outlook.com (2603:10b6:806:4bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 19:24:37 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 19:24:37 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: Fix potential out-of-bounds
 access in ceph_handle_auth_reply()
Thread-Index: AQHcrUmiNrdkrdJkbEWuNdvm5IkapLWh4ykA
Date: Fri, 6 Mar 2026 19:24:37 +0000
Message-ID: <2ddfc235e05ab8705a92f5e2e1ed780f47b9cc30.camel@ibm.com>
References: <20260305164049.2844606-1-raphael.zimmer@tu-ilmenau.de>
	 <9a967105c12095a4e5f32d1c49550c2424580483.camel@ibm.com>
	 <1b946af9-8c9f-49e4-9f36-efacaf2bcbde@tu-ilmenau.de>
In-Reply-To: <1b946af9-8c9f-49e4-9f36-efacaf2bcbde@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB7015:EE_
x-ms-office365-filtering-correlation-id: 40f5a6c5-de91-47d9-0a65-08de7bb601bd
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 vlMvoSqH1H8Foj4rPF/Em96tnTiMgsL8v6LcQi4+F1lhUqw5lRv8iVxxZNGfUCgazUH2pWvanNgzGoe3w2UD8+22lDOsCYZKPMamB05HAqebVaTx2uuBKPHKGVD/loQ8cqbOyYl0DYpWMZQWq50Igqzgs1TA4mt4ZMSkqQRczVHRcsG0IKpiryJv42Hjyf9wO7DVC6qQvsnEtERRTIa2nMp3xsw0kGbLbyGCnVI6NDmHCatjg1v/qyW2K6ivQjO9S8JqjrBw3za1WRC2bCj51Qr6XqVWE+4D8JI4ilwLeTYg9N+ExRVG7REn4v+igo2dJj2IRdLVcun4hLgIf0E0OP1DsxvCnTT0btIrPKcbSBVEdADvfOrA8/+Zuy/1EkpCOZFPD+gs1SluWwbl4JhvDWBUaSWFDexh170C5HzfA+VaKnKSUb66fDwOnQbVqnoFzoXEjhW7oKpEgtWi5D1EZXgYf/HI1AJBfKOlRotjtSTRpwnrb/TQvOIsMrWgTS36s/qBC50OQDiPQsHAHGDExsBNPWBRGBdp/CYvOOsxMF9hNqaoeYoSmr+XP0pv47OtbsY/H5rKeAbBJzgOzT7bMJJbCJ8Ns57ZYAgkPZSbBzocEU5aRCjevSmD7/n4Zrs17RQ2SZA8OqBcA4UQ1mfTXniGno+FYMmLa7ZQP+eAsUHeq7SLyqDRKmfWzTAa3jh0G8m2VzBpMdxLrFbpf9cweUY0IJ7qebbzWEmSrnAs1HfqSQRbjkgmFcOKF9fuhMmMjUgwuI/S1DnDCcJAPL/mDbYcD3kLogN2zNdC/9gNo+Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tk56Q043M1grcUVMOVhxWHJ5QjV3UFVJczdSSGF0TGgwOGhCSnlCZW50MUx6?=
 =?utf-8?B?RzZSZDRtUXFVTXh0VFBwdXVVS3V1VnV3and1ZDRJcW5wdVdtSnlxaTlTYkJJ?=
 =?utf-8?B?cWxEK083YkVUU1B6UldpSlYwK1ltSmhTT3VzZ3JoMU1pamwzbGtiNFlycEk4?=
 =?utf-8?B?SHNiY245cW1ZM2liMFIwY3o5eXMzUzJIMHBNNk9DVTQxd2NvYlc2OUVnbnpC?=
 =?utf-8?B?N1ZqWU5tazczbmplUThRR3IycGJJVng4aUlxTXp0VDJ4cjZSOFJVWUd2Lzhq?=
 =?utf-8?B?aVh1aVo3bGtKejFmeU9iYVdkNS9jcmVLSDVScE13NE5tWkd2NlpzMDBxVis1?=
 =?utf-8?B?aVF6VkxZNHdRd3k3V2hiYWdmeGs2bmtNSUVaTFFpWWErdFNibUlBV2xZU3dy?=
 =?utf-8?B?bFF6aklIWEozazMwM3hlaUN6Y1ZTZ1IxNFZRYzlrT1dIU3ZMbklITGRrWFpr?=
 =?utf-8?B?c0VuOEVneUVwYTJwaEFQMEloY1ZDZzFKaXQyZUt4UkZwc3puUHRKRVk4NURt?=
 =?utf-8?B?b0ZmaFgyOStBZElCaGZ6ZEpsREpibmhhMldDcVdEV2tXd2tIb0F2ZW9XZjR1?=
 =?utf-8?B?RFBrcytGNkhtZFJkUm1UY2dLcWs3d3RvYXBRRnkzdXVzTlY4SGgxWks3Yzln?=
 =?utf-8?B?QjVRRXJsZi9MaGcyL2FZMkJwVGVJWVdaYkJTTzEyd1FTUXRWdEhOR0JIUitL?=
 =?utf-8?B?TWJUU2UyVkpVNGp2c0VyVm9nYXRDWXQyMmVFeVA4RnBzZWl3akNvbG42VkNN?=
 =?utf-8?B?VldJYkRtUmxnMXRwVTlqK2VxTENyWlNaRDBhcWNleTFSNmZUQUdpbktTeE83?=
 =?utf-8?B?UlZUc2hEcVJVTUdhUm8yaStZS2RrN3VkQllRRlNwNWdzTlZ2dzNGbnlSUXdM?=
 =?utf-8?B?OGNZeU1yOEdxcVErZ1JiTnliaHhVZXo2WUsyaUU4eEdnTzRXbEJ5QThBbEpZ?=
 =?utf-8?B?cGZrU09PVHJ5dnhMS253S2trb2E5aXFsWEViQ0F3dVNjUVZWaC9Zc2tCZXRI?=
 =?utf-8?B?NHlHSVFvb3lNTHRaZ3BIekRCU3lGQ2Jzd01sTlIxZmREOVRLa0JoZ3Q5ekov?=
 =?utf-8?B?QmZzTmVmdjR2ZXhoNU5ZSlluaFl6N0Y3S1ZGbG9jcElEai9xaEdiMXJOYVZY?=
 =?utf-8?B?WlQvVytIZHE3Smo3OUhJSVpIdWFCVDhacDh2bS8wbTM1a3pUNGZMeUFnWU1r?=
 =?utf-8?B?RXk3L2s3OGl5anZqb2NtWHcxRmpPOVZqWkZXOUx0WlF5dGRvVkdZM0ZYWXlT?=
 =?utf-8?B?cmlzZFQwVzZ6Rm1wWVBmdHZMc0hZTWFKT1dFdFVPZkFhZjhsNmRJNFRJRUE1?=
 =?utf-8?B?azBNR3FqMjRyNFlSVTVDNkpCMUNzSFRkK04yRngybGNXK2pxcnN0T1c0Zkhn?=
 =?utf-8?B?SWI5OTN4cUFwWTZsVkI4eHNrbGtNN3UvTS9McEprZHJIcDBGb01udnRJNkV5?=
 =?utf-8?B?ekYvSXJhSm1qbXBWVEpXaFF3bVNUZzFFaUJBVWFXOEFlcG5KSmdJMGNxZC84?=
 =?utf-8?B?QnBmZHZDUm01MklzclFhY0JPZlJoMkppQVIyempjeUVJajgzeDh2YkVid3dv?=
 =?utf-8?B?OVRONWZ5ZE1OQndpLzErV1pObFZ4emFOSzRYbFdPSjhSQkpHcVRuNGJrTmEz?=
 =?utf-8?B?NVJoTFhndkQrYWUzVG52TnhlOURDOC85aHVyTEpxSWdnVFdETER1UHZudi9L?=
 =?utf-8?B?ZXZzUzdWc1ZQcThoRWowL3gyWHVwTDRBVGlldFJVV3FCRnhscHk0NDhjRHQx?=
 =?utf-8?B?bm95TGUrdzJPZXJBOGxSbTZxQzVXN1FERnlVL01kWlZoS3dJMzB6cU1QNFBi?=
 =?utf-8?B?NDJYWmhVdi8zaE0zQktWemVhd2JETVd4N2RqTTdyWGtjb1FJS1F1UXpmL1gv?=
 =?utf-8?B?YUlIaVY4WmNRNFVFTXRZdEkvSklNd3Nhak1JaGFTVlFENXdXSlZzQzBleHB6?=
 =?utf-8?B?UWREMnRGZnVGOTQ0dE9veHFnN3ZoTmMxY0ZiS2VPWHkvdU1ZbXlGdDFGaFo3?=
 =?utf-8?B?VjlkVUdiNjRqd2dmZ1gvYXRqZGxBQVFVbGZaRmx4bHlpOHVsZW1mckZ5bEd5?=
 =?utf-8?B?aGJ6R3BpVWJsOGt0WlhuaGV4TFhwSjZJNGs1dU90N1NucERDQXhRaWU5bkg0?=
 =?utf-8?B?OEdOS2RFY05LQVVnR3QyOVJYc091RmwrcnlmUjdYQ0lGeUg3b3Vqek5LR3VD?=
 =?utf-8?B?UVRPaWpGSnJpcnFDUTJxV1BpV2Z6Q1VIeThKS3VObHRhaGtOT2habDBteVB6?=
 =?utf-8?B?ektZWDFGb3QzZXE4dmorbHpkcWtvZG5DaFJiUVhZR2M1K3hpMU1tTHZQWFUr?=
 =?utf-8?B?NmRoUjB5ajJZaUlrSFNrRk9uQ0RSL05JdDFIbmNzSkdFM1M2bFo5MXlKekIy?=
 =?utf-8?Q?yPcpj4q/c0Hxsu4ke2VXnpOI4f1fbh7AEylnv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6F79A44395991469DB82799878AF841@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f5a6c5-de91-47d9-0a65-08de7bb601bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 19:24:37.6284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7bH+Ril9Auk6YxxERf2aImFvd/d/TvxwkTZ+kEjpAAdIHc/1SoeY6toAfD0CSurhg17ZKvDMGHBxzILBG0qow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB7015
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69ab29f7 cx=c_pps
 a=zi9RuwRnjJAIHZVcFFhnlA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=FaTBYfGvlQ3pX3-hybcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: F6vGuqPL4GyrWJFtN42dSA-6rfSm2-s5
X-Proofpoint-GUID: QiwRY0VT7dCdENY3grsIfK-SJpPz4nsz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE4MSBTYWx0ZWRfX+qthB0UsA2F6
 JyJXQowqSUgdf7DivD0Wj7E07Z+Pkbq099ngJyOmiqZpdh673pZaf35oFK3OFpmaeiQcaYOdVOy
 RI45yDOmNu19Av0Yhn1vWKYOhvbKKMcrhJi3krpGhA70ETmqAWeeqXdw3k5TBW0eTmi/Oji42A6
 zZDb36B2NgLPhS8L3i5GgtrIRUS+yQ1ns1Vw41nX2IUcixj528AYsVJyxO1hYvOlgFfb9SwQmv9
 hab5HMecjrHZoXa8o7JbllG6ZEzB/nLUV5lKsYs0FdDZmvhqswJ87HeB3ZiH8pfMGoQoUfsEUE0
 ghPaOHFtBjPwQc8cJAoKTxaq2F8ywzSQILjNPtKk1qRxslWj3qJcZrSNttXmLOsqvbFsx4euO58
 O3okC75SUgvYd7rss2Dqufsce3ummbHd0D71kh6nAy16DtqFr0e4cSe3NHBCq+u+ma+PtPp/HPw
 PxF/UqYXB9i3zCgbQnQ==
Subject: RE: [PATCH] libceph: Fix potential out-of-bounds access in
 ceph_handle_auth_reply()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060181

T24gRnJpLCAyMDI2LTAzLTA2IGF0IDEwOjE0ICswMTAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gT24gMDUuMDMuMjYgODozMyBQTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IE9u
IFRodSwgMjAyNi0wMy0wNSBhdCAxNzo0MCArMDEwMCwgUmFwaGFlbCBaaW1tZXIgd3JvdGU6DQo+
ID4gPiBUaGlzIHBhdGNoIGZpeGVzIGFuIG91dC1vZi1ib3VuZHMgYWNjZXNzIGluIGNlcGhfaGFu
ZGxlX2F1dGhfcmVwbHkoKQ0KPiA+ID4gdGhhdCBjYW4gYmUgdHJpZ2dlcmVkIGJ5IGEgbWVzc2Fn
ZSBvZiB0eXBlIENFUEhfTVNHX0FVVEhfUkVQTFkuIEluDQo+ID4gPiBjZXBoX2hhbmRsZV9hdXRo
X3JlcGx5KCksIHRoZSB2YWx1ZSBvZiB0aGUgcGF5bG9hZF9sZW4gZmllbGQgb2Ygc3VjaCBhDQo+
ID4gPiBtZXNzYWdlIGlzIHN0b3JlZCBpbiBhIHZhcmlhYmxlIG9mIHR5cGUgaW50LiBBIHZhbHVl
IGdyZWF0ZXIgdGhhbg0KPiA+ID4gSU5UX01BWCBsZWFkcyB0byBhbiBpbnRlZ2VyIG92ZXJmbG93
IGFuZCBpcyBpbnRlcnByZXRlZCBhcyBhIG5lZ2F0aXZlDQo+ID4gPiB2YWx1ZS4gVGhpcyBsZWFk
cyB0byBkZWNyZW1lbnRpbmcgdGhlIHBvaW50ZXIgYWRkcmVzcyBieSB0aGlzIHZhbHVlIGFuZA0K
PiA+ID4gc3Vic2VxdWVudGx5IGFjY2Vzc2luZyBpdCBiZWNhdXNlIGNlcGhfZGVjb2RlX25lZWQo
KSBvbmx5IGNoZWNrcyB0aGF0DQo+ID4gPiB0aGUgbWVtb3J5IGFjY2VzcyBkb2VzIG5vdCBleGNl
ZWQgdGhlIGVuZCBhZGRyZXNzIG9mIHRoZSBhbGxvY2F0aW9uLg0KPiA+ID4gDQo+ID4gDQo+ID4g
RG8geW91IG1lYW4gdGhhdCBwYXlsb2FkX2xlbiBjb3VsZCBiZSBiaWdnZXIgdGhhbiBJTlRfTUFY
PyBJcyBpdCBwb3NzaWJsZQ0KPiA+IHNjZW5hcmlvIHRvIGhhdmUgc28gYmlnIHBheWxvYWQgc2l6
ZSBpbiBvbmUgbWVzc2FnZT8NCj4gPiANCj4gPiBNYXliZSwgdGhlIHByb2JsZW0gaXMgbW9yZSBz
ZXJpb3VzIHRoYW4gc2ltcGxlIGNoYW5naW5nIG9mIGludCBvbiB1MzI/IEl0IHNvdW5kcw0KPiA+
IGxpa2Ugd2UgYXJlIGhpZGluZyBhIHJlYWwgaXNzdWUgYnkgdGhpcyBmaXguDQo+ID4gDQo+ID4g
VGhhbmtzLA0KPiA+IFNsYXZhLg0KPiA+IA0KPiANCj4gSGkgU2xhdmEsDQo+IGFjdHVhbGx5LCBJ
IGRvbid0IHRoaW5rIHRoYXQgYSBjb3JyZWN0bHkgZnVuY3Rpb25pbmcgbW9uaXRvciB3aWxsIGV2
ZXINCj4gc2VuZCBhbiBhdXRoX3JlcGx5IG1lc3NhZ2Ugd2l0aCBhIHBheWxvYWQgbGFyZ2VyIHRo
YW4gMkdCLiBUaGlzIHBhdGNoDQo+IHNoYWxsIHByZXZlbnQgYSAobWFsaWNpb3VzbHkpIGNvcnJ1
cHRlZCBtZXNzYWdlIHdpdGggYSBodWdlIHZhbHVlIGluIHRoZQ0KPiBwYXlsb2FkX2xlbiBmaWVs
ZCBmcm9tIGNhdXNpbmcgYSBtZW1vcnkgYWNjZXNzIHRvIGFuIG91dC1vZi1ib3VuZHMgYWRkcmVz
cy4NCj4gDQoNCllvdSd2ZSBzaGFyZWQgdGhlIENhbGwgVHJhY2Ugd2l0aCB0aGUgcGF0Y2guIFNv
LCBJIGV4cGVjdGVkIHRoYXQgeW91IGhhZCBhIHJlYWwNCmNyYXNoLg0KDQpPSy4gSWYgd2UgaGF2
ZSB0aGUgY29ycnVwdGVkIG1lc3NhZ2Ugd2l0aCBhIGh1Z2UgdmFsdWUsIHRoZW4gd2UgbmVlZDoN
CigxKSBDb252ZXJ0IGludCBpbnRvIHUzMiAtPiB5b3UndmUgYWxyZWFkeSBkaWQgdGhpcy4NCigy
KSBJdCBpcyBkYW5nZXJvdXMgdG8gY29udGludWUgcGFyc2luZyB0aGUgcGF5bG9hZCB3aXRoIGNv
cnJ1cHRlZCBwYXlsb2FkX2xlbg0KYmVjYXVzZSB3ZSBkZWZpbml0ZWx5IHdpbGwgdHJ5IHRvIGFj
Y2VzcyB0aGUgb3V0LW9mLWJvdW5kcyBhZGRyZXNzIGR1cmluZyB0ZWgNCnBhcnNpbmcuIFdlIG5l
ZWQgdG8gY2hlY2sgdGhlIGNvcnJlY3RuZXNzIG9mIHBheWxvYWRfbGVuLiBBcyBmYXIgYXMgSSBj
YW4gc2VlLA0KY2VwaF9oYW5kbGVfYXV0aF9yZXBseSgpIHJlY2VpdmVzIGJ1ZiBwb2ludGVyIGFu
ZCBsZW4gdmFsdWUuIEkgYXNzdW1lIHRoYXQNCnBheWxvYWRfbGVuIGNhbm5vdCBiZSBiaWdnZXIg
dGhhbiBsZW4uIEkgc3VnZ2VzdCB0byBjb21wYXJlIHRoZSBwYXlsb2FkX2xlbiBhbmQNCmxlbi4g
RG9lcyBpdCBtYWtlIHNlbnNlIHRvIHlvdT8NCg0KVGhhbmtzLA0KU2xhdmEuDQo=
