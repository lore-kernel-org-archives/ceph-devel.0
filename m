From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Bucket ACL precedence over key ACLs in radosgw
Date: Thu, 12 Sep 2013 16:26:14 -0700
Message-ID: <CABBk=J-FNrC8oJixDLOfYcPPW0Hik6=-xc_Z8YncZco3UWBXYA@mail.gmail.com>
References: <0b1431c8eff488eefb27b014c87dd330@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:54945 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219Ab3ILX0P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Sep 2013 19:26:15 -0400
Received: by mail-vc0-f182.google.com with SMTP id hf12so391473vcb.41
        for <ceph-devel@vger.kernel.org>; Thu, 12 Sep 2013 16:26:14 -0700 (PDT)
In-Reply-To: <0b1431c8eff488eefb27b014c87dd330@umiacs.umd.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Liam Monahan <liam@umiacs.umd.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 12, 2013 at 2:35 PM, Liam Monahan <liam@umiacs.umd.edu> wrote:
> Hi,
>
> There's a limitation for my site's installation of Ceph, particularly the
> radosgw s3 API, that we've been trying to work around.  If a user is granted
> FULL_CONTROL over a bucket, they still can get 403s when trying to
> access/modify keys in that bucket.  Would it be appropriate to skip ACL
> checks for the key if the user has full control over the bucket or is there
> a good reason not to do so?
>
> I wanted to gauge the likelihood of acceptance for such a patch before
> starting in on it.  Any suggestions would be helpful.  I was thinking that
> modifications would mainly be necessary in verify_object_permission() in
> src/rgw/rgw_common.cc.


In general if it breaks S3 compatibility then such behavior would need
to be set through a configurable. If it's turned off by default I
don't really see why not to include such an option.

Yehuda
