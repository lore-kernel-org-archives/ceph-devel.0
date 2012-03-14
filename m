From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: q. about rbd-header
Date: Wed, 14 Mar 2012 13:54:19 -0700
Message-ID: <4F61057B.30808@dreamhost.com>
References: <9CB50149-F22E-4130-80FD-1A8472891BD5@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54990 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489Ab2CNUy1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Mar 2012 16:54:27 -0400
In-Reply-To: <9CB50149-F22E-4130-80FD-1A8472891BD5@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: ceph-devel@vger.kernel.org

On 03/14/2012 08:05 AM, Oliver Francke wrote:
> Hey,
>
> anybody out there who could explain the structure of a rbd-header? After
> last crash we have about 10 images with a:
>     2012-03-14 15:22:47.998790 7f45a61e3760 librbd: Error reading
> header: 2 No such file or directory
> error opening image vm-266-disk-1.rbd: 2 No such file or directory
> ... error?
> I understand the "rb.x.y"-prefix, the 2 ^ 16hex as block-size. But
> the size/count encoding is not intuitive ;)

The data structure is rbd_obj_header_ondisk, defined in 
src/include/rbd_types.h.

The size of the objects is stored as a shift value in the 'order' field. 
That is, object size is (1 << order) bytes, and the default of 4MB is 
order 22. The total size (image_size) is just a number of bytes.

The encoding of snapshots is a bit more painful, since you'd need to 
look up the right snapshot ids for each image by looking at its existing 
objects. If you don't mind losing the snapshots, you can just zero out 
the fields after image_size. Extra zero bytes shouldn't matter after 
snap_names_len is 0.

> Besides one file, where I "created" a header and putted it via "rados
> put" back into the pool, and got some files
> back, many of the other images with lost headers have different sizes.

If you don't know the correct size, setting it too high won't use any 
more space unless the fs using it is expanded.

> We got bad luck again, too many crashed VM's, too much data-loss...
>
> Comments welcome ;)
>
> Oliver.
