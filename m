From: Jevon Qiao <scaleqiao@gmail.com>
Subject: Re: Seek advice for using Ceph to provice NAS service
Date: Thu, 24 Sep 2015 22:21:58 +0800
Message-ID: <56040706.1000902@gmail.com>
References: <56020CC2.2060806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34793 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467AbbIXOWI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 10:22:08 -0400
Received: by padhy16 with SMTP id hy16so74680082pad.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 07:22:08 -0700 (PDT)
In-Reply-To: <56020CC2.2060806@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: ceph-users@ceph.com

Any comments or suggestions?

Thanks,
Jevon
On 23/9/15 10:21, Jevon Qiao wrote:
> Hi Sage and other Ceph experts,
>
> This is a greeting from Jevon, I'm from China and working in a company 
> which are using Ceph as the backend storage. At present, I'm 
> evaluating the following two options of using Ceph cluster to provide 
> NAS service and I need your advice from the perspective of stability 
> and feasibility.
>
> Option 1: Directly use CephFS
> Since Ceph as a unified storage can provide file system storage 
> service via cephfs, this looks an ideal solution for my case if CephFS 
> is ready to be used in production environment. However, based on the 
> previous discussions on CephFS, I see that there are still some issues 
> like not ready for supporting multiple metadata servers, lack of a 
> fully functioning fsck and so on. Also, I learn that CephFS has been 
> evaluated by a large community of users and there are production 
> systems using it with a single MDS from the official website of Ceph. 
> So it is difficult for me to make the decision on whether I should use 
> it.
>
> Option 2: Ceph rbd + NFS server
> This might be a common architecture used in current NAS storage. But 
> the problem is how to get rid of the single point failure on NFS 
> server. What I have right now is to use Corosync and Pacemaker(the 
> typical HA solution in Linux) to form a cluster. It seems that 
> Sebastien Han has verified the feasibility.
>
> Your comments/advices would be highly appreciated and I'm looking 
> forward to your reply.
>
> Thanks,
> Jevon

