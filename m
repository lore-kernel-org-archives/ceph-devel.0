From: Junwang Zhao <zhjwpku@gmail.com>
Subject: Re: wip-addr-features
Date: Tue, 10 May 2016 09:07:08 +0800
Message-ID: <CAEG8a3JdpRAzYn6nbrMf+aWDdV3Dj2QmGyiVUDVYV2c89z+XfA@mail.gmail.com>
References: <alpine.DEB.2.11.1605051043220.15518@cpach.fuggernut.com>
	<CAEG8a3JUtTuw_MYw=k18GWAFQgFHfR408dDoJBOV2NcqECYpdA@mail.gmail.com>
	<alpine.DEB.2.11.1605090817260.15518@cpach.fuggernut.com>
	<CAEG8a3Ku1==qQ73cc6TQh=2pLAPYKf=ou8BvvcjSLeG=Vw=Cag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34068 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbcEJBHK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 May 2016 21:07:10 -0400
Received: by mail-vk0-f67.google.com with SMTP id v68so7116239vka.1
        for <ceph-devel@vger.kernel.org>; Mon, 09 May 2016 18:07:09 -0700 (PDT)
In-Reply-To: <CAEG8a3Ku1==qQ73cc6TQh=2pLAPYKf=ou8BvvcjSLeG=Vw=Cag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

Check this:
https://github.com/zhjwpku/ceph/commit/2dddc32eb18c2a065963ae33674cb2c8a9e64dc5

The original patch doesn't compile, I add dump and
generate_test_instances, now it passed
the 'make', I am running the 'make check'.

Not sure did I do it right, please give some feedback.

Thanks!

On Mon, May 9, 2016 at 10:14 PM, Junwang Zhao <zhjwpku@gmail.com> wrote:
> I am working on it, the complie is quite slow, I will ping you tomorrow.
>
> BR,
> Zhao
>
> On Mon, May 9, 2016 at 8:20 PM, Sage Weil <sweil@redhat.com> wrote:
>> Hi Junwang,
>>
>> On Sun, 8 May 2016, Junwang Zhao wrote:
>>> This weekend, I read the wip-addr-features patches in your repo and
>>> the related wip-addr patches in ceph repo, I understand that my task
>>> is to make the required-features-patch work by breaking done the 'wip'
>>> into small patches to make the required-features-patch finally work.
>>> I got one question, when I applied a small individual patch, how can I
>>> know it works, will 'make' tell(from the errors)?
>>
>> 'make' is the first barrier.  Making sure 'make check' passes would be
>> the next step.  You might want to make sure this passes on your machine
>> before making any changes, as it can be somewhat sensitive to the
>> environment.
>>
>> Breaking up the current changes into a patch series is a start.  I would
>> start with that and check in (ping us in #ceph-devel).  There are also
>> still a lot of remaining places where we don't have features yet and the
>> code still doesn't compile.  Usually it's a matter of adding arguments to
>> a chain of calling functions.  If you're not sure how to proceed check
>> with us on IRC.
>>
>> Thanks!
>> sage
>>
>>>
>>> Cheers!
>>> Zhao
>>>
>>> On Thu, May 5, 2016 at 11:41 PM, Sage Weil <sweil@redhat.com> wrote:
>>> > Hi Zhao,
>>> >
>>> > We identified wip-addr as a desireable first step to fixing up the
>>> > messenger protocol.  It has a bunch of other nice benefits as well, like
>>> > being able to support both IPv4 and IPv6 in the same cluster.
>>> >
>>> > I started rebasing the branch this morning ran into a bunch of non-trivial
>>> > questions about how we should structure the entity_addr_t to support both
>>> > new address types (ipv4, ipv6, xio, etc.) *and* the a new on-wire
>>> > protocol.  But this is actually step 2...
>>> >
>>> > Step 1 is to just get the feature bits plumbed down to every bit of code
>>> > that encodes an entity_addr_t to send over the wire so that we will
>>> > know whether to encode using the new or legacy format.  To do that, I
>>> > pushed a simplified branch, wip-addr-features, to
>>> >
>>> >         https://github.com/liewegas/ceph/commits/wip-addr-features
>>> >
>>> > The are some prelim encoding patches, then a patch that makes
>>> > entity_addr_t and entity_inst_t *optionally* accept feature bits.  Let's
>>> > call it optional-features-patch.  This compiles cleanly, and allows either
>>> > an existing featureless encode
>>> >
>>> >   entity_addr_t foo;
>>> >   ::encode(foo, bl);             // old way we need to eliminate
>>> >
>>> > or a featured encode
>>> >
>>> >   entity_addr_t foo;
>>> >   ::encode(foo, bl, features);   // what we want
>>> >
>>> > compile.
>>> >
>>> > Then there's a patch that makes the old way not compile.  Let's call it
>>> > required-features-patch.  This will make the compiler spit out a million
>>> > errors for all the call sites that still need to be fixed.
>>> >
>>> > Finally, there is a 'wip' commit that fixes some but not all call sites.
>>> > This commit needs to be broken down into simple, individual changes that
>>> > can be tested and reviewed separately.
>>> >
>>> > The idea is to work with the require-features-patch applied to identify
>>> > remaining call sites that need features to encode entity_addr_t.  Create
>>> > small, contained patches that fix individual modules, call sites, or add
>>> > supporting infrastructure (like the changes that expose features to OSD
>>> > cls ops in objclass/*).
>>> >
>>> > Once there are several of those, remove the require-features-patch, and
>>> > make sure the changes are safe and clean and everything still works
>>> > properly.  We can merge these as we go to make incremental progress.
>>> >
>>> > Finally, once *everything* is fixed to pass features to addr encode sites,
>>> > the last commit will be the require-features-patch, and we can get it all
>>> > in master.
>>> >
>>> > That will lay the foundation so that we can change the entity_addr_t
>>> > encoding to support the new protocols and encoding, the entity_addrvec_t
>>> > type, and so on.
>>> >
>>> > (The plan is to replace most instnaces of entity_addr_t with
>>> > entity_addrvec_t--a list of addresses instead of a single one.  And make
>>> > entity_addrvec_t encoded with old features spit out the legacy addr with
>>> > the legacy entity_addr_t encoding so that old clients can still function.)
>>> >
>>> > We're all in #ceph-devel on irc.oftc.net--feel free to ask questions there
>>> > or on this email thread.  Or we can do another video conf session to go
>>> > through it.
>>> >
>>> > Thanks!
>>> > sage
>>>
>>>
