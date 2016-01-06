From: Wido den Hollander <wido@42on.com>
Subject: Re: Speeding up rbd_stat() in libvirt
Date: Wed, 6 Jan 2016 16:31:50 +0100
Message-ID: <568D3366.3050104@42on.com>
References: <56813DB8.2060008@42on.com>
 <780342854.4132479.1451921916433.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:34763 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbcAFPb3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jan 2016 10:31:29 -0500
In-Reply-To: <780342854.4132479.1451921916433.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel@vger.kernel.org



On 04-01-16 16:38, Jason Dillaman wrote:
> Short term, assuming there wouldn't be an objection from the libvirt community, I think spawning a thread pool and concurrently executing several rbd_stat calls concurrently would be the easiest and cleanest solution.  I wouldn't suggest trying to roll your own solution for retrieving image sizes for format 1 and 2 RBD images directly within libvirt.
> 
> Longer term, given this use case, perhaps it would make sense to add an async version of rbd_open.  The rbd_stat call itself just reads the data from memory initialized by rbd_open.  On the Jewel branch, librbd has had some major rework and image loading is asynchronous under the hood already.
> 

I created a issue for this: http://tracker.ceph.com/issues/14264

Would be nice to have in librbd.

Wido
