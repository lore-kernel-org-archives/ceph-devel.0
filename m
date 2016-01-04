From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: Speeding up rbd_stat() in libvirt
Date: Mon, 4 Jan 2016 10:38:36 -0500 (EST)
Message-ID: <780342854.4132479.1451921916433.JavaMail.zimbra@redhat.com>
References: <56813DB8.2060008@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:43152 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbcADPip (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jan 2016 10:38:45 -0500
In-Reply-To: <56813DB8.2060008@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

Short term, assuming there wouldn't be an objection from the libvirt community, I think spawning a thread pool and concurrently executing several rbd_stat calls concurrently would be the easiest and cleanest solution.  I wouldn't suggest trying to roll your own solution for retrieving image sizes for format 1 and 2 RBD images directly within libvirt.

Longer term, given this use case, perhaps it would make sense to add an async version of rbd_open.  The rbd_stat call itself just reads the data from memory initialized by rbd_open.  On the Jewel branch, librbd has had some major rework and image loading is asynchronous under the hood already.

-- 

Jason Dillaman 


----- Original Message -----
> From: "Wido den Hollander" <wido@42on.com>
> To: ceph-devel@vger.kernel.org
> Sent: Monday, December 28, 2015 8:48:40 AM
> Subject: Speeding up rbd_stat() in libvirt
> 
> Hi,
> 
> The storage pools of libvirt know a mechanism called 'refresh' which
> will scan a storage pool to refresh the contents.
> 
> The current implementation does:
> * List all images via rbd_list()
> * Call rbd_stat() on each image
> 
> Source:
> http://libvirt.org/git/?p=libvirt.git;a=blob;f=src/storage/storage_backend_rbd.c;h=cdbfdee98505492407669130712046783223c3cf;hb=master#l329
> 
> This works, but a RBD pool with 10k images takes a couple of minutes to
> scan.
> 
> Now, Ceph is distributed, so this could be done in parallel, but before
> I start on this I was wondering if somebody had a good idea to fix this?
> 
> I don't know if it is allowed in libvirt to spawn multiple threads and
> have workers do this, but it was something which came to mind.
> 
> libvirt only wants to know the size of a image and this is now stored in
> the rbd_directory object, so the rbd_stat() is required.
> 
> Suggestions or ideas? I would like to have this process to be as fast as
> possible.
> 
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
