Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873C34EEED;
	Thu, 12 Mar 2026 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303425; cv=fail; b=qZrnor4U1dwEDOBDTsVnXlByczTOYO/exRN9RN3k9vqM8/CCsF8wcU/0jVrJOGMaGaI3YNshjX9TQzzMxVrEDZ4YXbDPXefwQuu6pQ+ltkQZ+F7aF6lmz6hxqW7eOsjqogY2XsZQRchaKxFBlNWWbsDiANxohUxbz/UtrnN9uVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303425; c=relaxed/simple;
	bh=u41OY1UtoRLity68mOrvjZkCDwzYcWDHSW8ANiTUWDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WoqJNd1Il16S30UCvdHEWJuBqSYaSWafYOVtjMonBfscL+K8t5hHPtrAFGc+u+oslsC50XOso0VOuSdjXZCHHAJQh088bVShlq1LqDM6BXS82viI7l2OM+kTTDB283y3ukiHKmo/dvwmXSs5VHypKoFpUiS3tiiaRWMzg8VHd9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=CA9AnOdT; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="CA9AnOdT"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C6vxZ41862126;
	Thu, 12 Mar 2026 01:16:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ZxlnFN+nIyNH9zxWdjMIVGg59OmOFUaydD6pIC95pXM=; b=
	CA9AnOdTTk/+EerZvAoCvdqgvr8JsEP0plRj7uF3F5uCCg5eqfbMTOrW15S/HLh2
	sQP+cBZvCpfUjss1zeEYvvoETZCs+FToSXGWp9XUeNGv7pg0v/3DDtyWP2hV60y3
	8OwokT2Lv0QheOEj2d7Q3+p29izLW4YKP4/+B0dcxLRFEG9rBCa5glKjBgoHNm+B
	8fu4Ntl+iRaEtsCmOH4uW3us2GSttGKrvneDzVLVHQBIVbn3gdTfHmSC+d8jfgiS
	R8/x7yQctHrCO3QX4eU6nDTbZlAaJjCECpcXkPWcNJjTPToK0vwYcq2jvQSSXaq/
	VYogdjiSWjhs8/32A78x8Q==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh6pren4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 01:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDsfJrj1EeaaTwFrLBduWzELvo6Hj9WWRpxO6I0oE6e61O2/xaxq08hw3q5mFvcJRVMAcAO3x1IzvIrMxxSKHa0qrPCyOJ0hJmjgRT/oZ/6GSDH7i1h3WV/I0h1hrWCQ6kpUUVMyDF6tEBmYoV5W7BzhYREir3rY3zI8rPA3600n8qYd0HgIqxddyP3GuowjOetjljvs+jxqYvagFQSQGHLCrQoknb3XkbQDNubvowM/N5mweY0imoD9WMAUiCNeHxiTmeJy5zyOpZaki+aifsMjspU7lY2jKs2mq3Qy1WswSb+9me5C279qAmXnIveGTmmtbqa3v9WO+Ai6sZL4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxlnFN+nIyNH9zxWdjMIVGg59OmOFUaydD6pIC95pXM=;
 b=JzJIFeH178SEqoTsUo43w1QaAoAXitPWc3WrSo+UPa1XYqo/wuK7RutV61DD1nB7FxJwcORCGF8Mx3hGH/JEm7jzFb4mOcFk6PezkCPIs/XjqQKUNaZGzTcZeOC+TRQcre6IfvZZM76VC16Aesa0m4Te5hlM3MdYiv6wdczBNNxhjYqbEqP0PP6MgBIfkF0MEKn16uG7t/gGxt23KO+dS9kxqlX3vBGII7OnKR+nKJ3vhtW15AjU2A2xefn8At/8wEscDEFMjsxEnPd9h/xmSJwYTZqoo0JwreV0VWZONYlZYHHnZgcXBS79rUPOgEsR7/I5VjRNmQC+EIYZzDWtNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:16:52 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:16:52 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, xiubli@redhat.com, linux-kernel@vger.kernel.org,
        ionut_n2001@yahoo.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 07/13] ceph: add timeout to caps wait in __ceph_get_caps()
Date: Thu, 12 Mar 2026 10:16:13 +0200
Message-ID: <20260312081619.40854-8-ionut.nechita@windriver.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SA0PR11MB4720:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bc42b8-d5a8-401e-bb5b-08de800fb710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u9QBiRqegm5Lzoi4mw1sShtHTDCWiydD9O1rtrFl/jRgj8WCk4Kr8rAhw1kxe4WzenrOV9uKYOvGlDw8mBH+JA7xcGXmNbbsbK8iGAYPSrrDe9mMWWPnwZI8tj3yP0P15IzIX0Q+4ML6iXg/H9wHq0WmNPTCLZ1i/f2MdPcwBwGCPH/lEaFQ0rCrlpvHBBSw9n2BTKk4h+mx9jTWNaD0bUKBz9pWX0obS0XzutGA6wENcgEcyTql3HHP8zme+s6H9cnC541u1fYgPKPP4vWbZliazTlgps3FQNIOkN7/qxWzQ2op7T+KuPagVeaeEglSdC1GedqGLCMZUtQAKVBRHMd66Ybu1aOYav2prlxfCYUumo47vcd1/T07qR/XcRlhxtIN7DiO6LdwCKUJ4Fq79iJ/+LAIZzHhZE5bst5IsGfGHNee17QUAoyrqWKvwAKyKzTORR1mgr448+TWzZ6GCc0ghuPfsJ81UwU6oa2KCR/SzW8aBSnNOOqD+oEmHr+Ra21goCvvDb0U365mT4/t88IKvLjoVhFfudG8l2Dm0vFiaQFD4v0YKlhZzBSH14AgT8UzxdtadHF/2Euz6TKkT/5OVUXIpMXOg3PAmEtwoTjnc+boWA1utYtGjm4jSyYx6D+IyDVFpmixDBOntHwd9UH67gGsRoR3RRW+xu2ZrmhAbjhrvza3NHJouLb54qBoyqKmDDXNXgkIhGSeImqWp4Gl258gx68bQVtw/5VkbRM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rt/OCXujRXS/9fJrsl7YBJMOYsHQMu+J09O2krs59CLUkPW41RMxl+Kyz0Xx?=
 =?us-ascii?Q?YFnDxywefb+Dknlbu775oNFq09OynV5FR6zlYhNNiA/mX+xoxSHDTdCA1/J6?=
 =?us-ascii?Q?BvlACV3vSIm/NXVl/55e8as0bgYhYvl5HjHiZ1cSVW2Wqskg6REC0FRs2QAv?=
 =?us-ascii?Q?8/Rui8XuRMgjk+oY4smvyhclMS3GbR7/+uPs1WbDrzxXYXMphB6lVwhhW155?=
 =?us-ascii?Q?0LphQzgpRR5lUaTOU3kseRLke8uCzYgAO9EWgxRm9rYmYEtTi2wj0jWlPp0v?=
 =?us-ascii?Q?mDNcAVpIxR6BV2vcvmA0smiPTlB8bB+3+MfluA8D+dc22dzwoCEgZ4zEnVUJ?=
 =?us-ascii?Q?M2sanxSnddTcTAvOcQGVCw2JDqPNg+hirvWgPFwU9Z9OQd7IHPjCAonpwAbr?=
 =?us-ascii?Q?AdDbFXa98m7Ct5wv0jAZq9HUB45DfLCd9XKdHw8grslrE9S7Po7NyVlgE/Zo?=
 =?us-ascii?Q?fxBup+7LhIKYcjsY7NbXpArRC2R66zI1SgBj9qwq7N33/G48IeK9j2nj68ro?=
 =?us-ascii?Q?jb6YllHtqT4oP2HRHuXjM97SGooqPNO3zd1PoNB6bvdzfjUTEJwE7mKH8iBk?=
 =?us-ascii?Q?K3r58Ot2gFOcQUcD+qIyPv5T4zBY5vZQq5f0mQe2MPmyvzpxSX3J5Cv94cX9?=
 =?us-ascii?Q?ce/cpatvFL1srKRIOXC7KT1qa5KB1i3EsyIgj2jtRrbWQDWY32nCniCxwUVG?=
 =?us-ascii?Q?8s2zK5v3nnHRAM1QaQ/W1DFkFLLdCEjNeXFlBkYMyoyeo58tP0z8p7/82vDr?=
 =?us-ascii?Q?WXZoyx+QUnRAuxoQhvTXI0JJmfZqumZP75RM5RuH7nrSSpAVj1esMcg54gBh?=
 =?us-ascii?Q?X5jgecoBm/OPyqohOfMKYPY6DIt/wjZToJCm72OwpGoeDHSXEKhA2SXU4yMf?=
 =?us-ascii?Q?pUWZgiO4b/i/KgqQ5rDYJq+wbki3vrjUw6MBmZBtWa93ijkC+KPfOusnGeVj?=
 =?us-ascii?Q?MmcilPLh85LDCscDNhrTcokz72WR2xWJX/uoHWjR5JloR2Gkrm4bmOnkjda6?=
 =?us-ascii?Q?EFpjjtiIbwc1/HBkW8loFv4ytZIWw5OAAVQ8FLV7Mft5fEqJ27PYaf6uTCl1?=
 =?us-ascii?Q?1OVYP/50jSXHgDMe1JXqcEKpz6Li7glS4NjZB7wD14Y5t9Tl4ZD8BVoAO0sc?=
 =?us-ascii?Q?0QhX4f7R/KhhXH6EPKcVrE9WU+B2ZXtU9eYiry4Zd/miscmeYGRJwM5HYFLO?=
 =?us-ascii?Q?O1rJa+RTCkhZH8r6Uy+Qvp6bDmvD6hs29VPk5HpMVPsddxP8wmbC2PF6Sy9j?=
 =?us-ascii?Q?bVd23FCR/0bmpsJ7sHXkQUb9J4xO084e5+LiAlvsiyrJ9R/GiWfhd5fB4YCX?=
 =?us-ascii?Q?+zz/6+DVgxI1G0XHP4Dsp0G8Xi8K2YEehrlY07NdOFU3YL+kP1LGs1kD7djD?=
 =?us-ascii?Q?kPL37lgzmIS0DmLzHagDUclV9DinQ6HqbFeApJRvtY7M528lcW0CHdni3rDc?=
 =?us-ascii?Q?pEQXsMRZaK1SsVBs+yQIohoAZl52H1xrrPnzFZkhhpxNc1YV9u0bdG2lmVTF?=
 =?us-ascii?Q?+pcfY/bWts1q8kg05cqSqH/GWbFpV06gsJYCYdJ9FnSku+gwCNRdu7oYw/GU?=
 =?us-ascii?Q?YGBUDqoDt5LPWVyHhRukT4EImO1umXpC6v0ca5K7QNUQO8zNWCOq7/awFo6i?=
 =?us-ascii?Q?FJ+DXTiDAp1Rm3rElEEBw4NY6l14XD4Ad+PsrDB12i7F5PIcQN87EWXRZh/g?=
 =?us-ascii?Q?XHklhHqCMCxmR7rFGXvWw5Az9l6bK55Qjw/t0olN0qyMHnNIPqgeR36H/FKz?=
 =?us-ascii?Q?EWBjN08evxsgjFv4hGtBI7XqWxaVxtaw7ORH2ZFxHTDDWkjFfvi1fpRkukGt?=
X-MS-Exchange-AntiSpam-MessageData-1: CrNuneeVnV5yr0LK7Kv1vc7Cy32CFgoJ1uo=
X-Exchange-RoutingPolicyChecked:
	iZNprHLgO4M1wLTCyVsg14TYTP4TepfJ3nLEJfNWwPFptnV77xFowQj80acukqtaxx1Hj2+ESEURbqYybEcjvwSUoL2O59oMwFIjNYO1QcrAwlVHB/0q/lUuKi91R1yCfE49wGFNYDAH+PkEbMyDUlQ9HuZQZyXMkI6KCIFgz81YhjDi3gP2a4RlUm5/Vlzt/Cl3cXrqkYhtsxIlriRFati7DXxmiafWwhduqrNOFrD8qeg0N/TpeJm42FANG/ZTit2VTbi3z+TYntIkFRtteTGATNE5s5zkRxTsV5BDk/ibcPwA8qaSBuK2O0eRxyb6uPchpUK746s2jvAG2d1G1Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bc42b8-d5a8-401e-bb5b-08de800fb710
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:16:51.9106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzyeMyo7IBO1R46iM4kMUdelcE5fuDosu9eoEeVKbcCIwKFH02+jLnMcEdpGrRoXu8IUVRH5yF5rpD+qUUD9zeqYpFHmbIJRHq7CVlHhCrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-Authority-Analysis: v=2.4 cv=ePAeTXp1 c=1 sm=1 tr=0 ts=69b27675 cx=c_pps
 a=wodMs23R9wL6gmOfRTd43Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=VlUkj_UfwbxC0px-5zMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 2T9vTxPDNe98BX4hAh-TVVzyVjBQLVA9
X-Proofpoint-GUID: 2T9vTxPDNe98BX4hAh-TVVzyVjBQLVA9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA2NSBTYWx0ZWRfXwkLoXplgq+2a
 AbgzZfR58sYR3N/PJiXjDXKvWXXyaGSUu496s2uID/HS4vsA7N21AiLGz1rojeOdkB0RdgO9Sc4
 NoYml1OqASl3nvB7HRpDLzZQyxFGx8MT+sheo198Oy4OIAKIA3PklEbSzUAB8h2HCTZp0rht9UU
 ZhBniQYaqLzrWhTM2Dm1CKDAdQ4t0HpX5pQMuHarLolwt00My28RX9dBBVMBg/3dDJ49/bvtXbD
 y+8r0YWtGXU3pX/+MOUcVncGFYnIYJBt3kUZiygQtDmqAkgOlbncsbw2WxuEK+BaTSQFukO316o
 Dcio/rfXrVA3exxZDTNQXvRaEfY3tXKkjBfB4DacIT25v73MhNNADaEwZnt7NYGdQ46DfXPHWjI
 +BNT35d8tqyUiZmXKHkyIf655kFtAMsdoXXEE8Fz1XFeTyc9GCfUILdKPWvB+EH9Es2CFZAuBik
 MUI70A7tf7ojqLfNEog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120065

From: Ionut Nechita <ionut.nechita@windriver.com>

When waiting for caps in __ceph_get_caps(), the code uses
wait_woken() with MAX_SCHEDULE_TIMEOUT, which can block
indefinitely if the MDS is unavailable or slow to grant caps
during reconnection.

This causes hung task warnings when MDS fails over:

  INFO: task dd:12345 blocked for more than 122 seconds.
  Call Trace:
    __ceph_get_caps+0x...
    ceph_write_iter+0x...

During MDS failover, caps may be revoked or delayed while the
client reconnects. Processes waiting for caps block indefinitely,
also holding i_rwsem which blocks other I/O operations on the
same inode, causing a cascade of blocked processes.

Fix this by using wait_woken() with mount_timeout instead of
MAX_SCHEDULE_TIMEOUT. On timeout, return -ETIMEDOUT to allow
the caller to handle the situation appropriately.

Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 fs/ceph/caps.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index bed34fc11c919..c88e10a634e5c 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3055,7 +3055,10 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
+	unsigned long timeout = ceph_timeout_jiffies(cl->options->mount_timeout);
 	int ret, _got, flags;
+	bool warned = false;
 
 	ret = ceph_pool_perm_check(inode, need);
 	if (ret < 0)
@@ -3104,7 +3107,18 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 					ret = -ERESTARTSYS;
 					break;
 				}
-				wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
+				if (!wait_woken(&wait, TASK_INTERRUPTIBLE, timeout)) {
+					if (!warned) {
+						pr_warn_ratelimited_client(cl,
+							"%p %llx.%llx caps wait timed out (need %s want %s)\n",
+							inode, ceph_vinop(inode),
+							ceph_cap_string(need),
+							ceph_cap_string(want));
+						warned = true;
+					}
+					ret = -ETIMEDOUT;
+					break;
+				}
 			}
 
 			remove_wait_queue(&ci->i_cap_wq, &wait);
-- 
2.53.0

