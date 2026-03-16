Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA333121F;
	Mon, 16 Mar 2026 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696073; cv=fail; b=jWs6nd/DewhgUX4yotMLhaCYQlxAQBWUDkgURJniaQXgVSSAs7hTipNa6T0D1cwRmHOqPXtqqqRYvWtv7cw1BznXo0VofSL1MaEG9pA3zOw8B08jYpV+aJybJT9iwv7yqu8TJy1zWyx4R7j36k9AbG/CMmK2Q7gXrdZtHQxtJ/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696073; c=relaxed/simple;
	bh=hdgyMZws+BZT/6ASOWSgXIOegzc4CJS7O7vrgf3SKMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bHx0nFqpYRzmBOPVENXgABKg80kR42p2D3pUOZ5PtynEv3R9/iognFTQk6mgRAlmjTqEsMWSyFyCSfC3QVpxqN5dJlCof1xTOiAWxBdO8ijc1437rw+me5iumHS9biwMpoe/22NoBkpIROIS//j2VFH4JJ9LG1/wBuvLnnFGz6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=L12HfFng; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="L12HfFng"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G6eMoJ3293731;
	Mon, 16 Mar 2026 14:20:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=YZ3IVN+1avH5YANz8K6jenk7I91TBJ+B9F6lnudH+BM=; b=
	L12HfFngssLIZdG99ZXNI/hg6RQWvxSaVZdBAoFZSCrFDMTHJKlbCi3KybycD1IU
	xj+IRBs8fQ5/Xw3cl/6z5xAb/YT6kXdNg30BcTnJE/F8HZ6132UScAsNhYIdBy7S
	yiH5rs7KZ5ikHmQiS4FqOaqU1MLg5DZ49+h6FXxwHq2n6JA+Rggd/YU4j7rx7bQp
	id6H1r/JJ8N9vjJQ99xYg/dTIvOUgCXh3406u/r8+o2TaweaBiMlPpf7r8Ja2VM7
	NsaIiVqAh4L8FUuXhqDZUUm3s6idI1NqfPjElbUE8eM1SnC+R0d1rJgeZeAefQIX
	9wBqF7jUk1nybTNzeqixrA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cw76dt86d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 14:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLm8lBdyy3dMW0Cx8gQmzu+d/Y5WymdcXRmMRZL/ajrNJp9ML54nCOR7No7tHqyOcv401D2qLG+k6keVunh0rM26FVFvSAb7hQSfnBJgnzvbCml9oNLD2k7jw9+2rbbb76yn5bVfhPra8qzQRHQxl4PLaF/mX4O592xOeSltRjCZFlrbQpQw898ZDwGBHUjjma7mEN6QUUX79dRcxoDe7XetBfSAMA+v/yITDUb1iSxkm8copyA0IADGeXx9WrQQ0XyO1MeinLBS1EKwh4ApVfxu04oXWqyB7XZ4ohv+Eku1D/Ol8niUY3+2wwe5y3zdqm/TcSWlqmatJIOSFBIo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZ3IVN+1avH5YANz8K6jenk7I91TBJ+B9F6lnudH+BM=;
 b=GGHZlUcz2WJF8aN3YdOSMoQRSN9QC0/Vs0a357ULY6KsC5ntL81jonVbGmdIee7r12Z29jbq6lUV395h1YPnP/xRalsEA0KOcsUy0zIKpLg8o/csKbnwZRZIAaDyyHu/JWeKe+w+NJj9cf/DH3WvaeO0cKnuvK4/lYBR2sALKHhk8r0TDh6OMZRQU2GorSkZPYzID+rVJxxktZCxz5y10GKom3ikcoAOFXIFGBs0jsV5R1wJrhE2bRLTbdUoHb6HGlW0jfP/ZuRU+CZQ5/wY+HrYVuKhrCSx9KQ5pIoeEi2+Oig3s6fAgbDem/XakCiawbVK7D9SREjFIUSQ8KV3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA1PR11MB5780.namprd11.prod.outlook.com (2603:10b6:806:233::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 21:20:55 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 21:20:55 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, xiubli@redhat.com,
        linux-kernel@vger.kernel.org, ionut_n2001@yahoo.com
Subject: Re: [PATCH v1 13/13] libceph: force host network namespace for kernel CephFS mounts
Date: Mon, 16 Mar 2026 23:20:41 +0200
Message-ID: <20260316212041.67098-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOi1vP_OYc2LKQV5PRRMM4G9C1-cxpq3Ts2p8Xbt0+hVwZXX6Q@mail.gmail.com>
References: <CAOi1vP_OYc2LKQV5PRRMM4G9C1-cxpq3Ts2p8Xbt0+hVwZXX6Q@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::26) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SA1PR11MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: b963365c-fa2b-45d8-ca53-08de83a1e85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4113zw79WQfbCuM1aq8T6PWAdGB6uYxtVo6ZiDU4H0RTVjn7uWWNEOdisb3JHlQTMR2NefFOk3iXIRt/ytx2S7CkiZgwixnnSy0HANt3rh29/vrXF9zqfHHRO176o98PQ5DLLekxf6mFdUAW4BihYeIb+WvCttYucY68geJXHGHZF5fIzRY7eyDrX//U8qyneUeugn0Uhrrbn/je6ppAHLH0fBTNoPJdsgaBU7FbXYiijvuyNdisSuqwaTeFOnWW0uZTyV87BNMrdKE8I7Qxx0PnxChoZfZQmL+rb153JgQflbsnt2ADYKd0Ds6mNxm6DwWm4mDjGRc12m9XQLmbT0ORTFH4nEyrXXfCzBnLS4pibFd5Pb7RUlwp1ncFtOUWQnxBSl9zES5pEa1NDyFqp8qujA3b8a/3FFZAytUYrkYTIWoG0SuMGlb0sIIhRByIn89Z6GNINXfhUL/Jio5mK9tJ8/tnhNd8mF9u6Vbslie49JLpJtBAdV7mMTd+6coDA8qNaUbLNLXHfXPWWXijUIj71IIogfH2fAcCS4NC+pSfqU0F5VvQFgAt0geyU3lTmKoLctP9PvQmYsT/ob2BQiX6pCLenH2A/gtR/UtpH1vOrhMl09exWgT1kvK8FHwnMpjnSFD2jmf1ar8VTzlwYsUMP11iLp9kmB9Btsp834EJoofIM7M8Kvsk0qYsT2TJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QjvAp0RH/dYvlDnzjJHypAJZf3shQYUU6iekDq3rXrwKIbEWrj6eGijEmW4U?=
 =?us-ascii?Q?1md7MjcVrr+gGTdK2+E5ob/DuxIGowwl842tFa+Q2A9dGZYQ/HkVuRRaoHcr?=
 =?us-ascii?Q?ZEFcvpCuHa4OPmN2fpm/R4BIX5lBPYm4Do5T77f2D96H+7ueGBFBv4MPTc6Q?=
 =?us-ascii?Q?XIlVo868xtfRx2pEK8udItrD+iEfMbycByaUH21h7HI5qyxyMFsH35hduryU?=
 =?us-ascii?Q?xTsscCJ9Sg5jhh8fJ0VSiz0z4pPAMOgWvIwBI8zjC01evrXuHiG0RLPw7uz5?=
 =?us-ascii?Q?NP6B5WsuBy/bnKCtwW7MRfE7X3Jvimtx0vu3G9rPPrV00+ZUqFh9ZSSXbkoB?=
 =?us-ascii?Q?/g/wI3ef3UmUFlLhkRWOac6m6/ziNKE906LMZNMuIhj17MpOL0XeQUQ0SoEI?=
 =?us-ascii?Q?WDcRgUl6oAXId3hBoWe2+9t7fYqMwVEyFQOmQ4bRED76fL25s+MSWgR3Jq72?=
 =?us-ascii?Q?zdKq6NpvcAif0SLFX33IBGEXICkGMNsCgxycjpOjGjhfx020a7Udhw6eplNC?=
 =?us-ascii?Q?OhQY7qrZNMVDjn/1gLmAYGBIm8IUULbEqcYq4eTV4x0aRRJOq9kB03e6FOD8?=
 =?us-ascii?Q?PcAPuQqwZcQmMPSso2CZKCH1xnN5TA0AIauSetbq2gPCQafnw9OAnVeg+GiA?=
 =?us-ascii?Q?1KHd6pT99ljserwyG9ch9oYQMfl/cy2x1ufhjR1rIK6P/fsiCMswml3kSB3P?=
 =?us-ascii?Q?egNvgPwex7sMaDIDaHPlloWMSmifYhfqbG7zSJTZBwcdsmhw87Sv/HZabYDK?=
 =?us-ascii?Q?2H5LubpAIxeQoqsH1QWlCTmmoQjKmDBU1dnakxMTEmGsZAa//sY6MiF2KpJJ?=
 =?us-ascii?Q?A4bMY2djtcyi2K1oMpJxhqu45giH3CkSi+FA7MZrQkqtXJqG44V7I3r5M5Uq?=
 =?us-ascii?Q?GixSD+C1AsDX8bEbZLwhE0Y2WByoRT5tTNkeUKacF6gQokK2fmqVu7uEhAZj?=
 =?us-ascii?Q?2Wjxd7+g76DcaCc3h4RotbbTK4H3J1zpG1p6OEQhPjzVqHzIV5xctU3oR8Sb?=
 =?us-ascii?Q?NrS5lNeK+JkWK/cw1CyOwORoUq0V+NaYpUrRyAvMiuXNne3jUQNN9v9/bZvy?=
 =?us-ascii?Q?WCKvnWGLgJsdHLO1vsU+i77PXSwVU4rDi/cIuzpulX75lJco+omI42OK+Z4j?=
 =?us-ascii?Q?BE5PFCDSy2+WXAILca1LmFFLX2oNTM7AZz+KJtWUEK3Lmg0CAn94TJ68Ayk0?=
 =?us-ascii?Q?LGEnHghSxU1HrUHcBGMhqi4H5i53gauJyHDrYDoTz3ptGh5W3bGbKbBCKFVM?=
 =?us-ascii?Q?mAQSX52M3go/chvvAXuGtMohxSbZ0xiOzHV3i4zML7Qn6oThdGLRpNrMvZgl?=
 =?us-ascii?Q?ogIcmhKtdIh65D8io5AwiuiADPUUW4UZ+IOhLyhBHn/H++rgWOWbDKN6/Zpl?=
 =?us-ascii?Q?Bgo02tLm7CE8p+34dtusNkpgUIASav+Rdd6tfXf00YfR8sFQgdxC+UsroPWy?=
 =?us-ascii?Q?FZ1PzcQiHnAcRH9nN7v6d1HCRVowQ4wpFyZTLnev6FDMcC5IcpeCC2TvWphV?=
 =?us-ascii?Q?oSKpZPM3LKnVfc/G9TXg4ZUpU8LyxCcKX5MlppZ5KNGPH/w2FFXzDLHQLujZ?=
 =?us-ascii?Q?lwQQIXA8VTw5sa51zraHzb9WRZi2BBqbDxMCEMLZgrkzDs+h4pdaO7cE+DA9?=
 =?us-ascii?Q?ZCCEjxdT6Aib5yVddBwWIHXeCavBGnWBlrnc+6YetlP4s2HW8H5EcoHBC7nk?=
 =?us-ascii?Q?D/9hijQNr/eXcP5pOWc6lEbGngiqiz4ZJcH1+1EV0Gzwi15viVCe/6DaNK48?=
 =?us-ascii?Q?Xym35KZRbV/WcB/rkkWoz7JrszdhTqL9RMMaYLUNgUT/pGyNY9Vug3Yai57/?=
X-MS-Exchange-AntiSpam-MessageData-1: 8VIkjSgZ2DbbITah3DCumcxSkzNA1/nzcC4=
X-Exchange-RoutingPolicyChecked:
	kfo55alyHWU8zNhOexWWunCKfL7F0/0fzuPL0riSoqB0LjCnvvWZcBB/DZ3vqGFPeFeE8prTjz4WhEXTGLJlRX/W0QYEtTFXAVx5P77RqTuWe4MNKYT5huzhNeCuNx1VkVIeVQnHqTGGFklXxo6971j6r+Ndl7gyZdNVb9tvdhBITuepoSWkqM0XzFiYm8V4bMb3+lUVJUsMks0XgiMaQJo9zcvjBur64SW9/rXVASZaEeN3c8JCaTPMXkqa4qskoQ9DtLiDdeO+zPjf3A/jCOAkCbDZAp9HFSsGppGkW2ALWxXaS+7EpSmj9vkN0vQUDJq5DJE5z4Y0oFjXomz49g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b963365c-fa2b-45d8-ca53-08de83a1e85f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 21:20:54.9457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJ72isR0Ze/l54LmL8bKBEoF29VMZWZHuOMUCirU+G8lsm3adf2Y7okGkZmchOvJ9osZUuJlvbbVzl58t+Du1Jt4/LwzW6JV/0835nY8qh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5780
X-Authority-Analysis: v=2.4 cv=S9nUAYsP c=1 sm=1 tr=0 ts=69b8743a cx=c_pps
 a=h6NrD5D8j3GnK3ckJnoRDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=4u6H09k7AAAA:8
 a=shgE_za_F5RGjcqunVMA:9 a=5yerskEF2kbSkDMynNst:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE3MyBTYWx0ZWRfX2VXRO/Tnb25U
 CW1W4puCSev+A3ptXLF3fkfbwNIGnhFowQPcsWxqs9CQ2bwI3noRGZ5vB9GQUXJIqk+0T9bBQR5
 ogZ2goe5ZUo3H9tylnw5eJIAhfVeQZXLDb7bM0cS2wx1+AkVhMJ7djqjHBLuAojOENSt1c/DTqR
 d0gP8DnRBChHTnTcRra6FbfacYxpHFJImDN+c1G2nx0dKDFr+neuZ5KMLRcw2ZU/ogcWq2VF8+i
 xC4j+0DXxJ0ZXwJiOBn0VoHYPMJwboyC3uAFLwghJdKbf1MXEzfL4aCyU+rdmdy6pp+6/qmSUqg
 Z4mNs7K0/gTCD7pHDAJZZ7dYJlKyMBMUzOI85L7JDnnspgr4DQ1S4+NEYpCMt0bTW/AgjzsW51Y
 UfPTT277oLYc7XCD5OA2cb7fTxCwrBUORaNBcq6WP8idweE97mTYuuLiIsLlfxAHQ/YJX+qHfL6
 8og0RONnFjWDiOMDHmg==
X-Proofpoint-ORIG-GUID: tP7xbpzZtr3G21lU2uLLJgMiVARQiShv
X-Proofpoint-GUID: tP7xbpzZtr3G21lU2uLLJgMiVARQiShv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160173

Hi Ilya,

Thank you for the detailed feedback and the historical context around
commits 757856d2 and eea553c2 -- I wasn't aware that namespace-aware
mounting was an intentional feature.

With the full series applied (patches 1-13), the Rook-Ceph rolling
upgrade scenario (e.g., Ceph 18.2.2 -> 18.2.5) with active CephFS
workloads completes successfully. The connection recovery, sync
timeouts, and mdsmap refresh patches address the core issues.

I agree that patch 13 is a force-impact change and can be seen as a
workaround for what is likely a race condition in the CSI/kubelet
orchestration layer. I'll drop it from v2 of this series.

I'd like to collaborate to better understand the namespace interaction
with CephFS in containerized environments. I'll gather more details  
about the specific race condition and share them both here and in the
Ceph tracker bug I opened:

  https://tracker.ceph.com/issues/74897

Regarding your questions:
- The network provider is Calico (IPv6-only cluster)
- The race condition occurs during kubelet restart when ceph-csi  
  issues mount() -- in some cases the mount syscall appears 
  to execute in the context of a pod namespace rather than 
  the host namespace, though I need to investigate 
  further to provide a proper reproducer

Thanks again for the review.

Best regards,
Ionut
