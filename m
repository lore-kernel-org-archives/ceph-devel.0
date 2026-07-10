Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F53B1E531
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2026 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701240; cv=fail; b=eJC4LIWepdiYyRs8M43Jk6Fx1ReNubVDVgjR5vMuzEs0C5kcXMu1zmBECmUQtjr+oPre7/PahsSS/oW82eFtZAnMlKH2QZs0Nd40ost4FbMTCPMABYMCFb9VOYPcRbybYt1gXoCpzwORNY7Csl3bGdHBkpCrRxPelXW19mdlcOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701240; c=relaxed/simple;
	bh=veuFPmxxwVqiIhM1igtIv+3TUAmRrJwnBtZbECxACY4=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Kmetk6kdmonHUL8ETC846aTGmTmy8xP5MAo9XPXCmlA2HcTXOyKhiATg0xbpAOJHNGNDsE2tbYCOI9Y02olFsRH+CKhOLVO+Bflj/fhHH6hlCyqghxGwUI/7NmFrEaJEaRS7PjcB2mKY7fBNcMoo4J4CEqOSFR18ODkCI18vAck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lv4HXcHo; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lv4HXcHo"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEmSq51406404;
	Fri, 10 Jul 2026 16:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=veuFPmxxwVqiIhM1igtIv+3TUAmRrJwnBtZbECxACY4=; b=lv4HXcHo
	SROvSvomOV+djNIWgVq7wVTRR82slczj4Qy4vpwrULRFuR/L4ecnA4yC/ydrcokk
	H2XbhmbbFLJVMQlAg6Yipj/no7HjLf9nDrzuE6Oq1F77Xx/TM2E/w7HsVSXu3sRP
	CiU4Qejfe3xDCz4Xuqd3cCiYFn92bW/ZkItG94uoftZ4Kq8dfnYw8yNbm/36QNNl
	fSk/1ecbJfNQ3UKM3zXFZ1Uikvp2xuwMPoEE3aptmEhTYoqUJVbWjywSIsADvtLA
	3w0EXQelBnGxPG+pDAJLNq8mMBFmSpPwUM9ZOd764GM0cW/aNsfya0b+FRFAchGR
	XNPzAT3/o5s8Vw==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fafh0cy7q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 16:33:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvxRTQlHQG9hZtT8E8BZpRrpRPoOZm7eDj44ixPFKw7STi/SS8mDke0WVWEfzd9d1OeHjFO+sc1V5xvE6jcxNR/L8ozndt5vMVta3d6KrY/qbJlh+0jo06fpgLjnuhoDhaWYSglBcmHAlT5M3fCvb2bXBzrbpSLRPfcfoxZeA8O0UUg1QTdMg8wXUfApM6sDmZiX7SIDfLG97Ij3Zz0lj+eJbqiwsTLCPTaE5ZGcfLjwXHbJiAqIL4tmDCWbCyo8OzE7ZCkOsQTUbgMKMnL/YUng4puyeXknMVBVhz0rZu/hfOaX37dmS+tA7Inp7O47V76lsrIOjSMQO4XoMBH3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veuFPmxxwVqiIhM1igtIv+3TUAmRrJwnBtZbECxACY4=;
 b=ZuB+NRnJLDlEIu3lcxGprU9yqvAtZ6HCYxCFvfjv+Z3t7koZgwZ01lzXkxCWoiUNmuRsE7T5jrfIPawIMmbWJrO/EGf3ivt0xh+OWBSj5xMHhBQIzcnaTxBFPL9UYMBCtqpymB8nDFCSwKX2MpfgPNZeB6ssSBBRB5Z4LcDROBbMD/zl2k7A4BT730wSFUJTeu90rCG/GaS9yokYraPbQdrU++fIfVKN+h6roYKsl4uZW+S6hf5Xh/CyLfedwNue/IebDDnnSf2f283xKU9llwGSOegjLjZt2Bcq3Jk1HWVbfz6LRG2Vy4LN/WwyTye+DCdMVkTjZ8znABZVBdFiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW4PR15MB4636.namprd15.prod.outlook.com (2603:10b6:303:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 16:33:51 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 16:33:51 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "enjou1224z@gmail.com" <enjou1224z@gmail.com>,
        "edragain@163.com"
	<edragain@163.com>
CC: "sage@newdream.net" <sage@newdream.net>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "dstsmallbird@foxmail.com" <dstsmallbird@foxmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Alex Markuze <amarkuze@redhat.com>,
        "yuantan098@gmail.com" <yuantan098@gmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH 1/1] libceph: use RCU to protect monmap in
 ceph_compare_options()
Thread-Index: AQHdEBIf6Fg9j8Yag0KXlhI+S/0Ea7Zm86GA
Date: Fri, 10 Jul 2026 16:33:50 +0000
Message-ID: <522d0bf88c127d2c8ca4f4e5055e77e2918d4bd2.camel@ibm.com>
References: <cover.1783423648.git.edragain@163.com>
	 <f9b8b94904378d14111606a3cfee801c60492681.1783423648.git.edragain@163.com>
	 <f5c76ebace1493337d01385088c5ad066abc1689.camel@ibm.com>
	 <235ac7b2-cb4d-474b-87f0-53a5962de59e@163.com>
In-Reply-To: <235ac7b2-cb4d-474b-87f0-53a5962de59e@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW4PR15MB4636:EE_
x-ms-office365-filtering-correlation-id: 7d0d6688-95d8-4fc6-8c3e-08dedea10658
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10070799003|22082099003|18002099003|11063799006|4143699003|38070700021|6133799003|56012099006;
x-microsoft-antispam-message-info:
 JAhNkHKWRBJL9bby0HbreuXLqpdZam668F1pj+nYjFoaynSohGJCorVEnfApj56HjEQhujPWfmQyVFgwGiPYRmQ2I0DULFlaByvt80wzRk6pCJFGZTTGycI8OsrQQ/W8+BkdEhRTzt1t353/JR6YFoyLGrykOk0HRIE+bEyHZvLVJFOjECewSBgIOyQJmyBLOoYQzFPKaSdZnq0qKOLW5egOExaOnL2u1Cbz5eprKae45MTUDFu7Ptxx6Faip4i0+R5JuLtotYID852HA01sSI9/4lk13XKNWPRkDnoR9mT8DnQXA0jVxegfXRAWt2Qzo1K2nR++1hXiH6H213YP5g14oT4B4kjmdXu7aqPmZ24wTrjJHhij/sVzhvKzgCotM2iS0RQv+AmgeXYZ/SYc+iy6UijrmXgdlDfCwDE8z7sPz1HbVDrBNzUAscJeJxHIucfCFFXUuH9nnugWW111Kea0QAa73NwX+EqiWPVHeLiMlQyI4IHmnOOWuqKMnubUcAu2SgfzrexIHws9MEDBM7h5Sao85rfC7qS3NMQGw1sl7VCVk1QDiKpestqTJyXsKPb25/PUXxOkNUxX1a0m47uoaZjggpTTzRLV5CrxlZ0ckMGEj2IwZ7r8hIzdJo1TSu3us8oszUTVn0KQ+U8bJ+DsJvRUl5aU93zfOWJG1O/+N3uEj9NSU2LrT1sCbBR5kEH5W50jJk+XRIAl+kKjoDM1WweKUeta2s5nZ8I7pE4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10070799003)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021)(6133799003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnQ2WEVFbmc4cFFGdWVpeDFydmtNc2dGUUVEUmdpQmc2Rit6dks1cERkbWtP?=
 =?utf-8?B?U04yU1Q5WFhQTU4wZW9FK1BZT0ExckJENlpuekNWTFpEd3pja0FEL3ExTFl3?=
 =?utf-8?B?cVprbWJnanhpZlRrNU1iQTc2ZWUzRUdSUnZBQVoweW5mZGR3WFEwZk1zTHhj?=
 =?utf-8?B?REpkMW11M3N4MDVYdmdtMXZrYjM0S2QzeGhiSlpzcHlLMzB0UUYxbkU2bCt6?=
 =?utf-8?B?S0Q0MzE3QmZsdGJCc2Z6dDlvTUNGOTZjSGJpL044U1pyN0YzTGU0TnF3MWVh?=
 =?utf-8?B?SG80VFhIdWFYUmJzSm9OVDZHSHh3bW1rK2ZiU3QrRjV4NjBFVlhVZlNWcEdh?=
 =?utf-8?B?U2NSc2s0SU5IcWNycGdta20wdlVqbmdiRGhpRXEwTWgwOWhOWVJoTE5zRmZz?=
 =?utf-8?B?K3FYeGlOdHU2NnFDOWVPSVVQeTBkUWN0Mng0WmVBRHRBcGhsS2Q2OVoxZHlN?=
 =?utf-8?B?V0FkaWVEYUZ4ZWY3ZkdtMlBZU0hvWThBSm4ya3ZDc003ekF5Zk5GaW56Vm1k?=
 =?utf-8?B?cFhtTjZBSUJEQ1NlVDh5dk5yRGMyek1UY1JZV0FNYUNwb05HV0FOaGlQRzdw?=
 =?utf-8?B?UEQ0N2VYNlE3VEdHWmFhWEJNUUc5SXVmR3RDcTNoUlphQlpwR3lFbW5tR0J3?=
 =?utf-8?B?bnA3SEJMVW9EaHYzcDBhNlpEelJRZlkwVy9wSDc0ZndJNys1TU93L1c4Umdu?=
 =?utf-8?B?Q3VsWS8zREcvUFkzVnZsTjNyc0w4REtkSkVDOWQzZUFNSllOa3F5cmp2bEk0?=
 =?utf-8?B?SXkxTjh1REZzbW80M3VrVUp1M1NXc3RRUE0ra0o5ZDVwMU5Xd0tqRDhIa3pz?=
 =?utf-8?B?VzhYWTVEZ01zNEpnTjdlZ1JrdmdaMzh5VllEL0M1citJUTFjRmFBaVEzTEV4?=
 =?utf-8?B?VE9hbEtHVXFMZDM0SFpKODEveiswMnFreDF4ck9HZVZMZjVueVRFeUc3QjVa?=
 =?utf-8?B?T1prbk9CVFM4Z0hYSVYwVTlIdG1wWXY3U2N0TTR2YUoyYWk4Qm55Q05ZcHNl?=
 =?utf-8?B?V0Q3T2MraGJpejdhRTk3U3V3MzRpN3RjQTNUeEZjVkFtcUp3SHlwOHNFNEZ3?=
 =?utf-8?B?eFJDMldyMFdWTThubmtrL1lHK3lTazB2QmVWUllXSCs1aVpwRndMbCtzVGo4?=
 =?utf-8?B?WWFNSU9tVU5rU3hqNWp2WGxEQ1FGc0ZIdzcxQmRTem1Hd3IvRkwzZTdmalN4?=
 =?utf-8?B?UDZQWDJmeURLVnh2OC9KWGNrdUF0S2xEYUx5czlwTmdaNDZWcE9Ldy9Ga2Fa?=
 =?utf-8?B?V2dnZlQ3dElaT2Zlcjk3dUJBRjRoVzB5MDhLaVAzMW84MzBwM2luUFhHSSsy?=
 =?utf-8?B?RDNQYWtmN0xwblE1dXJIdm5qWXh0U1NRQ0ZhOHBaK0E3cjZnQkRwa2x5QUZi?=
 =?utf-8?B?M0Q4T3p6VmV6V0dHa1BzbHZOenBDQlROcVUzN0pMb01ISlBmdU1GWktxdHNo?=
 =?utf-8?B?NUhNZ3Fjc2JaV0tnVHE0M0xqOFcyRlBRRUZTSmhMcVlDbk1mQStVZUdwME82?=
 =?utf-8?B?c2RmNnhxYnhsUkl6bG1uYTYzOHFvOVk5S2dTVHEvTGgyK2Y2K0gwTDIzcVls?=
 =?utf-8?B?RUl3NStCZ1JMNnhnalJpY05Ga3QzcFpKWnRab08xNlNZTkRnazF1aHRmNXFR?=
 =?utf-8?B?aEVNSGhMV0RpNmR6Q3Mrb2ZWRkdTYm1IZk9GQ3ZFeHltU3cvcXBDcDZSZ0N1?=
 =?utf-8?B?amRpSEdHckZZbVdZMTVPWm5lMkx1VFRrSUk0Rkh3bmg2SXdQTGVDWkxQOWVZ?=
 =?utf-8?B?UFhjeFlhelV0VGU0dWVBQjIrZGpPdW8wY3JFQUdkbXIvR0hqSHRrZnc5aXR0?=
 =?utf-8?B?cyttQlR2MWUvNnVPTHIyaVBlSElHUzJMVlE5ZHRiWGE2b1lMWWZMcmNGbmYz?=
 =?utf-8?B?bjRadHg2Q2g1emZQSXA5VS8zRVFWV3NmWDIrblgzeUc3Tk9KYmJtNCsrNlNj?=
 =?utf-8?B?UU5Kd0FCYXRCWVErQjlzYzNZc2psMzdEZXg3V3p2ZEJuVkp6cmJrZm51R3d0?=
 =?utf-8?B?d0RWMXZ1dE8rVDRQS05EQndYUnlRUjdJNXdkRlhRZ1IrUjNOV3BFWTRraVJa?=
 =?utf-8?B?SDA2ZEtTOFVqemdLRGRXSndRZ2Z5NFhzd1N0RE13eXRrZHNNRGNna1JaeE1y?=
 =?utf-8?B?elFuSk5DaTFJaTZGZXNkOWFRKy9TanBscVV4THljTk0vQjB3bUZOU0V4S1FB?=
 =?utf-8?B?SWZCQlE0aTB1OGxhV1lZRG1IZXZoRGdRUU1jK0NmbHgyNnhCelFDc3pCVFpq?=
 =?utf-8?B?NFhlK0x3N3dCV2x0MFl4WWt2K3BMVVdwbWdWWHl1eFNMWis0b0YxQU44V2xI?=
 =?utf-8?B?UDVVeVhhQU1yQkR0dTJLMk5BL2NzWTF4T1QrVk9senN0YU1LUm5zNndEWE8w?=
 =?utf-8?Q?bhRXV/WDLqWNn7w9Y78FwQ2eXBgLn0xFWIkyF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B90FC22DA09BE94BB0E4D0EEFAC99E67@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UZhVvAKh3kmP5ZODuhmhDszfMPK1g+DDNS+sWccFvo/v6sWtpocLCaSjODFFOTBIZ9LOZl948/lxlJyNDjPYlHA7N9VarIYBmtYtIkNiJyUzf9UL8lgIuG5/iGRbKp8bVuVwIUspKsUB+Ksr+f7b33eJYpq/SC2/hMfI/3mr11fTG5Dk0qTwTvhuYMNe4bYinEoSD62fMExD6w0pQFMs7kIjtEKkTxcdVAY3Lo2r6eEKe9IsuBwoEQucRz4qb6epCC/CCJmXBj4Vo17jtfd5lLjYNN09kogXipKjKiFX79vBoCL6NmsuTAS4SUG8WNuE0uP1PehqWst5wDJLzqroYQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0d6688-95d8-4fc6-8c3e-08dedea10658
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 16:33:51.0251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24BVwL5CzwNTTQWyKCbe+KB7PFeOncx57FU4vQEHKHvXqUSQMtuuj0oO9HQMgyzNFs5ACwLI7DQJXjuTiCcBLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4636
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a511ef3 cx=c_pps
 a=8DpcgsHgAViCMqsLoRaOsQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=Byx-y9mGAAAA:8 a=TJfNseb9o73qE7XCoO0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tgEtDV2vJZewtgzKS_A0iAY-aMZLibPl
X-Proofpoint-ORIG-GUID: FyLxUzGnkG-ZRJeUygKdgB8yv91yhuTG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE2MyBTYWx0ZWRfX5Ectuxf4E0sk
 YbKmJwjPuvlwqmiJQEBp3AyFa9Ce1VddBw/GhCd0baLQUSOhXRXIvQCZGDka/DzpkntaKmvcSNn
 nd2UU+jkFdx7t/1SX8j4AMrK7aQtKLY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE2MyBTYWx0ZWRfX+PlqbKvt8BlU
 fDMfjCxgEfgnfD4YExefycXWIV+yU4pPmauLQLsa/VEPG9z3U4J7ubbUl/BgLx8/BkH5hBJ1Vzq
 Eh7njIw5oCETVFLtY0VObwUfTcUyrIpMYRn0aUga/fqVsnupnHPTnp4RCEot7Yyhr33NFmiXSWj
 V/CG4bBDLYwYV83mHULIXBjju9qR7xGOjBUlalRyuc1+BDfRxRml61FcqG71LtfGufCJD/SwAwZ
 6USgZN1SrPpmhYTtma483t35yHiqLlR74PYjnY+4l+qXQ+ELSMU0i5rEe4LDoXv5XN6uULs4aYs
 t0r4zNfkqh7HvHujc5LsefSjU93Om1sNHPq281apsV0KUYQJNWBWI2uTcN6HezMWuiMnpMK+D46
 GzIbEfmPC4pEl77Nf24oGV7lvYJrLPAlLVnwUdHrIPc85PLdFrdwWN8kCPV/iVAtixT9cqTsxyv
 QyDkNQzVjBHQEhRyymQ==
Subject: RE: [PATCH 1/1] libceph: use RCU to protect monmap in
 ceph_compare_options()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100163

T24gRnJpLCAyMDI2LTA3LTEwIGF0IDEwOjE2ICswODAwLCBZb25nIFdhbmcgd3JvdGU6DQo+IA0K
PiDlnKggMjAyNi83LzkgNjo0MywgVmlhY2hlc2xhdiBEdWJleWtvIOWGmemBkzoNCj4gPiBPbiBX
ZWQsIDIwMjYtMDctMDggYXQgMTE6MDMgKzA4MDAsIFJlbiBXZWkgd3JvdGU6DQo+ID4gPiBGcm9t
OiBZb25nIFdhbmcgPGVkcmFnYWluQDE2My5jb20+DQo+ID4gPiANCj4gPiA+IGNlcGhfY29tcGFy
ZV9vcHRpb25zKCkgY2hlY2tzIHdoZXRoZXIgYSBuZXcgbW91bnQgc2hhcmVzIGFueSBtb25pdG9y
DQo+ID4gPiBhZGRyZXNzIHdpdGggYW4gZXhpc3RpbmcgY2xpZW50IGJ5IHdhbGtpbmcgY2xpZW50
LT5tb25jLm1vbm1hcCB2aWENCj4gPiA+IGNlcGhfbW9ubWFwX2NvbnRhaW5zKCkuICBUaGF0IGNv
bXBhcmlzb24gY2FuIHJ1biB1bmRlciBzYl9sb2NrIG9yDQo+ID4gPiByYmRfY2xpZW50X2xpc3Rf
bG9jaywgc28gaXQgY2Fubm90IHRha2UgbW9uYy0+bXV0ZXguDQo+ID4gPiANCj4gPiA+IE1lYW53
aGlsZSwgbW9ubWFwIHVwZGF0ZSBoYW5kbGluZyByZXBsYWNlcyBtb25jLT5tb25tYXAgdW5kZXIN
Cj4gPiA+IG1vbmMtPm11dGV4IGFuZCBmcmVlcyB0aGUgb2xkIG1hcCBpbW1lZGlhdGVseS4gIEEg
Y29uY3VycmVudCBzaGFyZWQtDQo+ID4gPiBtb3VudCBjb21wYXJpc29uIGNhbiB0aGVyZWZvcmUg
ZGVyZWZlcmVuY2UgYSBmcmVlZCBtb25tYXAgYW5kIHdhbGsNCj4gPiA+IHN0YWxlIG1vbl9pbnN0
W10gZW50cmllcywgdHJpZ2dlcmluZyBhIHVzZS1hZnRlci1mcmVlLg0KPiA+ID4gDQo+ID4gPiBQ
cm90ZWN0IHRoZSBjb21wYXJlIHBhdGggd2l0aCBSQ1UgYW5kIHB1Ymxpc2gvZnJlZSBtb25pdG9y
IG1hcHMgd2l0aA0KPiA+ID4gcmN1X2Fzc2lnbl9wb2ludGVyKCkgYW5kIGtmcmVlX3JjdSgpLiAg
QW5ub3RhdGUgbW9uYy0+bW9ubWFwIGFzIGFuDQo+ID4gPiBSQ1UgcG9pbnRlciBhbmQgdXNlIHJj
dV9kZXJlZmVyZW5jZV9wcm90ZWN0ZWQoKSBpbiBtdXRleC1wcm90ZWN0ZWQNCj4gPiA+IHBhdGhz
IHRvIGtlZXAgdGhlIGFjY2Vzc2VzIGNvbnNpc3RlbnQgd2l0aCB0aGUgbmV3IHBvaW50ZXIgY29u
dHJhY3QuDQo+ID4gPiANCj4gPiA+IFRoaXMga2VlcHMgdGhlIGV4aXN0aW5nIG5vbi1ibG9ja2lu
ZyBjb21wYXJpc29uIHNlbWFudGljcyB3aGlsZQ0KPiA+ID4gZW5zdXJpbmcgdGhhdCByZXBsYWNl
ZCBtb25tYXBzIHJlbWFpbiBhbGl2ZSB1bnRpbCByZWFkZXJzIGFyZSBkb25lLg0KPiA+IA0KPiA+
IFRoZSBhcHByb2FjaCBtYWtlcyBzZW5zZSB0byBtZS4gSG93ZXZlciwgSSBoYXZlIHNvbWUgY29u
Y2Vybi4gSWYgdGhlIHJlcGxhY2VkDQo+ID4gbW9ubWFwKHMpIGNvdWxkIGJlIGluIHVzZSB3aXRo
IG5ld2x5IGFsbG9jYXRlZCBvbmUocyksIHRoZW4gYXJlIHdlIHNhZmUgaGVyZT8NCj4gDQo+IFRo
ZSBuZXcgbW9ubWFwIGlzIGZ1bGx5IGFsbG9jYXRlZCBhbmQgaW5pdGlhbGl6ZWQgYmVmb3JlIHB1
YmxpY2F0aW9uLCB0aGVuDQo+IGluc3RhbGxlZCB3aXRoIHJjdV9hc3NpZ25fcG9pbnRlcigpIHVu
ZGVyIG1vbmMtPm11dGV4LiBSZWFkZXJzIG9ubHkgZGVyZWZlcmVuY2UNCj4gYW4gUkNVIHNuYXBz
aG90IGFuZCB0cmVhdCB0aGUgbW9ubWFwIGFzIGltbXV0YWJsZSwgd2hpbGUgdGhlIHJlcGxhY2Vk
IG1vbm1hcCBpcw0KPiBmcmVlZCB3aXRoIGtmcmVlX3JjdSgpLCB3aGljaCBtZWFucyB0aGUgb2xk
IG1hcCBpcyBub3QgcmVjbGFpbWVkIGltbWVkaWF0ZWx5LCANCj4gYnV0IGlzIGRlbGF5ZWQgdW50
aWwgYWxsIHJlYWRlcnMgdGhhdCBhcmUgc3RpbGwgYWNjZXNzaW5nIGl0IGhhdmUgZXhpdGVkIHRo
ZSANCj4gcmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb24uUmVhZGVycyBvbmx5IHNlZSBlaXRoZXIg
dGhlIG9sZCBtYXAgb3IgdGhlIG5ldyBtYXAuDQo+IA0KPiBTbyBpdCBpcyBzYWZlIHRvIHVzZS4N
Cj4gDQo+ID4gSGF2ZSB5b3UgdHJpZWQgdG8gcnVuIHhmc3Rlc3RzIGZvciB0aGUgcGF0Y2g/DQo+
IA0KPiBJIHJhbiB0aGUgY2VwaCB4ZnN0ZXN0cyBpbiBRRU1VIG9uIHRoZSBwYXRjaGVkIGtlcm5l
bCwgYW5kIGFsbCBjZXBoLQ0KPiBzcGVjaWZpYyB0ZXN0cyBpbiB0aGUgY3VycmVudCB0cmVlIHBh
c3NlZDogY2VwaC8wMDEtMDA2Lg0KPiANCj4gDQoNClRoZSBydW5uaW5nIG9ubHkgQ2VwaCBzcGVj
aWZpYyB0ZXN0LWNhc2VzIGlzIG5vdCBlbm91Z2guIFRoZSBwYXRjaCBzaG91bGQNCnN1cnZpdmUg
dGhlIGF1dG8gZ3JvdXAgb2YgeGZzdGVzdHMuDQoNClRoYW5rcywNClNsYXZhLg0K
