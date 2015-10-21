From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: MDS stuck in a crash loop
Date: Wed, 21 Oct 2015 14:34:40 -0700
Message-ID: <CAJ4mKGZok4GkwFPU2Yv1FY07bFBqHCmXP4MBAd-YBsvxL9-VKw@mail.gmail.com>
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
	<CALe9h7dGSWqLd0svDNyovtNZM0VUEuF+v6nQoT9HQe5TaOQrYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35566 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061AbbJUVem (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Oct 2015 17:34:42 -0400
Received: by wicll6 with SMTP id ll6so109631018wic.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2015 14:34:41 -0700 (PDT)
In-Reply-To: <CALe9h7dGSWqLd0svDNyovtNZM0VUEuF+v6nQoT9HQe5TaOQrYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Oct 21, 2015 at 2:33 PM, John Spray <jspray@redhat.com> wrote:
> On Wed, Oct 21, 2015 at 10:33 PM, John Spray <jspray@redhat.com> wrote:
>>> John, I know you've got
>>> https://github.com/ceph/ceph-qa-suite/pull/647. I think that's
>>> supposed to be for this, but I'm not sure if you spotted any issues
>>> with it or if we need to do some more diagnosing?
>>
>> That test path is just verifying that we do handle dirs without dying
>> in at least one case -- it passes with the existing ceph code, so it's
>> not reproducing this issue.
>
> Clicked send to soon, I was about to add...
>
> Milosz mentioned that they don't have the data from the system in the
> broken state, so I don't have any bright ideas about learning more
> about what went wrong here unfortunately.

Yeah, I guess we'll just need to watch out for it in the future. :/
