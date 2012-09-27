From: Dan Mick <dan.mick@inktank.com>
Subject: Re: How to create nova volumes inside rbd pool .
Date: Thu, 27 Sep 2012 10:41:17 -0700
Message-ID: <50648FBD.20108@inktank.com>
References: <loom.20120927T064251-722@post.gmane.org> <5063DFC9.5030505@inktank.com> <loom.20120927T083015-790@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41520 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab2I0RlU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 13:41:20 -0400
Received: by pbbrr4 with SMTP id rr4so3922401pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 10:41:20 -0700 (PDT)
In-Reply-To: <loom.20120927T083015-790@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

The command you show below is not creating a pool; it's creating an rbd 
image named testpool inside the RADOS pool named "nova".

Creating and managing images inside nova is done with OpenStack 
administration tools, typically, and not with the rbd command directly.
Did you have questions about 
http://ceph.com/docs/master/rbd/rbd-openstack/ ?


On 09/26/2012 11:33 PM, ramu eppa wrote:
> Hi Mick,
>
>    Iam creating nova pool using this command,
> rbd --pool nova create --size 1024 testpool.It's creating pool fine,
> but i want to create volume inside this pool(testpool).
>
> Thanks,
> Ramu.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
