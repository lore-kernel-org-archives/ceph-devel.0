From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: extreme ceph-osd cpu load for rand. 4k write
Date: Thu, 08 Nov 2012 23:06:18 +0100
Message-ID: <509C2CDA.3030202@profihost.ag>
References: <509AC772.5010606@profihost.ag> <509BC878.3090804@profihost.ag> <alpine.DEB.2.00.1211080658560.11845@cobra.newdream.net> <509BD38B.8090200@profihost.ag> <509BD87F.1010107@inktank.com> <509C23A7.9010109@profihost.ag> <509C2939.5000201@inktank.com> <509C2B05.2070200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:41480 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757111Ab2KHWGW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 17:06:22 -0500
In-Reply-To: <509C2B05.2070200@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 08.11.2012 22:58, schrieb Mark Nelson:
> Also, I'm not sure what version you are running, but you may want to try
> testing master and see if that helps.  Sam has done some work on our
> threading and locking code that might help.

This is git master (two hours old).

Stefan
