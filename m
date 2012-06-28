From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: OSD Hardware questions
Date: Thu, 28 Jun 2012 18:01:52 +0200
Message-ID: <4FEC7FF0.2010308@profihost.ag>
References: <5d5b400b-c2b4-4bce-9231-b412ce1aff03@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:44578 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab2F1QBy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 12:01:54 -0400
In-Reply-To: <5d5b400b-c2b4-4bce-9231-b412ce1aff03@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

Am 28.06.2012 17:18, schrieb Alexandre DERUMIER:
> Hi,
> maybe it can help, I'm doing same tests that stefan,
> random write  with 4K with 3 nodes with 5 osds (with 15K drives)
> fio --filename=[disk] --direct=1 --rw=randwrite --bs=4k --size=100M --numjobs=50 --runtime=30 --group_reporting --name=file1
>
> I can achieve 5500io/s (disks are not at 100%)
>
> cpu is around 30%idle ( 8 cores E5420  @ 2.50GHz)

mine is 25-30% idle? May be this is the limit? So our osds are the problem?

Stefan
