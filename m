Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288AD4963C2
	for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870465; cv=fail; b=jXPqETn7R0KKze19VauQz3fFaUijPC0vQNVx/ruEKb1LSTt4VkswgH7P4cZzGg8COAN9cXtOs3cbXX3qXgnq11/gpVQ1Z1LZG2Qu5+Tqz9w48Giy9gXP4JX3c+enyzgsT6CqIrSOYwFHCJL2BSgv0hCfpSDNUcuR2wZGbJD9l8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870465; c=relaxed/simple;
	bh=P0Co5Gv9hHZCjyu5/uELxI7r1CIQaYIl+0Bz4fcOfVk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=S1d+Ndwjp/77d6qL/QiGfYv1VORUal2joMR5jJ4XFd+g9+h3unNN2RBbWEfiHZjMePEbTywimFit0AG7S0ZjCOtqtXOKGYRS2gq5nvoGOI4NHk9fE9tPU6h4XOjkmU2dtDotYE74oya8qnTGIzfMiQjSEV2Daxz2NfAENvQOgMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gR9z/uPh; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gR9z/uPh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAmVQN4193839;
	Fri, 15 May 2026 18:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=P0Co5Gv9hHZCjyu5/uELxI7r1CIQaYIl+0Bz4fcOfVk=; b=gR9z/uPh
	asfYr1oLrJlFFBL/3xcDdfEjH7yVFi0A5+fadzQwyPSirUwFCvpEhBNq5fzFFwCd
	mLNjFc714+SVruw6vE/DIdjR763lqeSwSWZtcb2mgA12guOvlnpXF9cgzyDFsYnh
	abNJXOSsZRTayPucRQ1+ozf2CyvShBwGYgYWjaAiUTWS7uJEkEhlMJB1gjcwRR7d
	oQtOqbUgFSo8h7pWiYELDc3BMwj+PBInu+hzv/Y5kyLRCAIGnaWll1uIE66uoJ2S
	cKn50EQbaLyBiC7tqOvrLJVaGmurqVewualzOreCd130gkiF4rQpyVieWW66K+/a
	4TMU/rToZuZdmQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m8y4hp0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 18:40:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DharOZj0Dsm2O7X33RXcHNOREL6K1h/u0//09UM3QGfm1myBcOfTyyIwogJAVxsYM4KLqtJ/pt9bGrE1j5iASDx1eIbLiNkEhYK2mByNwHRdWkFl+dm/ku1noSW38gywrQWDksDz009Mao4PUrnWz25jp1pxSkGMKD1H2Llo1FEKuubYNk3uMry9T+d2DPpmWrmZdZAU7XOisXvYl0tAtzIHblN/5DI2xaHTez61UPNvnirI3NYi3a2eOzBtM6EwXSDrD0RVGbChYh4/Schn5LGg2U+QFg5RoBGCz3IMrxB78jlio85tS+5N5EF8QKfJWatXKBBVlov+3PdVtkK4bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0Co5Gv9hHZCjyu5/uELxI7r1CIQaYIl+0Bz4fcOfVk=;
 b=DCeubeaXX7mEgLBeoNLRRKWhGiZGEfOXfexzztJgzYcZZ0RkpNown0FXB0NzQGK0kcsegQ5TvZz5qUjvGrQnugXMMq3C0Pa1BZBh/E47kdDiwRJilnTW23dt1VkmuZoTG02QYma/5b837W2B5heqIrpR3adpNgUwI9YmExgj0DE6E/OHM69625bfurtmoeMBYgDfMYNLor/WWSG5P/8dWjkkDdpIErp07teJmKAJLCZof7ZvbdBAY1GVQUs+/utFPQdYPjckfpPd0XAuRNPdttUeGkJc0zC9oeIp1e2c63ywwi7NmjeNzEwMqAlnghcGFnCy+mJoScRS54k9H9uuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB6784.namprd15.prod.outlook.com (2603:10b6:8:30e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 18:40:38 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9913.012; Fri, 15 May 2026
 18:40:37 +0000
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
Thread-Index: AQHc4vg8Ve6O8/vscUqb4WL7fZIaFLYMMweAgAKDbQCAALg+AA==
Date: Fri, 15 May 2026 18:40:37 +0000
Message-ID: <8dd7c71c869474c680a29e196f33e911e1f93b46.camel@ibm.com>
References: <8edcef9c-0b7c-46dc-8094-dc55b62567d3@tu-ilmenau.de>
	 <20260513081425.1477060-1-raphael.zimmer@tu-ilmenau.de>
	 <a9e24eba42be211967a5342550561250c5894dea.camel@dubeyko.com>
	 <e510a0d0152cda8fc1662d55e4903d3caa290a39.camel@ibm.com>
	 <063a77e2-d189-4eb9-92a2-0355e6b7dc0d@tu-ilmenau.de>
In-Reply-To: <063a77e2-d189-4eb9-92a2-0355e6b7dc0d@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB6784:EE_
x-ms-office365-filtering-correlation-id: 39f625e7-adf0-4295-08f3-08deb2b17515
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|56012099003|18002099003|22082099003|3023799003|4143699003|38070700021|11063799003;
x-microsoft-antispam-message-info:
 ZJ/ChzHMe61Pxb6TTGdc8/Ig1lVDCJI2Vb3Y2eww1znqqYmq5Ki51lk36Dchl6eGxbJT1PNa4UsrjOOxjSH5ZsQjF6GrTb/e7waJKpqZ1wGQ9nReS2x0Ae3CrvdWQXc+SAaLqUVpb5forPJJ66l7/iRdaPgrhcHLVaypmYaQWpjcJqvkScTnDs27Xq9h234ON9wLQWZrrir7vHit4D732ybYGzj7Zi861gFjQ94e9APAqw9zyf8V915EnZSoyGIDvIVUPyBOB0i/jFyz6o7x9iTO3chqOYGPC6mIClj/v+RlHFNkMXoNVOApTfgug8gMuRTPe4tSFrJ4EMAGS0ZcFkIorax/yfb8wWKvOXI4cdzAP7nMhQfRRrsGaNLLiUujfDCU3P/Nd7F0NfXRCHVcD0U9hFtnku0y4b8HP2QAANbo/YPyCz85lQX8XeRI1bHaRvjBwNAdztbLe0jvu0lXK+sluUgG9dqoEEWtdO9vlR7k8dKQ8JrPTmaJZPgDE65HKO6sueZFHhPsUQy4WEKEB4I+6P5Lu8i5Z7GbZOIlTNTW9DPMh74EhrpnRKC6FQDJYNgKIHsQ1uLUN39oeWBqF3QDpDARzWH4VbPRQ9RarmYPqwZMH5U8bMlS586LuY4e3PJksmJ7+lbpH54h9gE0aOOz6iqTG+HuulO/9GoQpUZYTFYbKLS5N+P+CRnXD58jfMw7jRWXko/OccoMykGA6A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(56012099003)(18002099003)(22082099003)(3023799003)(4143699003)(38070700021)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUlBWG1iRnV2LytzV2RyWWRVblZ0cVhucm13OE5xTjVKTWlIc0ZYeHNBWHAy?=
 =?utf-8?B?QUZ2QnhTaTFIQndyaUNhbEZyRXN5NmZ0VDc2LzVtWXNoekhRV2pqYlNXSXZs?=
 =?utf-8?B?RXRQWUhwUWUrRUhrdk1qaEFVYmkyS3lhWndIeW9DZzQ2SkpMVUx2dVVHei85?=
 =?utf-8?B?VzRLVEVuTC9OOTgwQTdSZ0pBeW11N1phNVdmOHJrQ3lhQTVxTU5RZ2p1ZVky?=
 =?utf-8?B?ZnRWaFNzNEhKdE5PZmdFTW5zbjdZUThmVWRsQzBYbmd2UXMwL1l0NUE3M0Zj?=
 =?utf-8?B?TjF0dkJMRFJ0YjhtZmMra1NPcmk3U3AxVjBYeGs4OWR6L3M4cHRESmMvOVZG?=
 =?utf-8?B?NFNtTkdCOG8xR05zY3hWZkhWM3JtOE9ZRVRsQzd5czk4dWc4eXFMSXdVcTZB?=
 =?utf-8?B?YjgxM3VxZGxVOVFIWjVRNmczT09FcndyKy92RE1NUUdQaVlPTmRRR1ZPRW5a?=
 =?utf-8?B?SEwraFlKQXhTN09sZ3B3aWNwNDA2MjkzaFg1SlkwWDFIbUhKSmYvZ0xiMFpG?=
 =?utf-8?B?cERnRG9ESzlnY3YxdHBaR1lLUlJMYnVvNjg3MVRjRjhINjhZSkY4VHRhSWRE?=
 =?utf-8?B?emM2UlV0UWlUazZVN1NyMkcvWWVhMkkvZUl0Zy9BRWZRTy9laWtwd0FWZVY4?=
 =?utf-8?B?N2I2VTRGYUN6QmN4N0R3TjhHYnJQeGJHU0ZyYXlUM3dOdXBQS0d2d3M4eXFv?=
 =?utf-8?B?QnBwdEIyZ2E5WUJoM256cDd2Q0EzMVFIYjN4M1FwQlk4TzJoVStUSFJzR3VY?=
 =?utf-8?B?dElnZUpwUWRwaS9GT0ExbXFVSnZNS1UrbUx1WXZIUXR3aGFqbCtaTGs5Y2s1?=
 =?utf-8?B?RmRWUkhWTERFR05WR2hiS0R0MnBwWnBIaVQwMnFJVjA4K0grTllpRVNaR3FW?=
 =?utf-8?B?aGFvOGgzVGVMV3FsN0FEYTZIY0JvamM2ajlaejM1aFRnQlEvdXM0ck8zbXBE?=
 =?utf-8?B?R0FOWVpad0l1WDFQQXhWbGpCOForb2laK0VhSG40TDgvUVRiTTBqRXNXRDI0?=
 =?utf-8?B?VEhsZzBTU085ZExtYUdPMWgzMHVDVVNqRitMQVpiVkRaQ1dsOUxzY3lIYm5I?=
 =?utf-8?B?RTA4K3dSSUpmSnNNcGNqZDdhcHRCbzlCekhUSkVqOG1NbXg3Z2Y0TTZZOXV5?=
 =?utf-8?B?S3Q4RmpaVGg5NndIVWlZaHRIRStiRVIrVHR4YkNyd2VvZHJuK1BqbHJaMWl4?=
 =?utf-8?B?UU9TMEhzRjRoTGYyd3FhVDZ4MkhmQlNwTWFBTDJtUHkzZTdwTzNXKzlRSTZy?=
 =?utf-8?B?cnBsQ0VwVkYrV0lKYlFhTDJaSG5qWDdNR1MyN0w2dlgrNDU5UisyL295WnV4?=
 =?utf-8?B?cmxjMW5BbHkxTlEzMUYyNFphdU9TWHQ1THd3dFVnZnpkNlR2a1EwcWxXM25H?=
 =?utf-8?B?d2g5RGNMZlJpVDJEUG01aGs3OGYzb09kN3ltNzQvcnJFR1FGdlBwSHpHZDVW?=
 =?utf-8?B?dlJheXBPQjdkcHp2cHZWK0dQcHpxSlNkbEh4Yi9zd2lJTzNBSjhjdUNjNE5s?=
 =?utf-8?B?SU1IMk5sSmt3WDBKY0VITGRuMmhSVFBMVWVmZ3ZTZVo1VkVKNm95eExHOFl2?=
 =?utf-8?B?bnV2Tk1IVTJTK0FoVklFYWlGWld1d0VpbFFpcnJsNzNZTVhNT1lSbDFob29u?=
 =?utf-8?B?N3V1WXQxeGF0NTd0NTJXamlDSWo1SVZFRnNPdFJRSklRdFoxbHovd1ZrK0JY?=
 =?utf-8?B?TFl3ZDl5SFBDQXgvN2xEWE95bVFsbkk2WFFiL3VmUzkxS1RLY1NZQk9YbmUw?=
 =?utf-8?B?UkN2V0s0OWVhY2NzeTdFWW9TR1dIK2ZwakRCQW1Nb2dka3NrcmtxbEVlaFIz?=
 =?utf-8?B?YUNOUEZCN011VnBqTVE4aTkrWkFENkExc1NaTkJUV1pqMHlBMEZlZ1pmUita?=
 =?utf-8?B?NERUdm9uS2VUeXJWNjd4dFBOVHJMYjBNWkJUcjdRUkplZEIvWDRUZnpzMDBr?=
 =?utf-8?B?eTlCL0JqYzlVNTVzVkZ4T0FST1BhM1h4azNndksrMWdhSUVYMlAra21JdUd5?=
 =?utf-8?B?QVpGdGtkWk1MMExaUUE2aXRWRWVDM1BGYUhFZ1EwellxMFJtTnZqTFAyVlBX?=
 =?utf-8?B?Y1ViMHdMTnMrbFRaakhHb3NSbUVzU05ZdndMcHpWdnRHSDJEaERnVFAydWsr?=
 =?utf-8?B?QnZaNk0rZmkrdlpBVGU0RHJOVmtYVjltVldYaTZ2OGpBY2dNdUQzZ0ZRS3RG?=
 =?utf-8?B?Wk9zN2dzUzRJRHd3Y0JlZTZCTzZab3NkMFlXVmpUTERjQjZKUHVmUXlSbWFN?=
 =?utf-8?B?SGt4U0lyODU3ZEdVc0pZTE90ZjVjMTBkaVg4TXFJaXBwUWVRV1E3QUZtNlMw?=
 =?utf-8?B?eEhNNzVybG1tenpmL1V1VUk3Y0JpZ29rd0loaXNteGFhL3hMelpGbUNNaENw?=
 =?utf-8?Q?/ElFzAVdZz6objKpJzmVVTb2nFsHaw6Ku3Dmb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBA67B4A590A9E48BD177C1F7B052056@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	S1IulX5F/marPfnnFvZmDOrPiztclJFzKsL8FVDqr4QUR66acRXsnCoYGnVoRfq6ElOzpGuyVJfmN3+9lerB7nNVxIP5rCjBa251wtxBOfZovsK/XGnENNXem5A8jmWgyP/MX76bi4Pwy7sdJ4g2uzWJqPYEZI4xg0Pzjq5uVeRNPG4DamiOebiaCxVWZPxwl9Zm4EZDlt7bytxEzJnOzzFYLnDK6TxE92u59TwdsEEGqXYsbnjxQOG+4WGlghZD/6BRMNpMyNiIASgf5VhgNpCAK16m4j1aCcRv6I5UI9in7J3XK8zVi/20EdsuD0DwwKzzFgRcmcBKbdrPj63BHw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f625e7-adf0-4295-08f3-08deb2b17515
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 18:40:37.6226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtyJMh1r/lrNnUpadPknCYluUVHV363BjvIRGLuLxBsgxiezz5NYd/uIHBeo4Yb7uFWK3ap1ERSFltEO1RMSpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6784
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: kUi_c9wmPxFzN96L2WgKvqArE65fGXnL
X-Authority-Analysis: v=2.4 cv=RemgzVtv c=1 sm=1 tr=0 ts=6a0768a9 cx=c_pps
 a=f30+ahQCdjj2/zPB7vFTLg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8
 a=JupPm82s7jL0NwkiXeIA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: mC6fxoCdjlOlLf7QBKNH_DA9qOTZ3T8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE4OSBTYWx0ZWRfX3exsfldoz4r/
 OyYToLC4kZmSVzlRyL5sZD7xR0YXtBaPGXw2hoZhYr43ldXnN+M4PD7rePARb3K8nnUOMYDSLo0
 095/u1RPZgu2IUWKUL52cXV8b+IhuSnoJR3OnUMzQscnPqjMf9fDhrVAhfeFZFmFzoTcfhTejX5
 vTPfuwApUS8OLYBBd6CaSGLjDSE5Z4fQTzHItShw0PMM7qI7fT618BzLhmlu377m02n8NbXi05j
 mZcN1irh+kO4ylpMULrW7pwwb+whGXTHDBbZXgYeCUZYNNG2l4RdJarp+/N6CS5m8UF2lLRC1Ub
 0wrJXBeRa3wDG0rwdgtsVckLYt3FQhASgF0pmUTiR9XX7C9owMCtaq+2NG42DuDzEnbDLFyzamC
 /kEO8Zai0xQi5yEYBnWe+M34bntKBpxat1yDldKCwZzM5KcWyjHRnNualeTDQ7q+ogltPIpAMdX
 3PUZGAVUzg7ipUBCWAA==
Subject: RE: [PATCH] libceph: Fix multiplication overflow in
 __decode_pg_upmap_items()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150189

T24gRnJpLCAyMDI2LTA1LTE1IGF0IDA5OjQxICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gT24gMTMuMDUuMjYgNzoxOCBQTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+IE9u
IFdlZCwgMjAyNi0wNS0xMyBhdCAwOTo0MCAtMDcwMCwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3Rl
Og0KPiA+ID4gY2M6IGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiANCj4gPiA+IE9u
IFdlZCwgMjAyNi0wNS0xMyBhdCAxMDoxNCArMDIwMCwgUmFwaGFlbCBaaW1tZXIgd3JvdGU6DQo+
ID4gPiA+IEEgbWVzc2FnZSBvZiB0eXBlIENFUEhfTVNHX09TRF9NQVAgaG9sZHMgYW4gT1NEIG1h
cCwgd2hpY2ggdHlwaWNhbGx5DQo+ID4gPiA+IGNvbnRhaW5zIGEgcGdfdXBtYXAgcGFydCBhdCBp
dHMgZW5kLiBXaGVuIGRlY29kaW5nIHRoaXMgcGFydCBpbg0KPiA+ID4gPiBfX2RlY29kZV9wZ191
cG1hcF9pdGVtcygpLCBhIGxlbiB2YWx1ZSBpcyBkZWNvZGVkIGZyb20gdGhlIG1lc3NhZ2UgdG8N
Cj4gPiA+ID4gZGV0ZXJtaW5lIHRoZSBudW1iZXIgb2YgaXRlbXMgYW5kIHRoZSBzaXplIG9mIHRo
ZSBhbGxvY2F0aW9uIG5lZWRlZA0KPiA+ID4gPiBmb3INCj4gPiA+ID4gdGhlbS4gSWYgdGhlIGxl
biB2YWx1ZSBpcyBncmVhdGVyIHRoYW4gb3IgZXF1YWwgdG8gMl4zMSwgYW4gb3ZlcmZsb3cNCj4g
PiA+ID4gb2NjdXJzIGluIHRoZSBtdWx0aXBsaWNhdGlvbiB0aGF0IGlzIHBlcmZvcm1lZCB0byBk
ZXRlcm1pbmUgdGhlDQo+ID4gPiA+IG5lZWRlZA0KPiA+ID4gPiBzaXplIG9mIHRoZSBpbmNvbWlu
ZyBidWZmZXIgdG8gZGVjb2RlLCBhcyB3ZWxsIGFzIGZvciB0aGUgbGVuZ3RoIG9mDQo+ID4gPiA+
IHRoZQ0KPiA+ID4gPiBhbGxvY2F0aW9uIGZvciB0aGUgY2VwaF9wZ19tYXBwaW5nIHN0cnVjdC4g
U3Vic2VxdWVudGx5LCB0aGlzIHJlc3VsdHMNCj4gPiA+ID4gaW4NCj4gPiA+ID4gb3V0LW9mLWJv
dW5kcyB3cml0ZXMgKGFuZCByZWFkcykgd2hlbiBkZWNvZGluZyB0aGUgaW5jb21pbmcgbWVzc2Fn
ZQ0KPiA+ID4gPiBmaWVsZHMgaW50byB0aGUgY2VwaF9wZ19tYXBwaW5nIHN0cnVjdC4NCj4gPiA+
ID4gDQo+ID4gPiA+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGlzc3VlIGJ5IGFkZGluZyBhIFVMIHN1
ZmZpeCB0byB0aGUgbGl0ZXJhbCBpbg0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gbXVsdGlwbGljYXRp
b24gdG8gcGVyZm9ybSBpdCBhcyBhbiB1bnNpZ25lZCBsb25nIG11bHRpcGxpY2F0aW9uLg0KPiA+
ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUmFwaGFlbCBaaW1tZXIgPHJhcGhhZWwuemlt
bWVyQHR1LWlsbWVuYXUuZGU+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoG5ldC9jZXBoL29zZG1h
cC5jIHwgNCArKy0tDQo+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9v
c2RtYXAuYyBiL25ldC9jZXBoL29zZG1hcC5jDQo+ID4gPiA+IGluZGV4IDhiNWIwNTg3YTBjZi4u
NDJiN2I1MzAwOTAxIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9uZXQvY2VwaC9vc2RtYXAuYw0KPiA+
ID4gPiArKysgYi9uZXQvY2VwaC9vc2RtYXAuYw0KPiA+ID4gPiBAQCAtMTYyMCw4ICsxNjIwLDgg
QEAgc3RhdGljIHN0cnVjdCBjZXBoX3BnX21hcHBpbmcNCj4gPiA+ID4gKl9fZGVjb2RlX3BnX3Vw
bWFwX2l0ZW1zKHZvaWQgKipwLCB2b2lkICplbmQsDQo+ID4gPiA+IMKgCWlmICgoc2l6ZV90KWxl
biA+IChTSVpFX01BWCAtIHNpemVvZigqcGcpKSAvICgyICoNCj4gPiA+ID4gc2l6ZW9mKHUzMikp
KQ0KPiA+ID4gPiDCoAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ID4gPiA+IMKgDQo+ID4g
PiA+IC0JY2VwaF9kZWNvZGVfbmVlZChwLCBlbmQsIDIgKiBsZW4gKiBzaXplb2YodTMyKSwgZV9p
bnZhbCk7DQo+ID4gDQo+ID4gV2UgdXNlIHRoZSBwYXR0ZXJuIDIgKiBzaXplb2YodTMyKSB0aHJl
ZSB0aW1lcyBpbiB0aGUgZnVuY3Rpb24uIEkgY2FuIHN1Z2dlc3QgdG8NCj4gPiBpbnRyb2R1Y2Ug
YSBsb2NhbCB2YXJpYWJsZSB0aGF0IHdpbGwga2VlcCB0aGlzIHZhbHVlLg0KPiA+IA0KPiA+ID4g
PiAtCXBnID0gYWxsb2NfcGdfbWFwcGluZygyICogbGVuICogc2l6ZW9mKHUzMikpOw0KPiA+IA0K
PiA+IEkgdGhpbmsgaXQgZG9lc24ndCBtYWtlIHNlbnNlIHRvIGV4ZWN1dGUgdGhlIHNhbWUgY2Fs
Y3VsYXRpb24gdHdvIHRpbWVzLiBPZg0KPiA+IGNvdXJzZSwgY29tcGlsZXIgY2FuIGRvIHNvbWUg
b3B0aW1pemF0aW9ucy4gQnV0IEkgc3VnZ2VzdCB0byBpbnRyb2R1Y2UgYSBsb2NhbA0KPiA+IHZh
cmlhYmxlIHRoYXQgd2lsbCBjb250YWluIHRoZSBmaW5hbCBjYWxjdWxhdGlvbiBvZiAyVUwgKiBs
ZW4gKiBzaXplb2YodTMyKSBhbmQNCj4gPiBpdCB3aWxsIGJlIHVzZWQgaW4gYm90aCBjYXNlcy4N
Cj4gPiANCj4gDQo+IEhpIFNsYXZhLA0KPiBJIHdpbGwgcmV3b3JrIHRoaXMuDQo+IA0KPiA+ID4g
PiArCWNlcGhfZGVjb2RlX25lZWQocCwgZW5kLCAyVUwgKiBsZW4gKiBzaXplb2YodTMyKSwgZV9p
bnZhbCk7DQo+ID4gPiA+ICsJcGcgPSBhbGxvY19wZ19tYXBwaW5nKDJVTCAqIGxlbiAqIHNpemVv
Zih1MzIpKTsNCj4gPiA+ID4gwqAJaWYgKCFwZykNCj4gPiA+ID4gwqAJCXJldHVybiBFUlJfUFRS
KC1FTk9NRU0pOw0KPiA+ID4gPiDCoA0KPiA+IA0KPiA+IEJ5IHRoZSB3YXksIHRoaXMgY2hlY2s6
DQo+ID4gDQo+ID4gCWlmICgoc2l6ZV90KWxlbiA+IChTSVpFX01BWCAtIHNpemVvZigqcGcpKSAv
ICgyICogc2l6ZW9mKHUzMikpKQ0KPiA+IAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ID4g
DQo+ID4gd2lsbCB3b3JrICBhIHdyb25nIHdheSBmb3IgdGhlIGNhc2Ugb2YgaWYgdGhlIGxlbiB2
YWx1ZSBpcyBncmVhdGVyIHRoYW4gb3IgZXF1YWwNCj4gPiB0byAyXjMxLg0KPiA+IA0KPiANCj4g
V2hhdCBkbyB5b3UgbWVhbiBieSAid2lsbCB3b3JrIGEgd3Jvbmcgd2F5Ij8gSSBkb24ndCBzZWUg
YW55IGlzc3VlIHdpdGgNCj4gaXQgb3IgZGlmZmVyZW50IGJlaGF2aW9yIGluIGNhc2Ugb2YgbGVu
ID49IDJeMzEuDQo+IA0KPiANCg0KSSB0aGluayB0aGUgbWFpbiBjb25mdXNpbmcgcG9pbnQgd2Fz
IHRoaXMgcGhyYXNlIGZyb20gdGhlIGNvbW1pdCBtZXNzYWdlICJJZiB0aGUNCmxlbiB2YWx1ZSBp
cyBncmVhdGVyIHRoYW4gb3IgZXF1YWwgdG8gMl4zMSIuIEJ1dCwgYXMgZmFyIGFzIEkgY2FuIHNl
ZSwgd2UgaGF2ZQ0KZGVjbGFyYXRpb24gWzFdOg0KDQp1MzIgbGVuLCBpOw0KDQpUaGVuLCBob3cg
dGhlIGxlbiBjYW4gaGF2ZSB2YWx1ZSAiZ3JlYXRlciB0aGFuIDJeMzEiPyA6KSBJIGFzc3VtZSB0
aGF0IHlvdSBtZWFuDQp0aGUgY2FsY3VsYXRpb24gb2YgMiAqIGxlbiAqIHNpemVvZih1MzIpIGNh
biBiZSBncmVhdGVyIHRoYW4gMl4zMS4NCg0KQnV0LCBtYXliZSwgd2UgbmVlZCB0byBoYXZlIHRo
aXMgZGVjbGFyYXRpb24gaW5zdGVhZDoNCg0Kc2l6ZV90IGxlbiwgaTsNCg0KSW4gc3VjaCBjYXNl
LCB3ZSBkb24ndCBuZWVkIGluIHRoZSBjYXNlIChzaXplX3QpbGVuIGhlcmU6DQoNCmlmICgoc2l6
ZV90KWxlbiA+IChTSVpFX01BWCAtIHNpemVvZigqcGcpKSAvICgyICogc2l6ZW9mKHUzMikpKQ0K
DQpXaGF0IGRvIHlvdSB0aGluaz8NCg0KVGhhbmtzLA0KU2xhdmEuIA0KDQpbMV0gaHR0cHM6Ly9l
bGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjcuMS1yYzMvc291cmNlL25ldC9jZXBoL29zZG1hcC5j
I0wxNjEwDQo=
