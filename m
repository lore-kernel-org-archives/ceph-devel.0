Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71CC2701C4
	for <ceph-devel@vger.kernel.org>; Wed, 20 May 2026 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302638; cv=fail; b=tktekq0ttAf0bwX7YRJunWgULmYqYInIYO2n1lc436wXXxEELz0BI/7jxg7vrlavUiSFMBCP4AOa4/Dh78hxbUmaJlXCTJmZuCeAw35UOhDX26Xv2srghyuXjsAMknC0OgorNJs7W+fUPeB/WTQEnYVkxEjiMaaeVTSyAAii6og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302638; c=relaxed/simple;
	bh=LoBqrFy86GcFk036gL2AIiJa2JeGFG19zoNCtXWWps8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=pLPVWXgGS0jjm9S1GofyOGSOtUQs3AzGqGBoHMpbZZMdZ8Fz4TzMbxcP24ixDxWfn5WU4Ci3kEY+FOwm7FGnOJlAKKSBMydlPxSXP0T1HPC8Ls6bM0hH4ooKU7dqM7J/nMJbfPkpFeaLBFUm5JRd1CDRr54xDN2Xf+uBx+6JE8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gl/PzAF2; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gl/PzAF2"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KA1agO2151966;
	Wed, 20 May 2026 18:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=LoBqrFy86GcFk036gL2AIiJa2JeGFG19zoNCtXWWps8=; b=gl/PzAF2
	EtNs1IEYhL5uKQBSjrMoNFNkaXcXSwtA+MwYmiI6hhlwB7nwIjiMxxPk2u8tP16E
	nFoj8NkJNn5XTr+9h3so6XteoWnovP0Uv5zLdn4KYJq1MtsuXK5evRa5D9Nzrl/E
	82hgrSDDjcvMx9FYyiOn2JGI6fLl9VLCBnXzN6B4rWiFBDis+19VNb4QZ5aEyXwc
	+cJAD0NW3ji35Ks5tQnqwc4uF8hfWwAXIcrH/wslWZxrDxUeth2J8u09Lgpp8CB3
	p9S29OR2BIoTrAM85eLncL3ytB54QKiA04569JIsVj14pWacwdfppPSgu4GfIpHa
	M4d9AYL1KTPuyw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y3hq2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:43:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evHcEMVI9wd1q0gsRIA9sEbHME9VWlJUYIH3aaD4mWkTHxtPju/9GJCdPgD8apBfVr0qCsPhY6AsgmEYK59ia9tsrjwm+nDn4emxEk5ACO3aQ5BVQYCxypDEXOSsK7MpxAA7c558SNWFuduHSKVC0d7U7lBgI5uPR0CK7EtRKx+9DrO3Lo4dAMPbxKFLTc6iil98mQqS3yd4bA2GDHuFBAPyngfHMaVQXrz3142xBtk9Gy1ugXzV9Q9D5v/g5fDkPO4VUvahSklCW/C1Ts4QD2heWDrq9rfNhMDzNetxpCU0b7kKGjR56icgZ2kXCVtBhcIu8qyORfYtkJprE7mtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoBqrFy86GcFk036gL2AIiJa2JeGFG19zoNCtXWWps8=;
 b=CySGnafuYTcflajChDhvqA8U7A/1hywC8fMKECewlvGNgHlhNqRLVVBVkPT421ADZUIWW+bOF+x1fc9jEckLpmW6bNR2GwNLBAlvwFuA1QKxyrSij3uiTD4iRPqUMetG6UyOCrCHGD3+xm8poYtS37wu2jZTqPTBshluNNOoXzVK1VBS44rx95Yh1XVbTeAbEOPqTH8qkkPXM2MhFTowHfPeo8tHGmBwHxM2SK3KNkW25aBEzD+/oeqAoICgehy5WBXnC03XRmdAgoJ4POIduXXigqruL9ROa3IwwO+DQNjNa0zYyIir4lRats39HmVQma06zV9okW8fe/dxxKklQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SN7PR15MB4205.namprd15.prod.outlook.com (2603:10b6:806:100::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 18:43:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 18:43:52 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: "dongsheng.yang@linux.dev" <dongsheng.yang@linux.dev>
Thread-Topic: [EXTERNAL] [PATCH] rbd: eliminate a race in lock_dwork draining
 on unmap
Thread-Index: AQHc5+V/0t3U8tx7J0GT5bOgk4+cOrYXQWiA
Date: Wed, 20 May 2026 18:43:51 +0000
Message-ID: <58005a9093aec35a77e70b9eee012f5599d3b9f1.camel@ibm.com>
References: <20260519230820.1459703-1-idryomov@gmail.com>
In-Reply-To: <20260519230820.1459703-1-idryomov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SN7PR15MB4205:EE_
x-ms-office365-filtering-correlation-id: 96ec991d-b966-4cff-9d86-08deb69fbd09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|18002099003|22082099003|56012099003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 t+N0/pYU55/HYuFIw5xsBUByBZE9DhvFSyn2z3qKbHQHdc9lYQ8UASulMebUly5ktXS9/Ptb1mR7xi8wROlwhreMoD3Mhsc48rXLhIDchOX7BmT1u8vGwA5/QIe91Hh37eYqcSEkhHVSXc/yNbPKyLllXHGXbb09I26J2ueUXlX4B7aphF9eQBYc+va26xr85zRAlgetNeaTdsnRkhKuNNAfCv47sMHLwS8IynUZLFl8F5qqe1JhFNZBJc4xTFTR/CQ0liEzhf9l4R8/hgL4xoNIGiemxq8BRLSK9HD1q0I9UnjKvBTdubNUyvvTQ+GvgNkWjTV5Xh2c3LxgQgmmnLeoeoT63mnWpj3r9+LTrO3pymktTsUVXclQiB366WKVvAM2E4s4LE0qmUYlNWBsfR32+JdNq+UVr3ypL7ea9g7hGlUgnEuJqzmgvkTEwfrB4FT0awZiOEuxbu876y/L4+9DZuy1gc3MG81A4mrP6zcdS1ru5kGiWLLSg5oG7WUYK4uTIRulzs5bqaC1CVCgS//SQbLlRXzi7YakF5BXbCRVpyjAWJH9a2+FOurPIlHQVNsx5a/pzBOfIDcS14m52VMVMb4C8rgL8RKhGZPIyzEK+RXvC+RbxLsmQ4RN/PBA+8ZPUh2byeftvup14Jyz617t4+CV4RlYPtv1FZ1O/RqOm6b33n0RmXeZxKIQ6xIz7u8NT3SgQRiJqCZv0MZXNiMig0/Sm3eutLl8urmT3yfpiZNAk+z3wlXdTHH5bk0A
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(18002099003)(22082099003)(56012099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW5CTllsLzl0V0tGc0k1LzlqcTZxSTRxdU5YcFlrS2FucEpFN0FmL05YbXhF?=
 =?utf-8?B?Tk1pbzBnNjNFTUNhNWJYekNiUG1tV01qSHF6OENmZE9peTdJdVlRc1Jtb2ZI?=
 =?utf-8?B?Q0dqcVZGLzdMK3RSM2xBM0d0NUNVM2ZGbDJGMk4rNm5KNmFoa1BOc1J1ZlNT?=
 =?utf-8?B?TnlLY1ZjejV2cm9TYXBVWUJKQjIrc2Y0d01xcS85bFp2TW81S0ZUUy9VMEl5?=
 =?utf-8?B?ZlZmT2lLQktqa0cvTU8vZnhVY0NNblo0YzZCSkpucFhHcVNkcUZZSUdoaHFR?=
 =?utf-8?B?STFNRHFESS84dnVsVlpuNnZySndNbEM4YlhWakN2WW9KTDVVUitZYUFQSXA3?=
 =?utf-8?B?ZThicEIxMlpKMTh0dm4zQS9ZdHNOOEozbmltc0VmWktId0c2ZWdJbVRwOXZj?=
 =?utf-8?B?bkIvZ0lvdXFiN3R4R2RyR3NBZS9jczV5cjFxcVBMNHppZ3o1QTBNd3BONmdv?=
 =?utf-8?B?N1FSditpNjIya1o4UngxUHBJQ0FicTg5T3lkemYrTlgyd2R2QUFKbHJxTTI4?=
 =?utf-8?B?TGpDK1EyYTBIWXpmVTZiSzFWMmViMm4zck8vdUx6YlhXTlpPaDlOMThiR0Z6?=
 =?utf-8?B?RHpCVGUvb09BaDRoY25LL0hiSGp0bjBFc3V5d2E0eXdORk1iTm9TRGp3TDlD?=
 =?utf-8?B?UVBQRThCRUlWR1JQUHltKzZKSGFCK2IwRjVqYnh2Q2E1WXVuWjlPc1lrcXVk?=
 =?utf-8?B?S01jaHpNQW9UanBKcFZ3RWt4RGRHT3RDK2FnUHlVdUQwb0o2V3JqcitTV1k2?=
 =?utf-8?B?VHVkQlJpMExRUHpwWVh6bGM1d2dqREtVTTl1U1JHTVpRVVBoSnpaVGhTUTlm?=
 =?utf-8?B?NWlkNEJlUldTcTJkVXFDRlk5WXUzb0pGK3BKKzdBUnRSSzk1K2o2NW5IRW43?=
 =?utf-8?B?eUFEZEoydjdrZ1RaODFxWEMyemxlZDhHZkl3VktOSmpjdnFUUElkTlVPcWc1?=
 =?utf-8?B?aDlKVTJaM1JYMDZOTVdWVGVXT1lTL1JzdnRrWExRSVdlYTQzVzc1bDNGOFkz?=
 =?utf-8?B?blNwTTJWTmZSNW1sZDg1NkxvOFhCSkdKV0JMSFIrYlAyMnpQeEYraDBTa1pq?=
 =?utf-8?B?bHhmV1Q1ME9HQkswM2VqYjlTVnIwbDZldmNYSlJ5YzJNb3g1STNqakRPeWUw?=
 =?utf-8?B?dWRteU1weWJFRGpzSy9PWGdSSlNCbWcwRXVaam1NZ0NWWlRYUzNlSXVrY3ZZ?=
 =?utf-8?B?Nm40NEpoR1d0NVcxMFp0ZzU4VUM5SVBRL1V4aEE0SEtyd28waitEblBLZEY1?=
 =?utf-8?B?M2VzemNkWkU2S3A0MGl4Vno5bzVteUpucWhoSHlXN1pZVXJiY2VXT3YySW1Y?=
 =?utf-8?B?b3RxUE14bWVkMnVQOVBEOUNoOWgzNGRyOENCZWhsSUxlNFJ4RTFCaHZHSVZR?=
 =?utf-8?B?TWdmL1RzNmRwSC9CNG0yZ3FNMitsT3VyS0hKbS9rNHNOdzFCMzJ1NUp1QVFF?=
 =?utf-8?B?UW5HYkt5Z2s4cERLbWVOWG9qNFdHeXEvSDdTUFVqRUdNOGtKTjNhc2xidVdU?=
 =?utf-8?B?Yy9MSWo1T2gwZStWamxqMHpVTWNMMXZDb2JqY2YwN3RPZUJlNVA0c1N0MTJl?=
 =?utf-8?B?dXFaQzJYQW1QZmNaaE9ORGFRVjVORzE1UENtNTNUUUI4SUdrM2tpbThjcW1G?=
 =?utf-8?B?RlMvZ3dCRmYyZWZBc0dOWnFYc0g3ajNxZUZKZi9QdTAzYUdBZ3IzTVhMUTdM?=
 =?utf-8?B?YnpLS3RVL0xWT05OdENjZWY2WjRpWXU2RC9zUmwzUUIwZCt2NGphYnVVYmlO?=
 =?utf-8?B?MmkwTVFSd0lUVG1RclV5U0xRdnJuMGVrOVlBMy90UXlkc3k5N1V1eVdxWHlj?=
 =?utf-8?B?L1YwS1JsMG85Qml6VlBLTkE4OEx3SnlPb21BRzA4ekhXL3lSelNDTFo0aXhG?=
 =?utf-8?B?SkxhNjE0RS9xam1obHJ1VmVScCs2dVBGaXRBVE5KZlBGcTl5c1I0RHRrVCtm?=
 =?utf-8?B?S21BQlNrWUxqZUtaQlM2akxDRm16TkQ0b3EwcUUvY0RudTFCYnA2bU4xaEtQ?=
 =?utf-8?B?RWNBRHdhSXZ5QWxWL21KeUhlUDNFY2htQWNGd2JBMysrMTNKMU5xMGFOMTYx?=
 =?utf-8?B?cWVva2dGQ3BZbVZMbExnZjVJcnFlZ295cjVIVGhBQjN2aFpJd3RqNk9XMDVY?=
 =?utf-8?B?WkorejRKNklqUWtUODRzdkJGYXVWbDdXLzhNUUYvYUNoSU9Oa2ZSNGRsREFh?=
 =?utf-8?B?dEF3UTRzOFR0TGl5ODlEZExKWjFQa2ViR0VzejZmbmlvOXpSVXA3ZitIR21I?=
 =?utf-8?B?MEp0YUhDT1V2M0tZaDViSGZUazg3RVlpU0Q4NUw5bmFOUWw0dTRWS2hDVUQ5?=
 =?utf-8?B?VkdZOStyQml4dWJybldjaDUzOHExT1hZc01ZRy9aWnlEcThTcllMdkt5clZu?=
 =?utf-8?Q?lQEpVCIFaX9kHvmsOYLhDMMh/4f1G3zwQvHpd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <433E30C4BF297E438192043A5A3FF35A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	tH9yLVcygK7zrinqQIQJf2yr6xx1TRVjp4oZ64YLJknbg2zJts5PAspugqMhFCZ1pOKgpPqInu9N86PkrIqhgfuIDC88OAZB5uPXUt2ZcN2G7W4ODSicVHyOlK1qreGgWvqtzbHdIn2n0BmFlmaPyPopL//qSDsX6eGC7FbCK8DSO5zY/4PhL6yOI5gs7hLmHbcq5a4gubtnIiEuoIPVvjaDvvT81QCH0SRpM43BDbRByr3n7UFSrbQTGv5Bksxlaa5B06TZCOCtz+9pjXXLzkfKuA2WD1kYTmA+Wz7xLTk8WEz378QG7IlQMP7N8y5bRhDh5QId43tAH0Ib0Km3VQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ec991d-b966-4cff-9d86-08deb69fbd09
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 18:43:51.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: puwBbJ56QiniGgpnAG0mNXPWkqTX2/H09bVq1Qh2dTHE5NINd1OuLB82Fce3WgL1Jd4gOCHo1rE3UuJX3zaOpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4205
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE4MiBTYWx0ZWRfX2IazBzU2JNun
 VoeBi9NEPXILGqfSiqmyoIKLEfxnZVTWuhSKjW4Xdmpvx8jLkkf4fnGv/TkWFytmQjU+dRKxe5M
 AWdfkPGTTjxtj87IBYGRNtSeAiFSG9CIHX+2PN0yPzGoUzd1q40K1zLf7eyFz/pLXPCT0JuKxph
 Gwm6Bbb8KKKK9gn7bOE7kJGv7HgHnFqBaRCNFmMwWwaVAs9gA8MmegFtgXN+ACRimNsA8zErAjH
 W5SEOQqXuXziaI1zjpPekzgYRuWjX3QSezysDR3e5I7vSPIsLzny4S6QO6Z5yKcoBobryy5GatT
 tnHj2aRhOa0BwtTewuReQ1uQANAcH/UsN/CyfW4I4vzBmtSbos1Iuq+Qwyl7sdvNZ8guFMhc7pL
 t9Rm9dLkgXkPtZYLr3otrmThIv8oDB0rUWtq+1yiQOOXJaI/AVS5Vnt3xqxGa0mww0pHKfxCKVO
 eLuw6xCSgxaYOHe1MnA==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0e00ea cx=c_pps
 a=NvljgnbIoj+kJW4KAcm4xw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=jgFxxbE7Q793gxvOqKwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hmcMFsXVbdrMyycxOh_fozwQxfEyt0qQ
X-Proofpoint-GUID: xWzG8a3ZrVCKLjHvPEgnjI2w7GGJz7rQ
Subject: Re:  [PATCH] rbd: eliminate a race in lock_dwork draining on unmap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200182

T24gV2VkLCAyMDI2LTA1LTIwIGF0IDAxOjA4ICswMjAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IEdpdmVuIGhvdyByYmRfbG9ja19hZGRfcmVxdWVzdCgpIGFuZCByYmRfaW1nX2V4Y2x1c2l2ZV9s
b2NrKCkgYXJlDQo+IHdyaXR0ZW4sIGxvY2tfZHdvcmsgbWF5IGJlIChyZSlxdWV1ZWQgbW9yZSB0
aGFuIGl0J3MgYWN0dWFsbHkgbmVlZGVkOg0KPiBmb3IgZXhhbXBsZSBpbiBjYXNlIGEgbmV3IEkv
TyByZXF1ZXN0IGNvbWVzIGluIHdoaWxlIHdlIGFyZSBpbiB0aGUNCj4gbWlkZGxlIG9mIHJiZF9h
Y3F1aXJlX2xvY2soKSBvbiBiZWhhbGYgb2YgYW5vdGhlciBJL08gcmVxdWVzdC4gIFRoaXMgaXMN
Cj4gZXhwZWN0ZWQgYW5kIHdpdGggcmJkX3JlbGVhc2VfbG9jaygpIHByZWVtcHRpdmVseSBjYW5j
ZWxpbmcgbG9ja19kd29yaw0KPiBpcyBiZW5pZ24gdW5kZXIgbm9ybWFsIG9wZXJhdGlvbi4NCj4g
DQo+IEEgbW9yZSBwcm9ibGVtYXRpYyBleGFtcGxlIGlzIG1heWJlX2tpY2tfYWNxdWlyZSgpOg0K
PiANCj4gICAgIGlmIChoYXZlX3JlcXVlc3RzIHx8IGRlbGF5ZWRfd29ya19wZW5kaW5nKCZyYmRf
ZGV2LT5sb2NrX2R3b3JrKSkgew0KPiAgICAgICAgICAgICBkb3V0KCIlcyByYmRfZGV2ICVwIGtp
Y2tpbmcgbG9ja19kd29ya1xuIiwgX19mdW5jX18sIHJiZF9kZXYpOw0KPiAgICAgICAgICAgICBt
b2RfZGVsYXllZF93b3JrKHJiZF9kZXYtPnRhc2tfd3EsICZyYmRfZGV2LT5sb2NrX2R3b3JrLCAw
KTsNCj4gICAgIH0NCj4gDQo+IEl0J3Mgbm90IHVucmVhbGlzdGljIGZvciBsb2NrX2R3b3JrIHRv
IGdldCBjYW5jZWxlZCByaWdodCBhZnRlcg0KPiBkZWxheWVkX3dvcmtfcGVuZGluZygpIHJldHVy
bnMgdHJ1ZSBhbmQgZm9yIG1vZF9kZWxheWVkX3dvcmsoKSB0bw0KPiByZXF1ZXVlIGl0IHJpZ2h0
IHRoZXJlIGFueXdheS4gIFRoaXMgaXMgYSBjbGFzc2ljIFRPQ1RPVSByYWNlLg0KPiANCj4gV2hl
biBpdCBjb21lcyB0byB1bm1hcHBpbmcgdGhlIGltYWdlLCB0aGVyZSBpcyBhbiBpbXBsaWNpdCBh
c3N1bXB0aW9uDQo+IG9mIG5vIHNlbGYtaW5pdGlhdGVkIGV4Y2x1c2l2ZSBsb2NrIGFjdGl2aXR5
IHBhc3QgdGhlIHBvaW50IG9mIHJldHVybg0KPiBmcm9tIHJiZF9kZXZfaW1hZ2VfdW5sb2NrKCkg
d2hpY2ggdW5sb2NrcyB0aGUgbG9jayBpZiBpdCBoYXBwZW5zIHRvIGJlDQo+IGhlbGQuICBUaGlz
IHVubG9jayBpcyBhc3N1bWVkIHRvIGJlIGZpbmFsIGFuZCBsb2NrX2R3b3JrIChhcyB3ZWxsIGFz
DQo+IGFsbCBvdGhlciBleGNsdXNpdmUgbG9jayB0YXNrcywgcmVhbGx5KSBpc24ndCBleHBlY3Rl
ZCB0byBnZXQgcXVldWVkDQo+IGFnYWluLiAgSG93ZXZlciwgbG9ja19kd29yayBpcyBjYW5jZWxl
ZCBvbmx5IGluIGNhbmNlbF90YXNrc19zeW5jKCkNCj4gKGkuZS4gbGF0ZXIgaW4gdGhlIHVubWFw
IHNlcXVlbmNlKSBhbmQgb24gdG9wIG9mIHRoYXQgdGhlIGNhbmNlbGxhdGlvbg0KPiBjYW4gZ2V0
IGluIGVmZmVjdCBudWxsaWZpZWQgYnkgbWF5YmVfa2lja19hY3F1aXJlKCkuICBUaGlzIG1heSBy
ZXN1bHQNCj4gaW4gcmJkX2FjcXVpcmVfbG9jaygpIGV4ZWN1dGluZyBhZnRlciByYmRfZGV2X2Rl
dmljZV9yZWxlYXNlKCkgYW5kDQo+IHJiZF9kZXZfaW1hZ2VfcmVsZWFzZSgpIHJ1biBhbmQgZnJl
ZSBhbmQvb3IgcmVzZXQgYSBidW5jaCBvZiB0aGluZ3MuDQo+IE9uZSBvZiB0aGUgcG9zc2libGUg
ZmFpbHVyZSBtb2RlcyB0aGVuIGlzIGEgdmlvbGF0ZWQNCj4gDQo+ICAgICByYmRfYXNzZXJ0KHJi
ZF9pbWFnZV9mb3JtYXRfdmFsaWQocmJkX2Rldi0+aW1hZ2VfZm9ybWF0KSk7DQo+IA0KPiBpbiBy
YmRfZGV2X2hlYWRlcl9pbmZvKCkgd2hpY2ggaXMgY2FsbGVkIHZpYSByYmRfZGV2X3JlZnJlc2go
KSBmcm9tDQo+IHJiZF9wb3N0X2FjcXVpcmVfYWN0aW9uKCkuDQo+IA0KPiBSZWRvIGV4Y2x1c2l2
ZSBsb2NrIHRhc2sgZHJhaW5pbmcgdG8gcHJvdmlkZSBzYW5lciBzZW1hbnRpY3MgYW5kIHRyeQ0K
PiB0byBtZWV0IHRoZSBhc3N1bXB0aW9ucyBhcm91bmQgcmJkX2Rldl9pbWFnZV91bmxvY2soKS4N
Cj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IElseWEg
RHJ5b21vdiA8aWRyeW9tb3ZAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvYmxvY2svcmJk
LmMgfCAyMCArKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9j
ay9yYmQuYyBiL2RyaXZlcnMvYmxvY2svcmJkLmMNCj4gaW5kZXggNDA2NTMzNmViZDFmLi42YzFl
NzM0N2U2YTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmxvY2svcmJkLmMNCj4gKysrIGIvZHJp
dmVycy9ibG9jay9yYmQuYw0KPiBAQCAtNDU2NSwyNCArNDU2NSwxMiBAQCBzdGF0aWMgaW50IHJi
ZF9yZWdpc3Rlcl93YXRjaChzdHJ1Y3QgcmJkX2RldmljZSAqcmJkX2RldikNCj4gIAlyZXR1cm4g
cmV0Ow0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgdm9pZCBjYW5jZWxfdGFza3Nfc3luYyhzdHJ1Y3Qg
cmJkX2RldmljZSAqcmJkX2RldikNCj4gLXsNCj4gLQlkb3V0KCIlcyByYmRfZGV2ICVwXG4iLCBf
X2Z1bmNfXywgcmJkX2Rldik7DQo+IC0NCj4gLQljYW5jZWxfd29ya19zeW5jKCZyYmRfZGV2LT5h
Y3F1aXJlZF9sb2NrX3dvcmspOw0KPiAtCWNhbmNlbF93b3JrX3N5bmMoJnJiZF9kZXYtPnJlbGVh
c2VkX2xvY2tfd29yayk7DQo+IC0JY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZyYmRfZGV2LT5s
b2NrX2R3b3JrKTsNCj4gLQljYW5jZWxfd29ya19zeW5jKCZyYmRfZGV2LT51bmxvY2tfd29yayk7
DQo+IC19DQo+IC0NCj4gIC8qDQo+ICAgKiBoZWFkZXJfcndzZW0gbXVzdCBub3QgYmUgaGVsZCB0
byBhdm9pZCBhIGRlYWRsb2NrIHdpdGgNCj4gICAqIHJiZF9kZXZfcmVmcmVzaCgpIHdoZW4gZmx1
c2hpbmcgbm90aWZpZXMuDQo+ICAgKi8NCj4gIHN0YXRpYyB2b2lkIHJiZF91bnJlZ2lzdGVyX3dh
dGNoKHN0cnVjdCByYmRfZGV2aWNlICpyYmRfZGV2KQ0KPiAgew0KPiAtCWNhbmNlbF90YXNrc19z
eW5jKHJiZF9kZXYpOw0KPiAtDQo+ICAJbXV0ZXhfbG9jaygmcmJkX2Rldi0+d2F0Y2hfbXV0ZXgp
Ow0KPiAgCWlmIChyYmRfZGV2LT53YXRjaF9zdGF0ZSA9PSBSQkRfV0FUQ0hfU1RBVEVfUkVHSVNU
RVJFRCkNCj4gIAkJX19yYmRfdW5yZWdpc3Rlcl93YXRjaChyYmRfZGV2KTsNCj4gQEAgLTY1NDgs
MTAgKzY1MzYsMTggQEAgc3RhdGljIGludCByYmRfYWRkX3BhcnNlX2FyZ3MoY29uc3QgY2hhciAq
YnVmLA0KPiAgDQo+ICBzdGF0aWMgdm9pZCByYmRfZGV2X2ltYWdlX3VubG9jayhzdHJ1Y3QgcmJk
X2RldmljZSAqcmJkX2RldikNCj4gIHsNCj4gKwlkb3V0KCIlcyByYmRfZGV2ICVwXG4iLCBfX2Z1
bmNfXywgcmJkX2Rldik7DQo+ICsNCj4gKwlkaXNhYmxlX2RlbGF5ZWRfd29ya19zeW5jKCZyYmRf
ZGV2LT5sb2NrX2R3b3JrKTsNCj4gKwlkaXNhYmxlX3dvcmtfc3luYygmcmJkX2Rldi0+dW5sb2Nr
X3dvcmspOw0KPiArDQo+ICAJZG93bl93cml0ZSgmcmJkX2Rldi0+bG9ja19yd3NlbSk7DQo+ICAJ
aWYgKF9fcmJkX2lzX2xvY2tfb3duZXIocmJkX2RldikpDQo+ICAJCV9fcmJkX3JlbGVhc2VfbG9j
ayhyYmRfZGV2KTsNCj4gIAl1cF93cml0ZSgmcmJkX2Rldi0+bG9ja19yd3NlbSk7DQo+ICsNCj4g
KwlmbHVzaF93b3JrKCZyYmRfZGV2LT5hY3F1aXJlZF9sb2NrX3dvcmspOw0KPiArCWZsdXNoX3dv
cmsoJnJiZF9kZXYtPnJlbGVhc2VkX2xvY2tfd29yayk7DQo+ICB9DQo+ICANCj4gIC8qDQoNCkFz
IGZhciBhcyBJIGNhbiBzZWUsIHRoZSBtb2RpZmljYXRpb24gbWFrZXMgc2Vuc2UuDQoNClJldmll
d2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCg0KVGhh
bmtzLA0KU2xhdmEuDQo=
