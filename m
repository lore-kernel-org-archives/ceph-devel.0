Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC35F3E8C67;
	Fri, 24 Apr 2026 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056799; cv=fail; b=OPLm2rcJQwqUEHsfMCLMCNm11tfETKMJhr3zTfzAuec2iJcLd45HZcxTUwtwuzp2QKh3yZNV/QEGrujjak66GNondw51o2CtnzKpST8Xe6S2rNeR3cngudSbXHxr2q4fJg7SMeieDpEe62NYSs8xtutUK4tPjzvlvsLIsHKbNGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056799; c=relaxed/simple;
	bh=i/Op8SH4B694JT6ffAZNRC7OWoLZx7NPKx9+pwyFpt4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FSDHGh4K/flKs3Yvw7olY21RLOoCD2169OEuA5Zq0YeWase5DbBH2H3RdGXjOAgP3vwFO86GTqhGEdxAe/cdrDaL4J8k1IsteBpSASQZizb/U2u17PZXtExF6MXv2+bHHueiAkpI1gy5M2QNpeaTbOg9zhTcLKa3QDRH4cJ2JNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X8fSNAtU; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X8fSNAtU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63ODhoiq3107450;
	Fri, 24 Apr 2026 18:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=i/Op8SH4B694JT6ffAZNRC7OWoLZx7NPKx9+pwyFpt4=; b=X8fSNAtU
	tvd7/ymLXY1qXEStDWv3QGqSGoDK36u5G+43Ma3cPfpuIC8X7OHjp22DboQIbmw4
	AXn4o0Q/VBor/yykL8YOWzGF5hYAu2MsWrNR/1xKdFT1AFuu/SdAAYy27cz0FJP5
	k7Dzmzo36TD+DBiYyDxnS+fP8zkuNeZCZoOpTaz4JRmL9ux73ggoxY8A3vNTmnY2
	GjQghdLuwT16G8fZLfGuvdWDPK69phrIZuHc2rabJuPUfu/ZcjB5GHDqygA/g1dC
	RtkcE0NbrPhJtMEWx3yvs8y6EvaLyfZ6UOe1cQYANUY+nDBYSSK+7bVr4eMbVmG6
	AV9tcnrFz8aiXg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6pgp0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 18:53:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL6wCoTCEZQRuNJczn5h/+aSl5LnrHtObzaVZHYRWLcL9IgmzfHZKWnuWwXIA3330uRrRBdLtRDIZgb+fI8qwaJtZn7ujBFv8XjyUkLOqHJzPShECRPsRCSG8l31SqgrWBmHLlF1UCnwqK9YGqwIP3gnwNq7tI8qlNuYS43GWJ+DEQwxhzEi654/nbiuZDoDM1rq5UWc+EDSV8f2I20ZMbuiGdYlC/f697N8xdc0Y2jyw8wCjbXWWJlF8zb8FUaLTsy6FvZygyfWfAB+AaP4TiMhV+jw7Skvu/UQPIR4VAO+L0X2E511Cmh0p4HBRgC8j7sQLV/7pRMQ6tftQ+WyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/Op8SH4B694JT6ffAZNRC7OWoLZx7NPKx9+pwyFpt4=;
 b=gToIar6GOWH7qhVpyQMUkxnP3SqX/bRj7UQWbN5p7d57Jz1zcZbKXaB36CcZNk4soDgb5EFtbv0SNIBHpeXLv/9FllPpX/tsp8jp7lZgAnevauFiwoptfRXucNzoBgLIA4t7xyyQ0UBTePvM6MJoPpYc/+pN5NG+TGyxcF+C0cVbP8zKmwm46zxkYD+gBz3ngZub4ZaB04K9No/wb6c5MnU9uAMF5tmY28M21NlIQZsiCniaWBWFCn0wXb4QDqfsMGk9JnbTqFXUiO0Us6CU8DclnQGh7UdRju3kTtC2PGy9rny53juI55l4nEVZ86v3OWm0bPAHaD3RNRFLgQusGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA3PR15MB5630.namprd15.prod.outlook.com (2603:10b6:806:304::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Fri, 24 Apr
 2026 18:53:09 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 18:53:09 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>
CC: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Patrick
 Donnelly <pdonnell@redhat.com>
Subject: Re: [PATCH] libceph: switch ceph-msgr workqueue from WQ_PERCPU to
 WQ_UNBOUND
Thread-Topic: [PATCH] libceph: switch ceph-msgr workqueue from WQ_PERCPU to
 WQ_UNBOUND
Thread-Index: AQHc1BuYWsOYp54nUEWAlPMRQN/iiA==
Date: Fri, 24 Apr 2026 18:53:09 +0000
Message-ID: <d315d2b289b9dc561455e00d6742c35242e8b9f3.camel@ibm.com>
References: <20260409191517.318015-2-slava@dubeyko.com>
	 <CAOi1vP_OFnzuJB438=L_MUS2K0m7j49en=U2K19ZrH-xYUzaLQ@mail.gmail.com>
	 <1a5b5d23dc54c9099643795bfad9f14705505fed.camel@ibm.com>
	 <CAOi1vP95f6x5LX0TmsKxG6k57mCq3HdGBQRL5UJR7sprjHLq-Q@mail.gmail.com>
In-Reply-To:
 <CAOi1vP95f6x5LX0TmsKxG6k57mCq3HdGBQRL5UJR7sprjHLq-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA3PR15MB5630:EE_
x-ms-office365-filtering-correlation-id: d111dcf5-8a6e-4295-876c-08dea232bab7
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 8csb5Or8HbLgvozzpXB3QblyVcMq1xsOGjq7ZTjvdw/xeoYiYCAHeNYKlVqZHKzp2w9H38eu0O5n9ZYs3t8GVsK3GeMj5zYxeQg/QW/1RD9X2sbtaXlO4F/gphNmO5xuOVddxtkP/1SEr3JUoaY/8Rx2OB5jygKwiji0ZMdFmdhmTozYaw2GNfi3O62YEzj8L7wZHiNeWJgw7eu7HbwYTFtTiOBugu7EvkMABIiXpn8wHjV3ZkXXOY8nngqInyYg4QhV2BmFPRgpYrVxwSLZpXtreBhTHapusfgUPVN5ErdW6GaaffE2yETsLUqP2JoFJwR+I5a3srVPQe6TQoVjFHPB4TDScf78fiA+bg9kbIZWpUbx5w/jSkY7mEIfL3Sk5bT2cey1n+JjM4aPFE4957dBrvvnzSZnMQiEhtkSYAPtlE8eTyhuCbO8b19v592MSK901haLeSzCfGfSatlQLHMjw47nGpkRZbPFBMZixvwi+xzsrX2cPjGqmV5ddcxRfD5xxJhJtkERl8A5N5D0gmIAJ3EmhIuLpd39beRyV1ZVgnbE33WppRBOIx7w/ycNw1KcaGAKjwPv5ueQTXoaem9jlcUTI5mr0dZKHGq3C4GOXMTqMCd0YqYZZCgFU2TgXbZd5tDRTeKhc9pDq3zT6gCKJVCm0rNo3MfCMp1yVb44goYbiyh8esZxXT+SmUL4fxqw8L3ohBGRXfXLnM6Pf8kMAQfgwq5zaHAzEXNRrjFC2DgaEsyGIQh2vLE7DUMkNHcs4I1LMr1YxUZjagKjVAcet1s1ZXg69VvFilAR6OM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1FyTXhFWDBNdXpHZFZzdkVUSWpjeHJaanc1enVmOWRFZFkySVpZTE4xZ2NG?=
 =?utf-8?B?MEVRRW0yQ1lxUGp1ODV0MDhUV3BYTjJTSWlIMi9NcmFBTXh6NG53dW13eW90?=
 =?utf-8?B?SlMxbm9Sa2ZFemJCNm9HV25Fd2dBbHlvTTRVK3JWS3EySktjTEtXdXlSWEFF?=
 =?utf-8?B?a001ZFZkcnVuMnRSZUZMWmZJM21DdG5xNmhnVHNVUEorYlA5ZzgrNE1CVEs0?=
 =?utf-8?B?UDRNQUtsNTVNeUlBNG4vZUxYLyt4U3ZwNzFvSkxpSWFKRHoxWXlmejJYMWN4?=
 =?utf-8?B?L29pckxCdk5nWTRDa2s3dkVCQWlCaXV4SmhzTlRYb2d0TnVWT3NoWTJwMnZw?=
 =?utf-8?B?azA2UWMxQklHemdwQ1kxSzVLZERyUGVYZ1RudDJVSjJvVTFjSnhLNUJrWmdN?=
 =?utf-8?B?dlJEWjQralUyVS9HVkJJMEJWWGhzQnJWNnNITHhMYW5jRE4vVkdBL0VRTXNW?=
 =?utf-8?B?RjhrNGkyVlNNTnE2SnFlcUsvOEt1YzdiYVVQeTl4anZjdXBBdUhNQTZLYno1?=
 =?utf-8?B?Q05XSUs3amVhcUIvR3VzQVI5alRmcnBxbFAxa0JUR2tZYkk1S3cvZzZWalc1?=
 =?utf-8?B?Y3Z3cFJLZW1Tcmg4ZmExS2d5N2hUQ1ZZTWM4dGZsWUZBOWRLdEpFbm5aT2Ur?=
 =?utf-8?B?WElQRmF6QWkwUnlEUWNnYXFqOTFXZmVWWjlSZ0lCdEMybzFacFJJb2NwMWhE?=
 =?utf-8?B?dm1uT2hJaXh6QnRIOUNzZk9HVjIwVmlnYjk2NnpkL0VQakRyNTlUVkhpYWox?=
 =?utf-8?B?L0dxYmx0UUpPa29EMXdlMy9GeHZzMlpEZHM5dFlxZXRkMkRta1BiQ1B3QjJX?=
 =?utf-8?B?N1lIUXQxUzhRaVljY0p4VU16UjNhZ1k2bHlseEtLZUltZXVlenFYM2Y2L0ww?=
 =?utf-8?B?K25oWFlJcUE2YVEycXFkRmZQTGVvT0JvaE5sWkdvSkJkSUtXNStsTCtVcGxq?=
 =?utf-8?B?V2hHTWluQzZCa052MUZBdlkwUkM2VEdvRVpKbWVWMWJERzY1NkZRWHYySUhk?=
 =?utf-8?B?ODQ5UUx4VU9jZTZMRkRRYzRIRnJNOUh2c0ZLbnJtNFdhTnAyQTlqU1VpRVh4?=
 =?utf-8?B?V0lrQ0VsdG1WdHJtR1lJSHVhSnVoWFNlNTFvS2pEQUdRUk5kS0JlSGtuK0xU?=
 =?utf-8?B?ODI5NldiVTlnTlVPZzZJN2tkRGtQdysrNzFMUnU0eFBLOUpLRmVoME1YYWs0?=
 =?utf-8?B?aVBzS2ZEdmlDYlR0cUhhbitxMU03QzNBQnRTMk9vTVE2K1pzeFMwQ2pxQjds?=
 =?utf-8?B?QXdjbzFTYlFXQTBFTlRiVzZVeDUvRGVjUWIyNHhRV1Y5YXpUNWRYU2FqSFBQ?=
 =?utf-8?B?elhtTFJHTjZaWU54N2UxdGZZM1FDd1RZL2tvWlhEUml3MjBKRno4OVNsb0Rq?=
 =?utf-8?B?VU1lVXd6NXFlS1NsQSt5WGt5MDJyWGFnL3U0cnIyUjRraS9JVllCR1JwZEp2?=
 =?utf-8?B?M0VsRDZsWHkxa1g4MmEvRjBtMmIrTlJyamlUVDV3ckRmK3JyLzNra3VYZS9H?=
 =?utf-8?B?L29rNXQzOElGaWxsMU9aT0Y4TUZrd2c2QWx0NVZoSFFZckZzZFkyeVlxSzZT?=
 =?utf-8?B?ZWwxOFhmVkY2U0hCSlVlZE9NOTlmWFVlMFBIaHU1cUQvVm1RY3U4SDZMTHdz?=
 =?utf-8?B?eHErcXhRekl1dTlqdzRtWFVpS0pyL3RrdXMzcWRUZW4vRkVIU2kyMUx0Z0g1?=
 =?utf-8?B?dzZHelhDSkdtaW05SzR1b1d6ZEpoMERBaERkQWpGSlJlR3h2WXpXZFhsb1RT?=
 =?utf-8?B?MHMxVnpwNW5hM1VYUGluVDQwOFJBTTB1K0xBdTM0cnNpalJWNUlyU3hNcmJ2?=
 =?utf-8?B?akEyOG0yMEFPS05vb05IMld1dTFrcEpYcWk2R081TUs4Z3B1UUMrMVNEd1V1?=
 =?utf-8?B?NlY3OGZ6Sml6ZVpEd3lqSUxOT3doZVI1RWk3RHpJNGpkR2l1VTQyYlgwQVV3?=
 =?utf-8?B?eFYyVm11Y0xIdGZUWlh5M0hadE1WcUNLRXdLMDNvY2V6VGRIaFF4dU54S1pT?=
 =?utf-8?B?N2RUbmhuQ3FReDFBL2pLeXV4Ull3WjNQRERWVjhTTm1vcURlVy9YK3RWT2Er?=
 =?utf-8?B?TTBLTVhCUmttOHF6Q3JsZGh2Q1NLMW10N2xMb3RtRzZjOG9mYzFnMUliVGwr?=
 =?utf-8?B?UjBOUzJGTlVUV1VZUTMzZUNwck50ZURMYmdQdE9vVTlqV1lSUlRIWmVwenNI?=
 =?utf-8?B?ZUdQWEVJci90MVRZUXduOVVwL2FhelI5RVdYbGh1TnpXQ0txN0kyYjFOM2lv?=
 =?utf-8?B?RCtFUDk0d2xjYVZZKzkyVU5jMWYyVHY0ZmJHd2FrRm1LaEpvMUUwZjdULytN?=
 =?utf-8?B?emhScmRyRGI1Z1o5b0JxS1RHb2ZmVnNabDdaWTU1MFdpVHdJUEwrZy84cjl0?=
 =?utf-8?Q?sAy2uy4iBu5mXD2sBaCYr+tH5b6LG3TXzDhfl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C06842BDAFEE31468EA7B723B8F548A8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Zwtk0FLFWPPtiHzjaqMxDTnRI8lPMQn/PFvaQpRaNDze+qqCtgFJxyBWnWABUK/ntVwLTyODGCvRLBn96ki6mCdB/RwP7w4xNeVYgZcL5cNQVSx65CG4bI73lGpJVZnhbX09jvqh0bR7C3hNYd7pViIgz3PlsudVeiteCVLv/fqy+19G+jNy5PjyHeirLqllA9qFvPyFHLKWMOLDZEic2nl7tZaQMHTBAO10r2W18f3K0F9kLxUB6jaqkJm9XYxFwTvqRZFsD9sKHyux/D5+fHf5qNWHPqrlVvYgASq6W2h979U8jcVajVP0+mdToKeTM4TS4yMntiCS5suci0cHXw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d111dcf5-8a6e-4295-876c-08dea232bab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 18:53:09.7460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e03kAmwAqPYmjPeUk0L3llbqYnzIGhOCiz+pOqit9j/XvPdcgLFekmeNjqUZ8OFRWf2EuAwWDWQH1aYfsgxotg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5630
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE4MyBTYWx0ZWRfXz/RnNsbGxu6c
 nNBbZw+7MNNERhD7EVWrVKKOlTAMcI+RQBkebOmejqdetmeDxhlnvhb9wc4Q8+SnmxcCE6vK1+z
 MnhoP6Rltw2EOBw1T+KImF34NMFbzKfcf5pxBlco60AiyMt86ZkRglFlT44jwX7mD58GQugy+xi
 97aSm45SGlYdHaRzSeLxZdFsCJTnjUxTcrQRjkMeHXlj4sHaUwobwiD+CtQ/gF/zBu8NE3asy0X
 q1lTnO9KGDvNgTOMmabD70zgS7bEEtkNp2/RKj4mLabMsoOXX5IiNyVYSjn53oBheO53iYrpef1
 S+lrSVxKnCoOGFEUptewWwHci9Qz8Sy54WYod7Kxb6sd9lnJ8gfMwpgNh2OIrp9zN3xw18DiEe+
 cmslnSTO3BGmgN217mAC4LlnStd13DG40b8OTQYHrVrdllqNeMp2kSQTTvTL1DlJz3yLJoxKJMA
 zgZyEyVPwa8wtbzw0YQ==
X-Proofpoint-ORIG-GUID: BTomIXArhgNYOqmGYQmphrnwaqcG5yIM
X-Proofpoint-GUID: 6rSEfNwMLk9D5Zyal9JIMx3TycNvvipX
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69ebbc1a cx=c_pps
 a=+iTzTTZpyf9i2pLb45wEOw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=wCmvBT1CAAAA:8
 a=BEEObsbIldKNr8qYPjkA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240183

T24gRnJpLCAyMDI2LTA0LTI0IGF0IDEyOjIyICswMjAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IE9uIFRodSwgQXByIDIzLCAyMDI2IGF0IDc6NTnigK9QTSBWaWFjaGVzbGF2IER1YmV5a28NCj4g
PFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gV2VkLCAyMDI2LTA0
LTIyIGF0IDE3OjM0ICswMjAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEFw
ciA5LCAyMDI2IGF0IDk6MTXigK9QTSBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28u
Y29tPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IEZyb206IFZpYWNoZXNsYXYgRHViZXlrbyA8
U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIGNlcGgtbXNnciB3
b3JrcXVldWUgd2FzIGNoYW5nZWQgdG8gdXNlIFdRX1BFUkNQVSBpbiBjb21taXQNCj4gPiA+ID4g
MjdjZTcxZTFjZTgxICgibmV0OiBXUV9QRVJDUFUgYWRkZWQgdG8gYWxsb2Nfd29ya3F1ZXVlIHVz
ZXJzIikgYXMgcGFydA0KPiA+ID4gPiBvZiBhIHRyZWUtd2lkZSB0cmFuc2l0aW9uIHRvIG1ha2Ug
cGVyLUNQVSB3b3JrcXVldWUgYmluZGluZyBleHBsaWNpdC4NCj4gPiA+ID4gDQo+ID4gPiA+IEhv
d2V2ZXIsIGNlcGhfY29uX3dvcmtmbiBjb250YWlucyBhIHdoaWxlKHRydWUpIGxvb3AgdGhhdCBy
ZXRyaWVzIG9uDQo+ID4gPiA+IC1FQUdBSU4gZnJvbSBzb2NrZXQgcmVhZHMgYW5kIHdyaXRlcywg
bWFraW5nIGl0IGNhcGFibGUgb2YgaG9nZ2luZyBhDQo+ID4gPiA+IGJvdW5kIENQVSBmb3IgZXh0
ZW5kZWQgcGVyaW9kcy4gVGhpcyBtYW5pZmVzdHMgYXQgcnVudGltZSBhczoNCj4gPiA+IA0KPiA+
ID4gSGkgU2xhdmEsDQo+ID4gPiANCj4gPiA+IGNlcGhfY29uX3dvcmtmbigpIGRvZXMgaGF2ZSBh
IGxvb3AsIGJ1dCBpdCBkb2Vzbid0IHJldHJ5IEVBR0FJTiBmcm9tDQo+ID4gPiB0aGUgc29ja2V0
LiAgQm90aCBtc2dyMSBhbmQgbXNncjIgbXVuZ2UgRUFHQUlOIGZyb20gdGhlIHNvY2tldCB0byAw
IHRvDQo+ID4gPiBpbmRpY2F0ZSB0aGUgInNvY2tldCBpcyBlbXB0eS9mdWxsLCBuZWVkIHRvIHdh
aXQiIGNvbmRpdGlvbi4gIFNlZQ0KPiA+ID4gZG9fcmVjdm1zZygpIGFuZCBkb19zZW5kbXNnKCkg
Zm9yIG1zZ3IyIGFuZCBjZXBoX3RjcF8qKCkgZm9yIG1zZ3IxLg0KPiA+ID4gRm9yIGV4YW1wbGU6
DQo+ID4gPiANCj4gPiA+ICAgICByZXQgPSBzb2NrX3JlY3Ztc2coc29jaywgJm1zZywgbXNnLm1z
Z19mbGFncyk7DQo+ID4gPiAgICAgaWYgKHJldCA8PSAwKSB7DQo+ID4gPiAgICAgICAgICAgICBp
ZiAocmV0ID09IC1FQUdBSU4pDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgIHJldCA9IDA7DQo+
ID4gPiAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gICAgIH0NCj4gPiA+IA0KPiA+ID4g
SWdub3Jpbmcgb3BlbmluZywgY2xvc2luZyBhbmQgYSBjb3VwbGUgb2Ygb3RoZXIgc3BlY2lhbCBj
YXNlcywNCj4gPiA+IGNlcGhfY29uX3dvcmtmbigpIHN0YXJ0cyBieSB0cnlpbmcgdG8gcmVhZC4g
IFdoZW4gdGhlIHJlYWQgc2lkZSBvZiB0aGUNCj4gPiA+IHNvY2tldCBiZWNvbWVzIGVtcHR5LCBp
dCBwcm9jZWVkcyB0byB0cnlpbmcgdG8gd3JpdGUuICBXaGVuIHRoZSB3cml0ZQ0KPiA+ID4gc2lk
ZSBvZiB0aGUgc29ja2V0IGJlY29tZXMgZnVsbCwgY2VwaF9jb25fd29ya2ZuKCkgdGVybWluYXRl
cy4gIEl0DQo+ID4gPiBkb2Vzbid0IGV2ZW4gZ28gYmFjayB0byB0cnlpbmcgdG8gcmVhZCwgc28g
SSBmYWlsIHRvIHNlZSB0aGUgcG90ZW50aWFsDQo+ID4gPiBmb3Igd2hhdCB5b3UgaGF2ZSBkZXNj
cmliZWQuDQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+ICAgd29ya3F1ZXVlOiBjZXBoX2Nvbl93
b3JrZm4gaG9nZ2VkIENQVSBmb3IgPjEwMDAwdXMgTiB0aW1lcywNCj4gPiA+ID4gICBjb25zaWRl
ciBzd2l0Y2hpbmcgdG8gV1FfVU5CT1VORA0KPiA+ID4gPiANCj4gPiA+ID4gU3dpdGNoIHRoZSB3
b3JrcXVldWUgdG8gV1FfVU5CT1VORCBzbyB0aGUgc2NoZWR1bGVyIGNhbiBmcmVlbHkgcGxhY2UN
Cj4gPiA+ID4gd29ya2VycyBhY3Jvc3MgQ1BVcywgcHJldmVudGluZyBzdGFydmF0aW9uIG9mIG90
aGVyIHdvcmsgaXRlbXMgb24gdGhlDQo+ID4gPiA+IGJvdW5kIENQVS4gVGhlIGxvc3Mgb2YgY2Fj
aGUgbG9jYWxpdHkgaXMgYWNjZXB0YWJsZSBmb3IgbmV0d29yayBJL08NCj4gPiA+ID4gd29yay4N
Cj4gPiA+IA0KPiA+ID4gVGhpcyBtaWdodCBiZSB0cnVlLCBidXQgSSdtIG5vdCBzdXJlIHRoaXMg
Y29uY2x1c2lvbiBjYW4gYmUgbWFkZQ0KPiA+ID4gd2l0aG91dCBhdCBsZWFzdCBzb21lIGJlbmNo
bWFya2luZy4NCj4gPiANCj4gPiBNeSBzeXN0ZW0gbG9nIGlzIGZ1bGwgb2YgbGlrZXdpc2UgbWVz
c2FnZXMgIndvcmtxdWV1ZTogY2VwaF9jb25fd29ya2ZuIGhvZ2dlZA0KPiA+IENQVSBmb3IgPjEw
MDAwdXMgTiB0aW1lcywgY29uc2lkZXIgc3dpdGNoaW5nIHRvIFdRX1VOQk9VTkQiIHdoZW4gSSBh
bSB0ZXN0aW5nDQo+ID4gdGhlIENlcGhGUyBrZXJuZWwgY2xpZW50IGJ5IG1lYW5zIG9mIHhmc3Rl
c3RzLiBXaGljaCBwYXJ0aWN1bGFyIGJlbmNobWFya2luZw0KPiA+IHdvdWxkIHlvdSBsaWtlIHRv
IHNlZT8NCj4gDQo+IEhpIFNsYXZhLA0KPiANCj4gV2hhdCBraW5kIG9mIGEgc3lzdGVtIGlzIGl0
PyAgSWYgaXQncyBhIHNtYWxsIFZNLCB0aGUgYmFja2luZyBDZXBoDQo+IGNsdXN0ZXIgaXMgYSB2
c3RhcnQtc3R5bGUgZGVwbG95bWVudCBjby1sb2NhdGVkIG9uIHRoZSBzYW1lIG5vZGUgYW5kDQo+
IHRoZSBub2RlIGl0c2VsZiBpc24ndCBiZWVmeSwgdGhlIHBlcmZvcm1hbmNlIHByb2ZpbGUgbWF5
IGJlIHZlcnkNCj4gZGlmZmVyZW50IGZyb20gcmVhbCB3b3JsZCBzZXR1cHMuDQoNCkkgaGF2ZSB0
aHJlZSBub2RlcyBjbHVzdGVyIG9uIHBoeXNpY2FsIG1hY2hpbmVzIGFuZCBDZXBoRlMga2VybmVs
IGNsaWVudCB3b3Jrcw0KaW5zaWRlIG9mIFZNIG9uIGFub3RoZXIgcGh5c2ljYWwgbWFjaGluZS4N
Cg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gDQo+IFRoZSBmaXJzdCBzdGVwIHdvdWxkIGJlIGRldGVy
bWluaW5nIHRoZSBzb3VyY2Ugb2YgdGhlIGhvZ2dpbmcuICBPbmUNCj4gdGhpbmcgdG8ga2VlcCBp
biBtaW5kIGlzIHRoYXQgT1NEIGFuZCBNRFMgcmVxdWVzdCBjYWxsYmFja3MgYXJlIGV4ZWN1dGVk
DQo+IGluLWxpbmUgKGkuZS4gZnJvbSBjZXBoLW1zZ3Igd29ya2VyIHRocmVhZHMpLiAgSWYgdGhl
cmUgaXMgZXZpZGVuY2Ugb2YNCj4gc2lnbmlmaWNhbnQgbG9jayBjb250ZW50aW9uIG9yIGFueSBv
dGhlciBhY3Rpdml0eSB0aGF0IGNhbiBwb3RlbnRpYWxseQ0KPiBob2cgdGhlIENQVSBpbnNpZGUg
b2YgZS5nLiBNRFMgY2xpZW50J3MgaGFuZGxlX3JlcGx5KCkgdGhhdCB3b3VsZCBiZQ0KPiB0aGUg
dGhpbmcgdG8gbG9vayBpbnRvIGFuZCBmaXgsIG5vdCB0aGUgbWVzc2VuZ2VyLg0KPiANCj4gVGhh
bmtzLA0KPiANCj4gICAgICAgICAgICAgICAgIElseWENCg==
