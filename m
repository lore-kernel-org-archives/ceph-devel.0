From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Build Warnings: spotting them, and cleaning them up
Date: Wed, 16 Nov 2016 14:27:22 -0800
Message-ID: <CAJ4mKGbUhfi5SA5UKNN_rZbPZ=eHHLohjzJeiy4qr+0sDg=7Eg@mail.gmail.com>
References: <CAJ4mKGa6ECp6Qdy9jU2fF_NWONKZp=hviTyN68LXvw94J9Fd9w@mail.gmail.com>
 <20161116221018.GA8507@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:38299 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423183AbcKPW1Y (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2016 17:27:24 -0500
Received: by mail-it0-f49.google.com with SMTP id o1so323437ito.1
        for <ceph-devel@vger.kernel.org>; Wed, 16 Nov 2016 14:27:24 -0800 (PST)
In-Reply-To: <20161116221018.GA8507@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, Nov 16, 2016 at 2:05 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> Unfortunately, we've got a problem: boost is notorious for build
> warnings. At the moment, I'm only seeing one (repeated many times
> over) resulting from use of the "remove_whitespace" iterator
> functionality in RGW. Does anybody know a good way to handle that?

Oh, there's also a warning coming from cls_rbd's use of the
optional_io.hpp boost header. I'm not clear on if it's actually an
internal warning or not ("warning: 't' may be used uninitialized in
this function [-Wmaybe-uninitialized]") since "t" is declared in our
include/encoding.h.

>
> We also have another (seemingly real) warning: the BlueStore
> BitAllocator says there are missing return statements in
> BmapEntry::operator new [](size_t). I didn't look at the code; maybe
> it's failing to detect return statements in an if-else block. But that
> should be fixed up as well.

And yet another signed/unsigned comparison warning popped up in PG.cc
from "MAX(min, cct->_conf->osd_scrub_chunk_max),"


On Wed, Nov 16, 2016 at 2:10 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 16/11/2016, Gregory Farnum wrote:
>> It turns out, Jenkins assumes the build is good if the build script
>> returns 0 — it doesn't know anything about the actual text output and
>> doesn't scan for warnings.
>> I'm not sure how hard it would be to change things from that end. From
>> the *compilation* end, Casey suggests the "nicest" thing would be to
>> set the -Werr flag, which turns all warnings into errors. Since we
>> like warning-free code, that's definitely appealing to me.
>> Unfortunately, we've got a problem: boost is notorious for build
>> warnings. At the moment, I'm only seeing one (repeated many times
>> over) resulting from use of the "remove_whitespace" iterator
>> functionality in RGW. Does anybody know a good way to handle that?
>
> I have a fix for this in my Clangtastic branch, it turns off warnings
> in the building of boost and makes inluded boost a system include.

Is that branch going to merge imminently? If not maybe we could pull
out this and the BlueStore fixes for fast merging. :)

>
>> We also have another (seemingly real) warning: the BlueStore
>> BitAllocator says there are missing return statements in
>> BmapEntry::operator new [](size_t). I didn't look at the code; maybe
>> it's failing to detect return statements in an if-else block. But that
>> should be fixed up as well.
>
> I have a fix for that I'm about to push, I just have it return nullptr
> and mark it noexcept.
>
> (We could also make it throw something and remove the assert entirely,
> but this is more in tune with the current pattern.)
>
>> 1) The Ceph source should build warning-free. If we have warnings
>> from external code we still trust, we need a way to suppress *only*
>> those warnings so that issues we introduce can easily be detected.
>
> This is in principle fairly easily done with cmake hackery. Either
> marking something as a system include path or fiddling the build flags
> per-target.

Is this different from the boost changes you mentioned you already have? :)
-Greg
