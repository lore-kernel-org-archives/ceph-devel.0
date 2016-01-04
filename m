From: Wido den Hollander <wido@42on.com>
Subject: Re: Speeding up rbd_stat() in libvirt
Date: Mon, 4 Jan 2016 16:59:13 +0100
Message-ID: <568A96D1.8040802@42on.com>
References: <56813DB8.2060008@42on.com>
 <780342854.4132479.1451921916433.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:37139 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbcADP65 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jan 2016 10:58:57 -0500
In-Reply-To: <780342854.4132479.1451921916433.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel@vger.kernel.org



On 04-01-16 16:38, Jason Dillaman wrote:
> Short term, assuming there wouldn't be an objection from the libvirt community, I think spawning a thread pool and concurrently executing several rbd_stat calls concurrently would be the easiest and cleanest solution.  I wouldn't suggest trying to roll your own solution for retrieving image sizes for format 1 and 2 RBD images directly within libvirt.
> 

I'll ask in the libvirt community if they allow such a thing.

> Longer term, given this use case, perhaps it would make sense to add an async version of rbd_open.  The rbd_stat call itself just reads the data from memory initialized by rbd_open.  On the Jewel branch, librbd has had some major rework and image loading is asynchronous under the hood already.
> 

Hmm, that would be nice. In the callback I could call rbd_stat() and
populate the volume list within libvirt.

I would very much like to go that route since it saves me a lot of code
inside libvirt ;)

Wido

