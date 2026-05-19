Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975A372EFA
	for <ceph-devel@vger.kernel.org>; Tue, 19 May 2026 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217786; cv=fail; b=rPoDFRwtUKn9oTK8oHmF6sB6AqJnLh5L4U0k6JhRTsl1Hw586KcFrKmfkBbe2aQibXi9KSVJV3xhDKhxmqhUx0H/TTjj2i1tlVPiWO1wAxMaBcPczqbY4wEdIWCbzumKyfVe0aE2ANYkmtfB9qsj9koSXIuIivUlhbaSRu+5UWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217786; c=relaxed/simple;
	bh=nFQzcpRixkT+HKXAVMqoy8J0X993WS3zIOrS1ehfRFs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=UrMt3i++pwsCFeQO873nvdI03WNhYA8+9PzH18GuCw/eqp/XI5MEWnAKS0pVkbcVKtttYuBGX027e/pV11UtlPUsJqZKbx1559T0FN5EW0DLAHBAFbMxjylQ9pWYbh+K24QAnpwByvMt38w0xXqvRdDLwMWgseTsYMfIWtKC8SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RKxQYBmI; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RKxQYBmI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JIGSMU2723414;
	Tue, 19 May 2026 19:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=nFQzcpRixkT+HKXAVMqoy8J0X993WS3zIOrS1ehfRFs=; b=RKxQYBmI
	RzyevMXSqMdZib5nvoNGIeF3mM1hPk+YxEs81zDlghIifBk+hqcnLqK6yEqUukPO
	n5fyYhmCUQQssUwKipT8UkB74Y37krkc2g99Bb7H+aySvRxGo+xiffqrQfWe7HVc
	OwKB107T5Qui+dg7Dtv4u0p+xDqoBJDWXN10qYw8fexlpXKnq5EbnlGjmRgrcaAb
	bPQGlAA/yl62qC36+mLzCWSb1A105JXQzALZUy314V+hhq4zoF9qz32vRnAEIwfh
	Q0IziS1pIs24CiSZj5u28L2eiBcpA+AdVtdKrHsWKPsoGooq+9KvwdkrcMYyMH1K
	dHpBBWBCFH1MQg==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xxruw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:09:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFqIXsnVcETjwLh/do3JOVAk5ogA/YJuP72SX9OvucREgakwHDOYWhaVJYNerv1a5ri4E4YLVfItkJORVXSw2imEKjpdH7uugCOo3r+TAu3oAy444Wgqner7Lb60Z88/sedG14frT4obpkfGOjMjtwr814JBIDdiuuNUZMuZefqjtCMRdONQeRtJporyK+T7LtzCObgvhZiXsjp9MCBTJPfWKj1Qys/MTc8/7p87XfOOUqPKaT6BBQy6qKFMM1q5ZiPvBsh/UlaqnLOvrSC8aPEGXx2IieZOKWgbdu6YYBUWwjwct4KnJcyGsk7Dds1H7vTbW47I8zrUaBydbbnXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFQzcpRixkT+HKXAVMqoy8J0X993WS3zIOrS1ehfRFs=;
 b=ZPcdai3w0SWXGNKplonSQ7mxpy8HLoHmr5SvuY/YElkiQ7ePlD4lEOdFB3nY6NQs8ifR36cGkqPDVYcUp7cBYqVdRfPMHzSCi6O/4KcHCDvoDXe99bp73RszlHODJMPRpHQSsgKtoHeTagnf6HfzOyTkK2sqFOG3MAdDcZCzPGKVz5iWgY6Yd9UhCRrEMMzOaHUnHEgpVcBIbXXCmytm4k0g+yE60UxUmzW8OFMIua0jQvAfKkuQJIL1ot5CyKRBoxMpRWuaj5delErbF81P7cZaxdrO/v2sMkMD+aw0hTQwjU3VBPaeV8M6UEiVsNXM9SKVDgu2JMez9JKSLeWk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4591.namprd15.prod.outlook.com (2603:10b6:510:89::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Tue, 19 May
 2026 19:09:18 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 19:09:18 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v3] libceph: Fix multiplication overflow in
 __decode_pg_upmap_items()
Thread-Index: AQHc54BhLJ1K8k2skEC7Qa1hPZSLhrYVtvmA
Date: Tue, 19 May 2026 19:09:18 +0000
Message-ID: <00c3f93f7bd2752c0ed45c36ab139582a47ee3ad.camel@ibm.com>
References: <20260519110130.2189287-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260519110130.2189287-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4591:EE_
x-ms-office365-filtering-correlation-id: c896cca4-971e-4271-c6b6-08deb5da2087
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|3023799007|38070700021|11063799006|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 riSWivpbWRhxlPpVN0Wj1CZwqEWaKp2mYnPH/uwRAKMe6/kzfxKUVhoe6qzr6ITSgSisvMONlRdw6dFB3/8T666pCrsD0ZVU91+k/Sqhza8rsC3MPqreqDsfcDLQ17514Jzl88iBQT/dROsUFTGx5idc/6jwBCvhAJqbEey1WD/ZrU/nRUcLpWZTysRANlFGgwgEpZUUyUBjCEN+YrmOzjDTeVJyrsXUj/UONcn0MQJXzHOdyg/kNU/2T1v5wAdCpE3pxbtVJOkVs0Qql4r/GEtjpteCQHC51EAd3dfOv8Vh63NkfJGfW5BVkZT2kYv7clkgbnM9oL+SgPgIyyrOEzrLSzQBAISSlipC6OWj13vCHxL7M6lsPmf+vlg8cKWICEPxqFjPeHM6V7eQy7+uYwkcBgsVJNhDnDwXF1kdFT49c8SsO/FiCapcS0t/op1sq8TeNm6JlK2gikrVwf4FK6Xoaoh99d8AlDe3iHUwWHYZr2KFJ+EOVmi1lFHku13Xbt3MBHVpt1wFRvrqPjojuMazz7OI47fRkmtqSITeCC/a+XU9KGf8aK6go6YtMjXktC3kdKldMRxmQ4eET3drr7gS3lIl4N1nxmQZ7wd/YQvzZxFAXdE+0y5rmhYLM9OF0YV2YrfC0gN3GwI+ys4MoDnZLeeWwkcNWOgFp59SYFQunI/GmacD4bXgrsGIRVqkbTyJkJvWgfGi7g0Y7+/bSa498CEjYd8aeveSHFL0AwvNoNAr7f2VjW60dJEfdNrt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(3023799007)(38070700021)(11063799006)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlRvbUpqUTF2OXExck9hOUxGdXZUOFhHTTh3RnhUM21kOGp0SFNhaVMyWXlQ?=
 =?utf-8?B?LzFVL1Q0VDdrVU9qWWJnKzlEYUFFZmtJckNjbXMrU29MMnZTQTd3QW0vR0Y3?=
 =?utf-8?B?TjlTOTVUR1BmQmhuUnRPZEZnMSsvSVBoRHFvK0Fkb09laEFFUGdhd3dLRnlz?=
 =?utf-8?B?cm1XQzlDWG1JWHo0Zk03Q2tvL25JVEJMdVJwMjB2cXk0MVM0a3RGb2djY2Fl?=
 =?utf-8?B?amI1cnVIMXF5T0NFNENyTThTR0JuYUZZSDhPYi9HMGNFNjF4U0FIZ01lUnNm?=
 =?utf-8?B?WCtoc2ZWWkFzUCtxWElPV3RuUFcvRk1BTHVHNmV3UHUxclVjcmJUclJFUkh6?=
 =?utf-8?B?b0F5RmRkZ0l3SkJ2b3pXRTM1ZkR4akx0OWhlNmNXYzNzeHhMVFBZaE1Xd2hl?=
 =?utf-8?B?ZnJHR3VLSDFCRWF6c29qTWgrZWJWZ1dBdHlhbXlHdW03Z1RvekY2MEV4cWpa?=
 =?utf-8?B?cmIrWm9EZWs4VmlrZy9LSndjdEJjL1REaGc3T2M4bzJ0T3p6cHBYVkhtdmdD?=
 =?utf-8?B?T3RkZW1qRlV5THF0aVdOeVVpK0VpcTF2YU8xQzBERlh5NG9qWG5SYjE2dGxr?=
 =?utf-8?B?WDd0bkJoT1NkdnRCazMrakxQTUh2ZmtzS1BuSkRuUSttb0t4eXMvWUhQVzE3?=
 =?utf-8?B?ZlpLZlpXcWJGTnFjbysvaXl0SjFjbncyLy9oa3NBYThrN2pBT3VZUVJaSnRN?=
 =?utf-8?B?OHB4dW4zRkg5TEJqV2RtanQyNU9rYU40S0xzM2pFNHpJdGtPMkNNU2RoOStw?=
 =?utf-8?B?QU5CNDc4Q3RLVTUwQkViVmtUR09pWEFwbXVvaG1lMkhETitjN3QzM3VEMkpH?=
 =?utf-8?B?enMvRms4RC8yU1FXNWtyVEpnaGlOZTZINGdnZ3ZRK1dEcjgvM1F2YVQyM1Jr?=
 =?utf-8?B?S1dLTlZtOUYvaHhlMDNRbTFQK2haSXExd1pTWkM1SDVuc05XQnJXQ3YwdkVE?=
 =?utf-8?B?OVdxTVV4NGhhM2QzNVFqcFVKU2NJYnFXTEk3LzdwdE0rR0RidGwzTVRwRG9l?=
 =?utf-8?B?TmlITGI4Wi8zMkZleGd6cFIzRk5ueDVDbUUxS210RzJ0dmlSamF6RFhhemdX?=
 =?utf-8?B?VzJmUmExREVrMzRPR0lWelFSTWVlRktFTWhXbTBhb3dNTG13U3BtczFqakgr?=
 =?utf-8?B?eVVxWm45V2ZDc1VIRWJzaStZNmR4VzlhMlFWOFV4UnpaSE00c3MweGU4ODRj?=
 =?utf-8?B?QzZ5NG5hMHRIcUxiOWxQbWxPT09mOFBYWDE2TTlNdi9mR3hzcUlJQ0R2bEE1?=
 =?utf-8?B?UjhYUmM1bzU2QWw4TE1ORHYwaDc5VUY2TlcvR3hTeW5IaitOR0twVjd0RFN6?=
 =?utf-8?B?bmtzMTRjT25EdmM2UDgwNUNtWVc2N3d6NWI4a2F4TUUxUVExTmxUdGZlSXNQ?=
 =?utf-8?B?SGpxZkJ6cy9Pa0FJVDZNdm54eHRrQ0pWK213MnN2YzFEcitUZ2xneTdhZGJs?=
 =?utf-8?B?aSswS1c0dC82Q0RJUDMwTThJNnhVSi84cTYrdFVPRWEwNks0a3JMS0lZeXhh?=
 =?utf-8?B?THlXdkplbVh6aUkrY1UvbVo5UDArOFBWM2hQU1dWbGpkcm9YYUV2aUIrL2Zp?=
 =?utf-8?B?RGxHVHYyS1lYRFFUbk1GSzBuWWJyKzJnMlZuaFo0bVRuYWpDejVDWUt5ekZI?=
 =?utf-8?B?aVJMK1Z6T2k5VFZub3JDYTdxQlNjaEltcGlBeGNveGtUVVFmYjhRT3BHTC9S?=
 =?utf-8?B?UFZWcmh0bE9FeFJaTzhqVlEvb3ZNNVFnNVhwdXhiSlFjQlZ2M3RLaGpFVStY?=
 =?utf-8?B?QytIemdTb2tsSTNiSzhjRDVyeG0yU29CR2RJMDlxL1ZtS2ZJRklpclJJR0lF?=
 =?utf-8?B?YXlIVWdaM1Bva284OVM3V3hiMlVRTGF2V05VQlFvQklkbkxKZXNseERLOHJ3?=
 =?utf-8?B?WC9jNktFTCtBZXVvaU5pd0doanZxTW1TVHIyTzVpRWVFSjR5T2dHb3NYRUVI?=
 =?utf-8?B?ODJCNWI1KzkyZ2NqaDljZDJEb0pOdWRHczBCL1ljT0dwdGtyeUdSem1qanBh?=
 =?utf-8?B?NWY1OXJhMDJCb0FHNDh0eks5L0M2SVhnQlVyaXExUFpuMUUzWEtWTHVQUHM0?=
 =?utf-8?B?WGdUYTJyUlhMbnBrV0p1K2pWbThDV29sU2lIOUNGR0hQU0RBS0dTWFU5bXBq?=
 =?utf-8?B?T1pIQ2loN3dEZUdSTGJSbHBIU3h1ejlFWllPOUtYTVgzOEhqZURFZzVKSTBw?=
 =?utf-8?B?akVPVFJyZVRGVE5ZVWZpMGZUY3ZPQ0daTXdubHdnb1RWU0ZDSjRIcDR4QWZq?=
 =?utf-8?B?YjI4NEtxVVB6d3FVL1RqWnQ0bFEwSDgrRm1VZ2k3cjZFSHJKUVFZdW1HS3NY?=
 =?utf-8?B?eTNKVzllN2ZpZTJVT1FsYVdWYVgxd3M2OWtMTXp2dzRsNlhPK0w0b1l4MmZx?=
 =?utf-8?Q?h+SxrvejE46GR3iUuPpd8ObdYd1FT5KQxuvND?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A308C3E800C644BB87F590CD908304A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	JYzuy5QCCsW0BK6SJKdBdoCWmfCQ32q0N1gety+CdvygUrtnjUJFJ55aJvJkzcPpmjPg9sPuTghXqdHuf0i8IDb5jBU3zp3TKF95jRa3RfqICFLNxQs6Dv9AlhXLWRqpZ7Mv17gKVpbzQ3wIeQIpA7FcLl1WcnMAZwIEuTD7NCCLoXoHaSLW405XqJsGjotTMvuH8OvJs1ZNqCELxn//vgjht599Wt2S9qTehoh1sPC2yzrAhKs5piSACqM1/UETHW3z6AldhCcQSGoEuXJTH5a87PCucRs8OjTRqmgATEAJr2Teb7D30YWOlK5Mlc0EogcBzgm4TVW9GK1c8mCA1g==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c896cca4-971e-4271-c6b6-08deb5da2087
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 19:09:18.5993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QDAhEVJ8vGzZPkiHRZxecSTx/I36AbB3Pw1eZ0OHAKJ4HrLxbvLEwRrj9gTXwhtkkWa2Rh/B5tVMUp/VhCx38Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4591
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE5MSBTYWx0ZWRfX0WXl//YSpoLM
 lwopFlmmSxTzSG6mFgh5zhLV1kq7dF+x28J22bj+VQFGMX8FTQ0p0pZBT7pwHT47MUCTzqA3FVn
 0jrX38CMxFUxW/npU20AfwwqGnn22XYSnmedXMS1m6QG+qaYT9LKbBQfzXymCi2MHRvf3rsoFoB
 RN52dFQzYs+bWPKLNHPWblSayL8qUKmx6i6cAKfYpnX/ldYpRRcjxPSe5hCUczGfaLvJ2awqQsc
 61ipunSpp+tBFkievxThrJPCXmZizh1llljRSt7qZCj84NtYes6tVDzbiupJ3DC19ahIDukuO2e
 SQIEOZNcaAVjfYYW0d+wwDIu+WfSsphyf2UYv+dKkB7eRYo8wVXHE1/Q0Yfg/E1o4PhP7BwQenf
 70HT+a+e+DkKsrwwy6vj6kAwxfDjb3jC3R9KSY3Rlku7NYKY/JxCifd5LcKjyClSguYSFiBY+1S
 G7XP2dGbIhnu4Ja1lAw==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0cb568 cx=c_pps
 a=pqTWcw9xC4/AVWcamW/T+Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VOS-Z3Iv6m_viXl2wO8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: y1O13g0-kQ-pikaDeFxFs_pcLBQSKYqG
X-Proofpoint-GUID: wkakZrjkEVWl1wnF8TMvlxdoM7vMfuSG
Subject: Re:  [PATCH v3] libceph: Fix multiplication overflow in
 __decode_pg_upmap_items()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190191

T24gVHVlLCAyMDI2LTA1LTE5IGF0IDEzOjAxICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gQSBtZXNzYWdlIG9mIHR5cGUgQ0VQSF9NU0dfT1NEX01BUCBob2xkcyBhbiBPU0QgbWFwLCB3
aGljaCB0eXBpY2FsbHkNCj4gY29udGFpbnMgYSBwZ191cG1hcCBwYXJ0IGF0IGl0cyBlbmQuIFdo
ZW4gZGVjb2RpbmcgdGhpcyBwYXJ0IGluDQo+IF9fZGVjb2RlX3BnX3VwbWFwX2l0ZW1zKCksIGEg
bGVuIHZhbHVlIGlzIGRlY29kZWQgZnJvbSB0aGUgbWVzc2FnZSB0bw0KPiBkZXRlcm1pbmUgdGhl
IG51bWJlciBvZiBpdGVtcyBhbmQgdGhlIHNpemUgb2YgdGhlIGFsbG9jYXRpb24gbmVlZGVkIGZv
cg0KPiB0aGVtLiBJZiB0aGUgbGVuIHZhbHVlIGlzIGdyZWF0ZXIgdGhhbiBvciBlcXVhbCB0byAy
XjMxLCBhbiBvdmVyZmxvdw0KDQpJIHN0aWxsIHRoaW5rIHRoYXQgdGhlIHBocmFzZSAiSWYgdGhl
IGxlbiB2YWx1ZSBpcyBncmVhdGVyIHRoYW4gb3IgZXF1YWwgdG8NCjJeMzEiIGlzIGNvbmZ1c2lu
ZyBhbmQgaXQgcmVxdWlyZXMgb2YgcmUtcGhyYXNpbmcuIFByb2JhYmx5LCBpdCB3aWxsIGJlIGNs
ZWFyIHRvDQpzYXkgInRvdGFsIGxlbmd0aCB2YWx1ZSIuIEJlY2F1c2UsIGxlbiBpcyB2YXJpYWJs
ZSBvZiB1MzIgZGF0YSB0eXBlIGFuZCBpdA0KY2Fubm90IGhvbGQgb3IgcmVjZWl2ZSBhIHZhbHVl
IGJpZ2dlciB0aGFuIDJeMzEuIEJ1dCBpdCBpcyBub3QgdGhlIHNob3cgc3RvcHBlcg0KZm9yIHRo
ZSBwYXRjaC4NCg0KPiBvY2N1cnMgaW4gdGhlIG11bHRpcGxpY2F0aW9uIHRoYXQgaXMgcGVyZm9y
bWVkIHRvIGRldGVybWluZSB0aGUgbmVlZGVkDQo+IHNpemUgb2YgdGhlIGluY29taW5nIGJ1ZmZl
ciB0byBkZWNvZGUsIGFzIHdlbGwgYXMgZm9yIHRoZSBsZW5ndGggb2YgdGhlDQo+IGFsbG9jYXRp
b24gZm9yIHRoZSBjZXBoX3BnX21hcHBpbmcgc3RydWN0LiBTdWJzZXF1ZW50bHksIHRoaXMgcmVz
dWx0cyBpbg0KPiBvdXQtb2YtYm91bmRzIHdyaXRlcyAoYW5kIHJlYWRzKSB3aGVuIGRlY29kaW5n
IHRoZSBpbmNvbWluZyBtZXNzYWdlDQo+IGZpZWxkcyBpbnRvIHRoZSBjZXBoX3BnX21hcHBpbmcg
c3RydWN0Lg0KPiANCj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUgYnkgc3BsaXR0aW5nIHRo
ZSBjb21wdXRhdGlvbiBpbnRvIG11bHRpcGxlDQo+IHBhcnRzIGFuZCBzdG9yaW5nIHRoZSByZXN1
bHRzIGluIGxvY2FsIHZhcmlhYmxlcyBvZiB0eXBlIHNpemVfdC4gVGhpcw0KPiBwcmV2ZW50cyB0
aGUgb3ZlcmZsb3cgYnkgcGVyZm9ybWluZyB0aGUgbXVsdGlwbGljYXRpb24gaW4gdGhlDQo+IGFw
cHJvcHJpYXRlIGRhdGEgdHlwZSBhbmQgZW5zdXJlcyB0aGF0IHRoZSByZXN1bHQgaXMgY2FsY3Vs
YXRlZCBvbmx5DQo+IG9uY2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYXBoYWVsIFppbW1lciA8
cmFwaGFlbC56aW1tZXJAdHUtaWxtZW5hdS5kZT4NCj4gLS0tDQo+ICBuZXQvY2VwaC9vc2RtYXAu
YyB8IDkgKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL29zZG1hcC5jIGIvbmV0L2Nl
cGgvb3NkbWFwLmMNCj4gaW5kZXggOGI1YjA1ODdhMGNmLi4wNzY3NjM0MjBiMWQgMTAwNjQ0DQo+
IC0tLSBhL25ldC9jZXBoL29zZG1hcC5jDQo+ICsrKyBiL25ldC9jZXBoL29zZG1hcC5jDQo+IEBA
IC0xNjE1LDEzICsxNjE1LDE2IEBAIHN0YXRpYyBzdHJ1Y3QgY2VwaF9wZ19tYXBwaW5nICpfX2Rl
Y29kZV9wZ191cG1hcF9pdGVtcyh2b2lkICoqcCwgdm9pZCAqZW5kLA0KPiAgew0KPiAgCXN0cnVj
dCBjZXBoX3BnX21hcHBpbmcgKnBnOw0KPiAgCXUzMiBsZW4sIGk7DQo+ICsJY29uc3Qgc2l6ZV90
IGl0ZW1fc2l6ZSA9IDIgKiBzaXplb2YodTMyKTsNCj4gKwlzaXplX3QgcGF5bG9hZF9sZW47DQo+
ICANCj4gIAljZXBoX2RlY29kZV8zMl9zYWZlKHAsIGVuZCwgbGVuLCBlX2ludmFsKTsNCj4gLQlp
ZiAoKHNpemVfdClsZW4gPiAoU0laRV9NQVggLSBzaXplb2YoKnBnKSkgLyAoMiAqIHNpemVvZih1
MzIpKSkNCj4gKwlpZiAoKHNpemVfdClsZW4gPiAoU0laRV9NQVggLSBzaXplb2YoKnBnKSkgLyBp
dGVtX3NpemUpDQo+ICAJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOw0KPiAgDQo+IC0JY2VwaF9k
ZWNvZGVfbmVlZChwLCBlbmQsIDIgKiBsZW4gKiBzaXplb2YodTMyKSwgZV9pbnZhbCk7DQo+IC0J
cGcgPSBhbGxvY19wZ19tYXBwaW5nKDIgKiBsZW4gKiBzaXplb2YodTMyKSk7DQo+ICsJcGF5bG9h
ZF9sZW4gPSBsZW4gKiBpdGVtX3NpemU7DQo+ICsJY2VwaF9kZWNvZGVfbmVlZChwLCBlbmQsIHBh
eWxvYWRfbGVuLCBlX2ludmFsKTsNCj4gKwlwZyA9IGFsbG9jX3BnX21hcHBpbmcocGF5bG9hZF9s
ZW4pOw0KPiAgCWlmICghcGcpDQo+ICAJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiAgDQoN
Ckxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1
YmV5a29AaWJtLmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=
