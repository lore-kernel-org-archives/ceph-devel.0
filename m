Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AB2D97B5;
	Fri, 13 Feb 2026 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770969127; cv=fail; b=tMjEEK1w763RdCGTetgXUC28obzws/7mw63a2BM/EnCUcWC2DFsr0Y+4JBqQwRUICTZZGD9QY5QVYxGsFZhnLlnz9OM5BGfHNK3J1lmMHvTI5wctVE1cdkTU5ggKUatmNgqCm7oTSfEwM4Dv6QI6SRG/nbW/z2pSiEBeW9zoMxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770969127; c=relaxed/simple;
	bh=HydngnPH8JdH29JEkGrGYo1Fq5011iu1/G7Ad0Yr0IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RIz5MckP2WJCeir0q/HOKGl53W/KxiEakRGnF4mUsNRdA/NM48XI/RKu39pYsoKs3dC3hD4GOblwJKHfDvAA2zwPhQ9MmIpTdomEkbdR/QTQ6mJ5FqXWMpUCTmNt1pZldyfvlZ3YnW+4PLS4uYAEqbMfCeBNoS3uiZDDvV+kOU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ayWn0Oc7; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ayWn0Oc7"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D7jgfV1153039;
	Fri, 13 Feb 2026 07:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=HydngnPH8JdH29JEkGrGYo1Fq5011iu1/G7Ad0Yr0IQ=; b=
	ayWn0Oc7moDoGW5n4cQoRRWZcunlY2e6H45s0HQ+sp8XPzwdOw6DeFjxAkhUQ4sb
	NwBjhWWWz/e+Guzc8AwQzZle3501VwdLglWNg8nbbWPSc/kuHnsfB5iajtfyShzo
	set8Ls/hPEl4UoL34EpJTI6kt3EXa+VMofocgKzQqLeqSRBbz2spzHh8zbaMzpnz
	TVP1fNrSwIfIp1Ld8hptBpvIMemUGHBUMX8n/Gycy3g0TB5RjnOdNEt/Cjiu1vHe
	eqLe7+JMH9dZDOUSjlEbAmp46fQcDTYEhhgPSS1Z70hOe96DlVyKVwLBsw6y2xWV
	p/K+Lpv2uERiiXaXGsvcPQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c5tkwq7me-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 07:51:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ly2ouB/DQddTT9iuBYybTZRFSDCeVWRLxW0sgtrhSo33SH2rc0PlADWoC57cLq7ani6P+SxPkSMguhXljqTpZkhdjtt2MiM6fiJQygY6f/4XC4m+8RUx6s/XbHslMIcgF68ru54yoB5bTzTYVvAjmvQv5wL4EAYLJ/jlEY0bmbsSZRUpuKqYFKdUSMX3H2u1CEqOWDQSZUrhOJ/s2noAkDd0rXPC9TrDsYLfPH3GiML28wTS2hKabzYkp1/ynpVV0X/oCO+X2kRrOL1xpOP+FIU2Yy41xhSUURU2ppFY8TPWw8gY4JNz5WMCZMCeYHSii72J9RP3BS7ze5EE6lSfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HydngnPH8JdH29JEkGrGYo1Fq5011iu1/G7Ad0Yr0IQ=;
 b=cBndBdzFsBECIX4X9ZeqhRh1xB0t6knHDbmYl6Q3B7RikDNGc64Dx9hPFxhBstohjCdWVYcriV7ham5/j8QHp/PX1vLJ16AcCib1UaJNrEcdYwKXldc/uJ0E3zpHZ/cO8yoTH1YnxlyTWVRmlDNOMJyv8hA9d25QcGmvQV8zW9zhO1Q2lrqIHLVYOVVXWApQNUFMILgCPfz1WzvkJVunkGLY+GC6bluRL+d0cG9Vpn8WLcRsANEwpSj/7MHASbKMffEl6uTyfhvfGx05gGZdB58sF5mCEX+Y+rLWJQVHVvBlwxsgomTs9CvtOlJc8x3Dlk7edjU10ihIPTVl2/kGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by DM4PR11MB5295.namprd11.prod.outlook.com (2603:10b6:5:392::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 07:51:28 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 07:51:28 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: idryomov@gmail.com
Cc: amarkuze@redhat.com, bigeasy@linutronix.de, ceph-devel@vger.kernel.org,
        clrkwllms@kernel.org, ionut_n2001@yahoo.com, jkosina@suse.com,
        jlayton@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, rostedt@goodmis.org, sage@newdream.net,
        slava@dubeyko.com, superm1@kernel.org, xiubli@redhat.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: Re: [PATCH] ceph: add timeout protection to ceph_mdsc_sync() path
Date: Fri, 13 Feb 2026 09:51:12 +0200
Message-ID: <20260213075111.32886-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260208131819.37276-2-ionut.nechita@windriver.com>
References: <20260208131819.37276-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0202CA0021.eurprd02.prod.outlook.com
 (2603:10a6:803:14::34) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|DM4PR11MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: 6926af8e-3b41-40d4-a745-08de6ad4b1c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|52116014|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vjdzc3hVUFFFeWRMdmtEV2JZQWpwczFYNjJOeE9NVC8xMUExVU5rczJYYWMz?=
 =?utf-8?B?amRnRnRNODRxWGtXYmhrR0VVRUFyNndYQldPS3NPYlQxRWhLcVlwbTRFQlVn?=
 =?utf-8?B?MUdlbzdJR0M3SFZTS3VmU2tqSkhPMEJCOSs3S1g4NFkzNU44dkIwYVR1ME1S?=
 =?utf-8?B?VEZNMHlqaEFrOWwwQjF5ZGkvaEZtWHl3UU9xV2tEL0JRR0xycWZXeWdQd0g4?=
 =?utf-8?B?MmI1TjlHZ05GUHU2bFpvcWFCLzNmVm82ZmVpV1lFMUhXeElxU3NoUVprYWxI?=
 =?utf-8?B?cTdVUVU1aDFrdFVUMGR1RDVLUUhTY1NrSnZ3M0lUeFJiRWowd21KNzRQcFl4?=
 =?utf-8?B?YWpuWmtvT3VkTHZwZ0JmUXg4clRnN2JUbUl4VEVoWG1RVENNUFNCZTYvRC9F?=
 =?utf-8?B?UDV2dG9jRStqNG1EalRhWmdWUm8yYXlzRTh5dllFREVVYUxCeVJWcVRCYXRv?=
 =?utf-8?B?a0laNmI2amd0ME85RDQwQTZRNlRuL0NkS2krc0lBN1h4Zk9MVjlKWUJ3Q1RI?=
 =?utf-8?B?Qi9FOFF5Nmd5eXNBaEZWZmx5Y05WdGNMUmhwaGY2VlVsUGFETmJRZ043WVY5?=
 =?utf-8?B?NGhmd1BMMTY4WjFraGtEd1NMZjZUZm9YRFpHSEZieHpWQWhFc3czVGZHMzZx?=
 =?utf-8?B?MitWcnpaYVc3UTAwa3ltSWx5R0E1a01hMTJsTVpibllJd1JNV3hrWnFyNHN2?=
 =?utf-8?B?MGlpSjB0cHZiVi9aZFdTSHpScnlKZzMrVVFRQ3BkR0FtVDhnOGNFNXRsL3ZB?=
 =?utf-8?B?N25RK3JxbGZVT1NlRGc2dTBDS3ZqeGc4MFpySFVURDZMYWFQRENsK2dpS1JH?=
 =?utf-8?B?NWZ5emNlWDZIUlgyZEtFOHVGWkFmckpTSWdMdFRSejJFcWdzWG9lOHllSDV5?=
 =?utf-8?B?aE5VY2Z0VTRtSitLSVc1QUFlMmsxMnovb011bjlXR3Z0R244aVlzclVwMkJC?=
 =?utf-8?B?ZzQ1N1diYVcwejIvRW5qc20zdEZ6OWRBRjlhVjRvcTVtYWhNc2xMenM0d0s3?=
 =?utf-8?B?Zlc2ZFpiMzNVVlNCSjJrV0Vqd1NyY0V2SXBtUmIvaC9IdUZXT25VeEhCczgv?=
 =?utf-8?B?U0l0dlNoK0Jwdm5INTFRU3ZuNWxxcFlLNHA3SHh4aWJOKzZOM29lMkdDR1NP?=
 =?utf-8?B?NWZCMnlnc1dsb1NzeXYvWDcxWW1PWFdHT29KcU15aWFXVytSeG5TSTFqRTFJ?=
 =?utf-8?B?cVVmKzRQd2xOZ0RQaURwR2p3L2J4cGE2ZVBEWXpwZnJTVVQ5NHBTL2ROdEl4?=
 =?utf-8?B?a3JxM0VOb3U2SGk5WU9vZ3orb1BFTEtEeDFQTVFxVG5UWlQ3NkQxYTNJWmk2?=
 =?utf-8?B?emROMGlKazRSQjF5NDNNMlFkWlJyUDhwZk1tcUtVRG1JZ052VVczSXJtcFRl?=
 =?utf-8?B?eGNsL3lwZmxXb0M2QkpBK2ptNTJCT0RmZitGamZLK20ydE9MS29ieEdyU3Yv?=
 =?utf-8?B?MW54NGJGemdEcnhyZTRiSnRIWSswV21QeFplaUhHTVIwcHFZd08rVnZJaS9T?=
 =?utf-8?B?d0NDb2thTXJ0eFFjK3NpRmpSNjVPWjVaVk1KZWZaTDhhMGtPYllQalJ4K3Z2?=
 =?utf-8?B?UEExRGg1Skg3VTllNjdqZWl2L3NVeE43V3h0N0NFRUh2d09zdlMzY2dYUTcv?=
 =?utf-8?B?amxLSmFBNkJmS0NSMFhGeWVzcGxBODJidndQY3BJVFNiZFdoeUJpYkRZak1o?=
 =?utf-8?B?M3dRWVZtRjdrdzlPUUhlTllEUW9QcE1DOC9QOVVJQk9nb1JHUkl6VEo0SE1z?=
 =?utf-8?B?WUxkeWVxV1c4MmJpaVNjUUNrR0F6OGNYVkhIbkVEUGFwRlhqWUttRS9POG5N?=
 =?utf-8?B?dlorMkJ2Z21nYTZhSG9IcytrV2xvRi9Db3h5ZnNBWVdRNENiMlpCWWhKVEMy?=
 =?utf-8?B?RkYyeTNtWEFORGljMjM2NDJ2OXhOaVAxNEVJbDdhMEhOMDBXT200RE9lUVUy?=
 =?utf-8?B?NndpUnRJMjR3S0ttUlNyMk1CUXZMY29NelI4RGpqYXZoRG5IbHJaOXB6MGZD?=
 =?utf-8?B?TllMQzdkYnM2Q0M5QlA5OUhNQ1NaWFk3eVNCUkpsTm5vM3R5R3pPbm40a1VH?=
 =?utf-8?B?WTJOSEFvbWNSU2FpbHNESjNsaHFNV3RaWXl1Y3B4WWJCdklSUXZVMEVzZ1FI?=
 =?utf-8?Q?bSUE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(52116014)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MURnVVZMKy85Q2RBQk9QOFFkQ0JEc0ZNdkJjT2NuNWJQaHE0TzRrVG9WU0hN?=
 =?utf-8?B?QkNFRnV6VjFYczBUTjRaTVpMN1hOYi9Fd0pQaVMvbFpuNEltMFFsc0VnSzZY?=
 =?utf-8?B?UC85NGc2ZmJ3UDl3U2VxNUNUemFqVDBWbktzRzZyWGIrUWJOcGZvbThiNytX?=
 =?utf-8?B?NGxPVmdPenZaYXNQaDhVWGR2cmxJUTlVV0hkRmZrRjBUcE1QNklkUFJmb25s?=
 =?utf-8?B?NlB4UTdJMTZ0VmtMblBHZ2F2MldoYVFab0xialRXam1Ya1kxTkk3QThhL3JY?=
 =?utf-8?B?bCsvNlJ6VGVzSXBnVTJQZUNKWDlYL09HMnYxdHNIUHd3MG1DZEpNc2N2MDZX?=
 =?utf-8?B?QXg1YTU1WUpPQXlxQmliU1gzOEVqYkJQcGJ0RlY3VGtzRFN6djFCTHdEN0RJ?=
 =?utf-8?B?Y1dvMk5XdkxpM2hEdW5UYVBSbk9xUEg5aFk2Y2NlZlkxS1k2N01NQ2lKY25k?=
 =?utf-8?B?MHNLZnpYOWxkK0xpZ1pDOWFiRnJDSW1wR2hzRWgrRjhKTi9VTldPdm5LRENy?=
 =?utf-8?B?SHVyNGc0eENlYmlzaVViVE0waDR1T0d6YUFQUVozNnI3Y2c4S3N2bnJMVUt3?=
 =?utf-8?B?MnlVbmVHQ2NtTmZlY1pKQURZVG14c1ZvTUQxOThacWFaUjhhOW41UUdjSzdn?=
 =?utf-8?B?YXlhZnNLMVdia1VoQ3hhclZ2bVdJWkhOdzVTaFhOaG9hU2RwWElzMlA3TjQx?=
 =?utf-8?B?bld2WWlGcWVTcGJKaUJRcTQvYU1zcGhuaHNUYXlsRG8vbWNDajFtenNVWnd0?=
 =?utf-8?B?YTB4b0xlbVJYenpqQ2hTTzhlbWFnOFphc2x2SWx2WUpIcTA3M0grWWxSdlhi?=
 =?utf-8?B?U2phL3pJdGNUNnVsdW13UDhnY2g2SGFJR0E3ejlIMTR5MndwS3dXZlZ0dzEr?=
 =?utf-8?B?ZFBuN0dVSlpuYWR3bnpVRUY5bTVDdHlTTU5MaXVtbGw2dnlEL3ZVY0Jxdjk4?=
 =?utf-8?B?UVoveEd5djFYSU5ybER2MExmTjdkTWcvVU4zNGkwa0tvcUU2SVh2cVpYc3dM?=
 =?utf-8?B?VlVFYUlFWWloOEVRT1c3R0VLRjVJcTNQaVRyNGFJWk1OYnNKbGN0UDZUVTlF?=
 =?utf-8?B?S01rd3p0cHVUZ0t6d2s5Z3VGNVl3c0NDbUdPM0pwUDdFcGdDRXRyQXRXaVNt?=
 =?utf-8?B?VEpUMzZ6dGVIOUJTQXIzM2lNclpod1ZNYTV1d3lvelhodUw1aDBNV3pmUEcz?=
 =?utf-8?B?aldnZXRQRVdwb1hPckJPVWUwdzRjT2xzSnBQd3J5blFOWnN1ekpIRVhiMzJT?=
 =?utf-8?B?SGxsbUYyWENQckllckJOeVMwN0RQaVh1NTJZWlFiQ3FVL2o5RnhKOVl3cVRk?=
 =?utf-8?B?SmRSMldvN3pKQ2dlMWg4L2ZiQ2ZGQXBpV2tiSDBCN3lzanBxTHlOOUk0QWQx?=
 =?utf-8?B?SmQ1Q2RpY2FHUVd2Y3RlWDAxbU85NG1RalJWUkZzaVQ2NWxvcVcvR0VTa2ZG?=
 =?utf-8?B?OTF0TU1laXhLWVFlWW5vaFJkREh4bXZjbFhpY1QvR0QrdTV5aUdvTGZ3a3hv?=
 =?utf-8?B?QnNTM2I4ZGFxUnJ4a3ROTDdFVTFZSUhFRjNtY3hZMDIxVFA2bDFRQkNqUjFL?=
 =?utf-8?B?UVd2OHVla2lpYm5DRm9mcFBjY2V0L0lOWHptZTZ4R3E2NGR0dUkzVzV2NlpJ?=
 =?utf-8?B?eC9Cb21vZEpWdWlVckM3eFkzWTN5TmVQa0tycndMc3ZZcDFSQXhWU3pGUlJh?=
 =?utf-8?B?MkxDMEpVYktJT3BRZXpHbGxUU3V6M2pTc3g1bDZ4ckFNRkhrMklSRU1iVDdP?=
 =?utf-8?B?NVFVNUgzNzExQ2FSK1BLTGxDTzZ4UmU1cmtkQ05xbU1VaEY1RjNGcUpqeTVa?=
 =?utf-8?B?WW42Tm1YOGhuSnQ2Mkx4UlY5Wkx3S0tCR0lNbkFQTlZkMkpwUFplRlhMNmVw?=
 =?utf-8?B?SWdpekwrTjBMR0REMFJmaW1IWlo4ZkJKZG9pRDdOTkZ5VXpVbnMyaXNxUW43?=
 =?utf-8?B?cElLS21rd0JTWFNXa3NGbU9QUnR6NUlFc2FCSDgvZTZ2Z0tudENSMkJqQldC?=
 =?utf-8?B?SGRJdWx1eFRrZUo3SlN0TGRQSUs2NXZtNG5VUXd6cTRzZ0lMd3AyWWdtbms0?=
 =?utf-8?B?VkUxZEdLVmxlTEVRMDdCWXM4Vm1hTFFkUVVlKzRQbkRyN1V3SlhHbXljSWdm?=
 =?utf-8?B?TjZjcUxUSmhxOTlseXA5cjBVTmhvRHN1U2RMWXVWZTZDU2xjUFRaeHViMjRK?=
 =?utf-8?B?MG1VUFlRTXNHclRIWHkvcFVNVUhYWHRNL3FPcEMzRW1xNGNmSFFrd1RDdHEr?=
 =?utf-8?B?aGhnMlRkVVI5a1NHYll2Sk5TS0FMZHJRVWNUalBtSmxpVmxQcU15S3hMSk9j?=
 =?utf-8?B?L3VUejdkTk5HWFZEdjVSZzlsK3FsbXNHdU02dVdVeWhHVTBtVGd1cTVTZHQ2?=
 =?utf-8?Q?zy3tiRRU1SPF1x4GUMBPgeem5K6jO87gutUfdRTitckcf?=
X-MS-Exchange-AntiSpam-MessageData-1: JKTxdPbBH6/5uiVYpWHf2Un2WeUSzOzvg68=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6926af8e-3b41-40d4-a745-08de6ad4b1c5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 07:51:28.3861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0kG1CBS6zSaRRkPMJi0nexlgNEtcGI1Wj7D3+zVomrd8p7mw5Fa71WmRT0QRZZk7dFr1oO0IykyU2vSm/WubPcf22xVcWSGNOKRonl7ZHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5295
X-Authority-Analysis: v=2.4 cv=bvBBxUai c=1 sm=1 tr=0 ts=698ed801 cx=c_pps
 a=GL1li5ChHZoEBhvyUKgzGA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=4u6H09k7AAAA:8 a=U8VqEihZ4mKUUNuiy5gA:9 a=QEXdDO2ut3YA:10
 a=5yerskEF2kbSkDMynNst:22
X-Proofpoint-GUID: 9_SDE3osbR5-qZ0A15MWMC5U3X4dExl4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA1OSBTYWx0ZWRfX+g9q267xtnBn
 rXvNKRknUbrs7lcsqWluRUCTcBZsIqnDrYy1KP3vq3q70bSUYlP/UfMoD//ztJO7m+Z/nVGy4us
 zRef0wYWIDYmw0JIMfhpwy0TAifCCk4VVgalALR/4IcK7LY/XU+2y6bd3NyBud7+EhAyBYhhNoU
 zygMFIzmLAh9B/Z/t3u9dP6N2Q6DvYkNeZ+FOM3fx3BxILH20kB0mtZp+xcYvWjhF+yODpYb0vw
 4nIOQMGWH3UYFJFRp6lQPeFt55Qy7BT1ub52v24GB82uO7TOZUyh5uT5XTQM1JtoR531HpEZr8a
 cdyCH1oPA4OZ2MWE23/lEQG8F1Rg1netvb/eXAsmtgonVw1B5scIS6jsrd2AWrChI/UngerXTgp
 3wZKkeEgTPFbgvdBkETcKkhyqBodPAUr352FoEBSd1viB/qUhSrXbAh5L4Gat6QXH0PBxMh+vY4
 AY5Y9QE56GwJPJ7/vHg==
X-Proofpoint-ORIG-GUID: 9_SDE3osbR5-qZ0A15MWMC5U3X4dExl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130059

I also created a tracker issue for this on the Ceph bug tracker:

https://tracker.ceph.com/issues/74897

Thanks,
Ionut
