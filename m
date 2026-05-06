Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F32C48124E;
	Wed,  6 May 2026 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092587; cv=fail; b=IlywRPGWIrTd71l/YBOS7LNe5Axa/CNfhFLDd6OxGxKPKc5DE45AHcS2F34e4bwei+PM+F+4ShrRou2a3sgBu5LBOcBgOwnuDrsaAkKSzK9A0K/umVRbr2K7p1oIVOEEmNo0Pgt6OQnWoXINb3pIHROVnLPaVDF7U8gf8/GQG+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092587; c=relaxed/simple;
	bh=jEohGlzSyPunATAk/On08bRzjQiOnrmkxRZfocHFREQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=NPepyQm4Nq8+EPugFeBQU1xkUtMuFoemC/qxALGcHCyUlJpVFOYlk3SyPjEBXedsvW1msJY/bubcTsz4GPha7HnUc8biVt9sAjRhLJgiAJ/twFRgaC6/MiMTOFkE95ucWN8mIoqX80a+D4+QckqEPqNlAeu7vQlpgE9Osi2gX2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qiLyZZsG; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qiLyZZsG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6468jqax2228785;
	Wed, 6 May 2026 18:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=jEohGlzSyPunATAk/On08bRzjQiOnrmkxRZfocHFREQ=; b=qiLyZZsG
	I6OgupgNY2F/rNNY5DmIM7aea1j8iQJCVLuUxXmSCLibjF82tMAsYse1KzTqjvTa
	PrsMxpTJ8fMhRuU16zCiMyFuA/bq6hCuupwRVUsCkwBm2FaWj0rDxFZt6MFK2DQI
	fT5gLVzvXSwy6L1R9F/zT1q/3w1rX6/Awmkt96iceU+meNEpbL52aq8Q0GOI/cxA
	eNIisRfllCwxOXY3WR13XSXVxHb6B7e+FaqqsY6NEcUOtfGA/9GBEXh/wbSBQA0C
	TZwoDpRT0OTBAgVNTF6ArWwcRoC+06cX1/jyDyrcq82vzFMnN8SNhaIu6G8T2yWV
	Q0pJpRYbmuehMw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxsf43-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 18:35:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMsuU3FSKQrAKducAAOl72mIghYbIosqFY4FdkcJ6c32m7RPwpvzoSwjyt0w8nnrrtzT9jqcEyU2uZSXxaQPP8Pstz6znN74UoEPcHNWUsgf93njhDBux9PU2wC76nP6oFUeVqcQX5KlTdzcGeZIJ30M5JGd/q4XDqFTuHf0jBX8PKlW+IyrwkEhAMxWk1SvCu8ZikZHgsG9SzISzca+CQhAXYF+RK+qtePT/se72h/RyWrdDQJAW8me75nGHiM/9YF/rufkpvTONnCS3pnw3P4h442uOKyO619IESoKJ3JVJ2EbOtPZ8PwG4DGmCN8WrVKJxiBL8ioklnSqYttCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEohGlzSyPunATAk/On08bRzjQiOnrmkxRZfocHFREQ=;
 b=f8bw8zU8W2Kwc2UsxupZUlP/yK+OOeel1m8ZfToe8GdE8L7/Q5kp+bBsWrCNrc+XDAGEM9kdDakSuVN+vefTs4RbcrnoOnt/BROZYuDUqp2YHnoipzkuwvNZpDzB3DwKFSQVUM3jSaF4C+NXUaCaFCXB1UOddnR0eMpw9l96QDAtzoM/wIkzJX59wk0nR3Mn4nwNISRdJwcTgSDp+g5l+seMYGHkpy3BypPcfjMgLU8JRtpEUXvxWe4P/9q6F+1OlMYSeOFx/60NTkU3XX+XWn+Wj+hfDOciKsnZfKetOUY377zzivXeugI/DxysnYm488zMkZj4sxDKbixjSjrXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH8PR15MB5947.namprd15.prod.outlook.com (2603:10b6:510:25e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 18:35:46 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 18:35:45 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "mishra.dhiraj95@gmail.com" <mishra.dhiraj95@gmail.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "w@1wt.eu" <w@1wt.eu>, Alex Markuze
	<amarkuze@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "security@kernel.org" <security@kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v4] libceph, ceph: reject oversized mon
 and MDS data segments
Thread-Index: AQHc3Gin7p8kVSK0dEKK9c0WxXf7v7X/xsiAgAAvPYCAAV91AA==
Date: Wed, 6 May 2026 18:35:45 +0000
Message-ID: <dea43fec11a0416416f93a4980c6ab07f0adce5f.camel@ibm.com>
References: <3fb2610b-5240-41ff-a5d9-699a445dffd3@tu-ilmenau.de>
	 <20260504091635.17215-1-mishra.dhiraj95@gmail.com>
	 <51c2d30565ec36691c47d0ae7e42065ece813ddf.camel@ibm.com>
	 <CAG8b5tTiRK3AfTRx0hLeTi5GLfQ6sxXxfgUT+xzEqgzzDUMtOg@mail.gmail.com>
	 <a89c8788995a462443b0f4b4a3f95de098354a3f.camel@ibm.com>
	 <CAG8b5tSigSQY4meBi24bYxYGrNsM1A4EAihh=gV0t0M1BCcYSg@mail.gmail.com>
In-Reply-To:
 <CAG8b5tSigSQY4meBi24bYxYGrNsM1A4EAihh=gV0t0M1BCcYSg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH8PR15MB5947:EE_
x-ms-office365-filtering-correlation-id: ce4aabe7-fb9a-4cff-93bd-08deab9e497c
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 Ou0ypUhsTQGhAHmN7tOQ6/GlZL4NiAedfQHMtj3h58/TXMcdS+eZR4oF6Qk1UGgaj78ZgSgHH1W1ukrixVtu78lDFrWdxhFAYgbv6yrV4iCzeGN6hr0ixUkly/d6QQjxoYFZ1T+nXWpn4RnuQML9yPNACUTceTxj4YC8zMw2zH/t33YYhc9i/1wcLTCbLZvT6aS9T4qHR0pzzujxB8y2SkOkiMsE2aHYNlP5LPpuSUZLQ+NihGnnmD+c4vQhDyAEgfRLheKSZ7K8MYbyMPjfD4ZdBHBCGgYcAsh/ASLmENp/R+V2QxM+0LpqCogn3oVAjd6UyXJYu2gsvtHb//z3XW2vpIu5dnvk4hcukIBXHXXe5uaacDPGuf0ngyHiFqqnaLpnTfaLoFTTkem/9zUHJ/KQNy6KfSBzBWer2Z4WjEq5HsJQdB4jmYbe1o3rm8Za5D5nYl6oW8i2w5BcROYDE6G63YJHPq5/jw2/3mvls1HVXxHvdeQolQDsD3xvSiff8jYXscjeftb8L7hWGLtxPR2GB/IyxMvI5xy8FDugGaF1NcRT0mKV37So/b6DqKAfRHABnMYAZFmj09/PTg5GF6B/iq2R6ZCVciJ0uclH6m/IX0p1UXfWMjElNUzjNp5i2UP0ETF91SmHJskGuFfjIBjerYQO9HKbc/sID+K3L0iTdivtrDsy5hmbHkkuddP/zfDleGrqIom1rPx1BwGR34YYLGaSCSbHAOug//3+nlEgA3qR1pxjT2ADLDFDglWA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzNtMi9ib0wwNXBWaGdaVGpDVnlOR09oWGVzQ0NpWnpLRm9aRGRIY3FlbjBj?=
 =?utf-8?B?WjFUeisvcTB6QldNL3NyYzc0aGVoeGhHSGE1dVBibDNBbVcvRnZ2VUlNbktO?=
 =?utf-8?B?YXRJWFFxUU9iNDJ2RFlSWFZ0NUt0aXZESjBOWmYyN3RrejljYVZYRE40MG50?=
 =?utf-8?B?SG9SWEVSSkd2VkRrcTB3RE41Nmk3TWMxT0VqWUprNTlxYmlNYTZ1TEJVdnA2?=
 =?utf-8?B?Smg0M2F0ejBlYW9BWUMwT3krYlhuczErQlRGTkt3MzFuZHJlMDI4RnVLNEhp?=
 =?utf-8?B?RUV6VFBMWWFObzBGdmlIdW9vYlZiVlFSY2VFa2dJY2RJcUpSeVRjOXY2UDE2?=
 =?utf-8?B?SFZsRXdEU08wbnBLcWFqZFh5b0YxVnNHTHJ5RTFkRnUxM1R1TGtiN3VzcEVw?=
 =?utf-8?B?Qk5KRFdjR1FjMDlOSld0SUw3RE9rN2oweDNPZGpDbDV1L21nb0ZFSnZqdlVT?=
 =?utf-8?B?dWY3c2wxVkJvcVQzejUzWXZCSm9yMktTNkhQNVRNcFZjd3ByTzY5Y2ZIR0M5?=
 =?utf-8?B?ZG00Qks4U1lDZHZSK29NWEJha0pGOERyRE5JSVQrUU9EZTZxN0trVXdLTC9s?=
 =?utf-8?B?WW9DUnJhZkhiZ3l1SnN2OXM5TGU0RGVYZjhzbjJNMFo1UDZMSkU2YXNwaWp6?=
 =?utf-8?B?Szg0WFJjRkhEaEE4UkNkbkQwU3V3U0I4TTMzWTZTSy83QTBsYXdpcFRQNVBO?=
 =?utf-8?B?Sk1VdHQzTklFU3BiOGlkMXZESkx5UVQrWUhPeGE3OHF1cklLNHlkT0pLOWdO?=
 =?utf-8?B?emRjcFZZWGZaVitpR3Boa3FFVEg5RzA3UmFnZHBxWGRLT2haNDYxem51cW1F?=
 =?utf-8?B?L1F3ZE9peTBCNGsycEd0RTFTcmIrQzBjdndnOFBDdHB5NDdyeHkwZDdwZlJs?=
 =?utf-8?B?alVkQm1VblgrT1ZERkFoTWNCWlZDdEIyUm1TdEpNbUd4U3NwVDEwa2N2ckpE?=
 =?utf-8?B?U1RDWHdpUFE1REw1eUN5T0FVN2I3ckxseTB5Vmt3T0w5LzZvS2xXdExnYU1z?=
 =?utf-8?B?c2VRUlJRay9xemxaS1lOWnBTaTZwRVZLbW1PbDhEQnFLeEg2NFBCNXZHQkI2?=
 =?utf-8?B?anMveEtqZ1VjK2U3ZGs5K1NocXllMUFWd0hkTzM4STArSkpLK1J1VlZLR1gr?=
 =?utf-8?B?RGVPN2RidmVjdVI2c2Z6R2hLbXZXek92cThDcGk1VHBiaE1PS2tuajVuWURm?=
 =?utf-8?B?MzZ2aDFMUTJaL00wNTdGZkRlZ0JUOXZzbUEvRUovZEw4YmVodWFqYW9IZnJa?=
 =?utf-8?B?M3RyWHI3MEQvYkpMQjhaY1ZPb3dPdHFERnlQczBnYldnZXNISWNza1cvMlVH?=
 =?utf-8?B?OTl0ZFJZcUNteFlFeXZrZFl2dDRIZVBDcEVLaXV3NHIrTkpGemZ3bTByVzhH?=
 =?utf-8?B?ZmNhWGt2RklTUzlya0VrYzZ4OUNuam45VUpsK2RFK2ZaSWU5S2NqYTRwVWcz?=
 =?utf-8?B?YnptVGpTOW9CUCtxbGNVMHlXYm16WGplVmFmeHJ0U1NESWl5Mm94VUJML0lY?=
 =?utf-8?B?K3BJbDM4U3FVRDdhUDY3M3kyOXFITkx1Z2VSTmlpM2l4VUZtWU1vQm1CaTdl?=
 =?utf-8?B?bWc1TjNqRWUvZktoNFFKaDAzZitZaEFsYUZ2UjJOVjFBWGlvb3o5NFd3cWNp?=
 =?utf-8?B?dHRPbnBoQ0lTMC9GMVBXNmZnNGZTKy9KVG11Z3JpZVpkMy9DNmJIY0RiZy91?=
 =?utf-8?B?R1VPMUxFaFJMaUZLR3ZrMDVEbnpkTVlLVVRTVFhJV3E0RHR5L2l6UllFelNy?=
 =?utf-8?B?VWZTc0pxdXdtSU8raVZNL2FZdkEwVlkzQWJQcy9JendPUkl1QWFRVHFVRExI?=
 =?utf-8?B?R2cyWWZzb3hkSjI1aDN4L3JNN0dYUlgwVVpwcEpOVUc4WUFqalFrcXhUNGw0?=
 =?utf-8?B?TVRYdXNIbG5oV1NSYUhFWmdTeS9HcGZyeDVoZ3pNQWt6aVZITFNnVEt3VlpQ?=
 =?utf-8?B?RnJKQmRxeitJK2ZiQlhadUU1cENSdjdxNzBtSFhEWHZyRlh6emhRVUM4clNp?=
 =?utf-8?B?UDdWVUF4UG9ZUGY4dTJmL3Z5ZXFZV3dlK0g3b2gzR3A0SDQ5UTAzaWF3cEJN?=
 =?utf-8?B?TmNvVGZqdnJpbXVVdHpVMnp4UFA0TERqRTlKVkwzRUl5aXliVGhZTUlZRUs4?=
 =?utf-8?B?eHlPaHlRNDYyV1VFODBHclZNUmNEMzVNYmRFOTJTTzVxWnZ5R0hNTDB0MG9F?=
 =?utf-8?B?YVZtR2tENGhLUXhibituajhBd0txSTd0OFZJTDgzaFZUVmpyOEd5a0NWd1FW?=
 =?utf-8?B?bngzKzVXSkFUS05hYnRaZ2t4VVJ6S1ltV0J4T3lxcWE0RTNkU3o5VWtTZVJk?=
 =?utf-8?B?cVJEZmFsYWptYUNJT1JlUU95RGdXTFFCWXJNdEV2V1ZHQzVsSCsxQ01BR3pL?=
 =?utf-8?Q?fYHLqv8BDZIZpThgOODiZBBAX+Wtfy56X7owN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC1F33724777DA49A55E01CCFF421BAC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	m8O03zimJZEwCI7oOPI73C9r15Rf0aOnFnYWtXeYB4fr1SuXOg5MlzlsTqEiyZOVjINB2hm1ZlR0GNNFiAcs5LQSxpiHBNQBuwkvLXBFFuKlYhtgOuM9VHWA0xvCe8BDlL5zz4Wr5ImDbL5/T/f0ah23Afj7SlSxh1dZIO3cHLKWs5D5BwDq8Fk51U0eontfdtVMNGIU2dItJbQxmqstwgiFh9d+jEGqB9WJjy3aIOsgxSciV9lXTQtw6f3EcVDvu4CCDWUnO0uRMeUnBFnYh6X8DBtwuxh+6KuebmcZEb0hyqXAEKie3xTAJtBO3HvGStSXxOW0qVGvhzxObyIkjw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4aabe7-fb9a-4cff-93bd-08deab9e497c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 18:35:45.8752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IPHm5Y7emvgJaHO7Qt/i6IjHdqkzUykl93b+m4MxMGLXvYXcQUBgcGE/ggyWAN/QXol4nWQsUwggRu8Gs3Yu2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR15MB5947
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3NyBTYWx0ZWRfX/h4HPZ+pposK
 m4y5PEicGH+xuSMuSMYx/eB+cE9vsK4zCTlt0vJ4iz3a7QUFsyI5LxvTBYeQi1qXQmsEkMbc7M8
 O2djnZmk2hk2Yl4NSkschFfi4s3ownbGBwJQqmcKT42MovPmeRtPHjlDCoaBy2Qqauu9iABvve1
 6Yg3lW9LrFml0Sn+kTunkHTAZcUVWmg/cOlDGWWd8737R5u6Ujgp8uNcq/UfCO6OU3KaDzYwgnq
 aNQhkBLWyTIctPwmQKp742V4uanttys7XXRfLFRAeT642X79hyJuR1xuENSjs6pWB/PunbEsuHh
 jw2z78IQ86l4/hGHqHJC/EGm+YFt4T67QK+uQ8llhfloV5AoChV0j9tPKtBZtcr7KuYlTBn/9qG
 h1pbR2LBDKKSyX5hbyfDtOgNfYxY+XzC9uz31k8NWoa4xIKylpYZ1QgBBOkFieedcVafLfoRcWN
 HH9J+7TvQpgvC/3NdRw==
X-Proofpoint-ORIG-GUID: ZC8i1-gl3BJmBO2A8edbLIucUaaOWcaq
X-Proofpoint-GUID: 8TaWqbDuaM9YLdDR6KZ0U2Z3tECbcAUg
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fb8a04 cx=c_pps
 a=f333RhXzhOQaWIE8hCCRDA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=h3XX9Wp6tzcND2hV7VwA:9 a=QEXdDO2ut3YA:10
Subject: RE: [PATCH v4] libceph, ceph: reject oversized mon and MDS data
 segments
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060177

T24gV2VkLCAyMDI2LTA1LTA2IGF0IDAxOjM3ICswNDAwLCBEaGlyYWogTWlzaHJhIHdyb3RlOg0K
PiANCj4gSGkgU2xhdmEsDQo+IA0KPiBZZXMsIGJvdGggaXNzdWVzIGNhbiBoYXBwZW4gb24gdGhl
IHNhbWUgbWVzc2FnZS4NCj4gDQo+IFRoZSByZWFzb24gd2UgYmVoYXZlIGRpZmZlcmVudGx5IGlz
IHRoYXQgdGhlIHR3byBjYXNlcyBhcmUgbm90IHN5bW1ldHJpYy4NCj4gDQo+IEZvcg0KPiANCj4g
wqAgwqAgwqAgwqAgZnJvbnRfbGVuID4gbS0+ZnJvbnRfYWxsb2NfbGVuDQo+IA0KPiB3ZSBjYW4g
c3RpbGwgc2FsdmFnZSB0aGUgbWVzc2FnZSwgYmVjYXVzZSB0aGUgZnJvbnQgaXMganVzdCBhIGdl
bmVyaWMgYnl0ZQ0KPiBidWZmZXIuIFJlcGxhY2luZyBtIHdpdGgNCj4gDQo+IMKgIMKgIMKgIMKg
IGNlcGhfbXNnX25ldyh0eXBlLCBmcm9udF9sZW4sIEdGUF9OT0ZTLCBmYWxzZSkNCj4gDQo+IGdp
dmVzIHVzIGEgbGFyZ2VyIGZyb250IGFsbG9jYXRpb24gZm9yIHRoZSBzYW1lIG1lc3NhZ2UgdHlw
ZS4NCj4gDQo+IEZvcg0KPiANCj4gwqAgwqAgwqAgwqAgZGF0YV9sZW4gPiBtLT5kYXRhX2xlbmd0
aA0KPiANCj4gdGhlcmUgaXMgbm8gYW5hbG9nb3VzIGdlbmVyaWMgcmVjb3ZlcnkgaW4gdGhpcyBw
YXRoLiBjZXBoX21zZ19uZXcoKSBoZXJlDQo+IGlzIGNlcGhfbXNnX25ldzIoLi4uLCAwLCAuLi4p
LCBzbyBpdCBjcmVhdGVzIGEgbWVzc2FnZSB3aXRoIG5vIGRhdGEgaXRlbXMNCj4gKG1heF9kYXRh
X2l0ZW1zID09IDApLiBJdCBvbmx5IGFsbG9jYXRlcyB0aGUgZnJvbnQgYnVmZmVyOyBpdCBkb2Vz
IG5vdA0KPiBwcm92aXNpb24gYW55IGRhdGEgYmFja2luZy4gSW4gdGhlIHRlc3RlZCBDRVBIX01T
R19NT05fTUFQIGNhc2UsIHRoZQ0KPiBtZXNzYWdlIGlzIGludGVudGlvbmFsbHkgZnJvbnQtb25s
eS4gU28gaWYgdGhlIHdpcmUgaGVhZGVyIGFkdmVydGlzZXMgYQ0KPiBub24temVybyBkYXRhIHNl
Z21lbnQsIHRoZSBzYWZlIGFjdGlvbiBpcyB0byBza2lwIHRoZSBtZXNzYWdlIHJhdGhlciB0aGFu
DQo+IHRyeSB0byBpbnZlbnQgYSBkYXRhIGxheW91dC4NCj4gDQo+IFNvIHRoZSBpbnRlbmRlZCBm
bG93IGlzOg0KPiANCj4gMS4gdW5rbm93biB0eXBlOiBza2lwDQo+IDIuIG92ZXJzaXplZCBmcm9u
dDogcmVhbGxvY2F0ZSBmcm9udCBpZiBwb3NzaWJsZQ0KPiAzLiBvdmVyc2l6ZWQgZGF0YTogdmFs
aWRhdGUgYWdhaW5zdCB0aGUgZmluYWwgbSBhbmQgc2tpcCBpZiB0b28gbGFyZ2UNCj4gDQo+IFRo
YXQgaXMgd2h5IHRoZSBkYXRhX2xlbiBjaGVjayBoYXMgdG8gc3RheSBhZnRlciB0aGUgZnJvbnRf
bGVuIGhhbmRsaW5nLg0KPiBJZiB0aGUgZnJvbnRfbGVuIGJyYW5jaCByZXBsYWNlcyBtLCB3ZSBu
ZWVkIHRvIHZhbGlkYXRlIGRhdGFfbGVuIGFnYWluc3QNCj4gdGhhdCBmaW5hbCBtLg0KPiANCj4g
T25lIHNtYWxsIGRldGFpbCBpbiB0aGUgc2tldGNoIGJlbG93OiBhZnRlciBjZXBoX21zZ19uZXco
KSBpbiB0aGUNCj4gZnJvbnRfbGVuIGJyYW5jaCwgd2Ugc3RpbGwgbmVlZCB0byBoYW5kbGUgdGhl
IGNhc2UgdGhhdCBpdCByZXR1cm5zIE5VTEwsDQo+IHNvIGVpdGhlcjoNCj4gDQo+IMKgIMKgIMKg
IMKgIGlmICghbSkNCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIE5VTEw7DQo+IA0K
PiBvcjoNCj4gDQo+IMKgIMKgIMKgIMKgIGlmIChtICYmIGRhdGFfbGVuID4gbS0+ZGF0YV9sZW5n
dGgpIHsNCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLi4uDQo+IMKgIMKgIMKgIMKgIH0NCj4g
DQo+IGlzIHN0aWxsIG5lZWRlZCB0aGVyZS4NCg0KTWF5YmUsIEkgYW0gbWlzc2luZyBzb21ldGhp
bmcuIEJ1dCBJIGRvbid0IHF1aXRlIGZvbGxvdyB0byB5b3UuDQoNCldlIGhhdmUgY2hlY2tlZCB0
aGF0IG0gaXMgTlVMTCBoZXJlIGFuZCBleGl0IHRoZSBtZXRob2Q6DQoNCmlmICghbSkgew0KICAg
IHByX2luZm8oImFsbG9jX21zZyB1bmtub3duIHR5cGUgJWRcbiIsIHR5cGUpOw0KICAgICpza2lw
ID0gMTsNCiAgICByZXR1cm4gbTsNCn0NCg0KTm93IHdlIGhhdmUgdmFsaWQgbSBwb2ludGVyLiBQ
b3RlbnRpYWxseSwgY2VwaF9tc2dfbmV3KCkgY291bGQgcmV0dXJuIE5VTEwuIEFuZA0Kd2Ugc2lt
cGx5IGNhbiBjaGVjayBpdCBoZXJlOg0KDQppZiAoZnJvbnRfbGVuID4gbS0+ZnJvbnRfYWxsb2Nf
bGVuKSB7DQogICAgICAgICAgICAgICAgcHJfd2FybigibW9uX2FsbG9jX21zZyBmcm9udCAlZCA+
IHByZWFsbG9jICVkICgldSMlbGx1KVxuIiwNCiAgICAgICAgICAgICAgICAgICAgICAgIGZyb250
X2xlbiwgbS0+ZnJvbnRfYWxsb2NfbGVuLA0KICAgICAgICAgICAgICAgICAgICAgICAgKHVuc2ln
bmVkIGludCljb24tPnBlZXJfbmFtZS50eXBlLA0KICAgICAgICAgICAgICAgICAgICAgICAgbGU2
NF90b19jcHUoY29uLT5wZWVyX25hbWUubnVtKSk7DQogICAgICAgICAgICAgICAgY2VwaF9tc2df
cHV0KG0pOw0KICAgICAgICAgICAgICAgIG0gPSBjZXBoX21zZ19uZXcodHlwZSwgZnJvbnRfbGVu
LCBHRlBfTk9GUywgZmFsc2UpOw0KICAgICAgICAgICAgICAgIGlmICghbSkNCiAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIG07DQp9DQoNCkFuZCB3ZSBzaG91bGQgaGF2ZSB2YWxpZCBtIGhlcmUg
YWdhaW46DQoNCmlmIChkYXRhX2xlbiA+IG0tPmRhdGFfbGVuZ3RoKSB7DQoJCXByX3dhcm5fcmF0
ZWxpbWl0ZWQoIm1vbiBtZXNzYWdlIGRhdGEgJXUgPiBwcmVhbGxvYyAlenUNCigldSMlbGx1KSwg
c2tpcHBpbmdcbiIsDQoJCQkJICAgIGRhdGFfbGVuLCBtLT5kYXRhX2xlbmd0aCwNCgkJCQkgICAg
KHVuc2lnbmVkIGludCljb24tPnBlZXJfbmFtZS50eXBlLA0KCQkJCSAgICBsZTY0X3RvX2NwdShj
b24tPnBlZXJfbmFtZS5udW0pKTsNCgkJY2VwaF9tc2dfcHV0KG0pOw0KCQltID0gTlVMTDsNCgkJ
KnNraXAgPSAxOw0KfQ0KDQpJIGFtIHNpbXBseSB0cnlpbmcgdG8gbWFrZSB0aGUgY29kZSBtb3Jl
IGNsZWFuIGFuZCB3aXRob3V0IGludHJvZHVjaW5nIG5ldw0KZXJyb3JzLg0KDQpEbyB3ZSBuZWVk
IHRvIGNoZWNrIGJvdGggZnJvbnRfbGVuIGFuZCBkYXRhX2xlbj8gSSBhc3N1bWUgdGhhdCB0aGVz
ZSBmaWVsZHMgd29yaw0KaW4gZGlmZmVyZW50IHNpdHVhdGlvbnMuIEFtIEkgcmlnaHQ/IENvdWxk
IHdlIG1ha2UgdGhlc2UgY2hlY2tzIG1vcmUgbG9jYWwgaW4NCnRoZSBzd2l0Y2g/DQoNClRoYW5r
cywNClNsYXZhLg0KDQo=
