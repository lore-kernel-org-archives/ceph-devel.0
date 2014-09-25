From: Mike Dawson <mike.dawson@cloudapt.com>
Subject: Re: v0.67.11 dumpling released
Date: Thu, 25 Sep 2014 11:47:25 -0400
Message-ID: <5424390D.6010203@cloudapt.com>
References: <alpine.DEB.2.00.1409250808190.15854@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:47837 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbaIYPra (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 11:47:30 -0400
Received: by mail-ig0-f172.google.com with SMTP id a13so8702807igq.17
        for <ceph-devel@vger.kernel.org>; Thu, 25 Sep 2014 08:47:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409250808190.15854@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

On 9/25/2014 11:09 AM, Sage Weil wrote:
> v0.67.11 "Dumpling"
> ===================
>
> This stable update for Dumpling fixes several important bugs that affect a
> small set of users.
>
> We recommend that all Dumpling users upgrade at their convenience.  If
> none of these issues are affecting your deployment there is no urgency.
>
>
> Notable Changes
> ---------------
>
> * common: fix sending dup cluster log items (#9080 Sage Weil)
> * doc: several doc updates (Alfredo Deza)
> * libcephfs-java: fix build against older JNI headesr (Greg Farnum)
> * librados: fix crash in op timeout path (#9362 Matthias Kiefer, Sage Weil)
> * librbd: fix crash using clone of flattened image (#8845 Josh Durgin)
> * librbd: fix error path cleanup when failing to open image (#8912 Josh Durgin)
> * mon: fix crash when adjusting pg_num before any OSDs are added (#9052
>    Sage Weil)
> * mon: reduce log noise from paxos (Aanchal Agrawal, Sage Weil)
> * osd: allow scrub and snap trim thread pool IO priority to be adjusted
>    (Sage Weil)

Sage,

Thanks for the great work! Could you provide any links describing how to 
tune the scrub and snap trim thread pool IO priority? I couldn't find 
these settings in the docs.

IIUC, 0.67.11 does not include the proposed changes to address #9487 or 
#9503, right?

Thanks,
Mike Dawson


> * osd: fix mount/remount sync race (#9144 Sage Weil)
>
> Getting Ceph
> ------------
>
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://ceph.com/download/ceph-0.67.11.tar.gz
> * For packages, see http://ceph.com/docs/master/install/get-packages
> * For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
