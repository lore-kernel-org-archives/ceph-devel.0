Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76F4C92;
	Sun,  8 Feb 2026 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770556952; cv=fail; b=G18mzYMXyRla0RjJXcFrQX05Ei6A2BW/oLxN5Ky9uL5y54mD2gP/H7jrlXbpZiRMVAjB1U+4SpnLFV+MG9chhw4W0IuZwK62WC7NGBPhDC2tgbqMX84zN+gcV5w9SsV7LZ9Mc5Tk8PR/TZ1vYfnS0T/l8s0CxIwTAETNuMFG5HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770556952; c=relaxed/simple;
	bh=0bDLe9qYRB4DRQE5yGjGKHgBeMrNbGnRaDgkKzUvKg4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RZWBT8dXKfUrlbXYrDU+t6++1DUdLKvJEpXpc/51AzV6VHelfvhFtIpeBKhfBFOOXWvcYwEqxY0NprtBxbdCXN+EXk8S8w3lFo5l2Ftj1hIL0kZQVuWbZRTKqXalLPTgY6DqfRmoFpLaC/wmFyxeSQtUf3pREtneH8qd9nYr0z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=eEfEK30z; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="eEfEK30z"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618DGQFg1528225;
	Sun, 8 Feb 2026 13:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=sOi/HFMzK
	SDwNAg3oAfueNUKAISuphC5+sUF78lOo5I=; b=eEfEK30z7JdfuaSAEz1Xhhpii
	Kw17y568MYGkxU/px/4NL3hBKyfHxvajcgMOJOEFFIY/ZUY0IrWTofk5Rhy0wRNY
	DXc/CUMdS2M3szcuzgjyo2LwyC6BiJ4YANkkoXgjrKYBE+Ytx1D6kGfnmBQtmlE/
	0gTcZFJNAoksAwhwPgAQGv6gDc7gdIkjbEgKiVBzLvElIVX+g1dBA2eZLhWB9IeW
	jiw5tU3bD8WHZacrtb5/QS1ej4U6p+SGSS7h/+8d9xuSbYsnCYdwvL+rhzrDHVn1
	m6CU15PIrYrHT3gJUOFl46/dgDG/omIyXrIdDKTEq+CX0azRN0psBvjAnhKEQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c5tkwh2f1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 08 Feb 2026 13:18:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zi/oiwoMlVAt0uvmt36karB6D9AWX2lc6KyuG6+I0wGknkE0GBxWr1brzzM5MHCY+1jX1RSdxF5KKuzRAXaw6BaO7+RKEApC8zNB5078IxTBx0smU1ZwFvoODWJNRQJA5NUWaWRpcES77o4383BMhjNZJ5tlMYqdb1g3INuqFiNrI09cVvHQRbm+6jN6gOdqsbE0gcIWdmZ0v3AwcsC7kgNnVlZ/unca/2FOv/340d+EuwBaBqSmP26B116HtCc+WqfK07+GzausOfhUstjW3RIIksw1xXekgAv6eb7AglIVMfF0pHlG51KZ+f/PSwRAYDaRXFSZqDzN1hKNv7OpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOi/HFMzKSDwNAg3oAfueNUKAISuphC5+sUF78lOo5I=;
 b=gpx+SxkoIr4gOCgHh3knt04Tv6vw+wPvrc5ILlZ4Tvh9L3MddOv/5MYZ92zc3uXJd2hIS9zFFNfvgNi/qYDnZ1E0MUs5ozesMrGUlF5btfV5fxiW8KwIPFP+WOZpc7yuyWQyJFfvjZmIFvc51OmrTrgETn8/IkdoGIq8zoU4TMA4MrQeNUy7Yr1GezY2V2Lc/3MLVtCB0h5rO2pMIm/boUZ7t/cSl/7HMgJPNOHeoHMjRZAs6nBzbwCxD2nDwQCOo1hFA8zrf1YFozIDsY8v0xU+/BJHY//bILuRYiQvUJtl8zzUV/Kkhp7ROiFPqZMop0otCD93xijN4ka4/Ga/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MW6PR11MB8366.namprd11.prod.outlook.com (2603:10b6:303:24c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 13:18:45 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9587.016; Sun, 8 Feb 2026
 13:18:43 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        Ionut Nechita <ionut_n2001@yahoo.com>,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        superm1@kernel.org, jkosina@suse.com
Subject: [PATCH] ceph: add timeout protection to ceph_mdsc_sync() path
Date: Sun,  8 Feb 2026 15:18:20 +0200
Message-ID: <20260208131819.37276-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::20) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|MW6PR11MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b84849-39ff-4fb0-f49a-08de67149559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I7jmlgrrVryQOjOPxehNSiSs7kSRsXxhUTOOSTqozLhI3PFBDtEByEmoDnYp?=
 =?us-ascii?Q?0QHy1VPchNoGxCrPR/Osvo6Ev4/f0JuF6JrXqw6DiLCm4bXb9xg5Tbb2R/Cm?=
 =?us-ascii?Q?7F4Ffgd/jODE+7JGthXWy/zslZzdzGGxM63x7+tLPXNnyfv2zDwOIc50yEZG?=
 =?us-ascii?Q?bciCb7Trr1Q5DOEkIY4pSc/tRtQ6HB8mZxR0fCWWg/W765NtNZ0KGaQ7CqoN?=
 =?us-ascii?Q?SFKq3FytKG/8Lm7Xx66/tZxbNI+ibOz7U/HsE3E3eTycGc6SMQw3c45nDU1K?=
 =?us-ascii?Q?QfFCJeoM8NeJ96d1rg7xhH1ze6fjDo9nbOBWtEPjAT+d7e3ml+wKgZeW4UyB?=
 =?us-ascii?Q?ztZ9mW6C9hYgizAxRlch2lo0uKLGr/aXv2KjTgZtoVWbLmjSX+x77zeYvegW?=
 =?us-ascii?Q?I4qdJc7/l20yc6D87JllFM2XM8U+wBfSYBzr0QkehUnVeYbrWhqdk52GytOw?=
 =?us-ascii?Q?h8g/NPbLfWGC4+kwuy/c6qppwjBqUDfXY0pXq+1oIktOpFj2XZc+bYeZ6CvK?=
 =?us-ascii?Q?vfYayQoiMHLSSSeWwHKryaud3f0WaN+flfl238NNRdkvLdAIGm+kkYA0l+L6?=
 =?us-ascii?Q?/e3W+mIls9xuTPtPATsonD+beSWySorpR8rrsAn9btpCjpBb08JC796Wmb/D?=
 =?us-ascii?Q?JBMTmsPzNqH1kA22CDRmPGO2RR8DVU3zMp3TXrs/cvuqrfpxNrvfQ4o08i1h?=
 =?us-ascii?Q?Ibsf/LEFSiaVOy/dw2mfQvV/PkTN1se+Mq6HxpISsFFT9Iv+D4b/m7U0IS6R?=
 =?us-ascii?Q?YmZ3/2YwyWJAyt9R4ff1vIkBRdINB1nIJMJO6wz5csSxFV4C0auTCiiyFeSn?=
 =?us-ascii?Q?ANjFvNRswCt2tIrxYJFLL0KSqAh5+u/7Iiz5AGkjtRqTTZ8vQpvYaIlTWYTF?=
 =?us-ascii?Q?ffICJie1XuO0l+CJVOV/0X+mhv6g2FaeeD0+AArzEyDZQ5DOe/Hqi6xQiNQT?=
 =?us-ascii?Q?xRvwxcel4grquyE4cLH3kjzhj7hXQe6DmPHPb+Sz9+KV2T43YTKEUO6wcfNi?=
 =?us-ascii?Q?Iw8xACaCPQ2t/0gVLtNH6IZtV8MLY0nDLHJ6qYGEc68jsPfXxenDoms0xax1?=
 =?us-ascii?Q?aiCVag4D1VVQM08QviucOHrMXX2GKqktElNNET28M2tbC55lg9n4kXQAUD/C?=
 =?us-ascii?Q?YpMc9my6EbvCXfRiZFidHHxpVovcqvuTUNiQiegUwQb62czOQfBn9cZqrhAa?=
 =?us-ascii?Q?xDnY9FWntXGAO9s/WGK0mHXWS7iGynVc0M7nH5nuPMdLvZaDuJVghNmAtKKS?=
 =?us-ascii?Q?kAXYu/DyPfxpjhYnXdA/Fze3TqLnyny/iCypSN/hi1XEfMoGvgyNXDml5gyQ?=
 =?us-ascii?Q?jhxKrlzwcnsQ+1HXfoDmEeRFnUSFtkvGXlFyCRTWMQpfa/+PquE8t9KgNgHG?=
 =?us-ascii?Q?fUpk8Ph+/y1VvoTsXGr+1cdW9/+xZWrN+oTaEf0yZsb+a8cV1/0ug113fIAK?=
 =?us-ascii?Q?RXJ3ZV15Qn4D/Np/8iEw6zZa+M/9SdfDVFIemFHRtY7nBVpMALZusGO8KSse?=
 =?us-ascii?Q?RCwQ+vwxKR3l9rkIAX+3IJv7PIF5UjRd3GzO2YTYmuySSzWYMs8iXJpa/fHG?=
 =?us-ascii?Q?FzNgJTuzxqugwnW4iow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QRhO8TJKojbeE7vEas9fECtaCKTifQKk5JLpj9WjH+tdUKv6hH8Zy/jndwdz?=
 =?us-ascii?Q?6BhYg43TZYGOWVqEqUf6hwG5qtNuRFyG2/QmtTwL/KdUNggvX8nSybuQ1upk?=
 =?us-ascii?Q?k2IJ57HZnKyYQG8xdRpgultrHdqx3utMwvA/tuq6cPQBtlhAx37tG6RgQgaZ?=
 =?us-ascii?Q?JJw7E3iahlLCu98mME6IWncfEEXnHQ/80sYKqHq32+ZKDNouasT5LrkrcNC2?=
 =?us-ascii?Q?YKWq6lEOs5TNkkI+8fSVwG+9uxoZ83+jZJ1HB/onUC8ayQkBDy6sI5wm7bI4?=
 =?us-ascii?Q?DOuWPa6pqNFfDn25nLQnBHmH6JS0WIhiex2c2zrzP0QOEcq2oXphwsBH1JBx?=
 =?us-ascii?Q?Aci5PoAH6vs3gSueJuwxWCuTCOy8s8Pv91oKOWYQc8nLSJV2KYwaEcHDNqCV?=
 =?us-ascii?Q?RbtvZfw1RCsvHhNYucVUmu3Wuq+2+WsfZYu1NQiEk62CjxhUlwJQ2UEI+HPG?=
 =?us-ascii?Q?GZPspvebARNiquf42Lb6f+XexSvp6AEhZ4wO9UTWdb3rmGCLwuyQHKU1lq8u?=
 =?us-ascii?Q?sVwPvKLfqFDxBf1GzNOOLwL1mXeQWpsxqFz7ySkX7bpETBGxfRpFeS6phu6L?=
 =?us-ascii?Q?H10SLrEv+D2p3oo98zJOLDoqgVlBzsJK8dtEIg2HpwL4qBFbn4Fai37TLUBj?=
 =?us-ascii?Q?52KrGnoXWU4eYmRAqToQkxTQKai/0MgQqy99O4lt/HAZoNYlW5PYjXmrbeVE?=
 =?us-ascii?Q?tkwcRdYC1Ddt8e9Lu6BYPWhhCxeJm4t6juEgSTYhtkcK3xgJlKNWSXXNxSDJ?=
 =?us-ascii?Q?9INCr3o0w+fF/q7krkqaCeTRq+x/UfnRDfrKlbuWrWyw1fU63gpiWRi3j/90?=
 =?us-ascii?Q?x5V2dMBrtbm+RHFEUXD+p8Pcg0ZfQgwVMqumYogrGx+jeBb3vJztGrgMBiCo?=
 =?us-ascii?Q?D/frMcAZPdK2xWNqatKVOAbhjDb54NRbx1V45Z3ZN8twEoW2xf4b4eJOvX7Z?=
 =?us-ascii?Q?NHOAApCCxM7dwOFjHXTMAkNcrT3MPEnhSg2voMyW86Msh3/ic4GlptktgT2Y?=
 =?us-ascii?Q?iqp0BBszIqYjzv9lx0185DLz60d36CZHZBaEg/Mg9yqBqmQ2XATFQYAg6fvR?=
 =?us-ascii?Q?Dm13INfk6mqegF1DCxST03s0cEZ5942Do5r/OXgLincZPHcM1Si/6y+HbLDX?=
 =?us-ascii?Q?BBCCpUtUQ2GcFwRk8iX6eK4tqLK3i3SMzoLdwKCeX6GSqt/p8XsdqSwjh/SV?=
 =?us-ascii?Q?iRVrcTzaYiahMDJg3XZXxnlAgfzWDFBJ2iZVRhHjred6DnU8U3VEGqB4L5fw?=
 =?us-ascii?Q?DXs8URHf53VZhzRjSOgNrQHHpWMqh59bAtYs1ng45bCPmI3XlfZx8z8aGp7A?=
 =?us-ascii?Q?i2DTPeHK99Z7RcSJkwakhwdSQ6Sq8NH6QLy3MRrho3cs6Kp+bjWAu6pPyI1y?=
 =?us-ascii?Q?ej6VAIPhCcdr3AzlbpCEPMYqZg5ypnuu1BRS9nEqpAwTIrDokh/W5LlcRNve?=
 =?us-ascii?Q?wBwALw3AcHceTYA1mxF32e0OMPg4rvjbask7E+O3N89vrQgByzp7CAPoVITQ?=
 =?us-ascii?Q?6iA4dOiEr+nSmxJ7Gpo9tCsRjUjXBmkHPzjtgFPfehHj2XeUEs/owbcNK4Dx?=
 =?us-ascii?Q?/CC0Mj7jLDGv+epyL9UQMdzvvrDfbvsf++80a+cj6uqU5QFUh2Qn1fPPcEZ0?=
 =?us-ascii?Q?5phagpsBlLGiE+Hkoyvvk2wWdmwCk1lpLp5SFhzWwFboFkcUbs/suEOLasKm?=
 =?us-ascii?Q?l/Fc6lTkbHJf3SQjfvwZHdiWdpCg0l5kUkyWdPZ9c6srpsoXrviFkLpFJYQs?=
 =?us-ascii?Q?fNYu6Hl15EplTOgSgupTnU8wlrm7hr6TMOPCHNTbvNEMK/sfAkNvuiXgvJ1L?=
X-MS-Exchange-AntiSpam-MessageData-1: vVWJzg8OGykpOfMv6pluKwrJeoTK7cTMe7U=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b84849-39ff-4fb0-f49a-08de67149559
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 13:18:43.7809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTzQ93+hGGTOGrIuYW1Zecn3o16eQAMaLTbjZ4omKPoYnsYGPH7SIJuOUqjXzlPSlzSKnhr6FAvBqomFn0ViVYhrq7HkMzld4HGWt9VOyq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8366
X-Authority-Analysis: v=2.4 cv=bvBBxUai c=1 sm=1 tr=0 ts=69888d38 cx=c_pps
 a=ZSUkm9skZvR9PgEjA8jAeg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=t7CeM3EgAAAA:8
 a=SaH7p1EYcUSNWIx4HiAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: sLdBD3bEuRFWSesBkxOU0iaTgsvFdhHl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDExNCBTYWx0ZWRfXwwvPRWslBPuY
 CCSFFXe47j7lPkVCyKXJVmzuu98QLx6ozjjZU3cxiKw330ZJfKwaXSULKDgUOfJQMU31NgQmHXh
 bvGTnCrAJ/Vhs6pMnVW5F/WITdlSTQT0BdoL4hcvlFBgq2E/te0Im7SexwRiXvGny1DlaBKNa2h
 oRCcwrBDTkkldYr8NCzh6FHpkIKOqShkdJjyG4qriQH0UZtIjnTwzQu+0tQv70NCxL1FaMS2oP7
 0akw0E09ZGeyhTBlEdIoUIqZJgeH5xnEoMU5j+OdwM0bdGjo/Df73N00wg1pKKz8JM3uqhsmV7D
 OAjFrJ3ur9ghKGO0+c4n6UvQc71y+viivTgb9e+j+2jgybjWuFAIZY6m712/fQgJ7oWlusItc0v
 VJtCP7EboPL8R4sJC6/xGJbv3VzNqZVXG/cRIE6UAoibvQJ70AJwqS4gTOrploWyMUFzBCQkYys
 JI73KyhCEHfUvofb0WA==
X-Proofpoint-ORIG-GUID: sLdBD3bEuRFWSesBkxOU0iaTgsvFdhHl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_03,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602080114

From: Ionut Nechita <ionut.nechita@windriver.com>

When Ceph MDS becomes unreachable (e.g., due to IPv6 EADDRNOTAVAIL
during DAD or network transitions), the sync syscall can block
indefinitely in ceph_mdsc_sync(). The hung_task detector fires
repeatedly (122s, 245s, 368s... up to 983+ seconds) with traces like:

  INFO: task sync:12345 blocked for more than 122 seconds.
  Call Trace:
    ceph_mdsc_sync+0x4d6/0x5a0 [ceph]
    ceph_sync_fs+0x31/0x130 [ceph]
    iterate_supers+0x97/0x100
    ksys_sync+0x32/0xb0

Three functions in the MDS sync path use indefinite waits:

1. wait_caps_flush() uses wait_event() with no timeout
2. flush_mdlog_and_wait_mdsc_unsafe_requests() uses
   wait_for_completion() with no timeout
3. ceph_mdsc_sync() returns void, cannot propagate errors

This is particularly problematic in Kubernetes environments with
PREEMPT_RT kernels where Ceph storage pods undergo rolling updates
and IPv6 network reconfigurations cause temporary MDS unavailability.

Fix this by adding mount_timeout-based timeouts (default 60s) to the
blocking waits, following the existing pattern used by wait_requests()
and ceph_mdsc_close_sessions() in the same file:

- wait_caps_flush(): use wait_event_timeout() with mount_timeout
- flush_mdlog_and_wait_mdsc_unsafe_requests(): use
  wait_for_completion_timeout() with mount_timeout
- ceph_mdsc_sync(): change return type to int, propagate -ETIMEDOUT
- ceph_sync_fs(): propagate error from ceph_mdsc_sync() to VFS

On timeout, dirty caps and pending requests are NOT discarded - they
remain in memory and are re-synced when MDS reconnects. The timeout
simply unblocks the calling task. If mount_timeout is set to 0,
ceph_timeout_jiffies() returns MAX_SCHEDULE_TIMEOUT, preserving the
original infinite-wait behavior.

Real-world impact: In production logs showing 'task sync blocked for
more than 983 seconds', this patch limits the block to mount_timeout
(60s default), returning -ETIMEDOUT to the VFS layer instead of
hanging indefinitely.

Fixes: 1b2ba3c5616e ("ceph: flush the mdlog for filesystem sync")
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/mds_client.c | 50 ++++++++++++++++++++++++++++++++++----------
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/super.c      |  5 +++--
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 7e4eab824daef..4cd8f584147f4 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2290,17 +2290,26 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
  *
  * returns true if we've flushed through want_flush_tid
  */
-static void wait_caps_flush(struct ceph_mds_client *mdsc,
-			    u64 want_flush_tid)
+static int wait_caps_flush(struct ceph_mds_client *mdsc,
+			   u64 want_flush_tid)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_options *opts = mdsc->fsc->client->options;
+	long ret;
 
 	doutc(cl, "want %llu\n", want_flush_tid);
 
-	wait_event(mdsc->cap_flushing_wq,
-		   check_caps_flush(mdsc, want_flush_tid));
+	ret = wait_event_timeout(mdsc->cap_flushing_wq,
+				 check_caps_flush(mdsc, want_flush_tid),
+				 ceph_timeout_jiffies(opts->mount_timeout));
+	if (!ret) {
+		pr_warn_client(cl, "cap flush timeout waiting for tid %llu\n",
+			       want_flush_tid);
+		return -ETIMEDOUT;
+	}
 
 	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
+	return 0;
 }
 
 /*
@@ -5865,13 +5874,15 @@ void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 /*
  * flush the mdlog and wait for all write mds requests to flush.
  */
-static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *mdsc,
-						 u64 want_tid)
+static int flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *mdsc,
+						      u64 want_tid)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_options *opts = mdsc->fsc->client->options;
 	struct ceph_mds_request *req = NULL, *nextreq;
 	struct ceph_mds_session *last_session = NULL;
 	struct rb_node *n;
+	unsigned long left;
 
 	mutex_lock(&mdsc->mutex);
 	doutc(cl, "want %lld\n", want_tid);
@@ -5910,7 +5921,19 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 			}
 			doutc(cl, "wait on %llu (want %llu)\n",
 			      req->r_tid, want_tid);
-			wait_for_completion(&req->r_safe_completion);
+			left = wait_for_completion_timeout(
+					&req->r_safe_completion,
+					ceph_timeout_jiffies(opts->mount_timeout));
+			if (!left) {
+				pr_warn_client(cl,
+					       "flush mdlog request tid %llu timed out\n",
+					       req->r_tid);
+				ceph_mdsc_put_request(req);
+				if (nextreq)
+					ceph_mdsc_put_request(nextreq);
+				ceph_put_mds_session(last_session);
+				return -ETIMEDOUT;
+			}
 
 			mutex_lock(&mdsc->mutex);
 			ceph_mdsc_put_request(req);
@@ -5928,15 +5951,17 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 	mutex_unlock(&mdsc->mutex);
 	ceph_put_mds_session(last_session);
 	doutc(cl, "done\n");
+	return 0;
 }
 
-void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
+int ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	u64 want_tid, want_flush;
+	int ret;
 
 	if (READ_ONCE(mdsc->fsc->mount_state) >= CEPH_MOUNT_SHUTDOWN)
-		return;
+		return -EIO;
 
 	doutc(cl, "sync\n");
 	mutex_lock(&mdsc->mutex);
@@ -5957,8 +5982,11 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 
 	doutc(cl, "sync want tid %lld flush_seq %lld\n", want_tid, want_flush);
 
-	flush_mdlog_and_wait_mdsc_unsafe_requests(mdsc, want_tid);
-	wait_caps_flush(mdsc, want_flush);
+	ret = flush_mdlog_and_wait_mdsc_unsafe_requests(mdsc, want_tid);
+	if (ret)
+		return ret;
+
+	return wait_caps_flush(mdsc, want_flush);
 }
 
 /*
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0428a5eaf28c6..a8b72cb13de1f 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -569,7 +569,7 @@ extern void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc);
 extern void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc);
 extern void ceph_mdsc_destroy(struct ceph_fs_client *fsc);
 
-extern void ceph_mdsc_sync(struct ceph_mds_client *mdsc);
+extern int ceph_mdsc_sync(struct ceph_mds_client *mdsc);
 
 extern void ceph_invalidate_dir_request(struct ceph_mds_request *req);
 extern int ceph_alloc_readdir_reply_buffer(struct ceph_mds_request *req,
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 7c1c1dac320da..6b0ad7a455815 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -125,6 +125,7 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	struct ceph_client *cl = fsc->client;
+	int ret;
 
 	if (!wait) {
 		doutc(cl, "(non-blocking)\n");
@@ -136,9 +137,9 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
 
 	doutc(cl, "(blocking)\n");
 	ceph_osdc_sync(&fsc->client->osdc);
-	ceph_mdsc_sync(fsc->mdsc);
+	ret = ceph_mdsc_sync(fsc->mdsc);
 	doutc(cl, "(blocking) done\n");
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.52.0

