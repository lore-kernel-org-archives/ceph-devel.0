From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Ceph watchdog-like thing to reduce IO block during process goes
 down by abort()
Date: Thu, 24 Mar 2016 14:20:17 -0700
Message-ID: <CAJ4mKGbvi+RUxZUnK0HmQ8c886KUdiykXaqc7mZ=6E=TO7Jt8Q@mail.gmail.com>
References: <27d3bfba39234f83b8441abc4e9aea92@R01UKEXCASM222.r01.fujitsu.local>
	<CACJqLyax9Nntz09qJF2E_jjtoVa2moJxzW5T42bHVFGLop31Ug@mail.gmail.com>
	<6845351a143d41a3932b37efddcc1f75@R01UKEXCASM222.r01.fujitsu.local>
	<alpine.DEB.2.11.1603241646390.18774@cpach.fuggernut.com>
	<CAOi1vP8pDCbNej9a_5-THG_Dp70jG+_T6vzT36quBzsu4hiJgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35671 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcCXVUT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 17:20:19 -0400
Received: by mail-yw0-f175.google.com with SMTP id g127so75314473ywf.2
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2016 14:20:18 -0700 (PDT)
In-Reply-To: <CAOi1vP8pDCbNej9a_5-THG_Dp70jG+_T6vzT36quBzsu4hiJgQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@newdream.net>, "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>, Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Mar 24, 2016 at 2:15 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>
> Ultimately, this is about shrinking the time it takes for a MON to
> notice the "oops".  Do we expect those things to be common and frequent
> enough to justify an external daemon, however small and simple, on each
> OSD node?

Let's not forget that extra daemons aren't free quite apart from
having to build them. There's a lot of user education to happen.
There's more stuff to install; we'll have extra cephx keys for them
that need to get placed; we need to update all our install and
management tools to set them up. We'll probably run into new kinds of
resource exhaustion, and we'll hit new errors around the local
communication setup. :/ I'm uneasy about creating *any* mechanism that
automatically marks down OSDs, but isn't directed by the OSD in
question.

Plus, I think there are other benefits of annotating our asserts more
carefully. They're kind of a mess right now and if we were able to do
more than crash on disk errors, it'd be nice when we move on to
gathering statistics and things...
-Greg
