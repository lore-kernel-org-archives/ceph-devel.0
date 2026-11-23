Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795420967;
	b=PlSWfewndn8Pm41J3Ht4gAQfm/qi4RPAHg/rRi3R4djKhyMN32jvkfCkgaexq8pi6p1o
	 ysq/Zg7K6bjBfpCrBqb1Y3mmsCUgK5NFWQ55puuWOhiObdMHnfJVMibQotuCDbJbPkNRu
	 Gfylz7OLfxMur+66zduBmaJ35RGdNV6DMeNFwjd1sVjPjK2Lb4PAIJ7Xj/NzKvEzgPIzN
	 JKBkrwggKacIGuJv795yfX6Zy4IORWekSaSMVSiWFVLcNx60dPNA17hK508TRSwvIPip9
	 DcdfJH9viLpsEEc9B69+lvb3bQqi5CmYosUrIBmKKgrjhw96aZZoAxOMjZvMIy0d2Kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420967;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZJE3+zf2+O0/ZyjbOR6KIMVfhMGE4MNu6rLCi5SdQck=;
	b=unuQuiZaWAxzR32/XYW8FtAVeJLLMb2Q2bCvRECHqfQfXaoX+OjNiHeeTJ2HmzvJe4iy
	 pe058X6+XMfXzvx6yloOQCgozzuCPW9LQHAyX747xSoI3NiaZc/TcYmnhtdtquJLwaSFQ
	 DRMbuzF+MW7JSlfN/cpmWOExXPZX5HLDQmkGfBr2CIQAYp2o0A8KTqbcLds+J9oxkVL+m
	 wFSOjucYU2VxD3Sj8GB1+1bofeNddalW62TU7Lw1ICcVkFIoUBabpY9XNnAamHFUzBIXG
	 nhI+bFwOGHyPAv4RRPC6GabhvTM3UpWJcyejzONpGgViBS14OkJ+tWHaE/u7g3t2D8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=C1hNxrjj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F1606A33B;
	Mon, 23 Nov 2026 08:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A83F1606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=C1hNxrjj
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN51msI2840662;
	Mon, 23 Nov 2026 00:02:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ZJE3+zf2+O0/ZyjbOR6KIMVfhMGE4MNu6rLCi5SdQck=; b=
	C1hNxrjjLXUVYzijPvoQT45eLAzixnGmA6hD55CfeBiH5G/tkv39KdWDStmMZ71v
	mS/1nsQHbiR71a/dsiiuYyA+ECtasGRxCBdzuMa2lbbRMjYHb0jG8+qRwVkHcakH
	8Egk2at9xQqquGw3iet5dZVndBZyaySL1aaY9Ln5eVFozoLs94EaP43yCwg4iQe4
	c+udP1blpAYmc1eNWbJ7HyU6AY/cX0R3EEi6DaSrfvYCjQBBPEj9PYkcv5iEpATL
	zTi6XD+GhNo78kHyh/Erk+8vgTa3Gm6cSV2p5ATuUW6x0VicHXKwp0ukibvpsx/x
	8wsIN8kiyISYTZVzmApmoQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020118.outbound.protection.outlook.com [52.101.56.118])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j3bpjsr4w-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 00:02:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIDuJnm6QfxQZgMrc9cb8+Z/zmm9WLx60zfykA5TD6N1x9vYkv13XP7Cp7dn9d5jJdDlit9B/t4e6sYt0VjoQKMuwYLU2tS1bA+E/pZ9tZ8J78sD3jzmXCK4vQWj7w1Y4MpFG3RfkFlnmZ4xEFF83TZdx/8uWNgwVrACrj0cXEfQpgwEAmjt9H67D0N2AdEVGwsTwwlHnnfRudKSXwJACXOJ9VTJIFJL3DnFbGoo7VRgSNeZLsTSXhgONDbQje4AyVOpOkdd/88x1dgT9Yj2aUfV1sMkqmmRZuWQ4yzWRrnbyY1IMcPKGYvrJg9Cz1jybkk8mXXUF0kfFUIGV7eXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJE3+zf2+O0/ZyjbOR6KIMVfhMGE4MNu6rLCi5SdQck=;
 b=mz+G0GJQx+Hc9JAq5BC31RRL0kUb2hSW8BLVUIfPVZxuPAWCjcBcV7ARzarkoRKmSDTHfc4K1rsjAqYKPB9I3D5sVvAAgms55m1LPhV/3mZU77aLGCXSNC8YS9RZAuhf3Frwv8jS7o95wpIhbFrvPKxtPzlyi5GmutzyMwEFxBylzv5ey6L72BVbPEpUVDcJdSDqRKBztPFfILp6ZlN6wFaTWHS9O/YT6WLYd/04gUFK+H78qyLLEdDwnFCg6kSnRi4ocPkqfGJWCq91E3tGym3ip/pMFHiYmo7hfWu+IzLL/TsF5fUGkf2v3eu242TMWBSqRSUvweVmlRDAMDvDLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:02:16 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Mon, 23 Nov 2026
 08:02:16 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Xiubo Li <xiubo.li@clyso.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] ceph: make the ceph_mdsc_sync() waits killable
Date: Mon, 23 Nov 2026 10:01:47 +0200
Message-ID: <20261123080152.163172-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123080152.163172-1-ionut.nechita@windriver.com>
References: <20261123080152.163172-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0051.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::6) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS0PR11MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f25798-fbb9-417b-80e7-08df4938170e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|10070799003|23010399003|6133799003|22082099003|18002099003|11063799006|56012099006|261026121527099003|261026140227099003|261102123227099003|261022075727099003|261021123027099003|261022105027099003|261028144727099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	0rZHgEeY2Ma5LFdQUagEdB64GFOosJraut1lHAmZZQHkEtQ6Q1EG/bop1r3r49b8IKUh4gkFmFOIrDeGWvC0F6kl85jNGcOFsk//bKFRlXy4O5/5dsdXKexfXtjxmaFQ9SnGj4dY1sA9uWvqbmnVM2hOeO2l72cSxaqPr1p3Ayc8Y+vhs6s9L6JvDA6uEviLMfIywd/GtOI5fL+GFHsFBVz1C4WBQTxI26xooFje9hrDFZ74GLLSYCE4IRRJ598AC2eS4Xz5w2DNv9MDv+zljD5KrAFrJduTjBXNU6rPWfAEV1U3jSmH8YdjEvZq5wrMnfz45c5T2Le6zKQY5YunKsCykcGJ+NW6e2uo6t7g1PtbsvLsxMEYRpXTyXm5kVpexv6EoxvnjM/s0CwNkj/pxuMzLeWUYQres0vvWC1YCHIKWCVAuTMJqzmNmgM6PdslxyUzlaWK38lOOL8k3ksSaF7NOLeTEdVVv/R1XiMEhJmxry7Ewg3wAXOzoNCgQGq20/bPuJa5N8EEhyeIy+zjNmOMUaU0KoJEjyc/PC04vqFLjRdrQk3MpMWMZt89g0x3kI8s6BMXMSFovPFccFa5G4MQcnh0t3LSnSyrJwB+0goXw5A7Z/VuX8u1yZlmjCZ6nB0WjKzI9LbE48CR1fuWv0lbUe4eU0876mpbIh9hejc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(10070799003)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261022075727099003)(261021123027099003)(261022105027099003)(261028144727099003)(261021121427099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VfQ1AwgVYIjLDjovv6Xkz8SACaHEgSqYJs9x0xz+1gzZiOqQ7BOZS+5aocNo?=
 =?us-ascii?Q?z1oMe7JPLoVRhmCUBPknQ9zumJg9aUc3Q7XyGudidXjpF/QErqUB9lqHmzz1?=
 =?us-ascii?Q?FawqKTfsYEoGaAApNw1p35buMcJQZa76UObMkaYznRta7o6q+EqCaYtuNbfA?=
 =?us-ascii?Q?nMRiC5BMegHcUAnvHxuyXP0nWaq0Y66nIrNxULH3DEtHyln9VW+slm0IwEkW?=
 =?us-ascii?Q?6umGR1tMll667TQtURn9NueOYQo1i/t/z+bNJd7gIBsWggyKcluYugPJTYI9?=
 =?us-ascii?Q?PLJqsKClyrl0J7BxLqG/lwSegvmlg2PSU1QKY2YB+GGXioGzLLxGCruhCOl5?=
 =?us-ascii?Q?bQBE3N180YVPhJjLzvF7V6RaTuO+22nfQAM4zogEXWZNu+CuIatk2pZRLcZm?=
 =?us-ascii?Q?nRJJELMxK/AAoe3FXSIQyI0fD9wfQP+o5/gUr7a/saVjM/rt6R2e3otGzb8m?=
 =?us-ascii?Q?2VPDzncbwQ1fqw9JXT5KxzJDDH6lfgw12LCuMvYFW4f6ySCPsvU7PAlWk5Co?=
 =?us-ascii?Q?r3tMF4itgPaCWrHYTSSgDlEDdHF8iwf9hgOF0lV0MiGCBqrzcw7N1BOm7Iri?=
 =?us-ascii?Q?vT72iMf7MULqie6eCnLSKb47UHwBaVvBfGPCQQuKP8wngrUTToh/JulS7vKC?=
 =?us-ascii?Q?MFRk6DxuULOFfIDVPruap79mTXVmFnDgoVMhVd42jQ2Aj6rR2xCPqXsJrsr+?=
 =?us-ascii?Q?Ob+UFHOCvcqFk+/evRiDO2yaChjlx5UlNNzL9DFgJLjUVrAMHzE4Ilt0a9Hp?=
 =?us-ascii?Q?1c7oViKgjooOVyvMDqJX7Y5iEoQB2TQMU1/Mi9PLU1HwpspC0DDfVo3juvi2?=
 =?us-ascii?Q?61paI+wXZ05a4yUZiEeOsYFcqibb6Vp2xW3Z92tKGUdQwuZxyMx4o2N8Ktt4?=
 =?us-ascii?Q?MGg4kySTdM5FJByhwGjl/sjViOEl63+nTaPoJ+YczbpsSn+cjns2QiiOHYld?=
 =?us-ascii?Q?AbjwbQLsl/XVosrBKPtHpd2kHqYy2n2tyxtDkLjNaok1aGCGsvvnk8R1quMt?=
 =?us-ascii?Q?BQW+OcLIJRCOSInO5d9x7WbPub6pO71b3AcL/uRYgGa43VXBDl+QIgiUkSX4?=
 =?us-ascii?Q?2Zt8BkYIL2oD/EsnCF/4qw4djY114VjAiyXOJ4myZ7Ia2tZtdDWVpZfPMwhF?=
 =?us-ascii?Q?7hqC9YBUwBOSo9q08nkuugJ0ImZZ9uGPtSNJTqns9OpP1fNpoE3Pdj3Ljdtl?=
 =?us-ascii?Q?7z4XeEoFB02+UBjJ81sLphcFuWEqflyLn3LlyXMYRN5+rBmEZw84C+GCxDbS?=
 =?us-ascii?Q?wp2XV+j90rCkE8Ij1hqYl+eDS88xP/MIMadZ9kBbZpmAXgVKRv47Z6RpDqvZ?=
 =?us-ascii?Q?co1bBUENhhcQPnvk1lAVncMI/kEe+/9shXD0O6tJhe32NrXhXTGpkuytq30h?=
 =?us-ascii?Q?mv2XobHs9gabALSMvlEnbEPf5NPJSckw5xPnLaPsFBQbvpbb1PJsLxNwfuGF?=
 =?us-ascii?Q?LYNaJIFJ7r4wFsdQPcHru3xV8KoNbFWFCLoKWEIwgPZmbiY3GYtHo+5Xoc+r?=
 =?us-ascii?Q?B5KqxYucVCZhYSwF4GMoZN3sZAc24oEVZDASCDu+nb3YeYrbP8uSQNFPdI+P?=
 =?us-ascii?Q?xbDKb3HuC+88eEiDB6PynkJ2LWJPCh0J+6dI0YihXZaiGye3j9rTbBE41gF0?=
 =?us-ascii?Q?O+Y7fsjATa+mNUYSdjyMvZ9LrqTzvh28Z9MUQbW7KbmTopU2vvsg1+bR2A1i?=
 =?us-ascii?Q?/9+1wJRNTKnxVRWfIFh1EnEYxfwnNFnMXLRq0dJaaeR/jrxex8N+93Yxz+EJ?=
 =?us-ascii?Q?GhqSIcxHyNvaGaW5iuCX/GABy8wzgcIcYfSs4JOG+RPwSnbGlpus/87uxper?=
X-MS-Exchange-AntiSpam-MessageData-1: WluUjW0c6lSbpaht37y1vZKuKR11G391aW0=
X-Exchange-RoutingPolicyChecked:
	Snsxy3gEHC/9lIiPLipWCjHTC6EEo5ylkhsC9b+jTgsGUHoddJHPPGBinrPny0IPRyGfTgGrp+qg+/XooTnHQ1bb+i+ZG4F0LLbbwFn0NsS675vkfqkbxiOKy+C0QPT0qWRdHFW9QeyodOFnrVrRBOgJh06CQ5xvKLxgzIVRBlL7ZEyJbHlZ/bSuXPg2KdHAoE1H+/55h32327aeX89Fah+G5jVKKazTFN0CnjXl4XslS90ANf3vKiZyuwuTfc1w4C6SmEIMwJrhbmgd7MDohUqKPEP+vhOMZz2uwxgIZ5+4t0tsiWaFo8XtjCixKTbRBAdYLN+kZ8Wwo8GE8nWArw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f25798-fbb9-417b-80e7-08df4938170e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:02:16.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3bUJyDWpJpure0q/mFM86G4OyeF8KDAIdL9BwbW5JENAyfplXqBwPpfUr/0efeIpjmhCchLeJ224NWWR5ExVuUeTg0tsGcx2PCP56AA7Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfX4gKCNnBGzdKn
 EPmWCNiFkVxZqnZiM043Nle1s4s04ZaXGmOchNt3HItVWPsoKvwYJutou8nptMDbahaJ5Mghscv
 sge067CdBMTXDV9mDU1tChla6BMFKMlaYfFJntvqN1RJTIvZj0JkKVqe8I8YXfxJ8Kix64+lxw7
 BkRfX9oABMLVkIm7rarZGVdiRvIxmk0+6aTKOCNr4cXRKt16QPLpnjeXrfWRRvHbrjEDguWRllI
 lQl3g51lIH2xJjCIY6n1UH2PaEKkLBX2POL1BbuLTFnqK5tEy1ci4YmJvVAHLQq3b3bJlXuy9ai
 Ojygpjj0foSO+5gmngY5PXAopNPZWNKRaFWEjbC14Ly5dS0NvnlZNmJ8V+BjVNXc7jP0+ugRgUJ
 waXpobegdilIoomcQ31OUcO11hT6WOUj6MEoeWfawzsRVmFBmVgvp6T+p+qBHZTtxNMo3Rqoxla
 AeOdyCuwL3EGXSx3EOg==
X-Proofpoint-GUID: hS0wnNHZF9u8yyZfDjeoiK4pmxa2dlBi
X-Authority-Analysis: v=2.4 cv=I8Hw19gg c=1 sm=1 tr=0 ts=6b03f30a cx=c_pps
 a=WTYiPbwPEgbs67/cDcbz6g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=BfqanH_NPa9Dam8t21kA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfX3fh0VEdGHk0G
 bSKL+WlWtT7Zrsr3SCxWGD+OH/Qp6GBB9DroWvJvgVPoFEk0mKg6S219rLiB8EjiEvkxn+Xcw3z
 6Beb1X4OXEkLKCCLrBjvaxZfJfyOwlfwdSnKli1sHWjZYJpTmLqY
X-Proofpoint-ORIG-GUID: hS0wnNHZF9u8yyZfDjeoiK4pmxa2dlBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230031

When the MDS is unreachable, sync(2) and syncfs(2) wait in
ceph_mdsc_sync() in TASK_UNINTERRUPTIBLE with no way out:
flush_mdlog_and_wait_mdsc_unsafe_requests() waits for
r_safe_completion, and wait_caps_flush() waits for the cap flushes.
The task can't be killed and keeps tripping the hung task detector:

  INFO: task sync:514917 blocked for more than 983 seconds.
  Call Trace:
   ceph_mdsc_sync+0x4d6/0x5a0 [ceph]
   ceph_sync_fs+0x31/0x130 [ceph]
   iterate_supers+0x97/0x100
   ksys_sync+0x32/0xb0

Bounding these waits isn't an option: sync(2) ignores the ->sync_fs()
return value, so returning early would break its guarantee that
metadata is stable once it returns.

Make both waits killable instead, keeping the wait_caps_flush()
diagnostics, and propagate the error out of ceph_sync_fs().  A sync
that isn't killed still waits for everything to be flushed.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/mds_client.c | 37 +++++++++++++++++++++++++++----------
 fs/ceph/mds_client.h |  2 +-
 fs/ceph/super.c      |  5 +++--
 3 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3791fc627714c..f64a9c97cb882 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2522,9 +2522,10 @@ static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
 /*
  * Wait for all cap flushes through @want_flush_tid to complete.
  * Periodically dumps pending cap flush state for diagnostics.
+ * Returns 0, or -ERESTARTSYS if a fatal signal is pending.
  */
-static void wait_caps_flush(struct ceph_mds_client *mdsc,
-			    u64 want_flush_tid)
+static int wait_caps_flush(struct ceph_mds_client *mdsc,
+			   u64 want_flush_tid)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	int i = 0;
@@ -2534,9 +2535,11 @@ static void wait_caps_flush(struct ceph_mds_client *mdsc,
 
 	do {
 		/* 60 * HZ fits in a long on all supported architectures. */
-		ret = wait_event_timeout(mdsc->cap_flushing_wq,
+		ret = wait_event_killable_timeout(mdsc->cap_flushing_wq,
 			   check_caps_flush(mdsc, want_flush_tid),
 			   CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC * HZ);
+		if (ret < 0)
+			return ret;
 		if (ret == 0) {
 			if (i < CEPH_CAP_FLUSH_MAX_DUMP_ITERS)
 				dump_cap_flushes(mdsc, want_flush_tid);
@@ -2548,6 +2551,7 @@ static void wait_caps_flush(struct ceph_mds_client *mdsc,
 	} while (ret == 0);
 
 	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
+	return 0;
 }
 
 /*
@@ -6737,13 +6741,14 @@ void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 /*
  * flush the mdlog and wait for all write mds requests to flush.
  */
-static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *mdsc,
-						 u64 want_tid)
+static int flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *mdsc,
+						      u64 want_tid)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req = NULL, *nextreq;
 	struct ceph_mds_session *last_session = NULL;
 	struct rb_node *n;
+	int err;
 
 	mutex_lock(&mdsc->mutex);
 	doutc(cl, "want %lld\n", want_tid);
@@ -6782,7 +6787,14 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
 			}
 			doutc(cl, "wait on %llu (want %llu)\n",
 			      req->r_tid, want_tid);
-			wait_for_completion(&req->r_safe_completion);
+			err = wait_for_completion_killable(&req->r_safe_completion);
+			if (err) {
+				ceph_mdsc_put_request(req);
+				if (nextreq)
+					ceph_mdsc_put_request(nextreq);
+				ceph_put_mds_session(last_session);
+				return err;
+			}
 
 			mutex_lock(&mdsc->mutex);
 			ceph_mdsc_put_request(req);
@@ -6800,15 +6812,17 @@ static void flush_mdlog_and_wait_mdsc_unsafe_requests(struct ceph_mds_client *md
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
+		return 0;
 
 	doutc(cl, "sync\n");
 	mutex_lock(&mdsc->mutex);
@@ -6829,8 +6843,11 @@ void ceph_mdsc_sync(struct ceph_mds_client *mdsc)
 
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
index 4749438d94e1f..31abbb3b3bdb3 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -635,7 +635,7 @@ extern void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc);
 extern void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc);
 extern void ceph_mdsc_destroy(struct ceph_fs_client *fsc);
 
-extern void ceph_mdsc_sync(struct ceph_mds_client *mdsc);
+extern int ceph_mdsc_sync(struct ceph_mds_client *mdsc);
 
 extern void ceph_invalidate_dir_request(struct ceph_mds_request *req);
 extern int ceph_alloc_readdir_reply_buffer(struct ceph_mds_request *req,
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 7b5ef76e430d7..7936b76aa3cc0 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -126,6 +126,7 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	struct ceph_client *cl = fsc->client;
+	int ret;
 
 	if (!wait) {
 		doutc(cl, "(non-blocking)\n");
@@ -137,9 +138,9 @@ static int ceph_sync_fs(struct super_block *sb, int wait)
 
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
2.56.0

