Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8724423B632
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081053; cv=fail; b=BNGjBmet2a5+A3phyS0Aj1nNkeguh5+P3RAe+2UY4Alc+zfPH+fdiLPUIO4+0a8Z5YnCITGg0jZvp4Wws8ZtiaCHihT6m+RcF4wTPnZFedbXu5aUvS3fOn2CrzpOFzyxBvC0OTrCZMac/zg/YufQPqAnzcppijixZ6poUSm+QPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081053; c=relaxed/simple;
	bh=NByWWWfpxq6y38t1CBkpFgL7pPDmaTQjml/QzCJ7bpc=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=XdR7TcGCw51D+dzHk/He38Dsldw7vrfISqyZcSg4IzNcYllWXeuRAo8yxzWvyIzfjX/NNcdCdPlafJx0DzU6XOiSQjNzWPZl0j0xBYrRBF7f8uNhMIrRyxp6sdg9uH0jxJGFUS+OQYKeidcEtsA52V0jkRlnZCBCoHWf/PoY11M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=htl0es1/; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="htl0es1/"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629EKF2c1027783;
	Mon, 9 Mar 2026 18:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=NByWWWfpxq6y38t1CBkpFgL7pPDmaTQjml/QzCJ7bpc=; b=htl0es1/
	m5e/OUhy9kW28WprRy53NYvQGc0HfJGMwKGqEuWez+nz/liNFdgSmGz5T3uMECes
	s/bzv35Rp4yB/hCjha6JAVxnEGwpIeoTDM3kzvI2Mdsq4YZzzuh/hlOGyUKaG91D
	HOOymiE6OYTp7pB5LPQmJMGPxEMiF0jlRbVDklOTd7dugQNkaokAMJ6+niEp6LRC
	0r6gJ8VYhxS5ABo2gbg1/uV/o8/Bt/0K5f5T1CUCepRVbzPRCryMfJTL9A4HE+FB
	2m1ejkcxjve57s3fJJPwGOsVvwxgJKTaCtUBy5lUI/bX4E9mxWv+Okz/1yvO+zWe
	XslLU4vFcVJofg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun7nnd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 18:30:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oT+TyFTmfrjEHGPnAxAMAljMdJ6SE+Z0XA9XRgga23K1Z0tMplpwMTHu/SmCvKYzj+7nUUUaPzmMW+yW/Cp1b/n4h36c2S6jDwfVrYxMOPKhizsT7xfu2ZV0gxvlO5ntFT2SKbU6fOhFJmR72StpAb1ryIeYBz2thiuj/CqZN+B24i9h2lSFD7jriA9rB50QXwDBdP8EtDcKwApBcctadHVkqZY1oCrzIy5MtTMRj3FSD6Zw17YoqOb8W0N97YkgRJ+IOFWkS1oQ8SOxvf+kVkp7ms4I0lAARK5nlBEbWVT7OSdC/Y9LaQmLWJr4TZCxaEabkY8yrYySe3lhFEWNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NByWWWfpxq6y38t1CBkpFgL7pPDmaTQjml/QzCJ7bpc=;
 b=lYzhJOK5c0ASC94m9DbdA8eGQuDP5c8yZvx2Jj1ZgRXJVGHl7+9TvG4zW6DE0Qd389WhhEHAUPmkLqumG+yyhWy+sLi/TeUvkGVcyD7ClSePhtljISA6SNPjlDQz7azdwaM6lc8Qmw9kgKjtvuBUYGJNyQyixOJUpCS5UFfvMoSjnTTRv70ugauDQoaVqulBJgLdkw09ipybzyMQVNzMOKl7R6ImMIM/57BTxmDLvk9PgEmiN29dID3Msq8bxqIImYK90pZkI0Df52O/2c4szYj/KfMnEtmoZcsGBsmIiHV9sdWK/dpgrPcIHluEpGxzJ0xQkRxwjvwpgUK2+Ezkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA0PPF88AEDEFB9.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 18:30:35 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 18:30:35 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] libceph: Fix potential out-of-bounds
 access in ceph_handle_auth_reply()
Thread-Index: AQHcrUmiNrdkrdJkbEWuNdvm5IkapLWh4ykAgADuaQCAA7l9AA==
Date: Mon, 9 Mar 2026 18:30:35 +0000
Message-ID: <3d6435690a9485f3c2f93ec6ce03388d6e5911d1.camel@ibm.com>
References: <20260305164049.2844606-1-raphael.zimmer@tu-ilmenau.de>
	 <9a967105c12095a4e5f32d1c49550c2424580483.camel@ibm.com>
	 <1b946af9-8c9f-49e4-9f36-efacaf2bcbde@tu-ilmenau.de>
	 <2ddfc235e05ab8705a92f5e2e1ed780f47b9cc30.camel@ibm.com>
	 <1bf00a3a-d022-49eb-890e-a9b52a9da0bb@tu-ilmenau.de>
In-Reply-To: <1bf00a3a-d022-49eb-890e-a9b52a9da0bb@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA0PPF88AEDEFB9:EE_
x-ms-office365-filtering-correlation-id: 78df4ae6-5c08-4f3a-10e6-08de7e09f463
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700021;
x-microsoft-antispam-message-info:
 jDvbGlqd2qRDhZnxpvhhOoORo+IqJ9+o8VYAZKwzW5e0Kanm61nenQHdvyc+L/z6FK7G0X2c5ml1F3s8/5lwXWnl8zCYeDIwJOk8D3/GhGRzxKIt/hgzOrxIfO/jD+Ka/4az1JsCGtL+kxj6dRmNIx27I0gUJ0N9jOSqxuepgrFX6/AUdAY7DCIWJRiEUottRgylZKRazwLjuatwYgeZx+ONIpkCpsqf7Lhn1v5LF0YUMQEHy6qMCJuA69cZ5IluoCM6IDWMn7WrbyBYltv+qBK+1rlAAuIKY71OWHCGOSTS3Cw1ncKrJX3f9hNA5Qqh8ZGHwyrWmYCoM8tqC++gQGV+PIPms1XWJm6ddAky6PSKf0an09Pg3xlw+dwhFYXMa1+O3Kst+mrmY3m9aEE+NW27tNzMeEppC7ZZ/6eb02aKt9GEmiGBQ5HYMXmkq7VH5jRGEuDR2NxHGKmFd6chA6yRlYkh8t4AI+d43u9kjwp9aKihqrH7RKrDrfAG9u6lEXE8NUMlClxXHxvjlgQihvzha/lMCh4UnL/pVtZu4FXhXUhLd8+dt+dVKfzqT/ONfA/LzRrYZcyj4cLjW9vkvmxIoXCzus7huDCGYh/ZjdUQKHtACalWVBv1oDD8SYxKoyQ2w5PS56+6KOPJn17NMWSdbckzJDyCxrsgZnNNyycRNZuRQTHVaNtLRyL1LOLHbo73Iwp9H6Xg4eYJvYTFhGbM8INgRCpQ8qjn7t/CyXaCgpeM8e9s9a3fqUlp/RCY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0ZMM0dUYjdHeXYrZTE2MlhNeXJqTWJEam02UnVid1k3Wk9sK3ZlUnBCRkVV?=
 =?utf-8?B?ZGZ4SHNCcEhOSlVJalcxRWxlV21Jb2dlNWVpTVIzT1R1elErK291c2dzMFFJ?=
 =?utf-8?B?NDdTN1RnSGVQZ0ZWZ2VWcFFWcmFpYTQ0SmhjUUVtbjM2ckNCaC93ZmRFS0tn?=
 =?utf-8?B?Tm9PN2NyYW9YQUZPK1YvaCtnakpZZW5FcDBCemxiWm1PdDI5dkt6WVQ0WEdX?=
 =?utf-8?B?cm5jbStXa1h5RDlLK2x2TE5ER3VJbnhFZSt4SjVra1l1NkErb2dzT0xZK3Zz?=
 =?utf-8?B?VTlka3dDL3l2R1U2bXBPMTd3VnZvYXBDTkNOU2hxb1kvVUl2bFVqbERiZ3Jq?=
 =?utf-8?B?WUpkei9vVGoyeVJyalhZTEJVYThmYWFXY3NhUnpib3VzcDVwcXR0NnJSR0li?=
 =?utf-8?B?OW95YnJlVWNIRGpVbjlzOHAzcDdrbXRxWkFKV3Y0bHl4VytjWEhlUkZ2Mko5?=
 =?utf-8?B?ekJvajlWSjlFempOV2kxall6bGRrRUhVOFNjUysxa1JsNzlsaXRYSjBvc1NC?=
 =?utf-8?B?VitqSzJOUUV1YXdNM2tOK2xWaGJDRmkwdVdCdXdnSU1OQzMzeTcwS1dVRUNZ?=
 =?utf-8?B?akQ2RUN6bWhEaEZzZHJBRFpHSjI2RmRkc1lXYVlFZXhLWFEwTGNIdnFSV2Ex?=
 =?utf-8?B?VUkyVjRSSXdzWHpGd2ZEQ25NenVIZllhcDFoOUZ6UmJBRVZpdUZoOVkwZHlZ?=
 =?utf-8?B?TndQMXY3ZnJqM0QyU0xLRzdaWUcvbVdPZmZQcEJBUXhaOHE0SHhuK084bTBK?=
 =?utf-8?B?RThIVFE1SzBCajNQMXFPaGVKS3B6dGw4Z1Z6TnBWbEtiK0VVR3ZqdFFQTnRj?=
 =?utf-8?B?Z3pUa1ZWZkRRdmJNZ2p2bG9oM1FUS2FmWkJGWEJDZ2FUMHowZlhocmMxdktF?=
 =?utf-8?B?N05JT3IxZXNNTmluRVFNS3dCOTNmMU5JZzczcXZtUkVLOHBrSHJ1aGthRlVn?=
 =?utf-8?B?NG1vOSsrQ3JDNkRiVUlWRmNTcHYxVzNKMW5oWWsyNGlEUSt1UC8xeGNwWUU1?=
 =?utf-8?B?ckpPN0dJb1VIbUVYeHd5Z0c4S1JQK0pubjJDaXhDNnpzUFBoTi9TbVl5OHI3?=
 =?utf-8?B?bE1YQ2RuV1M3UFBQZTNIcXZsNm1TelJHcUE1M21oYWhRT1QwQlc3Slc3alBa?=
 =?utf-8?B?cVN6SFhlZld1bTAyc3NvTzg2R1ZUWk5aWHNtVnpGQ1Z2WUNPcWF6Y1hMM2dV?=
 =?utf-8?B?NFlSc2hOOG11M0dHUGZPd2p5amhadGNXQnBzcW1yM3VuODB5MnhhamdYVXk5?=
 =?utf-8?B?eDJ1TWFUWER1SGZNc3hoYVRjcnQxWlFseHVWODNKTW9HV3cxcHdMbTRkWEh1?=
 =?utf-8?B?UmNES3RGdXU4UG0vSzVTR3p2RGw3WjZ1bFZVRGRGL0ExVnNibmpFY2I2d05P?=
 =?utf-8?B?YkU0VnJRbS9LdzZ6dXVnbUxTcDNWMDBHbTVuMmxvWUViUnVyWnVaazVxTUJ1?=
 =?utf-8?B?cGJOdUliRUJJWTR1eUhCM2h2djJqTU5kNXdiQkNzMUNPMHFUcm12TTFtbmM0?=
 =?utf-8?B?YTRVSTNKelFjVEFjRFZvSkhzUkdNekZITDBZWmlEbWoyZHcvN3YzaVhoWDdp?=
 =?utf-8?B?RTRnay92NmhqVzVHRjJ4TTFpNEp0OGJQQmFLOGZoYW9SZlpONXo3VC93V2RI?=
 =?utf-8?B?S011Z291eDluNUcwU3VONVhYRXM5TmI1Wi9PcUl0aUZzUGVJbGh6N3crL3FX?=
 =?utf-8?B?WTN5c0p3dTNHQXU3cExZdC9BYytCZTFSNVZxdHRKNWc5aThNOWRDTUhQVWN4?=
 =?utf-8?B?R2dFdnBqS3NnOERNL3dVajBiNTIrVFl5K0IrU2tGZS9FRGMyaFl5KzVWTXZX?=
 =?utf-8?B?MEhWaitVRFBGOGRncGcrOStrVTlmaGNqMHlQWTB0M1dSQmRGaTlrOWhhWUlV?=
 =?utf-8?B?TlkwbEJ3L3FqSnJ4aGZkV0lyUnRiaUtacVI2N2llTTBHLzNsajUxUnM5d0xT?=
 =?utf-8?B?bWlrYW9UcmF6bmtsK2g4M3I0VE1uRTY4cmRmUkdmY05wajNsNmlScUZEaXYw?=
 =?utf-8?B?SnhKOHlYZ0pKN0Z1WWFiR1Q4RzNkUDhhYS9IREJFZ0o4dndwOXdNRXdFTXc0?=
 =?utf-8?B?eFNDcjJaY1RJc09qU0JNTDJMaUROOEN4emYwK1Fzc0Fqay9aYkJ0cjZrTGxj?=
 =?utf-8?B?T2RoUWZVaGpoejNza0swOCszM240WVp3MVc3SzhLL3hoUks5OXZBdCsrNDlZ?=
 =?utf-8?B?dFFJTXAxQjY1NWQ3MlZrVGNkZFA4YXBFTzJOWUpwdGlmYUJOclVTVGZyVkNk?=
 =?utf-8?B?a0Z2UllZZnlncnNhOHdhTXNlVnMrSlQ5S1M3Ykppc0ZuMGtvSUFOenphQm1M?=
 =?utf-8?B?VEc2Z3llak5kQXRNanV3amtjdVlGZTN6MW5XaFlHZGV2WkFWTXJzWE5ZNnJF?=
 =?utf-8?Q?ZvYKd84oOhbgkwqIF4O/pweu/8exT5FbjdbHb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C6B1501438BB246AFC038262A33748C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	YczmUMpiRs9PScxvdH7S3o6opo0OPrLfD6Ir7NYK4t0R9jxYGThZd2A++biABY867nCligzth5vYAghWSlopMdwoIvnrYViBN0t9OJkB+HvjKPlSOMiGjaJCwsYp0VXG489lZC7mXn8wDEAkJ/xXGAuIfvuPXqb+Mblfp98953JJ2YIkpxiZZgWIVgv4dg7Q7tB5NxbvxaHRAhKMfZyxtly3VDb5Q4Jtds/1XiB3DPyJ0SgvcGGPXrmdW/cF8+kcjrq1U15KSHLf/+wxUpS72WRe3YYUim15LBSq6kwyrnBDVUUbyP14CMxiVIBWxlEdXQL0C9znHJ+2yJSg+DKsbg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78df4ae6-5c08-4f3a-10e6-08de7e09f463
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 18:30:35.2829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/N5rP2joGVIz1W5YXZroxUNIJ8v2Be4Iw9epj0UDtJy+v3f5d0lcuQ+i+biiRhfpvRc3YMPGM0b54uR3f86WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF88AEDEFB9
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: d6I0u7WpjLh8vukOjthS530pr34B1wj5
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69af11cf cx=c_pps
 a=UjDdpJjQ9fE5FDPsVaFzsw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=P-IC7800AAAA:8 a=RIwQOdnTyNaRVLjiz_QA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE2MiBTYWx0ZWRfXx4Sb5LDJA4df
 FwQ96q7G673xpM4105rqSIWBPWpnGSIs1NaUgGcgKAj4J9v4kGd6Sd/TJHwhtd2wD0zUjKPHY71
 X0pWHTSE3jEUVpsk+bm98LTz8nz0hf1Rxp1g2vc3J/04QT+0zx/ntLCWnn1Ck7rsz3o2/2pP1HO
 tCtuuS4MEWqrkXIFvdn9GIje7Gss4CnyQkXQkC0b+6w3dl4L3Y45Cx+7Z+wm8Aug3dnsoJPQrFx
 TYSl6e3gD/DdmKVRahsfPZ9qovOIWf5xAKDcGreNa4FlrsPsnQIiY28PSWdVgai31VGMUZbYWEl
 hsAwN8aMkmD1kAyHY9w2szcuZu+RzA9C4eFezMDO1pPLIS9A8UF0Vu+hSeUomsQfqG/kR5jsWvQ
 dlPZm7huLurpjbeQiNtN3A+Wh+h8r9LKIjy5ImppGDZKJkJVDizmbq67mwXCXyZ8oc9hG2GhDWZ
 vLp9LI3omFolZYWzBDg==
X-Proofpoint-ORIG-GUID: J5swL_DlLhQUOOhJW9JSzNkf3JUeRXlE
Subject: RE: [PATCH] libceph: Fix potential out-of-bounds access in
 ceph_handle_auth_reply()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090162

T24gU2F0LCAyMDI2LTAzLTA3IGF0IDEwOjM3ICswMTAwLCBSYXBoYWVsIFppbW1lciB3cm90ZToN
Cj4gT24gMy82LzI2IDg6MjQgUE0sIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToNCj4gPiBPbiBG
cmksIDIwMjYtMDMtMDYgYXQgMTA6MTQgKzAxMDAsIFJhcGhhZWwgWmltbWVyIHdyb3RlOg0KPiA+
ID4gT24gMDUuMDMuMjYgODozMyBQTSwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4g
PiBPbiBUaHUsIDIwMjYtMDMtMDUgYXQgMTc6NDAgKzAxMDAsIFJhcGhhZWwgWmltbWVyIHdyb3Rl
Og0KPiA+ID4gPiA+IFRoaXMgcGF0Y2ggZml4ZXMgYW4gb3V0LW9mLWJvdW5kcyBhY2Nlc3MgaW4g
Y2VwaF9oYW5kbGVfYXV0aF9yZXBseSgpDQo+ID4gPiA+ID4gdGhhdCBjYW4gYmUgdHJpZ2dlcmVk
IGJ5IGEgbWVzc2FnZSBvZiB0eXBlIENFUEhfTVNHX0FVVEhfUkVQTFkuIEluDQo+ID4gPiA+ID4g
Y2VwaF9oYW5kbGVfYXV0aF9yZXBseSgpLCB0aGUgdmFsdWUgb2YgdGhlIHBheWxvYWRfbGVuIGZp
ZWxkIG9mIHN1Y2ggYQ0KPiA+ID4gPiA+IG1lc3NhZ2UgaXMgc3RvcmVkIGluIGEgdmFyaWFibGUg
b2YgdHlwZSBpbnQuIEEgdmFsdWUgZ3JlYXRlciB0aGFuDQo+ID4gPiA+ID4gSU5UX01BWCBsZWFk
cyB0byBhbiBpbnRlZ2VyIG92ZXJmbG93IGFuZCBpcyBpbnRlcnByZXRlZCBhcyBhIG5lZ2F0aXZl
DQo+ID4gPiA+ID4gdmFsdWUuIFRoaXMgbGVhZHMgdG8gZGVjcmVtZW50aW5nIHRoZSBwb2ludGVy
IGFkZHJlc3MgYnkgdGhpcyB2YWx1ZSBhbmQNCj4gPiA+ID4gPiBzdWJzZXF1ZW50bHkgYWNjZXNz
aW5nIGl0IGJlY2F1c2UgY2VwaF9kZWNvZGVfbmVlZCgpIG9ubHkgY2hlY2tzIHRoYXQNCj4gPiA+
ID4gPiB0aGUgbWVtb3J5IGFjY2VzcyBkb2VzIG5vdCBleGNlZWQgdGhlIGVuZCBhZGRyZXNzIG9m
IHRoZSBhbGxvY2F0aW9uLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gRG8geW91IG1l
YW4gdGhhdCBwYXlsb2FkX2xlbiBjb3VsZCBiZSBiaWdnZXIgdGhhbiBJTlRfTUFYPyBJcyBpdCBw
b3NzaWJsZQ0KPiA+ID4gPiBzY2VuYXJpbyB0byBoYXZlIHNvIGJpZyBwYXlsb2FkIHNpemUgaW4g
b25lIG1lc3NhZ2U/DQo+ID4gPiA+IA0KPiA+ID4gPiBNYXliZSwgdGhlIHByb2JsZW0gaXMgbW9y
ZSBzZXJpb3VzIHRoYW4gc2ltcGxlIGNoYW5naW5nIG9mIGludCBvbiB1MzI/IEl0IHNvdW5kcw0K
PiA+ID4gPiBsaWtlIHdlIGFyZSBoaWRpbmcgYSByZWFsIGlzc3VlIGJ5IHRoaXMgZml4Lg0KPiA+
ID4gPiANCj4gPiA+ID4gVGhhbmtzLA0KPiA+ID4gPiBTbGF2YS4NCj4gPiA+ID4gDQo+ID4gPiAN
Cj4gPiA+IEhpIFNsYXZhLA0KPiA+ID4gYWN0dWFsbHksIEkgZG9uJ3QgdGhpbmsgdGhhdCBhIGNv
cnJlY3RseSBmdW5jdGlvbmluZyBtb25pdG9yIHdpbGwgZXZlcg0KPiA+ID4gc2VuZCBhbiBhdXRo
X3JlcGx5IG1lc3NhZ2Ugd2l0aCBhIHBheWxvYWQgbGFyZ2VyIHRoYW4gMkdCLiBUaGlzIHBhdGNo
DQo+ID4gPiBzaGFsbCBwcmV2ZW50IGEgKG1hbGljaW91c2x5KSBjb3JydXB0ZWQgbWVzc2FnZSB3
aXRoIGEgaHVnZSB2YWx1ZSBpbiB0aGUNCj4gPiA+IHBheWxvYWRfbGVuIGZpZWxkIGZyb20gY2F1
c2luZyBhIG1lbW9yeSBhY2Nlc3MgdG8gYW4gb3V0LW9mLWJvdW5kcyBhZGRyZXNzLg0KPiA+ID4g
DQo+ID4gDQo+ID4gWW91J3ZlIHNoYXJlZCB0aGUgQ2FsbCBUcmFjZSB3aXRoIHRoZSBwYXRjaC4g
U28sIEkgZXhwZWN0ZWQgdGhhdCB5b3UgaGFkIGEgcmVhbA0KPiA+IGNyYXNoLg0KPiA+IA0KPiA+
IE9LLiBJZiB3ZSBoYXZlIHRoZSBjb3JydXB0ZWQgbWVzc2FnZSB3aXRoIGEgaHVnZSB2YWx1ZSwg
dGhlbiB3ZSBuZWVkOg0KPiA+ICgxKSBDb252ZXJ0IGludCBpbnRvIHUzMiAtPiB5b3UndmUgYWxy
ZWFkeSBkaWQgdGhpcy4NCj4gPiAoMikgSXQgaXMgZGFuZ2Vyb3VzIHRvIGNvbnRpbnVlIHBhcnNp
bmcgdGhlIHBheWxvYWQgd2l0aCBjb3JydXB0ZWQgcGF5bG9hZF9sZW4NCj4gPiBiZWNhdXNlIHdl
IGRlZmluaXRlbHkgd2lsbCB0cnkgdG8gYWNjZXNzIHRoZSBvdXQtb2YtYm91bmRzIGFkZHJlc3Mg
ZHVyaW5nIHRlaA0KPiA+IHBhcnNpbmcuIFdlIG5lZWQgdG8gY2hlY2sgdGhlIGNvcnJlY3RuZXNz
IG9mIHBheWxvYWRfbGVuLiBBcyBmYXIgYXMgSSBjYW4gc2VlLA0KPiA+IGNlcGhfaGFuZGxlX2F1
dGhfcmVwbHkoKSByZWNlaXZlcyBidWYgcG9pbnRlciBhbmQgbGVuIHZhbHVlLiBJIGFzc3VtZSB0
aGF0DQo+ID4gcGF5bG9hZF9sZW4gY2Fubm90IGJlIGJpZ2dlciB0aGFuIGxlbi4gSSBzdWdnZXN0
IHRvIGNvbXBhcmUgdGhlIHBheWxvYWRfbGVuIGFuZA0KPiA+IGxlbi4gRG9lcyBpdCBtYWtlIHNl
bnNlIHRvIHlvdT8NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gU2xhdmEuDQo+IEhpIFNsYXZhLA0K
PiBJIGRvbid0IGNvbXBsZXRlbHkgYWdyZWUgd2l0aCB5b3VyIHNlY29uZCBwb2ludC4gSW4gZmFj
dCwgcGF5bG9hZF9sZW4gDQo+IHNob3VsZCBhbHdheXMgYmUgc21hbGxlciB0aGFuIGxlbi7CoA0K
PiANCg0KSXQgc291bmRzIGxpa2UgY29udHJhZGljdGlvbiB0byB5b3VyIGluaXRpYWwgcG9pbnQu
IDopIFlvdXIgaW5pdGlhbCBwb2ludCB3YXMNCnRoYXQgd2UgInNoYWxsIHByZXZlbnQgYSAobWFs
aWNpb3VzbHkpIGNvcnJ1cHRlZCBtZXNzYWdlIHdpdGggYSBodWdlIHZhbHVlIGluDQp0aGUgcGF5
bG9hZF9sZW4gZmllbGQgZnJvbSBjYXVzaW5nIGEgbWVtb3J5IGFjY2VzcyB0byBhbiBvdXQtb2Yt
Ym91bmRzIGFkZHJlc3MiLg0KSWYgd2UgYXJlIHRhbGtpbmcgYWJvdXQgY29ycnVwdGVkIG1lc3Nh
Z2UsIHRoZW4gdGhlcmUgaXMgbm8gZ3VhcmFudGVlIHRoYXQNCnBheWxvYWRfbGVuIGlzIHNtYWxs
ZXIgdGhhbiBsZW4uIE90aGVyd2lzZSwgaWYgd2UgaGF2ZSBndWFyYW50ZWUgdGhhdA0KcGF5bG9h
ZF9sZW4gaXMgc21hbGxlciB0aGFuIGxlbiwgdGhlbiBldmVuIGludGVnZXIgZGF0YSB0eXBlIHdp
bGwgYmUgY29tcGxldGVseQ0KZW5vdWdoLg0KDQo+IEJ1dCB3aXRoIHRoZSBjdXJyZW50IHZlcnNp
b24gb2YgdGhlIA0KPiBwYXRjaCwgd2Ugd2lsbCBub3QgdHJ5IHRvIGFjY2VzcyB0aGUgb3V0LW9m
LWJvdW5kcyBhZGRyZXNzIGR1cmluZyANCj4gcGFyc2luZyBpZiB0aGlzIGRvZXNuJ3QgaG9sZCB0
cnVlLiBUaGF0J3MgYmVjYXVzZSB0aGlzIGNoZWNrIFsxXSBlbnN1cmVzIA0KPiB0aGF0IHRoZSBh
ZGRyZXNzIGRvZXMgbm90IGxpZSBiZXlvbmQgdGhlIGVuZCBvZiB0aGUgYWxsb2NhdGlvbi4gQ2hh
bmdpbmcgDQo+IHRoZSBkYXRhIHR5cGUgb2YgcGF5bG9hZF9sZW4gdG8gdTMyIGVuc3VyZXMgdGhh
dCB0aGUgYWRkcmVzcyBjYW4gb25seSBiZSANCj4gaW5jcmVtZW50ZWQgYW5kIHRoZXJlZm9yZSBv
bmx5IGJlIGluc2lkZSB0aGUgYWxsb2NhdGlvbiBvciBncmVhdGVyLCBidXQgDQo+IG5vIGxvbmdl
ciBzbWFsbGVyLiBUaGUgb25seSBleGNlcHRpb24gZnJvbSB0aGlzIHdvdWxkIGJlIGlmIHAgKz0g
DQo+IHBheWxvYWRfbGVuIHdvdWxkIGxlYWQgdG8gYW4gb3ZlcmZsb3cgb2YgcC4gVGhpcyB3b3Vs
ZCByZXF1aXJlIHAgdG8gYmUgDQo+IGFscmVhZHkgZ3JlYXRlciB0aGFuIDB4ZmZmZmZmZmYwMDAw
MDAwMCBpbiB0aGUgYmVnaW5uaW5nLiBBcyBmYXIgYXMgSSANCj4ga25vdywgdGhpcyBpcyBub3Qg
cG9zc2libGUgYmVjYXVzZSB5b3UgY2FuJ3QgZ2V0IGFuIGFkZHJlc3MgaW4gdGhpcyANCj4gcmFu
Z2UgZnJvbSBhbiBhbGxvY2F0aW9uLg0KDQpUaGVyZSBpcyBhbHNvIG5vIGNvbXBsZXRlIGd1YXJh
bnRlZSB0aGF0IHBvaW50ZXIgYWRkcmVzc2VzIHdpbGwgYmUgc2FuZS4gSQ0KcHJlZmVyIG5vdCB0
byByZWx5IG9uIHNhbml0eSBvZiBhZGRyZXNzIGFyaXRobWV0aWMuIDopDQoNClRoYW5rcywNClNs
YXZhLg0KDQo+IENvbnNlcXVlbnRseSwgYWRkaW5nIGEgY2hlY2sgdGhhdCBjb21wYXJlcyBwYXls
b2FkX2xlbiB0byBsZW4gd291bGQgbm90IA0KPiBodXJ0LCBidXQgaXQncyBub3QgbmVjZXNzYXJ5
IHRvIGZpeCB0aGUgcHJvYmxlbS4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gUmFwaGFlbA0KPiAN
Cj4gWzFdIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0z
QV9fZWxpeGlyLmJvb3RsaW4uY29tX2xpbnV4X3Y3LjAtMkRyYzFfc291cmNlX25ldF9jZXBoX2F1
dGguYy0yM0wyMjImZD1Ed0lDYVEmYz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTViSW00QVhN
emM4Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0VsdlVnU3MwMCZtPTZJOUlBemdhaFdVOVlWSWtibG13
OXR3MzJ6R0M2bVZHVUp2anJ1UmNxUnNHM2hKeGJqZnVwQWEtYU1GUWRQSzgmcz0zLXFkZWtjSkIy
bkJsWFF5YjIyZXJEcE0zcm1UaHhBMm1Jd0t6NmpvZ1lrJmU9IA0K
