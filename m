Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1E22A7F1
	for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2026 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460719; cv=fail; b=ckOiO+cCh2G0mSqEpLrSjuKTywD5tPHn7lguXaRnmU+qvKe7VvC0TVPNftLx2vknEj3IGiOSy0RqLYIuF73M2YKeymhIkPOl6YAzCKb7WP/L9YvjBOhXokMVXjzHAU0m5hM6la62xZOkA7LrClirpOKcgdc9Qen97qSp86a6K6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460719; c=relaxed/simple;
	bh=YqdCX1V2QXatD7eR8uOQOTl5zMX/wV5Cvw+CRsOkxR8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=jWTiZ1eom5JPNAdz0q/fTbJIwt/ISZtg5B5dLZ1qOq3qDx1Z0H9jAjoRBRX8Zkx6ulwyCkYjQUljJsrEChqhS7tZZW//SxmnOWkc34xYtMH6yyvl6HC5T2a/Jmr1VDxnhwf7Xw4MJ67N2rqAJYKyzOeLGuC0b0YuymHt+qzMngU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I6Cuk8xn; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I6Cuk8xn"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60QDJIY6009492;
	Mon, 26 Jan 2026 20:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=YqdCX1V2QXatD7eR8uOQOTl5zMX/wV5Cvw+CRsOkxR8=; b=I6Cuk8xn
	/Sof3eUb1+G1uX2eDXWemW/S6kcCfuP2nspdN6Qksu6oj/sWlfBHG3aBscLNwYaZ
	eh5cAmHGjInyINzwpjKb5JlPKw8p08PKTJIubshyZHqQpSHHwdcYq6HU1ZTZKksU
	yuMYkp9O5s0lOndQBHYOW5h4g/E3WI3p60YIK5KtkDxa7tAcMheLZKskthI95ZEN
	/viT/ypRlEozgYND+a5Qx0XN/n6vTwtFLA+cLKsR6s6g1r67VyOJL5xrw9fl1S77
	H061zRXwX9LeWXL6t/EIBnD60soU2cH9didyfrNEkvH1uD7zqyqqOE5hei7puFio
	LDkJhSiocEQ58g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrt9ysm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 20:51:48 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QKpmnI003576;
	Mon, 26 Jan 2026 20:51:48 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrt9ysk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 20:51:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IT2aQ/dCgVKzAN5gBkB6e7q1e40NZZ1707hJshDvhzd4WJ0opH/gwtryMde/d49dIIz79QD6vfijj8RQaOo7el7XZi3X8VzXgDKMcHZw8FYDnktezBlDZcp50OkUr7yGrCP5JDvOnk0TtczBpXh51lSHZY8VXPXm5PK/yprg1S4f3Dykqo3IEnsMDT2Yiz4VwrfDicH2mMJKRF056jzJnqthdFWuLuqs0JhuZ9W6F+jMSAvSzgfKDK66xp+nYSIvkuCJxTl/b766BIdE1UIw3dqmtKN2Rc9e2HJ4Vuei3393Vbc/NdRgkR8hb0WpItEpWuV1f0lpEXhaOz6kNRgN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqdCX1V2QXatD7eR8uOQOTl5zMX/wV5Cvw+CRsOkxR8=;
 b=rFBly1KTWmQ+uZjYQDUtElfKM6NEgcanHfBrXe10zQscBtzCypXcAcj3qGEhpH8GCcZEyLqTxqIrxfpw9bqnzKSagRh8r+a0TCCbSWj+sN0G0oY61GGgM3UY0O4eHww3MtB89behGMjCjYRvD422cr56+05yO9GjDHnfraK9Ogp1tuVxKVeKTZ/0SXAgWsCP4LRci0XC/7z05nrOBSYEWg22dV5Wt71o3cv8hl0ybGWn5f/gH0LxCvYP9R3lWErKPGvPLKcINJPGkeaUP1vGCP7Skx5NQuTVO5qV18U+UgF2jyp87ZkoUDQ4BuMFXfzAZjkQKAp2TOBnzRd0zgu7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ2PR15MB6490.namprd15.prod.outlook.com (2603:10b6:a03:57a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 20:51:48 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 20:51:48 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: "dongsheng.yang@linux.dev" <dongsheng.yang@linux.dev>
Thread-Topic: [EXTERNAL] [PATCH] rbd: check for EOD after exclusive lock is
 ensured to be held
Thread-Index: AQHcjspJ9voGPXK0k0CY88ZdEvFRcLVk7ZKA
Date: Mon, 26 Jan 2026 20:51:47 +0000
Message-ID: <664f986fc37c65c355df4a8cf1ba03273032a719.camel@ibm.com>
References: <20260126133729.867488-1-idryomov@gmail.com>
In-Reply-To: <20260126133729.867488-1-idryomov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ2PR15MB6490:EE_
x-ms-office365-filtering-correlation-id: cca576e7-9da2-4aa0-0403-08de5d1cb912
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dDhyS0VsN2dEUHpRclZIQWdWekJhWE4rY2NEY2t3c0JmMjMyZkswZTV3Vmc2?=
 =?utf-8?B?ZS9jSVVOaU5Sdy9Rek81a0x3VjFOSUVtWHZzekJqWVM2bGlGcnJpNzRsK1po?=
 =?utf-8?B?eGtLU0FsVFVCWnBXRmFtNGpKZDJNQVdFcC94cWhCeGlWY2FzalpNYlVMUTNB?=
 =?utf-8?B?YzBnN3RpM2xnNzZJVXA1aDZjNkRNTTNNOWcwRG5SN3JqQTZjbFgzY0NXVWxB?=
 =?utf-8?B?Y1JmRGZydzdObFJtWEN2WkFXMEcwV1Z0UDN5ZjJrRnpzVXhKTVJtZTV3a1Ew?=
 =?utf-8?B?aFdpT1JGRVJ3ZGU2S0poeDArUFZXdzZ3MnMrZkI3cWNVdngraW1oM3Y3WHNT?=
 =?utf-8?B?ZUZ1aXI2OUtWY3VWYWRuTkdsTlZQbkxXTTNhTDRCWEpDVEFhT09IQ054aURs?=
 =?utf-8?B?dDVCazZYSlBPeEozUGIvOUxDY3pWc215UkhDVklRWXk4dnlUUzVPUllMK041?=
 =?utf-8?B?SFJxNy9reVR3ZytmNDdMM3lCOUxVaGtwQVdRakV0bDR6R0c1eEVUZnFXaGUr?=
 =?utf-8?B?RDRScGhqTFBlY3I2ZURBQVc2bDdJQUE5SGU0RHk2a2hVaVlGUndUQkYrRnNo?=
 =?utf-8?B?ajNLSk1zOEZvd0dXM3dhRHlwYmtHbWRnaDdGdkF6dmtaZkY2d1dVQ3pBYWZC?=
 =?utf-8?B?MDgyWG1POWpLOEsxS3dibU1BYm5aSDd5V3ZFR3BhemlkY29RTDZJSWFuVWxu?=
 =?utf-8?B?M3JuVnQ5dmJsTkJabTRsaWp2Y1FseFJtNVRzbkRFZ2NGYXJkUGprRUp1SUl1?=
 =?utf-8?B?QXJ3SEZjZXJGczFFTmNlTDIxTy91bTZPM3NscWJ1eVY1SE53UTQwd21MRVFC?=
 =?utf-8?B?RmhNT09idmh4aUExQm1vQkcvMDVuUTIvOXQ0cldVZzduMzFZbG0rWmEySzlh?=
 =?utf-8?B?WURqb2VONGI1RXlVczI2S1pIaHZDMnpLWEJYUDdBU3Fqd3BlNEx3eXRBQkx5?=
 =?utf-8?B?dCtCVVEvcm1aYmJkbUNyaUd2Mzd6M3dOdi85NDJrQmZlNTNnUkI1RmZ4RENz?=
 =?utf-8?B?cTlRa1dlTGJVZmFvNE5yT0FOblRWV1pkWWk5RmVJRzV2ODNCQWNWNEtsMlJO?=
 =?utf-8?B?VUd3NE9UM0JUVkFMMUJOVE9vcUdqNXJnL1pYZkNzMjNpL3UrdWtIcDUwNm15?=
 =?utf-8?B?ZlhJSFlTUnA2MEhETVlxSWRHTC9nSTZmc1J6TDhlNFpWUjZrNU5SVU1tR0cz?=
 =?utf-8?B?bTNQb2I3K21yaEJFbzY3aHdvbEY5N3B4WFp3RkNDM0VvUTArRTFId3V4UXV0?=
 =?utf-8?B?VUEwNjI5RklOOHY0K3VYSFA5dW9mLzJoZy96eXIwZFJ0QVFFdk84aE1sWkhM?=
 =?utf-8?B?K1R5Q2FzZEJkVUpEQjNSNUhlQnFXdTlFMEIwN0lUZmQrL0JLZVJ3RjlNcFUv?=
 =?utf-8?B?WGVPa0pkeHNaOVNBWGRzbjdibGxjc0xLVTdKcUNZQ1FUQlBkWVE5ZjZVRVJC?=
 =?utf-8?B?L2g4T09MampnczBZVHNzZWpJTmJZUWpVY3JsT09mWlUzajZsVkx2T0NWeE44?=
 =?utf-8?B?U0VNaE5GRUpTUmwvZzd0WW1sYkhVNldwZ0pDMmJYZ3hETnVRK1d5U3hFcCtH?=
 =?utf-8?B?YllnRlZ6V2R4REhOWXJ6Qkl4anZuMXdraWkrYnEvWWI4bkhNSVlyMDcwNC8r?=
 =?utf-8?B?azFwejZndll6enYxU3dLdTVXVXQwUHdVS2FZZjR2YnBWNG01c3piU0NNdUF2?=
 =?utf-8?B?b1RrSnFqMDJwRFNTTmoxcUlTNEJETEhMOUNUUFVhYVg3aWVHbDVUVVBzK0Q3?=
 =?utf-8?B?M3V0UEdYRjhDbXpHM0dJOVdjZzhJcklyeHlxN2RTOFJjWk5KSUhUK3BrVTND?=
 =?utf-8?B?dElwNGVuQzRhcFJOWXJJZ1p1SXdIc0VJdXNMc3VGQWVyeW9IUG5DS0JnWWhq?=
 =?utf-8?B?a0ppQjFQdUM4THF6VE01bWswM0RFT01xWUc0Y1owY2xqUGdRcHRuZkg4YTNh?=
 =?utf-8?B?Y2RTWFEwSW54TExwZVpSckZOeWtTek9Fa3hKQ1IzdUZkV1VUNjFkV3Jra1Rn?=
 =?utf-8?B?SkNLR1dPUHMrNHVNeG4zcHI4UTUydHVNdXVEdmdDYS85OGozcEdFSmpWWk1s?=
 =?utf-8?B?NVdiQ2psTGZ0b3BVNjJuWGlmajRoZ3hPaUFkMGIrWXRzblBkUXdhdW1mMU54?=
 =?utf-8?B?aldtTlgyZUtlUmFRRGZZbjRlcVpLbWFIejlIRGZHQ2hIUGFYRy92dHZYdVFo?=
 =?utf-8?Q?TZRUGYgfQhYWRIf4Rwlb9Pg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V042QUJmRngvUHU3N2o4VEtxMkJhd2pEcGN2MkFsZnM5K08vRk5mQUF5cHkz?=
 =?utf-8?B?a0lxZDdmb01tVWsycTRodXBWbmxSbE9waGlpWUhnbGxLTzJabUlVQkVJVGY2?=
 =?utf-8?B?d3ZnTDY1NjQ4azRQV3pwdmt1eGt1Nnl5cjF1cXpuVHVWbEtVZ2hZTm5ZYlIw?=
 =?utf-8?B?OWRXWk9PdC9BTStjU1RTQWYyYWxSOFhURC9pZnh2NDhLc2YzMlc1UXA5UWxr?=
 =?utf-8?B?RGlTZzJtcE1jQ2I1dDFVd2NCZkFUamQ1Rk0xa20xc0ErSTF1VW5aV2lrbm0v?=
 =?utf-8?B?QzNTRzF4TjVqUEV4bU1qR3gxRXVZeVdlRkdHWGdmYnlTZjF6U2hvaHVPb3R5?=
 =?utf-8?B?YThDZUZoaUhvYnBXME5hMzNQMEs1b1dtVUI1YmFmUVUwelpBQ3F6b2FnVDVB?=
 =?utf-8?B?eW5sMVlHVlZtWG82SDdCNElHTkNiRGZYcS96OXRPcDl6S016a2tESzk4MVZH?=
 =?utf-8?B?RDJLODQ2aVU5dXFEWlBBdEQ3REV0ZHphUmJsSUNqRG00aExJMTNqYzBha2xL?=
 =?utf-8?B?Z21WZ0N1eGd2RmR0Q3NtZUFoMnN5bVRkOGkvanZxWWdDM3JVeGpyN2o5VDZq?=
 =?utf-8?B?Z0x1bnVyQ0FNWlJxKytpM2tWdzVNZVNoQ2p6UmpCWGJFZ0JQOFluM2Q3aWJD?=
 =?utf-8?B?NnowK1Z4ZWhlV0lnZlJzN1grSVRJUUxDaTZVbXVmWWl3OW1QRHdRWEV4cUMz?=
 =?utf-8?B?U0hCeTczMnJETEI3UWFmMjVOYzA3aER5ZW5ZaFRKbmZndHJZZmdhais4bGVh?=
 =?utf-8?B?YjJWNTNyb0FIZGlhckVpL3N3bEVSRUVzS0dpenRPZmlrQktSaWxsMncwc0pU?=
 =?utf-8?B?YTFwSDlLRFJZOE4wNEo2ZWVEdEVuZlJoNWMzUVl0U1VUS3JlRklUcXpNZVVh?=
 =?utf-8?B?bG9wUW1jS0NzSkhlbWdaaW9MUFhyR2JabFYycG9NRDl6bGI1QXJLa2FCWmtQ?=
 =?utf-8?B?Y0pTTW9uSGRiZm5mQjBlVms3ck51QTllcVZyb09uem5xdHcyVjZ6bmxyR20r?=
 =?utf-8?B?OGRQcUVRYTRCaytWcnI1MTQ0S2VVVHk5djUzYWRadldJUDA1cnZGZEowVnlk?=
 =?utf-8?B?TFh6WWtqeUZkdmJzVnFQbFpWTkxiUjdSQVB0OWJrbWRPcXplbCtyK3BNUXhI?=
 =?utf-8?B?RHNjbEVDUXpmU0dLMjNIM0Q2NFBuaCtGQ3ZMOGRFNm9QTW42aWh3UTZ2MW9w?=
 =?utf-8?B?M2Q3WkRrbktvWG1IejNnRVNnQWZ2cUI0am5HNWNMdzkxRElhWnJURmFubnNI?=
 =?utf-8?B?dDRpNkdSdi9EWThyWWkwR1JNRS9KTnRNRFoxUElnTzR1MmZ5d1JkLzFYK3Yy?=
 =?utf-8?B?RnQyNXBPamsvbnJ3cWFpa2M2TzhaYTliY3lCVmkzTXlic3lXNkZ4azJVSGNw?=
 =?utf-8?B?eVRielRJUms3dTNaM0g0TTdkQlR5dGEvSFNMYWFjeDBTdkFMR0xOU3Rid25q?=
 =?utf-8?B?OUhTbFBnUWNMYzdWOHJ5dDlBc2tsNFVIVUhWUHFqSVgwUXFneWZFcHY4eG5R?=
 =?utf-8?B?UTRSMnhIWTJZYmtZTzFJQWQyTlB1V0tGaERHWkVxRFRWbjNDWGRwU1lhOW9K?=
 =?utf-8?B?eS9NeHUrdDVtMDRHRnlLb1FGT0tOL1FYTERsL0Zqa252VmNoejZkdk03aHJU?=
 =?utf-8?B?SWxRY1lISjVxNzVpazhaTDhvemdiWktOaHB2MXZvajIvL2s2SWJWTFVmVzFE?=
 =?utf-8?B?NURnckFwWW9hdVREenEzWjE2UFQrMWUrZDZSYWhtWGdxdWxhMlJ0a1FDRjla?=
 =?utf-8?B?MWlBT3RtMU9XeEZ0RkRSZUdSTlRrSnpiYU84RjYxSnRrak9HTEhtK0NndnZQ?=
 =?utf-8?B?dmhLMm9xYlZydjRwaFhVcWZwZjhNN2JCWEFDY2pIVEgyRUNFYUlTWVBCNWtt?=
 =?utf-8?B?N3ZTU0hueTBhZ1FubUtHc1lobzlRNFpqa0Z6S0RsZ2VYdGtUK0tDTlhMclRG?=
 =?utf-8?B?ejJXUWt0K1F6WWdPS0QzOEQ5aG4zOTcrTHhrSktmOG9QbnRZaERQY2RGck5Z?=
 =?utf-8?B?Z3h6TjdReFlaTkZLK3NaaHFBQmN3bzdVMHRvT2kybTZIcnR4QXFpNlhoSFBk?=
 =?utf-8?B?S0Q1SUl6UFg0SXhMQ3k4Y3h0ejFxc2ZhaG5XVEt2S3RzRXVtQXpCNTRLdVVj?=
 =?utf-8?B?aHJOK1ZQeHl5dWRKckYwRms4ZkxXaVFtMHdEVm83Y0JnOTU0VnpUMVYzei80?=
 =?utf-8?B?eXR3cWhGSGp0cmRvV1JuUGlsVld1Ymp6WWd6MlgrSDNWbVNRU1JSendWZkk2?=
 =?utf-8?B?cGlXbTVVazBKdCtMSlpmWWVkVUNOSlZ2NnBUMTJVVEx2cE9hamFmQTVadWxn?=
 =?utf-8?B?YW02aWVrcjdSbUp4V3U5MnN3ZlZtZFdnWUZ6THhBQnFQK0lDZXBOR0NHdUZL?=
 =?utf-8?Q?ALXtHXLAVtkpRKY24A1Ls36sexfI1sdOkqos3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EF9569DE1B4E24A8351FA6B3D2F0EC6@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cca576e7-9da2-4aa0-0403-08de5d1cb912
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 20:51:47.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KRzICAHnxRRa+0epAGI9c9zcpRdksozFohjztxNTqgGv4Se6C/IQNL5N6O5D1vTDaBq3WIFgv0cyUSp1z6DCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6490
X-Proofpoint-GUID: dS5S1ds4aHXx9EXxiINIKzzfbJ45QsPk
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6977d3e4 cx=c_pps
 a=bKR93RD0qenpecP8xHJc8w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=XOQK3BVkxLrIezMs:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=305ZDI-Z4wTNESciBLMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wnSC20OcELc1gJ8Hil5dVov_GQmQ6LP0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE3OCBTYWx0ZWRfXyTFz1tkIUi4K
 +pbaw+g8sKj9tMFpmKmV2COf2JH153bKTlXiipbH5nXTNFkec2YdAsMRxKA5F13tiUnwS5VteZ3
 TwKmqkqMv1yh2BzO42E3CRUEBOv6Td2J8fy8XS6GYFgnfje0jj2/Fu5sHuLVca/aFsELkvFX0qn
 mQvp7HV/m5G1rIhittOAmYO3jPseB8bKRNmulddON/+j7cVGts1cnit7unoyCUSz0Z/W/MUNiCi
 0g8JkPor3oMuJQCZ0IXCCy5pw/YfzQwjK0PxW2BY93eQ6/ktAjtTxhDbO96geyE9V9ae+/gM+k8
 fDdOQFbMSfNfg/uZLaI8hT7aT3rZSZY6Rn0i0d9fZvTqjFfMgPMBuUclx/mEnuL/NIMW2/a/33M
 zDiqJknR3pw1iqj5BHNrbmm1c9DBLn/0C/z9lkeRueg86PmImz1uwxyzKFgNCrP8l0pw4adGnJV
 a5/bmC+D3WSAYlKwnGw==
Subject: Re:  [PATCH] rbd: check for EOD after exclusive lock is ensured to be
 held
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601260178

T24gTW9uLCAyMDI2LTAxLTI2IGF0IDE0OjM3ICswMTAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IFNpbWlsYXIgdG8gY29tbWl0IDg3MDYxMWU0ODc3ZSAoInJiZDogZ2V0IHNuYXBzaG90IGNvbnRl
eHQgYWZ0ZXINCj4gZXhjbHVzaXZlIGxvY2sgaXMgZW5zdXJlZCB0byBiZSBoZWxkIiksIG1vdmUg
dGhlICJiZXlvbmQgRU9EIiBjaGVjaw0KPiBpbnRvIHRoZSBpbWFnZSByZXF1ZXN0IHN0YXRlIG1h
Y2hpbmUgc28gdGhhdCBpdCdzIHBlcmZvcm1lZCBhZnRlcg0KPiBleGNsdXNpdmUgbG9jayBpcyBl
bnN1cmVkIHRvIGJlIGhlbGQuICBUaGlzIGF2b2lkcyB2YXJpb3VzIHJhY2UNCj4gY29uZGl0aW9u
cyB3aGljaCBjYW4gYXJpc2Ugd2hlbiB0aGUgaW1hZ2UgaXMgc2hydW5rIHVuZGVyIEkvTyAoaW4N
Cj4gcHJhY3RpY2UsIG1vc3RseSByZWFkYWhlYWQpLiAgSW4gb25lIHN1Y2ggc2NlbmFyaW8NCj4g
DQo+ICAgICByYmRfYXNzZXJ0KG9iam5vIDwgcmJkX2Rldi0+b2JqZWN0X21hcF9zaXplKTsNCj4g
DQo+IGNhbiBiZSB0cmlnZ2VyZWQgaWYgYSBjbG9zZS10by1FT0QgcmVhZCBnZXRzIHF1ZXVlZCBy
aWdodCBiZWZvcmUgdGhlDQo+IHNocmluayBpcyBpbml0aWF0ZWQgYW5kIHRoZSBFT0QgY2hlY2sg
aXMgcGVyZm9ybWVkIGFnYWluc3QgYW4gb3V0ZGF0ZWQNCj4gbWFwcGluZ19zaXplLiAgQWZ0ZXIg
dGhlIHJlc2l6ZSBpcyBkb25lIG9uIHRoZSBzZXJ2ZXIgc2lkZSBhbmQgZXhjbHVzaXZlDQo+IGxv
Y2sgaXMgKHJlKWFjcXVpcmVkIGJyaW5naW5nIGFsb25nIHRoZSBuZXcgKG5vdyBzaHJ1bmspIG9i
amVjdCBtYXAsIHRoZQ0KPiByZWFkIHN0YXJ0cyBnb2luZyB0aHJvdWdoIHRoZSBzdGF0ZSBtYWNo
aW5lIGFuZCByYmRfb2JqX21heV9leGlzdCgpIGdldHMNCj4gaW52b2tlZCBvbiBhbiBvYmplY3Qg
dGhhdCBpcyBvdXQgb2YgYm91bmRzIG9mIHJiZF9kZXYtPm9iamVjdF9tYXAgYXJyYXkuDQo+IA0K
DQpNb3RpdmF0aW9uIG1ha2VzIHNlbnNlIHRvIG1lLg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xh
diBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+DQoNClRoYW5rcywNClNsYXZhLg0KDQo+
IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IElseWEgRHJ5b21v
diA8aWRyeW9tb3ZAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvYmxvY2svcmJkLmMgfCAy
OCArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5z
ZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9i
bG9jay9yYmQuYyBiL2RyaXZlcnMvYmxvY2svcmJkLmMNCj4gaW5kZXggYWYwZTIxMTQ5ZGJjLi40
NGY0ZGQ2ZTk4ZDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmxvY2svcmJkLmMNCj4gKysrIGIv
ZHJpdmVycy9ibG9jay9yYmQuYw0KPiBAQCAtMzQ5MCwxNiArMzQ5MCwzMSBAQCBzdGF0aWMgdm9p
ZCByYmRfaW1nX29iamVjdF9yZXF1ZXN0cyhzdHJ1Y3QgcmJkX2ltZ19yZXF1ZXN0ICppbWdfcmVx
KQ0KPiAgew0KPiAgCXN0cnVjdCByYmRfZGV2aWNlICpyYmRfZGV2ID0gaW1nX3JlcS0+cmJkX2Rl
djsNCj4gIAlzdHJ1Y3QgcmJkX29ial9yZXF1ZXN0ICpvYmpfcmVxOw0KPiArCXU2NCBtYXBwaW5n
X3NpemU7DQo+ICANCj4gIAlyYmRfYXNzZXJ0KCFpbWdfcmVxLT5wZW5kaW5nLnJlc3VsdCAmJiAh
aW1nX3JlcS0+cGVuZGluZy5udW1fcGVuZGluZyk7DQo+ICAJcmJkX2Fzc2VydCghbmVlZF9leGNs
dXNpdmVfbG9jayhpbWdfcmVxKSB8fA0KPiAgCQkgICBfX3JiZF9pc19sb2NrX293bmVyKHJiZF9k
ZXYpKTsNCj4gIA0KPiArCWRvd25fcmVhZCgmcmJkX2Rldi0+aGVhZGVyX3J3c2VtKTsNCj4gKwlt
YXBwaW5nX3NpemUgPSByYmRfZGV2LT5tYXBwaW5nLnNpemU7DQo+ICAJaWYgKHJiZF9pbWdfaXNf
d3JpdGUoaW1nX3JlcSkpIHsNCj4gIAkJcmJkX2Fzc2VydCghaW1nX3JlcS0+c25hcGMpOw0KPiAt
CQlkb3duX3JlYWQoJnJiZF9kZXYtPmhlYWRlcl9yd3NlbSk7DQo+ICAJCWltZ19yZXEtPnNuYXBj
ID0gY2VwaF9nZXRfc25hcF9jb250ZXh0KHJiZF9kZXYtPmhlYWRlci5zbmFwYyk7DQo+IC0JCXVw
X3JlYWQoJnJiZF9kZXYtPmhlYWRlcl9yd3NlbSk7DQo+ICsJfQ0KPiArCXVwX3JlYWQoJnJiZF9k
ZXYtPmhlYWRlcl9yd3NlbSk7DQo+ICsNCj4gKwlpZiAoIXRlc3RfYml0KElNR19SRVFfQ0hJTEQs
ICZpbWdfcmVxLT5mbGFncykpIHsNCj4gKwkJc3RydWN0IHJlcXVlc3QgKnJxID0gYmxrX21xX3Jx
X2Zyb21fcGR1KGltZ19yZXEpOw0KPiArCQl1NjQgb2ZmID0gKHU2NClibGtfcnFfcG9zKHJxKSA8
PCBTRUNUT1JfU0hJRlQ7DQo+ICsJCXU2NCBsZW4gPSBibGtfcnFfYnl0ZXMocnEpOw0KPiArDQo+
ICsJCWlmICh1bmxpa2VseShvZmYgKyBsZW4gPiBtYXBwaW5nX3NpemUpKSB7DQo+ICsJCQlyYmRf
d2FybihyYmRfZGV2LCAiYmV5b25kIEVPRCAoJWxsdX4lbGx1ID4gJWxsdSkiLA0KPiArCQkJCSBv
ZmYsIGxlbiwgbWFwcGluZ19zaXplKTsNCj4gKwkJCWltZ19yZXEtPnBlbmRpbmcucmVzdWx0ID0g
LUVJTzsNCj4gKwkJCXJldHVybjsNCj4gKwkJfQ0KPiAgCX0NCj4gIA0KPiAgCWZvcl9lYWNoX29i
al9yZXF1ZXN0KGltZ19yZXEsIG9ial9yZXEpIHsNCj4gQEAgLTQ3MjUsNyArNDc0MCw2IEBAIHN0
YXRpYyB2b2lkIHJiZF9xdWV1ZV93b3JrZm4oc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAg
CXN0cnVjdCByZXF1ZXN0ICpycSA9IGJsa19tcV9ycV9mcm9tX3BkdShpbWdfcmVxdWVzdCk7DQo+
ICAJdTY0IG9mZnNldCA9ICh1NjQpYmxrX3JxX3BvcyhycSkgPDwgU0VDVE9SX1NISUZUOw0KPiAg
CXU2NCBsZW5ndGggPSBibGtfcnFfYnl0ZXMocnEpOw0KPiAtCXU2NCBtYXBwaW5nX3NpemU7DQo+
ICAJaW50IHJlc3VsdDsNCj4gIA0KPiAgCS8qIElnbm9yZS9za2lwIGFueSB6ZXJvLWxlbmd0aCBy
ZXF1ZXN0cyAqLw0KPiBAQCAtNDczOCwxNyArNDc1Miw5IEBAIHN0YXRpYyB2b2lkIHJiZF9xdWV1
ZV93b3JrZm4oc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KPiAgCWJsa19tcV9zdGFydF9yZXF1
ZXN0KHJxKTsNCj4gIA0KPiAgCWRvd25fcmVhZCgmcmJkX2Rldi0+aGVhZGVyX3J3c2VtKTsNCj4g
LQltYXBwaW5nX3NpemUgPSByYmRfZGV2LT5tYXBwaW5nLnNpemU7DQo+ICAJcmJkX2ltZ19jYXB0
dXJlX2hlYWRlcihpbWdfcmVxdWVzdCk7DQo+ICAJdXBfcmVhZCgmcmJkX2Rldi0+aGVhZGVyX3J3
c2VtKTsNCj4gIA0KPiAtCWlmIChvZmZzZXQgKyBsZW5ndGggPiBtYXBwaW5nX3NpemUpIHsNCj4g
LQkJcmJkX3dhcm4ocmJkX2RldiwgImJleW9uZCBFT0QgKCVsbHV+JWxsdSA+ICVsbHUpIiwgb2Zm
c2V0LA0KPiAtCQkJIGxlbmd0aCwgbWFwcGluZ19zaXplKTsNCj4gLQkJcmVzdWx0ID0gLUVJTzsN
Cj4gLQkJZ290byBlcnJfaW1nX3JlcXVlc3Q7DQo+IC0JfQ0KPiAtDQo+ICAJZG91dCgiJXMgcmJk
X2RldiAlcCBpbWdfcmVxICVwICVzICVsbHV+JWxsdVxuIiwgX19mdW5jX18sIHJiZF9kZXYsDQo+
ICAJICAgICBpbWdfcmVxdWVzdCwgb2JqX29wX25hbWUob3BfdHlwZSksIG9mZnNldCwgbGVuZ3Ro
KTsNCj4gIA0K
