Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6F2238C29;
	Wed, 18 Feb 2026 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771444740; cv=fail; b=jkfM5B+Dzfpz7InQxabtgYLst/AcFN6jrg/RuBKfOdiRS5ZtwM/At10GI5U5eenVsait8Brx0zlukHvlsh4ifZPhH0wQxlhJ5pY+p2MPtS/vIzto+Qs129TCRLOUcgzlNCi5hee22c+wf183l+rcCXPmoY0FKoLHFhEV12lfZEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771444740; c=relaxed/simple;
	bh=rEQhBFp+qnNHAWQJT6saDzj59LvsRy7Ir2uCRdAMVzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tM4bEBQjY9Km+mawuJxhE10XdfGh5KVk2svaAG24MRGLc3USFUXm6RAhufLrTIbV3trS0lLUx3/QG3ik/2viWhgmGhtLUNRBl9/a/TUa1sQpL/qSEVutPRZPTurO24qAhFoztfXxffYtHAfgtsDSrnesKMYA8p9FYW6ZDcOtaDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=dOG78Q2z; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="dOG78Q2z"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I9GGTw1360292;
	Wed, 18 Feb 2026 11:58:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ObLDpaGHwSf7XLmikJYu0ijGh74Sm+k3qf4ZQmALsNM=; b=
	dOG78Q2zfMz8IN8/29nFvWni5laYFMsj3jRBdq4kO1c6NCu+MAR+ZdQjPhXT2123
	j1NsGf7rMZa8mQmTsSz22FMdScCkIHOkTPjGqtbjE97zhC3GG/oL2ZmNQD4dAsHz
	FWaiTXiKqjx2cfCKGY8RZOGQtpNdxIWWdUtC5iyblS4ZCiRFnUqTbFv8OxRVXb2q
	wu52jlpmtCSu5wksaMOBRISw/JU3ReVIfDSSeGQ4OP1gvcBs/iPVK0I9FxXr8umN
	hitlcS9eagfABkr7YVJoMNqgWgKHjy80tyrdv78oB6oQzstU42PPZH5qtPcFOdZg
	+EjdHbGly5rAZDevczHl/A==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ccbam2tqr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 11:58:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwCAMgeDnL7jc7aacao9qzVI7GxSKoPeIO9uW8mKBr+JA1rVGPYzmEino3YF9xSXxxZQoqbNBvT4ysTw4h9QPRaxWBo6hMdSRWSG8GvT7yL0Zi0Wl4F9hzQYbNPAF2CcoUko+SldIuXwInULORfmPFAw4MVm25CMTXYqWcuXrm6IYadk5Ns9WgBT6IXvE7/zH20tuW/lHy4cYEHqx3RDIYp3Bjdn0rC813FreaW+UBkwSMmJ9uXzUDp0XuUYpq3SKnmknfino8oU8cskC3VHZww7SS5oG3XJ4HX42GmJiRexKjohNoxmG9XKNcB0JMsmIqWlcH+waTDcmH3ny48QBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObLDpaGHwSf7XLmikJYu0ijGh74Sm+k3qf4ZQmALsNM=;
 b=URknqtJPqLlP7eLD5JxH2Q6HxAP69bA40kNRttclcMrZk02PHDkK8v4guLpaP+z5fAmGTUoHQdRISyKf9L/xoi8gd5XuFFG8ZTeqhvU5XQamd1D8VBBOdbPdG68CjenAjgN+IehsKkWm0+dzvDEE6q0aGuNk8+bRLiW6db7k6oucOfY+22I1cQxCc+7cCenoj/4E17Puk7QDKwAW9u91VTcrtSglA60rXoDHk95LYV3mV5Re8hJh1MBEZKrALvxmzqQooZoxRLxbPHBrwkmtk9RYmcrAyVY65qVx2iUu5oTrREe+ymCmTrZt/8e8ABfD0qnqc6LTpRKhTDwBLeY0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by CY8PR11MB7847.namprd11.prod.outlook.com (2603:10b6:930:7c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 18 Feb
 2026 19:57:59 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 19:57:57 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, Alex Markuze <amarkuze@redhat.com>,
        Xiubo Li <xiubli@redhat.com>, sage@newdream.net, jlayton@kernel.org,
        rostedt@goodmis.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
        superm1@kernel.org, jkosina@suse.com, ionut_n2001@yahoo.com
Subject: Re: [PATCH] ceph: add timeout protection to ceph_mdsc_sync() path
Date: Wed, 18 Feb 2026 21:57:38 +0200
Message-ID: <20260218195738.49204-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <fe346c26386a4fc85cfa27e669dffd13191e7ea4.camel@ibm.com>
References: <fe346c26386a4fc85cfa27e669dffd13191e7ea4.camel@ibm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
 MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|CY8PR11MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e1a964-8260-4c54-08f2-08de6f280328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bOxVTdbAn57DZodvhjtB4vE1KaF/3Eas4QQQL3hsskBALIFUq7eANjcpbES+?=
 =?us-ascii?Q?bOabFdp85O2LnE+Ahhq4UFgTo6BEfFGdWgjxG3mqmcmpdbnNKByxtLidpLK2?=
 =?us-ascii?Q?N3eB3ovDYT7XyTBtb8lKITdOgnXFJFrZBb6DxJsk4d9u1cuuiXGqq38W6Xbv?=
 =?us-ascii?Q?VDFsBdcq6IeUovektQNdSma9LGF1hR/GsZB83MZwjYJBnhPYOJf8nGOQx/r9?=
 =?us-ascii?Q?2qe8VaxNjAN+xqAIaGLUDl70ou53Y2vJcqZz1LhcpwF5sHcixIZ61fHeEKo1?=
 =?us-ascii?Q?y443Q4glqsoAPgLaMlkj7/y2iKNEpiSVcTGGilhpGaZreLWxfYNWcVDE5hn8?=
 =?us-ascii?Q?HvAOc2OUIOAq6EA/Oz+7SX4KxbC4QZzF752vKzrPYLWcaA2awW9PZ+VkvfL+?=
 =?us-ascii?Q?RnPHPyiTF3W9IcsyUWzUwe4AnjNBYRDg03Vkqbw9MGc66NxvQ7TJ5aWhS386?=
 =?us-ascii?Q?XnumGpYdK1triSX72uZQLdb4jmy+Z43pU5pcryiDhc9qTOe8k1TSsJlARnTs?=
 =?us-ascii?Q?35Oqpowm+q4URTguSeF8EdViK8vMezGnGxPxZf8xOyYsKmtfL5gJu7Y7Hjse?=
 =?us-ascii?Q?NopQ2aPSetINirv/0tBr7kTeeS8UtZwLOEwf3R8s97xWsNU6id+oEOGwJT8H?=
 =?us-ascii?Q?VvD4nfQRNkFux0Pa0Y/2sXQdSCh9dcLas6fiFRHknnHxFUTk5pBxVK10GOa2?=
 =?us-ascii?Q?JmtokNttETqjJZHD+3fCNk+S6kDNTi6QzGu0m1Dqd5KQHIXJMDaisaFg91l5?=
 =?us-ascii?Q?WIEyCJRcRvjN1C1rQ/e7NwRk+g9Xp5J94hbZ6b9A8mkIdCRYfw2etXEobifs?=
 =?us-ascii?Q?flp2fPux/7vJePxPKjaIMPaH9FycJsNrSZ2UERfORWNKbXuhwc+4jZSq1/iI?=
 =?us-ascii?Q?ljCxCRamx3mo6voHEdFrEtfl/iCQKmhoD377KnUBmyzpounWPOKRs8tLyo/f?=
 =?us-ascii?Q?plETlHTeWCIXfjIHjtUqvh/C7zYtDMj3NsN2qmptPM8ZAcXsRc8OGeGelcag?=
 =?us-ascii?Q?pIQB2nUk/9XU25c63PyCzSTFmMAVLjReoyo0jKsv1iS+X8CY+Rc6ryn+7Unt?=
 =?us-ascii?Q?3RJND9H549b5Aa5OjHvHHm1gwNKS7I71QEr1mdgz2uanxGEkggAI+nxCEGkL?=
 =?us-ascii?Q?NsVhSneRAyTGhuTKqG1YJ722+o5o/HAjInm1eStj/TYTYccsewP4Hf209Wmg?=
 =?us-ascii?Q?VcgXCmrM3NvxlPRgnyB9hojMPedoArMudNIEM41TCJUkwea8uqROq378u+6t?=
 =?us-ascii?Q?W3pZCmS3G8IkBaf/2Ok9HupX3H8E35fjbawumEQAaOZR+QJ/0NZgyRg7z8f5?=
 =?us-ascii?Q?MWdVIaYPj4qQQQe7oj3BQspo7YKbt3qDkzBG3HMTzb/Hp0lUff2jQvSKdLDg?=
 =?us-ascii?Q?uDhysUA8ZtZ4rys1bVxvABfnBvVCtS41vGmo2fWK79eYnx+ZwNdI5hl9eGgu?=
 =?us-ascii?Q?XMyqPc+W7f/6mtYKRDdKJQmKaEwXFE7vg7U8sThVj2Jd4/Z/nOlylHSgCPX9?=
 =?us-ascii?Q?OrDEM/ri4qZi5OYsEKttjohL4Qa2HfzpdC25?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JJF/C/vBvOl7y3a607AIhgLdAviVJA8AEtoIgp1y4a5+kXZPTo6HHs6gNXgh?=
 =?us-ascii?Q?8vVd/qcdHm6P00oGEWgs5vT0L7wFJ57PTkn9BH65nQ8K2UuUrYtKIKYykpAB?=
 =?us-ascii?Q?Ymyh/lzdRApQfi3lWZ81JeG35c8Nufd2f+vzlDNVbm0Hhtcbm+HMVxuO6R38?=
 =?us-ascii?Q?03JuqUU/KlJ2F1XSxSY2B21yfrhFqc4qEDFK1Dpkrj4mUu7yrgLsht3chY1g?=
 =?us-ascii?Q?j5oZeD0en+wBd4uvkj0y+BNW9qvsILYHBXL/jo9pRzqsvD5GlETh9/gxoCDW?=
 =?us-ascii?Q?hK/3BBY2T1GTBl/CTlEa9XqcKuJ9vcfNkispq3g/34oUdEPNCwpuWoRxNCpL?=
 =?us-ascii?Q?asT6WGaVP16QN6h+m3uECNvPHuFGwRqvlJ+5IG1UH1Q0epkgeHhfk8epiLpm?=
 =?us-ascii?Q?Fkcv4b9pucHsjm7Zh4I98J9LA0Y6V6U0GYS6hkwTOC/0yHZ32YK6H/C9/TRk?=
 =?us-ascii?Q?WAhZxcftzHceJqQdjGq7wnJbTHZDyh3GJxkkJzHONNJ/PgZTAcYOuNyj0tyb?=
 =?us-ascii?Q?9BzfcCnI5jSrBkaQD37S7btzUKmUAmvXLJdB1aJ9YZuza6mrnyFMl9cJ29dt?=
 =?us-ascii?Q?zxTv73ybfP5jUWjZOagy/ZpSEhnJJ34ZI9f+D7nXGhxyw/67Xw/blNUWgtN6?=
 =?us-ascii?Q?A+Kj3j92DNWdtBZ+LJicQHu+hfWLmTYq+vF5Qw+1Ro0IjMF9e8nBiBjshBSL?=
 =?us-ascii?Q?LktLWcy3/lMymAVH1TIbk7dv1nxLcIOXovhuMt1slOTxhAyw/ZLSvU/pg0yy?=
 =?us-ascii?Q?gs389d/S7GAS/7elX54ckyeZVAvXGcXfE9irpmJurNu0jDwv0NYyrng3qxs0?=
 =?us-ascii?Q?B1eD211vHSSyi/4VKREGa7eyGjVgfKO8urRWWa5TS175PVq4AfrzjxklCVir?=
 =?us-ascii?Q?QcD6+uK53pPIxsC6lZdCP1ZEywiuT1x6SV8sx7ct0RT49FUhQnD1aWvwlOfB?=
 =?us-ascii?Q?l60mGPEXI62V81hbQDL/pB5Hm8b4dZwocMVRgXS2obbObx0g8g9x6PZmWLgV?=
 =?us-ascii?Q?W5m4MMAU3USO2VpsAA7we6+1x8RvecZv3lK708D6L+K6YAqTNVDGghqyYn9o?=
 =?us-ascii?Q?vqthyM+mEwoom1pWHhROmFlAO/DVR65jOD7wEKf/I71PiW2Iq5OS6n17qQXW?=
 =?us-ascii?Q?HmeYLXcNceOKydeTeVWilCk8dfT/dsptwA15rQx3+ZVys6i3PtWwERu5J21f?=
 =?us-ascii?Q?dICc/yESDaLpEokwSOyXkc8lowtgvQ0zZe6wWg8Yb+gYd7DDYGjfQpbabPQt?=
 =?us-ascii?Q?kyvQcdMvoqsB3YCDHyrS28clbfA1tORo++Mgg9ZaGOTBLeclNFWxPt+xxOAk?=
 =?us-ascii?Q?Jy7Q6+v8EEiMvTUDjdCMC8nRgQ5wBWmh5vxKIA/5WFKNQoMBF0UE7aWh11lT?=
 =?us-ascii?Q?3yvuS5VPLWJ/oZunoNPMC3Rz49LXoheRDgowWgHeivY7IbhCFfGmuOXaWsuR?=
 =?us-ascii?Q?OrDnjGD6lF26nY3UXB1wF82AqgHrWLUzhYRQoLvy5VhpYycaO7vb8kAQVHlx?=
 =?us-ascii?Q?PG02gXDs+U/XIUDQJ9OuL0I4b5AEYHfJRXw9q5mgUjN5QIWoQxylHHWTJieJ?=
 =?us-ascii?Q?4eTRtgBPwMLPx9m7N88H0DDQRyWhczDKZc0M9SkfWhcoN1rpV/KZfUGSTYZ7?=
 =?us-ascii?Q?asCgIG1vwhK1qykUJmsI+Aq/wZ548WArTAjtIbpOusIjI+WQCKbwmf9eNu4S?=
 =?us-ascii?Q?EynJkAYw1XVJk68xC6cb7tDKrYvM2i38aKkJcCPV8OlHVgVni4IJm0UG1QSe?=
 =?us-ascii?Q?lu1uALcelpDmmnUB8Pqj1RYufWHlqYDLd9uVcz0ItmwJwaqV6+IXnsDSg+zO?=
X-MS-Exchange-AntiSpam-MessageData-1: 8lF8yK/fr55Pyrjws5MZP/adcd9M645+Pb4=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e1a964-8260-4c54-08f2-08de6f280328
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 19:57:57.9361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOcATSiWdOn7JfU4Diy7BiIuqKiKF8TSodXxdkvz/WnHgeIXIou/cDgVA4wjJCGff90ML0DvlW/E9/UKtwW8Va1wgI/2YcGsKTebsRgIwoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7847
X-Authority-Analysis: v=2.4 cv=JauxbEKV c=1 sm=1 tr=0 ts=699619ca cx=c_pps
 a=0CcWBAfodXOgQTORYPtXqQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=4u6H09k7AAAA:8
 a=s42hmhtgp0YwE-nv9MgA:9 a=5yerskEF2kbSkDMynNst:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE3MCBTYWx0ZWRfX2fE/y//V2n7g
 nNzNefMnBVTAh0I7zdzTTAexGLPD+5g9n9CEWZw9/6AH7C7uoveFbtBR05sq0OiG3pPcm11i+84
 LbqWm1CXXd9EKeFe1fMp/g/VE0BGIGY8eaX9IEdBKBSdnPYdP02K66wVwAShzNnEHFns176D+YM
 RbwlWndjhekASRghJ+rG0o2l87no8+JqZ0OPUpsoBSeTwr6GtpwJBLM7WW6clGN2e9MeeP1ioal
 dL9BR2CbgF0xUEOnrrgomecX7IqsBY41MFf2OcUSDKNyMKcYmTzeO2esUKdeoAn/Spz0gbzAela
 aS8JdJkMy9N0ZnmiQILNd6AG5yRsrwb+O+wdtFnJFc8Q1lTr+I7Qz+AMmW6WFHuD2jIOL5LMzeW
 ad2UOLcwHdiIJeezCN7JFVW7fkeGqAkBzuKpTjp3DrHiaKgWmvhh6AzcHDqAYDdFLrkUYLirqmK
 1oI1tLo3STueJ6rd5vQ==
X-Proofpoint-GUID: AcBHFoqfHnU9ejNlCeEiK_IFg2N9txkT
X-Proofpoint-ORIG-GUID: AcBHFoqfHnU9ejNlCeEiK_IFg2N9txkT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602180170

Hi Slava,

Thanks for testing and reproducing this with generic/013.

Looking at the stack trace you shared:

  ceph_mdsc_sync+0x4b4 -> wait_for_completion(&req->r_safe_completion)
  ceph_sync_fs
  sync_filesystem
  __x64_sys_syncfs

This is the same pattern we see in the original report - the sync path
blocks indefinitely on wait_for_completion() with no timeout. In your
case it's ceph_mdsc_sync() hanging on r_safe_completion, which is
exactly what patch 2/3 ("ceph: add timeout protection to
ceph_mdsc_sync() path") addresses.

The root cause may differ from the original IPv6/EADDRNOTAVAIL scenario,
but the symptom and the fix are the same - these wait_for_completion()
calls in the sync path need timeout protection regardless of what causes
the underlying delay.

All three patches are now also on LKML:

  1/3 - libceph: handle EADDRNOTAVAIL more gracefully (v2)
  2/3 - ceph: add timeout protection to ceph_mdsc_sync() path
  3/3 - ceph: add timeout protection to ceph_osdc_sync() path

I've also added more details and debug information to the Ceph tracker
issue at https://tracker.ceph.com/issues/74897 - it might help with
your investigation.

Thanks,
Ionut
