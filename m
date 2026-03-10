Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1959B2C159A
	for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166996; cv=fail; b=JweB7llQlHSPok1R035f0LxF3N3a2TE4kQCbkvkPzgk45j5mECL2cBuM1wxvQAJHnNi+a6x8nfjgaMJq5w56QhVcwrGovCCNMZTUxXIkVmPTWvg7832kZPPvTWl7JjwA9BU16xkbEq2+LffqnjKwC5z0moLc9RCbmS8EFaiTcfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166996; c=relaxed/simple;
	bh=fC8OKYDKq5tSWvkAFB9g6wBc5Js/MP2tyA7EmPTN+gU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=VxwSnmAX/PiERrChULoyqAvIy0KSZERlm9p/+rN+vCNWeKIuc6zIGwkz2UI1BvcIfb1dWz0kFkB23lGkYQvMiTZI+7jkjzFTCU6OnTMDopwoCMJAllVN3ef8b92qdgwLwJd83zNdx3xdW1Zu5iBr3n3TlbNKVD1o06E4Er9j7+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i1vqde5R; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i1vqde5R"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A90Qoc1649593;
	Tue, 10 Mar 2026 18:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=fC8OKYDKq5tSWvkAFB9g6wBc5Js/MP2tyA7EmPTN+gU=; b=i1vqde5R
	KE1VeeLxyBFfBSzUf0ORFFQUVyLLT8rg62F8uhW2KDAV7PrnTuwkroG1Xgkrabze
	ruDEJJsvU8+7SLuJe3H6dXexTb0wXNI0EB7rqRCe6tUP/QdzI0ttJOnX+AscY0vW
	KNSI3L9fatQEygjQyJXKjCG/f5Y7qZnJqrJVuhstCxSCfeVs9CVfu99jbBlEPjj+
	wLwEIKjYQrLCd/YpJehkX5Z83QIHgTB1xrv0Ml6hfLhFhySQliR/vyymxM+OAPcA
	LoxunRASqJU8nabBX+FoahGPYd73wGnnfKZbUl+Un5VzRVJhc6WNDTnaqo8Bgnlo
	vSAZGvyaR8M0cg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmcc8q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 18:22:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjTit8W/5glOkAMzuJLxsVNCI1XKBy7Uzww0c1SKTapFfz3rCBwdzjKz699H/hOsS3rF3kbPHL9V9owYH5TotkRhkD7ij9WDabYD4xDMV3FL0pt0QB2FMsAlIb9UX7m+rfgv84JzOOeYvkR93N6ATZE3Z8cEZARs9NVi2TClTwNcAD358zRrB1EqzfweTBJXTPcBIM8xfo6SXwwa5mivGi1hbSmEnTyGuIQf5kCAG4kG1V1WdaJkZDFbXGIli0nnFq33NupMw5rhXQ461+Hck/BJYysWS5sG4dW+TWg/nani4aYea3zlcP5m6RVWoCFgWWewIjIOQoY8tr1mmx9YdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC8OKYDKq5tSWvkAFB9g6wBc5Js/MP2tyA7EmPTN+gU=;
 b=voiJ2VE7FNntbhKTor27z3Vz0JoGkJE2cEH7D+vCCcfTO1aQeovH9l77rLTCqizIrJpdWTL9IRjyMQWEn0dPPTBUuKRdN9WTJIZwxcZr/d78rYqG66xuu6cbIWExfsnuD3fui+F7QhpGTsWnuwAACoYHriIR6JpK6FjLNt2MyWdt8EXYX57N3AvQ0/fPRMJQVHwe4U6JUYPb0vrM8byRBpNdYIYTFl1W5t8Y66GpX7WDyIWkIQTAxHaToxUUiWUb5HafLn+883eiXxLuFxrAbgUGu8bsgZcqjW7CV9ZSVoiHiUHaOwjUkn3ceBbcOkZzbXU9FTD1vT5rqUsE77smQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4341.namprd15.prod.outlook.com (2603:10b6:a03:380::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 18:22:54 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Tue, 10 Mar 2026
 18:22:54 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] libceph: Fix potential out-of-bounds
 access in ceph_handle_auth_reply()
Thread-Index: AQHcsJ7MJ55y1M6USUyH8SvtymfhPbWoFJOA
Date: Tue, 10 Mar 2026 18:22:54 +0000
Message-ID: <f26dfec7535ea353bd78606a2db11a21d9cd4e96.camel@ibm.com>
References: <20260310142815.3747443-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260310142815.3747443-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4341:EE_
x-ms-office365-filtering-correlation-id: 84fdf424-bd2b-4959-655f-08de7ed20c41
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 hqQuDTxTeoqKgiGGEEl0S4kX2KgGDQHCcHmbfqByNprNesza2zqHzw3mKSTg5rJmG5XZauLNMiS8pQmhPCspBkDYFFHp00hK/qZSrD0P5awbjrZx1WZcH/ma2zZPoG4FIyjIaUn45jvvzbRl51QDfrZlbxtn+IpHOJBF22wuvAuC3+xW2QyRpRjoZE3K5aPdFuno+ZHsvyjVoK+DYjo8/oo7z6xNxNjvehxnq3SHF736ODZPwhtzvL96kC2XNvRAHK9LIazjij53jclSg8ixCjw6eLrDDi8jEEmI+RUVkN0iA5SMp6x3X85SBO7cqx/0soQcaDWwdCXMzonrBAiI/OcahArCOinVl9628HKxupoWPtUlyoXKxeWkmpb11XIJ4S/QcoWtw/AIAHLTc56TiqQ7gwNuHQcOXmC7KxXQ5s8JCFrwyO4xgKBw/krAhiLVWQIQJr3gk/GbkgsOlS1AXDqpDq/CMIpSpW+KV3ziLEomXHnJB9RK9jlpWBpyi+kqwt5EucRYtJTtHYdFj46bC/uRYYIcZy0kkOBTM0Jh9KpVBiCWWiDuTai6ttkL0qkJHEsECtzK0fzUo0oMesUvKlez8BHILH4OUPo6pNrOtfUfxk5TRcQa3hKqlddBwnnHCkoJ7Wn3uaw5hZ5GHkVQ8EmfCEpqSolIIT1PqnzA+gpVgbqbqpvDZMUy54Bpgzz3XmaUeLzsCSL5ft0yb5y7/rkopWbEXTQFQXR4W8c1QRN6PBoPjNpPEcondX6gbaQZhbcj21mq8gdjI1Mc3CSHtHe6TzY84xVXH2eqKaF/6DU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QitOdjVCMFMzdnpTQ05nVFQvZGtrVytYOEFGd1VGclAvOWE2S0N3QTdiZW1V?=
 =?utf-8?B?WExUNUQyaUpwcGQ1WENSTjdHbzFmazlTR3hFaVdtSks0VEc5QnlZZHZaNFVo?=
 =?utf-8?B?TXBIRmNUNksrY0s1VlFWQzM2NGovd2V5YWc3UFhBWENPcWplMGltbTlLL1c0?=
 =?utf-8?B?VmxjbXZTUjNNS3pJcXMvUmRMc2oxUmM0MlMrWVh1NzlOQTZ0QmdxQlAzVGdS?=
 =?utf-8?B?YWlrOXRkQyttRHc0ZWRITGZkUDlvdzl6YjdoM0tldG8yOWRYRWFBNTZ4Q3dP?=
 =?utf-8?B?UmlNSnkrNWMrL2lpV3JVa2F1eVU3a2dXaHBhVXl1aUpmSkpOcVZoa1ZMclBk?=
 =?utf-8?B?dW12a2NwMnMvQVgrZ3FXbU9MR25pOEFEc0hRR004OW1VRnlSbWJMOWdaUDFL?=
 =?utf-8?B?TVNtc2toYXE2U1FnMG5HRnJnOEZiZ1p6Y1Z6eWFnYnRaR3UvNFV3eTM5bHRB?=
 =?utf-8?B?aVA1RzVDdi9SSUFtS2Jwb2R6ZEJtVE1vQmdnNzJGbXZScDRMSDhVTzdudGRV?=
 =?utf-8?B?Yk0zRER3SU4yL3pIMEhndWhiMkdnaVNFamdiVU1xa2ZTQXZlY1BPUHRER0w4?=
 =?utf-8?B?dmUyMzJZMUxTQ2hIRVV2MkkvTU83a2VqaTV3TVUzc1hrNllaeEVac3RMdTVR?=
 =?utf-8?B?eVU3ZVF4eHFHRU9TNWRlOFZ6RUlraFF5a3YvWkxqTk5UcjNRa1NWb09UZGpm?=
 =?utf-8?B?RmtqWTlLZWw4ZTFPbE42MHJveHFzVlorNVJKcnN0cUFNVVBpZCtPc0tTbyt6?=
 =?utf-8?B?d25DK2dFOXdjWmpSQnNGL0xLUXB1WENYY0o1c3NWK1M1M2RvUHI5YmJOU1h4?=
 =?utf-8?B?ODlWNC9WY1RUUHpLcUJ2UmRkWUVZL3dUM3h5ZjlIVzhPWjhodXptR1pXZS8y?=
 =?utf-8?B?dzlZMlZsV1lMRDVPdklzRkJ3aGFVeTNvcC82UEJuR2tDLy8yQWl3Vkt0UVZL?=
 =?utf-8?B?ZU9Sa0Z1WG8rVzhRbGk1U0IzYXVnbThvSU11VVZvNUx6SGZoOEI0VHBJOXZx?=
 =?utf-8?B?V1FrcWo1SU54TkdsekkwUmh4TkNLNTczMDh6eGJORTFNWTN1NlViUGdFN0ZP?=
 =?utf-8?B?SWlDTHRvTEgvWXE1VFlheDM5UndyTDR5RTlHMmt6aFg1U3RmT0tuTFl6b1RX?=
 =?utf-8?B?Rmc4a282cW5tRWJpVW1LUGZuZHF6cG5nMU1udzg2R0NnT2xkVStMMitMZ0Zp?=
 =?utf-8?B?cmlqYUN2WVdqaURMdFRHRjM2WXd5aFRYeGsyRUtrYkt2NE1YYkxmNENHNGYw?=
 =?utf-8?B?Tk9Qd2tna2xBRHZXLzdXSmZPcE9yVW5JbU5CclZ5Mkl2MWpkeUUwajNmNHY0?=
 =?utf-8?B?T2NyUjNka3FWak4ycjhpcEZCM3BERWIva24zcHNIZ1BvMGxjbjZVaHVrc3RE?=
 =?utf-8?B?S25IUVZ0WWhsbVdWSHRXTzNqY0FHcWx2WVBvTVN6cmpoblpsZUJ3bjlIWXZM?=
 =?utf-8?B?VnRuTGZhZHljSmdyQnpyZTFqVkkwTjRLaHlORWY2azNhYTdLMGhEZWV2bVcz?=
 =?utf-8?B?VlVScmJnM0RkMXdqQmVQWEdrL1B0RnJXK3AwNDdGMDhZOEZSeXlmUldVYVNV?=
 =?utf-8?B?TTB4bDQxckhUbTBKY2tJbEhmaHJHSHFFZ09qdHBzUVN1U3d3M3h1cVJCOVJu?=
 =?utf-8?B?d2x5cWFDRzYvYWJVMGZKWE5OWU1mUjltTFRiY0p1eTcxUXBTZHZrVWxvL29y?=
 =?utf-8?B?V3FqNjhOUWt2UUdsLysvK2NXSW8yMW96cFRQc1BMdUI0Y3hHWGdmc2pDbDIr?=
 =?utf-8?B?K3RmdFk2NXpOR0xQelV6RStXYXpZKzFOWXk0SHFNV2E5MlpnVWtmR0sweEZ0?=
 =?utf-8?B?VjBRNlZTUzY0UFFNMzZhdVFOTStWMFNGWTNWK2YrYTEzVnZPd0R3dkZueFdi?=
 =?utf-8?B?aXVNZEF0cXpqQlQ2ZVNOaGM5b2JWN2l1VmxiWHBtK1lZSXNDM2F1V1Mra2Vn?=
 =?utf-8?B?REJOamRaTUdkSkhhaU5BaVR0MXNSRi9BM0RtNllPaHpNeGVwSCtDQlhnOEw3?=
 =?utf-8?B?NUxkbDFuZlBrbDJ3RUVhMEpleDZBOEtzNElpV2JOb3NhYXF4R2I5VmFtVVll?=
 =?utf-8?B?NHFyWFZFSG1FOTd3TFIwdUFjT3V6Q3l3ZXF0WFVFcThpQTdsdjNUM3E4YVlE?=
 =?utf-8?B?VlZGLzV1cjk5SXVyMzhwVHA3L3JuaWFBZVZjVzRYZnZ5QmVPdE5DKzNxVlRV?=
 =?utf-8?B?azgxb3NoYWMxOGxibDF3ZExkT082YTFIbXJKZjRLRGN4VUdXR3ZEMTZGc0d0?=
 =?utf-8?B?S0dnR0RyREYxWXEvKzlERE1TRjhaQlNPQndQeTMvbzRncWlrUVpBTmRFVFhw?=
 =?utf-8?B?Q0JKVGpRLzhuSGk3RUpKMkt3YWRNT3ZUcVpYQ2RoY0o3OVprb0JOTlg1UWZP?=
 =?utf-8?Q?7FJb1q30EuA3OCBzDCq4Fup/qt2s1LL6oxhOg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1BC23522656AC45BA71880A256CEFDC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LcfaA8UnPes1lrqSWxe9kI43a+2mK5ByV7lGv2nnqv/rT4cBbxFfasB8BYQGoXR+dYyqXGRWoAry9EXHCGq+0tG9ScUvnSB/0GWneHM7dtDr87rikJqe1qQqKe0FcLIpAeljoaK+wKao1kB/kgXQYngOhCWTmbpOBeL8NdID2YVQcthpC7K1dfjgN5aILNhP2pOKKYDKr3JRJqf/+9r8jhaYP7B6/vpZccd14aNzvD5lJk10e0HYGJ6wApOjODKD1s4n5KhiP332aBTLGW9KUnckRd5x345EiyBjzohRwDbMLVNzQy14cxaLbQUyExHsmqNV/8kUfZdykwzmdBfiww==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fdf424-bd2b-4959-655f-08de7ed20c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 18:22:54.6698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0u5BGIBo+yMDYL4sp7vmVXdi2mJINzmoGLJo15pWiT+SMD0M1ExA01CXGCqKyqW5ByoLGwx0OJAdJWrouGkHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4341
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Qy_OYqVp8UMplMgPjdYK_VNJAKZowuUZ
X-Proofpoint-ORIG-GUID: VBUoYBkaeSRTjYiuAQO8IALkzlJS9Q1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE1NyBTYWx0ZWRfX26k4MkFF3+wi
 mAQsXVImpE5hrSbhXp4+198Ias5lx7j+t4fcAUY5yqzxjjmz5uj1c3+LldcenbjP3UwqralRk7r
 gzOdxa/KTqFg2uUPOpydIxIDKjIlH9O5v8pjW+gYepM5FRZ2I8VhSi2iO18ESwqWSsovl6MSk6z
 nv0xyG3FHKCA4e8TPV/btTzVUvsDeKP5fhggXwUueYW/i8Uv9QrzGgvD0la4wbIIgrCpxlwv/H+
 OLsMWFrM0f4Fko2QOt2NeyX+qjDOTdHl3myLNw6kl5vNAieGyUPvMja40+t4cW+2gu4t1FsWTQw
 AYqg7mRLXGDHH06JNl4l7ilggpRQtxqFCqKSQghWinfsJotC5t27QzQ91k+2DoNZhvRlTR97CMM
 d0OZ/WFZUHlWFQW/wCzXZ4Kxz4gXu0MahDj9JJa4BtrrHv8a2QKpOTgereUluKJmi8grkZPROPk
 e3LyZ4Soj8vJP3rs7zg==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b06181 cx=c_pps
 a=Pvk2fBMKoGc+EtVHRePnOw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=zoaFoN3qpqxLZfDP7KMA:9
 a=QEXdDO2ut3YA:10
Subject: Re:  [PATCH v2] libceph: Fix potential out-of-bounds access in
 ceph_handle_auth_reply()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100157

T24gVHVlLCAyMDI2LTAzLTEwIGF0IDE1OjI4ICswMTAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gVGhpcyBwYXRjaCBmaXhlcyBhbiBvdXQtb2YtYm91bmRzIGFjY2VzcyBpbiBjZXBoX2hhbmRs
ZV9hdXRoX3JlcGx5KCkNCj4gdGhhdCBjYW4gYmUgdHJpZ2dlcmVkIGJ5IGEgbWVzc2FnZSBvZiB0
eXBlIENFUEhfTVNHX0FVVEhfUkVQTFkuIEluDQo+IGNlcGhfaGFuZGxlX2F1dGhfcmVwbHkoKSwg
dGhlIHZhbHVlIG9mIHRoZSBwYXlsb2FkX2xlbiBmaWVsZCBvZiBzdWNoIGENCj4gbWVzc2FnZSBp
cyBzdG9yZWQgaW4gYSB2YXJpYWJsZSBvZiB0eXBlIGludC4gQSB2YWx1ZSBncmVhdGVyIHRoYW4N
Cj4gSU5UX01BWCBsZWFkcyB0byBhbiBpbnRlZ2VyIG92ZXJmbG93IGFuZCBpcyBpbnRlcnByZXRl
ZCBhcyBhIG5lZ2F0aXZlDQo+IHZhbHVlLiBUaGlzIGxlYWRzIHRvIGRlY3JlbWVudGluZyB0aGUg
cG9pbnRlciBhZGRyZXNzIGJ5IHRoaXMgdmFsdWUgYW5kDQo+IHN1YnNlcXVlbnRseSBhY2Nlc3Np
bmcgaXQgYmVjYXVzZSBjZXBoX2RlY29kZV9uZWVkKCkgb25seSBjaGVja3MgdGhhdA0KPiB0aGUg
bWVtb3J5IGFjY2VzcyBkb2VzIG5vdCBleGNlZWQgdGhlIGVuZCBhZGRyZXNzIG9mIHRoZSBhbGxv
Y2F0aW9uLg0KPiANCj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUgYnkgY2hhbmdpbmcgdGhl
IGRhdGEgdHlwZSBvZiBwYXlsb2FkX2xlbiB0bw0KPiB1MzIuIEFkZGl0aW9uYWxseSwgdGhlIGRh
dGEgdHlwZSBvZiByZXN1bHRfbXNnX2xlbiBpcyBjaGFuZ2VkIHRvIHUzMiwNCj4gYXMgaXQgaXMg
YWxzbyBhIHZhcmlhYmxlIGhvbGRpbmcgYSBub24tbmVnYXRpdmUgbGVuZ3RoLg0KPiANCj4gQWxz
bywgYW4gYWRkaXRpb25hbCBsYXllciBvZiBzYW5pdHkgY2hlY2tzIGlzIGludHJvZHVjZWQsIGVu
c3VyaW5nIHRoYXQNCj4gZGlyZWN0bHkgYWZ0ZXIgcmVhZGluZyBpdCBmcm9tIHRoZSBtZXNzYWdl
LCBwYXlsb2FkX2xlbiBhbmQNCj4gcmVzdWx0X21zZ19sZW4gYXJlIG5vdCBncmVhdGVyIHRoYW4g
dGhlIG92ZXJhbGwgc2VnbWVudCBsZW5ndGguDQo+IA0KPiBCVUc6IEtBU0FOOiBzbGFiLW91dC1v
Zi1ib3VuZHMgaW4gY2VwaF9oYW5kbGVfYXV0aF9yZXBseSsweDY0Mi8weDdhMCBbbGliY2VwaF0N
Cj4gUmVhZCBvZiBzaXplIDQgYXQgYWRkciBmZmZmODg4MTE0MDRkZjE0IGJ5IHRhc2sga3dvcmtl
ci8yMDoxLzI2Mg0KPiANCj4gQ1BVOiAyMCBVSUQ6IDAgUElEOiAyNjIgQ29tbToga3dvcmtlci8y
MDoxIE5vdCB0YWludGVkIDYuMTkuMiAjNSBQUkVFTVBUKHZvbHVudGFyeSkNCj4gSGFyZHdhcmUg
bmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNi4z
LWRlYmlhbi0xLjE2LjMtMiAwNC8wMS8yMDE0DQo+IFdvcmtxdWV1ZTogY2VwaC1tc2dyIGNlcGhf
Y29uX3dvcmtmbiBbbGliY2VwaF0NCj4gQ2FsbCBUcmFjZToNCj4gIDxUQVNLPg0KPiAgZHVtcF9z
dGFja19sdmwrMHg3Ni8weGEwDQo+ICBwcmludF9yZXBvcnQrMHhkMS8weDYyMA0KPiAgPyBfX3Bm
eF9fcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4MTAvMHgxMA0KPiAgPyBrYXNhbl9jb21wbGV0ZV9t
b2RlX3JlcG9ydF9pbmZvKzB4NzIvMHgyMTANCj4gIGthc2FuX3JlcG9ydCsweGU3LzB4MTMwDQo+
ICA/IGNlcGhfaGFuZGxlX2F1dGhfcmVwbHkrMHg2NDIvMHg3YTAgW2xpYmNlcGhdDQo+ICA/IGNl
cGhfaGFuZGxlX2F1dGhfcmVwbHkrMHg2NDIvMHg3YTAgW2xpYmNlcGhdDQo+ICBfX2FzYW5fcmVw
b3J0X2xvYWRfbl9ub2Fib3J0KzB4Zi8weDIwDQo+ICBjZXBoX2hhbmRsZV9hdXRoX3JlcGx5KzB4
NjQyLzB4N2EwIFtsaWJjZXBoXQ0KPiAgbW9uX2Rpc3BhdGNoKzB4OTczLzB4MjNkMCBbbGliY2Vw
aF0NCj4gID8gYXBwYXJtb3Jfc29ja2V0X3JlY3Ztc2crMHg2Yi8weGEwDQo+ICA/IF9fcGZ4X21v
bl9kaXNwYXRjaCsweDEwLzB4MTAgW2xpYmNlcGhdDQo+ICA/IF9fa2FzYW5fY2hlY2tfd3JpdGUr
MHgxNC8weDMwaQ0KPiAgPyBtdXRleF91bmxvY2srMHg3Zi8weGQwDQo+ICA/IF9fcGZ4X211dGV4
X3VubG9jaysweDEwLzB4MTANCj4gID8gX19wZnhfZG9fcmVjdm1zZysweDEwLzB4MTAgW2xpYmNl
cGhdDQo+ICBjZXBoX2Nvbl9wcm9jZXNzX21lc3NhZ2UrMHgxZjEvMHg2NTAgW2xpYmNlcGhdDQo+
ICBwcm9jZXNzX21lc3NhZ2UrMHgxZS8weDQ1MCBbbGliY2VwaF0NCj4gIGNlcGhfY29uX3YyX3Ry
eV9yZWFkKzB4MmU0OC8weDZjODAgW2xpYmNlcGhdDQo+ICA/IF9fcGZ4X2NlcGhfY29uX3YyX3Ry
eV9yZWFkKzB4MTAvMHgxMCBbbGliY2VwaF0NCj4gID8gc2F2ZV9mcHJlZ3NfdG9fZnBzdGF0ZSsw
eGIwLzB4MjMwDQo+ICA/IHJhd19zcGluX3JxX3VubG9jaysweDE3LzB4YTANCj4gID8gZmluaXNo
X3Rhc2tfc3dpdGNoLmlzcmEuMCsweDEzYi8weDc2MA0KPiAgPyBfX3N3aXRjaF90bysweDM4NS8w
eGRhMA0KPiAgPyBfX2thc2FuX2NoZWNrX3dyaXRlKzB4MTQvMHgzMA0KPiAgPyBtdXRleF9sb2Nr
KzB4OGQvMHhlMA0KPiAgPyBfX3BmeF9tdXRleF9sb2NrKzB4MTAvMHgxMA0KPiAgY2VwaF9jb25f
d29ya2ZuKzB4MjQ4LzB4MTBjMCBbbGliY2VwaF0NCj4gIHByb2Nlc3Nfb25lX3dvcmsrMHg2Mjkv
MHhmODANCj4gID8gX19rYXNhbl9jaGVja193cml0ZSsweDE0LzB4MzANCj4gIHdvcmtlcl90aHJl
YWQrMHg4N2YvMHgxNTcwDQo+ICA/IF9fcGZ4X19yYXdfc3Bpbl9sb2NrX2lycXNhdmUrMHgxMC8w
eDEwDQo+ICA/IF9fcGZ4X3RyeV90b193YWtlX3VwKzB4MTAvMHgxMA0KPiAgPyBrYXNhbl9wcmlu
dF9hZGRyZXNzX3N0YWNrX2ZyYW1lKzB4MWY3LzB4MjgwDQo+ICA/IF9fcGZ4X3dvcmtlcl90aHJl
YWQrMHgxMC8weDEwDQo+ICBrdGhyZWFkKzB4Mzk2LzB4ODMwDQo+ICA/IF9fcGZ4X19yYXdfc3Bp
bl9sb2NrX2lycSsweDEwLzB4MTANCj4gID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTANCj4gID8g
X19rYXNhbl9jaGVja193cml0ZSsweDE0LzB4MzANCj4gID8gcmVjYWxjX3NpZ3BlbmRpbmcrMHgx
ODAvMHgyMTANCj4gID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTANCj4gIHJldF9mcm9tX2Zvcmsr
MHgzZjcvMHg2MTANCj4gID8gX19wZnhfcmV0X2Zyb21fZm9yaysweDEwLzB4MTANCj4gID8gX19z
d2l0Y2hfdG8rMHgzODUvMHhkYTANCj4gID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTANCj4gIHJl
dF9mcm9tX2ZvcmtfYXNtKzB4MWEvMHgzMA0KPiAgPC9UQVNLPg0KDQpJIHN0aWxsIGRvbid0IHF1
aXRlIGZvbGxvdyBob3cgeW91IGdvdCB0aGlzIGNhbGwgdHJhY2UuIDopIFRoZXJlIGlzIG5vDQpl
eHBsYW5hdGlvbiBvZiB0aGlzIGluIGNvbW1pdCBtZXNzYWdlLg0KDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBSYXBoYWVsIFppbW1lciA8cmFwaGFlbC56aW1tZXJAdHUtaWxtZW5hdS5kZT4NCj4gLS0t
DQo+ICBuZXQvY2VwaC9hdXRoLmMgfCA4ICsrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9jZXBo
L2F1dGguYyBiL25ldC9jZXBoL2F1dGguYw0KPiBpbmRleCBkMzhjOWVhZGJlMmYuLmVlODVjNWU0
NTc3MyAxMDA2NDQNCj4gLS0tIGEvbmV0L2NlcGgvYXV0aC5jDQo+ICsrKyBiL25ldC9jZXBoL2F1
dGguYw0KPiBAQCAtMjA1LDkgKzIwNSw5IEBAIGludCBjZXBoX2hhbmRsZV9hdXRoX3JlcGx5KHN0
cnVjdCBjZXBoX2F1dGhfY2xpZW50ICphYywNCj4gIAlzMzIgcmVzdWx0Ow0KPiAgCXU2NCBnbG9i
YWxfaWQ7DQo+ICAJdm9pZCAqcGF5bG9hZCwgKnBheWxvYWRfZW5kOw0KPiAtCWludCBwYXlsb2Fk
X2xlbjsNCj4gKwl1MzIgcGF5bG9hZF9sZW47DQo+ICAJY2hhciAqcmVzdWx0X21zZzsNCj4gLQlp
bnQgcmVzdWx0X21zZ19sZW47DQo+ICsJdTMyIHJlc3VsdF9tc2dfbGVuOw0KPiAgCWludCByZXQg
PSAtRUlOVkFMOw0KPiAgDQo+ICAJbXV0ZXhfbG9jaygmYWMtPm11dGV4KTsNCj4gQEAgLTIxNywx
MCArMjE3LDE0IEBAIGludCBjZXBoX2hhbmRsZV9hdXRoX3JlcGx5KHN0cnVjdCBjZXBoX2F1dGhf
Y2xpZW50ICphYywNCj4gIAlyZXN1bHQgPSBjZXBoX2RlY29kZV8zMigmcCk7DQo+ICAJZ2xvYmFs
X2lkID0gY2VwaF9kZWNvZGVfNjQoJnApOw0KPiAgCXBheWxvYWRfbGVuID0gY2VwaF9kZWNvZGVf
MzIoJnApOw0KPiArCWlmIChwYXlsb2FkX2xlbiA+IGxlbikNCj4gKwkJZ290byBiYWQ7DQo+ICAJ
cGF5bG9hZCA9IHA7DQo+ICAJcCArPSBwYXlsb2FkX2xlbjsNCj4gIAljZXBoX2RlY29kZV9uZWVk
KCZwLCBlbmQsIHNpemVvZih1MzIpLCBiYWQpOw0KPiAgCXJlc3VsdF9tc2dfbGVuID0gY2VwaF9k
ZWNvZGVfMzIoJnApOw0KPiArCWlmIChyZXN1bHRfbXNnX2xlbiA+IGxlbikNCj4gKwkJZ290byBi
YWQ7DQo+ICAJcmVzdWx0X21zZyA9IHA7DQo+ICAJcCArPSByZXN1bHRfbXNnX2xlbjsNCj4gIAlp
ZiAocCAhPSBlbmQpDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1
YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCg0KTGV0IG1lIHJ1biB4ZnN0ZXN0cyBmb3Ig
eW91ciBwYXRjaC4gSSBhbSBzdXJlIHRoYXQgZXZlcnl0aGluZyB3aWxsIGJlIE9LIGJ1dA0KYW5v
dGhlciBjaGVjayBhbHdheXMgbWFrZXMgc2Vuc2UuIDopDQoNClRoYW5rcywNClNsYXZhLg0K
