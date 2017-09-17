From: John Spray <jspray@redhat.com>
Subject: Re: REST APIs
Date: Sun, 17 Sep 2017 13:15:12 +0100
Message-ID: <CALe9h7f8wv8t8KzmfZE7wzACJR3FkySNBUUWTU33oWXLmYjNSw@mail.gmail.com>
References: <CALe9h7e02DdmcXPfJFP56c6KCpZ-DoRdS9nvNg1SHQFKuwr9qg@mail.gmail.com>
 <1505396014.391.8.camel@redhat.com> <CAA3h84tvKAryUt23GGBty9JcFZc8VdndnWx+ZLf7QYj3vUfH8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:46648 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbdIQMPe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Sep 2017 08:15:34 -0400
Received: by mail-wm0-f50.google.com with SMTP id i189so16473720wmf.1
        for <ceph-devel@vger.kernel.org>; Sun, 17 Sep 2017 05:15:33 -0700 (PDT)
In-Reply-To: <CAA3h84tvKAryUt23GGBty9JcFZc8VdndnWx+ZLf7QYj3vUfH8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ric Wheeler <rwheeler@redhat.com>
Cc: Boris Ranto <branto@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Sep 16, 2017 at 8:03 AM, Ric Wheeler <rwheeler@redhat.com> wrote:
> I think that makes sense - having REST APIs will give us a fairly universal
> way to plug into many other frameworks.

I don't think anyone objects in principle to the idea of a rest api,
the issue has been whether anyone is actually up for maintaining a
complete one, and the difficulty of doing that without any real users
to notice when something is broken.

John

>
> Ric
>
>
> On Sep 14, 2017 4:34 PM, "Boris Ranto" <branto@redhat.com> wrote:
>>
>> Hi,
>>
>> I still plan to port the v1 endpoints from calamari to the restful
>> module so that it provides a full replacement for calamari rest api and
>> so that it could be used by projects like tendlr.
>>
>> We do document the restful module in the RHCEPH product and several
>> people are/were interested in it. I did not hear of any product/app
>> being built on top of it yet though.
>>
>> We can extend the pass through method in the restful module so that it
>> is more user friendly for a more robust/useful replacement of the ceph-
>> rest-api.
>>
>> Regards,
>> Boris
>>
>>
>> On Wed, 2017-09-13 at 14:43 +0100, John Spray wrote:
>> > Hi all,
>> >
>> > This message is prompted by: https://github.com/ceph/ceph/pull/17530
>> >
>> > Questions:
>> >  - Is anyone using either ceph-rest-api or the restful module?
>> >  - Is anyone planning on doing any work on either?
>> >  - Is the CLI pass through of the restful module a sufficient
>> > replacement for ceph-rest-api for anyone that was using it?
>> >
>> > John
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
