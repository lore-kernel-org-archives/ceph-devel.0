From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: RBD image name constraints
Date: Mon, 11 Apr 2016 17:08:17 +0200
Message-ID: <CAOi1vP9a1qtB0RjbEuoj=Lwy99h32KRh6OArGQO-xzAZpOndUA@mail.gmail.com>
References: <5707A2C4.3030102@corp.ovh.com>
	<20160408202919.GA8043@gmail.com>
	<570B6436.9040109@corp.ovh.com>
	<20160411093703.GA17959@gmail.com>
	<1377018242.49644766.1460384950765.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35702 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbcDKPIT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 11:08:19 -0400
Received: by mail-lf0-f47.google.com with SMTP id c126so161346780lfb.2
        for <ceph-devel@vger.kernel.org>; Mon, 11 Apr 2016 08:08:18 -0700 (PDT)
In-Reply-To: <1377018242.49644766.1460384950765.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Mykola Golub <mgolub@mirantis.com>, =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?= <bartlomiej.swiecki@corp.ovh.com>, Ceph Development <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

On Mon, Apr 11, 2016 at 4:29 PM, Jason Dillaman <dillaman@redhat.com> wrote:
>> > >
>> > >You can still bypass the limitation by using --pool, --image, and
>> > >--snap options, and I would recommend to always use these in scripts
>> > >instead of specs.
>> > >
>> > True, but even if I specify image name with --image argument it still goes
>> > through rbd::utils::extract_spec function (or set_pool_image_name in old
>> > code) so there's no way to put there any raw name I want.
>>
>> Ah, it is rather unfortunate!
>>
>> I expected that with --image argument you could only specify image
>> name, but now I see we even have a comment in the code:
>>
>>     // despite the separate pool and snapshot name options,
>>     // we can also specify them via the image option
>>
>> I would prefer if it was possible to specify only image name with
>> --image argument, but I guess it would cause backward compatibility
>> issues, so, the simplest solution may be to ease the regexp to:
>>
>>   "^(?:([^/@]+)/)?([^@]+)(?:@([^@]+))?$" ?
>>
>> Or may be even:
>>
>>   "^(?:([^/@]+)/)?([^@]+)(?:@(.+))?$" ?
>>
>
> It would probably make sense to relax it for non-create operations and use a strict regex for create/clone/import/rename operations.

I think it would also make sense to start enforcing a limit on the
length of the image name on create/clone/etc.  I'm not pushing for it
to be 96 chars (although I do believe it'd be sensible), just that we
don't want it to be RADOS - strlen("rbd_id.").

Thanks,

                Ilya
