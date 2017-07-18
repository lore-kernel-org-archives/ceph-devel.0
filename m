From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Changes to md_config_t
Date: Tue, 18 Jul 2017 13:08:33 -0700
Message-ID: <CAJ4mKGYjWu0fo82RSkGwzKHZeotyPF8BSahPmHMh0Eds_N5f+Q@mail.gmail.com>
References: <CALe9h7fOeO07MH--+R40QoV2LHxPwZ6WDVhM=H4Raf09rqhjYg@mail.gmail.com>
 <CAJ4mKGZkA5=cGP=uqEqh_Qrd+Qi3W9LTUxocctsWgks9Lv0syQ@mail.gmail.com> <CALe9h7fVLO4xBsZ62uqEkyN-JG=ei+GYO4FD6ORQTbZRpkFSPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:36982 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdGRUIe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jul 2017 16:08:34 -0400
Received: by mail-it0-f49.google.com with SMTP id v127so9612859itd.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jul 2017 13:08:34 -0700 (PDT)
In-Reply-To: <CALe9h7fVLO4xBsZ62uqEkyN-JG=ei+GYO4FD6ORQTbZRpkFSPA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jul 18, 2017 at 3:54 AM, John Spray <jspray@redhat.com> wrote:
> On Fri, Jul 14, 2017 at 7:35 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>> On Fri, Jul 14, 2017 at 7:23 AM, John Spray <jspray@redhat.com> wrote:
>>> Hi all,
>>>
>>> There's a change headed for master soon
>>> (https://github.com/ceph/ceph/pull/16211) that will rework how config
>>> settings are declared.  Currently they're declared using a
>>> preprocessor macro, which is a bit too inflexible for some desirable
>>> enhancements like having different defaults for clients vs servers,
>>> adding more bounds/range checking, and adding more descriptive doc
>>> metadata.
>>>
>>> The thing that will effect you immediately is how to add new config settings:
>>>  - Add them in common/options.cc
>>>  - Access them using md_config_t::get()
>>>
>>> The old-style definitions for existing settings still exist in
>>> common/legacy_config_opts.h.  Do *not* add new definitions to that
>>> file.  All the definitions in that file now have equivalent
>>> definitions in common/options.cc, and the ones in common/options.cc
>>> are authoritative.
>>>
>>> The old header lives on in order to generate C++ member definitions
>>> for the options in md_config_t (i.e. so that you can get at them with
>>> g_conf->my_config_opt).  Once the consuming code has been modified to
>>> avoid accessing them that way, the entries from legacy_config_opts.h
>>> can be removed.
>>>
>>> This sacrifices the compile-time check that you would previously get
>>> by accessing a class member.
>>
>> Aww, that's disappointing. Maybe of limited value, but if we ever typo
>> one of those options it's going to be rough to track down. What kind
>> of runtime checking is available? Could we maybe do something like
>> generate wrapper functions so each config value we know about at
>> compile time has a getter function we can invoke instead of
>> get(<string>)?
>
> If you do a g_conf->get_val<int64_t>("typo") you'll get an exception
> (i.e. your process will abort).  In general, I'm expecting that if
> someone had a typo like that they'd be catching it in unit tests or at
> worst teuthology tests -- i.e. the issue gets caught before code is
> merged.
>
> It is certainly possible to do a code generation thing that compiles
> options.cc and then generates a class with defined accessor methods,
> but I see that as much less important than the change to expose nicer
> behaviour and doc strings for the user.  Given that anyone typoing an
> option will find out Real Soon when their tests fail, I'm not sure
> it's worth adding the complexity to the build.

You're probably right. I'm just a little concerned for when we set up
builds that let users work around or debug stuff we haven't been able
to reproduce locally, or when we're naughty and don't set up enough
tests anyway. But I'm glad to hear it's really obvious when you try
and lookup something nonexistent.

>
> I am interested in making the access a bit slicker though (i.e.
> avoiding taking md_config_t's lock every time you want to get a
> value),

I presume that doesn't (yet) apply to the generated-code stuff being
pulled over from legacy_config_opts? ;)

 but creatings some binder classes, that would go get their
> values at first access, register themselves with md_config_t, and then
> have an atomic_t dirty bit that md_config_t can set to prompt them to
> re-fetch if the value ever changes.

Hmm, I'm not sure I see a good use for this. If we need to do a memory
barrier on every config lookup, we'll presumably need to be making our
own copies and registering a config watcher for updates anyway to make
stuff fast enough. (And if the memory barrier is fast enough,
serializing on the config mutex won't matter either.)

Thanks!
-Greg

>
> John
>
>
>
>>
>>
>>> The benefit is that we can do all the
>>> new-style stuff with clean C++, that we can in principle load
>>> definitions at runtime (e.g. from the planned central mon config
>>> store), and that md_config_t will now know which options are really in
>>> use (because they're accessed by function and not by direct member
>>> access).
>>>
>>> John
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
