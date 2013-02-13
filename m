From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: rbd export speed limit
Date: Wed, 13 Feb 2013 08:54:10 +0100
Message-ID: <511B46A2.4060107@profihost.ag>
References: <511AA47B.3020309@profihost.ag> <CABYiri_QzZaOeXp5Rcys3HZRRwF2nexh4GvmA5WMFw9Z+GVZjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:35269 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757059Ab3BMHyR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 02:54:17 -0500
In-Reply-To: <CABYiri_QzZaOeXp5Rcys3HZRRwF2nexh4GvmA5WMFw9Z+GVZjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
Am 12.02.2013 21:45, schrieb Andrey Korolyov:
> you may be interested in throttle(1) as a side solution with stdout
> export option.
What's throttle? Never seen this. Wouldn't it be possible to use tc?

> By the way, on which interconnect you have manage to
> get such speeds,
Bonded Intel 2x 10GBE

> if you mean 'commited' bytes(e.g. not almost empty
> allocated image)?
Yes commited images.

Stefan
