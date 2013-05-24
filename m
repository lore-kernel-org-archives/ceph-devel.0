From: Wido den Hollander <wido@42on.com>
Subject: Re: qemu-1.5.0 savevm error -95 while writing vm with ceph-rbd as
 storage-backend
Date: Fri, 24 May 2013 17:08:35 +0200
Message-ID: <519F8273.1000307@42on.com>
References: <519F1AED.80005@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:47125 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266Ab3EXPIh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 May 2013 11:08:37 -0400
In-Reply-To: <519F1AED.80005@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/24/2013 09:46 AM, Oliver Francke wrote:
> Hi,
>
> with a running VM I encounter this strange behaviour, former
> qemu-versions don't show up such an error.
> Perhaps this comes from the rbd-backend in qemu-1.5.0 in combination
> with ceph-0.56.6? Therefore my
> crosspost.
>
> Even if I have no real live-snapshot avail - they know of this
> restriction -, it's more work for the customers
> to perform a shutdown before the wonna do some changes to their VM ;)
>

Doesn't Qemu try to save the memory state to RBD here as well? That 
doesn't work and fails.

> Any hints welcome,
>
> Oliver.
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
