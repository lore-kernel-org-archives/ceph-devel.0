Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1717335064;
	Tue, 24 Feb 2026 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963816; cv=fail; b=pEKQJW1PpqrYTMomKBXSJMClOG4DTWSaPKemvqQOleUjBh7GCJqhos8GtteYKpAWCUilUvbJHJ7GzmjeSs67ZJLwNeyDil3A7KTu63k8l0KBzenBjHt+c4jhLa/L9eAnjBmVZHeWO3jVVJ99cF+hhUj0J3e3NRfJS0g7rWw1/9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963816; c=relaxed/simple;
	bh=PkVo9Q+/W4a6/C/afblM86/RdqXqa+Csu0bL1MZBzBw=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ePgOu9CGK/gNADXp5GZ1TdRJBT4NdzvYNKxG3DUjIAr1JCXflLNVSVRzmlgYkDgJPhu2plFU7U0GR/urdi4cLni2EdY8Nn/oXjjm15Cw0CT2XXp1GxWYJuYa8VQY4ttTDzIAy1fBJWnTIETEZpVN/qrv95gz4+WjXY0SFMcdsCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aWzFn62W; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aWzFn62W"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OJT1PV2347007;
	Tue, 24 Feb 2026 20:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=PkVo9Q+/W4a6/C/afblM86/RdqXqa+Csu0bL1MZBzBw=; b=aWzFn62W
	MaWBSNWDaONlTqs4TYjpD38R+xDnpzjtv12dAUR+1HWqjufG10IAHlzYKeO/mGyL
	rRJVgI5998DeJ8Bgj0IM+JoxUzGoeaWEGoWKiqQTmy2n9QbJhz3AiHVLMpu94yHy
	RZ4HJdxPFJjGpFejfiLd2Ie5ZEm02Z+ItPcRaYg0xzHBLxjhOloY4Z2BFDeGuNFI
	9mBmhnYpRjbeHzIWBR4Bdz25zE2r9AGacg13Ag3lyrb9gpsylOLCkUFKZ7FooHTg
	k4Gqjlw6qaXC34UzAMVrox/y56cZh2zRuo5gsbTfKyDzkOh0fdqV4LSFoLAFJCa1
	5ycsvRBWE+3KNg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858jskw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 20:10:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvYBM3dSASCrIwRFa4yKL/gzU2MQnh80xxXG60JB3zlKKTvSQCFJk02m/YbO29gidAhFgyZkDkz3hIeM5qYQnzV6Lsw58TQSJvF636oaKSz1q8IxUogjHnlgfbYprBXqYpuGoFyg/SCTOICuRx8ut5jmyEd69KfcMo5ChScY9rGjXIy6zlVlckq938edrYbfzPWdX+ArzDguqK4er7kC8+BWAQEdQVsYDjyni5U5XzJwkbdNoiHmcwV50e9qW9eKTGU3cX43nSC63e1SCK9c87fdywbnj6jW/VzBe6Q0Nu0B6jo3CLrd/ydKhv+ub4Mojwp8xsTNKnIaUtuIrTg9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkVo9Q+/W4a6/C/afblM86/RdqXqa+Csu0bL1MZBzBw=;
 b=cPp/s/+41oSvy6+9Af+qze6ZLfyeCiRygJ+9lrmC/f1nG1Il7c1jrw1uaepzpwyvXKG+pOV1hEZRMWwiEraEsmXfbr8MEZqnJnmoRt7eVCpUV3iRKcsw7Iqwg+JP2l6yHRirqWeBplXF9ZC9STrlkG/EMrlUtfitJGe42q/snjnvkUlUb+AerRijGdpM4dSV9AqWR1+B1Q55AHt+bmF/D2Ll67IHhnBkzRHNr0m3vUxkAEHy3rp5VQAM0USW5cTzsonFGLsFIt9NlaYEWKVMcFJEPElX0UMAmfAenOcV0KqF7xXCnzv9qjKA3Ybfwg/iSkTYEqtJuUjXg/2TdHBbvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BLAPR15MB3874.namprd15.prod.outlook.com (2603:10b6:208:272::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 20:10:06 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 20:10:06 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "max.kellermann@ionos.com" <max.kellermann@ionos.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] fs/ceph/dir: fix `i_nlink` underrun
 during async unlink
Thread-Index: AQHcpZJGt6aUSwuNmUuq0g4HHYWVArWSR/yA
Date: Tue, 24 Feb 2026 20:10:06 +0000
Message-ID: <8e57aa68d3ce52ab7457241b9a05777a5f718f3f.camel@ibm.com>
References: <20250905211530.43296-1-max.kellermann@ionos.com>
	 <CAKPOu+_MS5RHVBW6qGZnbiwv+P78o+6fQAQuJdtd_HqoV-yE0g@mail.gmail.com>
In-Reply-To:
 <CAKPOu+_MS5RHVBW6qGZnbiwv+P78o+6fQAQuJdtd_HqoV-yE0g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BLAPR15MB3874:EE_
x-ms-office365-filtering-correlation-id: eec36696-dfd9-4640-ff34-08de73e0b436
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2RXNWpoeXBVYXRUYjRzaTN2RUpSM3JrQ1pyOUhwVHR3UW8vK29JbUppZTUw?=
 =?utf-8?B?VUxoNnJNbjhiaTlaK1pqbjZ3UDVYa0lqN1VzbkJ3VlUreWcrY1BQQ0lGdGlq?=
 =?utf-8?B?N0hISXAvNXVhZnV3Z081Y3JHYjRWc055TXpPZGQ4dU40Q0JMcDZTVFBxMXJT?=
 =?utf-8?B?Y0FnazFrajEwdytWenJuTXp0aTl2bkV2S3lQMjVYbzc4V055cVJEaGNUaTlE?=
 =?utf-8?B?R3EwcTRBMG9wVDloNHV6NTRIWU9aTDgrenpITmpkRzMweHgrdUN4VkM5MjQv?=
 =?utf-8?B?L1d5VFU4b0dUd3pITVpPR01KVFE5bW9qRUhxMnU2eEVhMWdDTDZoc3R2Qndr?=
 =?utf-8?B?YnFuUXNoeDJWOG1haU1ISXVSbU9aRmtScmc4Sk95ZEs3ZXR0VG9HNUpOZklu?=
 =?utf-8?B?UW50eVBudTRVbmgyL2lKZ0pkRHhERTQyblVtbnMvVnRkNnBnelROVWVrOTAr?=
 =?utf-8?B?L3lSb1BrRDltc3JIaWlTaUc1MVBadW4zd0swcEZnQkZrSjBNVFZ3NGUwditQ?=
 =?utf-8?B?bHRaZWVTMEFyMVA1T0I5VENEbjdRcHI4VzAyRmhLZjlvcWovaW80UEdBSVNQ?=
 =?utf-8?B?cjFwMlZlM0Rpc1VoaGZDNlRYTHhMZnoxSlJDOGw3WkxTeDlkSkN2RXZDcGRw?=
 =?utf-8?B?R3lVVjFaT1BiU0dqZGNSU0UxTDBSanF5a3pyV1kvOSs1MklEbVFkSjB2KzUy?=
 =?utf-8?B?d2lnazFPRGRkWFdkcGhOMlhGYm1BaHBPcWVaMG5KRFhIU1RDSHQvYkx3Uyt4?=
 =?utf-8?B?bVhkMSt1UHVZNEJiakhMVXZYSGhiOHgxdHM2K1BKTHNreWdlMFRiZzZUNS85?=
 =?utf-8?B?RlZCSDdUV0RMajRGQlN0NU94WEJaSS9wK3FVSTJ1ZnV3dXlSQktiV3lqVTRs?=
 =?utf-8?B?a08rYlhNZk9nOUU1djVKREw4NVFKdXFlVEJZWnBVYnBhZmNhenVpSS9Gc0tu?=
 =?utf-8?B?ZHlOYTdxb01tcFlsYWlVUk5pVmZwUll3VUdIc24vcnZHRzN1Ry9WT3d5dW4y?=
 =?utf-8?B?bjdDQjdZY2QxeFFIVmRrUGNuOVJPM09WQ01uSFJPNTBsdHJsbjQ3ajVyclFR?=
 =?utf-8?B?UFU5UERpdUc1Y1JqNzROemVnWFdQUXAybUlkeVVvY0xPTTNTdkhQL2xad3VR?=
 =?utf-8?B?ZGszNjhtWjZDMUVtS0NUSFlnUnZuZ002RGE2ek1yQUowRlhrc1lwMTZVelBu?=
 =?utf-8?B?Y09naHRwTmZ5KzNKMFdSZFpRR0JVTnptZVBJV1hsMU1xSWFYcnI0akZGcTVw?=
 =?utf-8?B?cUhzc1JrLy9zOUFtcUJtTzRjYVRoVzkwUXBDWjc2ZE5PTG0yY3JtczVsWjRZ?=
 =?utf-8?B?ZVVzV3FRSmtkaFJNVU04VXBUSVI5QWttY0ZmL3JxMkFDem5tQ3dkM2xaQXRS?=
 =?utf-8?B?OERSa0RuN3pMRjZ2VUxsVVNXb1dhcGgrODloU0w4Mk96MWswRkRvYXlIUk13?=
 =?utf-8?B?R2VFK1F5TjVvSldMekxsVkJmMnJ0alExWWdrUktCbzY5WlZ2L1pJd3UvTkZt?=
 =?utf-8?B?S0U0SjA3VVIzM1hlUUc5N1MvTVEySzJOSW4xem9pOThXQ29VcC9LbTk0MVMr?=
 =?utf-8?B?Z1p0K0YxT1ZIcnVIVnZNTUtTZVhTL3I2SmNzcVFkSUdmODhaUFdMRXBpTXk2?=
 =?utf-8?B?Q1dETHhKMWlBeGpHbHcvK20yaU9NUktEYjFCOWtpTmFXRjB6ZjNaSitmVnU1?=
 =?utf-8?B?TzcxOXhERDExbzJIVmlEd0VLRTV3YjhoekRuL2dIYm1meEJ5N0txYmJtbW9I?=
 =?utf-8?B?VzJ3cGNadVI5Z0RHelkwZVNkdGw4UUpMTXJpMi9ocExWRjBpcng2Y1RqMkZC?=
 =?utf-8?B?a2FRaWNTakFZazF2eCtNcUIyaVJ1RlViY28wbWFhcDRaTzhMWjdrc3BOUTd1?=
 =?utf-8?B?RUhNazRNbFRKcWJLOEVWSnlWLzJpaHRBbmxEK3loQWlISlArLzhkUWxhc2NW?=
 =?utf-8?B?aGVYQ2VUbS9WV0V5Z2VKVTNvMTUvNDdWbTNOUlRkUm5yMUJ2WjVXbCs3NEVC?=
 =?utf-8?B?aWJRWFhRU25jNlVTV3ExMUdpM1htUFdqb0owVjF5TU0vSDhmRUdoNjk1U2Vo?=
 =?utf-8?B?bzljOWk0ZXAyQlJWUk9MOGU1NUdJM2NGZGQ3RndOZjFIVks3QTRid3hZSjNC?=
 =?utf-8?B?aFp2YXhHNkJEdHY0dXNXb1lOR3ZaL0RLeUpZMWtWUnlQWDNqa3AwWG9JWHZI?=
 =?utf-8?Q?ynCjk1qhKEjWX1KBxPm6JTI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1h5V3lJV1FoWklSOTZTVVZyTzNId2hwMm8vNXZKeENRc1IyaTR4aVYzUDcr?=
 =?utf-8?B?TXRnaVNLWEppRXAxUktrQldHUDZmMEJGZjhWeHVqcXA4NDNvdGszbzI5d25T?=
 =?utf-8?B?TE5LcExiK2huYXhYTExvbVBVYUoyNGl2czUrOVlGZkVweGd0WG9Nakl4ZGNn?=
 =?utf-8?B?amRBVWxPdVZ3T3RyVlRnaGo5S3UrRWpubzJnZnFGZHBWVVFyNnVZZURNY3hX?=
 =?utf-8?B?N0Z6bjgvejRQNC9ZQWp1YkhmSGxJMXhXWDJBRjlPNmdiTEFhOWJ1OStRRS85?=
 =?utf-8?B?VjJlbE55MFFtZ0gydXNOOVZudmUzOFRKTkJ2eGt4ZnVac2FYNHR0eUVHejBS?=
 =?utf-8?B?dFY5QlA1VnFoREU5YlB3Tko2cm9pRFk3OEtaZkxBM3RveEZISlQzUFhaQWww?=
 =?utf-8?B?eE5wK2tVRVBudW9pYUNHeGtZN3g5dmcrR2RjNVpBOVlFbThIcEFWaHZCZmR0?=
 =?utf-8?B?Zm0rNnRyYVZQZkJFTy9BL0xBUFQva0tya2hVYmNkTE9JMGRMTCtzeUF5dmhy?=
 =?utf-8?B?cTA3a1JsSDlOYTJNS3lHMHE3SnNmQlJwTWxMVGxGUjJZV2JMUXBGM1JybWtD?=
 =?utf-8?B?SnhXdEgwUFZHTnVSTTV0U1lrNTdXK1dPby9JYVhGdE5sWndkUEJHVHFWMWEv?=
 =?utf-8?B?MGdsNUFpU2ZwVU1zdXI5RFViU3F0d0dYZGxmQXhtWmxjbDFOc001cjhUZytl?=
 =?utf-8?B?MTlXZUtQTEFqUkJBeExLdUJuaTZPUzJWOU1FL3djVXNMVUJOVGw1OG9lSkIy?=
 =?utf-8?B?UFVxYjN3dHB0N1h1bllZVExvS3dtbUhHYU5tUnFmQndkVDFRMThhbHBDQU52?=
 =?utf-8?B?UHdGYjRJbjEwS3hDUGdYRFRmWDVKNjRvREliVnRORGx0K05pUnBNTE45a05i?=
 =?utf-8?B?cnJ0OHFrQXAzbWRLSkNGQkZuQmtKNWJVa1pTUmIrcTArK0cxTXZRTVdvbGZV?=
 =?utf-8?B?QVJFYWNRamFoek1WVGRtNFZWUkVQYXQzWUIxbExmdzRaM0RQcUx2WWpJdlc0?=
 =?utf-8?B?R0ZkOXRaa3BDeEdmcVBRWCt5aGV4Nmp4eHN0UVB4SjZHQ1l6YUNYRXBrenZn?=
 =?utf-8?B?OThoTFV1NGhXYTdpZkVWMjVhS3NVNHBMT1RES0dIY1dteU4rbFBzMDVCMVVM?=
 =?utf-8?B?K1Z1NnNTRnR3VUNRN0dOQWdYZVRqV21DSWI0eHNxbGk3aHhLbXppdCtXalFC?=
 =?utf-8?B?bUFraldIeWhQakZabmZ2N2Vsclp2OEpVaUo1Nk1WZW9zUG0rdnNBS00wZkJu?=
 =?utf-8?B?c2NmZm9nQUVnUWZHMzkxeDVjMnMzbUdpQjJXWngzZWhaOVJ0NHY2MXBzc2Rs?=
 =?utf-8?B?RFdhRHhGZ3hWQU1qaHplbW91UFB3WUxzTEF1QVVYOFhTVDJTZkVCVFlZK21h?=
 =?utf-8?B?SERldHRlWW54U21oSitOTjRIS0w0Y3JoV2dnOEVJTUFDNGhYejhrYi85YUZn?=
 =?utf-8?B?WWV5eWJUTlBucGlrVE1SZ2x3QVNTRC9DVzY1WHI5NEJOQWV5NzEzZE44Mmwv?=
 =?utf-8?B?ajV2cExDenhGRUlXWkx0K3RKTHF1ZThxbG5SeE9OTUMzdTRsZHVzTEdJV2to?=
 =?utf-8?B?MGxWS2liVlBOeHBOTHA5TmROb1ozNTZZZllaUzJhMFoxRDB5SlYwbmI4ZWRN?=
 =?utf-8?B?RWZOOWNkcitLdHg3VG40QXhoYkQxNHR4VFVoWVNkSDZWOWo5U1ExOWVjTnk3?=
 =?utf-8?B?dmpmL1FzYXBwaVpkdTVidm1sZmpBcElNTGN3UWlqNE1SZHNTaGhvODBkcExX?=
 =?utf-8?B?NUxma3dqT2JISnZHTzg1eS8wZE1tNnM5YXdRaFpmU1ZOWndpUTFFQTlMR05k?=
 =?utf-8?B?ZllLTzJvcExuZ2lRY2x4bnJ1UEw2cnRPZVNnd2JtT3pFbzJJVXAzSHNYRXgz?=
 =?utf-8?B?WjRsY1RFSENMTUx4N3dUMTRRTmVZL3FiNzV0MHhKb3ZSUE5VSDVBVjFhRm83?=
 =?utf-8?B?QVJiZW0wWVB6cm91dUJwZ1U1eEgyUWdHOUE4QXFKakJzYzA4cVViNVhPLzhV?=
 =?utf-8?B?UzNESy9veU5PNHZJRzNOZkNxNU9NOEpJdWNleERPdkk0VStIbVZwaGtaY0RD?=
 =?utf-8?B?SzNyZWl3WmdOL2tFaXljVkI5b0daRTZwRkttYVNzMCtPUEx6Wi9mcEtWczhu?=
 =?utf-8?B?MU8wbXNQOGliY1lPNEs4b1ZsS2ZoNVpqQ25MbnFidllOWlZTT2lJcythVFRU?=
 =?utf-8?B?bGFTUm03SGVWWHRVVkFzYWMxNDNBT1Irb2lydGZPelZlcVp6eFpXRy90bEp4?=
 =?utf-8?B?MEFRNVR5MFM3WHZwcFRZUG93bHhDNmVsb0JoZ24yaHRRTzA4aDFQK3Q1dXg3?=
 =?utf-8?B?UC9ZYlIyaTBzQVJ2aVRKQ3dCWm1WYXRXcnFtM1hWVmU5bERrMzdPOUNUQjZ6?=
 =?utf-8?Q?n8CtU0mgmOjooMm3aRtdckDtFuW9ad788o0W2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C28B16AB45057145A10A5DBE67B1031F@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eec36696-dfd9-4640-ff34-08de73e0b436
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 20:10:06.6200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kx5G7WuzjACLr5z8jR8eBQI94EnYKv37CLg+OH1ZVDT8N+KT2cX/Ag9nNG6o6a1/nAG+lt9Jc8kM0sco/QYLIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3874
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE3MyBTYWx0ZWRfX8FlAm6u7jFGU
 lnBQBYhjiapipS5aXvr1FK8qj1J0Dr5v0j7g+4s0QM9rA36aDiSSJJg1sf+aR2upNdS8XuElVC9
 IngAiPCowKbNOJBi487vqJeQ7Cu3lWVWxHm2I8Mu69xA1f1W9H+bhe8a/EdmdXDcIhcXwrYqyfJ
 PR35n9dnp0foo2sLNW1tvGaaiqUQEIPbqF7/ZC5LiPk8K9vPLiwbGrmtwpIysESk0L8eN0AQ9y3
 LOGK5nDwrwenviKTa0FZyceUThXG1/hoe4jWVqngE5f9M4c6ezL1mbljwzuAQPDYXG3K5DVp2Tr
 yne9azTWuGsfMu8CeGGKplGvu+Bqc9nyUEbpIxlrvDG8TJ4A8MfweXiXX82njkfmSBAvrEKk7nP
 noEx2AWiR/Qjs0xzTlRyaGpQFkPWONz9q4sA4AtZQUX6L4TK5PIfV7np0DndYJ6nSyVcu0Eh+nI
 Oohkw/HiG2gvFZ+entw==
X-Proofpoint-GUID: iQKOMj-wTFJb8Iu7iVWNMoavAt4gfnfE
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=699e05a1 cx=c_pps
 a=i9oGDAf80PfF53tpRsLhyQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=UgJECxHJAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=R-UdMqwfR3rD-SdyLboA:9 a=QEXdDO2ut3YA:10 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-ORIG-GUID: gUXd7vnJeHYQ63hAH053x4l8w2U_vs55
Subject: RE: [PATCH] fs/ceph/dir: fix `i_nlink` underrun during async unlink
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240173

T24gVHVlLCAyMDI2LTAyLTI0IGF0IDE0OjMzICswMTAwLCBNYXggS2VsbGVybWFubiB3cm90ZToN
Cj4gVGhlcmUgaGFzbid0IGJlZW4gYSByZXZpZXcgb2YgdGhpcyBwYXRjaCBhbmQgdGhlIGJ1ZyBp
cyBzdGlsbCBwcmVzZW50DQo+IGluIDYuMTkgLyA3LjByYy4NCj4gDQo+IE9uIEZyaSwgU2VwIDUs
IDIwMjUgYXQgMTE6MTXigK9QTSBNYXggS2VsbGVybWFubiA8bWF4LmtlbGxlcm1hbm5AaW9ub3Mu
Y29tPiB3cm90ZToNCj4gPiANCj4gPiBEdXJpbmcgYXN5bmMgdW5saW5rLCB3ZSBkcm9wIHRoZSBg
aV9ubGlua2AgY291bnRlciBiZWZvcmUgd2UgcmVjZWl2ZQ0KPiA+IHRoZSBjb21wbGV0aW9uICh0
aGF0IHdpbGwgZXZlbnR1YWxseSB1cGRhdGUgdGhlIGBpX25saW5rYCkgYmVjYXVzZSAid2UNCj4g
PiBhc3N1bWUgdGhhdCB0aGUgdW5saW5rIHdpbGwgc3VjY2VlZCIuICBUaGF0IGlzIG5vdCBhIGJh
ZCBpZGVhLCBidXQgaXQNCj4gPiByYWNlcyBhZ2FpbnN0IGRlbGV0aW9ucyBieSBvdGhlciBjbGll
bnRzIChvciBhZ2FpbnN0IHRoZSBjb21wbGV0aW9uIG9mDQo+ID4gb3VyIG93biB1bmxpbmspIGFu
ZCBjYW4gbGVhZCB0byBhbiB1bmRlcnJ1biB3aGljaCBlbWl0cyBhIFdBUk5JTkcgbGlrZQ0KPiA+
IHRoaXMgb25lOg0KPiA+IA0KPiA+ICBXQVJOSU5HOiBDUFU6IDg1IFBJRDogMjUwOTMgYXQgZnMv
aW5vZGUuYzo0MDcgZHJvcF9ubGluaysweDUwLzB4NjgNCj4gPiAgTW9kdWxlcyBsaW5rZWQgaW46
DQo+ID4gIENQVTogODUgVUlEOiAzMjIxMjUyMDI5IFBJRDogMjUwOTMgQ29tbTogcGhwLWNnaTgu
MSBOb3QgdGFpbnRlZCA2LjE0LjExLWNtNGFsbDEtYW1wZXJlICM2NTUNCj4gPiAgSGFyZHdhcmUg
bmFtZTogU3VwZXJtaWNybyBBUlMtMTEwTS1OUi9SMTJTUEQtQSwgQklPUyAxLjFiIDEwLzE3LzIw
MjMNCj4gPiAgcHN0YXRlOiA2MDQwMDAwOSAoblpDdiBkYWlmICtQQU4gLVVBTyAtVENPIC1ESVQg
LVNTQlMgQlRZUEU9LS0pDQo+ID4gIHBjIDogZHJvcF9ubGluaysweDUwLzB4NjgNCj4gPiAgbHIg
OiBjZXBoX3VubGluaysweDZjNC8weDcyMA0KPiA+ICBzcCA6IGZmZmY4MDAxMjE3M2JjOTANCj4g
PiAgeDI5OiBmZmZmODAwMTIxNzNiYzkwIHgyODogZmZmZjA4NmQwYTQ1YWFmOCB4Mjc6IGZmZmYw
ODcxZDBlYjU2ODANCj4gPiAgeDI2OiBmZmZmMDg3ZjJhNjRhNzE4IHgyNTogMDAwMDAyMDAwMDAw
MDE4MCB4MjQ6IDAwMDAwMDAwNjFjODg2NDcNCj4gPiAgeDIzOiAwMDAwMDAwMDAwMDAwMDAyIHgy
MjogZmZmZjA3ZmY5MjM2ZDgwMCB4MjE6IDAwMDAwMDAwMDAwMDEyMDMNCj4gPiAgeDIwOiBmZmZm
MDdmZjkyMzdiMDAwIHgxOTogZmZmZjA4OGI4Mjk2YWZjMCB4MTg6IDAwMDAwMDAwZjNjOTMzNjUN
Cj4gPiAgeDE3OiAwMDAwMDAwMDAwMDcwMDAwIHgxNjogZmZmZjA4ZmFmZmNiZGZlOCB4MTU6IGZm
ZmYwOGZhZmZjYmRmZWMNCj4gPiAgeDE0OiAwMDAwMDAwMDAwMDAwMDAwIHgxMzogNDU0NDVmNjU2
NDVmMzAzNyB4MTI6IDM0Mzg1ZjYzNjk3MDZmNzQNCj4gPiAgeDExOiAwMDAwYTI2NTMxMDRiYjIw
IHgxMDogZmZmZmQ4NWYyNmQ3MzI5MCB4OSA6IGZmZmZkODVmMjU2NjRmOTQNCj4gPiAgeDggOiAw
MDAwMDAwMDAwMDAwMGMwIHg3IDogMDAwMDAwMDAwMDAwMDAwMCB4NiA6IDAwMDAwMDAwMDAwMDAw
MDINCj4gPiAgeDUgOiAwMDAwMDAwMDAwMDAwMDgxIHg0IDogMDAwMDAwMDAwMDAwMDQ4MSB4MyA6
IDAwMDAwMDAwMDAwMDAwMDANCj4gPiAgeDIgOiAwMDAwMDAwMDAwMDAwMDAwIHgxIDogMDAwMDAw
MDAwMDAwMDAwMCB4MCA6IGZmZmYwODcyN2QzZjkxZTgNCj4gPiAgQ2FsbCB0cmFjZToNCj4gPiAg
IGRyb3BfbmxpbmsrMHg1MC8weDY4IChQKQ0KPiA+ICAgdmZzX3VubGluaysweGIwLzB4MmU4DQo+
ID4gICBkb191bmxpbmthdCsweDIwNC8weDI4OA0KPiA+ICAgX19hcm02NF9zeXNfdW5saW5rYXQr
MHgzYy8weDgwDQo+ID4gICBpbnZva2Vfc3lzY2FsbC5jb25zdHByb3AuMCsweDU0LzB4ZTgNCj4g
PiAgIGRvX2VsMF9zdmMrMHhhNC8weGM4DQo+ID4gICBlbDBfc3ZjKzB4MTgvMHg1OA0KPiA+ICAg
ZWwwdF82NF9zeW5jX2hhbmRsZXIrMHgxMDQvMHgxMzANCj4gPiAgIGVsMHRfNjRfc3luYysweDE1
NC8weDE1OA0KPiA+IA0KPiA+IEluIGNlcGhfdW5saW5rKCksIGEgY2FsbCB0byBjZXBoX21kc2Nf
c3VibWl0X3JlcXVlc3QoKSBzdWJtaXRzIHRoZQ0KPiA+IENFUEhfTURTX09QX1VOTElOSyB0byB0
aGUgTURTLCBidXQgZG9lcyBub3Qgd2FpdCBmb3IgY29tcGxldGlvbi4NCj4gPiANCj4gPiBNZWFu
d2hpbGUsIGJldHdlZW4gdGhpcyBjYWxsIGFuZCB0aGUgZm9sbG93aW5nIGRyb3BfbmxpbmsoKSBj
YWxsLCBhDQo+ID4gd29ya2VyIHRocmVhZCBtYXkgcHJvY2VzcyBhIENFUEhfQ0FQX09QX0lNUE9S
VCwgQ0VQSF9DQVBfT1BfR1JBTlQgb3INCj4gPiBqdXN0IGEgQ0VQSF9NU0dfQ0xJRU5UX1JFUExZ
ICh0aGUgbGF0dGVyIG9mIHdoaWNoIGNvdWxkIGJlIG91ciBvd24NCj4gPiBjb21wbGV0aW9uKS4g
IFRoZXNlIHdpbGwgbGVhZCB0byBhIHNldF9ubGluaygpIGNhbGwsIHVwZGF0aW5nIHRoZQ0KPiA+
IGBpX25saW5rYCBjb3VudGVyIHRvIHRoZSB2YWx1ZSByZWNlaXZlZCBmcm9tIHRoZSBNRFMuICBJ
ZiB0aGF0IG5ldw0KPiA+IGBpX25saW5rYCB2YWx1ZSBoYXBwZW5zIHRvIGJlIHplcm8sIGl0IGlz
IGlsbGVnYWwgdG8gZGVjcmVtZW50IGl0DQo+ID4gZnVydGhlci4gIEJ1dCB0aGF0IGlzIGV4YWN0
bHkgd2hhdCBjZXBoX3VubGluaygpIHdpbGwgZG8gdGhlbi4NCj4gPiANCj4gPiBUaGUgV0FSTklO
RyBjYW4gYmUgcmVwcm9kdWNlZCB0aGlzIHdheToNCj4gPiANCj4gPiAxLiBGb3JjZSBhc3luYyB1
bmxpbms7IG9ubHkgdGhlIGFzeW5jIGNvZGUgcGF0aCBpcyBhZmZlY3RlZC4gIEhhdmluZw0KPiA+
ICAgIG5vIHJlYWwgY2x1ZSBhYm91dCBDZXBoIGludGVybmFscywgSSB3YXMgdW5hYmxlIHRvIGZp
bmQgb3V0IHdoeSB0aGUNCj4gPiAgICBNRFMgd291bGRuJ3QgZ2l2ZSBtZSB0aGUgIkZ4ciIgY2Fw
YWJpbGl0aWVzLCBzbyBJIHBhdGNoZWQNCj4gPiAgICBnZXRfY2Fwc19mb3JfYXN5bmNfdW5saW5r
KCkgdG8gYWx3YXlzIHN1Y2NlZWQuDQo+ID4gDQo+ID4gICAgKE5vdGUgdGhhdCB0aGUgV0FSTklO
RyBkdW1wIGFib3ZlIHdhcyBmb3VuZCBvbiBhbiB1bnBhdGNoZWQga2VybmVsLA0KPiA+ICAgIHdp
dGhvdXQgdGhpcyBrbHVkZ2UgLSB0aGlzIGlzIG5vdCBhIHRoZW9yZXRpY2FsIGJ1Zy4pDQo+ID4g
DQo+ID4gMi4gQWRkIGEgc2xlZXAgY2FsbCBhZnRlciBjZXBoX21kc2Nfc3VibWl0X3JlcXVlc3Qo
KSBzbyB0aGUgdW5saW5rDQo+ID4gICAgY29tcGxldGlvbiBnZXRzIGhhbmRsZWQgYnkgYSB3b3Jr
ZXIgdGhyZWFkIGJlZm9yZSBkcm9wX25saW5rKCkgaXMNCj4gPiAgICBjYWxsZWQuICBUaGlzIGd1
YXJhbnRlZXMgdGhhdCB0aGUgYGlfbmxpbmtgIGlzIGFscmVhZHkgemVybyBiZWZvcmUNCj4gPiAg
ICBkcm9wX25saW5rKCkgcnVucy4NCj4gPiANCj4gPiBUaGUgc29sdXRpb24gaXMgdG8gc2tpcCB0
aGUgY291bnRlciBkZWNyZW1lbnQgd2hlbiBpdCBpcyBhbHJlYWR5IHplcm8sDQo+ID4gYnV0IGRv
aW5nIHNvIHdpdGhvdXQgYSBsb2NrIGlzIHN0aWxsIHJhY3kgKFRPQ1RPVSkuICBTaW5jZQ0KPiA+
IGNlcGhfZmlsbF9pbm9kZSgpIGFuZCBoYW5kbGVfY2FwX2dyYW50KCkgYm90aCBob2xkIHRoZQ0K
PiA+IGBjZXBoX2lub2RlX2luZm8uaV9jZXBoX2xvY2tgIHNwaW5sb2NrIHdoaWxlIHNldF9ubGlu
aygpIHJ1bnMsIHRoaXMNCj4gPiBzZWVtcyBsaWtlIHRoZSBwcm9wZXIgbG9jayB0byBwcm90ZWN0
IHRoZSBgaV9ubGlua2AgdXBkYXRlcy4NCj4gPiANCj4gPiBJIGZvdW5kIHByaW9yIGFydCBpbiBO
RlMgYW5kIFNNQiAodXNpbmcgYGlub2RlLmlfbG9ja2ApIGFuZCBBRlMgKHVzaW5nDQo+ID4gYGFm
c192bm9kZS5jYl9sb2NrYCkuICBBbGwgdGhyZWUgaGF2ZSB0aGUgemVybyBjaGVjayBhcyB3ZWxs
Lg0KPiA+IA0KPiA+IEZpeGVzOiAyY2NiNDU0NjJhZWEgKCJjZXBoOiBwZXJmb3JtIGFzeW5jaHJv
bm91cyB1bmxpbmsgaWYgd2UgaGF2ZSBzdWZmaWNpZW50IGNhcHMiKQ0KPiA+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9mZi1ieTogTWF4IEtlbGxlcm1hbm4gPG1heC5r
ZWxsZXJtYW5uQGlvbm9zLmNvbT4NCj4gPiAtLS0NCj4gPiAgZnMvY2VwaC9kaXIuYyB8IDE1ICsr
KysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2Rpci5jIGIvZnMvY2Vw
aC9kaXIuYw0KPiA+IGluZGV4IDg0NzhlN2U3NWRmNi4uNjdmMDRlMjNmNzhhIDEwMDY0NA0KPiA+
IC0tLSBhL2ZzL2NlcGgvZGlyLmMNCj4gPiArKysgYi9mcy9jZXBoL2Rpci5jDQo+ID4gQEAgLTEz
NDEsNiArMTM0MSw3IEBAIHN0YXRpYyBpbnQgY2VwaF91bmxpbmsoc3RydWN0IGlub2RlICpkaXIs
IHN0cnVjdCBkZW50cnkgKmRlbnRyeSkNCj4gPiAgICAgICAgIHN0cnVjdCBjZXBoX2NsaWVudCAq
Y2wgPSBmc2MtPmNsaWVudDsNCj4gPiAgICAgICAgIHN0cnVjdCBjZXBoX21kc19jbGllbnQgKm1k
c2MgPSBmc2MtPm1kc2M7DQo+ID4gICAgICAgICBzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZF9pbm9k
ZShkZW50cnkpOw0KPiA+ICsgICAgICAgc3RydWN0IGNlcGhfaW5vZGVfaW5mbyAqY2kgPSBjZXBo
X2lub2RlKGlub2RlKTsNCj4gPiAgICAgICAgIHN0cnVjdCBjZXBoX21kc19yZXF1ZXN0ICpyZXE7
DQo+ID4gICAgICAgICBib29sIHRyeV9hc3luYyA9IGNlcGhfdGVzdF9tb3VudF9vcHQoZnNjLCBB
U1lOQ19ESVJPUFMpOw0KPiA+ICAgICAgICAgc3RydWN0IGRlbnRyeSAqZG47DQo+ID4gQEAgLTE0
MjcsNyArMTQyOCwxOSBAQCBzdGF0aWMgaW50IGNlcGhfdW5saW5rKHN0cnVjdCBpbm9kZSAqZGly
LCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICog
V2UgaGF2ZSBlbm91Z2ggY2Fwcywgc28gd2UgYXNzdW1lIHRoYXQgdGhlIHVubGluaw0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAqIHdpbGwgc3VjY2VlZC4gRml4IHVwIHRoZSB0YXJnZXQg
aW5vZGUgYW5kIGRjYWNoZS4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICBkcm9wX25saW5rKGlub2RlKTsNCj4gPiArDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgKiBQ
cm90ZWN0IHRoZSBpX25saW5rIHVwZGF0ZSB3aXRoIGlfY2VwaF9sb2NrDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICogdG8gcHJlY2VudCByYWNpbmcgYWdhaW5zdCBjZXBoX2ZpbGxfaW5v
ZGUoKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIGhhbmRsaW5nIG91ciBjb21wbGV0
aW9uIG9uIGEgd29ya2VyIHRocmVhZA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIGFu
ZCBkb24ndCBkZWNyZW1lbnQgaWYgaV9ubGluayBoYXMgYWxyZWFkeQ0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAqIGJlZW4gdXBkYXRlZCB0byB6ZXJvIGJ5IHRoaXMgY29tcGxldGlvbi4N
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICBzcGluX2xvY2soJmNpLT5pX2NlcGhfbG9jayk7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKGlub2RlLT5pX25saW5rID4gMCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGRyb3BfbmxpbmsoaW5vZGUpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IHNwaW5fdW5sb2NrKCZjaS0+aV9jZXBoX2xvY2spOw0KPiA+ICsNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICBkX2RlbGV0ZShkZW50cnkpOw0KPiA+ICAgICAgICAgICAgICAgICB9IGVsc2Ug
ew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fbG9jaygmZnNjLT5hc3luY191bmxp
bmtfY29uZmxpY3RfbG9jayk7DQo+ID4gLS0NCj4gPiAyLjQ3LjINCj4gPiANCj4gDQoNCk1ha2Vz
IHNlbnNlLg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtv
QGlibS5jb20+DQoNClRoYW5rcywNClNsYXZhLg0K
