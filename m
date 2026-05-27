Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A134451068
	for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904810; cv=fail; b=Mn+lioTflv1PPQ1wh6ptbSgQxfVGnouNR4N1jsO4OWxMswmHX6oIpOKZLYgjYld9kafR/yddgi1LorLMpte/8YkJc2eMAVTCKYD+ymyuyjCRdF0hmplxiJ69FAgQ4UsJ37V1OAxDv3wmAhs9cVYqD4kzGxf8tRL4ubY51sdNC5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904810; c=relaxed/simple;
	bh=gq6SHsjzB9WYKsicu+ecV/+7Gy6J6Aea8WeM8u70iKM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=vGLjsN23dxd/wB6f0Dil4obv0H0PXQd5FqptMJG419+m9K2PjUA2Hzi985diBOLnYOk5ZIgKmX6Njs7Y84R7MfzNlv47mVQkeo77XZoC2p3xRKrQXYFs70etveMOLCIaUAPoBbHW9oXJ7wsZZQ4Jut1ngSgVG/T06vaWe39kevI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vl9M9n/0; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vl9M9n/0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RD64GD3594720;
	Wed, 27 May 2026 17:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=gq6SHsjzB9WYKsicu+ecV/+7Gy6J6Aea8WeM8u70iKM=; b=Vl9M9n/0
	5W4pc3vqA+A5CvGjxjER0CUj8uCM0MuEyyFTvIDOgTariKWmI6IMct42M+4nN0VN
	Mf235N5CEljiI0lt9em4bk/fdGeofHPprf72JeFPFBHcIXTM+dbpQwCbL3bT+GZi
	rrQIhO/NM+qH9xfrHb94Me1J49OKtdCLoMlO6g/ke3vRvnpxYo90sv5ieX3ZjUpT
	VORiwf87PJr1iX9eKrBuTSHGEBqZY+8dPuTsFQQMr1n1+wsYgj1mh+9f4cbKSL2E
	e58J6L7rhQtjzz5pg0kiXQWmDx+EO/5+mmNDU0RDLOahanvoiCQpGKPJpTTHv2OA
	tSC9QPZ3MMhMUw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2jr2s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 17:59:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZU6G4WDORDExDDNPeDtv60EZyT6606bZykGpLCcExWspV3fmLPz4HsvSf8gkzcTRw25sXXM9FRocD4wlIbPhlRycIlp3zI6e9WRUQj1TYZ6Uw0NTYGZH0Cn93vpnnCDW+ThF3LhFIWLaqjjGk9TEWBTVueTJbuH/7Ae+AiB7qVM5r2UZiEUyiDGb8ov6JXdb8yJaJ2x6YYSWr7IFK2lix8lXYmfnSRoAq1PSrwgGeSo4pvuxNQLzVx7EzUGM4H3LG4TcnICY6S9qA3Fsg64glmK8chUyS0soRdVJoib5+FKxzHjwnh+HAecXq0Qbb+3Ek1DHtdvHDJp8IEjODyrQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq6SHsjzB9WYKsicu+ecV/+7Gy6J6Aea8WeM8u70iKM=;
 b=IjY9rYV9fjGtGoJ6PNr0UH9GvaWGj5T1D7ojuWFxnhglhOLqD0qdZ5tSzPUavCFZJw4dXKhaHB85Y/EVQUJxE2uNQpw0wFsqMWFsT7AOQvn47asGSVcU6YvDJ9a0Puf6bS7HBICpBD1neALxUz7T7My94ZFcRoZv2SqRmqCXeRlrAsTfvOtcE6g0vX0YaRRMOOcuzQBNWiGp75gNU1QzKxqzhFxZ48olLpd5UiTdEqwRMPy6ck6cJwKSwWdKn7LKM2T9JehZ6Za3BgiKiHyfpZUhkCEYPc7DzPVS9bv6a7mVsjQp9iy6lyIujoK0EYUxUY5p9bWVsEYUGhIfEMeepA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS1PR15MB6708.namprd15.prod.outlook.com (2603:10b6:8:1ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 17:59:46 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 17:59:46 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] libceph: Fix multiplication overflow in
 decode_new_up_state_weight()
Thread-Index: AQHc7eJKMNQXnZz0oUispRgIwDCy57YiKW0A
Date: Wed, 27 May 2026 17:59:46 +0000
Message-ID: <b6c16cd9aa7bc31240a133d68cec03ea914f918a.camel@ibm.com>
References: <20260527140617.3600044-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260527140617.3600044-1-raphael.zimmer@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS1PR15MB6708:EE_
x-ms-office365-filtering-correlation-id: 14424ae0-060d-4909-9910-08debc19bccf
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099006|3023799007|11063799006;
x-microsoft-antispam-message-info:
 i6pvDwo4S6+m6vTUOD63Kq+SfVp1E40FEr4R88een85MMYi4c5Zegq+a09mHiZOgG3w85l6Dfjm4HnjSOoIUT0sfrz70mlqyXexzWMLwgI5u22msqTth86McHivEcQAmd0szm6TtBSLsbfKGqUN9rUjkmkBv8z4rJwpMGrFcHDhlcljgzudHY3IL0r4z7INV3wzOBSqAl1Bl7E4tyJVKk/ALLNDP3XLL+pP0etWi/0C/PiD0XTnq9BuM0XXG7cb5YuRiS/vQximTdjCrW3z9no5glHGbPn0znbajiimA6j7LypcCd4zTWtJpsshhxEhBkrKTzR/sSmjYR5eDGw3VUMervh+62p7FiobWWSzNOkMgDcL2RXsbA5GGdHRuXKvjGJTJBLwU6wFpCGY435ZXHZs07Rt5bxQkRzj1Rsf95mvq6K+9OawtGeyvUuyMi3q13oPez9UVGP3pLPMm5yzFVHRhk+z9lrNd/SpVJ+9XVQY+VC6ah8+ECwEW7R7BZ3zwmvg36z1jn6SqWrOR76HeAM77VMOvDX9HRogSdq8hs1eitnNH3NkQhWzpmiRJYoixN9Z2Y7eHuIIq9jnsE73jTIHbd6La//xVa8qWgyRCR1VNI33k0cFKkiRVWUuWQLackzkCAokTsOkM++5PuoG3A+JdozuErJMRyQy0ErRpLuPJeVMFVXfyy44UDUUb7jcSzkNYZ0tu9UvR/4QFcshWa799x8fHHKzG/x1hyb/8HAg/b8aLfr5GWxUCXNePhpkr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTRLUjNNTjZibXUyNFZFcThPUWJTQ0ZjN2lad3RKS3I4Q296UWFCeDByd2ND?=
 =?utf-8?B?cnBwUU9ZMVB1YXZESnpwVGdXbGJMTFArZm5yTVdWY21kTHlKRi9WSm5oVVJW?=
 =?utf-8?B?QjZURFhuQXhCWjFFNU5YamFoY1dhWjdoNkd3bm5FWnQvMTNRYXM4bFpYZTE2?=
 =?utf-8?B?aWxJbWp0ZEMvTDZlVWFXK1IvaXVsTEkwa2IwRHhOWXVaNDJDMFlDcHh0a2ZI?=
 =?utf-8?B?TnQwSm9nRzZFM2tXdFRtWTl4RjJtR1B2RURYekZyM2tiRUtkbUlJcmdXdW5z?=
 =?utf-8?B?Z2tpb1NIcXdQR0xrUXZyd2J3YUFwa3crd2E4eVVsMFdrcCtHOG5yKzhldlQv?=
 =?utf-8?B?SFJnMHU4VmMxMDQ5K1hlc3VhU1I4S2t3MWpQcU9OMnFSSTdJOVEwVG8rem1u?=
 =?utf-8?B?cjFoWUlzRnY3T2JPUHBhdXRsZHRtOVF0WXVUTkpJMEZsME0xd0FHTVBucENl?=
 =?utf-8?B?NUp1QVFnMnorOE56Mk1nS3FIK2pBQ2ZmN3FtdWxENUpwdzcyQ2R1T2NNU09s?=
 =?utf-8?B?bkNGOXhEb3lJODU1N0ZBRlpiOVhwbzRxTHFVNDFjTFhBU3BibjZDd3JLMlM0?=
 =?utf-8?B?OTA2c1UvdVNaVHVZbUxoSzFCNlk1VC9JbGI2M0pKcUpxQUF4dExFWUpZamw2?=
 =?utf-8?B?eVVEREVXQ0phWHAyQWVsQ2lrVWFIc0NvdFRJL3RsOHdnV2hIaExJSnZjNWE5?=
 =?utf-8?B?cFAwUVJkMnlvbzE3OEpoV3N5bVphNTlUUlhXZW9TdGcycGQ1MG9sVmFVR1BW?=
 =?utf-8?B?dVlhcUhtM2Ntd2NZV1VsbG56dDJrSEVmU2F4OHZaZEFPdzRuT0VKWWJoK3NK?=
 =?utf-8?B?YmVYWWdqUlMzZ2p2NFVMWnRHYmJWcVBlZnpjUWd1Q0JMRm9mZHZBNXFFV2Ny?=
 =?utf-8?B?YmQ5d083WFlmYWR0R2E2OVd0VEM5U3RzS1NNSkZMMmQyM2xET09rb2VwOXg1?=
 =?utf-8?B?ODN6TEpwc2VGVCtWaTJIU3ZoMENrV1p0bXlBVzhUUlFVVWd2b21kclZqdjlh?=
 =?utf-8?B?aE9RbURKMWg4Q3hxLzR1clhZZ3R1c0FkOXFmbk9BVW1OcEU3RW1RRDhxem9z?=
 =?utf-8?B?allRbTZhMGtHY0Z5dFRtRWJrcjlpdjQraUhXeE9CTVkvejdNSkY4eEVaNlpj?=
 =?utf-8?B?UU1WallyOVhQQWNVMFdqVDdRUUk4eFRvbXVqc3k1ZGpvckVaMUp5U1BoTHJj?=
 =?utf-8?B?SThwUFphaGhrcjVRRGhaajNQeVY0a0lHcC9YRm10cE5udDRtZVVWT2pyajlB?=
 =?utf-8?B?TUk3bHdHQjJUbzB4NWgxeXVmS3dvVDhudUdXeWNCMWJxM0VGS1hqbkR0UkI2?=
 =?utf-8?B?a0lZOGl2TEZYYjYzeFZvMVNFUk51aUhVSksyMzY3NURPOXQzckV4c0VBeHlw?=
 =?utf-8?B?ZGRTZTFjL1J4SlE1bmJRZ24yMUZEaGFBQ1RWWXV5M3FoUHAwTHJWZ2FSSEw2?=
 =?utf-8?B?NFR5MzJDelh2UDdvS2FOc2VGKzRWWTg1V2VNMlpWa09YU0JnZVJtVFhlQlBW?=
 =?utf-8?B?dU5CWkpnYldmR3d5aFgyUmRxbmtYR1RkV0xrdExFckV2aUJHUExKUWExYldo?=
 =?utf-8?B?czg3RjRWUHpLNkxPRW5tZUpteCtrK3FsU2lMNXBSajh1eitBTlVlaVRDZmdF?=
 =?utf-8?B?TnJ1QUdkRmlERXdBKzFpSTQrRTlqMkNtM0ZXRHoycStXdnh0RzlKQnhGaWk0?=
 =?utf-8?B?OGFCb09xV3VsN3FMN2dFRjlDeGtQTkZ3QVlCZzZLM1BSWmkyVUp2NEltdkFI?=
 =?utf-8?B?bjFGdWRpb21jOFl0d1UxcFVZNXR3QUdFQlN3eHpRNGp0SDRjR29kNWJ5N1Jw?=
 =?utf-8?B?TEl2OGZoc0MvaVlFRWNCWXZ6VzBTTjZNU1F5aW5tUUZMa2xCUkhMWHF2Q21L?=
 =?utf-8?B?aUlzYUpxeUxLSEhVNDV6Rk0vTFQ2cDJRVDUxaFFieWJXT045V1VjYVZ1MWd5?=
 =?utf-8?B?eGx1RkRkMFpVQU1QeHI3aEFReTcxSG9ITnRURHBZWGpWMUxmaHIzQkVleFpR?=
 =?utf-8?B?R1hJcDhyMXAwak9DdTRBMmZEY1hseHZ6dWxXQ2hhNG5SeXUwVEQ5bGxIaElE?=
 =?utf-8?B?Q1lyaTZJZDIxY213NEVQS05FY054Y3ZMWHk4U3Z1N3VhblRjMk9NcEtLWEM1?=
 =?utf-8?B?S3A5a1phNTdEMmxMajlVTkVxZzZNQ0lRVmlkZEdjMHlXYm52Q1ZtdkxFZm9C?=
 =?utf-8?B?d3R2OEpidzNSZE1tNktpZXluQmx3MjVqYlRZV1NVaWRsTGEzRHdMZ0xxbFVv?=
 =?utf-8?B?NVY5SitodVphamo2L2U4SFB3em9SWEVOWFdFS1k5ZDM4Zk1VMHV2MUdjaC9E?=
 =?utf-8?B?TGJVMUdxV3RhT2M4eDRrRVNiWk9WcjZyak4xNWU5MlJmM3hQSlFqMmhxS2cy?=
 =?utf-8?Q?m7mlkM8HzGjRfy+tttTwOkks3WxSfIBqbJktJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48F2DBF9B22FB34884C99DA3823C4BB6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	TCBcv4rCo4e6c/jVtR745N5sQh/gCdGkUrEL9H3YsXHu2Z1Ogm4gyUIDAgkaytgQ+DJHd3u+g+jc3vFMvaOH0ysgNtSVBIcZmEyu+QOJG5R+VxX/UXoLqnQ6T7HJWmgApPx56UxozXV4jC6Yuyn7x1t+E9M9aRXEBs8b7K92DcW/rsASNiM9Wra0M1gCD6XqAv19znBJH7mJe78ptgy1T8iwQ4N/XgfRziOrxS8GyxEb1hm3DufJvwsEzHsqUaCVdocssl0yLCee9LVg0Lh3jhlqEx0x4uwo8LmLbII1+cFbJoleIpfAWVIcyi0MEYYJpA0C+V0JbeZSnZ149qncAw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14424ae0-060d-4909-9910-08debc19bccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 17:59:46.1052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOo59GIsJBLalamuSC8CN/wpFg5nqF+kObX9/65uYEc5FWHkVexzLNS6/G03AcC4s33hU2Mueye6F3TJjwG+nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR15MB6708
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: y4nB1YOSsRFuczsx9UUEGC5raV7ZAkgM
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a173117 cx=c_pps
 a=HozCXiP24e1PxqS5ATOdRg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=SCzqDOvs3xxEnH0MGvgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE3NiBTYWx0ZWRfXybYrms4zQeMK
 hokjL0wkvFtANofDgd7sGMkuw3/sy2itrO2iMTQ6klKWdiM6A4Fm2yLlET9caxNH5Jp9OmN4VbN
 JvYr1voV2nyWs/GR0DhC9Btp0tmwbZsFy37T3bCWDtb2lCUboxrJ6L5BgVZfycS6I2RGZA0p20w
 bre7DnDfYpdeYOgvT/2cILwO3+davesik4pExVZQfZWzflZ5BC0Z9tXqUQ2GUmhzP5gMd39OXUs
 xbFXJ9Qcfm1MWLkeQ19y76w6KehiRXRkiDn0fIavZI09w/bhaJr+nrv2eCHYtWkQQU64+Id8jYu
 Fzoveg31uysDscL2DAOk/BgQ9BX8hE9ligXBfPwcXW8tdu0pXKUYZ/zx8uCpX8MuH0ns1aUj/iA
 5M/F/2yQMR1a6lraweeVqPb8dtPxxDmhuTa4BliNEI/v7NY1Sm52lt/5EEOE6JHG81DJwnJTExF
 f9dEoqPVkX8KCpsSzYQ==
X-Proofpoint-ORIG-GUID: zzQrWCwheEms7xa5KMmir16RGz_P0oqZ
Subject: Re:  [PATCH v2] libceph: Fix multiplication overflow in
 decode_new_up_state_weight()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270176

T24gV2VkLCAyMDI2LTA1LTI3IGF0IDE2OjA2ICswMjAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gSWYgYSBtZXNzYWdlIG9mIHR5cGUgQ0VQSF9NU0dfT1NEX01BUCBjb250YWlucyBhIChtYWxp
Y2lvdXNseSkgY29ycnVwdGVkDQo+IG9zZG1hcCwgb3V0LW9mLWJvdW5kcyBtZW1vcnkgYWNjZXNz
ZXMgbWF5IG9jY3VyIGluDQo+IGRlY29kZV9uZXdfdXBfc3RhdGVfd2VpZ2h0KCkuIFRoaXMgaGFw
cGVucyBiZWNhdXNlIHRoZSBib3VuZHMgY2hlY2sgZm9yDQo+IHRoZSBuZXdfc3RhdGUgcGFydCBp
cyBiYXNlZCBvbiBjYWxjdWxhdGluZyBpdHMgbGVuZ3RoIGRlcGVuZGluZyBvbiBhIGxlbg0KPiB2
YWx1ZSByZWFkIGZyb20gdGhlIGluY29taW5nIG1lc3NhZ2UuIFRoaXMgY2FsY3VsYXRpb24gbWF5
IG92ZXJmbG93DQo+IGxlYWRpbmcgdG8gYW4gaW5jb3JyZWN0IGJvdW5kcyBjaGVjay4gU3Vic2Vx
dWVudGx5LCBvdXQtb2YtYm91bmRzIHJlYWRzDQo+IG1heSBvY2N1ciB3aGVuIGRlY29kaW5nIHRo
aXMgcGFydC4NCj4gDQo+IFRoaXMgcGF0Y2ggc3dpdGNoZXMgdGhlIG11bHRpcGxpY2F0aW9uIHRv
IHVzZSBjaGVja19tdWxfb3ZlcmZsb3coKSB0bw0KPiBhYm9ydCBwcm9jZXNzaW5nIHRoZSBvc2Rt
YXAgaWYgYW4gb3ZlcmZsb3cgb2NjdXJyZWQuIFRoZXJlZm9yZSwNCj4gb3NkbWFwcy9tZXNzYWdl
cyBjb250YWluaW5nIGxhcmdlIHZhbHVlcyBmb3IgbGVuIHRoYXQgcmVzdWx0IGluIGENCj4gbXVs
dGlwbGljYXRpb24gb3ZlcmZsb3cgYXJlIHRyZWF0ZWQgYXMgaW52YWxpZC4NCj4gDQo+IEZpeGVz
OiA5MzBjNTMyODY5NzcgKCJsaWJjZXBoOiBhcHBseSBuZXdfc3RhdGUgYmVmb3JlIG5ld191cF9j
bGllbnQgb24gaW5jcmVtZW50YWxzIikNCj4gU2lnbmVkLW9mZi1ieTogUmFwaGFlbCBaaW1tZXIg
PHJhcGhhZWwuemltbWVyQHR1LWlsbWVuYXUuZGU+DQo+IC0tLQ0KPiAgbmV0L2NlcGgvb3NkbWFw
LmMgfCA0ICsrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9vc2RtYXAuYyBiL25ldC9jZXBoL29z
ZG1hcC5jDQo+IGluZGV4IDA3Njc2MzQyMGIxZC4uNjVhZTQ4YjlkOWE1IDEwMDY0NA0KPiAtLS0g
YS9uZXQvY2VwaC9vc2RtYXAuYw0KPiArKysgYi9uZXQvY2VwaC9vc2RtYXAuYw0KPiBAQCAtMTg0
Niw2ICsxODQ2LDcgQEAgc3RhdGljIGludCBkZWNvZGVfbmV3X3VwX3N0YXRlX3dlaWdodCh2b2lk
ICoqcCwgdm9pZCAqZW5kLCB1OCBzdHJ1Y3RfdiwNCj4gIAl2b2lkICpuZXdfc3RhdGU7DQo+ICAJ
dm9pZCAqbmV3X3dlaWdodF9lbmQ7DQo+ICAJdTMyIGxlbjsNCj4gKwljb25zdCB1MzIgbmV3X3N0
YXRlX2xlbiA9IHNpemVvZih1MzIpICsgKHN0cnVjdF92ID49IDUgPyBzaXplb2YodTMyKSA6IHNp
emVvZih1OCkpOw0KPiAgCWludCByZXQ7DQo+ICAJaW50IGk7DQo+ICANCj4gQEAgLTE4NjUsNyAr
MTg2Niw4IEBAIHN0YXRpYyBpbnQgZGVjb2RlX25ld191cF9zdGF0ZV93ZWlnaHQodm9pZCAqKnAs
IHZvaWQgKmVuZCwgdTggc3RydWN0X3YsDQo+ICANCj4gIAluZXdfc3RhdGUgPSAqcDsNCj4gIAlj
ZXBoX2RlY29kZV8zMl9zYWZlKHAsIGVuZCwgbGVuLCBlX2ludmFsKTsNCj4gLQlsZW4gKj0gc2l6
ZW9mKHUzMikgKyAoc3RydWN0X3YgPj0gNSA/IHNpemVvZih1MzIpIDogc2l6ZW9mKHU4KSk7DQo+
ICsJaWYgKGNoZWNrX211bF9vdmVyZmxvdyhsZW4sIG5ld19zdGF0ZV9sZW4sICZsZW4pKQ0KPiAr
CQlnb3RvIGVfaW52YWw7DQo+ICAJY2VwaF9kZWNvZGVfbmVlZChwLCBlbmQsIGxlbiwgZV9pbnZh
bCk7DQo+ICAJKnAgKz0gbGVuOw0KPiAgDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBW
aWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCg0KVGhhbmtzLA0KU2xh
dmEuDQo=
