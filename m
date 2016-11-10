From: kefu chai <tchaikov@gmail.com>
Subject: Re: bump librados' soversion
Date: Thu, 10 Nov 2016 22:22:52 +0800
Message-ID: <CAJE9aOMfStDBYO07gjXkrY1+YyzZxFyE99Ga8nupGr18F2pRRA@mail.gmail.com>
References: <CAJE9aOMoOJSccnXA=gCxuO3KN+0fziF3mRhMxBcF3dy4tmwy9A@mail.gmail.com>
 <CA+aFP1BE+PFCnkYBwxARuL=PMGy5REdVW22tEvJGYkuchvhxiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33484 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933033AbcKJOWx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Nov 2016 09:22:53 -0500
Received: by mail-qk0-f178.google.com with SMTP id x190so295487637qkb.0
        for <ceph-devel@vger.kernel.org>; Thu, 10 Nov 2016 06:22:53 -0800 (PST)
In-Reply-To: <CA+aFP1BE+PFCnkYBwxARuL=PMGy5REdVW22tEvJGYkuchvhxiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Wed, Nov 9, 2016 at 9:52 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> Am I correct in assuming the original issue that forced this change
> was because a >2GB message was sent over the wire and that bug has
> been fixed?
>
> If so, can we just revert the API change and do a soversion bump when
> we really clean up the librados API, which has been talked about for a
> while now? There is some cleanup work needed in the librbd API that
> would break the API, so it would be nice to do it all at once instead
> of library-by-library, release-by-release.
>
> There only seems to be a few places within the codebase that even use
> "advance", and they could be switched over to a new a "advance2" /
> "advance64" method in the interim if required.


thanks Jason. okay! lets add an "advance2()" as the interim solution before
bumping the soversion.

>
> If we do bump the soversion for this, obviously the current failing
> client upgrade test would just need to be removed.
>
>
> On Wed, Nov 9, 2016 at 1:16 AM, kefu chai <tchaikov@gmail.com> wrote:
>> hi cephers,
>>
>> i am proposing bumping the soversion of librados2 to librados3. as in
>> 053bfa6[0], we changed the function signature of
>> ceph::buffer::list::advance(), which is incompatible with the prior
>> version of librados. that's partially why we have
>> http://tracker.ceph.com/issues/17809, in which, the old librbd client
>> fails to start, due to unresolved symbols.
>>
>> and if user has some (homebrew) packages depending on librados2. those
>> packages will be broken as well. the same applies to executables
>> linked against librados2 shared library. so we need to bump the
>> soversion. but to minimize the impact, i think we will not introduce
>> incompatible changes between major releases, in other words, the
>> soversion won't change from jewel to kraken, for example. if i
>> understand sage's comment correctly.
>>
>> yes, i knew this issue was raised before from time to time. but maybe
>> this is a good chance to do the soversion change in kraken.
>>
>> a PR is posted to address this problem. see
>> https://github.com/ceph/ceph/pull/11843.
>>
>> --
>> [0] https://github.com/ceph/ceph/pull/9395/commits/053bfa650ba1d656dfb20e389ef25afc4c383bb3
>> [1] https://github.com/ceph/ceph/pull/9395#issuecomment-224278945
>>
>> --
>> Regards
>> Kefu Chai
>
>
>
> --
> Jason



-- 
Regards
Kefu Chai
