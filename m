From: Liam Monahan <liam@umiacs.umd.edu>
Subject: Re: Bucket ACL precedence over key ACLs in radosgw
Date: Mon, 07 Oct 2013 10:34:36 -0400
Message-ID: <5252C67C.5030008@umiacs.umd.edu>
References: <0b1431c8eff488eefb27b014c87dd330@umiacs.umd.edu> <CABBk=J-FNrC8oJixDLOfYcPPW0Hik6=-xc_Z8YncZco3UWBXYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bubs.umiacs.umd.edu ([128.8.132.55]:45121 "EHLO
	bubs.umiacs.umd.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582Ab3JGOwp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Oct 2013 10:52:45 -0400
In-Reply-To: <CABBk=J-FNrC8oJixDLOfYcPPW0Hik6=-xc_Z8YncZco3UWBXYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 09/12/2013 07:26 PM, Yehuda Sadeh wrote:
> On Thu, Sep 12, 2013 at 2:35 PM, Liam Monahan <liam@umiacs.umd.edu> wrote:
>> Hi,
>>
>> There's a limitation for my site's installation of Ceph, particularly the
>> radosgw s3 API, that we've been trying to work around.  If a user is granted
>> FULL_CONTROL over a bucket, they still can get 403s when trying to
>> access/modify keys in that bucket.  Would it be appropriate to skip ACL
>> checks for the key if the user has full control over the bucket or is there
>> a good reason not to do so?
>>
>> I wanted to gauge the likelihood of acceptance for such a patch before
>> starting in on it.  Any suggestions would be helpful.  I was thinking that
>> modifications would mainly be necessary in verify_object_permission() in
>> src/rgw/rgw_common.cc.
>
> In general if it breaks S3 compatibility then such behavior would need
> to be set through a configurable. If it's turned off by default I
> don't really see why not to include such an option.
>
> Yehuda
>
Hi,

I put in a pull request at https://github.com/ceph/ceph/pull/672 for 
this feature.  Do you guys have any feedback?  Is there anything I need 
to do to make this more appealing?

Liam
