Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FF7080E;
	Mon, 26 Jan 2026 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769468108; cv=fail; b=PRFOad7FJBrLLN1u86moWDlGfa9+MFhteB7j0179NC8HNd+BRh+97P+gs+I42YUGZ8+kYBzA6MSWToYTqbDeBewFMqLM943SnLnGghq3mVxiyeyTerSrqldn7w0eOv9etjjpRGMiQ7hmIP2MSaYfwVntwh7Umwo/2q2XrEGZhmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769468108; c=relaxed/simple;
	bh=NySg8NrK/9rs8cB2orzbqYpM0cge3MRTg2gE7EvEDF4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=aWo0ywSmjwJuA25dJQEWo0jb0E69hkDzknMCDw6f1S0PGKpS0QaX2cGtV6h1aJ7Xc8mqj4SeF0LKfNRoDDDS/QEWvuuYByuC/btXl2WCn4QWPHXVJL+tNxRgVv2Cd03h1Dr3uzv1j7Qbtc2SrvkuhP9lk0GqiAksRLyhhIGMGHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pZproTXD; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pZproTXD"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60QF9VVM028672;
	Mon, 26 Jan 2026 22:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=NySg8NrK/9rs8cB2orzbqYpM0cge3MRTg2gE7EvEDF4=; b=pZproTXD
	BB5fWfDQuevdLp//UwRWDYBZ3zep6KfRbAwzY3McwQsw1Lqys+Wdwj+CuUlBC5Hg
	TuP161+GF6wtTT2i2cVVYM8DWC5VtIl3b0XrS1ozYBlHQoTYYZ5Wca2EsCFcWvxr
	dscCImiWAhoU23rgV3YpJDgwtsJTlhPnVbckEfXD58fuhUZ2XDL1BLTiVtIpgWnM
	RhN7X9rUp63H7XXI4yOWEZe6Zfq0nsIp23u8AlPOjNXJhMP+L5DPlifQpWLQgePT
	DHtz2NIz+HeV6Q6EWjIh/ab6b36KSgSf2cR0tCESAIzy/0s5OK/AFdvaHlMPLp/h
	P8SwkzQCtJE31A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfs4yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 22:55:02 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QMt2kS028094;
	Mon, 26 Jan 2026 22:55:02 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfs4ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 22:55:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAyZgR9Xhy+e64BmzYrfwYT0JXfB/Ni3k5+vcFUEA3zXZqrSWF94O5Z/7pcYnTUx2qeHRzuwZF6ooqso7BX56YqEmo3S/yMFQUX5Fooxn6v/xGgqOLATm6Ms3Mgc7rtmh2WYK/TkSiePTXhgyYwzC/8xRM3LDYSeIoGt98GDbCyXlP2CD06ZyPjW9Wp/8amLmdlhf0xIZNdtJ4ieGj4yhhPqfvwpiEF3wGhofZbOvyGGohGeoeeZgYO1l8D2QmQSV4mygcJD7namQPu61LncoLxTaZrI7zPKTIjyaweKcWJWNAXxuIhqUM5zwmvHx14cmvQ/taTp0j81WO0+aSkAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NySg8NrK/9rs8cB2orzbqYpM0cge3MRTg2gE7EvEDF4=;
 b=WHLxewV9/ZAdMOyCK/c2boNLHoZEd/scUXaVF0eNPdC3CG9V3EbrTPcM23llIeCQDeDPi3Ek35Chbl0macsIME/8EOH0R6urrUCMzxP+AQv/Rh5t4WIjkFcGc4AEYzio4hoUJQxGKLZttkdYkpM9g7Hn7Ss6C7iydyR6KSZyes31Yvgb5jMQj2NP3AHA47HdTLzhK0jtiv+ORaEBvPttybJlKIxCxXKn9e0ZonXXXc4QhIAWx0OmB31Vibe5bk9T9Etg0XJWgXFrawdfmq8CdCnI7jhUV78dfRety82Xrh/ThTjaEFSkD+wyKyiXy9avDQPMFMQO0UY4x+t0RP6UaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CY8PR15MB5531.namprd15.prod.outlook.com (2603:10b6:930:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 22:55:02 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 22:55:02 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Xiubo Li <xiubli@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>,
        "cfsworks@gmail.com" <cfsworks@gmail.com>
CC: Milind Changire <mchangir@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v3 3/4] ceph: remove error return from
 ceph_process_folio_batch()
Thread-Index: AQHcjmvaGvctu2bezEuLuwqkRdb/e7VlEL8A
Date: Mon, 26 Jan 2026 22:55:02 +0000
Message-ID: <65d1b29527a7ea8b06fd18854a25e0d1f60a24c0.camel@ibm.com>
References: <20260126023055.405401-1-CFSworks@gmail.com>
	 <20260126023055.405401-4-CFSworks@gmail.com>
In-Reply-To: <20260126023055.405401-4-CFSworks@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CY8PR15MB5531:EE_
x-ms-office365-filtering-correlation-id: a01aa625-8139-419e-3831-08de5d2df070
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YUI2eGt4dmw3cnpuNUJwTlhQcDVjcCs2TnBVY3R5MXcxdHkra2VydXM2UEFE?=
 =?utf-8?B?WC9rdFI5TUNYSHBibXVvekdNYjhsK0Q2S2hHTTFLcTNoQVIrM09WZGJjL1VJ?=
 =?utf-8?B?WjJjaEtocnAwaG5uREJEZ0xVSUpvb0dkZ2plSWpuRGtCS1pNL0VvZUoyYUNR?=
 =?utf-8?B?emRyVFNhOHNiUXdabUhlUnZaU0htQlVLY3dOS01ubnVNbG9xQnRETmdaQllK?=
 =?utf-8?B?M1ZvZjR5Vlh6YVlNWWdkUUlpcHZFQU5LVy8xdEtEUDBRTXVSSVZsK3c2dXN4?=
 =?utf-8?B?UVFIOFZla1d1bEkwVXhsUFI2VzhFZWFYdHZHU3ZLbEIxS0FiY3lqRytYdyto?=
 =?utf-8?B?dTlqU3RRNG1ncCt2MjV1NUpYbDVzQWF3NWlJcVNTYkU4ZDVKM1ZDUmJVMkZy?=
 =?utf-8?B?VU1kQSs3N3k4RCsyVWVGMVExVEFCOEhTYzJoOU43M2ZLc0ZWTjFYZTgxNVFv?=
 =?utf-8?B?dmpzMFdvN2pYVGVmbldScG1yTVp2dEw3eUtRMUVSNDRLTmR4VkpSaTlBRGha?=
 =?utf-8?B?aXJjR2RoNnJ0d0dUbVcwaXpkSThLdlBUQXRzTlk3bkFENzh1WmRtYUFlSE1L?=
 =?utf-8?B?TXVnR0tHRWdMR3o4bG80T1dwcVhKY1RkOUx3SEZybGtmZHRpbllFSGlXNGdO?=
 =?utf-8?B?RW5UK0U5L2VHaStSampTd0ZnL0pVU3crVnZEckNwVWNhV0trM1JIbzg0b21u?=
 =?utf-8?B?Y3R4eDZOVW9LVis1emZaT3ljamVzM2VJSGpRdEpPS0VnWWJzeU1MbHd3aTc2?=
 =?utf-8?B?VldBNGx4Tmd5Nm5FdzkxQWpDb04vT3RpWkRKL1RqdEEvWlJ3R0IwYmwxT2lZ?=
 =?utf-8?B?WTd5bHVXajhaZjV4c0VzcG5hZkloc3Qzd2NmMHc2VzhUOTVWU2ZMcTA0bmc4?=
 =?utf-8?B?VG1sSWhHSzhGWWxzUGJ6RGl3bjdZM1pFLzJhelRIbnpSbmNPeVNYQWVYQ2k4?=
 =?utf-8?B?QmdseGVCRS9ubG1wM05nbThSQlNXV0tQdmJsODlwU2V1YlhuT25xTDk3a3hm?=
 =?utf-8?B?OXRxYWdKRVdHNUJGRFhOV0FMM3RwMWREQUZNeW9zMEtIQzF1UVNhSUpJV3Rk?=
 =?utf-8?B?aE10eG9UTjBMelIwckJ1QWVBL3QyWjZCZGlNZXhyb2JTbVQ3SUpmaDN1RXZU?=
 =?utf-8?B?aGZHOXVIRDRKQ3B2VUZMWnlxWTBjQzdtZnZYa0E5WVFaakhFQjZ4R1NDNW1K?=
 =?utf-8?B?SG5PWHZVeXVmUzBDWm5SaEFjZHNZaTJmbU5FWkJUUWZETU9hTkRDYldtK2l3?=
 =?utf-8?B?OCtVMkJOcEZKUC9wd2thVDhZS0cvL1pmWWlMSTBGUnA2WFRDY1JWZ25qNkVo?=
 =?utf-8?B?YWJIbTFOSGErMGd4Qmlnc0t2RnlhZUd0NXJwWFhvbjZlNGhMWllqdkNZMS9V?=
 =?utf-8?B?ekdhTUUyWXRoNWxScW5QK0lvTHVsTzFxTGV3VUNzekcwOHhDZnRhM3hGZDJP?=
 =?utf-8?B?TWtaTHhvZ3pxVEtoTDl5WjVGQjRvRkZqY0c5L1R6U3VnbHY3amdXLzNobkdz?=
 =?utf-8?B?Y3l6cjhqZjBTckM5MU1oOUs5cTBxV3R1NEJZbFFKMlFzUGJ3T1hCQ25WZHc0?=
 =?utf-8?B?RUl1Vm1KSW5XMVVFZHhvNWdYdVdJa1d0bXJOYzFYTFNNSkFTRnozQlNHRE4r?=
 =?utf-8?B?TnJIaVMySnhpbEFZcEZwS3YvK0Npd05SdUorNTg3Vlg4SVBxT241c1FaMmRo?=
 =?utf-8?B?VmpROHdwTnJzZnFuU3pkVjlQNHVvWUxTWmg0WS9VWXdWRTRYMC9HM2VyeVhx?=
 =?utf-8?B?QUpVNGNmQ2xtSmJldWJrb09xNmNZcjlmK1ZGaFVYQmlXMklWWnhyNHhmVUNF?=
 =?utf-8?B?MVM5bzQrNmd6N2p0L2p4TGp6bng3czV3UlZXSEJ5Yno5bXhHdk03SCtmcjF3?=
 =?utf-8?B?Y3NlQ0orVkZ6ZSsxcFp3VDVtQ1IxdUFrOE5CUmJHdklvSkN3L25IVENuRUlV?=
 =?utf-8?B?OXM3VXhRM0t1MmVRTW5WYXcwc1RqRE5hRERmZWIvcVRTNjFqc0wzd1MyOFIz?=
 =?utf-8?B?V3VHWGFKakJLTkhhK0hUdlVnaG5PWG1XRkRhQ1BiSVE0dVVuc21MbmZTTEVp?=
 =?utf-8?B?WEZPMUxvdC9wNk9WWExNTmNKM2FTTG1TMWlETXpaalUzbCs5Mm51RW8zZ3lF?=
 =?utf-8?B?LzhnSlFxZnRla3dWOU5MT3dtTGxQWFNmUlU1YU1Ia2ZKakZQL202OFpsQ0pT?=
 =?utf-8?Q?FuJrOu+hIQSiDb925a28ypI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXRLWlI0UG1rUzVPTjZmUnErTVVSbitEbExxWnI5ME5rbVR0d0tiRTEwa3RW?=
 =?utf-8?B?RkwzN2RpbzZmRzlqQ2VmekRmUlJNRGptMWtOalRhWWFhaGN1Z1FzNDE3c2ND?=
 =?utf-8?B?dGRlZ0dBSUVwOGZoUERMcWE5OFZKZ2FrTWpmb2FBSGxyNHpocXhTekZDa1lM?=
 =?utf-8?B?N25ETlRlWlkyK1JuWi9ib1RmMjE1bkJJblBrSDZDZ21BVTc1UnczNmpXWVNC?=
 =?utf-8?B?OThFSFozaUZxRERYN2o2bW1jUVcvaEJqOTVzUnJLOGpCajRKRGNGZGZJYTN4?=
 =?utf-8?B?UUkwQVdyQmJxOURJSW92WVovVFhaQzlqK1Bhb05MbGw0TVN1OFVYc1pTc0tG?=
 =?utf-8?B?eGpTU3BFeWhvOVpobStWV1VjWDV1L1JoQ2dhOG5TT1E3TmEyS3BFamJuaDZF?=
 =?utf-8?B?QlhWc3d5M0hwNXl4WVdpdDFZeThmMTcvemRvWlY3MUNyNnlXeTdFTUQwbUZG?=
 =?utf-8?B?VmptZDhLSzFZcEVvOXltL1lZVEc0WXRLRGRrTmVNVzNOQ1ZxYkQ3RnFZejN0?=
 =?utf-8?B?ZWxHSHBMd0hvK0J5U3M0MGxzU0grSVlnL1QxWURKSnRsMmdxSE5jSWxJajhj?=
 =?utf-8?B?VWRneGVqcmsyZ04wVkdWeHBpTURuSXBuZzRvTVZIdUFVUjVvZmhwbXFTYWt6?=
 =?utf-8?B?UTdVdllXTCtpSHBINGRZNUpPL3FMYk04alZ3dk1iWGxyQVU3VitwWllwenJh?=
 =?utf-8?B?QVlabkFwalQyaFcrZHVPMzVxcnpOZ1FQY2trSHlQbzVjR2pjUFU5Z1BpVmhi?=
 =?utf-8?B?YlJLUG9FbFQ2L3BPTG5ZT05iKzdnZnJYbHNDMXVLQzhaUzFtUnA4V1RLN2xx?=
 =?utf-8?B?Yy9Yd3FDc0d0M3Jyeis4MU9PbGswR0N3bGZESTA0NnUyVHNrUThNK3FSbzRE?=
 =?utf-8?B?WFAyR2NrMnhpYlBGVitySU5rUVh4YzIwNHBydnZKd3g5a3AzUE1saGxMekJS?=
 =?utf-8?B?MDRqTnJORDFHeGFPZm9YZzZrWDlTdWs5dlJtWDU2ZFlzZUxlamI2SkwyVyti?=
 =?utf-8?B?ek15T0pFaTB2UVhvSVVHOGl3ZlhYMEduTHVySlMvQWc3Y0RNdTdmZXo5OTBJ?=
 =?utf-8?B?Z0tvZFZ4QWpCVVE3S0ZFOEI2QlI1VFlQSVZpMmEyS3I5K1FJbzRHS1RkM2po?=
 =?utf-8?B?NVAycFJ3YTcyNG15WlJCaVpId05kV2haTG5rclRwdS9jblVlcVFYa0lFUDNs?=
 =?utf-8?B?c2FVZ0VjRjR5WjRxOHNKK3NCbEpybXRQOEl3cXFjK0pVVi95L2dxZmZRQTRn?=
 =?utf-8?B?bUh3anRNbk1hM2Y3dVlGdmFjVXZxeUl5dnBVWEU3S3VYMzNHaW1YMFFsaHNk?=
 =?utf-8?B?MXFvNVlvZTdxVElkYk1hcStmaG1XQXJ4UFhEN1NxKzdiWEMzVkY5L1NVSjd4?=
 =?utf-8?B?TnNZWmQ4SE5yZTBjSnkzQktjNS8yUmxXaXFCZ3F2VCtLenJJTTRETUxlWjla?=
 =?utf-8?B?WkoxVGJyRjJuQ0plZXFla1UrUGo0Wk9Pb1FrTHhxMWtmNHRiSGNQdllVNG1X?=
 =?utf-8?B?VUhkQzFwd2hFOG9qY0pFY0k0eENBc3lIdjhLdGMvazc0UDRHMmt5Y0kxanBa?=
 =?utf-8?B?aUg0RG1LSkZSempLdmEvZGpkdllic2pBcm54ZDdYaEpQWVlpd3laRnBBVjlq?=
 =?utf-8?B?cmtSeXpHTlUxZVQ0SWNROHcwOFVFYWRuNGc3QnRKUVlnRlhOV0M3eTB5aUJK?=
 =?utf-8?B?cTN4V0FJWHBsZ3gzYTBmZndYNkN5clE0WC9TVE9nbTRCWjR4RGJWWElCenoz?=
 =?utf-8?B?cno1QTFtV2dtc3JKVWNHeUdyU0prY1pXMGQ1djYwRTh1cXljWXR5Vk9nZXhi?=
 =?utf-8?B?RzFpaGRvWXN4WjhuVWJNTFBwTXMvdzlOVXlyZkhia3M0a2VRYXdrampLcHpz?=
 =?utf-8?B?SmJOY0oxc1orNXBrWHI2SU1BbXdSMmNFNVZwVUl4WTBPZFpvWm90UDNHY1V5?=
 =?utf-8?B?aXJRbE5iTHRHN0RwM1k0OXFTKzAraTBZclF6VlRRdW9HWDR1dThuVW9TaUlv?=
 =?utf-8?B?QUs0Z0ZmQmZQemo2L1dBYXIxSkVWUnFIVkpVMkNRVUhyZXNjYjM3SStSbHIr?=
 =?utf-8?B?NEt6VGVqNFlxZjk3R2g4akVyb2Q3YWlzbEZ1M2F2cU51YTVuS2xpQ3hhaEpo?=
 =?utf-8?B?YmpOT0xqWkJxTFpjc0NFVTYxNFp0SGpHOWVKZFk1ZEthc1U2alk4RE9RTXlF?=
 =?utf-8?B?V2MwMGJPTHl3T29POHZFQXh5bWVvK3JldVhDYmhiZXI4MWZZN21zWVp5ZlMy?=
 =?utf-8?B?Uzd3ZWpPZnU4QWs0V0RrcE9uRjdTcmYwMzFWRUdqUUNjeHZHQjUvVWQrK0g0?=
 =?utf-8?B?NUdGTktVY2xZTXNhRWpUVklCcW14dDB5c0xkczByUHRYZUp0SlBqejg1clZY?=
 =?utf-8?Q?2zozQB8VDlyo04sKmHNjjcAKDMO8Sb+RRj5SN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2491C7D25D775C4CAE9050D64939F04E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01aa625-8139-419e-3831-08de5d2df070
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 22:55:02.1292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6WFjgmTykGqHgiNb3YXcbNM8fC7/ejEdo+x/VYjSD2M/PrsbMy+G9g8qiDI2CdE6NMFeHqBnQ+o6N7YfHAenQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5531
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=6977f0c6 cx=c_pps
 a=fYaSdR3m0whpxnlOBVIaHQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8
 a=KBVUG00mDK2Yv5t489gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lYwGFwSVrC4pzym_TnRPzGAJ4boRKDwd
X-Proofpoint-ORIG-GUID: QHPK54qVsEFGLyjQ4Fz9cn09hEjg-aC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE5NSBTYWx0ZWRfXxYHWWZht7eeI
 32FYb9cu2rNicCA5cNOUJWpDfCXBFDFqwDLx392JP9BGrin2LwWEP/rZfyEzzRgFDP2h3Q/5u2Z
 n1QekRWBEWrN+BeYzIKDgeNsdYQzvqA6j4jFgypGUwCfzOvmPcPu/6LUWbXucgNb4TjI/vi5ijl
 3zCwOtBEyB/gpeXcGmvpOg3G+z/dfpKPEtfYZDehe6BdKqDFGFVS6xcGCSXCcFV4tzVwZNh/ski
 /TRo4hG2iofIJEgy86W3gyqhciihaT2vPMwTVvDfCA7l7wmRcPvfmxdb1Prj2MCHaH9zpAf1AB1
 i/XJjYrWyiqfOv5CmbYmV+5L8UXfR6CfPfmhT4nvshPDfyLuWjn5HTDMW6lpYtQ9vP4elhl/3u+
 IAiqro8V/DWgACskKReEdaa+kjqXhSdwwTrBaV/vy13b8kCKYPaxMosK6hK0k2mhyuEc7Rcbb2T
 FKX/wg40rhVzr66pS5Q==
Subject: Re:  [PATCH v3 3/4] ceph: remove error return from
 ceph_process_folio_batch()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601260195

T24gU3VuLCAyMDI2LTAxLTI1IGF0IDE4OjMwIC0wODAwLCBTYW0gRWR3YXJkcyB3cm90ZToNCj4g
Rm9sbG93aW5nIGFuIGVhcmxpZXIgY29tbWl0LCBjZXBoX3Byb2Nlc3NfZm9saW9fYmF0Y2goKSBu
byBsb25nZXINCj4gcmV0dXJucyBlcnJvcnMgYmVjYXVzZSB0aGUgd3JpdGViYWNrIGxvb3AgY2Fu
bm90IGhhbmRsZSB0aGVtLg0KPiANCj4gU2luY2UgdGhpcyBmdW5jdGlvbiBhbHJlYWR5IGluZGlj
YXRlcyBmYWlsdXJlIHRvIGxvY2sgYW55IHBhZ2VzIGJ5DQo+IGxlYXZpbmcgYGNlcGhfd2JjLmxv
Y2tlZF9wYWdlcyA9PSAwYCwgYW5kIHRoZSB3cml0ZWJhY2sgbG9vcCBoYXMgbm8gd2F5DQo+IHRv
IGhhbmRsZSBhYmFuZG9ubWVudCBvZiBhIGxvY2tlZCBiYXRjaCwgY2hhbmdlIHRoZSByZXR1cm4g
dHlwZSBvZg0KPiBjZXBoX3Byb2Nlc3NfZm9saW9fYmF0Y2goKSB0byBgdm9pZGAgYW5kIHJlbW92
ZSB0aGUgcGF0aG9sb2dpY2FsIGdvdG8gaW4NCj4gdGhlIHdyaXRlYmFjayBsb29wLiBUaGUgbGFj
ayBvZiBhIHJldHVybiBjb2RlIGVtcGhhc2l6ZXMgdGhhdA0KPiBjZXBoX3Byb2Nlc3NfZm9saW9f
YmF0Y2goKSBpcyBkZXNpZ25lZCB0byBiZSBhYm9ydC1mcmVlOiB0aGF0IGlzLCBvbmNlDQo+IGl0
IGNvbW1pdHMgYSBmb2xpbyBmb3Igd3JpdGViYWNrLCBpdCB3aWxsIG5vdCBsYXRlciBhYmFuZG9u
IGl0IG9yDQo+IHByb3BhZ2F0ZSBhbiBlcnJvciBmb3IgdGhhdCBmb2xpby4gQW55IGZ1dHVyZSBj
aGFuZ2VzIHJlcXVpcmluZyAiYWJvcnQiDQo+IGxvZ2ljIHNob3VsZCBmb2xsb3cgdGhpcyBpbnZh
cmlhbnQgYnkgY2xlYW5pbmcgdXAgaXRzIGFycmF5IGFuZA0KPiByZXNldHRpbmcgY2VwaF93YmMu
bG9ja2VkX3BhZ2VzIGFwcHJvcHJpYXRlbHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTYW0gRWR3
YXJkcyA8Q0ZTd29ya3NAZ21haWwuY29tPg0KPiAtLS0NCj4gIGZzL2NlcGgvYWRkci5jIHwgMTcg
KysrKystLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvYWRkci5jIGIvZnMvY2Vw
aC9hZGRyLmMNCj4gaW5kZXggMzkwNjQ4OTNmMzViLi5jZGYxMTI4OGQ2YjcgMTAwNjQ0DQo+IC0t
LSBhL2ZzL2NlcGgvYWRkci5jDQo+ICsrKyBiL2ZzL2NlcGgvYWRkci5jDQo+IEBAIC0xMjg0LDE2
ICsxMjg0LDE2IEBAIHN0YXRpYyBpbmxpbmUgaW50IG1vdmVfZGlydHlfZm9saW9faW5fcGFnZV9h
cnJheShzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCj4gIH0NCj4gIA0KPiAgc3RhdGlj
DQo+IC1pbnQgY2VwaF9wcm9jZXNzX2ZvbGlvX2JhdGNoKHN0cnVjdCBhZGRyZXNzX3NwYWNlICpt
YXBwaW5nLA0KPiAtCQkJICAgICBzdHJ1Y3Qgd3JpdGViYWNrX2NvbnRyb2wgKndiYywNCj4gLQkJ
CSAgICAgc3RydWN0IGNlcGhfd3JpdGViYWNrX2N0bCAqY2VwaF93YmMpDQoNCkkgc3RpbGwgcHJl
ZmVyIHRvIHJldHVybiB0aGUgZXJyb3IgY29kZSBmcm9tIHRoZSBmdW5jdGlvbi4NCg0KVGhhbmtz
LA0KU2xhdmEuDQoNCj4gK3ZvaWQgY2VwaF9wcm9jZXNzX2ZvbGlvX2JhdGNoKHN0cnVjdCBhZGRy
ZXNzX3NwYWNlICptYXBwaW5nLA0KPiArCQkJICAgICAgc3RydWN0IHdyaXRlYmFja19jb250cm9s
ICp3YmMsDQo+ICsJCQkgICAgICBzdHJ1Y3QgY2VwaF93cml0ZWJhY2tfY3RsICpjZXBoX3diYykN
Cj4gIHsNCj4gIAlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gbWFwcGluZy0+aG9zdDsNCj4gIAlzdHJ1
Y3QgY2VwaF9mc19jbGllbnQgKmZzYyA9IGNlcGhfaW5vZGVfdG9fZnNfY2xpZW50KGlub2RlKTsN
Cj4gIAlzdHJ1Y3QgY2VwaF9jbGllbnQgKmNsID0gZnNjLT5jbGllbnQ7DQo+ICAJc3RydWN0IGZv
bGlvICpmb2xpbyA9IE5VTEw7DQo+ICAJdW5zaWduZWQgaTsNCj4gLQlpbnQgcmMgPSAwOw0KPiAr
CWludCByYzsNCj4gIA0KPiAgCWZvciAoaSA9IDA7IGNhbl9uZXh0X3BhZ2VfYmVfcHJvY2Vzc2Vk
KGNlcGhfd2JjLCBpKTsgaSsrKSB7DQo+ICAJCWZvbGlvID0gY2VwaF93YmMtPmZiYXRjaC5mb2xp
b3NbaV07DQo+IEBAIC0xMzIzLDEyICsxMzIzLDEwIEBAIGludCBjZXBoX3Byb2Nlc3NfZm9saW9f
YmF0Y2goc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsDQo+ICAJCXJjID0gY2VwaF9jaGVj
a19wYWdlX2JlZm9yZV93cml0ZShtYXBwaW5nLCB3YmMsDQo+ICAJCQkJCQkgIGNlcGhfd2JjLCBm
b2xpbyk7DQo+ICAJCWlmIChyYyA9PSAtRU5PREFUQSkgew0KPiAtCQkJcmMgPSAwOw0KPiAgCQkJ
Zm9saW9fdW5sb2NrKGZvbGlvKTsNCj4gIAkJCWNlcGhfd2JjLT5mYmF0Y2guZm9saW9zW2ldID0g
TlVMTDsNCj4gIAkJCWNvbnRpbnVlOw0KPiAgCQl9IGVsc2UgaWYgKHJjID09IC1FMkJJRykgew0K
PiAtCQkJcmMgPSAwOw0KPiAgCQkJZm9saW9fdW5sb2NrKGZvbGlvKTsNCj4gIAkJCWNlcGhfd2Jj
LT5mYmF0Y2guZm9saW9zW2ldID0gTlVMTDsNCj4gIAkJCWJyZWFrOw0KPiBAQCAtMTM3MCw3ICsx
MzY4LDYgQEAgaW50IGNlcGhfcHJvY2Vzc19mb2xpb19iYXRjaChzdHJ1Y3QgYWRkcmVzc19zcGFj
ZSAqbWFwcGluZywNCj4gIAkJcmMgPSBtb3ZlX2RpcnR5X2ZvbGlvX2luX3BhZ2VfYXJyYXkobWFw
cGluZywgd2JjLCBjZXBoX3diYywNCj4gIAkJCQlmb2xpbyk7DQo+ICAJCWlmIChyYykgew0KPiAt
CQkJcmMgPSAwOw0KPiAgCQkJZm9saW9fcmVkaXJ0eV9mb3Jfd3JpdGVwYWdlKHdiYywgZm9saW8p
Ow0KPiAgCQkJZm9saW9fdW5sb2NrKGZvbGlvKTsNCj4gIAkJCWJyZWFrOw0KPiBAQCAtMTM4MSw4
ICsxMzc4LDYgQEAgaW50IGNlcGhfcHJvY2Vzc19mb2xpb19iYXRjaChzdHJ1Y3QgYWRkcmVzc19z
cGFjZSAqbWFwcGluZywNCj4gIAl9DQo+ICANCj4gIAljZXBoX3diYy0+cHJvY2Vzc2VkX2luX2Zi
YXRjaCA9IGk7DQo+IC0NCj4gLQlyZXR1cm4gcmM7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbmxp
bmUNCj4gQEAgLTE2ODYsMTAgKzE2ODEsOCBAQCBzdGF0aWMgaW50IGNlcGhfd3JpdGVwYWdlc19z
dGFydChzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCj4gIAkJCWJyZWFrOw0KPiAgDQo+
ICBwcm9jZXNzX2ZvbGlvX2JhdGNoOg0KPiAtCQlyYyA9IGNlcGhfcHJvY2Vzc19mb2xpb19iYXRj
aChtYXBwaW5nLCB3YmMsICZjZXBoX3diYyk7DQo+ICsJCWNlcGhfcHJvY2Vzc19mb2xpb19iYXRj
aChtYXBwaW5nLCB3YmMsICZjZXBoX3diYyk7DQo+ICAJCWNlcGhfc2hpZnRfdW51c2VkX2ZvbGlv
c19sZWZ0KCZjZXBoX3diYy5mYmF0Y2gpOw0KPiAtCQlpZiAocmMpDQo+IC0JCQlnb3RvIHJlbGVh
c2VfZm9saW9zOw0KPiAgDQo+ICAJCS8qIGRpZCB3ZSBnZXQgYW55dGhpbmc/ICovDQo+ICAJCWlm
ICghY2VwaF93YmMubG9ja2VkX3BhZ2VzKQ0K
