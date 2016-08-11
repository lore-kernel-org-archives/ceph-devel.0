From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: admin_socket using poll or kqueue on FreeBSD
Date: Thu, 11 Aug 2016 02:42:26 +0200
Message-ID: <80153003-06d0-3717-4403-b5ce2736f49a@digiware.nl>
References: <5fe132c8-a4d4-a1e0-e3a8-7b3ac0d45350@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:17478 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbcHKAmb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Aug 2016 20:42:31 -0400
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 50F1D253C2
	for <ceph-devel@vger.kernel.org>; Thu, 11 Aug 2016 02:42:28 +0200 (CEST)
In-Reply-To: <5fe132c8-a4d4-a1e0-e3a8-7b3ac0d45350@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 10-8-2016 11:05, Willem Jan Withagen wrote:
> Hoi,
> 
> I'm haveing trouble terminating ceph-mon (and sometimes osd).
> Only kill -9 will get it to die.
> 
> I think it is due to that AdminSocket is still stuck in poll()?
> Should AdminSocket use poll() on FreeBSD, or is this a misconfiguration
> and should it be using kqueue stuff?
> 
> Below backtraces of the relevant threads...

Looks like rebasing and recompiling did the job.

--WjW


