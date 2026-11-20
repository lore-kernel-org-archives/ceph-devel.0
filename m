Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160128;
	b=jnzdiiOoKX3CoegxScN2ZpYf41WXpTMCJhkhxJp4WOn0hTRfK72+jU9oscbP0H0oZwGJ
	 6fxa+fNQl5mLuGauoJZYWf2Tc8lHrg5y2IhZTu8ZEeyuYgxNWNhNgCBRdP/9cVTZheeQd
	 II926GIiHfd6LwtqZXuMStzpKo8wpVFRMr9scyaJSbxM9Xqk20s/N/4JZtXUhBThrs3LK
	 nIHzpwAD+0dU87zPr+Kmeqn4wlIzh+9CbWTg7RnGBewye5THGfJ49aThnfroTJ0zOr9bp
	 a9HPJLqjwgkrkZmBz5AfctFtTIwX88qWGDnwHd3lm5DzoCVOt0XlsrA/GtrlLExwhOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160128;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1DjlWnE2NF20rXLtxQzB4Tm63wx2DoxkcyyjRGOzRsY=;
	b=MhGchGfANVH/K2jZDAZ1JEpkTJgW4oYszz/dGV3nZvC0O0tBIPvDj3d6hu9ZCAMnfdKJ
	 h+YFWMR94UNtx4WOHxZW2mjaiqDUK7knviYXF8dVxJYzmX47uRPXmcn+udcf3weMQGTmQ
	 ba+TIH7X6xfyrryVV4SP8Lnsv1Cic3M9GqPEOCHxSeQLQa0WAi/ikO2urLRuPuQ3PugOu
	 F/bP6/n873Aqc6611hh7AL07xZRyrTblmDmUtmL/XRf043cALZyu0DQz0O87l6c79cVCZ
	 lgQ/GRDpyfoS5vJXUaPo7V1OWp6oOblyyOjHT/ySRjdY3HF354tGiw9qy/98TuWzVqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=mRxaOmdV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.178.238
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A62606A325;
	Fri, 20 Nov 2026 07:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A62606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=mRxaOmdV
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3TRQg245230;
	Fri, 20 Nov 2026 07:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=1DjlWnE2NF20rXLtxQzB4Tm63wx2DoxkcyyjRGOzRsY=; b=
	mRxaOmdVvZJcyohOIzCHTM28wKrrC2+lWKD0BQyV8hteIGsxAlBLvUjC290cs+iq
	CGicwCMR3wRajwykNASiU71DI/mUbKujue0NT3DE3LSTbgSpV8XfK8dNHbo2UIKj
	uj8NBnNFM/xSXtq2fRpe5EhJ4cB/8s1M9fCmhGzpiKsSRmrs5qBr0zKbu579VqQn
	2/RY2XpGxXlDfJseJIkgKvWGG1RIEuf/3WA6VpTNf1Ta4Y79FTIzrfwi61MmXyTo
	lKbUF1biisUf1MKfQF8pXpnX7CiHa5t6I6/dUQu09xjyi0KU6e9Z7vrZTN5ce/VT
	tbAq+tEUIjx6nJAIUk5gxQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022110.outbound.protection.outlook.com [52.101.53.110])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvh8b2b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:35:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsQW5cF1wmFv7QqH+fkunHBRWLh8kEn2sY1eti/MdsFQ7XnhgP3mUHC0NKjfsKQrcO/k75xfg+08Pue01WPw4ermV1Xa9d+MuYBeInphsTvOU5QhqudQPRbevHtMaOWgR4knrN1MdBcjJbvfMANoq2HEJc2/NtQ4+B8/iPSWl4zJg1Vlrt4EfaIAKilhrQt+5KLIJAHIVRqxbCAW+15u2TasfceIO/WHkkBJ41CtsqA/PKX4pzRkfSxEKF7PwsIhig6KYubNt/RsKxcJdKZfn+pfYwgd33+78axRq5qx5QwcZB/tn3FCp/MeE/QhH4wOBz8bc+6ZFdIUG32rV5ipbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DjlWnE2NF20rXLtxQzB4Tm63wx2DoxkcyyjRGOzRsY=;
 b=RIS2UVIsyAQ/ThHr453Q1UXlnREB+YqkDD5KfkvKI33PXQX2Zu/XFlX4tEH6V6RU4VfiuIb1mB1+5KEJkSGFIRBGO7KhgDCIb+ObWZN7TCe4AnpDxxm3sy+dD1VCaZD3I3xvGCn7TxZc8YXZYn+kj1LJheNOfBD+mj2HUaIhs4Ek9BE2+inECjRBOcoTAZQ1I339sNBW4i9yISTX27CkQhjf8HwNzU1yLcwIdal2IFcxYbxoMB4byJR8z3SSFTw9kNeag7Tig/eJQ+UtWMWni/NLRCxZ48Oiq1PD4UDYwic1k5QPSkVnutbxBISAQvBNckll0q9mMxiFra7kLgGicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DSWPR11MB9821.namprd11.prod.outlook.com (2603:10b6:8:4e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 07:35:06 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 07:35:06 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubo.li@clyso.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] ceph: request a full mdsmap when an MDS stays unreachable
Date: Fri, 20 Nov 2026 09:34:22 +0200
Message-ID: <20261120073431.53636-7-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120073431.53636-1-ionut.nechita@windriver.com>
References: <20261120073431.53636-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI4PEPF00000142.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::89c) To SJ2PR11MB7546.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DSWPR11MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: b872f3f9-7f8c-4d82-a4d1-08df46d8cc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|52116014|366016|1800799024|261022105027099003|10067099003|261022075727099003|5023799004|11063799006|56012099006|261009223027099003|261021123027099003|261102123227099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lU3scqfC1wa/FvJVKegIqNGCBppC21W1Az0NFZxnXWz7xQiqj9AS7nFobGjdhQs5CeHQ1DLWwvt9fI7FdEf/TeI0n8zHpE5/qDBrdoXQT5kholpH+ppdq09wy1ygtxugkmq4u+Ccpv6sx752JyxSJ08hTV+2TfbQebHCy9tDzqM8MjGFnXiHA2Mtg6njukAV4BqY8G/lveK2DQE6zxwMsquc3qJBwScKpcg2/BOB58juxd3UL5EyHVQQGnxFLyotN5R9yGVsl7Spk3F2ZrFPqu31b4OFXzGKh2MzjLuavG0ZQ7Ubk6DpU1ioVjvpm0/52moMrYa0XF64JSzxKcBWjSZkZoU8IJ3Qr9ifUOgv2qheCixLzA/tk3+88a0R1g72zgK4IzJZFg/6RFdGI0+3UCmFxusVS2i94Aw6TLB5VqH1LPkVdQJ1IvZwz4w7tQcmg4g8UqA/IfixSieqm2Zj8tR2/5qRbmdPe20kjBmJ0E1/2zbJEsi0LHfDiAEJ1AghjHQZ25aB8gsVSNAdUObvov55Y/ZdJHSdDijV9dYIRf1Uilvo6ckIaPacR5Hvcx0HXpxzBg0rwIjL06dAetflSeLt2omcYbxbTWhuiHY/QLODNJ9eKDB+RlE7gsq70kY7OVQ0ZJTjX5N/tDCWnFkR5RtYl7thL3+YePse3M6su5w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(52116014)(366016)(1800799024)(261022105027099003)(10067099003)(261022075727099003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5COAgCyPSr1JVFsRrpm8RJbuAGZw2uBm9BUf7+1xXYzbwKnZrpMqBEc+2auE?=
 =?us-ascii?Q?gs2LktkAznty2DQA+s5I2pTRMtjByoRZySEDfk0I6bHQKI61J6YtpCsDN7Wt?=
 =?us-ascii?Q?WyBR3BAsFIxjzl4T79nEVTT7kr1KUR4SLaHEASATHcd1TrSqHk2QwILQH205?=
 =?us-ascii?Q?Su0AGARqaRk4/ZNwRtzER1tsWDS6q8R01YEMvPmucsdsCa+HYiUOyDW8Se1h?=
 =?us-ascii?Q?i3aLr61k2eDOUm/3T3czg8rY45zbKuJbylD58CdwhEqlJCvpik6Orns006Ud?=
 =?us-ascii?Q?WZHejNTc0vGi9UHBeFoJFiLCDR5yGPPlItx2Yz9yhR5PYYXho73FFdeLae7b?=
 =?us-ascii?Q?nLmkxrcvQY1Aq8EjnARmVV6LlDA9jcEQz6W7u5Vt7hxfjDCau6uXmWCVk9lA?=
 =?us-ascii?Q?ZQynLRsulG6Q0ZnWV+4XPm4MOt4giwL048+C7R61TCpfACENTvQWGfN5PyB9?=
 =?us-ascii?Q?705jD4swUm1kDsIIAEmOLAemVK6zwKYowXf9fmvlnn38LiM5kfobBc0Xg9MF?=
 =?us-ascii?Q?eZV7UdpZdTYQi7uVnsTwGyApaUytSajqQ3fdxD7b7MvQtImZhg+NzjWOid5U?=
 =?us-ascii?Q?Om54l9e4Udludscz1KbhtUa3lLCXRXH4DDQyNljIRJ17oWI+zqWTd0g06LUr?=
 =?us-ascii?Q?NW+7BOIaCrg82NEN5n423fyD6o0RxH/8RBVLskDuRRBjtHHT20SAns2+a0A9?=
 =?us-ascii?Q?sEV4H8u1tx0C93kRTgtOvp4K9kUopzG5M9LjIs/oglW4dF+5ilbWPdap+849?=
 =?us-ascii?Q?X/LWC8Dw1gMTVVvCby+ilKcgCB7RlIRbvaiylwpNWP81WtWAbDRoZFNcHObJ?=
 =?us-ascii?Q?3OLGrezR9Mx9WFonplV8LwgzOoZv3v4/GYq1JMuZ17U3mZ1egvKq1rvTAVj5?=
 =?us-ascii?Q?zzINwTOImFb7fCxBYjKwCGDRM9ALiQZcqBaTY/+FjXCCXw4EAkUgiU9cnttZ?=
 =?us-ascii?Q?PwfuzmdnI6Jc7SB4JTsLFMwJOfyzpdWyFG+xhUrXe4m8CQzDJWLXz4zm0/LX?=
 =?us-ascii?Q?SEXRK6fiwn5lxoD7iuKvVE8P5r4EEmox+3f5QS+hzXhkvlHuDrRlvvhl5Q93?=
 =?us-ascii?Q?dV7BVUPzA3DMdSmFcMM2+cNqGH34FqFc14aNN5Q82bpVCt4JPMIuPfwyIdWr?=
 =?us-ascii?Q?oXeI+kkPGfdAHFZx1Qs6gDTsz6KvLQL3Q8osVQy30mwn44lArkJtWKJ4BSg7?=
 =?us-ascii?Q?hNsr9EadbabMx6/HqJ5bDxipwl/Qgx/9qIaakWf+TpuY88lo+c711HUguwMd?=
 =?us-ascii?Q?hXCpeZPGqVeds+9XzxKA+5g9xlnd7YXLEQYzcwRM1k7/73aiUPPoW8zEA/T8?=
 =?us-ascii?Q?hz62Ve22beojeXDB7voI5yaA/fL5IaIjsNwpRH0J46Ebr2hnq0VkXP8TXQlZ?=
 =?us-ascii?Q?wHkyDgaMBizQ5FeVy0zYc3/fC43mrZ6wvPhl+AOif/f/slHL0rWMw4gkKCiz?=
 =?us-ascii?Q?alhkF2IaSbgB5TCoEfbYk9kZyVzDlEqG5INYoOu//eUBXpe/iPbPbjFQ/eTC?=
 =?us-ascii?Q?qjCq9mu+i2XWcxPdd89IcmEoB1ugRBU1jjsfBUEG8DuEeVanq1mMYZ6aP/P4?=
 =?us-ascii?Q?PlLsowfWaY2AKdkDS+oBUbw7Z1yESRqZ/vOoiqy0+Ya/N8ksfSAZDYyOLFlf?=
 =?us-ascii?Q?H8RQQzLKWdzKmunTfuHq2cI+/TvDcK8j8KIWcrg/wfWXRfDwgQv6igN/+7CD?=
 =?us-ascii?Q?k85FW1gxrbRLxQ02K+pZtXGpK3/s1NXKMQTJnW6WojtCagMIr5BeG7YJOK7h?=
 =?us-ascii?Q?WyA4i9mIbsnMeg7ZsdoFBRq1HXQcXE6mnWIIyw0raxOU8nw7Q7D15v7c5jkC?=
X-MS-Exchange-AntiSpam-MessageData-1: zZ+shIzhRUhC+NYOXmjUfZkW4f3M/vAefvI=
X-Exchange-RoutingPolicyChecked:
	gMJ5zUC+lwaFP1BSlwvoHICJyLcrxnjDX6tDGNdKqOHdl0SBHIVFpqPasXehMbJXxgMK/QqurCeVdlcrv9xvT+rRTnHdjgEBH0Ui8F+207ZbmYOtuondaRoG+mOKltnlD/pk2gXnQ4aUtK2AyUjgQZXJnkeOrmcEVQQ1HJINeXwDpI4T0xHWlVHDgpzoDP+CI6XhTPXO3YiyL6Ide+B2pZHRPJ1QWSKTnDK4JIwISqelQQ4z1nYpd/x8JNyXbDcnLg3k7Z4BKKKBmFcjq1zR3BJU7cr16jAcUZbZ91ky1pw4w/ZSCrwI27bMDbtJQKQ7QOJdEb0AdbITp4RZXy3r8A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b872f3f9-7f8c-4d82-a4d1-08df46d8cc0e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:35:06.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZvcf7eah77dgXZllTC0MdCX116TRS4OMlQUEe5c+0p/yozMWNf3KeD2OHYdov1ZZcp5NVuod24P1MHXYEsF9jop1nyTFSn92r4m3TOOCWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9821
X-Proofpoint-GUID: i_I45CfI6KIacU4iE9jZz9t8waC0DoyT
X-Proofpoint-ORIG-GUID: i_I45CfI6KIacU4iE9jZz9t8waC0DoyT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfXx0joZc0/Msvy
 nZSt63QhYKCQVi676e4K2rIMZGW70jHMj1O/WmaduQLiEqt3+8qrN7CzlVpKhAZFX0IgHurIvIF
 lMgzg4WcighGXnB0QXhSEmm5cGJr7JoXIojNa8qCqBri1k8qNABxAC/6FgzUmp1WBvMBedxmQqZ
 5uBtk635hSk37uRFYus40xA5PNrv9+8Bs+ZAsWbm77XvZe7wkG2sdPFG4jrQAIXu27a8UsVm92E
 QHJFBCQm80Za9dHeHKQQIP0d5GCQShfTpZnGTGLMHNzeurrmfh5W9S6pjCNLKMhYV0lV25Zs/t+
 8ntGMrpCAFAPUG7TxNlYWu4Rga4jeCLCGYDxVlkkMpN26I3Ne3JPPQcbWyxJrmAsXKBv5sMd5It
 SdtCsQwXvMoNzq+qn+vPi56DRLSSvx7PA6knq5Qn2wLq7CWRMnCmz0YaSKKROLztSJ3zhASjF30
 FofMcm5iIxhBVbppqAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX4OMYUA6Otu54
 f3c3QIyslEAe4ecQRT335zJGhdLVcZB1d3RWYDe87jSksMiAZTAZ6uCGKXogN0zcqDUA38L+Dx/
 E23n1hV1PWJldl2ahW/wMXpIuZcnh2SG5beqBDcPKSar4URdaZFM
X-Authority-Analysis: v=2.4 cv=GNCdgeNK c=1 sm=1 tr=0 ts=6afff82b cx=c_pps
 a=E5lcl6OKqxSDDTEGn4Qc9w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=sEnkRl3NJ9bUhnf8avIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200029

The client subscribes to incremental mdsmap updates starting at
current_epoch + 1.  If an MDS restarts at a different address while
the monitor session is also down (e.g. during a rolling upgrade in a
containerized deployment), the client can miss that update and keep
reconnecting to the stale address indefinitely.  This was observed
with the mdsmap stuck at epoch 53 while the cluster was at epoch 68,
the session HUNG and monc reporting "have mdsmap 53 want 54+".

Nothing currently reacts to this: mds_con_ops has no .fault callback,
and a session going HUNG doesn't touch the subscription either.

Add a .fault callback that asks for a full mdsmap (start epoch 0) on
every MDS_CON_FAIL_REFRESH_MDSMAP consecutive faults, resetting the
count on any session message, and do the same when a session is
marked HUNG, which covers a connection that went to STANDBY and thus
never faults.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/mds_client.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4460f614050e4..3c7ecf3147e6f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -72,6 +72,13 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work);
 
 static const struct ceph_connection_operations mds_con_ops;
 
+/*
+ * Consecutive MDS connection faults after which we ask the monitor for
+ * a full mdsmap.  With the messenger backoff (250ms doubling up to 15s)
+ * ten faults take about a minute, comparable to mount_timeout.
+ */
+#define MDS_CON_FAIL_REFRESH_MDSMAP	10
+
 static void ceph_metric_bind_session(struct ceph_mds_client *mdsc,
 				     struct ceph_mds_session *session)
 {
@@ -4651,6 +4658,9 @@ static void handle_session(struct ceph_mds_session *session,
 	      ceph_session_op_name(op), session,
 	      ceph_session_state_name(session->s_state), seq);
 
+	/* the connection works, see mds_fault() */
+	session->s_con_failures = 0;
+
 	if (session->s_state == CEPH_MDS_SESSION_HUNG) {
 		session->s_state = CEPH_MDS_SESSION_OPEN;
 		pr_info_client(cl, "mds%d came back\n", session->s_mds);
@@ -6285,6 +6295,18 @@ static void maybe_recover_session(struct ceph_mds_client *mdsc)
 	ceph_force_reconnect(fsc->sb);
 }
 
+/*
+ * Subscribe to the mdsmap from epoch 0 so that the monitor sends the
+ * current full map rather than waiting for an incremental update.
+ */
+static void request_full_mdsmap(struct ceph_mds_client *mdsc)
+{
+	struct ceph_mon_client *monc = &mdsc->fsc->client->monc;
+
+	if (ceph_monc_want_map(monc, CEPH_SUB_MDSMAP, 0, true))
+		ceph_monc_renew_subs(monc);
+}
+
 bool check_session_state(struct ceph_mds_session *s)
 {
 	struct ceph_client *cl = s->s_mdsc->fsc->client;
@@ -6294,6 +6316,12 @@ bool check_session_state(struct ceph_mds_session *s)
 		if (s->s_ttl && time_after(jiffies, s->s_ttl)) {
 			s->s_state = CEPH_MDS_SESSION_HUNG;
 			pr_info_client(cl, "mds%d hung\n", s->s_mds);
+			/*
+			 * The MDS may have come back at a different
+			 * address while the connection sat in STANDBY,
+			 * which doesn't fault.
+			 */
+			request_full_mdsmap(s->s_mdsc);
 		}
 		break;
 	case CEPH_MDS_SESSION_CLOSING:
@@ -7525,12 +7553,32 @@ static int mds_check_message_signature(struct ceph_msg *msg)
        return ceph_auth_check_message_signature(auth, msg);
 }
 
+/*
+ * If the MDS keeps failing to connect, our mdsmap may be stale (e.g. the
+ * MDS restarted at a different address and the incremental update was
+ * missed while the monitor session was down).  Periodically ask for a
+ * full map.
+ */
+static void mds_fault(struct ceph_connection *con)
+{
+	struct ceph_mds_session *s = con->private;
+
+	if (++s->s_con_failures < MDS_CON_FAIL_REFRESH_MDSMAP)
+		return;
+
+	s->s_con_failures = 0;
+	doutc(s->s_mdsc->fsc->client,
+	      "mds%d keeps faulting, requesting full mdsmap\n", s->s_mds);
+	request_full_mdsmap(s->s_mdsc);
+}
+
 static const struct ceph_connection_operations mds_con_ops = {
 	.get = mds_get_con,
 	.put = mds_put_con,
 	.alloc_msg = mds_alloc_msg,
 	.dispatch = mds_dispatch,
 	.peer_reset = mds_peer_reset,
+	.fault = mds_fault,
 	.get_authorizer = mds_get_authorizer,
 	.add_authorizer_challenge = mds_add_authorizer_challenge,
 	.verify_authorizer_reply = mds_verify_authorizer_reply,
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 31abbb3b3bdb3..46e13446afcc7 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -301,6 +301,8 @@ struct ceph_mds_session {
 	struct list_head  s_unsafe;   /* unsafe requests */
 	struct xarray	  s_delegated_inos;
 	atomic_t	  s_num_deleg_inos;
+
+	u8		  s_con_failures; /* consecutive connection faults */
 };
 
 /*
-- 
2.56.0

