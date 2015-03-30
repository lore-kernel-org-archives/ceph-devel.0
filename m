From: Gregory Farnum <greg@gregs42.com>
Subject: Re: ceph versions
Date: Mon, 30 Mar 2015 13:09:35 -0700
Message-ID: <CAC6JEv8mi8cp65a8ebWCgAh6x97KbtfRWC3AdU8KSLxQgvA+fw@mail.gmail.com>
References: <alpine.DEB.2.00.1502261451220.1619@cobra.newdream.net>
	<alpine.DEB.2.00.1503301130050.31431@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34935 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbbC3UJh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Mar 2015 16:09:37 -0400
Received: by ierf6 with SMTP id f6so504856ier.2
        for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2015 13:09:36 -0700 (PDT)
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com. [209.85.223.177])
        by mx.google.com with ESMTPSA id g195sm8120016iog.24.2015.03.30.13.09.35
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2015 13:09:35 -0700 (PDT)
Received: by iedfl3 with SMTP id fl3so602256ied.1
        for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2015 13:09:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1503301130050.31431@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Mar 30, 2015 at 1:01 PM, Sage Weil <sage@newdream.net> wrote:
> Resurrecting this thread since we need to make a decision soon.  The
> opinions broke down like so:
>
>  A - me
>  B - john
>  C - alex
>  D - loic (and drop release names), yehuda, ilya
>  openstack - dmsimard
>
> So, most people seem to like D (below):
>
> On Thu, 26 Feb 2015, Sage Weil wrote:
>> -- Option D -- "labeled"
>>
>> X.Y-{dev,rc,release}Z
>>
>>  - Increment Y on each major named release
>>  - Increment X if it's a major major named release (bigger change
>> than usual)
>>  - Use dev, rc, or release prefix to clearly label what type of release
>> this is
>>  - Increment Z for stable updates
>>
>>  1.0-dev1 first infernalis dev release
>>  1.0-dev2 another dev release
>>  ...
>>  1.0-rc1 first rc
>>  1.0-rc2 next rc
>>  1.0-release1 final release
>>  1.0-release2 stable update
>>  1.0-release3 stable update
>>  1.1-dev1 first cut for j-release
>>  1.1-dev2 ...
>>  ...
>>  1.1-rc1
>>  1.1-release1 stable
>>  1.1-release2 stable
>>  1.1-release3 stable
>
> This initialy made me a bit sad because it wasn't my favorite.  My
> aesthetic issues aside, though, I think more explicit dev vs release
> distinction is important and useful.  I think the main issue is the
> strings in the version which will cause pain for some distros.
>
> Would this make sense instead?
>
>  x.0.z - development releases
>  x.1.z - release candidate(s)
>  x.2.z - release and bugfix updates

The problem with encoding information about the kind of release into
digits is that you have to know what they mean. I guarantee you that
people are going to install dev release by mistake (because it's a
higher-valued point release!) if we go this route.

I didn't vote before because I don't know much about the difficulty
any of these will cause in packaging and distros, but just in terms of
clarity and user experience I really prefer "vanilla" D to the
others...
-Greg

>
> John preferred B (even/odd) because it encodes the important info in the
> x.y portion of the version; I think the above does that too, and a bit
> more succinctly.
>
> What do you think?
>
> If that works for people, the follow-up question is what initial X value
> we should choose.  We could go with 1 (and live with the baggage
> associated with what "1.0" is supposed to mean), or with 9 (J is the 9th
> letter).  And if we do that, should we make the hammer release 8.2.0 or
> stick with 0.94?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
