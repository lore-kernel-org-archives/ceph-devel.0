Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8908460
	for <ceph-devel@vger.kernel.org>; Mon,  4 May 2026 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918924; cv=fail; b=o+N3vAP3L8M8Cn1p/VvwNtfFd3KiLTYWiIO5nsofuI5zn9/GZbDbzDLQm5Y5KvGpk7FwOB9IPK62zTyJAwt6jOp7ztOxKQdzjojSoQlutQTzLhS9ZFZYjlASwNbETavdy2KDgZYLUByOt5rhRuJzeQZePtgmV3E4KN5awNIaYso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918924; c=relaxed/simple;
	bh=42Vt2vMmA9HIdNx0u/zM9uRYpJ+9YwznR0l9BhZHpDQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=HIlrlJX4zcGjM8PtLhI7JaFy0h8krRajCTxioES2EA1jVzv4lS0IMz8ZKkD6PBgMkGDlhnKu2s1A0We4LvPyvkoa2rjPKLzZve0jzp/3IiuKyAsrv4bdDHfKF/Wu/xVQ1/8DV3ErDSPzhm2VeUPcqXsvkqbjSczvZ8bZoZqlEFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JY+gVm14; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JY+gVm14"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644ExdeA3010004;
	Mon, 4 May 2026 18:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=42Vt2vMmA9HIdNx0u/zM9uRYpJ+9YwznR0l9BhZHpDQ=; b=JY+gVm14
	28Pq6/PusB95IJqUOstVkRlr/y6UGBiu2yKmRc4M0BLGTYfxRbKlyCFuEa7FzPrX
	tDCAIzNxq+hADSO36IGVE4WxfyD/Og+v+95jx1SZU+Qj4wrkxCY5e3LC+fDJk9q2
	4KEBQAlO5w2QpDRh70jbA6ZeaKW+9NwDk9C3NP8Pf2tjUm3AUBsQvbbvZ48ypVP+
	jF2p8pZSunY5p/R5IEjaOADCnXyPYJyl7kia+WuYkqIzYwyjw4+NYFPCWsIqW4ld
	kk4zlLQkDZa2VMP3BtU4vK0rQO+2ZBod11I9qt8k4u54P6XtoYgPNg28hlSGpNeB
	k8BwRFqio3rmUA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v78dk8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 18:21:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZyaeTcXLOSUvealMTBKWUuR2q4ksldp8upe+HgWZuKXAMLCNstj0OwCBkkFzLmZVkcRvPLlFK6DcuPzSTB6ojRv0MWBdZq03zLrvLl9mE4yOsTxOBiEGI0yvrkSDZ+Tnn7tRr3t/RDPCa5kjGM6SAgoTO6KEBb2zgcLOa6uldGTzOFk/+N2NtPwA+vMZZHuRGPkhTkRDyvSRYSPh2tZCGd/yy5us1aL7XPHLTTbv6HWvaBILnJP9XnbNlwkD9Z2fXkny7MPFnH/bWV48Yhc5LKkQDpKVsOcuAYvdXSjSV+2dq06POG9p5ce41DMbMK0O/vCAXp3aEgHfqJzO0vPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42Vt2vMmA9HIdNx0u/zM9uRYpJ+9YwznR0l9BhZHpDQ=;
 b=HFOFTdxDLPehS1lhEpR9B3UjfVSjoNh65NasyUWpJWTXmOfd88C9fVs4kv8kAGOvMC5lW/gzhcFHGkXceA/zaHNh4+pOGG0kgeDv2veRwfz7JlRhvjHxg7rJYJ5KSMVmI4EF66JAuTr9jfwNqgTvgo7Q64ZIqUS5HMrPueivzFx/URPx6DLAmhd1vxHXZXiwFmWJrOTdGBEuqR2bkQYDwcNUYO8JFuVkQJlr0+LRpkNuUmN4JI/EbNpB0lCyORi/YJblHyA488twCoNhgc3+dBmwSCuH7UlkkcEEjukRy0G9Oc/tgebbPp+tG4Os9Y0LNfeiqsd5Lh8C1DARFlSJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS3PR15MB6979.namprd15.prod.outlook.com (2603:10b6:8:348::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:21:51 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 18:21:51 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "hristo@venev.name" <hristo@venev.name>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>
CC: Alex Markuze <amarkuze@redhat.com>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] ceph: put folios not suitable for writeback
Thread-Index: AQHc2+gsrwEw1ALeXU6alFJNfhmUzbX+Le6A
Date: Mon, 4 May 2026 18:21:50 +0000
Message-ID: <f6c8cf0d2e330dd7e41ade8574507d4d56aa71fb.camel@ibm.com>
References: <20260504155450.1892761-1-hristo@venev.name>
In-Reply-To: <20260504155450.1892761-1-hristo@venev.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS3PR15MB6979:EE_
x-ms-office365-filtering-correlation-id: 912a0877-fd14-4101-567f-08deaa0a02f6
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 7WE+8hOmOr63hhHDuGCLlJin/6Lq9rhngR6Ld/Bf48XAz6q+93zv4omC8LSC6J9P9smNPnUNR1LqG30VWAgqelQX3wZb3FpOLP0aSYk1iDGXvRoKQTSlT6JCPs0t9JsepBjczYij0vwexDgO/bgVSI5AZXjTy1ieBL3eM3LfKDwKGA1sUiKFVlPYsj7U+1t4jKvxT26GNPzEiS4wJOj97Vrlz/vRAnkNeRXD7pRGGAgcgBnQ8cVPIrv2lncg3MO7Jwz9n3P3ql2RrN4ihF6//HjK1930WIc9Bc18OW6vf11hwukputQ1iepbCNmgcsR3aRaF9FUTBNZCRVIzCICzI/Qn3PalgoHYu+lNbqqCdRNRmmXIjg2eKYtTO4955lwe014/omPSkgGPH/hWHbZoiyeLQEApT/c/rtYBGsySkx/YSB1YLjmp/xYRAsAnYlCsFQHQJM0dEa6TuZHAQyvfo42tzLTEdNwLXgpc/VsCJCj3V21FjAvBR/NUeu8x4w2o10iyJuNYmHUvtGTh4bA3FT+rlkM9RkA5pi+CMillu8cRR/5rrd7KdxUkxvLftON+qMNIT9paMhRvfsZDauQCgE52vra08jbHtXkxBuWc02Blgz807THRNerNRJYxlUcyZeBw9AMT6T6w8/EkCSSTxgcOvy/7FPSvywtXaLS7fzlVgOlXXUkwRIa/nda6yeCEpS0v8EQ45K9hg9/jowOeNw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXhhbU5KdWg4YVhaMkY0clhvdzE2OGIvMmoxaTI2ZFlNYkZScmxJcnpTSjNl?=
 =?utf-8?B?K0I4RUI2TU9EcVhxR25tN1A5R3ZMRVRWUmhpNVNWY2pib1JwZDVLUFBjVUtz?=
 =?utf-8?B?bXZTalN1S1ZrWXhTUUdDaFovdEpydGJGaUZZYlA1ZUJ0UnUyVVFuRWRXb0xq?=
 =?utf-8?B?ZlJnMnlkdWpiR1VXaWJxb2lsS3RKYmtHY2tRSVQ3UllRRDBKU2xsVEd1UFh1?=
 =?utf-8?B?MjFjZ1cvc0ozMnZLbTlEVHhOWmRHT1lDdVFaQ1Roam5lTkVtTDdBaUdoeDFx?=
 =?utf-8?B?WG5xbkh5VGQ1SzVvaVdqOGIwalJtZHZ5c0c5eExvRVl1Nm9mbXUyRHM2MExo?=
 =?utf-8?B?Yy9zTDIwMktHWXN5WThWK284YjlUZVFNT0RVWGlsVWY5Y1RFSlA0alJxUkJM?=
 =?utf-8?B?VXVBMHRnaEtSajd6QklTcWRRVDlTTjZ2YkZxOSsvM1kydENrVlBwQ3FlUzhV?=
 =?utf-8?B?L2NqK2hNb3JPMnRWaWJyQ3Q5VHluejVLbVRiN21jV096TnF4WkpGYkZpMHhs?=
 =?utf-8?B?ekU2NkdvOVorbVB5WHlMblk2UzJpdklSWXU3RmNwdlEvNzhwditDYnE3aE5y?=
 =?utf-8?B?aXlVdWloMVZBNWswQkIrRzVaR3h4bEJXOXdiWE9Yell3aklhMDVoNnFnOGNJ?=
 =?utf-8?B?cWl0ck84K3JnSFpGUkljL3pTYUdJRjhOSzlGMkJYdnBTdmVFVTRmRFlhWlJ1?=
 =?utf-8?B?OVd4ZDhTTXlRRkxpOGlDMnluL3ZXUUhYUm82Q2NnWldiTUo1cW5ocERXNXdX?=
 =?utf-8?B?cUNoTEFVc2ladG1NczJIbVNBTnFuY2NKMUxSSnJvTFlLZ0FqaWpRd1I0d1lh?=
 =?utf-8?B?MnpUUE92blVzbFpDQ3FQT1RHRTN2ZzZVUHhMSnBWTUdHYXJCeFhWSG82QjRk?=
 =?utf-8?B?a2tqeDhCc2lCY2VQY2QzQW9Wbk5rblExbXZnWmoweG80NHFtUHFyU2YzZEdu?=
 =?utf-8?B?WWVjNWVYNDFQT3hoMmpCblJhYWh1Zll5eG9LRk00eDRYY3U1OVJBQjgwdmpZ?=
 =?utf-8?B?YUhDd09DOE1pSGdYLzJ3SkNpb0QzQnluYXBqMVFvNHNjM2FQZFUxSnFsUFEw?=
 =?utf-8?B?bUxkeUZTbncrR2xqSGZaMktCcVNPR1pVcnJHYkN2KzNjTGl1UEhoRXdBU1F3?=
 =?utf-8?B?RHZpblduZWhUWmFJSExoWFhVZEgrNzhadzFUdVZHc2swbmg0NnBpM0NkSkpM?=
 =?utf-8?B?a0VNZjQrREptdUlYNUhEY0dmakxBVGtsU1dFYUsramJoRXNwTWRQSzkwZWY5?=
 =?utf-8?B?US9DTTNhVGZMd1Fsb1JiWktWaktmRzBEa3hHem9kT05ZMUp2bVRsMGh4UmFJ?=
 =?utf-8?B?YWRCaGpjU2F1K3dFYVpxbkZnU2tYc1M3dWt4Y2JmM3AvZDZwRDB4S2hrRSsz?=
 =?utf-8?B?TWIrQnh5c1ZLVzBVeW5KRzZ4T0doMUgvSkhacDFLZ0ZOOEVHSWUvdHlMUXBX?=
 =?utf-8?B?STZxM3hCR3hrbWdRODhLanBVZlZrTjlwWXBWVmxsMUFNaUpab0Y2c29sM3Vy?=
 =?utf-8?B?U0xkWE1WdldXMlNGd3o1ZEhSTkp3YzJ3dXlVVjJpMmVFWmxLRFEzSllndThk?=
 =?utf-8?B?MEt3T1ZKamxldUo2ZXh4c3Foblk2eGdGWXE2NzIyT3NOT1hHbDJJTTNwcnhr?=
 =?utf-8?B?L09IZVJ2Q3BHNlM2eFc5cXNEeHFCQVYvWnN2d1FhREJoeTR3S0ZlY0R6V1h5?=
 =?utf-8?B?OXhFY2I2cHRpVjRkOWlJRWlhYVFsSExkYnM1Q2xOMEd4RGgvaG5XKzFlOTVN?=
 =?utf-8?B?S2ZXVHNsNnFQanptYlVpWXo4MkU5V3hNVmdYZ3NWZmNrRUNkNzJQSWJZeWk3?=
 =?utf-8?B?MDQ3U1RRNXVjd2RGU0o3WkVNOFJDVWRtWE1GcWZpcTBnOEtkbzN5SDZNcFAv?=
 =?utf-8?B?b1ZVQXJVSlB5cEdYYVF5WnB1djFoalIyV2VJWVpHc29ESmN0MjRGNlBHanBl?=
 =?utf-8?B?UVRTL2F3M1ZLWHhSYWM2Tk5ReFBSQndJV3lBZzY0THZja0JEQnlWKzgvUjBx?=
 =?utf-8?B?Y2NGMEo1QzhtQXRPSzVLaDlNYm9SRnZlTU9aQWJJOTFtdmJyeWpzajIzZ1Zo?=
 =?utf-8?B?dHNzMnlMRC8wdVhWMjgzSDQ3dW1rYmtkb3ZBTTJJVFRnWEcwVFFSK2dtNXpq?=
 =?utf-8?B?L3J0UWNlQnVFQ1dJd21FRkQ0S0QrU3lrUjhVQUNoV2pDZzZpZmp0d1FTVWpY?=
 =?utf-8?B?M05ZaHRTaGgramg5NlBiK21qKzBiYlNodXBuekJFM0RSWVRBQTNMSWllcERC?=
 =?utf-8?B?eXg1UHFPTm1FL2lPYkFHaDd0OHB4WjNsT0FFVWZzeDBuK1pnRjl5VVNtUnBt?=
 =?utf-8?B?bldJaUhPbld2aVBTazB1VFVNTDk5RHE0YlF4eCs5WFhzTkJHMGJxbDFzSHRw?=
 =?utf-8?Q?Bu6mRloMzB203DIgxnp5hF6NgRRYm028UjKvo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69BFBEEE8AA52E4CA069D9D3690DC8D0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	otSrixUEcpJ7H+T5AceOWKtEa1m/nnuFsx2hRCDwMO5NDu/0QScqDxEg2HJseeCCnbI8us4gjkxN8u3djqyJHVZI2Y/S1FDpEBl9NqWWpStQuspx8U1OxvZ6MW4uddJDbmI/GAGusoGBlYutlvGWAsVhc56uxfO7JXeoR/x6SFidDl4lvFBKVN2RPEoMghCEVwYLhArXjckPMgboy20RDyS4W7/99EIBOQPzlwW8puG4iDG3OG4zcuOYs43XJfvI84WBLrrUWIMgUaVbv46+X6cTkDtpbPbxWILLFuzF78x41MXnn1VwF0FmtemH8BVUlFbtezj35YrIonLsHxWUSA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912a0877-fd14-4101-567f-08deaa0a02f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 18:21:50.9187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NKnZYc/5YFvKOkrzgTaItnW9CIdZIrN80xCvNL/u6ZbriBsgbnbVVHXwQV8Ws9P01bHnWypbWfgFVSkYOxeNQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR15MB6979
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE2NSBTYWx0ZWRfX6Cd3ZF+kqJjL
 fSSj7EuueFLd6dNkddVUowqZ+IEObqYp7R0GKchnlHgIsWbRfliYTDKoWzLRl1Bx48p1+S/cDB0
 eCtml7XsKXSEMCZBfwTk0j/qgCegQcKBTsgekrgr2LptTNNrNarLDI2DxNPqY8fxyNYQLJfD0df
 4Vq6VNObS1CEpiVtXqvfH7YfMtRVOfM0rzUpAueMUbjdMPfoG2paeQ/bUIgeRacuPAY1SksD7hf
 lcBc3YQDIJe2WPM8l+btTiIa0rMRmgngE5bTu0TY1GG22Lht4F4IohUtOynECreZnlBYAUQ30WR
 jQCPrZCcJpDyih++FhYu6q2DIbrxHhuXQ80Z91QrzAbSdvgVVGzoTlrtPnadGOdpm3qr59oKW1t
 F4knA8T7WSjeyBvgUoqy79BGinDHJeLDxhbxdR6Zqyu3qBQhCiLqujP+5qlbLUreWdNoeW09U6g
 wWiSVVvwDhCwT+McesA==
X-Proofpoint-GUID: M9qbX1H4EhOR1MyPoZdO2V-WajQOg1Co
X-Proofpoint-ORIG-GUID: IeT6NeGVEBM2qcUdE-9RyKnebav4aTng
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f8e3c2 cx=c_pps
 a=J6o3koRVWeMoKD0aP1wsjw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=4u6H09k7AAAA:8 a=VnNF1IyMAAAA:8
 a=j8b1actZJrRzDqVh5EIA:9 a=QEXdDO2ut3YA:10 a=5yerskEF2kbSkDMynNst:22
Subject: Re:  [PATCH] ceph: put folios not suitable for writeback
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040165

T24gTW9uLCAyMDI2LTA1LTA0IGF0IDE4OjU0ICswMzAwLCBIcmlzdG8gVmVuZXYgd3JvdGU6DQo+
IFRoZSBiYXRjaCBob2xkcyByZWZlcmVuY2VzIHRvIHRoZSBmb2xpb3MgKHNlZSBgZmlsZW1hcF9n
ZXRfZm9saW9zYCwNCj4gYGZvbGlvX2JhdGNoX3JlbGVhc2VgKSwgc28gd2UgbmVlZCB0byBgZm9s
aW9fcHV0YCB0aGUgZm9saW9zIHdlIHJlbW92ZS4NCj4gDQo+IFRlc3RlZCBvbiB2Ni4xOC4NCg0K
SSB3YXMgYWJsZSB0byByZXByb2R1Y2UgdGhlIG1lbW9yeSBwcmVzc3VyZSBpc3N1ZSBvbiA3LjAg
a2VybmVsIHZlcnNpb24gYnkNCnJ1bm5pbmcgYXV0byBncm91cCBvZiB4ZnN0ZXN0cy4gVGhpcyBw
YXRjaCBoYXMgZml4ZWQgdGhlIGlzc3VlLg0KDQo+IA0KPiBMaW5rOiBodHRwczovL3VybGRlZmVu
c2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX3RyYWNrZXIuY2VwaC5jb21faXNz
dWVzXzc0MTU2JmQ9RHdJREFnJmM9QlNEaWNxQlFCRGpESTlSa1Z5VGNIUSZyPXE1YkltNEFYTXpj
OE5KdTFfUkdtblEyZk1XS3E0WTRSQWtFbHZVZ1NzMDAmbT1mR0VDVmg5T0l3Tk5OeWJjYnp0QXFW
RnFNSkFvRUtUbW1qZ1h3SU1YNjhONldiMlFSZFB4S01CRF9vMmRvZnlGJnM9MW9UdTJwSjYzem5H
VGdacElvbzNSQ3ZHUGE1MHdZNGxuTDNwYXhkemJfTSZlPSANCj4gU2lnbmVkLW9mZi1ieTogSHJp
c3RvIFZlbmV2IDxocmlzdG9AdmVuZXYubmFtZT4NCj4gLS0tDQo+ICBmcy9jZXBoL2FkZHIuYyB8
IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9mcy9jZXBoL2FkZHIuYyBiL2ZzL2NlcGgvYWRkci5jDQo+IGluZGV4IDE0NTQ3NjAzMzJm
Zi4uMGE4NmY2NzJjYzA5IDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2FkZHIuYw0KPiArKysgYi9m
cy9jZXBoL2FkZHIuYw0KPiBAQCAtMTMzNiw2ICsxMzM2LDcgQEAgdm9pZCBjZXBoX3Byb2Nlc3Nf
Zm9saW9fYmF0Y2goc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsDQo+ICAJCQkJCQkgIGNl
cGhfd2JjLCBmb2xpbyk7DQo+ICAJCWlmIChyYyA9PSAtRU5PREFUQSkgew0KPiAgCQkJZm9saW9f
dW5sb2NrKGZvbGlvKTsNCj4gKwkJCWZvbGlvX3B1dChmb2xpbyk7DQo+ICAJCQljZXBoX3diYy0+
ZmJhdGNoLmZvbGlvc1tpXSA9IE5VTEw7DQo+ICAJCQljb250aW51ZTsNCj4gIAkJfSBlbHNlIGlm
IChyYyA9PSAtRTJCSUcpIHsNCj4gQEAgLTEzNDYsNiArMTM0Nyw3IEBAIHZvaWQgY2VwaF9wcm9j
ZXNzX2ZvbGlvX2JhdGNoKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0KPiAgCQlpZiAo
IWZvbGlvX2NsZWFyX2RpcnR5X2Zvcl9pbyhmb2xpbykpIHsNCj4gIAkJCWRvdXRjKGNsLCAiJXAg
IWZvbGlvX2NsZWFyX2RpcnR5X2Zvcl9pb1xuIiwgZm9saW8pOw0KPiAgCQkJZm9saW9fdW5sb2Nr
KGZvbGlvKTsNCj4gKwkJCWZvbGlvX3B1dChmb2xpbyk7DQo+ICAJCQljZXBoX3diYy0+ZmJhdGNo
LmZvbGlvc1tpXSA9IE5VTEw7DQo+ICAJCQljb250aW51ZTsNCj4gIAkJfQ0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5j
b20+DQoNClRoYW5rcywNClNsYXZhLg0K
