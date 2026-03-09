Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A03603F2
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773083897; cv=fail; b=iDlHyAGhOyhtiiO6MSp4/gp/ysmXxsIA/pSOx+XXKW7l5XF6fwqOGQj5UkqmMS7xUmFMJsxQ3eHt+3zPrVecl9IpottXp+KGMOfYdl67hNQRFpuC57W+ZFRb6IR1vFYIiq1GM9iK76X5hCL/dBl5mxQgEdqa6ZqJztguz0iJ0bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773083897; c=relaxed/simple;
	bh=uMIHfd5Pq2wUSZ8Evp+q4QXULYxULnVZ2OoKv35i1qk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=E/oPz/71OZp9n+uV0+yb/5t64EEJwr0lCY5sf+WxLbX7BNAuSWbr4J0ORLvoCn6CP3qrq9aRmb1wtVqCKATZs2pjcdwtyI3tIAiFtXqG6eoAynAL7E7nqwWgxXBoBYXUTeHywDAm/6mlHw9rru6xLnlae/vPaSryibUTEtv6tNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NbttdfvK; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NbttdfvK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629F2mYb1388081;
	Mon, 9 Mar 2026 19:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=uMIHfd5Pq2wUSZ8Evp+q4QXULYxULnVZ2OoKv35i1qk=; b=NbttdfvK
	1EkXER3s2G6p1b6UG6jZFJBSCKlocZ+wPNIpkcBREGgDnT4kk7Xd5hcGIPYupkio
	Ul+TAU1dBLXDhV652gUXT7sXU/xqlre4yPT5ghb6ljPd0mltWGa1ZKHdTgxWbfa0
	4GYc8yb6Gao1n7pZb+Y7KIGR/1Epkui+eWB+m9e3oWMd8LKpvIQvLrQAbv+w5gwd
	JMsRZCO5cuaKPmFY69KQVJTCGv4ikYj5gW61VfNV511CaYV+Px3U4gFmA4D7OSA4
	FVcZ2k4rTiHpDOqgjzWOSaBwWm/6pBR1YEylXAXKkLIKhreJPMZG5welRKiWO2nF
	3im0tu7RneAlbA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun7t52-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 19:18:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf1AxxCIVkZZkdooj4JPI3MBNjol3slPq2vMKNhN/ccYXssbT5l31qaj+79NBy83v+s8+0JTqbCy6mj536OjJsyTinxYdMgN4TxfeUXKlILMVZr6g6hStsbZWUJajxXkHjEaiUzZ2BgzbcPB/oxf8pJhcXEsQa/evMjRIBK0Vx/ZXkrG4ZrtY0whIGD/NT58f8pOxCpFJapLjYnJy68Rg0JrhjvBfr49p2lq0OMDfeAF02R33xWzFl4lWYQYU1WsY6Jjqx8VxdAT5VrD/FsaTVs7jOemygh71d/j+8NdNwwPz+Gzdkh4WJd722/O91V9P+/TA1WZjzezwf99LDSUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMIHfd5Pq2wUSZ8Evp+q4QXULYxULnVZ2OoKv35i1qk=;
 b=F+ozwYDJz8apQWak6hfgXd88hBIwA4+MYyGGLUt8m62r0yVZmqpudQHzD4Sq60mqHluZZMiaSbuTf19CDhQ4h3fb+95PIJlH3wUZVCyANBWMyDpM8I+jxxfrC8n1yK6mKAUOBNyJs7bkO1BELX8y+GWTvGxJCcpWCOPUN91sTZdHFOVXNpaC/H22z3QI+ZJSXRQ33ne4HlgEIFi0Uupgn0fOln4o4mvjM0YP1BkA/5TCSskDwpsZls/+i+PUYbQrPRaycYe2hn8bygnUuMv9D9bGFkhut0gpAXefgKYBH+BVezFo+jKXL1KKnlHgT0Mt3mpuGf815uOxySR6jHMX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4220.namprd15.prod.outlook.com (2603:10b6:a03:2cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 19:18:08 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 19:18:07 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>,
        Alex
 Markuze <amarkuze@redhat.com>
Thread-Topic: [EXTERNAL] [PATCH] libceph: reject preamble if control segment
 is empty
Thread-Index: AQHcr0iXsr7ZhCoIhEGVODrqxpqIRrWmlFqA
Date: Mon, 9 Mar 2026 19:18:07 +0000
Message-ID: <a02c4542718e9647072bcb7661f4d7834c64fcaa.camel@ibm.com>
References: <20260308221142.695096-1-idryomov@gmail.com>
In-Reply-To: <20260308221142.695096-1-idryomov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4220:EE_
x-ms-office365-filtering-correlation-id: 66ef133e-f1af-4366-694c-08de7e1098ab
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 4Hg1KsqfN1yJ6A/i0Cq2yFottRP/DvzElLHLeniDpu5T0cNIwgIFlyqMOojxzGfbvQP0I/uRcT+faNLc/L0nrQWlo1dtHLzMNxAEvtCA0l3znjZVRO90Xx/HT+SmYgKi5JqnWDfQHT5cwF+bdtwKt98IqaNRw7fYYQiZ8QUqQwDtgit6g6KhTupJtBWvKe5hN7hsn68lcGL66pQrIc1Dnr1IK5yfLVXuZFOM7Edk+FgFDnxt5mrEoudEyVz+5g2e9xoedMdImVLJIz3FqdOtpKDC3xThlThU6GO30EKl9m59/K8Wp9oeaUuQTKbAUztdxOuvl6OuqUYVZEZdiecx9A7mWT6XuU+GH5pkgjJVQPRHDT3uZhaJ95XX4FLXsRuL8LN+zEBVZtpHN1a3dyeDw/HiQdS0TnlmHHuiIxu7435KENFXrfBiSewgWCijCgiaLT/GtfWDuDgG0cAymMHRnuhhlwiJ2AHj7G9HAmwXAsaIg+2FwnoA2pdWkIjQ4VwcYlMykZ2CkgrAb4uRCbmwYkuFKhrR9GlwpQaO6hNJYLKA6TAS0lqvuMU1IE3AukjeXaSyAbVjXWxHNSY1o2o7AtdhSsvNoDAd9KjQEROHaxr0+JPtGcNY6DWltXAyROnyWNuh093HnfB/eIpTiOp9+kFS1ZZMLm4gxizwQeoLMB7qwLY4vjNqtsLpB+LndD5zWItXCdhZk73ghtTDEZFGX5kYIdWt7NEX40vWFf5xUg1C61qmUMiURaB+2s37+irNDLrmvv+MfMznPL2rh7Z7g2+pQbx568xVafGfOuwRlCQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDk5cDdUZXZIODkyOU0zcGU3MUtsZmpQTDZabHJ0QWo5c05ENlhzL2VBMmFV?=
 =?utf-8?B?UytFcS9GTVpKSEVIc2lUWnE0M2NmS2dISWVHdFpiUjE1SGdHbmZGVGtHbWNj?=
 =?utf-8?B?L0VHM01TOFBCZFRyTE51Z0t3N0dVTUdzdmdOcm8ra1JUM0hlM1hYS0pkZzRX?=
 =?utf-8?B?Wks5MTRZVUhScmVQVCtPMFNGalduKzVvMWdHeGJyOW1HVEx3Qmc3RlFNTHMr?=
 =?utf-8?B?dTlJYm1tR0RGN0ZXVzFDTzZhaUo0WWlKQ1lUQVUzQ3FUQ3RadEQzT1NTY3FL?=
 =?utf-8?B?QnVTRVNOZXZuMG9mcUNJRGowVGJzZVlicTY4cVlIUzFJcUtsT01PdjlUWEw3?=
 =?utf-8?B?L2ozQXFld3ZOT21mSnJ2SzRyWi9QZkFCVHhLMFNkeTc2aUo2L1NkSkpUeXZm?=
 =?utf-8?B?bVJpV2VKd3FqbFVIZUZxSHJRUEdaOHZKNzUrSzIrR2o3Z0NwYTZYcGRDM250?=
 =?utf-8?B?NTRZaU9vdFVET3ZtSXVZYmJRa2hiMWthUURGQ0dicU5wdHVvZWtwdE5Dbmk1?=
 =?utf-8?B?NWhZbUZxU0FBWDVIdjhVVG9PS3I1QUYrVHQ2RHlqcTFkMVErOFNVeFB2dEQv?=
 =?utf-8?B?TkdzdXRhZ0hNMlhSYkd4MjQwNjNMcUIrNzVwNEtwV0NhekVnTEtTNHpCRGdL?=
 =?utf-8?B?K3lKL2pNckQ1aExNaTFJRFB0bWRMS01ab2UzdElydERJdGlnbTZGK3pGcmo5?=
 =?utf-8?B?WnhEc3pRK2dFL1o1SmRpZVIrMlIwUXRocURCanZ6OUtGdS9MWUhoQjQxdTBS?=
 =?utf-8?B?QmUrRFVKbDB3NHJPZndFV2w0N1l3aWx6TTIyL1pFVUFiWkxDQnRsc1Z3SE9o?=
 =?utf-8?B?VDMvT1lwb2tWOHR3RzhMbVI3K3BqTTVmK05TMDFNdWpYS3N6N0haeC84TFNw?=
 =?utf-8?B?M0RYdWJxUThSckFSTW5RS3hwU3pTYWhCTEJFVGl5TStYclpXZ3d5dEdmRUE2?=
 =?utf-8?B?c2laS2lVSFp4OGtFZkpac0hpTDUvMjJEdS9nSGZVZCtndDNGOGpaTWRQaWtC?=
 =?utf-8?B?Z0JkWlJ2OVBRODRZNzhvYzVsbXExbHZMREdGVzV0c2F4OVVuUVVwWEQ3cFRE?=
 =?utf-8?B?RGFOM2pPT0lQUCt4eVFGaEMyNWVSWksrL0ZFNU8vQXlmanhSS3dIL2FRNHF0?=
 =?utf-8?B?ZVJBMEs1Y0lIdHhiUG9oT0V1MStUMTlQT2oyWFNsWDFsN0JoUDJWNWVrRkpn?=
 =?utf-8?B?bFgxVi9VUWxwMDRtU0dka0o3VUxyMjZUZzJUZjdkRTh0VFR3dHRib3hEY251?=
 =?utf-8?B?OFRUcTFUV0FlK3RsK01IRFBLQ0RrSCtnUEphT1RxTmV0VzhodzV2YVBDK2Ri?=
 =?utf-8?B?MTY4SjBuVFdoZzl2TnU4NDlRL1ZrblU4N2g4Q2hlZGt6MWsrMGp3YjZRek53?=
 =?utf-8?B?dEdjTjZBb2JlMVFXaW1IdTRPSjZEWEI5ZWtxeDMvL1JyL3dTUE96YVM5Zm94?=
 =?utf-8?B?MlZXSHgveHU1bUJFVTRlVDNnOHcrR2Zia3F0U0N0VnNzK015SGkyRDYwQUpN?=
 =?utf-8?B?bjB3cXBZMVl0Tk8yOHdaUVYvM3lJUzBkV0hBMTBEeHJoWG1IZjZNWmkzL0Yr?=
 =?utf-8?B?NWZSSDRyc0p4ZHZ0UnhuL1Z1a1BkUG1ZZnJpRWhkK2w0THVaNE50ck9tbFRV?=
 =?utf-8?B?bHZXWmttWTdQc2hIdXhwNXdiZ1YzSjV2bTNXSVVYR2UrT3VvUlRSVnBXMGxU?=
 =?utf-8?B?cmVXenFqT0pUNnBuVjRlc3k4YjhqREk1YXEzeVNKdmZyL3o2TTdobldiZG9F?=
 =?utf-8?B?d0JNYndmcDMvQ0p5VUZpbjl4RTJGUW9BTTZRZEl1TjRML3RKUVhNQUxoR3M3?=
 =?utf-8?B?Ym0rOVR2OTc2YWM0M1Z2b3VOc3R2dzBMMGh6Y2JoeUJ0OVdUN3cweVpGMjVJ?=
 =?utf-8?B?TjF3bTJ5RlJ1SkNmRHZiVGMvR3VuSVBGYjJyd0ZMVmZoVjNZT0plR3BPcy9V?=
 =?utf-8?B?VERyRXV4bWsxZGZNY2JCRG9yZkZVYk1EekdyZkZNUFJCMTlmNGFnbGRKUjZy?=
 =?utf-8?B?c2hvbUgyLzVaWW1rcjl3Q2tFUkJXVWFSdUtSSHY2eUtHV2ZVWHd4c0V4dHBn?=
 =?utf-8?B?TkRUamVydnR1d04zMlZiL0Vjc0dZcDZodmtYeHNXS3Q2S0Yyd0hXY1FDaDFy?=
 =?utf-8?B?am9QRkJUc2xjTTJuRTAwc3FmSUxBemU3YXh3ZklHSGZLRmsxVFNPYjU0Rkhy?=
 =?utf-8?B?K3R3UU44Z0FURkRvT2NaUytwQ0dOMTdzN2RGTUluMmMrWlNkUnVsRVFQVjVL?=
 =?utf-8?B?ckt6cHJ2am96Wm1ZaHBTdUQxeXFaYVBGbTJPblk5OUM2TFFiWWcybklyUVB5?=
 =?utf-8?B?dm1QRWlRUHIwcW12MnU2YkpWay9vbDMxZHJMdjVCa1dnaTZObElkZzgvUUYy?=
 =?utf-8?Q?cFaPCOm9dTTo8vGB5KS9l7Occr0NszfwUprtg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55DC340DB18B584DA390039679CE8CD6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	rPUfeM0mjW8TeuvsrjBEGhFD3LNZl+XBcPmvCjOdzvS1o0aM/9ivR51tCnIDzlE1MUcJcu2Zvndv/qz2KBQRKjjsE5UJA7m6QLRKiFNFUO9j8fbvQjnTuYvagRPYKfKEP0fPrmDndQZv+4tXSOb8xOqQXnRUZXKoxl5sZ00S/Prz/45Sq78kOQoOS32OtzoEwYmYvmMDXQwxR44NxQKNKKXTbIlKp/Iw58NdYy/RqzHQHOyuDD1B+3pC9vvjWxDjzP6cdKRYzc0kdHeQmdk9Ipm7ZPuHBvuwQNz5SZcx/0/jgheTRrju0ITRzQFK2dhXZEZgkBNsml338ljmISdZIw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ef133e-f1af-4366-694c-08de7e1098ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 19:18:07.8520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJKdllPPY7VQH1xs8lZnC/h8qy95Doc7NyP98xPYv/KJcRVCCDqoyc/hBbmSvCU4XzhYrOK0TZgRb1SlxHQi9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4220
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 2qZUG4SWevnkvkUFCu3seLrftw-0mKJj
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69af1cf2 cx=c_pps
 a=fOo0+MOGfjr111H4QC4BGg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=Ivc_cZAgBku5_E1NKtYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE2OSBTYWx0ZWRfX8Wpd+NdzNC2c
 QZ5kWS1fRrXQEvzS64Xihif45Fawlf2+u4Ik3BMPkI0NFX6fvokPn6fM6uvI/zwWVQv/p2jL34H
 6WGq/MigxaPMaqL5aapNbKjQn1euvKD//2hWpB96xioNx8B/x2zhZSzjZd03+TDcdTSknZPeM8x
 0qDa0B/YF1hTUa/J1oougOvLMNfUN3vyrRhnTqBPNb1z1VzjBqXjLdcjz/sFrzMpfBRZ04avx+q
 cqvkeHaCN8x381fuhF1j5XIhTXk0ZJtbM4w48erD0cMZYS/GDEAu2axaYKZT1ieZNwD1gEA/YXK
 E7wX1y79rxkRUNY0t9Uj4MZL6fkL9rAxKlWvC7ZHqmXjEveKCKbs3k/sDta07K3mzdfHgdhpDm2
 WakbnPorVkGqbdrfVHMAuUTFE3Iv6NOAIBbFAu6tpC01vD85xJFA4dEmgsbCh2ZnWrGIL84KUeG
 ltILg6wXmGwkVp6tKUw==
X-Proofpoint-ORIG-GUID: 7Q8fDH4ozpEWGqL-ngtjv3S5fMsE46yW
Subject: Re:  [PATCH] libceph: reject preamble if control segment is empty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090169

T24gU3VuLCAyMDI2LTAzLTA4IGF0IDIzOjExICswMTAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IFdoaWxlIGhlYWRfb253aXJlX2xlbigpIGhhcyBhIGJyYW5jaCB0byBoYW5kbGUgY3RybF9sZW4g
PT0gMCBjYXNlLA0KPiBwcmVwYXJlX3JlYWRfY29udHJvbCgpIGFsd2F5cyBzZXRzIHVwIGEga3Zl
YyBmb3IgdGhlIENSQyBtZWFuaW5nIHRoYXQNCj4gYSBub24tZW1wdHkgY29udHJvbCBzZWdtZW50
IGlzIGVmZmVjdGl2ZWx5IGFzc3VtZWQuICBBbGwgZnJhbWVzIHRoYXQNCj4gY2xpZW50cyBkZWFs
IHdpdGggbWVldCB0aGF0IGFzc3VtcHRpb24sIHNvIGxldCdzIG1ha2UgaXQgb2ZmaWNpYWwgYW5k
DQo+IHRyZWF0IHRoZSBwcmVhbWJsZSB3aXRoIGFuIGVtcHR5IGNvbnRyb2wgc2VnbWVudCBhcyBt
YWxmb3JtZWQuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2Zm
LWJ5OiBJbHlhIERyeW9tb3YgPGlkcnlvbW92QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBuZXQvY2Vw
aC9tZXNzZW5nZXJfdjIuYyB8IDE3ICsrKysrKysrLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25l
dC9jZXBoL21lc3Nlbmdlcl92Mi5jIGIvbmV0L2NlcGgvbWVzc2VuZ2VyX3YyLmMNCj4gaW5kZXgg
YzRkZGY3OTExZjdkLi41MGY2NTgyMGY2MjMgMTAwNjQ0DQo+IC0tLSBhL25ldC9jZXBoL21lc3Nl
bmdlcl92Mi5jDQo+ICsrKyBiL25ldC9jZXBoL21lc3Nlbmdlcl92Mi5jDQo+IEBAIC0zOTIsNyAr
MzkyLDcgQEAgc3RhdGljIGludCBoZWFkX29ud2lyZV9sZW4oaW50IGN0cmxfbGVuLCBib29sIHNl
Y3VyZSkNCj4gIAlpbnQgaGVhZF9sZW47DQo+ICAJaW50IHJlbV9sZW47DQo+ICANCj4gLQlCVUdf
T04oY3RybF9sZW4gPCAwIHx8IGN0cmxfbGVuID4gQ0VQSF9NU0dfTUFYX0NPTlRST0xfTEVOKTsN
Cj4gKwlCVUdfT04oY3RybF9sZW4gPCAxIHx8IGN0cmxfbGVuID4gQ0VQSF9NU0dfTUFYX0NPTlRS
T0xfTEVOKTsNCg0KRnJhbmtseSBzcGVha2luZywgSSBjYW5ub3QgZm9sbG93IGZyb20gdGhlIGNv
bW1pdCBtZXNzYWdlIHdoeSAwIGhhcyBiZWVuIGNoYW5nZWQNCm9uIDEuIFNvLCB3aHk/IDopIEl0
IHdpbGwgYmUgZ3JlYXQgdG8gaGF2ZSBtb3JlIGNsZWFyIGV4cGxhbmF0aW9uIG9mIHRoaXMNCmNo
YW5nZS4gQW5kIEkgYmVsaWV2ZSB0aGF0IG5hbWVkIGNvbnN0YW50IGlzIGFsd2F5cyBiZXR0ZXIg
dGhhbiBoYXJkY29kZWQgdmFsdWUNCmlmIHRoaXMgMSBoYXMgYSBzcGVjaWFsIG1lYW5pbmcuDQoN
Cj4gIA0KPiAgCWlmIChzZWN1cmUpIHsNCj4gIAkJaGVhZF9sZW4gPSBDRVBIX1BSRUFNQkxFX1NF
Q1VSRV9MRU47DQo+IEBAIC00MDEsOSArNDAxLDcgQEAgc3RhdGljIGludCBoZWFkX29ud2lyZV9s
ZW4oaW50IGN0cmxfbGVuLCBib29sIHNlY3VyZSkNCj4gIAkJCWhlYWRfbGVuICs9IHBhZGRlZF9s
ZW4ocmVtX2xlbikgKyBDRVBIX0dDTV9UQUdfTEVOOw0KPiAgCQl9DQo+ICAJfSBlbHNlIHsNCj4g
LQkJaGVhZF9sZW4gPSBDRVBIX1BSRUFNQkxFX1BMQUlOX0xFTjsNCj4gLQkJaWYgKGN0cmxfbGVu
KQ0KPiAtCQkJaGVhZF9sZW4gKz0gY3RybF9sZW4gKyBDRVBIX0NSQ19MRU47DQo+ICsJCWhlYWRf
bGVuID0gQ0VQSF9QUkVBTUJMRV9QTEFJTl9MRU4gKyBjdHJsX2xlbiArIENFUEhfQ1JDX0xFTjsN
Cj4gIAl9DQo+ICAJcmV0dXJuIGhlYWRfbGVuOw0KPiAgfQ0KPiBAQCAtNTI4LDExICs1MjYsMTYg
QEAgc3RhdGljIGludCBkZWNvZGVfcHJlYW1ibGUodm9pZCAqcCwgc3RydWN0IGNlcGhfZnJhbWVf
ZGVzYyAqZGVzYykNCj4gIAkJZGVzYy0+ZmRfYWxpZ25zW2ldID0gY2VwaF9kZWNvZGVfMTYoJnAp
Ow0KPiAgCX0NCj4gIA0KPiAtCWlmIChkZXNjLT5mZF9sZW5zWzBdIDwgMCB8fA0KPiArCS8qDQo+
ICsJICogVGhpcyB3b3VsZCBmaXJlIGZvciBGUkFNRV9UQUdfV0FJVCAoaXQgaGFzIG9uZSBlbXB0
eQ0KPiArCSAqIHNlZ21lbnQpLCBidXQgd2Ugc2hvdWxkIG5ldmVyIGdldCBpdCBhcyBjbGllbnQu
DQo+ICsJICovDQo+ICsJaWYgKGRlc2MtPmZkX2xlbnNbMF0gPCAxIHx8DQoNCkRpdHRvLiBXaHkg
ZG8gd2UgY29tcGFyZSB3aXRoIDEgbm93Pw0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiAgCSAgICBk
ZXNjLT5mZF9sZW5zWzBdID4gQ0VQSF9NU0dfTUFYX0NPTlRST0xfTEVOKSB7DQo+ICAJCXByX2Vy
cigiYmFkIGNvbnRyb2wgc2VnbWVudCBsZW5ndGggJWRcbiIsIGRlc2MtPmZkX2xlbnNbMF0pOw0K
PiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9DQo+ICsNCj4gIAlpZiAoZGVzYy0+ZmRfbGVuc1sx
XSA8IDAgfHwNCj4gIAkgICAgZGVzYy0+ZmRfbGVuc1sxXSA+IENFUEhfTVNHX01BWF9GUk9OVF9M
RU4pIHsNCj4gIAkJcHJfZXJyKCJiYWQgZnJvbnQgc2VnbWVudCBsZW5ndGggJWRcbiIsIGRlc2Mt
PmZkX2xlbnNbMV0pOw0KPiBAQCAtNTQ5LDEwICs1NTIsNiBAQCBzdGF0aWMgaW50IGRlY29kZV9w
cmVhbWJsZSh2b2lkICpwLCBzdHJ1Y3QgY2VwaF9mcmFtZV9kZXNjICpkZXNjKQ0KPiAgCQlyZXR1
cm4gLUVJTlZBTDsNCj4gIAl9DQo+ICANCj4gLQkvKg0KPiAtCSAqIFRoaXMgd291bGQgZmlyZSBm
b3IgRlJBTUVfVEFHX1dBSVQgKGl0IGhhcyBvbmUgZW1wdHkNCj4gLQkgKiBzZWdtZW50KSwgYnV0
IHdlIHNob3VsZCBuZXZlciBnZXQgaXQgYXMgY2xpZW50Lg0KPiAtCSAqLw0KPiAgCWlmICghZGVz
Yy0+ZmRfbGVuc1tkZXNjLT5mZF9zZWdfY250IC0gMV0pIHsNCj4gIAkJcHJfZXJyKCJsYXN0IHNl
Z21lbnQgZW1wdHksIHNlZ21lbnQgY291bnQgJWRcbiIsDQo+ICAJCSAgICAgICBkZXNjLT5mZF9z
ZWdfY250KTsNCg==
