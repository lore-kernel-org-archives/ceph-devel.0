From: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Subject: Re: Can't start ceph mon
Date: Tue, 20 Nov 2012 18:17:13 +0000
Message-ID: <50ABC929.3000107@bob-the-boat.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from i01.ip.uk.com ([86.54.60.3]:46602 "EHLO i01.ip.uk.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072Ab2KTSRR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 20 Nov 2012 13:17:17 -0500
Received: from [194.164.232.154] (helo=[10.168.1.34])
	by i01.ip.uk.com with esmtp (Exim 4.63)
	(envelope-from <dave@bob-the-boat.me.uk>)
	id 1TasNl-0000AG-G9
	for ceph-devel@vger.kernel.org; Tue, 20 Nov 2012 18:17:13 +0000
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

>Do you have other monitors in working order? The easiest way to handle
>it if that's the case is just to remove this monitor from the cluster
>and add it back in as a new monitor with a fresh store. If not we can
>look into reconstructing it.
>-Greg


>Also, if you still have it, could you zip up your monitor data
>directory and put it somewhere accessible to us? (I can provide you a
>drop point if necessary.) We'd like to look at the file layouts a bit
>since we thought we were properly handling ENOSPC-style issues.
>-Greg

Greg,

Thanks. I was running only one monitor, so I will need to try to reconstruct things.

If you tell me exactly what to pack up and where to send it, I'll be only too pleased to receive your help...

David 

