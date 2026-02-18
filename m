Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621D2F261C;
	Wed, 18 Feb 2026 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771445067; cv=fail; b=mbF/Fgi62YtPv5sEjiHNJIQ6PPUJxKrsN7KhBk/YDurP4rfI5/Q4Cr1LGZvHibghwQdpGE6A3gnGHiL+22rMVM2yGJ49MGRXJG0WmRYA8Ydj1JXPGSI4KsuGQh7sjj/jw3nJr/3UxPfFDGPqvWTOwvoO65WQVrZCDabm30Pkwv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771445067; c=relaxed/simple;
	bh=9GymzLJtsMTX9zQvIJDD+CsRMUZj6klCns1Js905uqs=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Ck0lzQzjbbNahE8BVJxu1m5B6hu/GELHnDa0Yd3W7CqbLH6fNQKLHhnCyK+pROe0D1ZJbijPO3hwAKevppA0h39ra4bsbM1pTy0sBauFUGPEA9bwU4m2Zo7y5Gm0JgRBrrX74+u2Y7hQLxZqC7ecNZ0AhuLrGvo9Mg/daPcAnwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n50JYbKw; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n50JYbKw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IHm6rO1991245;
	Wed, 18 Feb 2026 20:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=9GymzLJtsMTX9zQvIJDD+CsRMUZj6klCns1Js905uqs=; b=n50JYbKw
	31+FigJYoYlj7s+94nVUMkJ9oGIfjl6Y7o5348Y1L6bCGgPItHDnw+hf+g7WJKEW
	LHc0LkzoREViBG4nC5lOOkI2Z53CsuCktstktmrGQBgw8SdPQn/ZVMvCYgtOsIOo
	BqGwd0BgWMgRukqeHf1FHtCvmyGbkZ+dLSOxxk5RlGpBpY4qDd0D+2VguzQnwJUT
	f1OqjkvPRA9IxIRkEP5Zqnu808fol95VNDVzPWl4XQzc1i2eKhfzoTL3rYwWzB2s
	Usu3Q12QNOtOESdMV1pggHL3XUD40I62+uO2sGYIzbEli5i4Bj49r8qaSvKOZ/Az
	OvELIJI/z54cvQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4khut7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 20:04:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIKZEjsY04jGNzlcgQhLGknjbb9mWPQhiJ0ZrDf70Y+8CfRC1xVFKCFH7+hDWSh6VCr0Tzd4T2+Tq87Ur3a1TndLJHJUYPosPzuI0ASoCumlA5j8iBjs1j4Nns2E56vKCrjWUkQg6SEZvzxxjDV5FEqPjV1auvaxbjZ27e/J6svi+0EQq0txwKB6+e/lf9L2pZ1t/67veic2HSk7HCYM693t/jjrawNPVwnCXmqXIHAxVmxsCBWFmG02jQoz+6LeOPkdv74R9Gk7BzcV0cRvhRde7RNNDhbc53+bOvZxio37LStEyV50WycCeASPMcDiUQky5xs4n3emyhMinVxAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GymzLJtsMTX9zQvIJDD+CsRMUZj6klCns1Js905uqs=;
 b=PvOFA9ABdJJ134G0/7ZbY5l2vapMCMANqVZIn/uatyz5IRxI0PFdCX0LvUfuxAmRr8+Z3CKtsBTO+mhFjWI+cpRv0toPBBHSMILzxVwr2Ibq9rnUF1wK3UEnz+eNDOWNwo1UB6124oBjSND+qO1VX3tXKZpsQPpZdJzgcEbzzHkDeU0LFjrgNBxDaidaPucbUzC5LBvcn9MPMvtLBBqVM7e3baFBs0eSVLr2dCzeuT/xKOiWHfZwfPbGkVA6FeeoaE5HuGRixVsXC7hBMRrTbcb0+PaeH7lhzTQ3JQhybhc5HxCJwRufPYc8/3wmc2luF0NWs/b+C9Pdc80lsvCZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS3PR15MB6978.namprd15.prod.outlook.com (2603:10b6:8:344::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 20:04:04 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 20:04:03 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "ionut.nechita@windriver.com"
	<ionut.nechita@windriver.com>
CC: "ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>,
        "sage@newdream.net"
	<sage@newdream.net>, Xiubo Li <xiubli@redhat.com>,
        "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Alex Markuze <amarkuze@redhat.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>,
        "clrkwllms@kernel.org" <clrkwllms@kernel.org>,
        "superm1@kernel.org" <superm1@kernel.org>,
        "jkosina@suse.com"
	<jkosina@suse.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: add timeout protection to
 ceph_mdsc_sync() path
Thread-Index: AQHcnL2tgXlJSMDACkeX8MuLfGlFGrWHdcyAgAFyYgCAAAHKAA==
Date: Wed, 18 Feb 2026 20:04:03 +0000
Message-ID: <aef4d7dbea2fe3301ac922a7a189ecc8c93314d5.camel@ibm.com>
References: <fe346c26386a4fc85cfa27e669dffd13191e7ea4.camel@ibm.com>
	 <20260218195738.49204-1-ionut.nechita@windriver.com>
In-Reply-To: <20260218195738.49204-1-ionut.nechita@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS3PR15MB6978:EE_
x-ms-office365-filtering-correlation-id: 2b685fcf-a5fb-4033-ddb7-08de6f28dd6a
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHdCOWtjZENGcVBkeFFVV2p4a090YjQrV3NDL2lWcWt3ZThsazNlekJlM2JV?=
 =?utf-8?B?VU9QYlEzQkJxVTJHRWdSTWFXdkM0OE85TnhiNWwxZmx4NU9ISkx6cDl1ZmtY?=
 =?utf-8?B?RHRCSW93NmZ1TGNTUm5pWFdwWHV6SzlZNnE3eVdhYmp0N2J5Z1c4M0F5K0hk?=
 =?utf-8?B?Tkx2L3czbktDSkYwZU5qd2xEeGNaazV5TnVvZjViZlRtdWVIcFNWMkJvK0xU?=
 =?utf-8?B?L05JNTd4U0hFOHZMS2J6NDhKT1EvdUxiYVVVOWV5TTBYb0JqVjB5NDVldVE2?=
 =?utf-8?B?dHdzbXpsQkdmL2ErMS9HU0dNVlg5RkRZcUNqWVExRmlhVENJSmtaNktnTjha?=
 =?utf-8?B?SlRkbkM2UDFGSlpiV3JvU1FXb0NuRWRrNWxhUVhENHdoeGZLUkJNOE5CR3Ju?=
 =?utf-8?B?MmZBNmJTNTNNbjR4Ri9CeUJmQUxsUURTckpFL1UvaFRHY1RJeEpjRzgrbkxm?=
 =?utf-8?B?RWUwdm9sMURrbjBHekRaS1VxdXdiRHpDZ0ZoWXhNNTZEeXloNkdvK1ZGWHpj?=
 =?utf-8?B?VXhoMTltNTZGaEYxY2tUOFlxQi8wTHFMNGp4Z0MvcWtTV2VBUDllZWdTQm45?=
 =?utf-8?B?MHhEQmprMUU4LzFXdnM5MUJteENSZlNPUE5zZitNWnU1L2lXelR1TDY1dmky?=
 =?utf-8?B?aGpwcHpNd3dwc1dnYVMzZHErVitlZUl0QW1tUkNlMExoQW1ud2tJdWFLNjZt?=
 =?utf-8?B?WDRCYTlXMk5pWC9zNktxOG1xSlFmdVEvMnNqMlhZU0N0MVQzZG5RZFZja1dr?=
 =?utf-8?B?NnVYbVo1UmRKVnFiQlBDdVRVYnFYY053L0VzaVhOMG1tc3lmdGZCR2Z3bXlx?=
 =?utf-8?B?a2c1Mi9jMloxUXdWNy84U2hqQ2xnR3QweUY3Q2NxN3VvRXM2dVpVNkptZ3k1?=
 =?utf-8?B?aUZHdStoangvK1oxUzZPRHFiRW43SDZjQktHMG9SOVJIT0RlK3Z5ZTRORjFS?=
 =?utf-8?B?d0ZXRU1kdnZSTlNBd2g0WXV3NFhxVFFURFl5SktaV29lZ2FHNXh6emQ5Qm5X?=
 =?utf-8?B?Y2xXa1VISkRyY0pHS2pjY3B0V1d6UDF3eXd4OXNDai9TbVJDcHdTOFNkRXIy?=
 =?utf-8?B?eXoxL2xTSTl0Ly9JYWZyOUtyVmJmRlZCcDdGbkdrbFpZZGZFLzNLbmJoNytV?=
 =?utf-8?B?bVlLc1RUZFBSNk5MaC9VTE1ITC85OUtvb1VObTFPY3RxOWk4UXhUdytJbGVY?=
 =?utf-8?B?ZTMyS1ZndjBjcGZ5clhRclFnK1ZVMmJlait2a2F6V0pyNU0zMUpPWUZTTm96?=
 =?utf-8?B?d1NKSnp4MnlSaXkxWGRMVDR1MTRFTkF2L1dRNzYyV0NsWE50aW50ajN2RFp6?=
 =?utf-8?B?bnpnNDRmZVZlQ0dacUJjcEV1R1ZPRGFkbzdQNWJGb1VLd0RKV2RtcEludFVw?=
 =?utf-8?B?L1BCYTE0RldVaFdXb3hFM1B4N01NdG8wSTJaSUd5Nm83TlpRRkhDYkMyZXh6?=
 =?utf-8?B?RmJFL2o5bEoyRmhUeU45T1RIU1lGOGV4OXJ5bmMyWWxqN29OaUZZTEJ5aWEz?=
 =?utf-8?B?MHlUVldvdWRLL0t5b0NuTU1uUEtRZUsrbXhNNTFVKzZiS09HeW1tdnpBVGFs?=
 =?utf-8?B?VDM2U0J5L01mMnFDN24rK0JTcm9ZL2d5eVNlQUlRVFlYUnRRR1ZVTjdvaFNM?=
 =?utf-8?B?VHRHS1JiVG1iWGpFdkh5RzVoOHMyQjFYYmQwN2VOblVQTkRaZU9BQVBGR1lI?=
 =?utf-8?B?SHFFWTduVWtDMkxpWkZtbEt1Um1mcnJrdit1TUJ5REpQSUZHYTcydSticElk?=
 =?utf-8?B?dUdkNkpYa054ZDcreE8xT0V2eWF6dWpGRnB0RTZieVJENFM5ci9qNTJSMHBt?=
 =?utf-8?B?MjhYYTcyZVFHNmJkYklIVkJkc1ZXZ0hod2FYYmNBNm42dUVKWG90RHd4SXhh?=
 =?utf-8?B?STdPSzRtZUtyWkI0bkpzTWl1K3BtSWNaWWdCRWhFMW9MYVIxT1duRlBjeDVH?=
 =?utf-8?B?Nkd4RG1DWnRxTWdocmxMWGpBSUFRdlNsVHljRnN6QmxwMGpqalkxOEdKNzd0?=
 =?utf-8?B?WFczMkhaMlUrL3lnVTJHYUlPT3VCdXpiUmc1c2ZuNHBQZTdob2VqRlRCcGox?=
 =?utf-8?B?VkdWQVRRTnl0UE1DUHlsdm4ycXVKemFGR2UwTXcvckE1ZUdOc25oclFlWUZH?=
 =?utf-8?Q?8ypLDUW8fdlkJnDZ1mfp+C0EJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0M1cnU4SkhvSm42SGdMelVUbDV6WmpGbnBQSGt6SGtsQ3h2RndSRHM5MXVN?=
 =?utf-8?B?YTBCSlpUVG1MZVAzZmdvWmJab1p4bFArd0VFRFVXRmZZRE1zWDRkZi9IMkVW?=
 =?utf-8?B?YnhjOWxwVU41M2ZkZXJNaGhIbDdvR2Z3elBHU0E4WkxVM1RrVUNKK3FjSzR6?=
 =?utf-8?B?ODkvYmFVMWpXYW84OXJGNUNkU2RXTTNBN1JmS1BnV21lcG9lTFIvUnUxNzFv?=
 =?utf-8?B?dTdwazBDbXNiMUxZS0RVcy9sTmEwdkJlV1BCdkNwMURhTUtmUE1pUUVoMDB2?=
 =?utf-8?B?TFNDaTc5WDIwRkdJUUNJUFVqai9Mb0JCMjYxcklCckZ5cjR1U0IvVU9IU1RW?=
 =?utf-8?B?N1dkMllsbzZaUmhrN1VUcUwwRnRVaklSNktraCttRjVwZGhVK0NQZW5mOUZ4?=
 =?utf-8?B?ZVNPS0cyZllNTnFNQlQ3MUJHeXQyQytFYVF2VVVlWnUzUXhOTFN0UWV1R21J?=
 =?utf-8?B?cVQ4amF4SHl6dE1jTFpMQzBYLzF6MFcxU1FicFN3VUFmOFNRZXBPWHVndU9P?=
 =?utf-8?B?TzJ6Wk9ObGQxbUV2aUV2ekd1MmNSMUJETi95b3NWNkJndkIyeUk5TmRhOHk5?=
 =?utf-8?B?TWJnZjdRV0FKc09HNXdoVUhpT3c4eEVENXpCVnJrLzJlNXVDZHlWOUgwekdx?=
 =?utf-8?B?L0dkUFlLditNdW4rS3I4WldZcHExenMvSEczZlBIcEZKeHV5U0tFdytiYzU2?=
 =?utf-8?B?dWlueldJdlNqWE56aStsdDIzWTArd2VzWWRsdFdWOHoxcmsrdExtd2ZTaXR3?=
 =?utf-8?B?Z0p2RUF3VG4wVndSTzh5bHlpSlB3NjRJUzYvYXFlL1F4Yi9rMVZydzlyZTM5?=
 =?utf-8?B?VFkwOE9CQ0I5WTdNZEV3aWdYZy9HL3ExMXkrZDFva1hiTzA1NElHWGJIRW1a?=
 =?utf-8?B?R3o0aVhKMTBBQnF4YVljZzEwYVk3SXdseCtabWszVjVUNUpyMi9BaWFxblQ3?=
 =?utf-8?B?RnRTSnNwWW1yM09XcHYvYWJ5VUx6WnRsRDdOWlhzVlBLWE1ORnd0dG8reE4v?=
 =?utf-8?B?Sk1pUVljUXBrVlA3VzladnFMczRUK3pvcnU4ZDFHc1owMExGczU1VnFPT005?=
 =?utf-8?B?RmhobmFMaWkxalVQaEpKbkVyTGpDSnd0VTZXSEZpd1FhSmVrYVFMWXJYS0Ni?=
 =?utf-8?B?T3M4R21qV1VhRnRoeVl1ZG8rZW9BbU93U3Z6L3RQVUpIV2FrdnRVK05aVlM5?=
 =?utf-8?B?dHVBRC94RW1mTCsrQ3BjaWNpczEyU2NITmV4emFyckY3NnpkRUdEODB4Lzhx?=
 =?utf-8?B?bVEzN01WOXh6eDlpWWtrUHNkNXRsWXZxVUh2RDBRZlVXVDNRbVZud1phTWdE?=
 =?utf-8?B?ck9JRExBMVkrbDhqNFRIejJYU2xpZjFzeXdQTTM3RmJwYnAxZlBsaElKQTRx?=
 =?utf-8?B?ZjIwZnZXWm5pK1NlMVJPN3lGRHlYY0ZBWGhxWHNOWVNiaytMOERVcm1zQ2sy?=
 =?utf-8?B?MktSd0hSOGNFc2RvaENvdlY2VjA0WnJYYm5GaG5uekNZZkpadDVJb1NnZm16?=
 =?utf-8?B?bU9zWWJDV2xtTkpMazNmQUZtbjlyTFBnZ0FndGlPV2Y1L2xEWDNpazRCN0I5?=
 =?utf-8?B?RFlUTHRja1hPSFdDRHhwSnBpMktxck9mMXVXRjdaMWpZbUlxWmpGQjJicVJt?=
 =?utf-8?B?SDlzT0NCRXBRNUFEekZOZDFkL3R3V21QZG53bmxuekJmTTI1WWZhWVlpNFg2?=
 =?utf-8?B?TDdKbGV5dGM5L0g0OGpmcExRZjE1eCtGTThQUkV1ZDliY0pCd0pjbStNZmdl?=
 =?utf-8?B?VWdCWEdpSGxLSkZidVBHRHBGRmdBeW1IVlhPMnZzUC9FS0grdlNUZCsyOVgz?=
 =?utf-8?B?K2J2WjlVUXJuSnhFYnNYUVpaWG1ldG9zbi9hZnljc0R2SXVZUis2RGc1bGZ1?=
 =?utf-8?B?bDhZL1RjeEh5RTB4ZmQ3elpNb2wwREZZV0VmTXlxazNuQVpITmE4VmVGVVhN?=
 =?utf-8?B?TDZEQkJ3aHB0ZzQ1dXR2c2xHL2tOdnBDcGlrdCt5TDVqVjR5cDBPWXh1MVMx?=
 =?utf-8?B?dU1YcmJaYXpqbm9pSWpPNVY0b2tXK3RRZU5wUXdBNWU5a29pVFlhbk5sSE1r?=
 =?utf-8?B?YXFGUlZLMWJvc0hDNW93TmZHMlZMVlFyL2dZbVhNalNnT2UxNU5jcFBPMzRJ?=
 =?utf-8?B?VXI4eEFnVFVNY0JNelVmNmxGZ0ZpS2hTdjFEMjBDUlNlYTA5aWRjRVBUUGxI?=
 =?utf-8?B?MCtKckUrd2FBT2dXbkUrUzFMVVgrdUQvTnVibGlaR3NDNHR0RjR5NC9XYnBH?=
 =?utf-8?B?R0Yrb1QyTHZuczRQMEtBNTlVVk5Sb0NmUFV1c1BITEVpOGUxeHVzOVQ4QUxM?=
 =?utf-8?B?OXFiVFdkbVRzWFRMNXNpVUFUVWRteTV5QjJmSjdIVHA2QU00Q3ZYQm4yOEFn?=
 =?utf-8?Q?fMztgWCGgo2G1umc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0220B1F4DDDA964D8E4651E76BD68DC0@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b685fcf-a5fb-4033-ddb7-08de6f28dd6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 20:04:03.7021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thcM+ID0sWNDVi05ReDdp4QqmLqDhEuV4l7BtgE4BNL8yHVCvBMT6zfE7ykNqQ4HUsVl7+NsxrkpyeFJVGGXOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR15MB6978
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE2NyBTYWx0ZWRfX5biu9x/83xHv
 nm/hG1I83l6dPIJ1wtf+Oa+RUBcLRRG8FbjfqyvZMe7lGVZfqH1GDtMzSX4UGodTh3bMDVYyzKJ
 kHPSELCRQoq+T+abS+LpQYpYvlDhtdGgfYu0h3Ia/TvzF6DwjS5B9aP19tBhNG/x+Xl5t11Deme
 RKQ9kq/13KBzuySiVRveW3ECMA9a7Nu4K/bMVkfS25GBsQ7ckg5dhILxoA3BM9RgfTWKre4krZu
 X02pc42+Glpc9L/iclUXUvX1WaZz4GXYx6VTdSpOZA+elZ25t7CabD4MizSHXX6kif+7u/EbeWe
 O5kuN07DQlcXHCNaYnapCN9Tt+J7OmgP0m8fYLhBGavOT5yEYh2sVqq4Jf20CJcemewDLfEhEGR
 SfDyUsPYDgu30lkgpEd5Ne+SwdNhARRkPd8lGSzD6J+1xBArRfIBOq2eW2oNj2Kld2Q1HFE/GoB
 wuTdmq70dUdxY2PCw8A==
X-Proofpoint-ORIG-GUID: 9RFB8bd3ke6vBok04R22AXSv9tooY2pq
X-Proofpoint-GUID: A61Ou_23wM8WYB_kj_cv9IU3IP7l3MxA
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69961b37 cx=c_pps
 a=mPJaQZadrGlgYT55Vo1ogA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=4u6H09k7AAAA:8 a=H0R6jeImuaquIYV4xn0A:9
 a=QEXdDO2ut3YA:10 a=5yerskEF2kbSkDMynNst:22
Subject: RE: [PATCH] ceph: add timeout protection to ceph_mdsc_sync() path
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180167

T24gV2VkLCAyMDI2LTAyLTE4IGF0IDIxOjU3ICswMjAwLCBJb251dCBOZWNoaXRhIChXaW5kIFJp
dmVyKSB3cm90ZToNCj4gSGkgU2xhdmEsDQo+IA0KPiBUaGFua3MgZm9yIHRlc3RpbmcgYW5kIHJl
cHJvZHVjaW5nIHRoaXMgd2l0aCBnZW5lcmljLzAxMy4NCj4gDQo+IExvb2tpbmcgYXQgdGhlIHN0
YWNrIHRyYWNlIHlvdSBzaGFyZWQ6DQo+IA0KPiAgIGNlcGhfbWRzY19zeW5jKzB4NGI0IC0+IHdh
aXRfZm9yX2NvbXBsZXRpb24oJnJlcS0+cl9zYWZlX2NvbXBsZXRpb24pDQo+ICAgY2VwaF9zeW5j
X2ZzDQo+ICAgc3luY19maWxlc3lzdGVtDQo+ICAgX194NjRfc3lzX3N5bmNmcw0KPiANCj4gVGhp
cyBpcyB0aGUgc2FtZSBwYXR0ZXJuIHdlIHNlZSBpbiB0aGUgb3JpZ2luYWwgcmVwb3J0IC0gdGhl
IHN5bmMgcGF0aA0KPiBibG9ja3MgaW5kZWZpbml0ZWx5IG9uIHdhaXRfZm9yX2NvbXBsZXRpb24o
KSB3aXRoIG5vIHRpbWVvdXQuIEluIHlvdXINCj4gY2FzZSBpdCdzIGNlcGhfbWRzY19zeW5jKCkg
aGFuZ2luZyBvbiByX3NhZmVfY29tcGxldGlvbiwgd2hpY2ggaXMNCj4gZXhhY3RseSB3aGF0IHBh
dGNoIDIvMyAoImNlcGg6IGFkZCB0aW1lb3V0IHByb3RlY3Rpb24gdG8NCj4gY2VwaF9tZHNjX3N5
bmMoKSBwYXRoIikgYWRkcmVzc2VzLg0KPiANCj4gVGhlIHJvb3QgY2F1c2UgbWF5IGRpZmZlciBm
cm9tIHRoZSBvcmlnaW5hbCBJUHY2L0VBRERSTk9UQVZBSUwgc2NlbmFyaW8sDQo+IGJ1dCB0aGUg
c3ltcHRvbSBhbmQgdGhlIGZpeCBhcmUgdGhlIHNhbWUgLSB0aGVzZSB3YWl0X2Zvcl9jb21wbGV0
aW9uKCkNCj4gY2FsbHMgaW4gdGhlIHN5bmMgcGF0aCBuZWVkIHRpbWVvdXQgcHJvdGVjdGlvbiBy
ZWdhcmRsZXNzIG9mIHdoYXQgY2F1c2VzDQo+IHRoZSB1bmRlcmx5aW5nIGRlbGF5Lg0KPiANCj4g
QWxsIHRocmVlIHBhdGNoZXMgYXJlIG5vdyBhbHNvIG9uIExLTUw6DQo+IA0KPiAgIDEvMyAtIGxp
YmNlcGg6IGhhbmRsZSBFQUREUk5PVEFWQUlMIG1vcmUgZ3JhY2VmdWxseSAodjIpDQo+ICAgMi8z
IC0gY2VwaDogYWRkIHRpbWVvdXQgcHJvdGVjdGlvbiB0byBjZXBoX21kc2Nfc3luYygpIHBhdGgN
Cj4gICAzLzMgLSBjZXBoOiBhZGQgdGltZW91dCBwcm90ZWN0aW9uIHRvIGNlcGhfb3NkY19zeW5j
KCkgcGF0aA0KPiANCj4gSSd2ZSBhbHNvIGFkZGVkIG1vcmUgZGV0YWlscyBhbmQgZGVidWcgaW5m
b3JtYXRpb24gdG8gdGhlIENlcGggdHJhY2tlcg0KPiBpc3N1ZSBhdCBodHRwczovL3VybGRlZmVu
c2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX3RyYWNrZXIuY2VwaC5jb21faXNz
dWVzXzc0ODk3JmQ9RHdJREFnJmM9QlNEaWNxQlFCRGpESTlSa1Z5VGNIUSZyPXE1YkltNEFYTXpj
OE5KdTFfUkdtblEyZk1XS3E0WTRSQWtFbHZVZ1NzMDAmbT10eThnUjRPanJ3RlhVUVBqRzlEbTRF
YXB6TzRId3lqN2FBWDZJTnd1bEpZMEdqb1UwcFRmN2toWWtYd3Jrc0RUJnM9M2ZPWDhvNG9kMVRv
ZGhKdzhTSENOalI0aHVYSlM2VnNSRllENjc5MURXTSZlPSAgLSBpdCBtaWdodCBoZWxwIHdpdGgN
Cj4geW91ciBpbnZlc3RpZ2F0aW9uLg0KDQpGcmFua2x5IHNwZWFraW5nLCBJIGRvbid0IHNlZSB0
aGUgc2l0dWF0aW9uIG9mIGJsb2NrZWQgdGhyZWFkIGlmIEkgYW0gYWRkaW5nDQpkZWJ1ZyBvdXRw
dXQuIEl0IGxvb2tzIGxpa2UgYSByYWNlIGNvbmRpdGlvbi4gQW5kIEkgYW0gbm90IHN1cmUgbm93
IHRoYXQgYWRkaW5nDQp0aW1lb3V0IGlzIHRoZSBwcm9wZXIgZml4LiBQcm9iYWJseSwgd2UgaGF2
ZSBzb21lIGlzc3VlIHRoYXQgbmVlZHMgdG8gYmUgZml4ZWQNCmFuZCB0aW1lb3V0IGxvb2tzIGxp
a2Ugd29ya2Fyb3VuZCBidXQgbm90IHRoZSBmaXguIEkgZG9uJ3QgdGhpbmsgdGhhdCBJIGhhdmUg
dGhlDQpJUHY2L0VBRERSTk9UQVZBSUwgY2FzZSBvbiBteSBzaWRlLg0KDQpUaGFua3MsDQpTbGF2
YS4NCg==
