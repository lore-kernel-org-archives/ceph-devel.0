From: Dan Mick <dan.mick@inktank.com>
Subject: Re: How to write data to rbd pool.
Date: Wed, 03 Oct 2012 13:13:52 -0700
Message-ID: <506C9C80.9070505@inktank.com>
References: <loom.20121001T173732-275@post.gmane.org> <CADvuQRE9paXEHD+bEa_Xjbh9Ex5Dt9+E4R+WjYq=3JY=VPCrOg@mail.gmail.com> <loom.20121002T151242-374@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63295 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab2JCUNz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 16:13:55 -0400
Received: by padhz1 with SMTP id hz1so6694639pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 13:13:55 -0700 (PDT)
In-Reply-To: <loom.20121002T151242-374@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

Don't understand the question.  rbd images live, by default, in the rbd 
pool; the image namespace is flat, and there is no path.

On 10/02/2012 06:13 AM, ramu eppa wrote:
> Hi all,
>
>    How to know the rbd volume path.
>
> Thanks,
> Ramu.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
