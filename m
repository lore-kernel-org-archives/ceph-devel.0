From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Bucket ACL precedence over key ACLs in radosgw
Date: Mon, 7 Oct 2013 10:15:03 -0700
Message-ID: <CABBk=J80rQwYQgtVxkjVZ3hH3c_+_NtV+hET1mdUJz5D-PW5WA@mail.gmail.com>
References: <0b1431c8eff488eefb27b014c87dd330@umiacs.umd.edu>
	<CABBk=J-FNrC8oJixDLOfYcPPW0Hik6=-xc_Z8YncZco3UWBXYA@mail.gmail.com>
	<5252C67C.5030008@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:64766 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab3JGRPE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Oct 2013 13:15:04 -0400
Received: by mail-vc0-f181.google.com with SMTP id hz10so2993097vcb.40
        for <ceph-devel@vger.kernel.org>; Mon, 07 Oct 2013 10:15:03 -0700 (PDT)
In-Reply-To: <5252C67C.5030008@umiacs.umd.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Liam Monahan <liam@umiacs.umd.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 7, 2013 at 7:34 AM, Liam Monahan <liam@umiacs.umd.edu> wrote:
> On 09/12/2013 07:26 PM, Yehuda Sadeh wrote:
>>
>> On Thu, Sep 12, 2013 at 2:35 PM, Liam Monahan <liam@umiacs.umd.edu> wrote:
>>>
>>> Hi,
>>>
>>> There's a limitation for my site's installation of Ceph, particularly the
>>> radosgw s3 API, that we've been trying to work around.  If a user is
>>> granted
>>> FULL_CONTROL over a bucket, they still can get 403s when trying to
>>> access/modify keys in that bucket.  Would it be appropriate to skip ACL
>>> checks for the key if the user has full control over the bucket or is
>>> there
>>> a good reason not to do so?
>>>
>>> I wanted to gauge the likelihood of acceptance for such a patch before
>>> starting in on it.  Any suggestions would be helpful.  I was thinking
>>> that
>>> modifications would mainly be necessary in verify_object_permission() in
>>> src/rgw/rgw_common.cc.
>>
>>
>> In general if it breaks S3 compatibility then such behavior would need
>> to be set through a configurable. If it's turned off by default I
>> don't really see why not to include such an option.
>>
>> Yehuda
>>
> Hi,
>
> I put in a pull request at https://github.com/ceph/ceph/pull/672 for this
> feature.  Do you guys have any feedback?  Is there anything I need to do to
> make this more appealing?
>

I still need to review it, have it on my todo list.

Thanks,
Yehuda
