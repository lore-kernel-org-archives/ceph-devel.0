From: John Wilkins <john.wilkins@dreamhost.com>
Subject: Re: non-btrfs and checksumming, rados tutorial, planning wrt documentation
Date: Wed, 21 Mar 2012 20:26:30 +0000 (UTC)
Message-ID: <loom.20120321T212529-612@post.gmane.org>
References: <20120321192326.1d598442@dieter-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52706 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757580Ab2CUUkH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Mar 2012 16:40:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SASKB-0006I1-Vn
	for ceph-devel@vger.kernel.org; Wed, 21 Mar 2012 21:40:04 +0100
Received: from 76-246-5-136.lightspeed.sntcca.sbcglobal.net ([76.246.5.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 21:40:03 +0100
Received: from john.wilkins by 76-246-5-136.lightspeed.sntcca.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 21:40:03 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Plaetinck, Dieter <dieter <at> vimeo.com> writes:

> 
> 1) if you don't use btrfs (i.e. xfs) will checksumming still be done? by the 
OSD's? does the checksumming
> happen on every data read, or do underused OSD's also checksum their data in 
the background? (like
> openstack swift does).  if checksum mismatch, what does the client see, and 
what actions are taken? for
> example if you use librados, will the librados api return the read data to the 
user (even if known to be
> invalid), throw an error, or will librados try to read from other nodes first 
to try to return the valid
> data?) will the disk be marked as failed, or will the system attempt to 
overwrite the bad file with a good copy?
> 
> 2) I'm trying to set up basic rados distributed object storage cluster. I've 
successfully
> followed http://ceph.newdream.net/wiki/Installing_on_RedHat_or_CentOS, but now 
I'm stuck trying
> to configure and actually run the thing.
> (I didn't modify the prefix and the various *dir configure arguments, as I 
think /usr/local is the best
> location, for now)
> I found http://ceph.newdream.net/wiki/Simple_test_setup but it's more than 2 
years old, the
> workingdir.conf it refers to doesn't exist anymore.
> is a matter of copying src/sample.ceph.conf to /usr/local/etc, modifying it, 
and then?
> How to set up a basic rados cluster?
> 
> 3) I saw in the "lords of ceph" footage somebody mentioning work would start 
on improving the docs.  Is there
> any concrete planning on this you can share?
> 
> thanks,
> Dieter
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Dieter,

I am coming up to speed as quickly as possible, 
and should check in some updates on Friday, 
which hopefully will get rolled into the main branch 
with the team's approval. 

So that my updates are not just a well-crafted parroting 
of what's been done already, I'm actually pulling from git 
and building the source myself to ensure that we cover all 
of the pre-requisites, at least in Ubuntu. So once that's
available sometime next week, I'd appreciate your feedback, 
including any significant differences between installing on 
RedHat or CentOS versus Ubuntu and Debian.


Regards,


John  

