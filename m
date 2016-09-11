From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: rgw: feedback on auth engine selection
Date: Mon, 12 Sep 2016 01:20:33 +0200
Message-ID: <CA+H5UW2TMo=axqbg78Nva5DLTXgigORZw3ZT3btAjoXLSdRq9A@mail.gmail.com>
References: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com>
 <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com>
 <45ac8340-c6eb-8cdc-9c83-3db6f7f3fcd6@redhat.com> <CA+H5UW3J3XtMeqhH7FjRCe-ocep-ZidLSpNX=1y=sX6GmcamRQ@mail.gmail.com>
 <d1335f1c-26ce-5d46-8cc3-af806be25822@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34821 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbcIKXUe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Sep 2016 19:20:34 -0400
Received: by mail-qk0-f178.google.com with SMTP id t7so24253699qkh.2
        for <ceph-devel@vger.kernel.org>; Sun, 11 Sep 2016 16:20:34 -0700 (PDT)
In-Reply-To: <d1335f1c-26ce-5d46-8cc3-af806be25822@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi Casey,

On Thu, Sep 8, 2016 at 10:49 PM, Casey Bodley <cbodley@redhat.com> wrote:
> Thanks for the extra background! You've convinced me that it makes sense to
> extend the auth interfaces to support this instead of treating it as a
> special case. But I still don't think that AuthEngine is the right place to
> manage that state - mainly because each request will be trying to
> authenticate against multiple different engines, and only one of them will
> be successful. So with stateful AuthEngines, we'll have to construct and
> destruct instances for all of the engines that fail, and then once we find
> one that succeeds, we have to move or copy that instance to extend its
> lifetime to that of the req_state. I don't see a generic way to do that
> without an extra allocation.

I see your concerns. I think we can deal with the issues of additional
dynamic allocations and moving/copying memory as well.

At the moment ::authorize() of the Swift API's handler instantiates
multiple engines on stack only to form the array of interface-typed
pointers. I'm pretty sure we can create them in the step-by-step
manner and perform the real job having only one instance alive
at the same time. The mockup of AuthStrategy::Visitor interface is
designed to utilize this pattern.

We can pair the step-by-step processing together with the static_ptr,
that already has the emplace<ConreteClass>(ctor, args) machinery,
to create AuthEngine instance directly in its final location.

This way we can avoid creation of disabled auth engines, dynamic
memory allocations, std::moving/copying between ::authorize() scope
and req_state and even optimize the on-stack memory usage.

> I pointed out AuthApplier (which is what we return from a successful call to
> AuthEngine::authorize()) earlier, because it's an existing example of auth
> state that we store with req_state for later access. That seems like a much
> better pattern for something like AuthCompletion. I suggested combining this
> with AuthApplier, because a) then we don't have to allocate the completion
> state separately, and b) the completion is a noop for most auth engines.

What makes me a bit uncomfortable with putting the authenticate_complete()
into AuthApplier is mixing responsibilities. Applier operates in the area
of identity - it verifies whether someone owns an account, has the admin
status, loads its account info and so on. AuthEngine in turn is supposed
to encapsulate the request authentication process.

Verifying message integrity looks like a part of request authentication
and thus conceptually seems to be the Engine's job.

Regards,
Radek
