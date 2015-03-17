From: Gregory Farnum <greg@gregs42.com>
Subject: Re: regenerating man pages
Date: Tue, 17 Mar 2015 12:32:17 -0700
Message-ID: <CAC6JEv8Gogaspvva0MygWZ5AzwXTqaNRMbfo65XtsmcYiZYagw@mail.gmail.com>
References: <55085911.9060800@redhat.com>
	<55085B32.9000305@redhat.com>
	<alpine.DEB.2.00.1503171011020.3716@cobra.newdream.net>
	<55088008.8010807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33570 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbbCQTcS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Mar 2015 15:32:18 -0400
Received: by ignm3 with SMTP id m3so59430890ign.0
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 12:32:17 -0700 (PDT)
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com. [209.85.213.179])
        by mx.google.com with ESMTPSA id 192sm9157706ioo.38.2015.03.17.12.32.17
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2015 12:32:17 -0700 (PDT)
Received: by igcau2 with SMTP id au2so43946181igc.0
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2015 12:32:17 -0700 (PDT)
In-Reply-To: <55088008.8010807@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Ken Dreyer <kdreyer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah. If this has gotten easier it's fine, but asphyxiate required a
*lot* of tooling that I'd rather we not require as developer build
deps. I'd imagine we can just produce them as part of the Jenkins
build procedure or something?
-Greg

On Tue, Mar 17, 2015 at 12:27 PM, David Zafman <dzafman@redhat.com> wrote:
>
> I found that I could not build the docs on Ubuntu 14.10 with the proper
> packages installed.  Kefu is looking into Asphyxiate which is very
> tempermental.  I installed an Ubuntu 11.10 in order to generate docs.
>
> David
>
>
> On 3/17/15 10:11 AM, Sage Weil wrote:
>>
>> On Tue, 17 Mar 2015, Josh Durgin wrote:
>>>
>>> On 03/17/2015 09:40 AM, Ken Dreyer wrote:
>>>>
>>>> I had a question about the way that we're handling man pages.
>>>>
>>>> In 356a749f63181d401d16371446bb8dc4f196c2a6 , "rbd: regenerate rbd(8)
>>>> man page", it looks like man/rbd.8 was regenerated from
>>>> doc/man/8/rbd.rst
>>>>
>>>> It seems like it would be more efficient to avoid storing man pages in
>>>> Git and generate them dynamically at build time instead?
>>>
>>> Yes, that'd be great!
>>>
>>>> https://github.com/ceph/ceph/blob/master/admin/manpage-howto.txt
>>>>
>>>> "admin/build-doc" does a lot of things (including man page generation).
>>>> Could we simply run the "sphinx-build -b man" part at build time as a
>>>> part of "make"?
>>>
>>> I don't see a reason not to. It's just a matter of making it work on all
>>> the platforms we're building packages for. That might be annoying for
>>> the entirety of build-doc, but for just building man pages it should
>>> be simple.
>>
>> I think the original reason we didn't was just because there are a lot of
>> dependencies for building the docs, so this inflates Build-Depends.  That
>> doesn't particularly bother me, though, if the deps do in fact exist.
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
