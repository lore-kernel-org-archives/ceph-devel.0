From: Constantinos Venetsanopoulos <cven@grnet.gr>
Subject: Re: Experiences with Ceph at the June'14 issue of USENIX ;login:
Date: Tue, 03 Jun 2014 12:12:12 +0300
Message-ID: <538D916C.4020801@grnet.gr>
References: <20140602183219.GD17479@philipgian-mac> <20140602214040.GG4356@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:25327 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751000AbaFCJ01 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jun 2014 05:26:27 -0400
In-Reply-To: <20140602214040.GG4356@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>, ceph-devel@vger.kernel.org

Hello Robin,

On 6/3/14, 24:40 AM, Robin H. Johnson wrote:
> On Mon, Jun 02, 2014 at 09:32:19PM +0300,  Filippos Giannakos wrote:
>> As you may already know, we have been using Ceph for quite some time now to back
>> the ~okeanos [1] public cloud service, which is powered by Synnefo [2].
> (Background info for other readers: Synnefo is a cloud layer on top of
> Ganeti).
>
>> In the article we describe our storage needs, how we use Ceph and how it has
>> worked so far. I hope you enjoy reading it.
> Are you just using the existing kernel RBD mapping for Ganeti running
> KVM, or did you implement the pieces for Ganeti to use the QEMU
> userspace RBD driver?

Non of the above. From the Ceph project we are just using RADOS,
which we access via an Archipelago [1] backend driver that uses
librados from userspace.

We integrate Archipelago with Ganeti with the Archipelago ExtStorage
provider.

> I've got both Ceph & Ganeti clusters already, but am reluctant to marry
> the two sets of functionality because the kernel RBD driver still seemed
> to perform so much worse than the Qemu userspace RBD driver, and Ganeti
> still hasn't implemented the userspace mapping pieces :-(
>

Ganeti supports accessing RADOS from userspace (via the qemu-rbd
driver) since version 2.10. The current stable is 2.11. Not only that,
but starting v2.13 (not released yet), you will be able to configure the
access method per-disk, e.g. saying that the first disk of the instance
will be kernel backed and the second userspace backed. So, I'd suggest
you give it a try and see how it goes :)

Thanks,
Constantinos


[1] https://www.synnefo.org/docs/archipelago/latest/
