From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: rgw: feedback on auth engine selection
Date: Wed, 7 Sep 2016 19:19:01 +0200
Message-ID: <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com>
References: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35036 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbcIGRTD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2016 13:19:03 -0400
Received: by mail-qk0-f171.google.com with SMTP id v123so21729497qkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 07 Sep 2016 10:19:02 -0700 (PDT)
In-Reply-To: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, Orit Wasserman <owasserm@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, mdw@redhat.com, Pritha Srivastava <prsrivas@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Casey!

I think we could make that with currently existing
AuthEngines. Although they have some internal
state, rework of authenticate() methods to return
a pair consisted with enum (GRANTED, DENIED,
TRY_NEXT) and AuthApplier would allow to strip
it down.

Where I see problems is AWS Auth v4. It's truly
state-full. And when it comes to handling state,
I would prefer to use the language assistance for
it (non-static class members) instead of letting
internals (context) leak to req_state.

Anyway, before we start discussing the whole
auth stuff further, I guess it would be helpful to
write in one place all requirements/plans that
might affect this area. For instance, the idea of
RGWHandler rework can have such impact.

Let me start the requirements with an item found
after a session with Swift's FormPost middleware:

* the auth infrastructure must allow for easy-adoption
  of new AuthEngines as even FormPost would need
  one :-).

Regards,
Radek


On Tue, Sep 6, 2016 at 11:49 PM, Casey Bodley <cbodley@redhat.com> wrote:
> Hi Radek and friends,
>
> Matt and I have been discussing the auth strategy work in progress at
> https://github.com/ceph/ceph/pull/10925.
>
> With respect to the original auth rework, I really like the distinction
> between the Engine and the Applier, with only the Applier having access to
> the req_state. But I feel like we could have gone a step further with
> Engine, to remove all per-request state so that a single Engine instance
> could be reused for each request.
>
> It looks like this could be accomplished pretty easily by adding req_state*
> as an argument to the authenticate() function. Token extraction, if
> necessary, would happen internally to authenticate() so we shouldn't need to
> store the token in RGWTokenBasedAuthEngine. It doesn't look like the other
> engines need to store much either (let me know if I'm missing something!),
> but if there is important state that's unique to a given engine, we might
> consider moving it into the associated Applier.
>
> Having an Engine without per-request state means that, on initialization, we
> just need to generate a vector of Engines (pointers or unique_ptrs because
> they're polymorphic). RGWHandler_REST_SWIFT::authorize() works pretty much
> exactly as it is, except you loop over that vector instead of the std::array
> of Engines on the stack.
>
> I feel like the current AuthStrategy design is trying to get here, but by
> adding extra abstractions instead of collapsing the existing layers. Do you
> buy that?
>
> Thanks,
> Casey
