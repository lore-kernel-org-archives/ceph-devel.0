From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Tue, 29 May 2012 23:34:18 +0200
Message-ID: <4FC540DA.2050601@profihost.ag>
References: <5970d59f-9531-4f60-8600-3e1268824c83@mailpro> <4FC49B12.8020004@profihost.ag> <4FC4D1A8.1080001@univ-nantes.fr> <4FC4E0A9.8010008@profihost.ag> <4FC50C4A.4090101@inktank.com> <4FC53AC4.5020600@profihost.ag> <4FC54020.8040603@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:40207 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840Ab2E2VeU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 17:34:20 -0400
In-Reply-To: <4FC54020.8040603@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org

Am 29.05.2012 23:31, schrieb Yann Dupont:
> on the contrary, pool data is jumping up & down, no matter how much
> thread involved :)
>
> Maybe this is because journal is too tight ? Or because 2 of the 8 nodes
> have slower disks ?
Can you try with 3.0.X? I would be really interested what happens in 
this case.

Stefan
