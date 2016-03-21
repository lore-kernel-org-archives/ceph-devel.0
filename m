From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: object class capability semantics
Date: Mon, 21 Mar 2016 09:52:23 -0700
Message-ID: <CAJ4mKGY4VMk+dbF59RWmY+LkvG_26d-X0xADHFpYyZqOJnkNqA@mail.gmail.com>
References: <CAB2gnbVFypTbHREtJAb6od1bC9ZpRtCz04BHg=6Yqmi5eEtP2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:32773 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429AbcCUQwY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2016 12:52:24 -0400
Received: by mail-vk0-f47.google.com with SMTP id k1so222082610vkb.0
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2016 09:52:24 -0700 (PDT)
In-Reply-To: <CAB2gnbVFypTbHREtJAb6od1bC9ZpRtCz04BHg=6Yqmi5eEtP2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>, Samuel Just <sjust@redhat.com>

On Mon, Mar 21, 2016 at 8:55 AM, Noah Watkins <noahwatkins@gmail.com> wrote:
> This is a follow-up e-mail from the CDS meeting at the beginning of
> the month regarding merging cls-lua (http://pad.ceph.com/p/cls-lua). I
> want to clarify the semantics of what was discussed.
>
> # Class Load List
>
> Purpose: option to specify the names of object classes that are
> permitted to be loaded.
>
> Format: `osd class load list = * | [class[ class[ ...]]`
>    1) * any class may be loaded
>    2) list of class names allowed
>
> Default: list of classes shipping in tree?
>
> Classes loaded as a dependency of another class are not required to be
> listed. The `osd_open_classes_on_start` option is affected by
> filtering based on this list.
>
> # Class Execute Capabilities
>
> Purpose: wire up class capabilities and add an option to specify the
> names of object classes are allowed to be used without explicit
> capabilities.
>
> ## Default Object Class List
>
> Format: `osd class default list = * | [class[ class[ ...]]`
>    1) * any class may be loaded
>    2) list of class names allowed
>
> Interpretation of this option is described below.
>
> ## Enabling Class Capabilities
>
> It looks like currently in OSDCap::is_capable() that 'x' and class
> read/write capabilities are checked. The first change would be to
> cross reference these checks with the `osd class default list` to
> ensure that the class is on the allowed list.

Woah, no way. These are capabilities, and are additive. We and our
users are going to be very unhappy if the security meaning of one cap
changes depending on others.

So I take it you mean for those execute and load capabilities to be
applied to clients, not the OSD or class methods or something? In that
case we can just stick them as additional clauses within the class
cap, and I guess take the missing clause to be "all" or the default
set or something.

> The second change would be to enable the class capabilities that
> explicitly name classes. I see two formats. The first format only
> specifies a class name:
>
> allow [match] class <name>
>   1) execute any method
>   2) does not need to be in `osd class default list`
>
> The second format specifies a class name and class cap as a generic string:
>
> allow [match] class <name> <classcap>
>   1) execute class methods subject to classcap
>   2) does not need to be in `osd class default list`
>
> I didn't see anything on how `classscap` is interpreted, so I'm
> guessing that this is intended to be used as a way for classes to
> enforce their own cap policies?

I think that's right.
-Greg

>
> If so, we'd have a new class method:
>
> - bool ClassHandler::ClassData::is_capable(std::string)
> - where is_capable is passed OSDCapSpec::class_allow
>
> Thanks,
> Noah
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
