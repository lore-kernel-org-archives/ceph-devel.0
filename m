Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D5367F36
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010616; cv=fail; b=nmcdW5wurBKAu3oLQcVBzOG+nXlU+k/73yM7PtNNf4QY+9SfQqps6usAQvhKC0vw9py0ncDSuWw/D+GJbG0JK8BvJMaI6B6MA54JAo27CmgRSwm8tJmVaauQiThkzLdYhUAqn0IGCwtAyuvPX6ojYV04OIXvXACH31dMuZREN94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010616; c=relaxed/simple;
	bh=Ng2ns2ZRRXFribKwBCZluDGglYMKatKekrgFYMYVDzA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=h4MZRP8hGkhnNYj//4+VS1it+92ueiM4y9dus+druO35uJEMOb7jEPlJXtEjqYzI/TNvisxmVGhvba2goRsIgE7FwtE671VcXtaRXVGkQoyuv+KVOd17r5H58K67W1ElMm7bXvZGU3o7AGPND//NNehph+5XBdzBLdzb78263ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NJ0WHH1T; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NJ0WHH1T"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlndI3215611;
	Thu, 28 May 2026 23:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=Ng2ns2ZRRXFribKwBCZluDGglYMKatKekrgFYMYVDzA=; b=NJ0WHH1T
	TV0fJQ62r3oS+BmPjnbpsJFkS9kEERnNv9AS+QhHr4p5Fz84/o0C4mw2Nyaa4VJd
	t8ZjQElkWSqYAEmPWbg854zEOLLSXrfeb1xgETtN7bJVznmBLMjGzIUVJOUGPgur
	12+Jime0/Q44d3Iz3GHnp+1Gb1USxgpOwJxj1a9op+D7dgJmKBJfQ/IFwam7FQwj
	57eS+I+nrG6nPxVshKf5XpWqh48toL579D+bBOo9+yHZz8G0QCw4bWmxslF21cLW
	B/hKZ1r0TENXx8iTTFyBSYkc211kVJZkdCCMwnDxdxPKfldCyUcuN6LNnjO4xCZr
	ehTcmbzYF2HU4g==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bddc8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 23:23:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhzEtKB+7p8hjlRcEmMLPhvoCM7yB5mHuESapxcORh1P3kKMNmUn8cSFkB5Llb1XssrT6yXik5arr7GbhdefuBglJdrVcJZe17D8Kj8BG8PpXtAIzrXwVHT9tURw9ktgYHXWpIeHrNyix5W4+/+lXpB6Le8CEE50uUXL/GO1sy49+TWbIw2hihSjbLMk75p7BHlJIHyPqcyhw9pe9aiVV/5+g9YqqyRkE7uzPWl+XFDTPXAJKenz2ytLA1erYd2mw1/0QQXb8qgw35e75H2XGRgV9BKK46Y5AK0TlhqeZPDa5WTMKSiFp1YzLti6rTHbGIMCvvcdgfxH+iyCBdaN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ng2ns2ZRRXFribKwBCZluDGglYMKatKekrgFYMYVDzA=;
 b=Sg99uoSdQxcsRlC7pG8HfQ7K+3TCS8qu8ufOPttk3dcGI/c5NVwC9hpvEVrOCP2Wqn5Him4AR+26C1T6nN2QnavTj885wSKpy7r+0EcUT8vcbyXiHBtx8j/rOnarONVuUP0AfkULkfBTcfs1jJg9hTq6yRet8dPLFMBovwMaHbWQBdiAG9n3JWq0jpOS0QWgYmgRmCtVuhGFZ8RhOUxHLiWgICzxc6SIA5b68dAx0MitdQUJJJdZ71A8iDLYaiZVki/mK2U1mX0ViyStbL5LbgO9RJgqisMYNHkYIZH0u+k1gOyEURnR/b2iT90Cs6Jxkb92okZwjHLveZ1aMu6qow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by DS0PR15MB6013.namprd15.prod.outlook.com (2603:10b6:8:157::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 23:23:23 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 23:23:22 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "hexlabsecurity@proton.me" <hexlabsecurity@proton.me>
CC: "security@kernel.org" <security@kernel.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        Xiubo Li
	<xiubli@redhat.com>
Thread-Topic: [EXTERNAL] RE: [REPORT] fs/ceph: malicious-MDS kernel OOB read
 via unbounded snap_trace_len in CEPH_CAP_OP_IMPORT (since v2.6.34)
Thread-Index: AQHc7mmRCYgHgLo8O0+p6652EIJDSbYj/l6AgAAVQICAAAGAgA==
Date: Thu, 28 May 2026 23:23:22 +0000
Message-ID: <e694e55521bee6b8f9c80895749b9cfa5d74a3f9.camel@ibm.com>
References:
 <cEUA87QPkzfvf28KWaj4f8hEVYBkHl6Gc9sqTYM2Ld-H76SJIpst6wVPSu55qpViAeMPeUWyLrYyDQTzG8Mj969WqjThU58gj56D1GF8X8g=@proton.me>
		 <2026052843-unread-quicksand-1da9@gregkh>
		 <ved5l12DIYeOrtpiOyxLZX4Q6ns8pHePwLZ9NSRbYVkoN2MgZWVMYx_5pR-MwzWqQlZ6AeWTI0PWWqprXZx0nCkjSTGR8Mv2GEsKBjIzf0o=@proton.me>
		 <449e934b182ba6d8f6f4912f71bd1263630396d6.camel@ibm.com>
	 <L-m2MCIXcXV8COv8VZ3KxX7UtnbDB6zYlSmb-0m39OXp14kxgQ_PSenP2p1WUtrXmqQvQ4-5yxdYi3lKUTlvPPBGaoLBGjbqfY5BUCilY_8=@proton.me>
In-Reply-To:
 <L-m2MCIXcXV8COv8VZ3KxX7UtnbDB6zYlSmb-0m39OXp14kxgQ_PSenP2p1WUtrXmqQvQ4-5yxdYi3lKUTlvPPBGaoLBGjbqfY5BUCilY_8=@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|DS0PR15MB6013:EE_
x-ms-office365-filtering-correlation-id: 655cf213-aa0d-4fc4-a0ef-08debd101c2a
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|22082099003|38070700021|18002099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 pfMR/kKxiPomNYylXxJd9Joy9XvkaPRwhcf0DkxqqRKr85bCzUqNGinHLD8WSmtDYTlKaqFS6mhSjciIQa8NDw0lDjIyxoceslgkP18gQdFgH1rw8eR3Jn49gnfpXU9/AQ32huZ3BEiW5//LXxgTEykkERLtpx1+WH1zHyGwfIb6unBVHwZb2gv6O3JdAxN/o/l2a+fYiqwXx+DW0U+jCzgvg72gGFh+fAlRcTJUlEVD08fDryqj1u3Q3zZWQT2M1CSGpe9nZco7tiXxoxnzunpG8eRxDGFnSHlHou7K/MXG8IZM0IShl0ZBPKptTh4IBdrJxicVWj9b/lHYLb6LENOTbbqWMtsKNy6ZeigrnPAgN0WGPr1HVQ+Cxwq6AwSVBYg8Wcx450gmug+xLhjzLQ46erZfjjkTXu4uIb8aA3AWPF5kcE9iLP/vSHHojhtdDh9U7Fm7Rtk/msbU+UDQBtzK/hGr6bSuaR3WtbZs6F+3QUqAajfaRKM8jf0RFRTItGwLeFQTikVzcIG5HT+Z9mJOEDdGeYEK2DE3oom93iLfRkX0hoMQ0LRbVKBPijv7a7ZU31iR2lnh8bVDN8NV6syO5jk8e3WLA7PEInRQHgNFORhHN8AMY8Stl79kWtx7kzgfuFqR350MumlMhadGAJO6okFI5Wduie38FOt9iFTP2NEfitejh3eC86rwpiALQSOoMYOIw2TK9uYzjtii2Gj2H3axO6P1fXIicxUAyLGhNIwlDlr+sFa+Ql9Racem
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(22082099003)(38070700021)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEUxdFJMUTJlMStyNUFFWjAvcldtYXR0dk1yT1VFS2dUdkp5Wk56SGNvZys3?=
 =?utf-8?B?czJPQ216cXJWR1F2SUtnYURLc3U3UzhFbUVsTXZKbEl4RW5tSnNaenA0NE1y?=
 =?utf-8?B?R1hxd0JDbDN0WXZTUzZ0UlIxaU9KN3B0Zm5YdlVDY25nYnRsQ2paWm95bmxs?=
 =?utf-8?B?WVUwUzd0bEN1MWRoSlhMa216RTBWMTdZQXF3VmhiVkxQcUJRZVJlU3U2Sm16?=
 =?utf-8?B?VFhwMi9ONktIVUFQeXFORGhxbnZ5THdjVEtlUFF2NHNEbDVQM3pTNEFkbERv?=
 =?utf-8?B?S3RETzArRmNHVlYrd01DNlBuV2Rob2JudUF4cGFDMlU4ZmNxTkV2UzY4U1Bs?=
 =?utf-8?B?ZGJXVkZXVlU5Skdrc3NjR2dKTlF1K0RhUFlvZmtVYW5ubEJmTHYweWU0R3hr?=
 =?utf-8?B?SnMwQy9wNlNWNzJlWHdNN3d0Zjk4WWJPWUIrNDhla05xcVhFM3NtZlJQYVpE?=
 =?utf-8?B?SUVNZEd4ZnRlVlVua2tXVG9LNDJkaVB4VVo5RHNoTi9DNWxBUG5RSXVOYVRy?=
 =?utf-8?B?cmhTbjdlR1VQODJnN3NWOGEzZkVKdi9jYjFCSjBVbjZFUXgyNHN1YnZqR1RC?=
 =?utf-8?B?NmtYKzZVSjd6MWtyeDJYSEhHVkl3UVhXWTQyelhoaHE3SVFhb1FOcU1oQ2Iw?=
 =?utf-8?B?K3JBRXUwL2MvWHNaamloVGVFVHN1NFZNZE9LM045SHhaZWpBOEFCa2F5VTFQ?=
 =?utf-8?B?dlU5L1BxUkcwMmxuOWlsZzhzaC8yOW5pbGswUVRabEpnbkZKRk91SVdJN0FQ?=
 =?utf-8?B?Mm5RdHRGNEhrMDlLVlVVVXlpQ21wUVJycHlOTVFWbThmUW5EeHBua0FLTklN?=
 =?utf-8?B?Z01PU2t4U0VpTjhCdVR3TUQ3dm9lTGgvVWRMekpJRDNGRkQ0cTFuT1JUOTNR?=
 =?utf-8?B?RThsVEhicXlQWlZzL3pJb2o0T2U0VWk2WVRDVGlXajVIM0VGSFZpRTdCSDF4?=
 =?utf-8?B?R0p1eWhLZXpaVGNhdGVzOVlHMFN6UHdhV0ZhZUJYWnBMRGxQSmQ3OGYxR1Ba?=
 =?utf-8?B?aWVpcGNkSFhXSHUwcWNKMHFOWDFQTy9mSWlCbWpuTnZaMlZ0aDFPb1I2dTAz?=
 =?utf-8?B?bjIxcU9GSDQ5VGhvTS9PZDN3ZlpEZmxGZWwzMmFHUngyUGZ5NnhXYk1FTkpV?=
 =?utf-8?B?cyt6c2RCb0VYL1kwaWFRM1Nyc0RmREhEZlRkaHBUeXZBemIrUFREUHdDS091?=
 =?utf-8?B?d0UxcnNYcVdsdEloWHpEZmIzeXY4Zy96M1NJTVZLamJDeUx0a3l0Y1J0ODJu?=
 =?utf-8?B?UE5pZVBhVnhFcFdHM2RBMUtTZ1hNeVdjNFc2L0JPM2NGWVNLZldTeVRtZC95?=
 =?utf-8?B?YVhodnZEQkdnVG1hb0kwK3FTVk9EbmVZZ214ak92K25hNTdDbVY3amp1Z1Zp?=
 =?utf-8?B?dEFSRjIzelZkMlB6T0hlVUVQYmJ5QjhUaTB0WkFYSk1ic2ZiNlRSeVhHc2cr?=
 =?utf-8?B?eGNOcUhWN2ZKVXg0bTlEUlMxRFVBblY2ak5JOEQ0eTBpbmFyaEhLUXhTUi9W?=
 =?utf-8?B?ak9hd0h1UVlJcmFlSWRWa0VSS1R4eTJOdTgyK1FpTlJON1VJUFd1a21rVmZa?=
 =?utf-8?B?Qk9vZmVZNGhRR2treFNHemQ4bHhrUzZMa0RwbitpT0krUlhMMVgxdUd1MFdZ?=
 =?utf-8?B?dU5FVGFwY0RRR3NoaUFOVzkweHdqNXJWS21sU3EzRkM5b0JlN3BHUTRDWHZ5?=
 =?utf-8?B?MVlhZnlrZnNpZmNkdWM4WGFuVjFFdzNJcSsvajlkT21DNXo0eENNdFVaRGlS?=
 =?utf-8?B?MHhtSmZYWk5GTEJPV0tiNzBXUHJEdVpJNTJoU1lzak9yazM4TDdnbHVRTEZ0?=
 =?utf-8?B?dEV3d0trMXdzVHI2L2hTWkJGb2tPZWtNaVRGVVl2ZGpKQjJJUHc1WDNJcmQz?=
 =?utf-8?B?dEN1QlhEemtFdFRnY1dVdXl2VjdBNC9VaEQvZXJvbkRPWWg3aU1VdHVhSXZF?=
 =?utf-8?B?NFVuN2Y3clBWTGk4UUJMd0tXaDdPOU8vS0pPUm8rbE1DWHZVRVQ5QU5rS3Ez?=
 =?utf-8?B?cW82anhCMVJhQTdrYTFDelBhbWpaK0NOU3F2c2tieDNSYU9xajRVRkdqL3dZ?=
 =?utf-8?B?Q3g2dTlNZXV1T1pNd1ltMjUxNS9BTWgrZ21RZkNqRzd6YktLLzdMT2ZoY05T?=
 =?utf-8?B?Q1BHQXJFZCs1Y0I4cXNueG5Vb0lFRXVVK1JuelpNaHRKeG9aY2x0bU1uMVVZ?=
 =?utf-8?B?cTd5NXNpRzE2NUYycW45OFgzdTl0UTh3MFNZbVFjNldMUzh1RjZ5UXpQc3Iz?=
 =?utf-8?B?eXFUYjRzM0FVRUZ2b1dwdC9Xa3VDaEdmNUxZakZNWmVSMjBieFE2RllPdWdW?=
 =?utf-8?B?ZjQ1eUJUZU92a1pHekdVSE44MGNyaG9MWVAwSDk1dGNKVnFEZHJhY3k1b1BO?=
 =?utf-8?Q?c/rW6++4R3f8zy+HX6TU3RDb90bDSG2VR9+a6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94233687B9CFA6418F535A2443F6B0BC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	oEKYOAOX9MWvKBhNdUPlusIRw5lasItJ+axNLGuEt3t9AU+etcOFPsJlsqV4ZpoJFy7nubudDbHBUV2GMC1rpFrQtz5XFDqS88z6b3HN42YwnwFO57K8Qoqq1L6qgZVTxZMngCJvex38UMtRCsyWQGi9bbfNJ3ckKGdFTFhdBRpLKpQmLbdcajb9h+cDIItt19deN1ECOHh99Hjl89ejpoJgqWZiM0LyJUjOkq3MOykb69Jd/huvCWo29iCQlCQwi1MQeAWAOU5HdeYaDgwLectZRRkFx8lCoSr9fCyS5VU3JXm2glizhQvmmXjhg9YE0OgrFdAyIHQM1tx08romoQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655cf213-aa0d-4fc4-a0ef-08debd101c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 23:23:22.2766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9I30yJWA37X6yZkzBAc/myLZzSjlVf4JVSphshhOuCRbUy10e40tIsAcEIHZMfwd+llbtA6zZH0qbqi6q7MBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6013
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIzMyBTYWx0ZWRfXznLsuim8guLc
 rcl1V7sb8Qm3KQKFQCUOkfev6w3Vn/H3PkZrzJZI2Afs5vaY6FMzFO8r2pdPoBWBX33TNFnooyb
 3aziupECKoGQ12k+r5mJt9I4UJnuGdzLR00dK4EXu1etsWRE9qxoGTD+YlXzQ5AZRgW7MqsGtMY
 AJmNFeghxlGph7qXaOBjppZGtTtbPIquE8WpOfkfBj4OTop0uaJvKD7lyIH4gpvzivKYBjnKOZy
 Iy/8WUZPHzty5I3MDEW4JX9VkHRd4h+qSDlsz6i3WgRcA7lC78kYS4QNLiMyfS0M2IL0wqydG/4
 iFXjoxbf8G+OZsZqC2xkW+PUbwyJzqi8wUZ4V/X6uv6x/96yFc1Y3NL9O6z8VGDpZ+bd99cynol
 Aphs9G3qwz+UpvdoOqTKJ23wPccwn4PrzO16BXHjJrirrINktqe36b19aWl8zXfp+iZfD4IvvPp
 ipelRKPijFerF/Ritvw==
X-Proofpoint-ORIG-GUID: taC1I4d_GMCfgmEh99pus2RjS60n-myw
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a18ce6e cx=c_pps
 a=VugNgcmXu5HSfOtR6yJkXA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=RVfVJbpfiwzIniM5gL8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OiOk4vga2EVDXMxcXESCXefzBQ9FoXCS
Subject: RE: [REPORT] fs/ceph: malicious-MDS kernel OOB read via unbounded
 snap_trace_len in CEPH_CAP_OP_IMPORT (since v2.6.34)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280233

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDIzOjE3ICswMDAwLCBoZXhsYWJzZWN1cml0eUBwcm90b24u
bWUgd3JvdGU6DQo+IEhpIFZpYWNoZXNsYXYsDQo+IA0KPiBUaGFua3MgZm9yIHRoZSByZXZpZXch
DQo+IA0KPiBJIHVzZWQgdGhlIHN1YnRyYWN0aW9uIGZvcm0gb24gcHVycG9zZS4gIHNuYXBfdHJh
Y2VfbGVuIGlzIGFuDQo+IGF0dGFja2VyLWNvbnRyb2xsZWQgdTMyLCBhbmQgb24gMzItYml0IChJ
TFAzMikgYnVpbGRzIHRoZSBhZGRpdGl2ZSBmb3JtDQo+IHNuYXB0cmFjZSArIHNuYXB0cmFjZV9s
ZW4gY2FuIHdyYXAgdGhlIGFkZHJlc3Mgc3BhY2UgZm9yIHZhbHVlcyBuZWFyDQo+IDB4RkZGRkZG
RkYgYW5kIHNpbGVudGx5IHBhc3MgdGhlIGJvdW5kIGNoZWNrLCB3aGVyZWFzDQo+IHNuYXB0cmFj
ZV9sZW4gPiBlbmQgLSBzbmFwdHJhY2UgaXMgd3JhcC1zYWZlIC0tIGl0IGlzIHRoZSBzYW1lDQo+
IGFyaXRobWV0aWMgY2VwaF9oYXNfcm9vbSgpIHVzZXMgaW50ZXJuYWxseSAobiA8PSBlbmQgLSAq
cCkuICBUaGUgZWFybGllcg0KPiBtc2ctPmZyb250Lmlvdl9sZW4gPCBzaXplb2YoKmgpIGd1YXJk
IGd1YXJhbnRlZXMgZW5kID49IHNuYXB0cmFjZSwgc28gdGhlDQo+IHN1YnRyYWN0aW9uIGNhbid0
IGdvIG5lZ2F0aXZlLiAgKENPTkZJR19DRVBIX0ZTIG9ubHkgZGVwZW5kcyBvbiBJTkVULCBzbw0K
PiB0aGUgMzItYml0IGNhc2UgaXMgcmVhY2hhYmxlIGluIHByaW5jaXBsZSwgZXZlbiBpZiByZWFs
IGRlcGxveW1lbnRzIGFyZQ0KPiA2NC1iaXQuKQ0KPiANCj4gSSBkb3VibGUtY2hlY2tlZCBib3Ro
IGZvcm1zIGluIGEgc21hbGwgdXNlcnNwYWNlIHRlc3QgY29tcGlsZWQgYXQgLW0zMg0KPiBhbmQg
LW02NCAoZ2NjIC1mbm8tc3RyaWN0LW92ZXJmbG93LCB0byBtYXRjaCB0aGUga2VybmVsKSwgZmVl
ZGluZw0KPiBzbmFwX3RyYWNlX2xlbiA9IDB4ZmZmZmZmZmY6DQo+IA0KPiAgIC0gNjQtYml0IChM
UDY0KTogIEZvcm0gQSAtPiBnb3RvIGJhZCwgIEZvcm0gQiAtPiBnb3RvIGJhZCAgKGVxdWl2YWxl
bnQpDQo+ICAgLSAzMi1iaXQgKElMUDMyKTogRm9ybSBBIC0+IGdvdG8gYmFkLCAgRm9ybSBCIC0+
IHBhc3NlcywgT09CIHByb2NlZWRzDQo+IA0KPiBTbyBvbiB0aGUgdXN1YWwgNjQtYml0IGNvbmZp
Z3MgdGhlIHR3byBhcmUgZXF1aXZhbGVudCAoeW91ciAibm90DQo+IGNyaXRpY2FsIiByZWFkIGhv
bGRzIHRoZXJlKTsgdGhlIGRpdmVyZ2VuY2Ugb25seSBzaG93cyB1cCBvbiAzMi1iaXQsDQo+IHdo
ZXJlIHNuYXB0cmFjZSArIDB4ZmZmZmZmZmYgd3JhcHMgYmVsb3cgZW5kLg0KPiANCj4gSWYgeW91
J2QgcmF0aGVyIGtlZXAgaXQgY29uc2lzdGVudCB3aXRoIHRoZSBzdXJyb3VuZGluZyBkZWNvZGUg
Y29kZSwgSSdtDQo+IGhhcHB5IHRvIHJlc3BpbiB2aWEgdGhlIGNhbm9uaWNhbCBoZWxwZXIsIHdo
aWNoIHN0YXlzIHdyYXAtc2FmZSBhbmQNCj4gcmVhZHMgdGhlIHNhbWUgd2F5IGFzIHRoZSBwb29s
X25zX2xlbiBjaGVjayBhIGZldyBsaW5lcyBiZWxvdzoNCj4gDQo+ICAgICBjZXBoX2RlY29kZV9u
ZWVkKCZzbmFwdHJhY2UsIGVuZCwgc25hcHRyYWNlX2xlbiwgYmFkKTsNCg0KSSB0aGluayB0byBi
ZSBjb25zaXN0ZW50IHdpdGggdGhlIHN1cnJvdW5kaW5nIGRlY29kZSBjb2RlIHNvdW5kcyBuaWNl
LiA6KSBJDQpkZWZpbml0ZWx5IHByZWZlciB0aGlzIG9uZS4NCg0KPiANCj4gSnVzdCBsZXQgbWUg
a25vdyB3aGljaCB5b3UgcHJlZmVyIGFuZCBJJ2xsIHNlbmQgdjIgY2FycnlpbmcgeW91cg0KPiBS
ZXZpZXdlZC1ieS4NCj4gDQo+IA0KDQpTb3VuZHMgZ29vZCENCg0KVGhhbmtzLA0KU2xhdmEuDQo=
