From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: Regarding rbd --image-shared and --shared <tag>
Date: Mon, 9 Mar 2015 16:30:43 -0400 (EDT)
Message-ID: <155930577.1108244.1425933043884.JavaMail.zimbra@redhat.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282CA4CD@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:47065 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbbCIUar (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 16:30:47 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F282CA4CD@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel@vger.kernel.org

There generally is no built-in RBD restriction about having multiple clients perform IO on the same image -- but if two clients were performing write operations on the same image they would need to coordinate their activities outside of librbd/krbd to ensure they aren't corrupting the image.  There are some use-cases where it is beneficial to use the same image concurrently on multiple machines (e.g. running GFS or OCFS on top of an RBD image).

The "--shared" option is an existing option that is used with the legacy co-operative RBD image locking feature (i.e. lock add <image-name> <id> [--shared <tag>]).  This legacy locking feature is cooperative because nothing outside of the rbd CLI uses / enforces these locks, so scripting would be required to achieve a desired effect.  

With Hammer, librbd has a new built-in and enforced exclusive locking feature (disabled by default) that ensures that only a single librbd client can have an image open at a time.  This new feature is the foundation of the new librbd object map feature (also disabled by default) which will track in-use objects within an image to speed up certain operations.  It will also be used by the forthcoming librbd journalling feature that is still in development.

The new "--image-shared" option for the rbd CLI is useful if you have enabled the new exclusive locking feature by default (i.e. by adding rbd default features = 5 to your ceph.conf) and you want to disable the exclusive locking feature on a single image for backwards compatibility with krbd (since it does not yet support this new feature) or other use-cases where the image can be opened concurrently by two or more clients.

-- 

Jason Dillaman 
Red Hat 
dillaman@redhat.com 
http://www.redhat.com 


----- Original Message -----
From: "Somnath Roy" <Somnath.Roy@sandisk.com>
To: ceph-devel@vger.kernel.org
Sent: Monday, March 9, 2015 3:48:15 PM
Subject: Regarding rbd --image-shared and --shared <tag>

Hi,
My assumption was I can't map the same image from two clients (and run IO concurrently)  as this can corrupt the image. But, in the latest rbd cli I saw --image-shared and --shared<tag>, wondering what is the use case of this ?
This means that I can now map same image from two different clients and run IO in active-active mode ?
What is the difference between --image-shared and --shared<tag> ?
Is there any restriction on the operation allowed in this mode ?
Appreciate any information on this.

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
