Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8F933032C
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632663; cv=fail; b=alemoki4PTDBJrN0S1/dP7zDSRIfNV9Oni3olgcRfwyC/6pioJ/LTWxuAz0z5KvR/Awl8ZQbRzrsoisp5qTDClkCNtcI0AXSU0K8ptjN9hRjjHCk+U5JaP/yYbK2mVHgcJaIFjQKDg47EOPfh9Bb/n9xZVYjtFkezA4mA3J0sTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632663; c=relaxed/simple;
	bh=/x7kYJVSoxiO3dCH343Japi1Y3KsjKanmMvs4OSz/nI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=InLqDb0OHlpxto86Nrj3/5LyTHyz+NvDekMTerPuBySZ4UxXRZhrKBu+swck+ilQxcJBWBIjSgzZUUpBqf9YmLwJzz9mjYA90xPYKWMP7W43jqP0EyCv1vl/gU7ttxvomlhMlCukPJ8JW5No/IM/1nlMvpTLjRanme+YHdOjJ4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MAXqwdjw; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MAXqwdjw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60SJpnbr013292;
	Wed, 28 Jan 2026 20:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=/x7kYJVSoxiO3dCH343Japi1Y3KsjKanmMvs4OSz/nI=; b=MAXqwdjw
	fw3554VXsY28rFYrmPsiz4rViTN3p43tf+4Hz5QNLi5OuZs2hDvpwi2CDGW2RcrQ
	kYFoV+5ve65XY7DV46LS1+sMVxmcTpbuy/HZu4Pre750noXqnM76D/yzs2ayER8I
	GKMU8ZGlrfWLfK4MP6OtcFhuzoAxQyJHjTiyEtwAzX0Llg/jdZLJuNEJKZv92pIg
	sfjfhqB4sroEgvAWWYWbAChCbSOyk8svAp6raI8zT3aRuuipPDP5HrFJEsXgt+oK
	YtCs5BgVH1W9ikfjzrvZM0wFZG8DV+tQbbJGOsMyNJ9bZGpK4q3XFs0doSkyukFM
	/BGO1yE7inobVQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmuecb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 20:37:38 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60SKNcqR013924;
	Wed, 28 Jan 2026 20:37:38 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmuec7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 20:37:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trAMjKuVFOJgoPcwYNAF9gcrt4NfyR3iDcjTkSjuqI3UUoAz5QvsVXoBnuakz/j1/PA8qp4mjrWPjVwT1f7PfpX5O/86bzcqsXQ9VQtrd/AJ1VrcWG5Rkb1v9846SqYm7KWMGb3426SbUmxI5IQ/VC6pwJUsF92uLMotwBAJ7a42Ey/8f0dxeQIrfMn7sInczvSo1TbD1BunOt1zMPIuT6HqmZevsxcEo9ccoUOZR+BunB4A8dFmVQ4vP28LKjjhymV8BNJhuV19sEJL1LTZh5uqRRYqDegjncozfc0XlHerixZuzwE1GNeB1CDP9qxLVgWvtGkZ0ZyxN5wro8nLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x7kYJVSoxiO3dCH343Japi1Y3KsjKanmMvs4OSz/nI=;
 b=q9u8ZLPwJr8XyMBUMNGBaSLyn3Xri5gLg8A98EWa8F7IQBO8JthQuBiR6I54OjdJkuKqAbbOnVGQZnnrJ/5nrVxr9O/i3DU8RJ4PAjC7ti4qpjwhVAoMcT/nopddK/b3jtmKCV2hL0WXsTxSEk1p87CExw7sVxsojHM0QUDZN860b9/UKnNLCcW8eCw1OzukdUygGlTkzKMhtfhOtzHUGWjfHnuToZ2pniW2XEuDCwFFtN9cLvlgeO+jSPOzAJyFJsYnUb00mVgEZfKKXcYorC+VuBa5DJm1kHyUwOQGTpydVTXnb5DDi8p4DSOAKdyaUfbLNi3IJo1RfbhmLPyczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4526.namprd15.prod.outlook.com (2603:10b6:510:86::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 20:37:35 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 20:37:35 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: Alex Markuze <amarkuze@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>
Thread-Topic: [EXTERNAL] [PATCH 1/5] libceph: define and enforce
 CEPH_MAX_KEY_LEN
Thread-Index: AQHckEGZP/3iKPpst0muzMfbpVzRJrVoC1kA
Date: Wed, 28 Jan 2026 20:37:35 +0000
Message-ID: <a70727fde6f4030181481f82f5c0c292cfd266bb.camel@ibm.com>
References: <20260128103329.964466-1-idryomov@gmail.com>
	 <20260128103329.964466-2-idryomov@gmail.com>
In-Reply-To: <20260128103329.964466-2-idryomov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4526:EE_
x-ms-office365-filtering-correlation-id: a68ef2a0-89a8-4f60-794a-08de5ead11eb
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2hpZ25WcVBudGZWd2wwTHdBZ2U0ZzE5VXpTdHQvajNsam54Vi9tRjRYcEEy?=
 =?utf-8?B?UjQ4SVRsak5XN01EUlVscmZrcW94YUk4eUhXMzg2TXJOT1NtY0ErWEhtM1pI?=
 =?utf-8?B?MFcvRzAvT1Z6Y0pwMko3N1JHM3JhZjZwSVJNc3BZSlIzSTNabXl0bjRBNEVQ?=
 =?utf-8?B?SStCaTlRcnRLUkxhdmdOK2p0Y1R2T3R6eXcyQUo5K1YvYktoMVRrLzJKSkRK?=
 =?utf-8?B?cWxaaU1GdTdMQXdwUjVRL1JlelprQ0RYZWVrS1ZIbU1vNFdROVBEb2ZnQlRw?=
 =?utf-8?B?SmpXVUwzWkVpSERyaVFvN29qV0pST3dHNE5ON2lXNzZISmlXdk0xQmlHb1FO?=
 =?utf-8?B?cDlTTU4ySHhobTdNU084c3VqWUo2NnY2cmNjR05qaTBjUVRETXJXYzRJRDl4?=
 =?utf-8?B?ZEZWblBpTXRURDdaNVM0aUlqY1JEK2FYV1E4RXhPbmxIZkp6bFYzaHc0MUNX?=
 =?utf-8?B?MTE3R1A0WW8zMGlualdzbWh6SVM0TGVHTXBOdHBBWGxWRVdBL2dBRWwzMEdl?=
 =?utf-8?B?Z0VJVmJVUXY0OUxMVXM4cjBMTDl5Tm5GL3UvKzBQZ3BxVm9DUjI2MkJMb0dq?=
 =?utf-8?B?QlB0Y2Q3T3ZqWVJBUWNpdVFxQWIxTlZxQllvQisxdmd6Y0xBL2c3LzZyZ1Np?=
 =?utf-8?B?ZmRDSEwxSTgyRy9qak1kQ1c2cGhjS2FoaVR4WGJid2J2R3A0c0VXQUpHZ0lC?=
 =?utf-8?B?amR3dG5XbE9Oc2RmUzJtTUlhNWJRK2xOY3VkOHpLOG1LRlN6M1Uya3BJNDBm?=
 =?utf-8?B?SDBuTGY2Z3hoZC96UmZjcXpGQ1p5UFdFT00vNDkxYTJUQzRMUSt3N1FBbWVZ?=
 =?utf-8?B?YkhxYldDTkpLTnZLVElMdVRzcGd0SFVPbER1MVJzWVNSdU9ucGVkVXpSelVm?=
 =?utf-8?B?ZW5ob2M3T1BGRGJLWEJ1d0llOEdGSm1Ldk9IcjcvUHBuYW9HWGlFTTlCMTVK?=
 =?utf-8?B?bm9lRUo0TzBseVo5ODJmR3hGSHRKSzRoWm1welVXQVVINmhQeW5KalZXWWFJ?=
 =?utf-8?B?Snc2RUs0Nit3NU9XTG9HV1pnRVh0aElXQk5pYmtOaGJjMU91Z0p0ejZFaENV?=
 =?utf-8?B?K0lvbDQ0U2NSbjZUM094cnU4anVkTVVPZWFaR1NMNGJ1VzR2QXlaMTdrV0pw?=
 =?utf-8?B?ckJkelZMWGZxTFlZUm5MR0h0cGNDR1g5alcza1dTYVlvZ1oyRkNLZnpDZDhq?=
 =?utf-8?B?WEtINjFPai9WajNyRzBwVXJ2L2Myd045SU9RL21kWUZDS0p1QmwxOTRVTVhQ?=
 =?utf-8?B?V29jTEUvT044eGljdnZqME01MER1UktndmtSNmZJYkQ2MFJRREhmTkROd0Fw?=
 =?utf-8?B?bGRPam9XbXUvYnU5N3JEYXMxMEVjZXFYUFJmbTFZWXgzMEVLVlVJWWFpYVdx?=
 =?utf-8?B?WnlIZmhiWEYxSXlRMFM5aFIrU2xlT3prTEFXUTFOOW9Ia0Z5STlRTDlzK3RH?=
 =?utf-8?B?MC8rM1hjY0p5N214cDlIRGNZSHdTOTFyWEQ0b1FVTDNzUjRiTVoyaGVkQlJy?=
 =?utf-8?B?ZjZlczB4TjZBaTdDUGNtbGVhcXNxRVhQZjI4R1Z1WUFpakZDaW9xMnJ5ZHRk?=
 =?utf-8?B?SUVJMUZlOEJzbUdUTDdueThwcktLV3FmeFpXV0NEalVQeHI0ZkhZY0NBb3Ny?=
 =?utf-8?B?SnkvOUZJa1dXOTZhUm1CMGlNUkMwZDY1cXRyblpNdlJmdDJLbzU2YnFIeXJu?=
 =?utf-8?B?U0lyeHo1WmNseVNReS9xREpCSjNVb01STjRsa1orOTZvQ3hhSlg3T0p3TDRT?=
 =?utf-8?B?TmY5bVRaOG9wemIzYnVhY1paM0pIblFIOHhFdkxMNExNUDZLaVVGakpvem1J?=
 =?utf-8?B?WHBGUDZUaExuZXZiZ0dKSG0zNm9wOHlqbGYyeUE1RCtDZUNpZEdRMlBnSGZB?=
 =?utf-8?B?a0RKSHdRTmFpaXE2MG9jSXdVYXZwcktUbE0rZC9HYUU2clNhekFVajAyYWFl?=
 =?utf-8?B?SERPVlM1UTd5WndVRnBoazVMbjJPRkNGMCtMNDI2VHdOSVoyRzRmWWtRbnNz?=
 =?utf-8?B?d0gzaXJxeWFTMVR6TjFGVHNJeXBSZ0JGdTNtK09ESmxrQ2NTcmJjT1BFV3p0?=
 =?utf-8?B?QmhVWHBTU1pjdTJ0VGxLejVmTVZ4MzVhL3pmUnBrNG5ob1FMQzUrZ1psTnJH?=
 =?utf-8?B?YVpkbGVQMDUrcE9NTE1lU0s4R0NMTFBMdHdJL1VuQm5FcGZaZklXdmtIWVhQ?=
 =?utf-8?Q?/KVFrAfDcs3563AxdL3AOio=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aW9pYXNPY29CV2l3ejhmbENoZ0VEdXFrckY0d01rR25zTDN6WFJiY0FSNUor?=
 =?utf-8?B?TlhyakVWMVZ1Tk1GVXZ4eTUyUW01RDJmR205Sk9DMy9NUThkSnU1N3FYaUVl?=
 =?utf-8?B?VHhVNHI5Zi9uYTdFL2I5V2ErMmhDblFWRm5VanZGdkVaa2V5b1BWenRmSzI1?=
 =?utf-8?B?d09XbXd2NTM5N0F4VlhVb3NxK1pDNW41S1R3UlJHeVhvdjJnVUVPbDlrYSsz?=
 =?utf-8?B?end4R25xNCtxZEk0WXhNREJMSmR4Q3pkYWdVbk5ya2UzekVRQTk1S3J3UTRP?=
 =?utf-8?B?bGVSalpBeEdycFdPaWx0Ui8xakJ6SlNwcGJTWUFoZ2NESFFia1A1RllXcExT?=
 =?utf-8?B?NWNwMHN1eWZsTmtMTGFqcW1XV2tVUElFQVNHV3JXd01tWFhzZnJqSkQzYWNQ?=
 =?utf-8?B?SUFJTVNtVW82eUt3L2V2am42SnV6K0UzRGg0V21Fd2ZtUllSOWhVUmFwQzNZ?=
 =?utf-8?B?MUZsK1RNc1NFWDl5YzU4SjB4Y3d5MHpqUzg0VjBWRHlvRSs5c05UUDNZUUlm?=
 =?utf-8?B?d0hyUXFzQS9saFY4b2lldnR2U2FrMnNsZVp1ZExzSUdzQTRaeDNQUzV2a0VK?=
 =?utf-8?B?eUxMQ3lueEJsQWZJOWxHNEJiOGtHUVNHYW5rb1Z3QkNNUER3ZjJjTmdFWE1y?=
 =?utf-8?B?a0wzUFJ2dFJxbVVNdmNoTThQVnlCZUowdzRmS3hhOXpVeS9IZENsbDJZNU1s?=
 =?utf-8?B?TnBIY3R5dWVkZExSSm55Uk01dE1SK3FlSkFaK281dTN3d05LcGlZNUlLeThO?=
 =?utf-8?B?SjN4ekYwS0xrVlRLREF0REhMUGw5WWphVDhieUJZWVVMTjlYZ3FONWg3RGtJ?=
 =?utf-8?B?aDR6NjN2WkVNNzZZNUtwRnZLU1JJbXFPQS9OU1FnbjJOeitFVDhjcWF2SlIv?=
 =?utf-8?B?Z2RlWkhDVTZxMDBBblduTTFrRFZrMDNxdW5ybXZzS1FtRnpURnRFbXdYZ3ZN?=
 =?utf-8?B?R2JmRzhVQXBpVzJTaCtEMkRBaFk4NXBSTEtyeGNjNzM3bnRqTFQrbldiOHl4?=
 =?utf-8?B?OHJLUjNPb2FWRUFpem5KdTlDVHlOVjZYL04rM0Nxb3BhaHZsTkZaTnNPY2JF?=
 =?utf-8?B?Y2RzSkx2elQ5RGhaSXRRNERaMjMyUlZuUjNEbFovVWtwZmh3VE5pdVhLaXdB?=
 =?utf-8?B?N2szblJnQ1lsKys3VGpZdytKR0ZIRFMwSXNCNEdSRkd4OFBtNmY1VkV4YTg0?=
 =?utf-8?B?S0xqaGkxK1hzay9ZSGsycSt5VHNsOFRZRGRNWWpZRGVvbElNRW9rRHAwZTE1?=
 =?utf-8?B?N2pVUjhLMDlVcCt5UUFzbGNDaWJQbzZFd1NvQnhtSlluZWIrVnByNTUxR0s5?=
 =?utf-8?B?TzVQQjFvNkNWY3ErdFhydEhud2IxZGxJeExSb3BFdHd2S1Fza0hDdG9SZnlq?=
 =?utf-8?B?ZXZGRXFtcWwwZzZjZjRPUit1RVBTczFrQVBUdDdlTWF3QU95NFpVV25TS3or?=
 =?utf-8?B?TnpkNDFpS25Vc2xnSTJ5ZWUzMEd5TFBFNTRuVkVjbHFMRFJ1amhHUHVkWmMy?=
 =?utf-8?B?aVVQclpDdFlrOVRnNExrN2E3NTRQemkwT1NlOHRub25Uc0Z3OEdOSXNpQ1BZ?=
 =?utf-8?B?Z29mREgxU1pWN0JlWVQxcEFmZ1hMMXJ5THJYMkYvYkFDWHR3enNUUnFscm9h?=
 =?utf-8?B?ZTBhR0FxYVd0V1VMeG1RZlRkSnJkNHRITUJpajRnSGt5cTcwWVFTeStpZkFO?=
 =?utf-8?B?OUdEMXU4S3RmTnIzZGFDZDh1SWdJeldQZkxUQTVwcDFyZ09YSDEwZlZZOVV1?=
 =?utf-8?B?T3E0STczMlgyRE1wNVIvV1RISS9ETzVPc1k3ZERUSVhNdS91US8xblRFN3hi?=
 =?utf-8?B?WjVYWm9TZEJEcnJmOWluajhnSkJ5bnRhR1hVYlA3cGhtY29VTUZydzJQRWts?=
 =?utf-8?B?K0ppZW8rblNFOEd4d2pLaG5maHJNTUg2c0k2MC9ZL0N6UHgzazRTOXJKc0xw?=
 =?utf-8?B?b1lGRHhrYWIxak5oVWxMalkzUnU3SGZDczVFZDZ2MkhVTlBHcWRVcnNLOVpi?=
 =?utf-8?B?RUpaZEYxa0grK29peFJkUXV3TkFDbEUrYnpSTDJ6d25tQVh1TXUvcmlWZHk1?=
 =?utf-8?B?a3hYK2tkVlNFSlJPcHJBWU1BTXpZdWJ0bGZDcGpqaWQxYms1Y2lpWC9yRmRB?=
 =?utf-8?B?K3lyV05QQXVxSnFwTHluMHNVUzN1eGUvSnc0NlRnWmx6YnVZYiszTFg3dzN5?=
 =?utf-8?B?OWthYXFyV1RDcXFrVlhlRWVEbjlxNThxQTZ1aFN4aHp5VkMydzFTa29YVGZ2?=
 =?utf-8?B?ZFRnK1NqeE50VUxvNHJCYXVxNzhNQjdrR3NmM2dkRWxPUW51akYyK0JnUHNB?=
 =?utf-8?B?WllGWWpWZFpldksrdE5ZMExEREl3RVoreS8zU0JyMnkrMXZiZ21WVkh5ZnVq?=
 =?utf-8?Q?UPT68nhzLBgbP1vaxRLiE/OWqB32FL7uVQdoK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B37286A5444B58479C1C76DFDEC35600@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a68ef2a0-89a8-4f60-794a-08de5ead11eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 20:37:35.6154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQ3Tl8TjZM4Hp73FgbyKncPM4ksC4Rqq1IQGC1brHKq4mVwaYK/3CRcv14WWmsVLKXDsY6RyJ+9qNWBnoztclA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4526
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=697a7392 cx=c_pps
 a=x8GZ0b2gSoXatiKXRdBC2A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8
 a=6g0SroFu_lU-SunSz6QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VNHnxkd5tpNjFwSr5Yp4S-XCL9rP7zBP
X-Proofpoint-ORIG-GUID: v-l7sahjyb1iTG3rU0QX1oeJR9y2LqGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE2NyBTYWx0ZWRfX2v0pnqXG3FHm
 Kv/jFM7hPrz442YW0xfB5s0fGH44pKQ3iu3WOUOaec50nvnMk2MMzv1zZFaqj63pxmMyeZ6jbzJ
 LieDaI6kpGtd5hbK4N1KIgrMJu0gC+W/Q4aCNBX1Jy2usX0w+IrrMcZblBS5dTO3gbP0pMpDPyD
 7hgWXIaX3BsY7QglQPnuC4JV8h2mCMEwrmsFl7aiSBz336sRYTw4OAcec1p4M4oYRGsvKHV5/h9
 gPDk9E4FODok5omE4Sb1wFjTXY0zssCvvi44Ok7Md1H9v0/O5IGmiARC0fJzycZU5jdN/ssf8D6
 jDqo26Ht/aVPh63dBz3gs9IgmG6Ep4XRM4j3WYIuVh7MlyyI1/CSafX0PGekBRwo4rYvIC019Al
 YeihOoJg4jFLnGbQOwvt1NZXjcqMgfG/YHHBX/IDhThJhuN18iMzLUzSlCi1OlHiLd6nHiWGABi
 exofE/oU5eMGARsc2ow==
Subject: Re:  [PATCH 1/5] libceph: define and enforce CEPH_MAX_KEY_LEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601280167

T24gV2VkLCAyMDI2LTAxLTI4IGF0IDExOjMzICswMTAwLCBJbHlhIERyeW9tb3Ygd3JvdGU6DQo+
IFdoZW4gZGVjb2RpbmcgdGhlIGtleSwgdmVyaWZ5IHRoYXQgdGhlIGtleSBtYXRlcmlhbCB3b3Vs
ZCBmaXQgaW50bw0KPiBhIGZpeGVkLXNpemUgYnVmZmVyIGluIHByb2Nlc3NfYXV0aF9kb25lKCkg
YW5kIGdlbmVyYWxseSBoYXMgYSBzYW5lDQo+IGxlbmd0aC4NCj4gDQo+IFRoZSBuZXcgQ0VQSF9N
QVhfS0VZX0xFTiBjaGVjayByZXBsYWNlcyB0aGUgZXhpc3RpbmcgY2hlY2sgZm9yIGEga2V5DQo+
IHdpdGggbm8ga2V5IG1hdGVyaWFsIHdoaWNoIGlzIGEpIG5vdCB1bml2ZXJzYWwgc2luY2UgQ0VQ
SF9DUllQVE9fTk9ORQ0KPiBoYXMgdG8gYmUgZXhjbHVkZWQgYW5kIGIpIGRvZXNuJ3QgcHJvdmlk
ZSBtdWNoIHZhbHVlIHNpbmNlIGEgc21hbGxlcg0KPiB0aGFuIG5lZWRlZCBrZXkgaXMganVzdCBh
cyBpbnZhbGlkIGFzIG5vIGtleSAtLSB0aGlzIGhhcyB0byBiZSBoYW5kbGVkDQo+IGVsc2V3aGVy
ZSBhbnl3YXkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBJbHlhIERyeW9tb3YgPGlkcnlvbW92QGdt
YWlsLmNvbT4NCj4gLS0tDQo+ICBuZXQvY2VwaC9jcnlwdG8uYyAgICAgICB8IDggKysrKystLS0N
Cj4gIG5ldC9jZXBoL2NyeXB0by5oICAgICAgIHwgMiArLQ0KPiAgbmV0L2NlcGgvbWVzc2VuZ2Vy
X3YyLmMgfCAyICstDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9jcnlwdG8uYyBiL25ldC9jZXBo
L2NyeXB0by5jDQo+IGluZGV4IDAxYjJjZTFlOGZjMC4uNTYwMTczMmNmNGZhIDEwMDY0NA0KPiAt
LS0gYS9uZXQvY2VwaC9jcnlwdG8uYw0KPiArKysgYi9uZXQvY2VwaC9jcnlwdG8uYw0KPiBAQCAt
MzcsOSArMzcsNiBAQCBzdGF0aWMgaW50IHNldF9zZWNyZXQoc3RydWN0IGNlcGhfY3J5cHRvX2tl
eSAqa2V5LCB2b2lkICpidWYpDQo+ICAJCXJldHVybiAtRU5PVFNVUFA7DQo+ICAJfQ0KPiAgDQo+
IC0JaWYgKCFrZXktPmxlbikNCj4gLQkJcmV0dXJuIC1FSU5WQUw7DQoNCkFyZSB5b3Ugc3VyZSB0
aGF0IHRoaXMgY2hlY2sgaXMgbm90IG5lY2Vzc2FyeT8gV2hhdCBpcyB0aGUgbW90aXZhdGlvbiB0
aGF0IHdlDQpjYW4gcmVtb3ZlIHRoaXMgY2hlY2s/DQoNCkNvdWxkIGJlIGtleS0+bGVuIGJpZ2dl
ciB0aGFuIENFUEhfTUFYX0tFWV9MRU4/DQoNCj4gLQ0KPiAgCWtleS0+a2V5ID0ga21lbWR1cChi
dWYsIGtleS0+bGVuLCBHRlBfTk9JTyk7DQo+ICAJaWYgKCFrZXktPmtleSkgew0KPiAgCQlyZXQg
PSAtRU5PTUVNOw0KPiBAQCAtODMsNiArODAsMTEgQEAgaW50IGNlcGhfY3J5cHRvX2tleV9kZWNv
ZGUoc3RydWN0IGNlcGhfY3J5cHRvX2tleSAqa2V5LCB2b2lkICoqcCwgdm9pZCAqZW5kKQ0KPiAg
CWNlcGhfZGVjb2RlX2NvcHkocCwgJmtleS0+Y3JlYXRlZCwgc2l6ZW9mKGtleS0+Y3JlYXRlZCkp
Ow0KPiAgCWtleS0+bGVuID0gY2VwaF9kZWNvZGVfMTYocCk7DQo+ICAJY2VwaF9kZWNvZGVfbmVl
ZChwLCBlbmQsIGtleS0+bGVuLCBiYWQpOw0KPiArCWlmIChrZXktPmxlbiA+IENFUEhfTUFYX0tF
WV9MRU4pIHsNCj4gKwkJcHJfZXJyKCJzZWNyZXQgdG9vIGJpZyAlZFxuIiwga2V5LT5sZW4pOw0K
PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gIAlyZXQgPSBzZXRfc2VjcmV0KGtl
eSwgKnApOw0KPiAgCW1lbXplcm9fZXhwbGljaXQoKnAsIGtleS0+bGVuKTsNCj4gIAkqcCArPSBr
ZXktPmxlbjsNCj4gZGlmZiAtLWdpdCBhL25ldC9jZXBoL2NyeXB0by5oIGIvbmV0L2NlcGgvY3J5
cHRvLmgNCj4gaW5kZXggMjNkZTI5ZmM2MTNjLi5hMjBiYWQ2ZDFlOTYgMTAwNjQ0DQo+IC0tLSBh
L25ldC9jZXBoL2NyeXB0by5oDQo+ICsrKyBiL25ldC9jZXBoL2NyeXB0by5oDQo+IEBAIC01LDcg
KzUsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2NlcGgvdHlwZXMuaD4NCj4gICNpbmNsdWRlIDxs
aW51eC9jZXBoL2J1ZmZlci5oPg0KPiAgDQo+IC0jZGVmaW5lIENFUEhfS0VZX0xFTgkJCTE2DQo+
ICsjZGVmaW5lIENFUEhfTUFYX0tFWV9MRU4JCTE2DQoNCkZyYW5rbHkgc3BlYWtpbmcsIEkgZG9u
J3QgcXVpdGUgZm9sbG93IHdoYXQgd2FzIHRoZSBwb2ludCB0byBjaGFuZ2UgdGhlIGNvbnN0YW50
DQpuYW1lPw0KDQpUaGFua3MsDQpTbGF2YS4gDQoNCj4gICNkZWZpbmUgQ0VQSF9NQVhfQ09OX1NF
Q1JFVF9MRU4JCTY0DQo+ICANCj4gIC8qDQo+IGRpZmYgLS1naXQgYS9uZXQvY2VwaC9tZXNzZW5n
ZXJfdjIuYyBiL25ldC9jZXBoL21lc3Nlbmdlcl92Mi5jDQo+IGluZGV4IGM5ZDUwYzBkY2QzMy4u
MzFlMDQyZGMxYjNmIDEwMDY0NA0KPiAtLS0gYS9uZXQvY2VwaC9tZXNzZW5nZXJfdjIuYw0KPiAr
KysgYi9uZXQvY2VwaC9tZXNzZW5nZXJfdjIuYw0KPiBAQCAtMjM2MCw3ICsyMzYwLDcgQEAgc3Rh
dGljIGludCBwcm9jZXNzX2F1dGhfcmVwbHlfbW9yZShzdHJ1Y3QgY2VwaF9jb25uZWN0aW9uICpj
b24sDQo+ICAgKi8NCj4gIHN0YXRpYyBpbnQgcHJvY2Vzc19hdXRoX2RvbmUoc3RydWN0IGNlcGhf
Y29ubmVjdGlvbiAqY29uLCB2b2lkICpwLCB2b2lkICplbmQpDQo+ICB7DQo+IC0JdTggc2Vzc2lv
bl9rZXlfYnVmW0NFUEhfS0VZX0xFTiArIDE2XTsNCj4gKwl1OCBzZXNzaW9uX2tleV9idWZbQ0VQ
SF9NQVhfS0VZX0xFTiArIDE2XTsNCj4gIAl1OCBjb25fc2VjcmV0X2J1ZltDRVBIX01BWF9DT05f
U0VDUkVUX0xFTiArIDE2XTsNCj4gIAl1OCAqc2Vzc2lvbl9rZXkgPSBQVFJfQUxJR04oJnNlc3Np
b25fa2V5X2J1ZlswXSwgMTYpOw0KPiAgCXU4ICpjb25fc2VjcmV0ID0gUFRSX0FMSUdOKCZjb25f
c2VjcmV0X2J1ZlswXSwgMTYpOw0K
