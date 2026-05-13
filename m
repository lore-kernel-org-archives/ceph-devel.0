Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E96D19C553
	for <ceph-devel@vger.kernel.org>; Wed, 13 May 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692728; cv=fail; b=gDymSR7S83VuC/zuzsuGQzJkzU1gtK1x/mK638lgKFzj2MZz0GrWShREykZNlTZfujTZ/C7a2v5jqOu2cqeQYjSaVSfRJfRTpR+ZWbHcGJ7Mz6PSPsK1oJ6Id/ZqdNvyel+SllthDbH2MZAmPywa1fprIBxwxwT8pkoq3VVuwjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692728; c=relaxed/simple;
	bh=HYjhzdkUFFF0oL0B9dGqgm2yRzNo7RUvfdDV8JTXQEQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=j0bOpZdnOOOrfj+Ez6C/WN6dlaN1kW/D9xw01NIJJ5ZAccEZa2cvKxtttpb2CabNwYa7k8Tpm3ldeGMl044DL2Uv7NuiVzFHdav24b9vDqLulaacNIGleC7Zpb2WuWCTQHghL4zPaID5F7oUuDRe45ZDQ37t+4EWfHYJNuFrHJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XDU3HKUj; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XDU3HKUj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGmOUA2606950;
	Wed, 13 May 2026 17:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=HYjhzdkUFFF0oL0B9dGqgm2yRzNo7RUvfdDV8JTXQEQ=; b=XDU3HKUj
	5eetIvwy3MvgxTpeMu8rMODxZUn6LQ2L6B9gRgSd4Kyp8biPyZQmrOvECdBsldJy
	Xg0C78Iupah3hl8jHjzJG7NP6PY0WfN7xS3d6kdZ6AuNWwnj07kL8HOivmsPlLVa
	EgAl+M17rqwpCMY3wpbpT4sqJFWRhKBQle7ZXvS2CWYUTcEQF2EtKVa+8gHB6Rw5
	egvw68xAo/Dz11QD0Z/SCCUNNlcNEQpvhrTktb5CiqNLcnL4fkQ6DdpJUHO2XDsb
	VFdekNNza1BwttGbBT62DDFSGVv9T7f7iMDgHkatlfEEGrmSea7pOGRy4hjF66Uv
	VcPhtXqauFMDQg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv58vyy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 17:18:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmuF3w6GL1lL3IiAjNCaIx+y+xEgJ3e6Cm+T3HZre8loReqTDlsjPiQlvyLAFvFh9ns1sgJq0QZYrWi4znZr7GksjiCExHe2ZlTmpVU67IR3YA+Zd/HDeAgcBrb9zuBUq2wXYzaStguH5UMjU8lWN/Xcolb80nq39YDHJ1q3I0C1mbFUnIu778Sp7/rrskzOGjn4RpraOT8Mb11UUKDQOONqhIJNpCrjUu8Dr5p+FuNndkHLYOZPG5ZnCYYscN+L6dcJ37Y1IjBQBLenoJJikDPxtPss5+ug++zPKo5XjAyoOSTvUuNkX5qIHWtWbQSxpehXPOOZ4Ehv0PtS1C73vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYjhzdkUFFF0oL0B9dGqgm2yRzNo7RUvfdDV8JTXQEQ=;
 b=kxnozZJeLZ2keHe6hvsfvs+oimLQDFVVyhdLy3e0JOb2qGatkLB37CETEtdpz6mugaXVhib41FQ5rITD2xVHk0pL9bePc82IvAzWZ6OgRj7mqsEMpYhMMmSw6wKdkRsvqRqnk6EundDVVhRc9gEmoxY2ZtoKLDepbUwZaZJV3kiulcgdLYmRRT+pjxkh6jR/D6bY5zbL5QSaoOcO14l3Cg9HjeqKh6JEf9xDzUzDb0Jj6h5l/eqx1+5walFlvHteMIPab2xrauj+blpp42xbMbh71P3INa+CwUOUaxrGVW+EAA1UBCYTlvW4mc1XZd1OzRlgv53VnvMrYSEMrzZwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM4PR15MB5996.namprd15.prod.outlook.com (2603:10b6:8:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 17:18:18 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 17:18:16 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        Alex Markuze <amarkuze@redhat.com>
CC: "security@kernel.org" <security@kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: Fix multiplication overflow in
 __decode_pg_upmap_items()
Thread-Index: AQHc4vg8Ve6O8/vscUqb4WL7fZIaFLYMMweA
Date: Wed, 13 May 2026 17:18:16 +0000
Message-ID: <e510a0d0152cda8fc1662d55e4903d3caa290a39.camel@ibm.com>
References: <8edcef9c-0b7c-46dc-8094-dc55b62567d3@tu-ilmenau.de>
		 <20260513081425.1477060-1-raphael.zimmer@tu-ilmenau.de>
	 <a9e24eba42be211967a5342550561250c5894dea.camel@dubeyko.com>
In-Reply-To: <a9e24eba42be211967a5342550561250c5894dea.camel@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM4PR15MB5996:EE_
x-ms-office365-filtering-correlation-id: eb9decc4-a542-492d-f058-08deb1139f29
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021|11063799003|18002099003|22082099003|56012099003|3023799003|4143699003;
x-microsoft-antispam-message-info:
 t7LqKvaW5oPzr5v+h6LAW+hhcDoXCejn5iXNJ6+OIh3WuXtsRJc6rgPwrOwzBspSmplDhw9pv9JTMdF6LHy17Ieh4wIbM8tBCkLMNqxCms2wVqVzCwKtHT3IhovwK5WviocTyU2PCqwkD/jmeFwlP1bZsB/ZJkaPgQs5JKq+9+rGiwXXRldRz0l06JEsfyAxQgiHbrMeqgTX/zWYX0F7CV+cpE+fLDYlLavVec9KzO2ZhYawwt8yxqraUIep00oZPrvC471Ccg9nAIsRJWslYFNF9yRD2WQrpqwpEcTtC1pJFFJMskFfpq3sIwiF9wQtrZ7ATvhDNe4IoJ9SgyCXslgSwLarBrNqfS+ZxV88KKNddCzrLIa3MiteNmGS49xS3xjnfTuZ432oDFTHwxRzqfWY5ST5sRsx7TxnYBdUTL+TB59IoHYCVZt++fGGVCKoJJLd0znM+IaBlL6zZG68dQGni6lvmY5opGYjRUKdH0T5CJTrQ+Jvu+diwKzFZXnOqX+0otVKhjuJbQpBv+WmKWTw7yjho8pIWDXT5UoSp7cCo7+zmsXTK+cz7GIsyyPV4hqP2d6/5rKB3xpZNN3F81c8D3kzBbme1BLTaBFioR/1LwARAFCHn7fy6/qF+TDMpxQQRhi5kCtQqGsbSPr/yi9i++CNt6t0IGBmdOy3l8be1ONvRz59h9ST8NnR9bY8qSQCAASGiwd4u0lUlBoiXicdj4MG/2ILmfvZyR8zX6iLnTyhmX9CQkv09TkjtKm6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021)(11063799003)(18002099003)(22082099003)(56012099003)(3023799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlJicTFDbnNoNFpOZnFnQU02TlIra09zQmtHMENrQ2RqQkZ2elY3ZlVkVFlF?=
 =?utf-8?B?WFR1S1VYZGNEbmlNcWxEd3lBR2Y1aVJXZDF5b1k0cUNsSXlERGdpWmNnZmRs?=
 =?utf-8?B?OWcramVBbmhUTEZNSzZuMzQ5NG1UbkljODJCN25Ka2hqbXUwOXBBTXRRSW9E?=
 =?utf-8?B?SC94ZmM2M1owUllRT29PTXRUTEtETUZ6VFpiYUNhNTZ6aTdWR0x5RlZkeGZo?=
 =?utf-8?B?S0NwS010dmhBb2cxMElEN2RMUFhmcDVIaHRIVXhzNDAzQytRRmxhSWE3cm96?=
 =?utf-8?B?b0tPZVVuQmhhY284Yk53MTJIUit0eHhKbStDY0VWVU5NbGw4Q3VLellOdW4w?=
 =?utf-8?B?ckpwTVcyQWc3N25HSkZtc2l4cGhnTitFVFg1YTMxN1JHV0Y0RzJwRUs3WXpF?=
 =?utf-8?B?RFQrdGRTL0JoTU1WNWxEY2dVWm9VNWtsTkxzUlZDdU9oS0l3Vml4Q3F6QmhU?=
 =?utf-8?B?b08vbisvbHZSMXlKQ2FYV1FaeURqcVVEWDZWTEVqeDZaWHBSYWZPRDNoRFhv?=
 =?utf-8?B?TVU2ZXlXRzFGM3pDVzczREdSSXdibGdreVU0dEVRMVBsL1JDSXRVd0hYaHAr?=
 =?utf-8?B?T2Q5RlpOaXg0ZGtTNnI4bWNWZ2lnTmFmdXJhd3Q5M0psVDlRNHRuTFI5bWdT?=
 =?utf-8?B?NGNOMm0vOGtEaUlLdWJPOTIyRk9JNVVKMkNLalNaRmtxbVRQbXZWdTVCcGlS?=
 =?utf-8?B?bFJPRzhucUpZVlNuNm4yR05GMHBoUDRpamlYSXEvNkJpTUhMRWtkRlh0dGpx?=
 =?utf-8?B?U0dSbVI5a3NlNzVObGR1ZzczZ0RxbU94SGU4TlVEb3dtN0RBVjR5dHFsODIz?=
 =?utf-8?B?bjEyZGp3Tlhyczc4SjJBK29wdVdBMCt5ZkRPZmFmZ0JEWENEejRoZ2lYb0pL?=
 =?utf-8?B?YU1lRTNlaTJLb0tPMG1ZaDZtNy9NSlJpLzkrQzJNam90L3p0WksxazE0WHkv?=
 =?utf-8?B?ZXl6dm1PWW9oR0V0blMzaDJzZlJaTFZmSlBEWjFBSmNObldiYmpoYlFQVW5J?=
 =?utf-8?B?SzY3cEdhbGZ5ZmR4MWU0Ykd3VnJJNTVrQnhtaUJUcG9vbEx3TWMwMGdTa2xE?=
 =?utf-8?B?RHFIb1hzZ0FuVU1xYlgxbzluNmNCRG8xTS8zWHZJN3hIZzRNT3J5eC9rb0Q4?=
 =?utf-8?B?Tkw3Z0dSMHYwem5YQ3p1S3ZIOGtwRHA3RFRmU2loVG5XM21nLzRwTDNybUJw?=
 =?utf-8?B?eUVrcWQ5OTZKQ0dEMnRmcmx0TjQ2V0tBNDEzMnhjdEw3RUxOc3RiRE93Z21B?=
 =?utf-8?B?Q2NubWhKWVdUM1BqR1dqN0pMZ29XeHFzSTdZZDAyZjZPN3hlQ1ZMSlRTUERi?=
 =?utf-8?B?RElBelJKSGdoRVBERVZ1S01wUkVPN3VOS0RyUXR6SXZudTZYdmJISmtmeTlH?=
 =?utf-8?B?YUxIQVB5Zld0NDBNc3NYZXlHRGJHNkNxcjRicTVCRWtFcmFLN09Peno5enR0?=
 =?utf-8?B?SXN6UU52R2JycWs1ZExseVYxZ3BtdVk2NzhjcXJqcnpUWjVPSTkvMjJrYUo2?=
 =?utf-8?B?Zkc4a0grdGFHVVVvayt2WFZPcmh0SDQrMWs4ZldkRVlEQS9oKzhJZEtaMXgy?=
 =?utf-8?B?bkJLd0x0ZUtPT3ZCc0FYYXcwVVMyQjVuSTYxenhXbXBtcGNSckwzckk2MnJH?=
 =?utf-8?B?R1pML3JwWENicUVmb3NYdTZrMi82ZWkyanBEVERCR0FiWk9NWTdHaFRzUVpu?=
 =?utf-8?B?Y2pXQUFGdXZ4NXV4eDVyYWNYb2VmR3dHbmJHY0hyR2hCbnBwemdmcDZnK2NB?=
 =?utf-8?B?R0VKZUVkM0tVOFBtUUJ0em5jc0FxTFdIR0lUaWJBVkhDR1ZZRVNtMTRFeVgx?=
 =?utf-8?B?RXBudmptRjN2Z2dtdnRVRGlla2NFempOUmRuV0hzb0crcmlQR3VQSkxXcmZ5?=
 =?utf-8?B?OGthVU5oMEY5TEY2M213QnAzWWhlODcyL2xVSWdGM1djWDlMV1F6SWwvenpy?=
 =?utf-8?B?bWQ0clZkUmtEYk40dFlJZjYyY2FvNWtvOE1xM0xoRkFGQ1hZZXFTWlBteWZa?=
 =?utf-8?B?OW1tRVl1R2p1bGFrNDdlSklkNHpBS0xydnNsKzVnY3c3dzhvWkMvNCtSYXBN?=
 =?utf-8?B?djRKZWliQ2lKSytmVzl2SndRUjAybGpPMGpwS0E2RksyKzBnRkx3NW1vZE5a?=
 =?utf-8?B?UDZuMVFEUDJFZDRNaHRpR1RjdG5LQkxZNjVoM0IxcFBpWWg1V3ZsTFpKUVZW?=
 =?utf-8?B?b0IwSWtHZGtBQ1BCWHZkcU8zbGpJZTlORGJTOGdFa0dsMTVGa0RNd2NMZ3R4?=
 =?utf-8?B?cnovNlJURlVqMHFEbGhtQTRvbFRhTFdtVXBUVjFhUk5mbGRzNTlGN0o3UEhK?=
 =?utf-8?B?Ly9jcHU1eFhncTFpd3p1OEplQkY3S3IzNXZLYjR5cWNFS2ZOZXcrK3Z0NGtz?=
 =?utf-8?Q?aD4D6ZwcW1SzytvQjLSg03MJ7qfgMoQ8pPEow?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCBE51CFABBB014EAA7EF39819D65342@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	lKWZBYCU72WTXVi4MQCSUmcuehUVDcksNGqFXypOa6Cumh5A97w5W/KJuyhHuIEI3QGbZxD+NL8s92IbC5YiOJfSb/dYQwSjlBOBNzB9aWXZx8i01Uou/okn4zmxqC4c9fyQUYh6E/9BSf9V+qBpG8wWfg6WRZ6IVflEJabuf9s0VG6hJwuBpjMWaPoZxbM9zNaMXkfEbnMVyLJ+37y7UULZGVRmwJT9qnJVq3Aluy1KZgKK1PBmSUm/tFwUD8ke66ZnvcgpSjyEFcqadg/ZZhIzQUyJXh1PQ/cT3Qphn6xuTGD1axf4/jl3WZD4sW+/Br2Ez8EvKOR2XmzSVxbhAg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9decc4-a542-492d-f058-08deb1139f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 17:18:16.5879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71/WWNTV9mFtl80K+YyovH1WGfmOh0KbFwsC8/GYsrJQ7Ow/ZOp/Ze1TgFMij9qW5FzyWf7BwbmAhmXap+ENsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5996
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3MyBTYWx0ZWRfX5TIyMw9hFtzB
 iZr6DWCUPeHMSa63HjDwuGp8mpl2bIxrLDIyhR+fk4V5/NHmlpM+g38VwTBk6s0iP+2fQvnZQNT
 8K1fYjJtJnpcircbRLoEP04w0xJO0PLDrP0hddo6KF2qn0cbGmNZidNy56brMPqU48TnSDEfF1j
 arndgmRzkOF/pFL0c7wmPJquIV4wHc2/w15dWDtCYR7B0AENz9euoJCg7cn7OJEfxMAZW7p2sbh
 zY1VDyXrCVVd6KBHIlccP5zc9AGDSGZdRIygmqRdyBOHSGaTHOFW9EhHtos9h7TE70elWZbKwAY
 J3eRfpsRACK5tmB1dIKvvVycbZ1z//BWMBhcfWaV8dEBTskfchDvCr4vj3wPhGKn/R8ExIkadxk
 JXXbYl9Qvtha8USL22vuADm9qxr59rcbbI4BI2vacYGjx4bzKKZKbqTgHcEsCu69cUZJzcrR7O4
 zoAY4H5yz2yfXOL25aw==
X-Proofpoint-ORIG-GUID: wDydAIyWvKDyaW3TghXvjWwYRr7AZuaf
X-Authority-Analysis: v=2.4 cv=Jc6Ma0KV c=1 sm=1 tr=0 ts=6a04b25f cx=c_pps
 a=YKnEkNs9mh/nosOxSBBx4Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=8EJVoNHlgn2w9rG7ZfIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qEdGzm_W8TAzQQWI3Ybi9O4Bwedr8wLw
Subject: RE: [PATCH] libceph: Fix multiplication overflow in
 __decode_pg_upmap_items()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130173

T24gV2VkLCAyMDI2LTA1LTEzIGF0IDA5OjQwIC0wNzAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IGNjOiBjZXBoLWRldmVsQHZnZXIua2VybmVsLm9yZw0KPiANCj4gT24gV2VkLCAyMDI2
LTA1LTEzIGF0IDEwOjE0ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToNCj4gPiBBIG1lc3Nh
Z2Ugb2YgdHlwZSBDRVBIX01TR19PU0RfTUFQIGhvbGRzIGFuIE9TRCBtYXAsIHdoaWNoIHR5cGlj
YWxseQ0KPiA+IGNvbnRhaW5zIGEgcGdfdXBtYXAgcGFydCBhdCBpdHMgZW5kLiBXaGVuIGRlY29k
aW5nIHRoaXMgcGFydCBpbg0KPiA+IF9fZGVjb2RlX3BnX3VwbWFwX2l0ZW1zKCksIGEgbGVuIHZh
bHVlIGlzIGRlY29kZWQgZnJvbSB0aGUgbWVzc2FnZSB0bw0KPiA+IGRldGVybWluZSB0aGUgbnVt
YmVyIG9mIGl0ZW1zIGFuZCB0aGUgc2l6ZSBvZiB0aGUgYWxsb2NhdGlvbiBuZWVkZWQNCj4gPiBm
b3INCj4gPiB0aGVtLiBJZiB0aGUgbGVuIHZhbHVlIGlzIGdyZWF0ZXIgdGhhbiBvciBlcXVhbCB0
byAyXjMxLCBhbiBvdmVyZmxvdw0KPiA+IG9jY3VycyBpbiB0aGUgbXVsdGlwbGljYXRpb24gdGhh
dCBpcyBwZXJmb3JtZWQgdG8gZGV0ZXJtaW5lIHRoZQ0KPiA+IG5lZWRlZA0KPiA+IHNpemUgb2Yg
dGhlIGluY29taW5nIGJ1ZmZlciB0byBkZWNvZGUsIGFzIHdlbGwgYXMgZm9yIHRoZSBsZW5ndGgg
b2YNCj4gPiB0aGUNCj4gPiBhbGxvY2F0aW9uIGZvciB0aGUgY2VwaF9wZ19tYXBwaW5nIHN0cnVj
dC4gU3Vic2VxdWVudGx5LCB0aGlzIHJlc3VsdHMNCj4gPiBpbg0KPiA+IG91dC1vZi1ib3VuZHMg
d3JpdGVzIChhbmQgcmVhZHMpIHdoZW4gZGVjb2RpbmcgdGhlIGluY29taW5nIG1lc3NhZ2UNCj4g
PiBmaWVsZHMgaW50byB0aGUgY2VwaF9wZ19tYXBwaW5nIHN0cnVjdC4NCj4gPiANCj4gPiBUaGlz
IHBhdGNoIGZpeGVzIHRoZSBpc3N1ZSBieSBhZGRpbmcgYSBVTCBzdWZmaXggdG8gdGhlIGxpdGVy
YWwgaW4NCj4gPiB0aGUNCj4gPiBtdWx0aXBsaWNhdGlvbiB0byBwZXJmb3JtIGl0IGFzIGFuIHVu
c2lnbmVkIGxvbmcgbXVsdGlwbGljYXRpb24uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUmFw
aGFlbCBaaW1tZXIgPHJhcGhhZWwuemltbWVyQHR1LWlsbWVuYXUuZGU+DQo+ID4gLS0tDQo+ID4g
wqBuZXQvY2VwaC9vc2RtYXAuYyB8IDQgKystLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2Nl
cGgvb3NkbWFwLmMgYi9uZXQvY2VwaC9vc2RtYXAuYw0KPiA+IGluZGV4IDhiNWIwNTg3YTBjZi4u
NDJiN2I1MzAwOTAxIDEwMDY0NA0KPiA+IC0tLSBhL25ldC9jZXBoL29zZG1hcC5jDQo+ID4gKysr
IGIvbmV0L2NlcGgvb3NkbWFwLmMNCj4gPiBAQCAtMTYyMCw4ICsxNjIwLDggQEAgc3RhdGljIHN0
cnVjdCBjZXBoX3BnX21hcHBpbmcNCj4gPiAqX19kZWNvZGVfcGdfdXBtYXBfaXRlbXModm9pZCAq
KnAsIHZvaWQgKmVuZCwNCj4gPiDCoAlpZiAoKHNpemVfdClsZW4gPiAoU0laRV9NQVggLSBzaXpl
b2YoKnBnKSkgLyAoMiAqDQo+ID4gc2l6ZW9mKHUzMikpKQ0KPiA+IMKgCQlyZXR1cm4gRVJSX1BU
UigtRUlOVkFMKTsNCj4gPiDCoA0KPiA+IC0JY2VwaF9kZWNvZGVfbmVlZChwLCBlbmQsIDIgKiBs
ZW4gKiBzaXplb2YodTMyKSwgZV9pbnZhbCk7DQoNCldlIHVzZSB0aGUgcGF0dGVybiAyICogc2l6
ZW9mKHUzMikgdGhyZWUgdGltZXMgaW4gdGhlIGZ1bmN0aW9uLiBJIGNhbiBzdWdnZXN0IHRvDQpp
bnRyb2R1Y2UgYSBsb2NhbCB2YXJpYWJsZSB0aGF0IHdpbGwga2VlcCB0aGlzIHZhbHVlLg0KDQo+
ID4gLQlwZyA9IGFsbG9jX3BnX21hcHBpbmcoMiAqIGxlbiAqIHNpemVvZih1MzIpKTsNCg0KSSB0
aGluayBpdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gZXhlY3V0ZSB0aGUgc2FtZSBjYWxjdWxhdGlv
biB0d28gdGltZXMuIE9mDQpjb3Vyc2UsIGNvbXBpbGVyIGNhbiBkbyBzb21lIG9wdGltaXphdGlv
bnMuIEJ1dCBJIHN1Z2dlc3QgdG8gaW50cm9kdWNlIGEgbG9jYWwNCnZhcmlhYmxlIHRoYXQgd2ls
bCBjb250YWluIHRoZSBmaW5hbCBjYWxjdWxhdGlvbiBvZiAyVUwgKiBsZW4gKiBzaXplb2YodTMy
KSBhbmQNCml0IHdpbGwgYmUgdXNlZCBpbiBib3RoIGNhc2VzLg0KDQo+ID4gKwljZXBoX2RlY29k
ZV9uZWVkKHAsIGVuZCwgMlVMICogbGVuICogc2l6ZW9mKHUzMiksIGVfaW52YWwpOw0KPiA+ICsJ
cGcgPSBhbGxvY19wZ19tYXBwaW5nKDJVTCAqIGxlbiAqIHNpemVvZih1MzIpKTsNCj4gPiDCoAlp
ZiAoIXBnKQ0KPiA+IMKgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPiDCoA0KDQpCeSB0
aGUgd2F5LCB0aGlzIGNoZWNrOg0KDQoJaWYgKChzaXplX3QpbGVuID4gKFNJWkVfTUFYIC0gc2l6
ZW9mKCpwZykpIC8gKDIgKiBzaXplb2YodTMyKSkpDQoJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwp
Ow0KDQp3aWxsIHdvcmsgIGEgd3Jvbmcgd2F5IGZvciB0aGUgY2FzZSBvZiBpZiB0aGUgbGVuIHZh
bHVlIGlzIGdyZWF0ZXIgdGhhbiBvciBlcXVhbA0KdG8gMl4zMS4NCg0KVGhhbmtzLA0KU2xhdmEu
DQo=
