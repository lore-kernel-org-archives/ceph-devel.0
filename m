Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8633DD536;
	Fri, 13 Mar 2026 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426540; cv=fail; b=IAJrE74vtHbwWaAlbgWf5J+o2L4rFXmL94Pq4b2C2W/M6DtZiu/rYe4G2K1I5hvZwY2Ya5eBaOsW34Xjexs1Rzjo/k+vydUk9vmXNizHkNxeIPes8zhyB9EOljYwPNnnTw7xuem8rsTJ5GFNFyVpEQRX9n+aMfiSN4CWNsBKdKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426540; c=relaxed/simple;
	bh=B4P7TAOdbbE18BYwUDofT07rV9WZe18+GNpnOuLOAfM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=czuOeT5tjy34PnpWAWMOi+0WX6UTn2IbMl8Usq62SG57V8UYqvV+awTRwn+Wq5EqswJet3Ry/Rssl56zPgWiU+u3q9SDhSx+/ZooW+DqaEHFM+3qYmE5loTXwwybZkcKX04CoNIZjx+robg7X/o5ddayOXEC9F6SGYlaJc8xf3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DtzzWEMN; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DtzzWEMN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6e3im2923674;
	Fri, 13 Mar 2026 18:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=B4P7TAOdbbE18BYwUDofT07rV9WZe18+GNpnOuLOAfM=; b=DtzzWEMN
	+ZcL812jMxfST5BS1enOr1fxTxR67zRTRTBbaDwUZWUEE+r5fVNSFumqSmT770EJ
	cSJ4fjR508kZ2PiUPWAaXnQu8+MK1FZVRBBwScQJgCrwgvGOLlytoBeNxruuZobF
	oAh8+IE9HZaF6XSIQES811dRft4WYkqU7ysUW5o7lS06PXotzboAeTKxmKSBS/os
	OMdqw84HFaW36giHCM6mHCg+MLSaHrP/hy+BQ3//HOh1etN+Up+B6Ki7MJfT8Tiy
	zkZzqZiwZQ+kNHVEynfcg3TEKVPsVlLbFbZLXnOAuC+BZTyZx67Kq1lvBoJJ6ZU5
	p5fbtBkxPJ65xg==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh95199a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 18:28:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ir3QJSKnY2759/ouokCUAP6bszYi92qGZzCuA7cmbIw0Vfhpjvv0J+MmrVhil5B7mcON9S1j6pT6K9NWAJhDaGIAG38IlzO6KDzvSG/4ct54HEihmdg9R5MJg210jwWYtoza2Itb4JOyyv95cTVf/Q8GtVgGpFKeO/NPpX3qqYyRPuaIdSo5mm5kYT2IWKw/vJ7LTGLYJnxtly36kehR7+/Ny9l48MEcuHjkAVAcjYRgnfs+slK5rlbSQl9l0SeWwhaDtuncuQfyAppc+AHcPqDj+mv6AYq0vx7sydZH/GrFFp6bcuJ+kWYeg6uatHnjx9lgStbkyHRVN3WIwym4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4P7TAOdbbE18BYwUDofT07rV9WZe18+GNpnOuLOAfM=;
 b=xaiWIPJOuVIRCdlzvcmAZ/d2/tt6ipWdSb/JnTWCP7IlxFvmaW1p0+1wRBJO8WsbDTW+Q5TWbq07H9ESTXfvRZw/fRhQ/nxr+aAHs89CZz0vR2qxVEAuTH5P0YTQefJNJUjxqj1gZfthMT1wwdVNGFc63I4lN2i2RqITyRjL0b77dnBmgVXCORg0DbfC88+a0yOIcYRCEyRVaGMdCIsPUbKfH1Ux0FHOdN7kbZL6kTUtqSkAiS92cmtFLj9ShUAWG3obRF8TEp92PP9N+huuUUz93HJ5qqozMtwkr6t3sU86/R+0NljzZiNyd2g0nz+cr4w+ieMB/i/b+tCuvBc0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB6360.namprd15.prod.outlook.com (2603:10b6:8:fb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.6; Fri, 13 Mar 2026 18:28:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.000; Fri, 13 Mar 2026
 18:28:51 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ionut.nechita@windriver.com" <ionut.nechita@windriver.com>
CC: Xiubo Li <xiubli@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v1 08/13] ceph: make ceph_start_io_write()
 killable
Thread-Index: AQHcsmFI9nHo5gB8jE+YKvAk62zrZbWsybWA
Date: Fri, 13 Mar 2026 18:28:51 +0000
Message-ID: <d60a766e62698f970217ab2f487abe6e806f63ab.camel@ibm.com>
References: <a86dcbd27a3f2a17d16046ecc9c19d91ab093549.camel@ibm.com>
	 <20260312204559.8516-1-ionut.nechita@windriver.com>
In-Reply-To: <20260312204559.8516-1-ionut.nechita@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB6360:EE_
x-ms-office365-filtering-correlation-id: 25347e43-bf61-4f11-8a97-08de812e605e
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 TNrFXiwf4ebtJKhSp0Ub95c4cn/4E3+/+Rbs99fmVBgTwRgbkR3TbZ0eknHsNRUFytHztTcciJjFNKbSUnNEyKF3ArHNrnlmpm7Vv/iO3lghBpWtOvE7cwrzgGl3puih6wWVmwV9bFz+GAbIVg9pQdtJ4lT2RBTE5iK/qfGfdNIipjJD7BaH7EW5RxKGwSAYUXU6SCK4ov9epQKkzBP2IgQghpa6vO7m6z07PniiHqX/oLxHef/yy/JPzDwk6T1a37y2cXLVUOu4s15OlU8lI7QWaq0+x862TOs0RMYtpbaDsv3+ntXWUI/MYmUB8VZrSTAu/nXBO4Pt4WFmVKP+G0zDy2meB0U9l1sC6efOjtA2OdCVEPL1vQvw8RnKJG57QlTPyHndYWXAqCULhQiHfCMe83eSYQplQPmyo4pTpvcfLNb/o66z9+0kW2T3/1jksHbtMVlOP1DOjy0Fad6BkLNt5DTda3R4Qa3uyNxo6Snu5MxViGRtSfiIs/yCw00orIS6tRdJlyBiQIEcsviJXfFSoq2qiPkoAjdxymeGmBzcXUQQ8ATYjagPpHnQTk7vM8r5habhenJqhLm1XL4mWjm+D+qV0ci2FOnI6Q7SceZg6Nx6jnU/SHq9yOtZAgiBJtJzvsIH2V85FwB+f4w2hdRMoI8Zl5SrD8bK1mTRlDZT9xgLwRHyoYdD94ERun8YJeTA3R/lfl1piDmgWUxzGvvrOoyS47mDg/gOrTE5qpKZZk5I/yjnkqyKCd1wckHdvm8LA5S9t8+cjC0hTGR59Z1+PHdQxtR5t8IfagZ90WA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym9KSDRabmJBNmJPOUFxSHU1MVVjYkdSOHNnYXA4NnFTYWp2MUF3Zk9iZHpV?=
 =?utf-8?B?TXgxUUN4T09WYUd0L3N5UzRjS3FvT052OGJuTUN5R0xIR3UvRVJiZUhJTkll?=
 =?utf-8?B?RFpyU2dhSitUN3ozRE9JRFYwc1JyaHpvS3NyUVVVUU0yT2dya1lzZUlGQit2?=
 =?utf-8?B?Tm9vRTVrZzJrTllpYTNjbFJzRzFmTFZ3Unlscno3WnlMNkRKZVVDTTNZZm9O?=
 =?utf-8?B?bGk3L0NVejE4bHFQVFBHdTM4QjZXWTZhaHBKenlXRHpuZlhLaEZhaFAvQzBa?=
 =?utf-8?B?OTJBdkYwczdQazJjdWdLc2ZkbHNvQzFaVnZDMnEwVG9XSXhXVmxVOWFpbk9j?=
 =?utf-8?B?Y09NY3B4bHpKODRUTTdXc1NOT0tCTE1sVUFwejU5bmU4c0w4YkhJcG1LaC9h?=
 =?utf-8?B?TnNnaTQzbjdkYUQ5eXh2VlNsUWkzQzBZUjVnR3llTXpOT0FWa3JlRU5DVFpq?=
 =?utf-8?B?OHpPQlN0U05uNEdmaVlUMTh6R3Nadkw1LzdjdmNMcXdpcGN2VjZCQjhiMjNr?=
 =?utf-8?B?WDRuaGpjQ2phR3RGK2xXUER6MVNtbnZHODBKMzRzUVZ0L2NBUGRGNnVYTHEx?=
 =?utf-8?B?ZVNweWw5NGQwVVJ1RUZodS83Wm9rSDNQb0k1MTJJTlU0bnphdUdMUWxmZnE2?=
 =?utf-8?B?bzI3LzdaVnhSR3p5SUcwblBycW9RNVV6OU9kR3VYRlVRNVljZkRNdUk3NDFT?=
 =?utf-8?B?bHhvUHFwRlZodWhTY0xpMmpUY0ZGck94S3NJRE54TWVSVzZnTjdIcENmS0dx?=
 =?utf-8?B?T2tVUE94dlZFMklvL2xqNGxuamloeE9Mekg1SllUakU3NTB3OXU5YXc0Wk1H?=
 =?utf-8?B?a2R0V1ZTczk5N0orL2xNR2RONWNiSWc4dk40VU5lMGdLMmhJRW91TVh2T3JM?=
 =?utf-8?B?UzZsZThlZDJFSGh6b011aFdYSDlLWWtMUUNEMUk1Rkw3Z2lMNWU1VEpmNXd1?=
 =?utf-8?B?SlFEcitpOUNvR2hvcmdrRlRxMDY2ME5IUzlVNWU5bGlpeW1WRFRhVmZmMWtR?=
 =?utf-8?B?QVpVVFFpVjBoRWlSRThVWFo5QUdXUGkzY25EeHhHNzJWTTdWQ2hxaUtSbTcw?=
 =?utf-8?B?RDZtZCs2NHR5dkVXOVdJc2RPcCtwL1B4R1FaeVgzWVlkUjFQQW5TaWdZcS85?=
 =?utf-8?B?NVZrSzdlS1U5bHVjYUtRbmYwL01LcEh1RVdBYy9JWG1zdjE1WUVOczNTSEt5?=
 =?utf-8?B?b29kblhDR3RiR3pjV3FPbi9oR2IrS2w1WUQ2bWUrYVcvWlNhK29uN0IzaHJO?=
 =?utf-8?B?MUs2M252YXdPZytKUGNPRndrcjd3ZWljek12UnNXV2VmL1pkNnZ3NlVPZzRR?=
 =?utf-8?B?aVJ4TlNhMXNGVkduelBKbXRod1huL3FRNlA0ZlpqSGV6WXpacnJDK3pKSGNt?=
 =?utf-8?B?dE8veWhQM29jVk1VRGNjVGRNZ0cvZlovS0ZQK01qMEZ3TnVQNWxXMW42SVgv?=
 =?utf-8?B?T1o3emFKelFsekhhcGJzMFZkVXdjb0oySEZVTlJoTGNFZEV0VG9xL0xDSlh5?=
 =?utf-8?B?TFFOR3k3MFlBTFhYd2QzU1F2eC9pTG8rOUJHekZ6WWNKNUVjeWlDN0JacE1O?=
 =?utf-8?B?NmdFT3crWHBQTTNFSXV2MldhTm5rdmtBdld3YW5aTWVzZGROUVhsbFpTcGN6?=
 =?utf-8?B?WDRHTmVJaVRZczhCdWtmSlV2aXp1WG1JUXJwU1UvN2IrODJBYmJvZjV6Mks5?=
 =?utf-8?B?NkJqeExTNGgwYUFPQ2FoK3FsWFlSbHFVT1V3WUl5N0w0eUpvUTl0dmN0WXZJ?=
 =?utf-8?B?bU5ZaUpOUmVIRDMyVlZ1OE5DeUJBdVZxTzk0VFIyVkozcS9WcWNBOXZJcWdz?=
 =?utf-8?B?ZEdURzdMUDBEendBeTVsV1FWWG9WRkk2SGk4OUJpNk9zeDBPTitnaHp2VVc0?=
 =?utf-8?B?MXRrdDZieWVSNHhUREtMMk5ta09SRjZleHpYUStmMmxmSDRIZ3JnblI5bVZZ?=
 =?utf-8?B?ajY1THVzUElZemYxczZtVU9JMlovckhKYXVsbTY2T1lpNnFVelFoSTdCVkd5?=
 =?utf-8?B?dTVJSy9QNUV1ZzJUWGwyWjlHcDRmSkw0OHNoM0NheVZUeHJlUk9scWhMRUhW?=
 =?utf-8?B?NlFGMEdTRmtVU1dqTmdBUFRnanl2c0ZvRjVkRXhpdlA2U3ByL01vV21GenRs?=
 =?utf-8?B?d0NBQmlFMkE3RmFxOGNUSDI1Mkh0NkVTektBalJTempoZ3ZuQi83cEg4QXZL?=
 =?utf-8?B?dG1xUFpiOXRWRFpJd0ZJc2E0VEl5eTNwN3JIeEE3TjY2TENKOXBQd2psdUFt?=
 =?utf-8?B?ZTBVaUx1UnptMFRQZklwZVJkN1dMUkd1UFM4OTE5SXVjK3l0dUZUNWFUV1Vz?=
 =?utf-8?B?MERod0lSN2pXNjNEWlEvZWRqd1ZxS0Y3V1JsVUhzUjB6VWtjaGc0eGZBRGRs?=
 =?utf-8?Q?7bXzaEU0HGKGxlNocGDTHrECco0UjBO3t5Ddi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF0E98560354D540AA2F48B07A4E690A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	o82jyYovtfcpCi0Y6kxB+JXeWc+mmXhqjjK+bPSIHXALB66HBoI3L42S4edKxHJrWtueBYd6sYsyiWSg4Z5WdqzyQi42qvWqRkKVk7bIg9U/Iz15iN5EMsdaBbK8j1WvV98ZbXmzhd/amy1n0PnldeKZnsVjJjjL4StFlyarlz5paT8k3l9PlD2Q1ZYueV+oK7rw9lR8Lo58en00heUIc+JjC+B721j3WzjKm1+STAYFhla1asJJi/UT4G4XgoRSzE+qlboajN7PhnFbkLqZNtMW4YBUbMPLHiaygH8m0M+xuMpTLYm93KLle9k1pHF5CufzCtf9vbawpqgnjkSy1Q==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25347e43-bf61-4f11-8a97-08de812e605e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 18:28:51.8212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQuE61/aX33xE+bEp8GOqDIwfwsPlz1R6Xo/UZtz9FGZdevoiIMFVnc7eeGpKkhVNujuZtSVD0ntowUz0c/OWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6360
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b45768 cx=c_pps
 a=eHfeAi0ej4loD7KcX6Y+qw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=t7CeM3EgAAAA:8 a=MYjB8md5GbNDGWMEEIEA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE0MyBTYWx0ZWRfXxclyX2yaPYf6
 xS8CTvEWZz/RF8+Gxu8RnLI/HXxE0UXsctkkeVyhpXkPYVMZ91qYOiQYXnfCw8ETC7Ob/xcbqeD
 SEl/IoyPgNUW9/mkPhZgiQTcPkFT2IQKZqLPFumovzvSQHIcBM7AOnyedK02iFlO6iDdJuGOUU1
 psmyjXmduBLkG9e9gVPcDwXX1ajN6569dDQyHO34uhUWavbFvjsBdrZ3OA6j5QxaMkNaylwhaEM
 lS3tlY/vNlpcXUtcu5mVfPZ+8E1/GEJZr5bRtN16v+7yVeVwd66XIO9zO0dE7te1n8QtlyF06US
 vM9GRe69U+h2oFtZPzkhQS2QoicxtCJZxxXPUm4WSQuzKwR8sT8e5PjN09wD3bp3eD4YFBe0zgw
 b90+ZbLPNsusUy39MpGMJYx1IWiH+TA0mT6yJ9WDigk+yqh0rEUROo8VfagTjX8d4UOXyQZyOsk
 4Xlpn/2QBaFCpp92gkw==
X-Proofpoint-ORIG-GUID: tdaz0JEwtXST9lIO0Hzik9qQ_eHmV9II
X-Proofpoint-GUID: kpzi1S34McEBiH57vOBZ-exvlcN6Y88f
Subject: RE: [PATCH v1 08/13] ceph: make ceph_start_io_write() killable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130143

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDIyOjQ1ICswMjAwLCBJb251dCBOZWNoaXRhIChXaW5kIFJp
dmVyKSB3cm90ZToNCj4gRnJvbTogSW9udXQgTmVjaGl0YSA8aW9udXQubmVjaGl0YUB3aW5kcml2
ZXIuY29tPg0KPiANCj4gSGkgU2xhdmEsDQo+IA0KPiBUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMg
b3V0Lg0KPiANCj4gTXkgcGF0Y2ggc2VyaWVzIGlzIGJhc2VkIG9uIHY2LjEyLjU3IChzdGFibGUv
TFRTKSwgd2hlcmUNCj4gY2VwaF9zdGFydF9pb193cml0ZSgpIHN0aWxsIHVzZXMgdGhlIG5vbi1r
aWxsYWJsZSBkb3duX3dyaXRlKCkuDQo+IA0KPiBJIHNlZSB0aGF0IHVwc3RyZWFtIHY3LjAtcmMz
IGFscmVhZHkgaGFzIHRoaXMgY2hhbmdlLiBJIHdpbGwgdGFrZQ0KPiB0aGlzIGludG8gYWNjb3Vu
dCBhbmQgYWRhcHQgdGhlIHNlcmllcyBmb3IgNi4xOCBMVFMgYW5kIDcuMCsgYXMNCj4gd2VsbCwg
ZHJvcHBpbmcgcGF0Y2hlcyB0aGF0IGFyZSBhbHJlYWR5IHVwc3RyZWFtLg0KPiANCj4gDQoNClNv
dW5kcyBncmVhdCEgOikNCg0KSSB0aGluaywgbWF5YmUsIHlvdSBuZWVkIHRvIGNvbnNpZGVyIHRv
IHVzZSBuYW1lbHkgMTAwbXMgYXMgdGltZW91dCBpbnN0ZWFkIG9mDQpIWi8xMC4NCg0KVGhhbmtz
LA0KU2xhdmEuDQo=
