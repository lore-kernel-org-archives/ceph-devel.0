Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53D35949;
	Fri, 10 Apr 2026 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775853998; cv=fail; b=UTmvs9Br01MaC32o2//N6ifYWMrSB7ZAUStucjtWZY8rQEYGxqHi6Ui4cOwvKC3bXPXvfFe805lvr9he9uyt4b6KwRyQ7Dt6Br/kkmMVqsyk/AqNYvxYxS7i09eFPYzCHkMlp429zGkVHyP5dd3bVw+RRZ8HKoUvesTqsr8rLB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775853998; c=relaxed/simple;
	bh=OAur+qmyS87yfRRyNFEkWeAv+dFapRZnGvl+KJVc8fM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=SNkQ7ykfQhJdq1Ke98XFv8MF3b5soggDc4ccwSCFXLX7RxB7DFI2BPVjBXQq8UZo2ZGm1/n8g/8m8DMonHy3+ZI4k2ctQGy5I9WrTmRGhz+Tx02mEA9jCPL7za/Txeo1WUd2yhNgbUXaZeQKFsEaEjOhe7dAjj/qWTEZsxH1F98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lmPnFN5h; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lmPnFN5h"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63ACrL2f2592193;
	Fri, 10 Apr 2026 20:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=OAur+qmyS87yfRRyNFEkWeAv+dFapRZnGvl+KJVc8fM=; b=lmPnFN5h
	OxRljSNllZWOCyFX9Jpm0h8u4QCebf0VWWgXAJn/2HgUBTFnIIvInY4+oKcyP8mS
	pZlPjaYnhtXdNTpQw0uYhbg/Wgsxvz8WAl+0vIRUVjajFnNyRxpTQ3c/K7mjA01U
	oTQN8UbFG3Bmu6B2Awu6rwoDQNlloaUEXQKY8lCYjEAoqk8ejKeGwcEV8RJSNKRZ
	HyncAvUDI8AY43OmuCc6Ys6zuhi8hUHdKQtifyIHDudEZNBI6Wk1Za5Odyc2XApX
	/S6Ihv1z8CoIEMXYKurmiIuRUUYsOrhwN5JOlwU0kMIuDZW42teP1kwEGx2fy7Vs
	I0E54diAdohulA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010023.outbound.protection.outlook.com [40.93.198.23])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2em5ud-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 20:46:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3U22zHZG9OScWGr/QmQgUnDWXavjOXx9+OlXvZ16FEugbKJeDdyYxJ+msoYAO2evBsnDJybbc42pIrAvId46ywL4vHqgNC0/Gk4OKWVMNeUh6LuwSmJ2PU582KaLXx3U5HrhMLU2/nb3wGFuBQ63w0vLTuS3LspZHXg9tnvPCfwba0SeGxQyo+vmGPlniFaGzpAH3bX883eQF+pBOGXCIGGgkd6PmTVqMhGX/4ardVGtm3165aYyz+voOBP3CkOC+5vwjc3S9VJ/pmXVFTDl/Ek7Y2jxpAmc4q/5/bjy+v7BtaqSJPeNSyZdrabHI5X6TUVmFOu00sML7eE8OriJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAur+qmyS87yfRRyNFEkWeAv+dFapRZnGvl+KJVc8fM=;
 b=k/pcJKTdpfk/7lxIVZOJj1slA9bg7S6qKbEcoyI0Cne9zjSDQPYDCvoXllQy0aI/MG8+9HlRzpASzE/0f01RElqDK0tkZ76pLxbRvyk9l+mQAwf1QnD7GaMdtM6vHCYWZmjeUMQohWL7FeB2+GZ7Ntn1Xd1QIWY0xhjksZwrYkMRIGsG3JWlGs/zuDrtgHhrBGm4vhJsBCSXhNiVsscneOWrqttC+MqTLuypvPA2Q7kKwCCRQCLTuG38abJ6kA5BUia611Ub/kWsv4eRKKmNSp9fowrygcSVqYiHumjJKZa7WNuhMk8d5mG9BrEWNluvuM+x327tTV9qt2BmkXFsOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH0PR15MB6116.namprd15.prod.outlook.com (2603:10b6:610:18c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 20:46:27 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 20:46:26 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re:  [PATCH v4] ceph: bound encrypted snapshot suffix
 formatting
Thread-Index: AQHcySo783MRKNnaNk+uqwxflFbjYrXYw92A
Date: Fri, 10 Apr 2026 20:46:25 +0000
Message-ID: <7e043aa928f13d043552ca650808c0383209f806.camel@ibm.com>
References: <20260404101003.3-ceph-pengpeng@iscas.ac.cn>
				 <20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
				 <20260408093001.1-ceph-v3-pengpeng@iscas.ac.cn>
			 <20260409110001.1-ceph-v4-pengpeng@iscas.ac.cn>
		 <f957bdf6488b391b4329ff3cc892bfdc93c014fb.camel@ibm.com>
	 <847376cbf4408d12389545142311cb5883045937.camel@ibm.com>
In-Reply-To: <847376cbf4408d12389545142311cb5883045937.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH0PR15MB6116:EE_
x-ms-office365-filtering-correlation-id: d56a9d52-e5a5-42e5-9827-08de97423bcc
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 cJkxKal5wvuhdr5CRe4dsINjRYSw5SNx1j3PWNnwHHMtSWAR7oA59953sDDcnd0ppP46VVE9m35oR3Z83WCmf94kjCvrEQXcsz7TCa0gbO2l/VsRqSTzSvZ1QsjuZnUBqhhBtXGw5KPgnPJCAQNoATcUaBWZE//97D+ICu9L+F5NaBAFzIrx0FAH3fe7I2zJlzYymQxOHChRW3rCheBJ8zc/cBApPh7YW1jB+9a8TFB9DzRRkfIyz/PCrINhRE3mTXaBtMRWlqpfFunUxJVztr9ZosdZSmLQY/8dD0XMcDxKFDxPm0pvlC+MAg8SNNZE9PuI6Hj/kD7WnT8zj6l4XjemX3b6smrcg/jknp/dAUXObzOGUzuVq03D4FKoQ0fmdzEXSINd246FqJAuxisSedFD9O/u06S9AT7lIgkhB838IvBhLXdZK/oVUJYulT5mpdcKOHrikpfX5fQV/LmmeJuseMPGdkRYCvY4XKlBdX5pK51swsVHtiAwKajSLFlLaCowdq4fX5C0qefVbLttDltS+MtWGmyxhdTnwKCcp49XriMT5iEYTOtmQJe41aCWg/Yt74RQbmn4RuWipMuEByLkqjUOtsP1jhHAnddLElsi319GCco/P62KyM+o4EXb65B1gB3isDXyw3iNuX347a2C0YSKcnzNCYfZF3ytKGolqAIjn6dJvukaLQnQraz55ZF2wVh5BLn8I5lL+N2YErV2Oihgxew9nCYvZd5BDV9+7dsKS3236VIaJJXwcC1X4aGuVIkyz3nCkyx5OpR12s7jq6W1cdFopssdAD6WJBE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2ZtdW85THFKLzIvdm9yUUt2d09LdmRZSllVRHNoalVLZGJOams4SmNpZGRq?=
 =?utf-8?B?cEVGZW5Iemh2SjVaQk1UTHhyQVNGd2xpRzU0d0pEMzJrR0FMajFzWEpOcnBs?=
 =?utf-8?B?S2dFdTNrZVNzRWlMNFJNMFJsVTNwV0Rab2h2SGlYZFZITGlZOGJWQ2xUQVdz?=
 =?utf-8?B?MVVSdHhvMFltKzB3dnY0cXdTZWpVbHA1SVZJQjBHb1MwcC9Qb0p1c2taWm1L?=
 =?utf-8?B?RGgvcTRsM0l4b3JDUEFZRVZWRitPNlVoSldBSXN0TGRCK1pkQWpMUVlIakND?=
 =?utf-8?B?dDlmV0ZiTnk3VlhYUEFYbWNPUmhTUXNmem0vRDhyTXpRSjFkTlZ5MkJsSFNU?=
 =?utf-8?B?TUZRQTkzOXpZUVQrTjl3SGVocFoxM1NCVDR3Sm16MVdBZ3VHUEVDMkMzZWlj?=
 =?utf-8?B?UlBCblBBSmxBWnlqMDZCSjNZcDFlQW1TbnR6SzVEZEZFN2ZMdVZpTGl5YW5B?=
 =?utf-8?B?eGk1QTFBclpxbWhrTG5pcE13cFVxN3FGM0dMOFJHU0hmajlIdXlwVUFzZ294?=
 =?utf-8?B?Ri80TXhqZmtIVkRnNmVrY0l0NXErMGxYTk5YYlBXdmZ2VEZ5ckNGR2JSNGFT?=
 =?utf-8?B?TE8xZllhV2tOL2ROUEthOE1Dank1NXFjMVRKMGZlcDh4L0orb01PYUdnc2x2?=
 =?utf-8?B?dlJuMFJQTVkvanJHaXRGNUFWQlkwdlNmV1RhYTNHZi81SkxjTkROcUpBWTlu?=
 =?utf-8?B?QnVBU2pWbXNhRnR1cjFuRlBtRlNRUmlpOUJBMHU2cys3UU1ibUl3Y3luV0Vl?=
 =?utf-8?B?YVFpakxUTDRTblBoRFFkMEVZdWxZeWt1NEwrUGtRM2hXK2J4eWtFR0I1em9E?=
 =?utf-8?B?N2dvTlIrd1AzTlRjcW9PWFVCNFRHdGh2OTBRZ0xNWUx4VHFBdlM3RVVmcnhn?=
 =?utf-8?B?ZUVmRm5PT0tzcXRUc1ZNUnF2WUduT0tUeHdneHpjL1g3T2pwOUtJNlFZdjds?=
 =?utf-8?B?NFhsVlN2dWJOMXd6UEJhSTlEdHVCbTRGMGNrcFIvY0QwWGI1SFhIT1grWUha?=
 =?utf-8?B?a1cxTkgwUVYvQldHQ1lveVRtb1I5dkhIZStxdVZTME1sa0hDdlR2dFZnOXly?=
 =?utf-8?B?Vjd1NGlUVi9VOFMwaHdLUC9MMm1Va083cEFrQ0xGYnplSVc4QVZaak44QjFZ?=
 =?utf-8?B?ZEs4YWdKUU1PUzREdXZVWmhqWjZjUFIvZnp1NC9RR1J6Vks0eTdBUU1hS1Vv?=
 =?utf-8?B?Y1o0dHBmZmdVTjNzSXJLZkNHanozeU9QUmtSSDdabWoxbE5KS2tDK3lBcTlX?=
 =?utf-8?B?NTFUVlA1Qjd1WGVxMEkwM3V0ck1sMFRhb1NuQlMyQ2RqNEphZEJhQUh1c3lF?=
 =?utf-8?B?dGMzcG1hV3dSOFQ5L2tVNTQ5bHpVRzYxTXVjeHYzZ0Vaak1NbDRsbDJsaFhW?=
 =?utf-8?B?Unp6Wi8wT0VxTFBQa3YrYTF3WG9jck4ySXlHWEcwTURPU0dlNkJjdzJ1NW9Q?=
 =?utf-8?B?bis1d1crTjI4NS9hQlQzTTVQU1lMaVpyY01jMzlGa2cvWCs3OG9id2YwWitt?=
 =?utf-8?B?MDA0ZFh2My8rQTc3VFdxTEVIZDB1ZitpNDExR05WdE9ibFdWSFVTb083aDA3?=
 =?utf-8?B?TjNlQ3E3WjVFd2N4eUVUS3pmaXR0Sng4Z2hSWEtqMHFaZGdhQzQ1OUN4TmRS?=
 =?utf-8?B?eHMrNDJleXFVWHJpSkVWMFJTSEplak9mT3pYcXZWZmU1VlhRTTNNc3kxOFNr?=
 =?utf-8?B?UjVSR0hVaUpBS055M2U0S3lQbWNlYlFyKy93YUlRNXU0Z2lZWkZtbEFRMUhL?=
 =?utf-8?B?NGxZV0E1azlEdjJvLzY1aXkycGd6dE41TjVwUUtka3VPc1dsZWZsS1ZHTzk3?=
 =?utf-8?B?bVhpQ1BwelFZS0V4c3VJSGY4R3pKaWpIeG9aQWNlL1BPamowTWFzeWdsZkEz?=
 =?utf-8?B?T2N1b0EwbTl5MFZPNjJQMmRXMndmN2Qya1orKzd2bEtGK2tJc2k5TTV3L00x?=
 =?utf-8?B?T2Zzd2hMbW4wR2F2UEhERG9lNW04RmloMy9aY01UTCtBVURkRzNXOE45eWRG?=
 =?utf-8?B?SXlncFZ2RS8zMXBYdjAwY2ZTdUNtQ1BJYXNJeE1hN0hZc2U1MjZjVnprRWZq?=
 =?utf-8?B?cGJkZTZDditGQVlaMTgyVHhiczRjV0JVSnp1TWo4cFBGS1FkMmh1bDNqTWlu?=
 =?utf-8?B?ZWVad0NtQzZVSzd1emZhRmErUkt3UWRjTmdRaWpaeFlOVHU3ZkJCdE0rbkJq?=
 =?utf-8?B?UGlaSW11TGw0Z2IvVk93UFFlVjhCaS9mM0VwZHZrUzRva1hUeXI1SityMlBC?=
 =?utf-8?B?T1BzQTlSSU1uak5QMnNzeE1ZYnBTVDVSZUgzNForN3htN1JPOEVpQ3ZZRTk5?=
 =?utf-8?B?aUZ5VVdicUZUVk5NR2lJbTVuYXBzNVgrbU9iSkxiVU9KVW9BYmhCenNwUkcw?=
 =?utf-8?Q?WqBZCjt8Y75jUjD+ZmNDPyH4eTVfxaMJXBn5G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51A32CCF2DDCBE468DE3859C58A425D2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	p+5CYvLAeT7a+y0IAD7Cd3EBx7JiSsMhwVnzfWTshGvE75gfc3WZ1eMR3QBWb8g8xH3fFr4HVYgp4iClO90V4a3ub20uf9RxYkMkp2nPQAiBkFysF8VcKNJCOMXn/FXhaJ2+8eRmgBoqeXSj0N8WQ+u3nq/azXRvjjYyU71qxhsCLJNlTbadCWmYyA056JBrTDxXW6KYxP2Ad29PjJjwgni1fb6wNMM2CJWhC1fAG+yh3XTMIe48qtxqcomM1Qo02U9Gc0CgMySUhGPATDsqfSXGZs7EylihthRTITJAfW+H6Ft0/4nAJHEFmBy2U1gK9UJVBIXG1x8mAx/qG0Xw6Q==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56a9d52-e5a5-42e5-9827-08de97423bcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 20:46:26.0005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGkjNNnSeApKyxphSg0bDrIPtHqLz0/WiVkvYfFAHnBAvGCkR+7rjuk2zyZmmSAS4KV3mUg9vOEtXjGS0DC/bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6116
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: NbmlixpyXC7FPNf163yU80gJwugux6_T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE5MCBTYWx0ZWRfXzRFOv6Ymy7v+
 0M9LeaJFjaaWu4pjif7+6I9iSGZ+kWN1nhiomRoQajjBmTN3FZEygMBfu8oQ0vgj24S/qsRB6Kq
 /e98sTWxqdOyyce46rGoGATuX1upLMt4H5dlFcAaf5q15yGkDlIdQqSb5HboU4v4cZjmHp1O//u
 4Nd/6DivHEhKutJh+dRBuUXmdzlxWULK5MAFQYmlZo3bVJJex+GirzMl27b0pG+Fzrzqt0YpMLq
 ioA6mn9FKPlF5UJmMItjExq3G1NZz/ti+eKUW9d7iBdYjfvuWgF+XuAh0F8WKLyC27ehpzSgYno
 Jgx+rbI5rP+3C46OxE+byLf023CPQmHwsRewGgoaJNyMYKPkkyjUmWfXAdohvDw+Br4z95ddphB
 jMLs9fDm/5wjwi5zf4l3oItwSA3isJrRmHoFhhKp3g5idsaTDJK9M+/Gb2qYcSWcnZKCg6NNdNQ
 ZMThQZPIqD5XZ7qW6EQ==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d961a6 cx=c_pps
 a=kGaFF29v6S4cQQ60M6zgkw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=3eJXn_QKO0VfASYHqwMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: o4ksOylD3UZVyzLghtHVjdu7oKiyRgKQ
Subject: RE:  [PATCH v4] ceph: bound encrypted snapshot suffix formatting
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100190

T24gRnJpLCAyMDI2LTA0LTEwIGF0IDIwOjQwICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIFRodSwgMjAyNi0wNC0wOSBhdCAxODowOSArMDAwMCwgVmlhY2hlc2xhdiBEdWJl
eWtvIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyNi0wNC0wOSBhdCAxMDozOSArMDgwMCwgUGVuZ3Bl
bmcgSG91IHdyb3RlOg0KPiA+ID4gY2VwaF9lbmNvZGVfZW5jcnlwdGVkX2RuYW1lKCkgYmFzZTY0
LWVuY29kZXMgdGhlIGVuY3J5cHRlZCBzbmFwc2hvdA0KPiA+ID4gbmFtZSBpbnRvIHRoZSBjYWxs
ZXIgYnVmZmVyIGFuZCB0aGVuLCBmb3IgbG9uZyBzbmFwc2hvdCBuYW1lcywgYXBwZW5kcw0KPiA+
ID4gXzxpbm8+IHdpdGggc3ByaW50ZihwICsgZWxlbiwgLi4uKS4NCj4gPiA+IA0KPiA+ID4gU29t
ZSBjYWxsZXJzIG9ubHkgcHJvdmlkZSBOQU1FX01BWCBieXRlcy4gRm9yIGxvbmcgc25hcHNob3Qg
bmFtZXMsIGENCj4gPiA+IGxhcmdlIGlub2RlIHN1ZmZpeCBjYW4gcHVzaCB0aGUgZmluYWwgZW5j
b2RlZCBuYW1lIHBhc3QgTkFNRV9NQVggZXZlbg0KPiA+ID4gdGhvdWdoIHRoZSBlbmNyeXB0ZWQg
cHJlZml4IHN0YXllZCB3aXRoaW4gdGhlIGRvY3VtZW50ZWQgMjQwLWJ5dGUNCj4gPiA+IGJ1ZGdl
dC4NCj4gPiA+IA0KPiA+ID4gRm9ybWF0IHRoZSBzdWZmaXggaW50byBhIHNtYWxsIGxvY2FsIGJ1
ZmZlciBmaXJzdCBhbmQgcmVqZWN0IG5hbWVzDQo+ID4gPiB3aG9zZSBzdWZmaXggd291bGQgZXhj
ZWVkIHRoZSBjYWxsZXIncyBOQU1FX01BWCBvdXRwdXQgYnVmZmVyLg0KPiA+ID4gDQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBQZW5ncGVuZyBIb3UgPHBlbmdwZW5nQGlzY2FzLmFjLmNuPg0KPiA+ID4g
LS0tDQo+ID4gPiBDaGFuZ2VzIHNpbmNlIHYzOg0KPiA+ID4gLSByZWplY3QgYGVsZW4gPiAyNDBg
IGV4cGxpY2l0bHkgaW5zdGVhZCBvZiByZWx5aW5nIG9ubHkgb24gdGhlIGVhcmxpZXINCj4gPiA+
ICAgYFdBUk5fT04oKWANCj4gPiA+IC0gcmV3cml0ZSB0aGUgTkFNRV9NQVggYm91bmQgY2hlY2sg
aW4gdGVybXMgb2YgdGhlIGZpbmFsIHRvdGFsIGxlbmd0aA0KPiA+ID4gICBpbnN0ZWFkIG9mIGBO
QU1FX01BWCAtIHByZWZpeF9sZW4gLSBlbGVuYA0KPiA+ID4gDQo+ID4gPiAgZnMvY2VwaC9jcnlw
dG8uYyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2ZzL2NlcGgvY3J5cHRvLmMgYi9mcy9jZXBoL2NyeXB0by5jDQo+ID4gPiBp
bmRleCBmM2RlNDNjY2I0NzAuLjQyZTNmZmYzNDY5NyAxMDA2NDQNCj4gPiA+IC0tLSBhL2ZzL2Nl
cGgvY3J5cHRvLmMNCj4gPiA+ICsrKyBiL2ZzL2NlcGgvY3J5cHRvLmMNCj4gPiA+IEBAIC0xNSw2
ICsxNSwxMiBAQA0KPiA+ID4gICNpbmNsdWRlICJtZHNfY2xpZW50LmgiDQo+ID4gPiAgI2luY2x1
ZGUgImNyeXB0by5oIg0KPiA+ID4gIA0KPiA+ID4gKy8qDQo+ID4gPiArICogUmVzZXJ2ZSByb29t
IGZvciAnXycgKyBkZWNpbWFsIDY0LWJpdCBpbm9kZSBudW1iZXIgKyB0cmFpbGluZyBOVUwuDQo+
ID4gPiArICogY2VwaF9lbmNvZGVfZW5jcnlwdGVkX2RuYW1lKCkgY29waWVzIG9ubHkgdGhlIHZp
c2libGUgc3VmZml4IGJ5dGVzLg0KPiA+ID4gKyAqLw0KPiA+ID4gKyNkZWZpbmUgQ0VQSF9FTkNS
WVBURURfU05BUF9JTk9fU1VGRklYX01BWAlzaXplb2YoIl8xODQ0Njc0NDA3MzcwOTU1MTYxNSIp
DQo+ID4gPiArDQo+ID4gPiAgc3RhdGljIGludCBjZXBoX2NyeXB0X2dldF9jb250ZXh0KHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHZvaWQgKmN0eCwgc2l6ZV90IGxlbikNCj4gPiA+ICB7DQo+ID4gPiAg
CXN0cnVjdCBjZXBoX2lub2RlX2luZm8gKmNpID0gY2VwaF9pbm9kZShpbm9kZSk7DQo+ID4gPiBA
QCAtMjA5LDYgKzIxNSw3IEBAIGludCBjZXBoX2VuY29kZV9lbmNyeXB0ZWRfZG5hbWUoc3RydWN0
IGlub2RlICpwYXJlbnQsIGNoYXIgKmJ1ZiwgaW50IGVsZW4pDQo+ID4gPiAgCXN0cnVjdCBpbm9k
ZSAqZGlyID0gcGFyZW50Ow0KPiA+ID4gIAljaGFyICpwID0gYnVmOw0KPiA+ID4gIAl1MzIgbGVu
Ow0KPiA+ID4gKwlpbnQgcHJlZml4X2xlbiA9IDA7DQo+ID4gPiAgCWludCBuYW1lX2xlbiA9IGVs
ZW47DQo+ID4gPiAgCWludCByZXQ7DQo+ID4gPiAgCXU4ICpjcnlwdGJ1ZiA9IE5VTEw7DQo+ID4g
PiBAQCAtMjE5LDYgKzIyNiw3IEBAIGludCBjZXBoX2VuY29kZV9lbmNyeXB0ZWRfZG5hbWUoc3Ry
dWN0IGlub2RlICpwYXJlbnQsIGNoYXIgKmJ1ZiwgaW50IGVsZW4pDQo+ID4gPiAgCQlpZiAoSVNf
RVJSKGRpcikpDQo+ID4gPiAgCQkJcmV0dXJuIFBUUl9FUlIoZGlyKTsNCj4gPiA+ICAJCXArKzsg
Lyogc2tpcCBpbml0aWFsICdfJyAqLw0KPiA+ID4gKwkJcHJlZml4X2xlbiA9IDE7DQo+ID4gPiAg
CX0NCj4gPiA+ICANCj4gPiA+ICAJaWYgKCFmc2NyeXB0X2hhc19lbmNyeXB0aW9uX2tleShkaXIp
KQ0KPiA+ID4gQEAgLTI3MSw4ICsyNzksMjcgQEAgaW50IGNlcGhfZW5jb2RlX2VuY3J5cHRlZF9k
bmFtZShzdHJ1Y3QgaW5vZGUgKnBhcmVudCwgY2hhciAqYnVmLCBpbnQgZWxlbikNCj4gPiA+ICAN
Cj4gPiA+ICAJLyogVG8gdW5kZXJzdGFuZCB0aGUgMjQwIGxpbWl0LCBzZWUgQ0VQSF9OT0hBU0hf
TkFNRV9NQVggY29tbWVudHMgKi8NCj4gPiA+ICAJV0FSTl9PTihlbGVuID4gMjQwKTsNCj4gPiA+
IC0JaWYgKGRpciAhPSBwYXJlbnQpIC8vIGxlYWRpbmcgXyBpcyBhbHJlYWR5IHRoZXJlOyBhcHBl
bmQgXzxpbnVtPg0KPiA+ID4gLQkJZWxlbiArPSAxICsgc3ByaW50ZihwICsgZWxlbiwgIl8lbGQi
LCBkaXItPmlfaW5vKTsNCj4gPiA+ICsJaWYgKGVsZW4gPiAyNDApIHsNCj4gPiA+ICsJCWVsZW4g
PSAtRU5BTUVUT09MT05HOw0KPiA+ID4gKwkJZ290byBvdXQ7DQo+ID4gPiArCX0NCj4gPiA+ICsN
Cj4gPiA+ICsJaWYgKGRpciAhPSBwYXJlbnQpIHsNCj4gPiA+ICsJCWludCB0b3RhbF9sZW47DQo+
ID4gPiArCQkvKiBsZWFkaW5nICdfJyBpcyBhbHJlYWR5IHRoZXJlOyBhcHBlbmQgXzxpbnVtPiAq
Lw0KPiA+ID4gKwkJY2hhciBzdWZmaXhbQ0VQSF9FTkNSWVBURURfU05BUF9JTk9fU1VGRklYX01B
WF07DQo+ID4gPiArDQo+ID4gPiArCQlyZXQgPSBzbnByaW50ZihzdWZmaXgsIHNpemVvZihzdWZm
aXgpLCAiXyVsdSIsIGRpci0+aV9pbm8pOw0KPiA+ID4gKwkJdG90YWxfbGVuID0gcHJlZml4X2xl
biArIGVsZW4gKyByZXQ7DQo+ID4gPiArCQlpZiAodG90YWxfbGVuID4gTkFNRV9NQVgpIHsNCj4g
PiA+ICsJCQllbGVuID0gLUVOQU1FVE9PTE9ORzsNCj4gPiA+ICsJCQlnb3RvIG91dDsNCj4gPiA+
ICsJCX0NCj4gPiA+ICsNCj4gPiA+ICsJCW1lbWNweShwICsgZWxlbiwgc3VmZml4LCByZXQpOw0K
PiA+ID4gKwkJLyogSW5jbHVkZSB0aGUgbGVhZGluZyAnXycgc2tpcHBlZCBieSBwLiAqLw0KPiA+
ID4gKwkJZWxlbiA9IHRvdGFsX2xlbjsNCj4gPiA+ICsJfQ0KPiA+ID4gIA0KPiA+ID4gIG91dDoN
Cj4gPiA+ICAJa2ZyZWUoY3J5cHRidWYpOw0KPiA+IA0KPiA+IExvb2tzIGdvb2QuDQo+ID4gDQo+
ID4gUmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29t
Pg0KPiA+IA0KPiA+IExldCBtZSBydW4geGZzdGVzdHMgZm9yIHRoZSBwYXRjaCB0byBkb3VibGUg
Y2hlY2sgdGhhdCBldmVyeXRoaW5nIGlzIE9LLiBJJ2xsDQo+ID4gc2hhcmUgdGhlIHJlc3VsdCBB
U0FQLg0KPiA+IA0KPiANCj4gVGhlIHhmc3Rlc3RzIHJ1biB3YXMgc3VjY2Vzc2Z1bC4gSSBkb24n
dCBzZWUgYW55IGlzc3VlcyB3aXRoIHRoZSBwYXRjaC4NCj4gDQo+IFRlc3RlZC1ieTogVmlhY2hl
c2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+DQo+IA0KPiANCg0KQXBwbGllZCBv
biB0ZXN0aW5nIGJyYW5jaCBvZiBDZXBoRlMga2VybmVsIGNsaWVudCBnaXQgdHJlZS4NCg0KVGhh
bmtzLA0KU2xhdmEuDQo=
