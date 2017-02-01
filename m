From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2 01/13] ceph: add new r_req_flags field to ceph_mds_request
Date: Wed, 1 Feb 2017 20:10:34 +0100
Message-ID: <CAOi1vP9BszmpzTfM-gC2+JGY4MZeJJfAZPhNh+uXYJpKKwHjqw@mail.gmail.com>
References: <20170130161942.16537-1-jlayton@redhat.com> <20170201114914.20808-1-jlayton@redhat.com>
 <20170201114914.20808-2-jlayton@redhat.com> <CAOi1vP9hGnsqVMnZV7RO7f4AQUEFsnD0VeuAcumTOcQu2sZ8+Q@mail.gmail.com>
 <1485971230.20965.1.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34036 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdBATKg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2017 14:10:36 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so7619809wmi.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2017 11:10:35 -0800 (PST)
In-Reply-To: <1485971230.20965.1.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>

On Wed, Feb 1, 2017 at 6:47 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Wed, 2017-02-01 at 15:08 +0100, Ilya Dryomov wrote:
>> On Wed, Feb 1, 2017 at 12:49 PM, Jeff Layton <jlayton@redhat.com> wrote:
>> > ...and start moving bool flags into it.
>> >
>> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
>> > ---
>> >  fs/ceph/dir.c        | 2 +-
>> >  fs/ceph/mds_client.c | 2 +-
>> >  fs/ceph/mds_client.h | 4 +++-
>> >  3 files changed, 5 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> > index d4385563b70a..04fa4ae3deca 100644
>> > --- a/fs/ceph/dir.c
>> > +++ b/fs/ceph/dir.c
>> > @@ -371,7 +371,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>> >                 /* hints to request -> mds selection code */
>> >                 req->r_direct_mode = USE_AUTH_MDS;
>> >                 req->r_direct_hash = ceph_frag_value(frag);
>> > -               req->r_direct_is_hash = true;
>> > +               set_bit(CEPH_MDS_R_DIRECT_IS_HASH, &req->r_req_flags);
>>
>> Hi Jeff,
>>
>> Just a couple of nits:
>>
>> These are atomic -- should probably mention in the commit message why
>> is atomicity needed.
>>
>
> It's not strictly needed for most of this stuff. DIRECT_IS_HASH in
> particular could just use __set_bit.
>
> The rest of the flags, I think are already protected from concurrent
> writes by mutexes in the code. What I'm not sure of is whether they are
> protected by the _same_ lock. That's a requirement if we mix all of the
> flags together into the same word and don't want to use the atomic
> *_bit macros.
>
> I can look and see if that's possible. Even if it's not though, using
> the atomic *_bit macros is generally not that expensive (particularly
> in a situation where we're already using sleeping locks anyway).

Auditing for whether __set_bit, etc can be used instead is probably not
worth it.  I'm not saying we shouldn't use atomic bitops here -- just
wanted to get this explanation in the commit message.

Thanks,

                Ilya
