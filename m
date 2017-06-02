From: John Spray <jspray@redhat.com>
Subject: Re: mgr dashboard and rest api configs
Date: Fri, 2 Jun 2017 14:42:10 +0100
Message-ID: <CALe9h7d39FswDZP7ky-E7yCHCnpUEXdaVt2mHsD_um1jTgosHQ@mail.gmail.com>
References: <alpine.DEB.2.11.1706012007280.15628@piezo.novalocal>
 <CALe9h7fmjF1Yvkvf068nzpvACKfo7qz5PJ5SZdhWsboueg1xFA@mail.gmail.com>
 <alpine.DEB.2.11.1706012208360.3646@piezo.novalocal> <1496394883.10067.8.camel@redhat.com>
 <alpine.DEB.2.11.1706021334430.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33420 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbdFBNmc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jun 2017 09:42:32 -0400
Received: by mail-wm0-f43.google.com with SMTP id m7so12282239wmg.0
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jun 2017 06:42:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1706021334430.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Boris Ranto <branto@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jun 2, 2017 at 2:35 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 2 Jun 2017, Boris Ranto wrote:
>> On Thu, 2017-06-01 at 22:16 +0000, Sage Weil wrote:
>> > That part I fixed with NamedTemporaryFile in
>> >         https://github.com/liewegas/ceph/commit/c169c8fd461bf94459cd9
>> > 8b658d2a2d8bf42bca6
>> >
>> > Was there also a python module dependency problem?  If not, it seems
>> > much  more natural for the module to create the crt/key pair the first
>> > time it  stats if it's not present...
>> >
>>
>> I had something like that before, see commit
>>
>> https://github.com/ceph/ceph/pull/14457/commits/92fa210aaa87fcc47b2491f
>> a44f029f7426cd7b9
>>
>> or
>>
>> https://github.com/ceph/ceph/pull/14457/commits/f59e9bf0bbda870311c6084
>> 74b9aad63f4323c43
>>
>> that removed/changed it. I had a couple more implementations that did
>> all sorts of things. I later removed all of them and went with as
>> simple solution as possible for two reasons:
>>
>> - the simple straight-forward solution is usually least likely to bite
>> us in the future
>> - it seemed almost impossible to get an agreement on how a more
>> sophisticated solution should actually look like (it felt like I was
>> going in the circles)
>>
>> The one removed in the first linked patch did not require any special
>> dependencies (make_ssl_devcert is part of werkzeug). The other linked
>> one required pyOpenSSL which was kinda bad as afaik, pyOpenSSL is not
>> being properly maintained.
>
> I like the make_ssl_devcert approach personally... John?

I just had a look at the werkzeug code and it seems to be using
pyOpenSSL too under the hood, so I guess has same issue as the other
approach?

If pyOpenSSL is not viable, maybe invoking the openssl CLI from inside
the module would still be neater than having the module depend on
packaging to do it?

John

>
> sage
