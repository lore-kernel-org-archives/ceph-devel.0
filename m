Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260FE30499A;
	Tue, 10 Feb 2026 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770708230; cv=fail; b=AE7T8t902pPhoWvlAjAicv6Gb20on6e1TtzfHSFmXHyA3T8EpVrzKw35Y8uVEV+ES2BxFKTweS8KpRqzDTxrPQsqlOiFKiRRKBW4WcnO4UZbuCmfmW1l9OSFj6vG55Wa7KNYQZYWuATwdQ1ZqPhJBiDRNLfRQUvk2u2ar5hvoNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770708230; c=relaxed/simple;
	bh=6wiocPjS+hqraHC9P41nZ9MZPkMULJWbcDJUM1UY3fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P8KEemP6CjFy5dlRSk8BTlCC2teZ/LF+mEfAsiIs16oKHpPpqnbqzHjYbf+JxNH27rz2ce5GuYoHstXp9QpOW9O941cimf3eGaIlJtcRDz+0mo8t5oUmwEVYv3fNgl0xpgrp2BGtigdWR80sJsF/a2ytraIJnpYTWt4FXbKRWvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=q/p/z2/L; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="q/p/z2/L"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A4aSni1588094;
	Mon, 9 Feb 2026 23:22:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=0ydqtjqg9
	ff0cFTBuqyvlWt8Q1ia4ICfeE4DIrXVA/0=; b=q/p/z2/LS4DR4e9iXL5LK9M1a
	I2CFrryTHZ0cKI5rknerVQzpVEm2Z4gfBc312AU+KObt4761EpxrqgNXpWy9tTYM
	18ftkCJ4WZhv4y/KRh3QUKd6DZGhZPuCmr72K1yU8ugmjw4AENkM2lJ/RPlm6id1
	yeMUzGpcvoSrjyhV7WGtKBDixIMlFSXlqCHjEtbToS8Yl32u5Vprd9k0WvgtRXHk
	ylOI1e60IU0f14kwexUOtO1JQlzhTJuABwJgzr6gospPMtxorCyeTxZWPF1AOm2P
	G73+3nh+H39krElOfZObo1lCWy+rHDNPMhN1sz9KOB12XFTDsG3l8zC9xi5zg==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c65sj2mjv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 23:22:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUNFl/AG34Dmq2BddrC0ArTnuY4jYLEDQaph6lr9sHn3vWniTTd98ppfpOlitA4y67yPe5T01AUb7w6vE/LVHk/d7eTLX+wj/0fYAwyDuuDE0wUH3FVc/d/XalBgQWrvtRX1je51N60Us8gb4HwZDDVu/yPlr9or2AYwQs+WRW1AqmqYpHGEsgJm7XUBN2mMexzxKXo1w9u/9QdIrk7E+wscdRh0VEGuphSQ4wcIM+0NvKGg11ZDrPn4k1G/IGq3CYNi5ZvnEQQMslVSipUpxnUhoaVVdtiRG2jZ9uqDMMuSOCin0mgDnx6neKtrOXdperwXAC8A9ZqiB3zVrxvDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ydqtjqg9ff0cFTBuqyvlWt8Q1ia4ICfeE4DIrXVA/0=;
 b=vSnRVn7syqYJ2ceBQJknyyF3+TKOaG9wnSx8aLR/q/DmMcTdZkz24xPdBsSSefZAt2FoGKpcmdZDxeji95SRph7Kus82Q/MIjjaUA4E3rGmf0SgOP+RNmYHN+983/kwmGD4+qvXOwtU8FaYAPMJ4QR5HfGFIrKFyxEnRd19wl/xy77yUg67P6+zferh0sZ3UqoMY38UP1UfPlCIm0DDntqE6sQKKIMYgFK4nGQR/muCfjffMC2Ms/qyvU9rIFOaKEA+c3DtX/WcQ+yIKcjkOr6ImGNEuKGm+3BKSWAZ6B0kVbPM+BCfiEIKisNCJ3n79kR+EPT81n/wjGV3SwO3rNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by PH7PR11MB6353.namprd11.prod.outlook.com (2603:10b6:510:1ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 07:22:55 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9587.016; Tue, 10 Feb 2026
 07:22:55 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: idryomov@gmail.com
Cc: amarkuze@redhat.com, bigeasy@linutronix.de, ceph-devel@vger.kernel.org,
        clrkwllms@kernel.org, ionut.nechita@windriver.com,
        ionut_n2001@yahoo.com, jkosina@suse.com, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        rostedt@goodmis.org, sage@newdream.net, slava@dubeyko.com,
        superm1@kernel.org, xiubli@redhat.com
Subject: [PATCH v2] libceph: handle EADDRNOTAVAIL more gracefully
Date: Tue, 10 Feb 2026 09:22:43 +0200
Message-ID: <20260210072243.16169-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::17) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|PH7PR11MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d5c83c7-a39f-4124-07db-08de687535a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7gS7ENzTZpP8szVpyyZd7ZdqIxulifZjhjPK+Byhd1a4jLRUFV8tCa+txUvj?=
 =?us-ascii?Q?wtMa/AxafskkjaCXTQx0Hl491//XykfcJJF0buTmS/L5GsrF3vBo/HV3jIYg?=
 =?us-ascii?Q?7dZcXqbHYyMRB9JzPL7ntbZoFSYRFyoyXlZ090cPDQgGnEHUDGfle42MRuvn?=
 =?us-ascii?Q?iz4eDKdCx+Z7vnJUS4IB2XwWQGsXv7CApPWbuDcKY2la0sEPfkn01u/bWB2F?=
 =?us-ascii?Q?rIMuJcmQ2hg75KV2idIVzI1qnUpVencMISWWHeSnvPizidzXAOODw+Vburl3?=
 =?us-ascii?Q?FfK91iIQUUCTJ/R4B5j0P7szUYUDOyJis4CyqoEkSPCoasXvzFZ3SM10jy7a?=
 =?us-ascii?Q?/C2JSk6PI2qVxBmbR8ShE4B1VpmIb53jbBMXemsy1udEKXTH+sxfldTG4RgJ?=
 =?us-ascii?Q?zEd2Clw5HE3hNl4YMEwhURtGnSygflfk2lw40SKSBzTdCYjH2EKwTccGHeK7?=
 =?us-ascii?Q?Y2mkF4WubzdXboNuumSlcwAebXcpab6zIBCuuSiSEnCGUU3a8R+AGiju+sAC?=
 =?us-ascii?Q?yjEA6abVdMTZI7eqTEiLOcnYlEO4MzO/oyJxVC9xznlqbIAqaTwCQGGmbIWK?=
 =?us-ascii?Q?LRiegv91+cvPIgV5wTSK1pePvtjER3DLpKI7RC/rfIbgnmx07xCeR1xVjOqw?=
 =?us-ascii?Q?n+iP9U3iEnP20IRkZKTiU498IXTd+pz4wxanVxntleRSzXTAJDyHFrpRUKLR?=
 =?us-ascii?Q?KFfdv3tFhuY7gxzlVltsFQDe3QNUa9VPN3bhLWTpNF3hyHvtcghjlUVQeLrC?=
 =?us-ascii?Q?yPcEgdMKPf/zlL9GU/3EFVlXk8ymzhohN4L944Z0PUaXRZlyjtbU8ty6qcAm?=
 =?us-ascii?Q?SnsZIuuCiUAPTBGnkMlEGSXsjfGki4x6QT74tqmSE2UnbZUmKKXSLW9LxAza?=
 =?us-ascii?Q?Ii+SG2mQqemawLfLc6RTe6o37NpyfO03ZfXW56mxOU1riTuCfTRO9FBmoUP2?=
 =?us-ascii?Q?WNV0Jni5MJDV2myrWAhdrc+zXXt9iTVDXXKvr3bDmzzj0di7Fw/R9dFjtA9Q?=
 =?us-ascii?Q?xV6w990TZRK71/mfs6ugSfMbsFI0YHTq6fmd5kdFOobpIKZL02k3fjAfWXkT?=
 =?us-ascii?Q?9jjfXq0g7QtaISkoyOZ99gsukM5sYk5YDmThetooMfG9omOsWw1UQahRx5Ik?=
 =?us-ascii?Q?kTIEkawJvo0QjzDw3jK5CNe6MyhfJIdNCLYwhUeYVb98VF/jA7mbcwIhOdx6?=
 =?us-ascii?Q?xE6vHQVHd3MY6jZQ5RTS/unzZUwoOrsoPRwukAlrDNsO7aoDojoZhEYr6iGT?=
 =?us-ascii?Q?IbQA4QPTZkknUNg49EBZlRnOQZHoM/hjT0XJ8d5EN1NDTmrlYJ5RYniPyxea?=
 =?us-ascii?Q?/JbXyswCatUfrGkPpZTnmudK4mLTDQ9jDICTWTk2u7l4R4Qzbs1fzz93g7R2?=
 =?us-ascii?Q?COCw0/1Dha5qNdGHJN0tgNRWkhcB/Qlua1LCRTkvQOFrEO67BC2NbcEfDejR?=
 =?us-ascii?Q?j1hGruoLWfTnaH4fs4Byc3B80rUsh352WRr1ZC1VYaLGetlR8qCugMAaJnTE?=
 =?us-ascii?Q?2Hd10VrfUC7wDIfVPlsrcImAIZxjucUQ3+MWg6ldOA/xiUGyBf6Gp3QSKPnn?=
 =?us-ascii?Q?xo/2T0mXRIttcK2OVf8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XTONgZqa3lKjYoh3bNTRuGLF2axgxmVqFJ0TtBxkD34G60JttaOC0gEdP6I6?=
 =?us-ascii?Q?e0gwfxQ0oISuAsOGI1h2Ex+yizz21sLHhpkT+kStD1vfwCPLTQW457gTJNLb?=
 =?us-ascii?Q?s5cLYIuUCrXGUwgrandWKyzSdyOBePRRHJvZd0Enuu0gIM+8kkZ2sjg5knl4?=
 =?us-ascii?Q?fkVumBN6/FQRniae8l3oFBlJ/3bhioUS4ruSxjrSz6DPEe63JYogLOQm9ZSq?=
 =?us-ascii?Q?QkIZqlCtrVG+yRj/FjrV9cEyn8IsfsPp4lM1kVNpCHD/FQSkYAaNfcBed1zi?=
 =?us-ascii?Q?cHL97SO0VfXpaEYmQ0ia49bTdGlC77+2dvFYml4TRrHHRy+7XHg3J9CjTTRl?=
 =?us-ascii?Q?1KQjoXLwxGW2liRInjco+7eekNTZABoWcECYI7W1Ku+Hpnxs8uUavcut60ZK?=
 =?us-ascii?Q?V4oCoiHS7pELeklDSgk/n20AnATf//6Gaf9c/q5/WuiiQXe8ob2s8pU3dXLh?=
 =?us-ascii?Q?ipyZaX0N3mc5xHr7UCPXhwtFguRXhoRsHpbNNcY4TfumDlu5dHBAJAY91uU0?=
 =?us-ascii?Q?vbfWVr7ioTw4OnXWkwGleIHv0gDbmxfzRYmu0S11KWg+L3w+rQO0B3egMXFE?=
 =?us-ascii?Q?G0irbphvYYFNmHhufJYCD1sNljQ+hy+YZr+CfXLK7BvWHaiphviNkx4G67Yw?=
 =?us-ascii?Q?EH3geUeedN5VyJ8KPN3attCeQ9WCJjjE5Z4ETqLxkjtDuh8hpNXsPeZ1LOJj?=
 =?us-ascii?Q?yz51sf11NE64rH9YHz0aBLaU0T1Nxrx/KsUjsgm+8o9lytEJJIqAnlQ9Dbzs?=
 =?us-ascii?Q?zb/ecGLnPOeemXHK+3t73Jpv/nUmDLoMnHs1tzqQvoW9iOC6cJsN6MB3szeN?=
 =?us-ascii?Q?4kDlLEPZDf3njLBRjoWo8xWGAI9wkDt//N1JJAdcefvGUxvsKs8a2YOSuMQI?=
 =?us-ascii?Q?DvOs9gyPubI76ycKDGGh7W1biXLzUVR5MS2xdkubgnbGlsdWjL4rtWseUDxB?=
 =?us-ascii?Q?GGBGwGvMNBnkjM6QXfVhMCLhjsuB6sKDK2HZfAJ90wSVxda1n1U2JlLHDJ4N?=
 =?us-ascii?Q?Da3FYC0dA9u96jCjx9qdV69o/JUXUKib2z37rLvry+w/J65yf1tnNeRV7NoY?=
 =?us-ascii?Q?9LPTa+4hvIuL1ugdFYo3MJRvKu9wRombSimrRYLp2sSK4r3JnmB807EwoR4/?=
 =?us-ascii?Q?EIcNdS98rbSGQMLHZ6x0Nd9Tvq1m2Va0T9YpcSle/0ddHfg1z6FrnugZwXYK?=
 =?us-ascii?Q?cDZYytfos7L+kx0YgAGBkIJqKZD++L9exs9nVF/sxINImORnqPQqnQ6MB7pE?=
 =?us-ascii?Q?j1gGRy8A7IYV7leawLj1uquXzRQSLG1jR5kjW+K3ItUt+y74hPu8x2rQHnDI?=
 =?us-ascii?Q?kmyErckS/3ioXosSwyciMidlgwYB/K6RJe4nBY6mZW1ioPPRD8jeZzVL31eM?=
 =?us-ascii?Q?Y1P2ctTfM2QPB+zYv/o++C20sHiMOWQp1cQYOygP6bcB0wugVyBouC7Ed7SM?=
 =?us-ascii?Q?QzTsgO5Cc/XCkvK20XMIJgNl0ZCKdxD3zZBa0rd4UKcz4NYbkEGUZ4Ebh25v?=
 =?us-ascii?Q?/prK0u/663mXrFjq0n2nqdlPVlSaQXRUIUP7W79b2DNEkChO7pXLlv9meHOS?=
 =?us-ascii?Q?l66mIrjh3869hO1jm18BAzMYbuwfmM3wrRgf9HfjNK6v+Ap28BgDC5CRdvHM?=
 =?us-ascii?Q?CH1kVFiWgFfhNliJpmuWRdlzgeT4naFtmNSPUBpoXAby/zop4akcVb4wxJM7?=
 =?us-ascii?Q?/czGMDeaiE67f3DNZXAXlDRAiE4xmKMARE6ZJpM1DbwdbvchLy/yI3rDxKu4?=
 =?us-ascii?Q?qBTB/VyTMVhEc3NRvbGoJ7JuSir6HoUwFBAh6Zn1WeGff19YIof5Zlmb6QYD?=
X-MS-Exchange-AntiSpam-MessageData-1: yOSIr5veNXIWgE73migN4DjDALRpHOtSwMQ=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5c83c7-a39f-4124-07db-08de687535a0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 07:22:55.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFPtue3N4hbKvihUe11MxVdHNB/blffWjklN4XXj8KoN+z+4lwibljb9CH8m50SUU0RQi7rWVCvlqQS0y9XyTAUPm/lUuvXwbFfgmw8R1vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6353
X-Proofpoint-ORIG-GUID: CMhcRb9sqQcvDwXXORoYI4-PKNJtnLvY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA2MSBTYWx0ZWRfXyTXgwigGzMi5
 /n7hojBIXDplYFZqVqI+Bj8vels+tZbaSY3Bhs4k8MqP6/do97IPOIcmrPAQVAUSIEAVwr50bvZ
 TvZ3ZMCAnBp7VE8/rFi7e1EGuASfS5Z0pi6XhLFhKFzSOeAghUxctJ727IVpU2IQngkxwSPkTp2
 +kMcyMnd8qw9S+1PZLqAA0lUAm9hr+q9DKX/a8K/zkSbFrzR37DSFqhfMBvnLCU1WUaxJOj725O
 5oTCq+8DwnHdSoRrOOKMnWiWXsMaK9O5hFANgS+S7rYQV+y+o8fNknZj019+/YxZ2n4gserdOO7
 n8qIwf/tasshhAD2SnowMpomZ7EnLcZ/8Zm/ZwgGXHTB3qyrWYVeFTHF8YQSU+HyMVm8wR686Fn
 ayrx2zuO+SmA35UGYXnXz9IApAo4J3T37kDqz4SRzmPI5eMtMcN5AOyOf/LTK4eYPlD2QE1WYpx
 uf2jkgqcegSpMBseMWw==
X-Proofpoint-GUID: CMhcRb9sqQcvDwXXORoYI4-PKNJtnLvY
X-Authority-Analysis: v=2.4 cv=Cpyys34D c=1 sm=1 tr=0 ts=698adcd1 cx=c_pps
 a=6KPqUB2zuHFFswelnWAHBw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=t7CeM3EgAAAA:8
 a=1uu5jfe8Kc4fJiQIugQA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100061

From: Ionut Nechita <ionut.nechita@windriver.com>

When connecting to Ceph monitors/OSDs, kernel_connect() may return
-EADDRNOTAVAIL if the source address is unavailable. This occurs
during:
- IPv6 Duplicate Address Detection (DAD)
- IPv4/IPv6 interface state changes (link up/down events)
- Address removal or reconfiguration on the interface
- Network namespace transitions in containerized environments
- CNI reconfigurations in Kubernetes/StarlingX rolling upgrades

Currently, libceph treats EADDRNOTAVAIL like any other connection error
and enters exponential backoff (BASE_DELAY_INTERVAL 250ms doubling up
to MAX_DELAY_INTERVAL 15s). Additionally, the monitor client has its
own hunt-level backoff (CEPH_MONC_HUNT_INTERVAL 3s * hunt_mult, where
hunt_mult doubles up to 10x = 30s max). These two backoff mechanisms
compound: at steady state each monitor gets ~30 seconds of attempts
with connection-level delays up to 15s, and the round-trip through
all monitors takes ~60 seconds.

In production on a StarlingX system (6.12.0-1-rt-amd64, Dell PowerEdge
R720, IPv6-only Ceph cluster with 2 monitors), the EADDRNOTAVAIL
condition persisted for ~36 minutes during a rolling upgrade:

  13:20:52 - mon0 session lost, hunting begins, first error -99
  13:57:03 - mon0 session finally re-established

  ~470 failed connect attempts across both monitors
  sync task blocked for 983+ seconds, triggering hung task warnings:
    "INFO: task sync:514917 blocked for more than 122 seconds"
    ...repeated at 245s, 368s, 491s, 614s, 737s, 860s, 983s

The duration of EADDRNOTAVAIL varies by environment: it can be brief
(simple DAD, 1-2s) or prolonged (complex network reconfiguration
during rolling upgrades, minutes). In both cases, the key issue is
that exponential backoff up to 15s wastes time once the address
becomes available -- the client may sit idle for up to 15 seconds
before attempting to reconnect.

This patch bypasses the exponential backoff for EADDRNOTAVAIL by
using a fixed short retry interval (ADDRNOTAVAIL_DELAY, HZ/10 =
100ms). This ensures reconnection happens within 100ms of the address
becoming available, rather than waiting up to 15 seconds.

Implementation:
- Detect EADDRNOTAVAIL in ceph_tcp_connect() for both IPv4 and IPv6
- Signal the condition to con_fault() via an addr_notavail flag
  (per-protocol: v1 and v2)
- In con_fault(), use ADDRNOTAVAIL_DELAY instead of exponential
  backoff when the flag is set
- Clear the flag on successful connection and when reopening
- Use pr_warn_ratelimited() instead of pr_err() for this case

The fast retry is appropriate because each attempt is inexpensive
(kernel_connect() fails immediately when the address is unavailable)
and quick recovery is critical for storage availability.

Fixes: 60bf8bf8815e6 ("libceph: fix msgr backoff")
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
Changes since v1:
- Corrected commit message: removed incorrect "1-2 seconds" claim,
  added actual production dmesg data showing the 36-minute
  EADDRNOTAVAIL duration and explained the two compounding backoff
  mechanisms (connection-level + monitor hunt-level)

 include/linux/ceph/messenger.h | 11 +++++++
 net/ceph/messenger.c           | 55 ++++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 6aa4c6478c9f6..ec08d02a9d4bd 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -321,6 +321,13 @@ struct ceph_msg {
 /* ceph connection fault delay defaults, for exponential backoff */
 #define BASE_DELAY_INTERVAL	(HZ / 4)
 #define MAX_DELAY_INTERVAL	(15 * HZ)
+/*
+ * Shorter retry delay for EADDRNOTAVAIL. This error typically indicates
+ * a transient condition (IPv6 DAD in progress, address reconfiguration,
+ * temporary route issue) that resolves in 1-2 seconds. Fast retries
+ * allow quick recovery without exponential backoff delays.
+ */
+#define ADDRNOTAVAIL_DELAY	(HZ / 10)

 struct ceph_connection_v1_info {
 	struct kvec out_kvec[8],         /* sending header/footer data */
@@ -361,6 +368,8 @@ struct ceph_connection_v1_info {
 	u32 connect_seq;      /* identify the most recent connection
 				 attempt for this session */
 	u32 peer_global_seq;  /* peer's global seq for this connection */
+
+	bool addr_notavail;  /* address not available (transient) */
 };

 #define CEPH_CRC_LEN			4
@@ -432,6 +441,8 @@ struct ceph_connection_v2_info {

 	int con_mode;  /* CEPH_CON_MODE_* */

+	bool addr_notavail;  /* address not available (transient) */
+
 	void *conn_bufs[16];
 	int conn_buf_cnt;
 	int data_len_remain;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 70b25f4ecba67..d86efcfb7b87f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -467,8 +467,22 @@ int ceph_tcp_connect(struct ceph_connection *con)
 		     ceph_pr_addr(&con->peer_addr),
 		     sock->sk->sk_state);
 	} else if (ret < 0) {
-		pr_err("connect %s error %d\n",
-		       ceph_pr_addr(&con->peer_addr), ret);
+		if (ret == -EADDRNOTAVAIL) {
+			/*
+			 * Address not yet available - could be IPv6 DAD in
+			 * progress, address reconfiguration, or temporary
+			 * route issue. Use shorter delay.
+			 */
+			pr_warn_ratelimited("connect %s: address not available (DAD/route issue?), will retry\n",
+					    ceph_pr_addr(&con->peer_addr));
+			if (ceph_msgr2(from_msgr(con->msgr)))
+				con->v2.addr_notavail = true;
+			else
+				con->v1.addr_notavail = true;
+		} else {
+			pr_err("connect %s error %d\n",
+			       ceph_pr_addr(&con->peer_addr), ret);
+		}
 		sock_release(sock);
 		return ret;
 	}
@@ -477,6 +491,13 @@ int ceph_tcp_connect(struct ceph_connection *con)
 		tcp_sock_set_nodelay(sock->sk);

 	con->sock = sock;
+
+	/* Clear addr_notavail flag on successful connection */
+	if (ceph_msgr2(from_msgr(con->msgr)))
+		con->v2.addr_notavail = false;
+	else
+		con->v1.addr_notavail = false;
+
 	return 0;
 }

@@ -610,6 +631,13 @@ void ceph_con_open(struct ceph_connection *con,

 	memcpy(&con->peer_addr, addr, sizeof(*addr));
 	con->delay = 0;      /* reset backoff memory */
+
+	/* Clear addr_notavail flag when opening/reopening connection */
+	if (ceph_msgr2(from_msgr(con->msgr)))
+		con->v2.addr_notavail = false;
+	else
+		con->v1.addr_notavail = false;
+
 	mutex_unlock(&con->mutex);
 	queue_con(con);
 }
@@ -1614,6 +1642,8 @@ static void ceph_con_workfn(struct work_struct *work)
  */
 static void con_fault(struct ceph_connection *con)
 {
+	bool addr_issue = false;
+
 	dout("fault %p state %d to peer %s\n",
 	     con, con->state, ceph_pr_addr(&con->peer_addr));

@@ -1621,6 +1651,19 @@ static void con_fault(struct ceph_connection *con)
 		ceph_pr_addr(&con->peer_addr), con->error_msg);
 	con->error_msg = NULL;

+	/* Check and reset addr_notavail flag if set */
+	if (ceph_msgr2(from_msgr(con->msgr))) {
+		if (con->v2.addr_notavail) {
+			addr_issue = true;
+			con->v2.addr_notavail = false;
+		}
+	} else {
+		if (con->v1.addr_notavail) {
+			addr_issue = true;
+			con->v1.addr_notavail = false;
+		}
+	}
+
 	WARN_ON(con->state == CEPH_CON_S_STANDBY ||
 		con->state == CEPH_CON_S_CLOSED);

@@ -1645,7 +1688,13 @@ static void con_fault(struct ceph_connection *con)
 	} else {
 		/* retry after a delay. */
 		con->state = CEPH_CON_S_PREOPEN;
-		if (!con->delay) {
+		if (addr_issue) {
+			/*
+			 * Address not available - use shorter delay as this
+			 * is often a transient condition.
+			 */
+			con->delay = ADDRNOTAVAIL_DELAY;
+		} else if (!con->delay) {
 			con->delay = BASE_DELAY_INTERVAL;
 		} else if (con->delay < MAX_DELAY_INTERVAL) {
 			con->delay *= 2;
--
2.52.0
