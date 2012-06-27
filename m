From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: OSD Hardware questions
Date: Wed, 27 Jun 2012 17:28:39 +0200
Message-ID: <4FEB26A7.4070507@profihost.ag>
References: <4FEB04CC.4050008@profihost.ag> <4FEB10DA.7010206@inktank.com> <4FEB2310.9080801@profihost.ag> <CAPYLRzj916kW=KLy3dMTVPJRoNtPMP_Ejz+YAxRUJ5jZc+HeMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:36451 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757567Ab2F0P2l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jun 2012 11:28:41 -0400
In-Reply-To: <CAPYLRzj916kW=KLy3dMTVPJRoNtPMP_Ejz+YAxRUJ5jZc+HeMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

 > Am 27.06.2012 17:21, schrieb Gregory Farnum:
>
>
> Well, as we said, 1GHz/OSD was a WAG (wild-ass guess), but 3.6GHz+/OSD
> is farther outside of that range than I would have expected. It might
> just be a consequence of using SSDs, since they can sustain so much more
> throughput.

Sure it was just so much away from 1Ghz that i wanted to ask.

> What is the cluster doing when you see those CPU usage numbers?
random write I/O from one KVM. 14k I/Ops with random 4k writes.

Stefan
