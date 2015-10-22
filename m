From: John Spray <jspray@redhat.com>
Subject: Re: MDS stuck in a crash loop
Date: Thu, 22 Oct 2015 13:48:20 +0100
Message-ID: <CALe9h7e48B7hd-zpt-sxTuXRS8mg29ELqHGM+wM3ZBVQdwdoVQ@mail.gmail.com>
References: <CANP1eJGesJ_wGKDNQRJ952x8jkNHiJybeX075wxmJDurbSTMNw@mail.gmail.com>
 <CAJ4mKGY5uTZ6oiqZY4VbU5LdECXx5sko6VOd5aD2aEhtq74NDA@mail.gmail.com>
 <CANP1eJFNpLu3-HeqJ28L7xCTuKh-MhUT2j7A_tM7reofZ94FTQ@mail.gmail.com>
 <CANP1eJFGy4psfmUHpsgdPFT+UUW=NTzLTgAsnGqeuD6iWuF-cQ@mail.gmail.com>
 <CANP1eJHnavBzJRnDLa9gQ93haJ2QzKJsLj4+ZbS_vd1kquV8Lw@mail.gmail.com>
 <CANP1eJGmjechy8ZkVarA-HWdL37scmHdQXToM6NdAXxU-_KVMw@mail.gmail.com>
 <CANP1eJHYvgUKDCKrVYY=XkJsgcdVGn6T=drvEA8hofHyVX+0YA@mail.gmail.com>
 <CAJ4mKGYyza=MqV8zRS3cGA0EfbB=h=UhYbwO7QBgTb6FfzXSQw@mail.gmail.com>
 <CANP1eJGiPEx49nNyQgv3qo9ugVRAWnsh_WAHt33jHXX23S=0GQ@mail.gmail.com>
 <CAJ4mKGYHDew0LdQ65vNODiBw6u_jBrmyL3fzOWhB1TxKP8XidQ@mail.gmail.com>
 <CALe9h7fwpuz8Rv5GuqJ+-S9NDw8=uy37A+BfD3qW1Sa5FTHoxw@mail.gmail.com>
 <CALe9h7dGSWqLd0svDNyovtNZM0VUEuF+v6nQoT9HQe5TaOQrYw@mail.gmail.com> <CANP1eJG=H7FGxcfeLfQpJ_10Zngm9OMzt0=0=hX9pVxK8ndWjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33091 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755592AbbJVMsl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 08:48:41 -0400
Received: by obbwb3 with SMTP id wb3so66710404obb.0
        for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2015 05:48:40 -0700 (PDT)
In-Reply-To: <CANP1eJG=H7FGxcfeLfQpJ_10Zngm9OMzt0=0=hX9pVxK8ndWjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 22, 2015 at 1:43 PM, Milosz Tanski <milosz@adfin.com> wrote:
> On Wed, Oct 21, 2015 at 5:33 PM, John Spray <jspray@redhat.com> wrote:
>> On Wed, Oct 21, 2015 at 10:33 PM, John Spray <jspray@redhat.com> wrote:
>>>> John, I know you've got
>>>> https://github.com/ceph/ceph-qa-suite/pull/647. I think that's
>>>> supposed to be for this, but I'm not sure if you spotted any issues
>>>> with it or if we need to do some more diagnosing?
>>>
>>> That test path is just verifying that we do handle dirs without dying
>>> in at least one case -- it passes with the existing ceph code, so it's
>>> not reproducing this issue.
>>
>> Clicked send to soon, I was about to add...
>>
>> Milosz mentioned that they don't have the data from the system in the
>> broken state, so I don't have any bright ideas about learning more
>> about what went wrong here unfortunately.
>>
>
> Sorry about that, wasn't thinking at the time and just wanted to get
> this up and going as quickly as possible :(
>
> If this happens next time I'll be more careful to keep more evidence.
> I think multi-fs in the same rados namespace support would actually
> helped here, since it makes it easier to create a newfs and leave the
> other one around (for investigation)

Yep, good point.  I am a known enthusiast for multi-filesystem support :-)

> But makes me wonder that the broken dir scenario can probably be
> replicated by hand using rados calls. There's a pretty generic ticket
> there for don't die on dir errors, but I imagine the code can be
> audited and steps to cause a synthetic error can be produced.

Yes, that part I have done (and will build into the automated tests in
due course) -- the bit that is still a mystery is how the damage
occurred to begin with.

John

>
> --
> Milosz Tanski
> CTO
> 16 East 34th Street, 15th floor
> New York, NY 10016
>
> p: 646-253-9055
> e: milosz@adfin.com
