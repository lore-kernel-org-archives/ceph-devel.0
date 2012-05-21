From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: KVM/RBD Block device hangs
Date: Mon, 21 May 2012 16:50:47 +0200
Message-ID: <4FBA5647.40101@profihost.ag>
References: <4FBA54E2.3000703@profihost.ag> <4FBA559D.7040902@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59156 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab2EUOur (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 10:50:47 -0400
In-Reply-To: <4FBA559D.7040902@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 21.05.2012 16:47, schrieb Wido den Hollander:
> What do you mean the OSD crashes? I assume you have multiple OSD's in
> your cluster and one of them crashes? Or do ALL of them do go down?
2 of them went down (1st then 10 minutes later the 2nd)

>> What's next / wrong?
> 
> Could you fetch the last 100 line from the log file and also tell us
> which version you are running?
i'm upgrading right now to v0.47 and will try to reproduce.

> Also, the output of "ceph -s" might be useful.
before or after the crash?

Stefan
