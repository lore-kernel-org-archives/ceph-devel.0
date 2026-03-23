Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A03264E4
	for <ceph-devel@vger.kernel.org>; Mon, 23 Mar 2026 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774292402; cv=fail; b=ZLSG8xS4/xDUX5UHoeUOi/OES7R03B4lXnb/y8rSXRBu4jekXtaWPLdI5dOdYkCBrW29riLDKziz21O+VscdIs9ipUO136WQ8RHG47uF+Xm6O7UW0HL7Jlzz1w9QvWXrH0ok/NWyXF8FDsHcGceWdbKFyKQZEcAxCFB93/3V4/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774292402; c=relaxed/simple;
	bh=5EMmgnEjn5WBUdeCk2HBLwAkYbzJE0tXc32UBk8Bz7M=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=nbrRiy+5fJMNIB5YkrutwCSdctHvQPmR/ETiyJF/Ww0A9veLTLiJsxXWrAdR9oOGeIUlOvyzL4uQ8gGfhGMz2z5NmdjuPWSHMNe3Y+oQXAo0wX4PPjrTT198+r5sfaKDPS8Zdy5guhmApFsqfU3mc7l6ZC8R168Gk/Qt51qsKeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GzzgrCso; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GzzgrCso"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFZ9J7624833;
	Mon, 23 Mar 2026 18:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=5EMmgnEjn5WBUdeCk2HBLwAkYbzJE0tXc32UBk8Bz7M=; b=GzzgrCso
	aEqxfSk0B1Uv10HiEoJ4jNugoaEYXnIHzJKIjgsHzLRH35wsc3qOGIMTsFp4ZopZ
	0/Tj+N08jpqzJziaW94lHv2UB35G84QUH2Dnz7bAT+SGpvC/DppGzngoow/jVvM3
	HtUNXYK0pM1Ar3UQizZb/5T+ko0HhbLcz1FIllVBWP+HPTnW22nJvI4heInuLpCV
	zKNoc9/7BNKTCf8R8VRWb1u01mGmCC88RdxaUmhX16MMXgGZbHjwHQES3Em402Kg
	yPlL9fwuzOIkQ5C//10csPaLm6iHhHfAZgAfdI6yDCDECAkSDxX2pB3++xsY2WLT
	NcaHvygg6d7LUA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9rauy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 18:59:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjSrKwpfj/FjZCfTDeY+yA9qC2pM3fECEu4lbFQx/9V34aHIW0SfPX6qVtiXfGmmc7di9URBoBuzuK+X91iAf1gJAWI35qiZi3LmNNhHYXHSFdX04lydGkCtQd+zPMw1KVdp8jCVzSQoVF/m9at87yf0+e6B08yOY07EEJv+y7IHSEupYIdZgIrNjMkmwKVdKf6+fIFA37gogkxoIRToNBkd6P5xLFCd190KAV9rAX9o3NRKghXIcYpZWviJceihvIMrkFLnVd5x65FE2jF2OHAcEsV48B6xrg2SDq8liA0/MOPBiiB9IlKeXE/iGvNWxfYiR0QCFNqi0fo6Cl8SKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EMmgnEjn5WBUdeCk2HBLwAkYbzJE0tXc32UBk8Bz7M=;
 b=oeL607ixC3k+zVPcgDaTfsQjSktvzdwBCInyYGbUIKWn0vOk7DMhQXsAMe9LEVD5rDzoaK+KOxR0Qo2HfqqbG9u+6q42v722cJXcID11bijBBQ9lA6GP2JgZCFmy0fTcpRi0F1A+UpL8pc7xUiEUfW6ylAYBAPa4bOBCgUZULciUlYlwnyTCgSrjxyh9dDhAn7LF1b6NW/H5txtMh1iEOHq2VHXdAqcyHREo6LSPqNSVggZp/UclXOJsft+kC/CAIV4UkxFfVN2v19TF2g6ZjvsJOvH8Bv+NKIH/ThKGUCcuIarVPhYCz5+N6xhbNbAC4sRDAVTPbRSIzisdxyjoHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB5920.namprd15.prod.outlook.com (2603:10b6:208:3fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 18:59:40 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 18:59:40 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>
CC: "security@kernel.org" <security@kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: Fix slab-out-of-bounds access in
 auth message processing
Thread-Index: AQHcurnC6phudK5LO0+0uA3MVPzZdrW8ePKA
Date: Mon, 23 Mar 2026 18:59:40 +0000
Message-ID: <9afcc984548bfb418f3fbab64dd98f5e14ed63c0.camel@ibm.com>
References: <4f9fdcde-f5a8-43a8-9580-6ec3402c4185@tu-ilmenau.de>
	 <20260320094154.1158656-1-raphael.zimmer@tu-ilmenau.de>
	 <0959410fbce95fb8f5ac25de6c751421834ae923.camel@ibm.com>
	 <395ea4e1-f83c-472a-b336-fba24368e5ce@tu-ilmenau.de>
In-Reply-To: <395ea4e1-f83c-472a-b336-fba24368e5ce@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB5920:EE_
x-ms-office365-filtering-correlation-id: 676a3909-5ed1-42a4-2132-08de890e5672
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 3+2Pv+hAIwCa6WZoRdkoQt4QaZ7/D/o8uHR4J0SiRRI+9KpDzwBV2NHVXooXW/nDfP++lOl6ONxusoewTqiPUTgBMNVS7kCoWtT9JIKvFxOHQXT3Sm6oVuIXZDUdLuQLRzhTLziN5oQilFotrKJBA/s8kPj8115dc9LuYIYjEe/5TW+WaZiBuOZC+NH+F30tqoyOxAaSjP0y1B9TEFGXFcKuDN+QDplaNuYrk7xGWGgkNLESwEomkaVAlF8nFmz1OfceUiMLdJUhZjd6Mnu8pnack+Ek7ODY91ketUtlpI6EMrgFetdQip5QYMLuDd/1ykYQ6a7o6zK4JsqZPOAjh3X54ld9dsjZhSn3y1lLnVnr80ML1a1B8JWr9t9VYezOOSubj18Z7Z8Zno51Hu4F3JCJcckPPf+2xoYV91NrfWOLN0UmrUTPpv81gLOd2osz1GhbCaXqCCDneGBLLRK/6jylx+HStYuNe68SKo7+D0fE1SPUO3MSelbwjg5ldRg31Ui54cbaEuMbyFJAzrifrof9IUp/KFxaATLe8af3KhnR2tM6EAGVpwGWWT5anaVSaOWRP0Fmvcw4PzH5s87aWlGYpuIF9gRaGTw7bsA+1H5SjFIXD/gps9NqLxmUIT3yKencoqOfnDC/6w1P9VIf8K9w2HCHDq5CRhqrkdK/SQApnoOvyg3Q+0TYjJ65O/o7VcP65dknys+ggPXpUVBnCvWc2ZbJehlkn1/kZRxNppw8rED1c7aIO8iFNftQzZFgXpxLXpbiWpMuPOLzyBTUxAj3/IEzosBwGwYcnqEfWkc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUlic1VScFpRRUJLWW14TmVWTDFlNGVrU1hzWHV0V3dUQy9LSnNJcmJ5elN2?=
 =?utf-8?B?WmRDQThBMzM5S25KQU5sb09OTmRFbGFxUE9JL2RwVFNNc3pOWGRRWVZ6SzNt?=
 =?utf-8?B?VUdwWHZYQUFZQW8vNUNnR3VjSmJ0bE1SWDFBYlFxdmdVdlJzc1M2aVFCMDEx?=
 =?utf-8?B?S0VrdlZ6V0dDZzZmT1I0WE5TNjJLQWdkSUd6Wm5zbXlvcm1qVkxTRCtXeU52?=
 =?utf-8?B?VlptVzdUd2lnNWs4NldrNEZock1nZGJLMC9melFWanhPNWdaVkZ5QWhrNmpj?=
 =?utf-8?B?ejJGMVBJNHpBbXZTaGVVaHpTNUVIWlkweVNCek5iUlBmRkc1OVduZGpyUWxz?=
 =?utf-8?B?N3JBbkZWbGU2TlNYbHByWmFJRXJCcjVSTWxKeThMUm9lY0RoTHRTU2t3NC9H?=
 =?utf-8?B?Y0VETG55SHpBWW1KcjAvZHpDK1F1cGFSSnBmektrTGFJd2dMWHJNVHJNTVdS?=
 =?utf-8?B?WmE0R2oraTJXQXdPaDVPZlZlVDk0WFI3SzRaUW9uYmNleGRLZkdhVENPekoy?=
 =?utf-8?B?L2tSMlZxaktFV3A2MmUyQ3k4UmN3NWlYZkY1WFJiMWFyb1Y3OTVUQ1UwM29h?=
 =?utf-8?B?UksrZEgxK2FleEUrNmxSUjZsYUd1Ym9kb2JtYktaRlVpeS9Cd1NrSUF2bk03?=
 =?utf-8?B?UmdqQUxFaVR5Rmw4N1NiWWxKdVc0U09SUXh6aEdLTDByZHYwL0RydGVrbG9M?=
 =?utf-8?B?MnRrMkVrdjhjUUhxbmVWajFLaTlDY2RWb011OTRCUVVxejlod1d5TjVhWUt0?=
 =?utf-8?B?U2lSRjA2dFYwY0ZXMHIxU3dBY2ZjenIrblkzNHVFdTVmTVRmTHBtZk1iUXE5?=
 =?utf-8?B?azBYVkozY3AwZUtMMzRINWNCM2RGVFNqakIvMElYbGJTcGp2U3F1d0lybFJy?=
 =?utf-8?B?YUd0c2E3UVVSRHg3Mk5nbTgvL25qRm83MXB3MzM0WnVyZTNWQThOcHFsMmFQ?=
 =?utf-8?B?MkI1b29sUkJZQ3REOWNnRGVIdkNuQXl5SFl2ME9BT1Z4TVRXMEFOTFhnQmxY?=
 =?utf-8?B?Rld4aW9FcTltTCticWFyZXJCR21qcGo1RDhja3ljUHRpVGgrUVJxeGEydlpl?=
 =?utf-8?B?RU1qeFlaVXI2Zmo5eHFRWkx2SnJOVno2UFNlR0dvVjEyaFlxUXo5dWhWM3ZX?=
 =?utf-8?B?dU5qV2pXZWhKdHBUOVdMTmsyenhTMHJCak9YSzFxUjFGKzRqbTJLYm4rNzhh?=
 =?utf-8?B?OTJwMGRhUGhpaThONWVZYlpsSDlYL2J4YXg0dHVCdkF4bHoyd3JOM0ZvS1hU?=
 =?utf-8?B?QXRWTDVvc0VRWUF6eTlkUHQydnBPKytjbU9xQWZ2NlpDWi9UckQ0NjZRdlZZ?=
 =?utf-8?B?c1A0bFB3bDYrQzU0dXFSY0dKand0V2hMdjFSTWdvdHM5WTVtY2dXaHlYc2xW?=
 =?utf-8?B?SCtyUVF6YS9malVUZHBzaEhQcllJaW4xK3UxMzQyN3E3enZaZHB5UFgwM0c3?=
 =?utf-8?B?Vk1QaDA3RFFxUjB6Tk1nMDZPdEU5UXhKUTZZZFBNRXlQZU5jSXkzbnQvY1NY?=
 =?utf-8?B?ZEdBdTliVFMzZHpsYS9MZ1ArQjRRTk1GWXBONUhIbTRNV3JjK2RwN1c4VGFa?=
 =?utf-8?B?V0h1U05GNGpBT1BLeGtjcjZaT0wvKytSbEhsTnZieDUxTW9zdDFNYmF2ZUwx?=
 =?utf-8?B?M1hRV2lGb0tPNDhuWjNaM0dOaEpjaEJpRWxDOERWNlNFZFdheVBKejAxd1pi?=
 =?utf-8?B?REZYWU9QUm55TG84KzVEVmcrZnYraU5hVGZCR2J1bFhZeGtldXRmdUJPaWhH?=
 =?utf-8?B?QjR0N0R0UnU0Rk8zQU9SWlQ0amFxczdIR3F1WHdSMUY0Q0tkUHg1VEVyUkt4?=
 =?utf-8?B?NU1DeVFTSlJCVjJvTHJYV0tucnhhdlNEWDlKZjd2UkhzMkx1aTdDcE9XeWQ0?=
 =?utf-8?B?UGY2cXpBcG1LWFFNMUw4MytWcWYvNkxUaUcyMmhiZTVUcng0akNzMjBqTm8r?=
 =?utf-8?B?Q1RIMW5tdENZcDhVN0RmSjRmeFVJUTkwY2xXeWZPYkxMRnk3UTBVOXhOK1ZF?=
 =?utf-8?B?VjE1SGF2NG1jR3NJMEphaTV6KzBjKzQrUU9uZGUxdTd6U0JDeHpKZnVwY29s?=
 =?utf-8?B?WXQ2ZEZ2d2MvYU5FUmM5dm52Q2tBRDFxOFlUV0NXTWovbE1NU0xVNXhqUnlH?=
 =?utf-8?B?cnV2RGtDbWNOa3FiQlJGNWJqZDB5VVYzSHIvaFEzcmRuMUhleUdkTVFORThR?=
 =?utf-8?B?bWpsN1lmd2U2RDRWTCtheTlpU29MNXF6S2lyTUI0ZWNybG5RT0NPWWg2bFJv?=
 =?utf-8?B?Z2J6RXZjQm1vOUFET2hsaFMwdGJyQU9meDF2VDZYeWhuMmJwNStnMlBwNXFj?=
 =?utf-8?B?eU1UVmNsQ2RUN2hFYkMwVzBWdUFScmlSVjFueThoQ0hhUUk1UEM2WE53Q0h1?=
 =?utf-8?Q?hhjKhxFj9HRymEInwXX8kXdfXEUcouEjmXfkG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B71343CC579BE64FAF501F5DAE2357F9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	aEX0IcBf+kdMZk4ZqJnrl73OAJGmyjtGCMTD1oVkK12Lb/c/K4GXsb4khONL0iWWy1C6Q3ueqNeVpyJQeQc3BDqrWGVxQIDsxUSEV5IZ1F0YAd2axzGw/1YKrEGFH7t6dEQJK43xvlPeas3l/+EEFdNBVzFeTi4AScUdlBJ7E2BXEm8JEw/Ls36e6O2sA1Mu/p6t+lJYbM2gP4XNCTzlgYwosP9w8DqCwFhVvK8RGb1A/scITw0HPhkE9Xy2OaEsqC1J/UgLRL8g+nmY5WY4FY7UpSvT1vyKH5czL9iZ/OwZVtbf6ADBCigRcs7+NoTZvmsiheyl5QV4nxJhkaGYEg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676a3909-5ed1-42a4-2132-08de890e5672
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 18:59:40.5731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPfGFlJ2oqNg8vqrm2F8F8vBB2cDB57X281l1oGbmOOrcCO9voeucBO+dwspmAKMEn3IKc8DHY8VGnt+TUgXXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5920
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: qtFIYj7nQTkTgP24UsEZjYg1wJHcckQo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEzOSBTYWx0ZWRfX39nBRrrnDcrd
 uL3Eiiwatlwr1G7opjvihBvVDBdImCdMZW/qMkHz+uJ7XIF4ewcKpxmmHEucAcaJeXfD0FkXxIX
 l0D5QW8nAZYkQSJFeT+bCOYJ6vtWgEnc6sXskNL54zGIA77bql3Gwfj43X/8XL37SbTuIi5xiVP
 5bIMPb+FB7J8UPGlYWHG4TzvoTWd6iP026FYvv8FBWXoQcUWS/1rCGR5VLEJPD0YzK02oJFqhff
 rV8O5M7GEIVDjL/raD7bLrzXHaZ2AZYtQ3jinA8cJukcnVqoR71UDSn0hbSAkFVV0qj404TObqH
 AjB4ExlJHOd5vsdWwql3QYuAyq+AWgPdPzbguEdeJqHY9ZgiiTisNVpRJkFVL39ZvNWKtKUP4vl
 L0XvUrYKCpn86/VrFMnon8GSInnplcBS9BtN08oyuu5Th6/lMIvgUoSaxnbvFF1nYFjcYsfoFfk
 S7kfqP18QYZpsfZfdfg==
X-Proofpoint-GUID: XXIFJgl0950rLzc7NQJ91JQxSJS2lP8-
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c18d9f cx=c_pps
 a=lFLl6ekDlCbwJXWYbP8qnQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=zeMkc8NizSHT1Q7NrYkA:9
 a=QEXdDO2ut3YA:10
Subject: RE: [PATCH] libceph: Fix slab-out-of-bounds access in auth message
 processing
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230139

T24gTW9uLCAyMDI2LTAzLTIzIGF0IDEyOjM5ICswMTAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gT24gMy8yMC8yNiA3OjI4IFBNLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6DQo+ID4gY2M6
IGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gDQo+ID4gT24gRnJpLCAyMDI2LTAzLTIw
IGF0IDEwOjQxICswMTAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToNCj4gPiA+IElmIGEgKHBvdGVu
dGlhbGx5IGNvcnJ1cHRlZCkgbWVzc2FnZSBvZiB0eXBlIENFUEhfTVNHX0FVVEhfUkVQTFkNCj4g
PiA+IGNvbnRhaW5zIGEgcG9zaXRpdmUgdmFsdWUgaW4gaXRzIHJlc3VsdCBmaWVsZCwgaXQgaXMg
dHJlYXRlZCBhcyBhbg0KPiA+ID4gZXJyb3IgY29kZSBieSBjZXBoX2hhbmRsZV9hdXRoX3JlcGx5
KCkgYW5kIHJldHVybmVkIHRvDQo+ID4gPiBoYW5kbGVfYXV0aF9yZXBseSgpLiBUaGVyZWFmdGVy
LCBhbiBhdHRlbXB0IGlzIG1hZGUgdG8gc2VuZCB0aGUNCj4gPiA+IHByZWFsbG9jYXRlZCBtZXNz
YWdlIG9mIHR5cGUgQ0VQSF9NU0dfQVVUSCwgd2hlcmUgdGhlIHJldHVybmVkIHZhbHVlIGlzDQo+
ID4gPiBpbnRlcnByZXRlZCBhcyB0aGUgc2l6ZSBvZiB0aGUgZnJvbnQgc2VnbWVudCB0byBzZW5k
LiBJZiB0aGUgcmVzdWx0DQo+ID4gPiB2YWx1ZSBpbiB0aGUgbWVzc2FnZSBpcyBncmVhdGVyIHRo
YW4gdGhlIHNpemUgb2YgdGhlIG1lbW9yeSBidWZmZXINCj4gPiA+IGFsbG9jYXRlZCBmb3IgdGhl
IGZyb250IHNlZ21lbnQsIGFuIG91dC1vZi1ib3VuZHMgYWNjZXNzIG9jY3VycywgYW5kDQo+ID4g
PiB0aGUgY29udGVudCBvZiB0aGUgbWVtb3J5IHJlZ2lvbiBiZXlvbmQgdGhpcyBidWZmZXIgaXMg
c2VudCBvdXQuDQo+ID4gPiANCj4gPiA+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGlzc3VlIGJ5IGZp
cnN0IGFkZGluZyBhIGNoZWNrIHRoYXQgY2F0Y2hlcyBhDQo+ID4gPiBwb3NpdGl2ZSB2YWx1ZSBp
biB0aGUgcmVzdWx0IGZpZWxkIG9mIHRoZSBtZXNzYWdlIGFuZCB0cmVhdHMgaXQgYXMNCj4gPiA+
IGludmFsaWQsIGFuZCBzZWNvbmQgY29tcGFyaW5nIHRoZSBsZW4gcGFyYW1ldGVyIG9mDQo+ID4g
PiBfX3NlbmRfcHJlcGFyZWRfYXV0aF9yZXF1ZXN0IHRvIGZyb250X2FsbG9jX2xlbiB0byBwcmV2
ZW50IHNlbmRpbmcgdGhlDQo+ID4gPiBtZXNzYWdlIGlmIGl0IGV4Y2VlZHMgdGhlIGJvdW5kcyBv
ZiB0aGUgYWxsb2NhdGlvbi4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmFwaGFlbCBa
aW1tZXIgPHJhcGhhZWwuemltbWVyQHR1LWlsbWVuYXUuZGU+DQo+ID4gPiAtLS0NCj4gPiA+ICAg
bmV0L2NlcGgvYXV0aC5jICAgICAgIHwgNSArKysrKw0KPiA+ID4gICBuZXQvY2VwaC9tb25fY2xp
ZW50LmMgfCA1ICsrKysrDQo+ID4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygr
KQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L2NlcGgvYXV0aC5jIGIvbmV0L2NlcGgv
YXV0aC5jDQo+ID4gPiBpbmRleCAzMzE0NzA1ZTU5MTQuLjU1NWIxZmFiNDYyMyAxMDA2NDQNCj4g
PiA+IC0tLSBhL25ldC9jZXBoL2F1dGguYw0KPiA+ID4gKysrIGIvbmV0L2NlcGgvYXV0aC5jDQo+
ID4gPiBAQCAtMjE1LDYgKzIxNSwxMSBAQCBpbnQgY2VwaF9oYW5kbGVfYXV0aF9yZXBseShzdHJ1
Y3QgY2VwaF9hdXRoX2NsaWVudCAqYWMsDQo+ID4gPiAgIAljZXBoX2RlY29kZV9uZWVkKCZwLCBl
bmQsIHNpemVvZih1MzIpICogMyArIHNpemVvZih1NjQpLCBiYWQpOw0KPiA+ID4gICAJcHJvdG9j
b2wgPSBjZXBoX2RlY29kZV8zMigmcCk7DQo+ID4gPiAgIAlyZXN1bHQgPSBjZXBoX2RlY29kZV8z
MigmcCk7DQo+ID4gPiArCWlmIChyZXN1bHQgPiAwKSB7DQo+ID4gDQo+ID4gRnJhbmtseSBzcGVh
a2luZywgaXQncyBoYXJkIHRvIGZvbGxvdyBob3cgdGhpcyBpcyBjb3JyZWN0IHdpdGhvdXQgcHJv
dG9jb2wNCj4gPiBrbm93bGVkZ2UuIERvIHdlIGhhdmUgYW55IGRlY2xhcmF0aW9ucyBvZiByZXN1
bHQgcG9zc2libGUgdmFsdWVzPyBQcm9iYWJseSwgd2UNCj4gPiBuZWVkIHRvIGhhdmUgc29tZSBj
b21tZW50IHRoYXQgZXhwbGFpbiB0aGUgc2l0dWF0aW9uIGluIG1vcmUgZGV0YWlscyBoZXJlPw0K
PiA+IA0KPiANCj4gWWVzLCBpdCB3b3VsZCBiZSBnb29kIHRvIGhhdmUgYW4gZXhhY3QgcHJvdG9j
b2wgc3BlY2lmaWNhdGlvbi4gRnJvbSB3aGF0IA0KPiBJIGNhbiBzZWUgaW4gdGhlIGNvZGUsIHRo
ZSByZXN1bHQgdmFsdWUgaXMgZWl0aGVyIDAgZm9yIHN1Y2Nlc3Mgb3IgYSANCj4gbmVnYXRpdmUg
TGludXggZXJyb3IgY29kZS4gVGhlcmVmb3JlLCBhIHBvc2l0aXZlIHZhbHVlIGhlcmUgd291bGQg
YWx3YXlzIA0KPiBpbmRpY2F0ZSBhIG1hbGZvcm1lZCBtZXNzYWdlLiBCdXQgbWF5YmUgeW91IGtu
b3cgbW9yZT8NCg0KSSB3b3VsZCBsaWtlIHRvIGhlYXIgd2hhdCBJbHlhIGNhbiBzaGFyZSBoZXJl
LiA6KSBIZSBzaG91bGQga25vdyBtb3JlLiBUaGUgDQpyZXN1bHQgPiAwIGxvb2tzIG5vdCBvYnZp
b3VzIHRvIG1lLiBUaGlzIGlzIHdoeSBJIGJlbGlldmUgdGhhdCwgYXQgbWluaW11bSwgc29tZQ0K
Y29tbWVudHMgc2hvdWxkIG1ha2UgdGhlIGNvZGUgbW9yZSBlYXNpZXIgdG8gZm9sbG93Lg0KDQo+
IA0KPiA+ID4gKwkJcHJfZXJyKCJ1bmV4cGVjdGVkIHJlc3VsdCBjb2RlIGluIGF1dGggbXNnXG4i
KTsNCj4gPiA+ICsJCXJldCA9IC1FSU5WQUw7DQo+ID4gPiArCQlnb3RvIG91dDsNCj4gPiANCj4g
PiBNYXliZSwgZG8geW91IG5lZWQganVtcCB0byBiYWQ/DQo+ID4gDQo+IA0KPiBObywgSWx5YSBy
ZWNlbnRseSBtZW50aW9uZWQgdGhhdCB0aGlzIGlzIGludGVuZGVkIGZvciBjbGFzc2ljIGRlY29k
aW5nIA0KPiBlcnJvcnMuIEhlcmUsIGEgbW9yZSBzcGVjaWZpYyBlcnJvciBtZXNzYWdlIHNob3Vs
ZCBiZSBlbWl0dGVkLg0KDQpPSy4NCg0KPiANCj4gPiA+ICsJfQ0KPiA+ID4gICAJZ2xvYmFsX2lk
ID0gY2VwaF9kZWNvZGVfNjQoJnApOw0KPiA+ID4gICAJcGF5bG9hZF9sZW4gPSBjZXBoX2RlY29k
ZV8zMigmcCk7DQo+ID4gPiAgIAljZXBoX2RlY29kZV9uZWVkKCZwLCBlbmQsIHBheWxvYWRfbGVu
LCBiYWQpOw0KPiA+ID4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL21vbl9jbGllbnQuYyBiL25ldC9j
ZXBoL21vbl9jbGllbnQuYw0KPiA+ID4gaW5kZXggZDUwODA1MzBjZTBjLi43MjA2ZGI1Zjc2OTUg
MTAwNjQ0DQo+ID4gPiAtLS0gYS9uZXQvY2VwaC9tb25fY2xpZW50LmMNCj4gPiA+ICsrKyBiL25l
dC9jZXBoL21vbl9jbGllbnQuYw0KPiA+ID4gQEAgLTE3NCw2ICsxNzQsMTEgQEAgaW50IGNlcGhf
bW9ubWFwX2NvbnRhaW5zKHN0cnVjdCBjZXBoX21vbm1hcCAqbSwgc3RydWN0IGNlcGhfZW50aXR5
X2FkZHIgKmFkZHIpDQo+ID4gPiAgICAqLw0KPiA+ID4gICBzdGF0aWMgdm9pZCBfX3NlbmRfcHJl
cGFyZWRfYXV0aF9yZXF1ZXN0KHN0cnVjdCBjZXBoX21vbl9jbGllbnQgKm1vbmMsIGludCBsZW4p
DQo+ID4gPiAgIHsNCj4gPiA+ICsJaWYgKGxlbiA+IG1vbmMtPm1fYXV0aC0+ZnJvbnRfYWxsb2Nf
bGVuKSB7DQo+ID4gPiArCQlwcl9lcnIoInNlbmRpbmcgYXV0aCByZXF1ZXN0IGZhaWxlZCwgYmVj
YXVzZSBsZW46ICVkIGV4Y2VlZHMgYWxsb2NhdGlvbiBzaXplOiAlZFxuIiwNCj4gPiA+ICsJCQls
ZW4sIG1vbmMtPm1fYXV0aC0+ZnJvbnRfYWxsb2NfbGVuKTsNCj4gPiANCj4gPiBJcyBpdCBwcm9w
ZXIgcGxhY2UgZm9yIHRoaXMgY2hlY2s/IEl0IGxvb2tzIGxpa2Ugd2UgZmFpbCB0byBzZW5kIHNv
bWV0aGluZyBhbmQNCj4gPiBleGVjdXRpb24gZmxvdyBoYXMgbm8gaWRlYSB0aGF0IHdlIGZhaWxl
ZC4gWWVzLCBzeXN0ZW0gbG9nIHdpbGwgcmVjZWl2ZSB0aGUNCj4gPiBlcnJvciBtZXNzYWdlIGJ1
dCB0aGUgcmVzdCBvZiB0aGUgbG9naWMgd2lsbCBjb250aW51ZSBidXNpbmVzcyBhcyB1c3VhbC4g
TWF5YmUsDQo+ID4geW91IGFyZSByaWdodCBidXQgaXMgaXQgbm90IHRvIGxhdGUgdG8gc2ltcGx5
IGNvbXBsYWluIGhlcmU/DQo+ID4gDQo+ID4gQW5kIGlmIHdlIGRvbid0IHNlbmQgdGhlIHJlcXVl
c3QsIHRoZW4gY291bGQgaXQgYWZmZWN0IHRoZSB3aG9sZSBmdW5jdGlvbmFsaXR5Pw0KPiA+IENv
dWxkIHdlIGludHJvZHVjZSBhIHJhY2UgY29uZGl0aW9uIG9yIGRlYWRsb2NrIGhlcmU/DQo+ID4g
DQo+ID4gVGhhbmtzLA0KPiA+IFNsYXZhLg0KPiA+IA0KPiANCj4gVGhpcyBjaGVjayBzaG91bGQg
bmV2ZXIgYmUgdHJ1ZS4gSXQgaXMganVzdCBhIGNvbW1vbiBwbGFjZSB3aGVyZSBhIA0KPiBzZXZl
cmUgZGF0YSBsZWFrYWdlIGNhbiBiZSBwcmV2ZW50ZWQgaWYgYW55dGhpbmcgd2VudCB3cm9uZyBi
ZWZvcmUsIA0KPiBiZWNhdXNlIG1fYXV0aC0+ZnJvbnQuaW92X2xlbiBpcyBtb2RpZmllZCB0aGVy
ZS4gVGhpcyB3b3VsZCBwcmV2ZW50IA0KPiBhbm90aGVyIGJ1ZyBsaWtlIHRoaXMgaWYgdGhlIGxv
Z2ljIGJlZm9yZSB3YXMgZmxhd2VkLiBUbyBmaXggdGhlIGN1cnJlbnQgDQo+IHZ1bG5lcmFiaWxp
dHksIGl0IGlzIG5vdCBhYnNvbHV0ZWx5IG5lY2Vzc2FyeSB0byBoYXZlIHRoaXMuDQo+IA0KPiBN
YXliZSBhbiBhc3NlcnRpb24gbGlrZSBhIEJVR19PTiBpcyBhbHNvIGZpbmUgaGVyZS4gT3RoZXJ3
aXNlLCB0aGUgDQo+IGhhbmRsaW5nIG9mIHRoaXMgZnVuY3Rpb24gd291bGQgbW9zdCBsaWtlbHkg
aGF2ZSB0byBiZSBjaGFuZ2VkIGF0IA0KPiBtdWx0aXBsZSBwbGFjZXMuDQoNCk1heWJlLCBCVUdf
T04oKSBsb29rcyBsaWtlIG1vcmUgcHJvcGVyIHNvbHV0aW9uIGlmIHdlIHNob3VsZCBub3QgYmUg
aGVyZSBmb3INCnN1Y2ggY2FzZS4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==
