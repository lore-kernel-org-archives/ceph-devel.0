Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEA22D7812;
	Fri,  1 May 2026 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777671484; cv=fail; b=K3FogK7xFFvTNHnZCAEys26sc3NQoBY++SjITlpLzbqsjXxmHL2qIhjFCSlFYRgA5Qv4cuiSY3iR+sjbM6d9448iDIfNUp+h6WVnQplgZXUFeLO6GOfQcqD8FoxmF6yLlLu36fdFPW3jfg5JK1koQkUsfJGILoBsC2MnWwadQ6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777671484; c=relaxed/simple;
	bh=LBMVxsBPuN06DEbiho3LeW9WSV5Ra1m+WYoLB6WBX70=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=tCWIgNC4Rl/INhViuQ3xS4gk35HXxF0Uv18NWqglQQ9b+/3u2lRsdDPIOXVI2qVtrYbW8+ULdxam3jCH+bDEUqvw6RbgweBLAFyx0959VnUWTNQwqSCssfS5dqS7LCyga+2Vu0qw4MmrUO87rBcFfnB8WDdecIuyu5o354Gqoz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j56vdhdS; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j56vdhdS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 641FfUGp2123530;
	Fri, 1 May 2026 21:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=LBMVxsBPuN06DEbiho3LeW9WSV5Ra1m+WYoLB6WBX70=; b=j56vdhdS
	vCBX8pBQg9gVCz3ON1YeXX9yW1vruy3LsvhtwU+wD3SoqexrxhME/sY1UhqlXj9T
	0l0TpMdREZTqi8aZriLWCT1Z9OYtgBOI1WcQNJfa8fDRxfwEfHH9lTs/MnSZ6adp
	bnTGdg4zJ9+upgZ+j8L9rVMbfEogK905JclEaA36G3Asf8DbZq5iv/JQ576LJYcU
	YRweuNeiRDlU50cxmGfQqQCTjwQM49wjTkdIBzn0tS49G++BiIrtVhnxl9vzZGkS
	Cqg0Mq0XeFTMnKky0bF4A87LWhUs88w7V4edc+I0ZE1A/FOPfPrrXSJ+z1wLRzFO
	BxJzTbfuKOcvTQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vvep5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 21:37:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0JryOESQpbHB0R65NWVJguKbyaT42TBhLEeT+E2w0zhNYIRPZ2whcu1Wcldl216dNYYn7j6+lC1LSe/5AypcujI7SlBX9JgFx/16NkcAAjfjy9HdzA0/7gCfspjaGvF8aIUFPjRSDmal5EIoujBDg+Yvp0p7cuqqkxmC8Dqv7VJOWKVn4cI2pk/rX3W8GNab9wiEiFnY80m4gNhpQY6gBJoKW+VrlMrmxzsucXn8H438ARVnRp2f14KNFw90wYQjjl5Hi1yyDqcvIHBkRF2uhy5JIGIWE4wtRUPHzASvDp0zJRlROQEh89v8SB1L80n4B0EozOBgEkg06v2BfHG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBMVxsBPuN06DEbiho3LeW9WSV5Ra1m+WYoLB6WBX70=;
 b=DTwMisnmg3vK4sU9oLgGo6lY/ypXRdjnHbW95N8+MrmYgfBqCElUch7mr05+1t5M/T8k2+zYq/vcm1g7rdsFq7cy3ANkaIYGf+POGd6bDKc5bUs35kar5wdVGXsECAbp09AcadmUIFvV6v8Vpk8YGv2DOu1SlbOMokFiDkDfuSaO/tkHqD2+oyxSyYr9mTK31VgnsmJCD1zjnXVvbNGGeX9NJ1AdhWrA3ddXeRUnS6MMSYnYZ37//HOcer/jN9kh9ftSGv9sk3kJGPnaVQGI8s2R2ieCr/2217ey9zeYuZARMmBhi4UZRdQpyVdDhiayANAEXOzPYYpbULCH3EPuIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA3PR15MB6584.namprd15.prod.outlook.com (2603:10b6:208:526::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 21:37:26 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 21:37:26 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "mishra.dhiraj95@gmail.com" <mishra.dhiraj95@gmail.com>
CC: "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] libceph: reject monitor replies with
 oversized data segment
Thread-Index: AQHc2aH/bZGhchgjQ02EF/eXlwBGjLX5siMA
Date: Fri, 1 May 2026 21:37:26 +0000
Message-ID: <3bbef0fb32f1f7b1925cf47e3396a95b139289db.camel@ibm.com>
References: <20260501193722.25194-1-mishra.dhiraj95@gmail.com>
In-Reply-To: <20260501193722.25194-1-mishra.dhiraj95@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA3PR15MB6584:EE_
x-ms-office365-filtering-correlation-id: 0d322c58-31a2-4514-85c4-08dea7c9d6d1
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 0ullpbEEiIU+81wOnP054CXnZ7/5hF4/mY5OfHOfofhqigiypJ0+5GedzLmMC3CWZmvU0yEdId6bVffWnjP3A0vdjXlHQ9snwBPhV0InDgWr5AMB/JwmBWAkD3MNlzNt2+ROZqh666HF6jBRKTAQ4j/rAai8zOKIfd7dfsCOrZAghj45WBLwRwrKfC6rqIJLIoMFedSuCFo+nxD1RwkZn/RnjSzxDtcnaNvZEDgXgEWqSBhkjiT3sdb/E0+v1/fhXl5Ic01Ct2BZCTLkd8YgJDXB1JQ2JJjCIBiVwLDWJRx+D6e8Gfm8ETnRSWXMioasLFrT6fpZxYtZL5fzARJDEflYYmnc3C82GcQ/Yb7Uk/MnGJSbj7AR0dpTs/SfR/XUxECBb5SzF4Fr/NsTrwd9LdxKxMUTNMpb5kWE0f+R8jzgyiR5VzivKvYUjIr+X0XBTatbzqjZ/YpDGFaoL8vrVvFQXlRCVSC39iceYylaACWftVtWOE4ICID++SM457s3ni5Xr+mExIKviD1LFdhr1nS0VtycQxzak4LFJi8pvwSESgUQYHeLMqFozmvdTjiUdcvIadkCjGV1FuDW1EXIKfmDFMkwcWM5QwB+AOAvNP+fz9SKaCrajo34F/q1Ih6EB774JWXYkNiOkhmO+zXPy92DMzZdQLPP/7K0tlFwcG7pG+3pfmahVmVt2G2p9cUPhsBwzEpqyIufNOJtCG1ZaXAqZaM1LuHJw3DntwULzgZjuXWdV9u6X1r+Vp5/URml
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHhrblB1MXRUVDlHd0QrU2JTTG5NaThuZXo4bjBvRWlzR3QxQk1uMTlWN1lP?=
 =?utf-8?B?S2NudEZyME9KVDVaa201SE1mQkNVOFAvYVhzU2pTZXhuSmtzZjZiY09GSzFp?=
 =?utf-8?B?UldjbHZkaXJmZFpiS3VnZ01VTDFoSlpKb1Rnd2EvVU5FY3B0QU5qWWpDQVpw?=
 =?utf-8?B?Qzd6cWxoZ3JrYUpyWnlKQk16QWVVTWcyeWdBOFl1d1kyYVhXeWdFUmZBUEoy?=
 =?utf-8?B?T01OR1VPZUJjeTZKWWFhWDY2bjFEdGhXanR5NlJObmJCMDNzV2RRaUlEMk8r?=
 =?utf-8?B?UkUrem1mbXE1bUJnR2F2K2QwUU5ycGJFMFJiWUJxVkVEWHhNejczajNZcEFx?=
 =?utf-8?B?MVNURngzOUNIZzRZVHByZVZQd1psWWNJN3JLR1ZmaXk2czNTWEJsUkQ5VzJs?=
 =?utf-8?B?WTlHR2tpQXlTQUtFbThwYzdJRFFtWGF3bVBvSkpmd1R3WjR5eDFBZngzNG4v?=
 =?utf-8?B?dEJ4dXJsWHEvRU1OQklvcEJUenpYRlF3L3N1b3BMY1huQ1VJYmRRVHFmK2FJ?=
 =?utf-8?B?MGxuYTVTWFlxZTQxcUhFUHp6ekxZZXFJc1o5VFpGZWVodUlpRUZzSmp4UU5i?=
 =?utf-8?B?L3dzT1ZnUGd4TlhCZXc3a0pqSFpaMzFsZTJoWmExdWFEUTNpUHhlMDVnQ2Fx?=
 =?utf-8?B?MW1MOGFNQTZ6MHBmZW4zRkhscFhieHhhOHBocVV5amJXZGNrdms3QXRPYW82?=
 =?utf-8?B?YisyNUpXTURUVEgrN1J2aklOa3R6dU4rQmd6UkU5eHB2MVBGZUlpWjM5Nmo0?=
 =?utf-8?B?ZjNJL05GY1AzYWRKTkJXUHVPVVJpQjNkR1pIM3I1NDFsd2p0N3pReG9KeHVh?=
 =?utf-8?B?eXEzcUY3VnBHOTdQdlc1aUZRaXBkMlhUOFhnWTR0N3EwT1Y3ZDdra1JHNnJk?=
 =?utf-8?B?SFRDS1BNWlhvazNJb1AvZGNyWFdXdmp1ZFdGQlorMUwrZDg4eWxrL2MzVlIx?=
 =?utf-8?B?L09iQkFVREx4Yms3TGExOEpvMkJUeVhSbkV6eGpaS29RaUpleXJFVUwvNFkr?=
 =?utf-8?B?TFBPMnYxQUx6S2FRaGlUUXR2ZjhDRFQ5SWhoZ0haZDdTNE9HaVpQN1U2ZU1I?=
 =?utf-8?B?b2xHMFBLUUEvL1JWVkJ2blBSKzBLTUUydXBHa0NsWEZCejJPZFhqUjBEcytY?=
 =?utf-8?B?VHBzV3M1ZXRmRkEwSHZwM3RrMnhLSGxFS0NkdHpPMG8ydWNjVUZzNzFQRUtm?=
 =?utf-8?B?SVhlTkxWZmFROFdod0hGQ0JUSXVMNzFLSEZqMWdPZ0hBcm4yMjNEeW1UMXIz?=
 =?utf-8?B?Q1JFZStnMXV4YU9vUjFsTFhFMDRBVmhkbnpDZHZaU1FRK3V3N1dRVHkzYlRS?=
 =?utf-8?B?STVyRjF5aEdaUTVISFpPTGo3UWJjb3FsRFZQNHlHNDNJOW5nbE5nRlNzME9j?=
 =?utf-8?B?NWdwYll2QlovaXVYU1VrZlQ2THREQnk3bzJ6OENHSEhqbk52dXZqdVJ5c0Zu?=
 =?utf-8?B?ZFkxQkF1WERwT2k2RjNsOHpnb3dFZHdEVXlKRUdHNXdBcWZPMGVQc1hBUlZM?=
 =?utf-8?B?R2l3Qk1CRVVPY2d4RW5kc20xWEZ4eGNRRkcrK3ZXVHU0ODA5WTBrT1ZUSW1S?=
 =?utf-8?B?U3NnWFNCeEtwb0xrTkxkTk42Ym8zLy9JeCtHU0wyZWxGdHdpUklXSGFNR2hB?=
 =?utf-8?B?S2ZLWWU5U2RXY0M2b3dUYy9hc05salZFYXhhUUZmQno3dnFsMzFEQncvWW9w?=
 =?utf-8?B?ZlhMbTZYNUZ6RnNXNmpDTytNU0ZBbmt0Zk0yNnFsS3J0VFU2TFJ5K041Ly9M?=
 =?utf-8?B?ZjNBN3V0Vkl1NXF3bFBOaWpVZE0xWEdYTEQ2UFVVNHJZQzlXNWhSbHpFQmR1?=
 =?utf-8?B?aU9EbjNuMXcrMytZRGx3bUZxZngwWWNBQzBnTkRvOE9MMDdJUk43V2xoVE5E?=
 =?utf-8?B?aDlxR1RpVDZ6ZFR5OHlmUzZrczY5OG5KQTZIOHR1OFNsUUpLbnpvT2U0T2pJ?=
 =?utf-8?B?S3l4ZFJObFpTT0RDYnUyOTlqWlg1QkkxOE5PYmpxVUxKZkZKa0xKdHJETElO?=
 =?utf-8?B?WnRxU3dMeUZDN3VaQjMyZzNNMlJKYitTUTI3Uk1qN3UyWVlocmtZZXJxQjBS?=
 =?utf-8?B?Z2RUaXNaRm1XNlNlTWtRQXpHZU9jb3N5dlo5TTdpU0ZHYkNmb3QyWFNXck5m?=
 =?utf-8?B?TzBNcXVhUnVNMzBEZzlWcTlmMlE3dW01QTZEL2ozMnZvZzNoSStyTENGdi9m?=
 =?utf-8?B?d2k3aUQ0akJGTlBQZ3pLWThLdXYzSW1tdXl2VGw2bmVEZnZhcEtsc0d3Nkhn?=
 =?utf-8?B?ekhUMDdsQ21LWUk4RURrUW54L3NlbXhubWhkdFJ6c3pvdXozaEZ1ZDNWelBL?=
 =?utf-8?B?eG04SWNmMWtMUkRBTzhHVkZwWFlORWhic2xtYkY3ZmFGN1lWcXRTVkhyQk1E?=
 =?utf-8?Q?4Hc7zw+cd1+OMFmO7BzX8jdqcBcYvKEUen/p+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96B15BEE05A08441983A98CEF9E9D21B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	K4LNlf2SxFKQlJV//BV7tG+YvyKxm5HpVbsoCflkXjGzh5eBMGzvLGX5kui8gbcVVDH+Cu/ElTtYnPEIZHZPUum4UrQuMMWnGWBAVzB/TqvBSJU8SvynyXnN8Ee0zGcy5/gz/u6iNpjvudRx4VUbtVBR69FTADQ+WGccQmtrXUdfMNMADbiSAwM8a5HuzTRmLBEo0JN2D4uK8/DFYKmkznrjeaQKPOuWaWWj96AfVwuXToIgGRsj/9dzWl+FTj9e8YaocL1gCq1V9Bqa8WtZwX4VeHs/jIdQ0q01cy8rT8m+hxgGOzOFODlUStJUHajV2cg/nM+hruNWkkixsyvkPQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d322c58-31a2-4514-85c4-08dea7c9d6d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2026 21:37:26.7375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+XPst30Lt85/xi2mVYppBNwsaoMbFADN9mksttAXNcmFjPkUKXFM3ljIR5jzUpir20LREuzmSVKs/SiPOLCqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6584
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f51d1a cx=c_pps
 a=QnZ2uEdZlRAtgHxfLCbJPw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=NZDTwnWLz-ndBdYG9LcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -uiYCt0Os04aWZ3aH19LXz97mGf0WEbl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDIxMCBTYWx0ZWRfX4Qf0GhW03ftX
 2K1LYCtSn+v4Kxb7uUzrIwlfMuX2iv/i6O2HVPWUJqSbhga/QS0ZbUOYvGKQi8WLDpKAevDCpm2
 d48uitsSv0IKDY0USFTzg0SM1IIf2p6NayUzdL4R55MlGvnRGOaDDAPILuJ2MgdQe5DZ1TPCk43
 CbMzzYxGm7UO5MGRC7k1CBmZEStaafOWFOkHJstk5ZY1p4OKMQS0d04u5ofZGl3VLCLIZcjDq0c
 owRjDixlcDG804DnZfFG4m0adMyC+PAbbjReikUA7ZLAf1mUg2JS7DsvNif97swvTQHJpUDwu3/
 GFge/oCJ/yjq+4nbQqbPpnpOrMvK04lxPQNHJScDPBffGv6nxQ+eaS3+Fqnn7ZIHCpNaqAUPx3J
 8QFB4eeuyN9VBfzO8VFTmHytgDZh+ZckoZPI9SxODqyi4nuZPzNFo9CPifiN0jL4fmh2ei5/WCv
 wv+Dzha7NkCOCtHC7OA==
X-Proofpoint-GUID: 0NiNgrzEkm4YbOgrUNed5WkJuzhScsOF
Subject: Re:  [PATCH v2] libceph: reject monitor replies with oversized data
 segment
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010210

T24gRnJpLCAyMDI2LTA1LTAxIGF0IDIzOjM3ICswNDAwLCBEaGlyYWogTWlzaHJhIHdyb3RlOg0K
PiBNb25pdG9yIG1lc3NhZ2VzIGNhbiBiZSBhbGxvY2F0ZWQgZnJvbSBwcmVhbGxvY2F0ZWQgcmVw
bHkgbWVzc2FnZXMgb3INCj4gd2l0aCBjZXBoX21zZ19uZXcoKSwgYm90aCBvZiB3aGljaCBtYXkg
cHJvdmlkZSBvbmx5IGZyb250LWJ1ZmZlciBzdG9yYWdlDQo+IGFuZCBubyBkYXRhIGl0ZW1zLiAg
VGhlIG1lc3NlbmdlciByZWNlaXZlIHBhdGggY29waWVzIHRoZSB3aXJlIGhlYWRlcg0KPiBpbnRv
IHRoZSBzZWxlY3RlZCBjZXBoX21zZyBhbmQgbGF0ZXIgdXNlcyBoZHIuZGF0YV9sZW4gdG8gZGVj
aWRlIHdoZXRoZXINCj4gdG8gaW5pdGlhbGl6ZSBhIGRhdGEgY3Vyc29yLg0KPiANCj4gSWYgYSBt
YWxpY2lvdXMgb3IgY29tcHJvbWlzZWQgbW9uaXRvciBhZHZlcnRpc2VzIGEgbm9uLXplcm8gZGF0
YSBzZWdtZW50DQo+IGZvciBvbmUgb2YgdGhlc2UgZnJvbnQtb25seSByZXBsaWVzLCB0aGUgcmVj
ZWl2ZSBwYXRoIGNhbiBjYWxsDQo+IGNlcGhfbXNnX2RhdGFfY3Vyc29yX2luaXQoKSB3aXRoIGxl
bmd0aCBncmVhdGVyIHRoYW4gbXNnLT5kYXRhX2xlbmd0aCBhbmQNCj4gaGl0IGl0cyBCVUdfT04o
KSBjaGVja3MsIGNyYXNoaW5nIHRoZSBjbGllbnQga2VybmVsLg0KPiANCj4gSSB2ZXJpZmllZCB0
aGUgaXNzdWUgYWdhaW5zdCB2Ny4xLXJjMS0xMjMtZ2U3NWE0M2M3Y2VjNC4gIFRoZSBtc2dyMg0K
PiB0cmlnZ2VyIHBhdGggaXMgcHJlc2VudCBzaW5jZSBjb21taXQgY2QxYTY3N2NhZDk5ICgibGli
Y2VwaCwgY2VwaDoNCj4gaW1wbGVtZW50IG1zZ3IyLjEgcHJvdG9jb2wgKGNyYyBhbmQgc2VjdXJl
IG1vZGVzKSIpLCB3aGljaCBpcyBjb250YWluZWQNCj4gaW4gdjUuMTEtcmMxIGFuZCBsYXRlci4g
IFRoZSBtb25pdG9yIGFsbG9jYXRvciBwYXR0ZXJuIGlzIG9sZGVyLCBidXQgSQ0KPiBoYXZlIG5v
dCB0ZXN0ZWQgb2xkZXIgbXNncjEtb25seSBrZXJuZWxzLg0KPiANCj4gQSBjb25jcmV0ZSB0cmln
Z2VyIGlzIGEgbW9uaXRvciBjb25uZWN0aW9uIG92ZXIgbXNncjIgYWZ0ZXINCj4gQ0VQSF9DT05f
U19PUEVOIHdoZXJlIGEgRlJBTUVfVEFHX01FU1NBR0UgY29udGFpbnMgYSBtb25pdG9yIHJlcGx5
IHR5cGUNCj4gaGFuZGxlZCBieSBtb25fYWxsb2NfbXNnKCksIGEgdmFsaWQgZnJvbnRfbGVuIGZv
ciB0aGF0IG1lc3NhZ2UgdHlwZSBhbmQNCj4gZGF0YV9sZW4gPSAxLiAgQ0VQSF9NU0dfTU9OX01B
UCBpcyBvbmUgc3VjaCBleGFtcGxlOiB0aGUgbWVzc2FnZSBpcw0KPiBhbGxvY2F0ZWQgd2l0aCBj
ZXBoX21zZ19uZXcoKSwgbGVhdmluZyBtc2ctPmRhdGFfbGVuZ3RoIGFuZA0KPiBtc2ctPm51bV9k
YXRhX2l0ZW1zIGFzIHplcm8uDQo+IA0KPiBSZWplY3QgbW9uaXRvciByZXBsaWVzIHdob3NlIHdp
cmUgZGF0YSBzZWdtZW50IGlzIGxhcmdlciB0aGFuIHRoZSBkYXRhDQo+IGJhY2tpbmcgYWxsb2Nh
dGVkIGZvciB0aGUgc2VsZWN0ZWQgY2VwaF9tc2csIG1pcnJvcmluZyB0aGUgZXhpc3RpbmcgT1NE
DQo+IHJlcGx5IGhhcmRlbmluZy4NCj4gDQo+IEZpeGVzOiBjZDFhNjc3Y2FkOTkgKCJsaWJjZXBo
LCBjZXBoOiBpbXBsZW1lbnQgbXNncjIuMSBwcm90b2NvbCAoY3JjIGFuZCBzZWN1cmUgbW9kZXMp
IikNCj4gU2lnbmVkLW9mZi1ieTogRGhpcmFqIE1pc2hyYSA8bWlzaHJhLmRoaXJhajk1QGdtYWls
LmNvbT4NCj4gLS0tDQo+IHYyOg0KPiAgIC0gUmVzZW5kIGFzIGFuIGlubGluZSBwbGFpbi10ZXh0
IHBhdGNoLg0KPiAgIC0gQWRkIGZ1bGwgZW1haWwgYWRkcmVzcyB0byB0aGUgRnJvbSBhbmQgU2ln
bmVkLW9mZi1ieSBpZGVudGl0aWVzLg0KPiAgIC0gQWRkIGNlcGgtZGV2ZWwgYW5kIExLTUwgdG8g
dGhlIHJlY2lwaWVudCBsaXN0IHdoZW4gc2VuZGluZy4NCj4gDQo+ICBuZXQvY2VwaC9tb25fY2xp
ZW50LmMgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L2NlcGgvbW9uX2NsaWVudC5jIGIv
bmV0L2NlcGgvbW9uX2NsaWVudC5jDQo+IGluZGV4IGQyY2RjOGVlMzE1NS4uN2YyMjkzMTIyYmJh
IDEwMDY0NA0KPiAtLS0gYS9uZXQvY2VwaC9tb25fY2xpZW50LmMNCj4gKysrIGIvbmV0L2NlcGgv
bW9uX2NsaWVudC5jDQo+IEBAIC03MTIsNiArNzEyLDcgQEAgc3RhdGljIHN0cnVjdCBjZXBoX21z
ZyAqZ2V0X2dlbmVyaWNfcmVwbHkoc3RydWN0IGNlcGhfY29ubmVjdGlvbiAqY29uLA0KPiAgCXN0
cnVjdCBjZXBoX21vbl9jbGllbnQgKm1vbmMgPSBjb24tPnByaXZhdGU7DQo+ICAJc3RydWN0IGNl
cGhfbW9uX2dlbmVyaWNfcmVxdWVzdCAqcmVxOw0KPiAgCXU2NCB0aWQgPSBsZTY0X3RvX2NwdSho
ZHItPnRpZCk7DQo+ICsJdTMyIGRhdGFfbGVuID0gbGUzMl90b19jcHUoaGRyLT5kYXRhX2xlbik7
DQo+ICAJc3RydWN0IGNlcGhfbXNnICptOw0KPiAgDQo+ICAJbXV0ZXhfbG9jaygmbW9uYy0+bXV0
ZXgpOw0KPiBAQCAtNzIwLDYgKzcyMSwxNiBAQCBzdGF0aWMgc3RydWN0IGNlcGhfbXNnICpnZXRf
Z2VuZXJpY19yZXBseShzdHJ1Y3QgY2VwaF9jb25uZWN0aW9uICpjb24sDQo+ICAJCWRvdXQoImdl
dF9nZW5lcmljX3JlcGx5ICVsbGQgZG5lXG4iLCB0aWQpOw0KPiAgCQkqc2tpcCA9IDE7DQo+ICAJ
CW0gPSBOVUxMOw0KPiArCX0gZWxzZSBpZiAoIXJlcS0+cmVwbHkpIHsNCg0KVGhlIHJlcS0+cmVw
bHkgaXMgc2V0IHVuY29uZGl0aW9uYWxseSB3aGVuIHRoZSBnZW5lcmljIHJlcXVlc3QgaXMgYWxs
b2NhdGVkIGFuZA0Kc3VibWl0dGVkOyBpdCBpcyBuZXZlciBOVUxMIHdoZW4gcmVxIGlzIGZvdW5k
IGluIHRoZSB0cmVlLiBJdCBsb29rcyBsaWtlIGEgZGVhZA0KY29kZS4NCg0KPiArCQlwcl93YXJu
KCIlcyB0aWQgJWxsdSBtaXNzaW5nIHJlcGx5IGJ1ZmZlciwgc2tpcHBpbmdcbiIsDQo+ICsJCQlf
X2Z1bmNfXywgdGlkKTsNCj4gKwkJKnNraXAgPSAxOw0KPiArCQltID0gTlVMTDsNCj4gKwl9IGVs
c2UgaWYgKGRhdGFfbGVuID4gcmVxLT5yZXBseS0+ZGF0YV9sZW5ndGgpIHsNCj4gKwkJcHJfd2Fy
bigiJXMgdGlkICVsbHUgZGF0YSAldSA+IHByZWFsbG9jYXRlZCAlenUsIHNraXBwaW5nXG4iLA0K
PiArCQkJX19mdW5jX18sIHRpZCwgZGF0YV9sZW4sIHJlcS0+cmVwbHktPmRhdGFfbGVuZ3RoKTsN
Cg0KQXMgZmFyIGFzIEkgY2FuIHNlZSwgb3RoZXIgcHJfZXJyKCkgY2FsbHMgaW4gdGhpcyBmaWxl
IG5ldmVyIHNob3cgZnVuY3Rpb24gbmFtZS4NClNvLCBpdCdzIG5vdCBjb25zaXN0ZW50IHdpdGgg
Y29tbW9uIHN0eWxlIG9mIHRoZSBtb2R1bGUuDQoNCkEgbWFsaWNpb3VzIG1vbml0b3IgY2FuIHNl
bmQgYSBmbG9vZCBvZiBvdmVyc2l6ZWQgZnJhbWVzIGF0IGxpbmUgcmF0ZS4gUHJvYmFibHksDQp3
ZSBuZWVkIHRvIGNvbnNpZGVyIHByX3dhcm5fcmF0ZWxpbWl0ZWQoKS4NCg0KPiArCQkqc2tpcCA9
IDE7DQo+ICsJCW0gPSBOVUxMOw0KPiAgCX0gZWxzZSB7DQo+ICAJCWRvdXQoImdldF9nZW5lcmlj
X3JlcGx5ICVsbGQgZ290ICVwXG4iLCB0aWQsIHJlcS0+cmVwbHkpOw0KPiAgCQkqc2tpcCA9IDA7
DQo+IEBAIC0xNDk5LDYgKzE1MTAsNyBAQCBzdGF0aWMgc3RydWN0IGNlcGhfbXNnICptb25fYWxs
b2NfbXNnKHN0cnVjdCBjZXBoX2Nvbm5lY3Rpb24gKmNvbiwNCj4gIAlzdHJ1Y3QgY2VwaF9tb25f
Y2xpZW50ICptb25jID0gY29uLT5wcml2YXRlOw0KPiAgCWludCB0eXBlID0gbGUxNl90b19jcHUo
aGRyLT50eXBlKTsNCj4gIAlpbnQgZnJvbnRfbGVuID0gbGUzMl90b19jcHUoaGRyLT5mcm9udF9s
ZW4pOw0KPiArCXUzMiBkYXRhX2xlbiA9IGxlMzJfdG9fY3B1KGhkci0+ZGF0YV9sZW4pOw0KPiAg
CXN0cnVjdCBjZXBoX21zZyAqbSA9IE5VTEw7DQo+ICANCj4gIAkqc2tpcCA9IDA7DQo+IEBAIC0x
NTQ0LDYgKzE1NTYsMTUgQEAgc3RhdGljIHN0cnVjdCBjZXBoX21zZyAqbW9uX2FsbG9jX21zZyhz
dHJ1Y3QgY2VwaF9jb25uZWN0aW9uICpjb24sDQo+ICAJCWNlcGhfbXNnX3B1dChtKTsNCj4gIAkJ
bSA9IGNlcGhfbXNnX25ldyh0eXBlLCBmcm9udF9sZW4sIEdGUF9OT0ZTLCBmYWxzZSk7DQo+ICAJ
fQ0KDQpJIHdvdWxkIGxpa2UgdG8gc2VlIGFuIGVtcHR5IGxpbmUgYmV0d2VlbiB0aGVzZSBjb2Rl
IGJsb2Nrcy4NCg0KPiArCWlmIChtICYmIGRhdGFfbGVuID4gbS0+ZGF0YV9sZW5ndGgpIHsNCj4g
KwkJcHJfd2FybigiJXMgZGF0YSAldSA+IHByZWFsbG9jICV6dSAoJXUjJWxsdSksIHNraXBwaW5n
XG4iLA0KPiArCQkJX19mdW5jX18sIGRhdGFfbGVuLCBtLT5kYXRhX2xlbmd0aCwNCj4gKwkJCSh1
bnNpZ25lZCBpbnQpY29uLT5wZWVyX25hbWUudHlwZSwNCj4gKwkJCWxlNjRfdG9fY3B1KGNvbi0+
cGVlcl9uYW1lLm51bSkpOw0KPiArCQljZXBoX21zZ19wdXQobSk7DQo+ICsJCW0gPSBOVUxMOw0K
PiArCQkqc2tpcCA9IDE7DQo+ICsJfQ0KDQpJIGRvbid0IHF1aXRlIGZvbGxvdyB0byB0aGUgcHVy
cG9zZSBvZiB0aGlzIGNvZGUgYmxvY2suIEFzIGZhciBhcyBJIGNhbiBzZWUsIHdlDQpoYXZlOg0K
DQoJY2FzZSBDRVBIX01TR19TVEFURlNfUkVQTFk6DQoJY2FzZSBDRVBIX01TR19NT05fQ09NTUFO
RF9BQ0s6DQoJCXJldHVybiBnZXRfZ2VuZXJpY19yZXBseShjb24sIGhkciwgc2tpcCk7DQoNCldo
YXQgaXMgdGhlIHB1cnBvc2Ugb2YgdGhpcz8NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCj4gIA0KPiAg
CXJldHVybiBtOw0KPiAgfQ0K
