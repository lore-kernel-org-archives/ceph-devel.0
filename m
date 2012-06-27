From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: OSD Hardware questions
Date: Wed, 27 Jun 2012 20:48:30 +0200
Message-ID: <4FEB557E.7030903@profihost.ag>
References: <4FEB04CC.4050008@profihost.ag> <4FEB10DA.7010206@inktank.com> <4FEB1EF8.4050307@sandia.gov> <4FEB2480.3080404@profihost.ag> <4FEB4179.8050104@sandia.gov> <937453C8-37D5-4708-B81B-CD97B4AF3BF8@profihost.ag> <4FEB533B.9040107@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42473 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab2F0Ssd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 14:48:33 -0400
In-Reply-To: <4FEB533B.9040107@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 27.06.2012 20:38, schrieb Jim Schutt:
> Actually, when my 166-client test is running,
> "ps -o pid,nlwp,args -C ceph-osd"
> tells me that I typically have ~1200 threads/OSD.

huh i see only 124 threads per OSD even with your settings.

> Hmmm.  The only other obvious difference, based on
> what I remember from your other posts, is that you're
> testing against RBD, right?  I've been testing exclusively
> with the Linux kernel client.

right and SSD. So it might be some timing issues.

Stefan
