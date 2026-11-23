Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795420969;
	b=gZM6CMASW1s3+cuugPqyL9teVfhCg/oH0F9esTZcDV3Amco7GhYCceDsO3Dqq0qVlMM3
	 SreM+W5Ad2vZy2QVUN5j1fTaCcNL8bFfxnGM98TFmoj6FhLxoha6cgcjsxjgDeSF9dwSi
	 dO9gHVzyX1+5wWwa8glKjeCFjjliZf74XaDGLVRHLjk9mqe4KiA32i4XfYxvmkinKdBSe
	 tYYhYewvLtOg9ZzqTTqp4hQAcKU94p16bcRCMaBZlDxR/zepFevVHiqD/6mVdNG/mP9TN
	 yc7S2xdb3jzejcQMliLlodAPdxkEpoP8FP7WMWfzRw5213rVsvky4Zaz+N4/F2LHZ6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420969;
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
	bh=CUdNWVugs6i6GW4y/MWPiQTCaoDyc8ouI7x/Je6XfVY=;
	b=ypQ+UKPDpbpLXnTxY0vSKh+nXw9GhKwnYJmOdmtjB07AVpmIZEL+4LNGqCVJT8nQMk40
	 abZimSqukTVLpAXi2cVfZTZ+37cNoNkGmZL2YZrwGsZK6e4DriTYyBroeLlYYlVFiwdRc
	 foB63Bb4+wvYiPPWuXR6lRmReADoksI2iCz5KCUdvx9aFo8G7Je+uTchlqscH6Xb3gqDe
	 lBFe8+5YfhlpzpaYbaZpqSWLnQ/IYYtOedodhiB6e2dt2KptDXSRRmVABbpkNkT3HJ6Ml
	 KyEEaFUKEkDQpApz/crxW6aExjXa/rJ0GeBFgx85oKWZhKbyWvWat076AIelFoHNSaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=B3N8m+Sx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FBA606B185;
	Mon, 23 Nov 2026 08:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69FBA606B185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=B3N8m+Sx
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN51msJ2840662;
	Mon, 23 Nov 2026 00:02:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=CUdNWVugs6i6GW4y/MWPiQTCaoDyc8ouI7x/Je6XfVY=; b=
	B3N8m+SxzRRRbhOFUVQNqSPnhUt0fvwmFaNt1iR2HQjd7POLet+m8B3W27/T/Ebc
	61d+laUidkfKFjhQV5eaWWXQF061tddffsjyUXHTtqKb7wbV7LTAvD2KjSmU6QYM
	apHJE1S4RdIo0Ft6hODPzGSJSKaIBKr+KaojriCiGx0p//WYJr1GgStJzPjAB/o0
	v7RWlUP9jUgUkKdUTjeLCXFixuSsgqFLd8rPofonZAXYlgkAmaCzjtIcnclLkuwz
	WMj4MzAgGCdt8j/mJAV0A2FIBFgex2IO5/7a5DJc0kpjoVqOGjX3aGYnke8JXnFO
	VkzEcjsFD9yv5UEYgx9M1A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020118.outbound.protection.outlook.com [52.101.56.118])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j3bpjsr4w-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 00:02:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJ90oQtdkmaG+AhP5++On4ZxyrZZgHorWJQLmy/FakCucrCIdFiJQ/59Q1/L1zlBVtBzMkpC0Px4+Cro7BWi96n5SYDnypIKaq4A7vX8Y+4Hh8aQVCcQpbupPToFn8mqV8czD6uKA3TGG00CWx/0NeODVvKvZcQ0bwWwKHNUN/md3E5tc2W/FDClv2dqAMmqMlgLG779QBSftaKT37H18IbzJXZ/jdfZ4cN9oIDzsAyqElFHtmX17Sy1zLDWJA/kMmkHR6+gk/9R355HoTNmdEwMtVytSme34+E4YLtrm9dPmQILIkBO0BGN7XSynBQLb9AzhmDz4fAad1uP4VnT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUdNWVugs6i6GW4y/MWPiQTCaoDyc8ouI7x/Je6XfVY=;
 b=RzGIotUcdAn+19jQMdnjn/l27Dz7wazaUxSGtwjhO+p8Nwccj3pB/Cth+nPr39NJEFdwiJEZF3H+Hg37XDc2UYi3LgGw2AgGyup8V2PPN4lv6VfVSkbEY2zj3JGY0Twy3hTdpMu1sRQtjMEiNiu6px7okcutuzEr641BSiGTnoKM44+onthSR655T44EErecJil7gJkgvOy0aJfA9fEBK8tR5PR8X/Nur6EU1UObmreCtrOeTU/+i+5RTW8hit8igQU4pXD7okTPdyD7+tpP2QLukf+p20qCBrzN+luBeRjIZTLWBcthR5n/guGw005yxWQPAFJTtIE+sycPdWMbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:02:14 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Mon, 23 Nov 2026
 08:02:14 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Xiubo Li <xiubo.li@clyso.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] libceph: don't back off exponentially on EADDRNOTAVAIL
Date: Mon, 23 Nov 2026 10:01:46 +0200
Message-ID: <20261123080152.163172-2-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: a64dd384-8543-4ad7-e744-08df49381586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|10070799003|23010399003|22082099003|18002099003|3023799007|5023799004|11063799006|56012099006|261026121527099003|261026140227099003|261026130827099003|261026135527099003|261102123227099003|261022115727099003|261022075727099003|261021123027099003|261022105027099003|261021130227099003|261028144727099003|261021121427099003|261021133027099003|261021135927099003|261022113327099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	fu6PjzGp+5V11RLqJnMKYL8zqg5UN1wgelDMDQg5exj8uIPjAKQfLowriGOl4/DGypmULqgj9D+6RqbpvUuhxjmZEHba6q36EsKwDB7FLYiwkGxnuJkaKxa/nF0PpvzIMKwToEMg5av9BIVm9/4lkWiflayp8vCLhNzncHy8lTo1SRydo9193hIesv9JmfKGG5uXkJKgOeTm958BQkgGKzRNe+uIP86DhystF94UArw16IRE1yxFtDH7uLE8Uf6OcKv+W60wpv3SzwQ7a1BhfH3PZ4bb4jlZ+0MyDdrw9K6VVozruajzY8bGrieAXpzn48h4q3djBTjIW2ph4tP3BlUtfaQVHBRncBgECiXdb8g8aeQT5e+mz67n8HdUV5VDS3ZHuSi1OwpsGwXPzykgAkgxICie4CiweNjM4+zi07XzmSS1Q9rNwY0WUKmjeT9sEOC0HhIDWnR2g2CPMV6cOtcpRlsEwFTm4kmsbV052UgUI0sjo2xFS0SJI2kJUJ6xWHeeLKSSs1zraN4vBsiFn+nvnT0y4neBmIPyN5zeaLOGspgqH4vp/Q0nMB+fXnB0n0BgLQvcCzFTKZLRNNIQIHXnwo1P5Bkrit5CALVIJlZ9C8UvSsjrfo3SX4WWdwe579PaCefnDjuCusJg9ZM4wunqD5nTcs7eXNqRggIN0kE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(10070799003)(23010399003)(22082099003)(18002099003)(3023799007)(5023799004)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261026130827099003)(261026135527099003)(261102123227099003)(261022115727099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021130227099003)(261028144727099003)(261021121427099003)(261021133027099003)(261021135927099003)(261022113327099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lHSazaX7dzZSc88zPb3jCITWb5ffQyEUewu7GUxXNinD0GYFm+WmIibktHip?=
 =?us-ascii?Q?tUxkLJ5xBjxgXU1peVw1P3rotX5YzyzpsP+whfWUdxTzxQbUcta7zjlkBzqm?=
 =?us-ascii?Q?2WLFz6Pxb04SAJskVr4t4SoS1lKXfy5bUA8fg3bMksW+md2Si5MtYIrOWVfF?=
 =?us-ascii?Q?Oiuejn3vVvmwrtAfOUQkpIt5FU+qpBHPyE/Dkymxlaq4MmREfQH//9CeUN65?=
 =?us-ascii?Q?z5e4X/s51sKHfTbU5J9ZvyNMJ+aOVdD1+psgb4muYw9w1BCnSm4TCJZfn4fj?=
 =?us-ascii?Q?Qo7rCY3Pk3WCUiw7+/gbjyqJk4JvTPb0iTkYA1UNRdh+glgPDyVmE20DPSAY?=
 =?us-ascii?Q?wFgy4YO4B+WlZ9rg6cIwJTKJn6rm97ttb101cWLphP40og3or6j4xq9ivX2r?=
 =?us-ascii?Q?3xQcCWMr0NBN61re3JxBXN4jL68xDACE1d/uLfYYv7Svp50ctj9Usg2OEwMV?=
 =?us-ascii?Q?vIYmaIFFEi1AemW7ptDMwsqzdmMRzo5JPEgnc9k43F6h796lkFJelgmIJF8T?=
 =?us-ascii?Q?rQwObjeQdikEM3hlFssdi3oDvu1jVS4HO9EvoDd+olbs/8XOp8tmCZE3Ny5T?=
 =?us-ascii?Q?M6Tf87ljBYlaEWyGJ+mjapbeSH+pIF9bdkA5OZelXzGA7zwdHgMprsVTatJ4?=
 =?us-ascii?Q?O/TeZkPpkcMxNleTh5TFOBagFNDgb0JHft5PenhV7+e93eC2Ftf6p8AMIMhr?=
 =?us-ascii?Q?pOYztWKqMPn7jdCQIzj+j7/GlHwibX/ZjaAFmTlqrcbHT0euUYtXOjP6kPvf?=
 =?us-ascii?Q?0mhh7zJs+N4XkR2mZ2w7ILO1XGK20d0Cps1UCUdEicR4H5fJce9ZA0Q0wryy?=
 =?us-ascii?Q?5wAMiJ9TFs6w3/yuB6PtW7qbhgsPV5NJd+lMpBGDJLRluC4tPxh28MwYq9Ba?=
 =?us-ascii?Q?fq45eGEDXMetcRZ4WaRDbJUHQisLlo5A67ouBwOoWfhFdn+o3OAjQx3CRSOV?=
 =?us-ascii?Q?m471lO2PINAhQ+vb62VNknaLFKowE8gRvK9Manndvb0xI0DL+uy3RerpRvm0?=
 =?us-ascii?Q?83tYVEY+6C9Thhg+W4ie2xLefAQ+4JO/tEMiPfOdgDKEoAujo3MZ+auLlns3?=
 =?us-ascii?Q?TZbH6L1F1DStfDIyCqjV1N4ysKsGCvXQgDnBDmyAnL3cZlxB8QzkRC1NYqpJ?=
 =?us-ascii?Q?X5xzyRFDlzUItj7DMaCd002bso3r40DU58iArok594iGo3MPPuukX894Uq2R?=
 =?us-ascii?Q?jEu+0rIfA4CUQuVXxLGPfkHIY6tKHmN3Jqd7B0ysCKInosm24f+u4LuqZEv4?=
 =?us-ascii?Q?JFLPMd0JSlRtGUYMkIuBtjvc26lAQgHGjuH2nQ2Iuwhpkru60lC3gkeZaTqG?=
 =?us-ascii?Q?JStCD1rCEbyjb+LsRA0om9nzFaLfB7MxYNDUPg1z82W1utIdiT/jWV1GOFxl?=
 =?us-ascii?Q?eb8pPS98myxjR5ll4asZyJvfoOI8JO5fbiGjddS4Tpgqly3cm5RwxMXevwlI?=
 =?us-ascii?Q?yyBzCV+TQzeT2RLP1BPRpKP+1sTNPfgV8kRJ7TkV0nG3mNew5PoAbpF6uIdQ?=
 =?us-ascii?Q?5Rk65Uuq0O7OEkiGHZhYakWgBon/SfY6Y7b7hzeg36un4aBl+zptePv7OIt4?=
 =?us-ascii?Q?U4m3/1ehfwjBleVpBFwCxbrha32U280ZDjcWL0Zy1WyUr36ipCRe+9qMt5uf?=
 =?us-ascii?Q?nNtoYcMjJNR7nmQMP9pRawlz8MwKK225cJTU5YjxiRDJaPYmw+410Af01oOH?=
 =?us-ascii?Q?K59SO6/Tr8xTT8Ltp5L6Af5DmLH5CBS8Ht7AAdyVvMEuP+RT7Rnc7qsfdU5o?=
 =?us-ascii?Q?eXYxBsdT3Osas7jAH0Ktsyv9WNyDuGnuVG80ntc7Hh/ujKkt4kbM3nZQ+W3d?=
X-MS-Exchange-AntiSpam-MessageData-1: lGUPav/r/SiMrzNue3n0lcOn14RrnXqZp6w=
X-Exchange-RoutingPolicyChecked:
	IJiQ+f6bXVLCLxMDlIoDGfH8KqvrAu8tHnc9aZN5TtPHsCmrTfoBdbdIEUt2lHVqgcKHXSmzwrc1MF6GfLICHi+D6PHJhtiRMv0hh33oyOyRoI6xqMMXzDb+SOMoQWtig67HV5/zAszg+P8DwRpP/LE2CWePXZ4agduUFBIAujpyIC5M8Dxu4fvi/y41TObE3r8FrDIsknWMV/heGPUIpsmAh4UvcmdFKX+EKVhvpzHcOdaQGAh4KKDwP6L6fZ2QO7UWzywr+H+SMaLtcXtTJyiKig0lN6YbPXRotCrXJpivlxVUFtCeGf1bz+nWb9cMTMW2/7J10py+DEb2miCJvQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64dd384-8543-4ad7-e744-08df49381586
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:02:14.0355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWOepGROylI61xlNK/c1zajm+wEenzvKAd+zW3HHOQjwF7gVkeIMnmE5LPMdBW6T3rjjJJPa1RASyFA2vYYqrlhhjvhPXY+mpGr/7OBCgLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfX5w+fsCH/5EgR
 71aZjA5Wb3vA1S4nqiyUnM1vi7Sm4fJ3/tZap5zI6pwjWqceNjJE3+4/xbZeJw28K5buEYMjHJ7
 jl4mCxOd5z8gPoNwasJd2BQrh+F1T4f9Eq8LF6tk404ecdQbpohxPTIPKo39snicyppkVGviTxO
 LFhQRICt0Wz740Vn7m/4zkSQRkWrGdbubYK0IPMAAdX+Q4gChs/+8K6JgWNkzgNiQbsYkMuQmlW
 Wh8hEAhoOodbNrwxquBfEtaWYoTNfbRlKYOv8dwNAeFjTR6obLa9VvZwpBUSGrtLZB6gWm2xx2u
 LXrmfgVKZyna1TlCTPjHtS09L42YRhm9vWVVzYln0xGEEJobvUjZ+W8ldiwSPbBEfIbSDNKMUEf
 C6pT3rzgW65MlyFSk1TIVYudbtQx/gybMda60vvAOqRkunvIHyhZitdmbY33jQtZ93y0i/C00N+
 8VO+dzZp2zIvF7YphAA==
X-Proofpoint-GUID: VI5AMPFGHhQ_D4b8X9NIAiU7yzoPNpuR
X-Authority-Analysis: v=2.4 cv=I8Hw19gg c=1 sm=1 tr=0 ts=6b03f30b cx=c_pps
 a=WTYiPbwPEgbs67/cDcbz6g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=06xcUqQ1aE7JeyoqIIgA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMSBTYWx0ZWRfX5V/IduIZho9M
 f5Tbic2uGRQh6xFfHIb63o8D3sMFy5poanJ1UDNHAVFSzXppSqWoSz0muHC+CTUoFs3hKMH+cN4
 /EF3UQRp+FRROcATxKfEJ6cBtxzEayHhxnHTnq+aysdGUIXuWHDm
X-Proofpoint-ORIG-GUID: VI5AMPFGHhQ_D4b8X9NIAiU7yzoPNpuR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230031

When kernel_connect() fails with EADDRNOTAVAIL, the error is local:
no route or no usable source address for the peer, and nothing was
sent on the wire.  con_fault() nevertheless treats it like any other
failure and doubles con->delay up to MAX_DELAY_INTERVAL (15s), so once
the local condition clears the client may sit idle for up to 15s
before trying again.

Since a failed attempt costs nothing and never reaches the peer,
retry at a fixed 100ms instead.  Track the condition in struct
ceph_connection so that it doesn't depend on which protocol (msgr1 or
msgr2) is in use, and rate-limit the message.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 include/linux/ceph/messenger.h |  7 +++++++
 net/ceph/messenger.c           | 15 ++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 6aa4c6478c9f6..344496967b5c5 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -321,6 +321,12 @@ struct ceph_msg {
 /* ceph connection fault delay defaults, for exponential backoff */
 #define BASE_DELAY_INTERVAL	(HZ / 4)
 #define MAX_DELAY_INTERVAL	(15 * HZ)
+/*
+ * Fixed retry delay used instead of exponential backoff when connect()
+ * fails locally with EADDRNOTAVAIL.  Such an attempt never reaches the
+ * peer, so backing off protects nobody and only delays recovery.
+ */
+#define ADDRNOTAVAIL_DELAY	msecs_to_jiffies(100)
 
 struct ceph_connection_v1_info {
 	struct kvec out_kvec[8],         /* sending header/footer data */
@@ -507,6 +513,7 @@ struct ceph_connection {
 
 	struct delayed_work work;	    /* send|recv work */
 	unsigned long       delay;          /* current delay interval */
+	bool addr_notavail;  /* last connect() failed with EADDRNOTAVAIL */
 
 	union {
 		struct ceph_connection_v1_info v1;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index cc7db8c61db37..3c893bc0f7d8b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -467,8 +467,13 @@ int ceph_tcp_connect(struct ceph_connection *con)
 		     ceph_pr_addr(&con->peer_addr),
 		     sock->sk->sk_state);
 	} else if (ret < 0) {
-		pr_err("connect %s error %d\n",
-		       ceph_pr_addr(&con->peer_addr), ret);
+		if (ret == -EADDRNOTAVAIL)
+			pr_warn_ratelimited("connect %s: address not available, will retry\n",
+					    ceph_pr_addr(&con->peer_addr));
+		else
+			pr_err("connect %s error %d\n",
+			       ceph_pr_addr(&con->peer_addr), ret);
+		con->addr_notavail = ret == -EADDRNOTAVAIL;
 		sock_release(sock);
 		return ret;
 	}
@@ -477,6 +482,7 @@ int ceph_tcp_connect(struct ceph_connection *con)
 		tcp_sock_set_nodelay(sock->sk);
 
 	con->sock = sock;
+	con->addr_notavail = false;
 	return 0;
 }
 
@@ -610,6 +616,7 @@ void ceph_con_open(struct ceph_connection *con,
 
 	memcpy(&con->peer_addr, addr, sizeof(*addr));
 	con->delay = 0;      /* reset backoff memory */
+	con->addr_notavail = false;
 	mutex_unlock(&con->mutex);
 	queue_con(con);
 }
@@ -1644,7 +1651,9 @@ static void con_fault(struct ceph_connection *con)
 	} else {
 		/* retry after a delay. */
 		con->state = CEPH_CON_S_PREOPEN;
-		if (!con->delay) {
+		if (con->addr_notavail) {
+			con->delay = ADDRNOTAVAIL_DELAY;
+		} else if (!con->delay) {
 			con->delay = BASE_DELAY_INTERVAL;
 		} else if (con->delay < MAX_DELAY_INTERVAL) {
 			con->delay *= 2;
-- 
2.56.0

