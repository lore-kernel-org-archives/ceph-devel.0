From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Changes to md_config_t
Date: Fri, 14 Jul 2017 11:35:26 -0700
Message-ID: <CAJ4mKGZkA5=cGP=uqEqh_Qrd+Qi3W9LTUxocctsWgks9Lv0syQ@mail.gmail.com>
References: <CALe9h7fOeO07MH--+R40QoV2LHxPwZ6WDVhM=H4Raf09rqhjYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:37860 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdGNSf2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jul 2017 14:35:28 -0400
Received: by mail-it0-f45.google.com with SMTP id m84so29603180ita.0
        for <ceph-devel@vger.kernel.org>; Fri, 14 Jul 2017 11:35:28 -0700 (PDT)
In-Reply-To: <CALe9h7fOeO07MH--+R40QoV2LHxPwZ6WDVhM=H4Raf09rqhjYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jul 14, 2017 at 7:23 AM, John Spray <jspray@redhat.com> wrote:
> Hi all,
>
> There's a change headed for master soon
> (https://github.com/ceph/ceph/pull/16211) that will rework how config
> settings are declared.  Currently they're declared using a
> preprocessor macro, which is a bit too inflexible for some desirable
> enhancements like having different defaults for clients vs servers,
> adding more bounds/range checking, and adding more descriptive doc
> metadata.
>
> The thing that will effect you immediately is how to add new config settings:
>  - Add them in common/options.cc
>  - Access them using md_config_t::get()
>
> The old-style definitions for existing settings still exist in
> common/legacy_config_opts.h.  Do *not* add new definitions to that
> file.  All the definitions in that file now have equivalent
> definitions in common/options.cc, and the ones in common/options.cc
> are authoritative.
>
> The old header lives on in order to generate C++ member definitions
> for the options in md_config_t (i.e. so that you can get at them with
> g_conf->my_config_opt).  Once the consuming code has been modified to
> avoid accessing them that way, the entries from legacy_config_opts.h
> can be removed.
>
> This sacrifices the compile-time check that you would previously get
> by accessing a class member.

Aww, that's disappointing. Maybe of limited value, but if we ever typo
one of those options it's going to be rough to track down. What kind
of runtime checking is available? Could we maybe do something like
generate wrapper functions so each config value we know about at
compile time has a getter function we can invoke instead of
get(<string>)?


> The benefit is that we can do all the
> new-style stuff with clean C++, that we can in principle load
> definitions at runtime (e.g. from the planned central mon config
> store), and that md_config_t will now know which options are really in
> use (because they're accessed by function and not by direct member
> access).
>
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
