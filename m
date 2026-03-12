Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0683BA240;
	Thu, 12 Mar 2026 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303431; cv=fail; b=Sc/EglZCL3EPs6fSmILpkJF6dG/HPRxWwo7OF3VOXmfcWPryVn5NrsKdULyeHdZfFKhKbqVpDCPG7GBbZO13J+qw+gZicn95U35+hYbK2iBok/aQHGgCdJMl3S6nSiMHIIzJoesPwo9aBh16Q9AQojHJa4vAK9/J7kKdGt4hhT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303431; c=relaxed/simple;
	bh=QHNrVwQwX4HaNjPNWkgKvo6VnbZjw1VQXi/C5dzr3uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F1N6zN1DVL7BoxR89KDL1uO2DF/Mjtp7mwxql7iNQPQfXkVQCAOZC1Ak1tKJKU++PwG/M6bB+URKasnG7qdrbi25VT4DEqwj6NyI/YKeETtN6NRqKoe33rVCCCAKW3mphBwvmUQbGGdXhwYDcuNYLZsQKchZ8STVCaL3TyYknMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Rcj8qE9t; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Rcj8qE9t"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C6vxZ51862126;
	Thu, 12 Mar 2026 01:17:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=LiQpYqXKDi/2llVuJXhkwAjxLgXyyHX5InmYxOskjow=; b=
	Rcj8qE9ttCWWmOcfOgE6fYUs9MX6bZnIuk1pOKeMx0Oy+w5v/A1+yDK+DDVXeykp
	rLVOrW6XutBqJBxcO1eFsxnIslvUhoKP0eAqXNs8hbiuiF8WdwbFyIK4v97SjoT+
	HW6XzYVcwz61iXTwLkVFT6vSSya8bRWieNGTYk2N4kKgpYUZifwD5OP9M0ES043D
	XwZkl72Y4keFvK76kKlrsiPF9ciCT+AOGdCnXB/yjiEZRCuWZiOc1BYBYCzBQlBU
	heFk8KU6Znew82P+sKaZqFypivvl088gdXPf9UQ1vWcbFejddtw7E3o1xWv+dvFU
	HIMfhOrs5E1m/dQF5cxbmQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012011.outbound.protection.outlook.com [40.107.200.11])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh6prenc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 01:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDUTRFq4sbP1BzNMScmYIG8ou5QM8K5yrwLuCrFH/B93/7SwhaBQK79/VbLVQOPhCH//Bf5AaVm7eRHckMaLwoLs5z7nWbNACA/AX84a/o8oQ/V8cI7fJ7xqf8FN/J1sBXOQ5MbRY/jP5ToXHMkFHGSp8hxccLyDrgKuBaQEjnue+s6cG2lGEtFtK+EFiLVDclT9HZcrf75o3CJvJpQTOBPslYk1adwyTKY7tJ3hKDvXOgKzlsEhP+krj+aC9cUe/b4bi2fqAcr7vHojX3EoqVeCON6BrFPY2hwW6Egpfz198HTJ8Z6pcSLIhMqV0ZEUnkCwTfhyH6xf0pYWkc1zuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiQpYqXKDi/2llVuJXhkwAjxLgXyyHX5InmYxOskjow=;
 b=L1O0J+awLJbHFgB51N6+Bir/StidTQUSWxfmeuUGYAUhNFlamm+em5d+5SGsn73xgjqbfUOardgyQ6d6Du9Ml9GIyMnlRjLuLwD5hte979vJ3HhEFfWUmouDdcNCPWLpG9kwkkfJxkYuKUdKf1UgzJakBsrXl54UAs2RowwL5hepu6UyTi5HFLBzzJDBUq5FQzpmuUtlmVBlk59kEawO4VZ4HM6PU7AacpJO84OIMwJ67kJTk23X0J15lplNcQqmeg31na+I/tTgCH+Awo+rOWJ1n5QSSRF5NGRV/G2Hzs7/dCShyXWWQg5Oc0L+3Me3nS+Otnplq688VgRTMD3nWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 08:17:04 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:17:04 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 13/13] libceph: force host network namespace for kernel CephFS mounts
Date: Thu, 12 Mar 2026 10:16:19 +0200
Message-ID: <20260312081619.40854-14-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312081619.40854-1-ionut.nechita@windriver.com>
References: <20260312081619.40854-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DM4PR11MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5fdb2a-5172-457f-de05-08de800fbea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|10070799003|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	axxEeYYgTye5GLeExWcKDuFSv6sJW5La/uzo37N7olYkGERumYpdodDeFZKjwRVkCLOh2z6buD2YyzBc72d5K7QMOMjS4Wko9f0RKZZKiUQFZkhJlGOqKe5jb8hZjOVYIQiWiPfYTqKaWb/TDuYDbudbeSnkqAWyVuYqCBMi/MVdoMQep1P9ZgMC/VUGFrS9l5P64LkH3pMvilOy6BNKCM7EcGvDhq+O1XSs1D4lZ/ldB4yozk2KDK9tmOKvpJexTUZy0IBKwqET7oJLVLkKFc/HtPrHyu1ET/GYWKsBdfE6sGmY/poUYWh9NEL8mgPcCKFMLKyX4KiGUoG3Ubeh/7f6VJunNqLsjSyipFBy+3Qr6YoQhu3hM5ntSAIcolhpIGGQDgx1LlAj9HSHFBXmQU8ul4YWmwUVHREdO346raicYsPGVSnmWs+oGaeq9kYzor8lb8CrzvLOKHDFs4Dcc6wmLNFxqodf67iEsdDBsxHC6YRFwHucYnSiuybV/XKH0Jd6okfsVMI9Q00+V7a30LWrD8GARdQgZUv9C47usjB5cLueZoMhF1eiNn+zdrzf9KgbSamcWiyn4jlmLcaE17dmwpNtbcdOGKRpG+el6eM7y9WapztOatjfGuromeryyARaP4wm0me2rvVNedB96PuVnBXqfQZrUbCtKbPMhHUov+59Ra7jew4qlrBhnlQpKA4000iygFxVljSrGcJWP5gujU+/MfZSMNQRJrmEezI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(10070799003)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?92uz2562oSXs/sn0fI/iO1YM8vLRmoRgu9eVo2iUTb+j95rsqvQZmJmpgMAV?=
 =?us-ascii?Q?JRdfvrgcXKJzJP1ZiEKuHnR9ck6f2z9gVUIhGKevAr2IHxNmyo8ND0Sgaown?=
 =?us-ascii?Q?GyCwdKghBXIMgFVhuiWWXOZqV97YD3BgN9jpgTJ8n0LggqpOXXPDmazvT1UH?=
 =?us-ascii?Q?kKyF4wcE5NjRGd9ngIt67jmkwdSssaeXUJYdzMj1qowDooc+Okt0Z/Ocy7+a?=
 =?us-ascii?Q?ppFmzZcRrys4cQJrYrplCt7EkvFMiCd2zwxX85Qv1eHfeATxlr+mOJ/zTNH7?=
 =?us-ascii?Q?ljElQ+8+1Hz10KFZhy7xoqhgNoumsptW4m0bP0VM2043lQLAe5lTNzfZMn9a?=
 =?us-ascii?Q?UDs4dVwH5APpYDfi9Na/xk+2bSfPXVHTTeDvzrbwAxH8aqtY1xCgHpGtNOF2?=
 =?us-ascii?Q?YdmjZ46K2MDo2gxo9KnkbgpIw2OpaK1MSLr9qXb7u/kjXlxotPuZooX+tMx8?=
 =?us-ascii?Q?p127/mJk3lAaHDq8+ONZkM950JT4a4OMauo3/PhQ4CUv1+8W2e4p3B6pecST?=
 =?us-ascii?Q?almjz2AlRQTZFH+aX0JmUKTYB1imfHOiwi0H81enAWGqh+XCjVMCL6/BpGmn?=
 =?us-ascii?Q?h2/dxFYcrdx466hYQNdm59hBUZxGAI4+6SUuW8PUCCNUocyQGxEvdnWp3ebP?=
 =?us-ascii?Q?rpZHYZm73khvZ19f2snFZSomhpdZe3tpSriEwP0Ev6XBtqo7ns57l1Nz3CbF?=
 =?us-ascii?Q?SapLmDSi6fhX4wIlXqJzIeIOwIRh3G/Q2V6AHylVcNDQ3Ducc9lGPC4XPUf4?=
 =?us-ascii?Q?MwIWW++YIuV/Xhx6dSxO+TAgRD98z+EEtpoUKPf1nNoi2CBBC/zPmJiYCJXb?=
 =?us-ascii?Q?ZQw5owXnpNBKzrN9wWIz3TKq3/f6wrO5RFiQgM7ysscPWDppFzsY2P/DIwz3?=
 =?us-ascii?Q?BlQm1ofsoudwwnZoLQUOG6Z4NuJm6OeBZ6e4c93qtOwnwEXBlIJESPszRVf7?=
 =?us-ascii?Q?maeH2qTnXc4f99LHKux2ABhiMxNNYuWVrOMF49gujZ55+KZBtPrdtmCLKglX?=
 =?us-ascii?Q?zB8XYp3/ebmEgfDcTcQY36TT4qzF6NtOGnBxcgynQDOXiy5TRaId+2YHeJ6T?=
 =?us-ascii?Q?dflPrcFPq9qSfwDIUdZVfDYPU5Yx64SI45HVChp4X9eNHiQCJLxyYpboEd8t?=
 =?us-ascii?Q?t6gAEUhqUyBAkIHh5yeyFqd7ArqzfEQZsPf+in44f2gwgRMelVhd2N5YFo8T?=
 =?us-ascii?Q?pFYIWeifq2kWthk9Qo47HT0CW5K7WwDQsmMAnhdzvqfMsZ9vdD3tBsg05WHm?=
 =?us-ascii?Q?JjEZ/3bUVckVEbDhfFp9DCrYTNsatXys+3AJNzc2ctd6jEwe5bHj97dRqvjs?=
 =?us-ascii?Q?jnjQHzFfyoVmYtSUIuCFAlaRJ0usYuChNl+rr4XPtljhCPsa7/aU33Ik36at?=
 =?us-ascii?Q?zo92lM2jbRtdXxbTqsxeU4p29kv19FMMZW2nGsBn0SXB2oG1Ql2qTtUhlrJV?=
 =?us-ascii?Q?WD9PCMGXYRar22RRCrXnxgKEdY40JHLmk8Pui8XcLx1EHXFYLsJiEUPOT+/a?=
 =?us-ascii?Q?KP+jgviqYudsrtAPfXXeBzwZga+oAIF9bTBpjE/LD6NKKyiLFSZBg2O8fPoI?=
 =?us-ascii?Q?fGMldHJtyCeKzYdd4DYy7qw70p1zCH/vAcOmK3o3SEOf400YKokz3qTFZTt0?=
 =?us-ascii?Q?MtB8gOF3vSdnPYNezVg8KksMZwQexy4i9/lK/9pLOhZRfatU8SsZupfo+jaO?=
 =?us-ascii?Q?r/ri9toNJpo2jzPbSKodycaGq2fZ/FCZLGpuOICDFLRD92SOr0tcyPwCVDRe?=
 =?us-ascii?Q?QqaFPJnTcVhZ5Ff4QTSM1OcHVNKM9+SXdDKkNp7izxtWNk1y49TFZwrFYW6H?=
X-MS-Exchange-AntiSpam-MessageData-1: VVmsx9V182pT5ljz/3JUbKaYz4ncw181VNM=
X-Exchange-RoutingPolicyChecked:
	nfFQDHQ3xedMeXjRqfxoDyc4C8aTJqWLShcoEvJwIXyEZ5xcitZI3MbT+FKh6X+1blwg+j3eU11sNcsMzTyV/bq0+Vsa6u4HRJ1TSi4fjk8EeW08SJWRI69ckdJjrOhEm9JlENzu/hCyEaIBl0LZ9bD6Mc6K6Szm4PQaJT4Ay1mDIDKjRB1+pTLQ/ibzpR61+/zpv2AW2Ck8AvUUY08FJ1MCK/sZ8SQ8Whduc6Arl7l3ghawE1Z7soHTzBy19YpC2ZlsD5WRIosyMQXmBxXywb4IhusY+bi9qoi3vAY7pbsb9Nh9Ojhr6H+9tfUA5/k5XT+VSLk2u8yXiTp/lnoEVQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5fdb2a-5172-457f-de05-08de800fbea2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:17:04.5992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOPiVDo7ItTfcxPtuwPjCKRJ6Q5yCPHi0f48sEXYk5WwYHgpg0q3pUk+ecJFQPCsyFmaB6i/wmnXaD1eKvjDjqJ1QNxH2Y1NaV85r3qvhSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
X-Authority-Analysis: v=2.4 cv=ePAeTXp1 c=1 sm=1 tr=0 ts=69b27682 cx=c_pps
 a=la37NW5KtsdugurppmDlYQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=oitQaU9eZ9I-RMSOPSMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 7aq5eubD8_-o2F6PFIUOSVlpSYuwF5zj
X-Proofpoint-GUID: 7aq5eubD8_-o2F6PFIUOSVlpSYuwF5zj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfX6s5Eg3NtZ87w
 9Rw3gSu03+Ug0AtCz96fG4iDANh4nPzX42E5ZmyLazinMs+910HzE4eLqoAwEVuzmiagFt0ARsn
 qyvDTwQEu8A5iOyCHZ+vZYoCJdCAxEywhdTRQGCPLbiGtukXyD+hOzaclryC8xyqGgqfj6Wc1GG
 Q9tXf4zm4Mp+NDdO0wrUZvBw1jhvQHUgLyRM7As27h9s60CMPGw7QYXiNhIEePZ1gaCD1ZEKJoZ
 wNR6pr9/HZnEcVUx9jAToG0CK2ApBPra4TPEL483wQhD3cBy14Vd12VoTIUr3528N53cVP9hv+1
 Hf/ABjS0JLwZwCgkn1LGOC7EtsZ+W8uc7UIYtRAAoWW3ndRjBik3oLAZwMyFYOZZEoiW9mFnLuu
 hGPMV4R3leO14kru9xKqdV9MVVZ+Es6r9oFHPd7h2hgSTyazRtjrl/lB7DxYdguA0FdvgzTuIpB
 AKeFZlprNueh/Di9YDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120065

From: Ionut Nechita <ionut.nechita@windriver.com>

In containerized environments (e.g., Rook-Ceph CSI with
forcecephkernelclient=true), the mount() syscall
for kernel CephFS may be invoked from a pod's network namespace
instead of the host namespace. This happens despite the CSI node
plugin (csi-cephfsplugin) running with hostNetwork: true, due to
race conditions during kubelet restart or pod scheduling.

ceph_messenger_init() captures current->nsproxy->net_ns at mount
time and uses it for all subsequent socket operations. When a pod
NS is captured, all kernel ceph sockets (mon, mds, osd) are
created in that namespace, which typically lacks routes to the
Ceph monitors (e.g., fd04:: ClusterIP addresses).
This causes permanent EADDRNOTAVAIL (-99) on every connection
attempt at ip6_dst_lookup_flow(), with no possibility of recovery
short of force-unmount and remount from the correct namespace.

Root cause confirmed via kprobe tracing on ip6_dst_lookup_flow:
the net pointer passed to the routing lookup was the pod's
net_ns (0xff367a0125dd5780) instead of init_net
(0xffffffffbda76940). The pod NS had no route for fd04::/64
(monitor ClusterIP range), while userspace python connect() from
the same host succeeded because it ran in host NS.

Fix this by always using init_net (the host network namespace)
in ceph_messenger_init(). The kernel CephFS client inherently
requires host-level network access to reach Ceph monitors, OSDs,
and MDS daemons. Using the caller's namespace was inherited from
generic socket patterns but is incorrect for a kernel filesystem
client that must survive beyond the lifetime of the mounting
process and its network namespace.

A warning is logged when a mount from a non-init namespace is
detected, to aid debugging.

Observed in production (kernel 6.12.0-1-rt-amd64, Ceph Reef
18.2.5, IPv6-only cluster, ceph-csi v3.13.1):
  - Fresh boot of compute-0, ceph-csi mounts CephFS via kernel
  - All monitor connections fail with EADDRNOTAVAIL immediately
  - kprobe confirms wrong net_ns in ip6_dst_lookup_flow
  - Workaround: umount -l + systemctl restart kubelet
  - After restart: mount captures host NS, works immediately

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 net/ceph/messenger.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 8165e6a8fe092..a2e8ea6d339c9 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1791,7 +1791,32 @@ void ceph_messenger_init(struct ceph_messenger *msgr,
 
 	atomic_set(&msgr->stopping, 0);
 	atomic_set(&msgr->addr_notavail_count, 0);
-	write_pnet(&msgr->net, get_net(current->nsproxy->net_ns));
+
+	/*
+	 * Use the initial (host) network namespace instead of the
+	 * caller's current namespace. In containerized environments
+	 * (e.g., Rook-Ceph CSI with forcecephkernelclient=true), the
+	 * mount() syscall may be invoked from a pod's network namespace
+	 * even when the CSI plugin runs with hostNetwork: true (race
+	 * conditions during kubelet restart, pod scheduling, etc.).
+	 *
+	 * If the pod NS is captured here, all kernel ceph sockets will
+	 * be created in that NS, which typically lacks routes to the
+	 * Ceph monitors (e.g., fd04:: ClusterIP addresses). This causes
+	 * permanent EADDRNOTAVAIL on every connection attempt with no
+	 * possibility of recovery short of force-unmount + remount.
+	 *
+	 * The kernel CephFS client always needs host-level network
+	 * access to reach Ceph monitors, OSDs, and MDS daemons, so
+	 * using init_net is the correct choice. The previous behavior
+	 * of capturing current->nsproxy->net_ns was inherited from
+	 * generic socket code but is wrong for a kernel filesystem
+	 * client that must survive beyond the lifetime of the mounting
+	 * process's network namespace.
+	 */
+	if (current->nsproxy->net_ns != &init_net)
+		pr_warn("libceph: mount from non-init network namespace detected, using host namespace instead\n");
+	write_pnet(&msgr->net, get_net(&init_net));
 
 	dout("%s %p\n", __func__, msgr);
 }
-- 
2.53.0

