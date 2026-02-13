Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB33115A2;
	Fri, 13 Feb 2026 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968753; cv=fail; b=BJB54G2MJwAyVJbCnV4MEmgPWZMC5qqKZ4PpTUKq7j5Hcn+9mgQilDgm1Jz/YMjz8MHlO7G6kv5qrPkeuSPBBKP6RnlQgcCLzyka+MujXFHtL1IyMDDMM2A1x/5umsnXIr7J4qmxD4gXwrBqqZkLatLgfyugdoIelNSH0F0W+34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968753; c=relaxed/simple;
	bh=HydngnPH8JdH29JEkGrGYo1Fq5011iu1/G7Ad0Yr0IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oxfW/JIluTWsWb9suwniJJMAuyYohU3lLzfyvFsGfTD2mzlMiKdLMO5IR13px0d/JZuXxzDBBFblOxLpEu9Ny3LQZL3oc202lxINeUEyssgRg9+eA7EB2wB0OHBA7BGWe0dg9+7Lx1vIYM9CUS36EPSE10zy2M1BFmh7q0nvWHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=IAqlECl1; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="IAqlECl1"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D7c6991582306;
	Thu, 12 Feb 2026 23:45:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=HydngnPH8JdH29JEkGrGYo1Fq5011iu1/G7Ad0Yr0IQ=; b=
	IAqlECl1AD0Bujm9PT4QqF0YTYzV1Jva6+I0Cx9BPW/pgw5cqIltY/Wjgdwj9iri
	5gGKcrC0XoBfMJS3sJhQaJqOsk7KRS0Oy5iPdQsVpzbQrsnmMmIzyTRD4gVlLVvK
	qBtJUAIL6YsWO2FMAhyZi4qeCE2Qv8hZdv0a39UNxirI8l0zvvMxV7gI6hDrXNgD
	2VZ2Ml6eNNAyDQpj0grR184WuEMMpTPIt8hIS345JkMqO+44mWLkc0qvlnyyt2dn
	v7zoGdv6h5XMxH9rGSNDg9ceMxlFu/fiG7oigk66TWimWvSiZpKMysRjjzsUBSUi
	R8AVVbzFrhBqTehx4stQew==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c65sj6vfj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 23:45:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYFeEPFpojfCfhM9TA2RbWW7atPiSu6zwV20w0j5Uypfxr9mXhs9jyeAkD9m+7BIRUWjSwYaQpWuJrjl6v5LGnHPL9jSKH5tGd4gFPuwwRA4nWHfVqD0INkEFo7bX0JJDtcZFb4IIacXy50BJ/7bq7quJwBkSw4qXKbeskBcdyQNDFBhRp4Yko8GCWPF8dIInRiEacKW6oxiBwlgagDIH92j86/MjKdbZ8wCQ+uMgNQntGf+zAmRj0FTTgAfsXgiiazsCrE6m6DnEdrNbMhBS1mUbklgsdija5bTwaOhv/UsP0xsfXwPbXCAYUi0ZfUqMQbQMi43mdrsktgcUbiZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HydngnPH8JdH29JEkGrGYo1Fq5011iu1/G7Ad0Yr0IQ=;
 b=ki5vYnpOezancw16AKgMX+fYoBeEB4Qg9Ee7gVOFYgQkmuPfDghtfJHqMzE2y/BeOZBWuLpu7fUCBmMY31JWVRwJwlBO0+qiQW6LKNvHOalfkAxcXjxJDkF3cK7hqUAcB5t2Q9cjmojjlWZbIFTHUSiOa0T67LVx6JbaMWT7qv1Rt//qDP8L7TPuXH+KlKqixHSoFU3o6hoq1LcNmoQTWsCSe1eesF++VoWOoVlcvSXfn7Lqrv3uveQqdnz4i3N8O0zItfj1KmNAjvMW2JUQKhHeIVy3uBlKgnNIy022bh5133KqEeMySOfyvGmaeRfi4Mi+8y4uwE63N6es1CRcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by DM4PR11MB5295.namprd11.prod.outlook.com (2603:10b6:5:392::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 07:45:33 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 07:45:33 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: idryomov@gmail.com
Cc: amarkuze@redhat.com, bigeasy@linutronix.de, ceph-devel@vger.kernel.org,
        clrkwllms@kernel.org, ionut_n2001@yahoo.com, jkosina@suse.com,
        jlayton@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, rostedt@goodmis.org, sage@newdream.net,
        slava@dubeyko.com, superm1@kernel.org, xiubli@redhat.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: Re: [PATCH v2] libceph: handle EADDRNOTAVAIL more gracefully
Date: Fri, 13 Feb 2026 09:45:16 +0200
Message-ID: <20260213074515.31914-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260210072243.16169-1-ionut.nechita@windriver.com>
References: <20260210072243.16169-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0041.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::18) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|DM4PR11MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba093bd-3e2d-41ad-eb9f-08de6ad3de26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|52116014|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG1yVDlzNDRZdlZ3N0haU2ZGTE56bVY3YUNRS0RjL3o5M0lIcWxpeHBiNVhr?=
 =?utf-8?B?NHN2Uzc1SURUcW5PYlZpMmVnY2xmQTNYSmJlUSszRVpCQ0lvMFJMTGw0RHhl?=
 =?utf-8?B?M3hoTWZCNUsyMktKekE2ZENrQmhsbjJsT0Q3bVZBMEZoRGY2KzNsOGdoQldl?=
 =?utf-8?B?UzZJM2M3MEF1S1hsdDkva081dXVsRnM4OER2dmpuRXRJMW1wZFVLRVdib211?=
 =?utf-8?B?YTNWVURiUlV5clZGandVUERLL2JPdkxUYlZXQ0NOTURkTlBwQUNVeHJkMFly?=
 =?utf-8?B?N1Fod05BeXlkMGZWWTFGSkpHYkxhaFNvaldEL21xTGdvbzQwRjdVYmVVWDBy?=
 =?utf-8?B?aC9iQWNQcURTTGliUHBjMGYwZEZZM285UHlKRVUxL01sdXUxS3VjV1ViTTk1?=
 =?utf-8?B?WW5XRjdmTEVHclBMa0d2TWJlUWJkNDliOXYwcXVlMk9OSkRKcTNheVkvMFVB?=
 =?utf-8?B?Rmptd0RsL3owTWhUVDRLR1ZXc0xJaGtMYTFzRXp3VU41S2J4bmI2RUtYNzVk?=
 =?utf-8?B?a3BLcXRIZ1RuK01UUEVxZTM4d2hsaHRidDVMYk81Vm5JZDBhWWowRUxoRVJp?=
 =?utf-8?B?NUhHN1VaQ1V0N1QyeHRpVHRQbUxCdHQ3V1dmdjlVamtGMzFoU3RhOUZVK0JM?=
 =?utf-8?B?YUswdWZaVXByMHZycVVhbFpOWkx0NVl5aHRiaXBPQWhpdkxyc2ttVTIvY3BI?=
 =?utf-8?B?VVpxSkVWYUdMWm93dDkrQTZJcGhEZUgvNzFkYVZLYm05OFlJNzIyRHpKZ3ZG?=
 =?utf-8?B?RlN3NW9DNjJwb1RKdkdOMEFQYUpGNC9US2NzUjdBR1duMFlHUWZvc0xuSEJh?=
 =?utf-8?B?OTZkZ0xKdlB6V1FJM0xTbS9HVUR4L0lOOUY2VVFqR3ZPMHpOcWt3Ym1BazZa?=
 =?utf-8?B?Q3pPQUNtOTR0T1VnaXk3MzdScFhjeDJxeEtPSHZNN0FZeHZEMG5HR1NvWnc3?=
 =?utf-8?B?Vnd0NVArQ3FIUGZPY3FhcW1FQTg4cVRxWDFIbXNhZG9nSVU0MHREb21vMjgv?=
 =?utf-8?B?SFBIbkU5VHpKMWk2OUc5dkE0Nzk4WjZDcDhUUkNqVEJ6dDhvQis3QkpIYjFS?=
 =?utf-8?B?VGRyMlVNMGNTbktGbk9ySllINFlSUUFOZ0pqeEd4WU9aQ3RzSTdFU1RGSHNz?=
 =?utf-8?B?Z1dBSzhYM0Q0M0pBZ0NTaUlGdEtHTjFBT0dxMHhBNVRjSGdUUVZTVkdGNm1m?=
 =?utf-8?B?QTlwNFN3Zkh2bjhBVEdwczVKamNPVXMrTU1ZdkFWbWZwekZnYUh1VDkwMDJR?=
 =?utf-8?B?MnR1OXUvMnl5SmJURy9acnRHeWdwUE1hbEdtTkdYbzdaVlg1WG4veXIydk95?=
 =?utf-8?B?djJaRUtlVVZaelhrdWp6VnBCNUdhNTFLN2FCRVFFV2NSVW1pOFlpWWlaREJM?=
 =?utf-8?B?MXJLcTJSVVQwWnB2UENGcHVyTExWRnJvcEZlM0Vab1ZzZ0JXOGV5QWFHRnJO?=
 =?utf-8?B?VjM0LzJTVzczVHZXaUZQVEoveWd5bnJuVExKWFhncnNHSEV3N1FBN1owd2RG?=
 =?utf-8?B?cDd4VXM1T0JrOUcrTllnTCtUT3orV3BUK2VPdjNZcVRmeEUzTjRIN3ZnbWFR?=
 =?utf-8?B?SnJWY0xkUHdvRng4MmdvRlJmRkwyMXF2V1dVRDBVVjh0cVF0SENKeXRVZlFX?=
 =?utf-8?B?RmUrZHZaZHM5S0xBaVlaaHhjWWxBWGJ2NmpMc3BBODNFV2xFYmpIbFd3STVC?=
 =?utf-8?B?UFdsSmxzMk00emdhdHl5c3g4OCtraWsxLzFYR1U2bHFDSEtQb1hEN3VGdDZH?=
 =?utf-8?B?MTloNXhBTFdzUzgxcGtJZnhUQTdyNEo0ZUVqV1pNWnh1TE5icWlGdEltMWx2?=
 =?utf-8?B?KzhHVWxHMEFmalF1T2Y3SjB3aHJaVC9qcENVSVg1UERYSWZRNlhOWHlqZmdz?=
 =?utf-8?B?NkovREYyVlpFK0pienllNnJGQlErRGZnUzJUbDJUcnM3ODNPVUQzcndmV0t5?=
 =?utf-8?B?eWtlenRMbXJkM0tsUWIrSXF5dmRkWDc1VnhkY0V3WjcxcmFwZjBuV1FIalds?=
 =?utf-8?B?N1lZL3docEFFZlhtRDYvalY3RXpmYTBhbFZIMUFhNjlxYTZqcFlBcVpTaUVW?=
 =?utf-8?B?OFZtZ3p2L0JqSllMRmh2VngzY25OemNhU1phQjdqVC9TRVAyMUp2QjFjMCtS?=
 =?utf-8?Q?MhlM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(52116014)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aCs2SDA1R0xwaUF0dHVHL0hnNURtYmtkWlVWMWJrY3dZWm0rQmpSNWhBbGhi?=
 =?utf-8?B?Njcya0pEWVZzb2V3Ylk0ZktGQnJnS2Nxd0JJaWRsWDNXWC8yVlJ2ZkFiOU9k?=
 =?utf-8?B?Ri9aN2taVlBxYVhGazlZbFpDcStscExQTFhqSkszZTJNejBsc0VvQVJ0d0p3?=
 =?utf-8?B?blFVaU9ZMlIrVmJoVWhmeWxwcThDUDRXWC9vT0toSjN3NTRxVXpia21SRGNM?=
 =?utf-8?B?ZlFkT08zN1FkNWdJTi9ITjRjdCtWRVZMRFp2L252dW9vZTdYMzR0a1BJaTdU?=
 =?utf-8?B?M0U4Z0tZa1NzYjcxdmtsSGQrMFhBakFYdTNKWGJZWGpzeVFhbTdjb0dlamZI?=
 =?utf-8?B?U1RETjdLWWhsOTQ0aU5hdEYySHRyZk1VeTdmZEZmckRnbGFNd3M2cmNOY1lN?=
 =?utf-8?B?aHY5bkt3U3NtUVhPNXJvSURrTXRwMWw0b3dYRGhib1plNFp1SkRrWmxIQ2tP?=
 =?utf-8?B?RVBVbUVsdUtVWUFBRy82aEdPQnlTQXBGWWh1SE1HdFpza0trK3JPUkhLVUZF?=
 =?utf-8?B?S2tlUm95L1pWQTlDbTE1R2plZk9vZXMvV2sxaHRVcGtXeVhzZ2lzS0ZhN0dH?=
 =?utf-8?B?YXhVUlNGL3hMdXozK3lNdUUvZ2lNM0N6cHVBcGhuT2Z1N0tJQWQ2VzNjYTMz?=
 =?utf-8?B?ZVg2Z1V0QmR6NzhRWGU1N2xmWGd3clFidjZ4YlEyMlR2UFJRTDVncVVGTjFY?=
 =?utf-8?B?RFFmSUdxbzFyamEydzhKc2Y1cjcyUmVqVW5COXFmWjI0SE1MUWxocW9jM1FS?=
 =?utf-8?B?SHkwYm82QnllUDdtVHVad25LYjRoazhMYm85N2NaWmxsQmtOaUtDaHFFQUVQ?=
 =?utf-8?B?cXhLRkMrWTRWMlM3MWJTdWxXd0l1VmtxN2xSRXBhdWo0TUk1WVRFYWk0MkhB?=
 =?utf-8?B?dXF0WHNuTlhKaTJrSnBwNTZTK0ZBQUdkNENXTjF0ZCt6ZG1DT1MxeDNYV3FI?=
 =?utf-8?B?YnNRMStHMCs4eWI2S2dzWGgxYis1NzlRUERyWW1WaGdaMklXd3A5aEpBS3Rn?=
 =?utf-8?B?WG5rWi9LWjg1WUhVYzdIMWN4dXdGd3AybkhMN0N3UFR5SlZwei9HR0t6cHBC?=
 =?utf-8?B?RzFRaDR3QW9LU0RlN2o3ZWxtdjRMckhTdDVUTE1BOHBtQ1NzTHN3OHA1Q09J?=
 =?utf-8?B?MElyZXlObUIvRzNZQVFOUUI3WGQrODdQamc3M21FWG1vWmFDdDVZZC90Mkph?=
 =?utf-8?B?N3RJNk9XY1NTZWhoN0VUOFRFelVpSGNlKys1SjRMTmY5R2VnQjl1bTU4aFEr?=
 =?utf-8?B?T0EyUExQTlJCTW1ISEdqQjNpU0NCenp4ZFFaUHhqZzdocW0xbEhxbDBIbDk1?=
 =?utf-8?B?WDNUMlNENzZoekt6NEQrRnJhWmlyNjdtQXhIaVVHSjhQL0FBYjQxNDIrWlU0?=
 =?utf-8?B?RCtZMFk0cjZmOHNERnREdUF4dU8vWVExRlp4dUM0djVGM0lFcFBIYVBRMHAy?=
 =?utf-8?B?SHM2UzJsTXFGL1BFOTR5MUFXRGswK3hEd1liU1JjZnNTcStvYUsva0Eybktl?=
 =?utf-8?B?b0VTT2Q4OU5jUmRiSk1nVkVGQW42UGRXZzlKblhKdzB2Uitqd3E5NVd5NHpN?=
 =?utf-8?B?ZnpqeFBzWVpQUjBEcWRNTWd0U2UyTjFrcGVnS1FxRjR4UXhScDBLV0cxekFw?=
 =?utf-8?B?U3RtUGd2a2d4Q2Q1UWhoMGxJM0JzZ3Z0eDFjQXgzMzNFaHVNUHJCV214YnJH?=
 =?utf-8?B?NWxKRitjbWRqd1hmM0FlMC9KZk10QURBVFNCcFZXckdQUGliUXJIVVJyMXNw?=
 =?utf-8?B?a2ZjUnk5STMrYXlYNU9TUGNQZUZpTXB3MzJXdEF1b2tDNmEvQWlCSDZucmZX?=
 =?utf-8?B?emlLVEN1RUJwRmVwaXZYajdLdEE4TUpJNEd5bjQ2Tit5NXhSTzZNblJXcVFk?=
 =?utf-8?B?L0VCQ0NLTDB6bEV5SitXUmo1RE00RStiNE5idDdIQjVTY2E2VzBhRCt1SzdI?=
 =?utf-8?B?WVV2c053M04rdGlDb0dDbnk0UzV1VWtyZDJCaG9kL3RMOVkrMWxUY2ladW4r?=
 =?utf-8?B?OUJiYkdzYklYSU51Y2FSNDU1V251NU9lRFV5dDY3UE16RnZSMjFrSXVwTmls?=
 =?utf-8?B?b3FNUXRLM09DTEp3SnVJQU04TDIxeG5JWkhlRm5sd09VL28rZSsraVprS1JX?=
 =?utf-8?B?NkJLcno3K1N2RkJLcUJobXI4SmJSUkRrcGduWmZCSm4wcXRtWDhsVEgyUzdT?=
 =?utf-8?B?bCt6ZWcwYzg2TThreGF6U3V3MCtWR3hQTFFTd0I2L1B0NU9ZeWE3UGJlM0Ji?=
 =?utf-8?B?WXQ1TDE1OTNFeDRwOElIZFNLL2FKMW1zZk9IdG5Udjg4ZnQxVUpPWjlEMFJD?=
 =?utf-8?B?enphb3grMm4yQ3prOE81YWJYYUhEQ0o3UHU1VHlmTHJTSEVDS0VnT1ZmZTVK?=
 =?utf-8?Q?6Pzo3qkq3Dq5x9TfwEJ/Z+dArmLigfoE3U4MVLo+FX2gT?=
X-MS-Exchange-AntiSpam-MessageData-1: LNB3+/x4C9gTsPo0fkQQVUk3J93LcJpjITE=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba093bd-3e2d-41ad-eb9f-08de6ad3de26
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 07:45:33.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuhUfsj2pQmgiuLDNOcKIMDPjmykZBfvZX/q2Hr4roMesj7XTvU9ygYGQdcD471tC0lVQBMDQvw/QElh0oKEtbKAv/1i+f/s/jFqMgveNho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5295
X-Proofpoint-ORIG-GUID: gHiSGo9wKgmvATRPXIIGHFCIEBhqqBeC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA1OCBTYWx0ZWRfX0lrjKnuj5ZSD
 YzshR+n+2lxyYVXk7jChSsmEPjTovxJdkcWiU4Kx3Njt620Tc28jvRpZbrB3d2/lgKWicRTwiwn
 76IWU88YABRMzOMHvTmnR22nArL0cgU/ACflO0KRBf8SZW2ULgDEa9jFBnEUwqi16jjKy+pli0P
 UrG8AHO6XWo1d9gmo5aTf2+UZ/8kpJX4PPpPVhyh9qHHcjHhrJXnZr1mIrEzmVxRKWhoL3I6FtN
 bVZ2MjVGjwge7g4dOK+GBVoDsRb0koheS45pDBqs+TsmWnFDQf2YqU/DWeHlIAtei2yj7vCKQgH
 3PhfYXuIAP2+0EkvGHBWy/f5vdU4XH5kj1VMCSdBrqIAGPicw3CGvig/mvpR3oSinJUUHrszrdX
 PHa9ryu7JjDwz34+tg40qa1C24etzRIZyx1nFB1j8KCntRKivq6EW2++tomR4h9CRw9PH+hhv1O
 UuqoeTjgd8JkmLxrcxQ==
X-Proofpoint-GUID: gHiSGo9wKgmvATRPXIIGHFCIEBhqqBeC
X-Authority-Analysis: v=2.4 cv=Cpyys34D c=1 sm=1 tr=0 ts=698ed6a0 cx=c_pps
 a=ilQVyvKR/QcI4Z4wCA23Ug==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=4u6H09k7AAAA:8 a=U8VqEihZ4mKUUNuiy5gA:9 a=QEXdDO2ut3YA:10
 a=5yerskEF2kbSkDMynNst:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130058

I also created a tracker issue for this on the Ceph bug tracker:

https://tracker.ceph.com/issues/74897

Thanks,
Ionut
