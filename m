Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6003876AA;
	Thu, 12 Mar 2026 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348381; cv=fail; b=bzgo55MYQRMaawlStI9VCoCcfBsNNLCgg5xwmykkg8RyALwDKrdYvAQJJV6hTQ415hIKG3y2DSz8vfVf03m+bvx7FHdE1wAHfm9hnV+D9xOqcKH8G3RfFmVTnovuUuecE2gn/Qm4E5WigeQcxNdi39vWAFZ4pY8UwuFVdu9Z55s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348381; c=relaxed/simple;
	bh=a6+EF6bh4CySUmHEl3iHO/DGxWWKU4lSWu7ZwYejzQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ooXcXjq4GpT1blsr7JSs+OAuPw8gxNw8d2YwAfExa6yRPw5GWDiqby6+4+F1j6mUxxmpuiIsH96tE5kWFN21rmBLWKHpERvZcGQWZL8X0WM/hEtBgVbEtJ47MiOzdmfUjpsondvdXrivPypF1o7886a/BaRrBJtXZ9VIfR0JJeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=dHUO6ioh; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="dHUO6ioh"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CJk2UI1064282;
	Thu, 12 Mar 2026 20:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=a6+EF6bh4CySUmHEl3iHO/DGxWWKU4lSWu7ZwYejzQQ=; b=
	dHUO6iohpfdULXBgIkW8xcUrjuBTC9A2lb47D4cNDfqBoLvS4SLK/0cLWb3ayOzX
	UgvVkuYXPk6UcOcfS2KwUnjE8nlCqy706cdcMZUWiPtmq+/CG4phrt5TeLcx6V2Y
	eViiZKMkFljTzZ8bWG78jUip8sGl/h3sedVcKfjS3vfWK2QkY30WqjzYyO+J3R03
	PU7VOPxUUtY2FZwieTESAwdcu3yRJLHAazKHQNDz9u55p6CGsaqGMrqkK78UK+lR
	oVYtA6cuLY02MC4tfrPR9etc451vLUX+/FLL+pj+P5FQCg6evcBLX6ncVhOBxGRf
	mPsjZCtLfABfwd+1MyI+dA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cutxqrs5v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 20:46:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6IATgnszbq4s22O82dk1w1gKUjyepaEx3paLUe/GNL2Eif9QuAaeCWRVY0fhKymiBHlACctLV6t/yJhLcd3EwziOtzFIbqr4ftcJSrE5PQVd1/4yGwojH3F11bDpkr40u/gaYXSxGb5+1bYFZmLvaHJ3OTnZiZOe6FGM5hqKsQPyieb/UQ4E8LhtpLzap6GVaWzhiZCjSMzffEigSY80msiSOtf+wXRNdu8ARXH93EQhv8CbqgBmcrtUaZp2uRpecIGMdCURua3smcXHGoq1t/0JaV+ni/u6zRBLyWPaPnO2ZgaFxjqsNuoL+VEv7R9kFcykU3B6p0t953mlznYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6+EF6bh4CySUmHEl3iHO/DGxWWKU4lSWu7ZwYejzQQ=;
 b=dKu592sIdTOAfsmp9j3xGpnEAIlSxjA5Y16D4SWHhxyRh5VmP4OlgriSMY/sxNaLJMh1xHJvClv/FTNHJZqu9zmSoXP3zdJ+03bNLFU8aiTaWPNCJw+ty63fR4/OU3WVC9ouFFoMJ4sG/zSm/RPWCLq7hXc1uRW5Gm+wyq8+EPiSZHJEJCoeRidxkWnbTel7eNv4iWUdZZCH7eRXvpeMnVOCKBxCMcqFh5ZN3X0EHLPFgj1bf1juxhxI/4oyQxQpvLirzi59T7vaVqBzOFgC9B09ua3+DeOKk+V60uffnS+TkH3ibU5e7hGqU3Xy7L6za2sltByZGzx/CeuElRkwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CH3PR11MB7867.namprd11.prod.outlook.com (2603:10b6:610:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Thu, 12 Mar
 2026 20:46:11 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 20:46:11 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: slava.dubeyko@ibm.com
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com,
        ionut.nechita@windriver.com, ionut_n2001@yahoo.com,
        linux-kernel@vger.kernel.org, xiubli@redhat.com
Subject: Re: [PATCH v1 08/13] ceph: make ceph_start_io_write() killable
Date: Thu, 12 Mar 2026 22:45:59 +0200
Message-ID: <20260312204559.8516-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <a86dcbd27a3f2a17d16046ecc9c19d91ab093549.camel@ibm.com>
References: <a86dcbd27a3f2a17d16046ecc9c19d91ab093549.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::15) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CH3PR11MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b22e2ce-87b3-462d-b30e-08de80786487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|52116014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kwzpaZUvK9eUhratcT1t5P8JDgs5Jb5vuFqwOG9Kti87s1nG7nZS5/7U6I/xZr4rDO7yzSt2kLZ8RzcgQKiAQkbQoiIIaKQGa3BP2YshMTA6uLwF+K3LlJwGQgGuMV3sYntjMWYnFN5vgLDvzpNbBgFwkWGEbOAUUuoNfK1zmp64oYl4kdm4Zf8gzMhMOaPu5OU2JEeaB27OXeCzxXMRFLXdJ/0FTy34X4D0G8dxTCBcPJJkboGfjqa8NAqrx87xHZHDlZv7J3gZerbF5qVBbRaZl5xlHzKaXTTrUO2zglymvDCTyAwkup0AX7azeauFvgchGYuYbtOxFf1vk3WvR7uAD1Gfymo4/C5EmuRYkhqHZgRZAqohgN0IGnxurhpY0A00mqUFU6KG0Y6Qz5GnorwWhxo6eFiU26xRAPeywGPsFCouKFjIBsg8PS+XP0XHiO7yIDnBKi456VJtfKYwaOeQVTSr85KCwkqScbOKSkdVeMo7BCfWNYzyGOrsZgj2xmjARGYzJA5kg9JlKgNCjdV6FpGcRphMOUgH15Wz20Lz+cbJGknKpm7UMPJevce9watZUxJMZVwK6ceqX2qkICtvsk536DiD9Xz3yeqQgAroCFKVqQOqBKPrScS0BPwv0YmlOxTNM/lYJ7A7SPshL1Ep363ibp2LbzMRWVe7w5xYe1bEkUDacmAfJ6kpDTtSzvEiMLhx5msXjS0LizbwAo/Z3E5RGJWB0WWUaYxof0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(52116014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG5ld25wakd6SkVJUzJYYTlsQUxIY1RhR0VYNjA4RUlTajIvamtpTklvcmlZ?=
 =?utf-8?B?U3BTRHNTekFnQjVmczFYenNxL0hEb2NGWkJUVEhCRnBDeC9jeGVhWGNzQXZN?=
 =?utf-8?B?d0hqWEw2SGdDTnp5dHEvMW8zWVFRb044NG42YWdCMEdib0VvMmhvQkZuMWJH?=
 =?utf-8?B?Vzh2bWNIRWErYVlKY2ViamhmY0MzWnpDRWFWbXN6NURtYW82OFVJTFNuS2l0?=
 =?utf-8?B?TVFzelVPUE92ZlhlTDVxWXBjbWhBR1dCQllVd0ZMV1BwRW8vRjNrdmJuc2pu?=
 =?utf-8?B?SjloZmlvcnFnV3llYkFVQnkwQ01tdENHOVFsQUhwb1A3ck9UckJRMDU1WmQy?=
 =?utf-8?B?ZmUwQlZEeFZ6ckZ4RS9odG1RR2tJUnVkRGpMQnI5S3A2SmVveHdWTmE2Qkl2?=
 =?utf-8?B?RGRmRXlyVXZXYTl6QkFxeGExT0ppVEd4YStOWEtXbHI4eXdTN29DSC9BWkY1?=
 =?utf-8?B?eGdkYldNckcrZVFXTVl1ZHp6eTBnREZoTVoyelF3V1pDd00zcjlwcVk1YmFk?=
 =?utf-8?B?TDJ2R1F1TDQ2OXNQNFRSODdmbk52VnRjc1JmY25CWDhuYUdkNE9EY3E1T0Nq?=
 =?utf-8?B?dTV2Y1I1WUFVb0pFQlM0MU9BWks5a0Z5VlA0WnFUWXIwTEpuRWg3UWl5UDV2?=
 =?utf-8?B?cmNBaEY2cHE1K1gvalAzSjN4NFNnemgzamJDL3krTUFFMmVYZnBZNUFNcUpT?=
 =?utf-8?B?K1VlK1poNkM5Z3VnSUpFTWEwNjVieGx0dlVwdEV6dW9DWFpjT0pPakZCU1pV?=
 =?utf-8?B?RkFVUVN4dG9JaVJCUmlCSTJvL01HczFaVjZPeWNUUURGM1BCZ1oxSjVOT1dj?=
 =?utf-8?B?SU1mUDF5Rkt0T21ybGJNM3BzSDE4WXQzczd1TEordlNnalVBRnJWeXdmYlVN?=
 =?utf-8?B?amxabjJnTGEyd1RlMThYdTZ1VVNPSlA1Nld0SHBWdThuZkhYem5VVkN6ZWJk?=
 =?utf-8?B?a2FZM3hUQzBTRHpXMjUybFJzQU9FNFhFS3p5V2Y4WDJjK3NvZ3ZJT0R2T2lE?=
 =?utf-8?B?QWFMMVp6bStxVXp3TzRFTytNYkZPWVh4VFNDOXFqemhrdzF1SnJOMEIwSjlV?=
 =?utf-8?B?RkNweUZiUlhSN3hGQjZFT1hMajljNU1jMTZQS1R5S2QrQU9XMUdjc3hjaU1w?=
 =?utf-8?B?VCtwa0djREo5NEhLcEJTaDNnTjNJZE8wYllTTy9jejc4QU5VTTRSWWcxSDRx?=
 =?utf-8?B?QytlWVlnSUoremFvRDBUc2ZJamJINE5adjIrUjd1YUFXTFJtU2VRd3hCb3V4?=
 =?utf-8?B?ZFVsYVI0bDRjVzl5ZXdBWXpYVC96RmJTa2NaMTBxMDNXc2FXZXkwK1N2cVds?=
 =?utf-8?B?ek9aR1pGamVXSXh1VlZnWi9udDFMYkovVmtvZVQ5ME9GbVFkUTJGRFVjZnlV?=
 =?utf-8?B?NXBoWHowQ3pxVVFKSmYwWE90bmtYZWdYOG9xTE1iTGM0UlE5UGVOcVU5Njg1?=
 =?utf-8?B?T2lPb3BEd3hiUXZBOEI4Tzhac0pPTUVWbmhRZjlhWUJLK2M5dnY4a3Z5OUpy?=
 =?utf-8?B?N0g1c05uTVovM1pXYzdIREk5cTRiOG1JeGwycTRhYTNLVzcvZ09ZdjBsQ1RH?=
 =?utf-8?B?dkhYTjlMV3dhL0NoZVdMUlE3VVZqRkNRbXN4d0dGZzBVTEhpUGFid0Z5MjE2?=
 =?utf-8?B?Ty9GNU5jWXRLcjdES24waENCTnJsUlExdDNaYUNQWGZxTldOV2JzNE5EWjNS?=
 =?utf-8?B?YUQ3MDZQK3duTzhnNzF4VlZRbHUvSFFDSkhCRkdyeGxDUnNvZEQwQ2FvMDg0?=
 =?utf-8?B?bEtSeE1IajhUZnZpTjFCejZEejF2SHI3bHZnMFFORlJiVDFWQ2dmbjhYRit0?=
 =?utf-8?B?dkI2R3k3WW1TWldyalJMOWtTOEZzYmYvQ3VmVUk5MmpGRWxJQWtDNG1aNFBM?=
 =?utf-8?B?Q2VwWllpbU1XZ1JWMWVZRzJnWFpaRFh4b0s5TmJIQUFva0dLMit3NWw2Q3ZV?=
 =?utf-8?B?azUwRXVuZk1WRUVRcEVuWFd6enJPR1ZCd095dHh0cFBLYWtpRUYxdGVCRUk0?=
 =?utf-8?B?aGp1NFBVakZNcEdCOGhia21kYk5yVUt2eXRpUnk0b1laMkN4Q2d2R2QyT1hC?=
 =?utf-8?B?WmgyN0piWWJLMTJYeW1WSURJY2YvU3JseVBVdndwc2J1U0VVQjFYK3RCR1dl?=
 =?utf-8?B?OGZiL3F0SWpvazVHdkZKd3l1VkJYSGg4ZVdBNWtwSW50Z3k5MjlhSkZpMkxz?=
 =?utf-8?B?c3R4QjFwZFY4UC9MZmxheHBVQjhEUlNOQ1pDT3lvRGNwTGwxOGRGbDFNaWNk?=
 =?utf-8?B?ZUJkWjRjWWJpempyYzcxQldXWmZJZDRkaFo3Z0cyN0FvQ1l0YlhHSWwwWklh?=
 =?utf-8?B?bi8xMllFME1Jb09wYTlwQ0t5T2lFTTFHN0hyZGJKWExKbmF3d3lzcXRYOGFR?=
 =?utf-8?Q?mO3nCB3ZtFD6cneJonG79s4jXg0fZuIy0HqNlh0IZ7WE8?=
X-MS-Exchange-AntiSpam-MessageData-1: okiIld+FiNjf2TEH2O83oBqvAB9A5CkW17E=
X-Exchange-RoutingPolicyChecked:
	kwh6P+MBCx6Z1C1P4XTe1pb1Ygu4b1cMEX3++Z7rYrW3VypPziKFzDFqLwoVHPvDupGJtdrkpNKgyl4ZhXgjnksei1W20EZm4CNDhbbeS7DvJIhkbH5SZkO2cA+m+giUJOF8aZBrhiBo/d2vmwQh5JpUCAK9rxUWHefj6z9AFeP9uAeOjH7+RzLva/3Bwynq7S6TfrqWdaFLjtcgWCamWx7q6Mioo2+JxS8lAWd0CUrNNX3cbZ5VSpW1LnVVDotymCvcQZcwVsWcTQi2HBR8bFNMh9HNSu2HaABJiCmdC8Wwt2H9RHuwfpo81Smr31yrfpKQjhRfi8s3JDNwpR/k/w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b22e2ce-87b3-462d-b30e-08de80786487
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:46:10.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vN+0TLbQ0oROU+jwgWv/Xoi39cqXO2aRRN5f9zcHviltNz6pN//e6R0u0mGcP9cIbROA2qC9YK5dqtO0MnCjyiBuI0Grqm3lruKMiDfilTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7867
X-Proofpoint-ORIG-GUID: Yt2lOXyn_YxMwPpST6XmTIRkVnaD87l3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE2NyBTYWx0ZWRfX/OpOd3YmHjJY
 11ZLySSRFP2PqFYFEIS2td/HjgewfZNR+Vl7EVXaPJugOUfIjoQwTAkjKpa8EPGksKDmEnRvKpN
 i0RKcWsFxVIu6oJAFKball2/GoxoiCOdZ29DeHWKZjWGy0rii/zWnhmBlw+HTAb6763rgQAp79d
 XvdmeRgOn7aXL9pjRV8PaXC6puBVBvAysAhZO7RNaTHiZ+9yJoTcxiG/zjS2cbw71t0hUs3Y1SQ
 ++2tDt0wd10xXGdBBJN5CPhfbgVipGKbbpqwY4zXn4tQ9dldZSMbU/mJ5rTgNiy67fKQS9eF3MT
 GtOZKWw9AbvKxruE+StMuprn8dHN+OyoxLXV1gVcDuqFt6pH9n7Csa5Mp0tNBZuEuBe0issvtBV
 v6EQQZ+JcXNV6JemlvpyMz67uZXvfm35+YW8Yn+0FL/7sTeJn0GqDz+86oE1yVaZZdlyNlhMKpE
 gKINh3i5qU6TNNJurOA==
X-Proofpoint-GUID: Yt2lOXyn_YxMwPpST6XmTIRkVnaD87l3
X-Authority-Analysis: v=2.4 cv=feegCkQF c=1 sm=1 tr=0 ts=69b32616 cx=c_pps
 a=h6NrD5D8j3GnK3ckJnoRDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=t7CeM3EgAAAA:8 a=8yG_7asPzamaG5Ovj-sA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120167

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Slava,

Thanks for pointing this out.

My patch series is based on v6.12.57 (stable/LTS), where
ceph_start_io_write() still uses the non-killable down_write().

I see that upstream v7.0-rc3 already has this change. I will take
this into account and adapt the series for 6.18 LTS and 7.0+ as
well, dropping patches that are already upstream.

Thanks,
Ionut
