From: Gregory Farnum <greg@inktank.com>
Subject: Re: omap functions in librados.h
Date: Fri, 17 Aug 2012 12:54:59 -0700
Message-ID: <CAPYLRzhw9BF+9h6y4WUW113oc71OHQnecACNK0sw7oXbqiUpLA@mail.gmail.com>
References: <502E9D44.6010006@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59809 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757664Ab2HQTzB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 15:55:01 -0400
Received: by lbbgj3 with SMTP id gj3so2329130lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Aug 2012 12:55:00 -0700 (PDT)
In-Reply-To: <502E9D44.6010006@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 17, 2012 at 12:36 PM, Wido den Hollander <wido@widodh.nl> wrote:
> Hi,
>
> I'm looking for the omap functions in librados.h, but they only seem to be
> implemented in librados.hpp?
>
> I want to store about 6000 objects in a RADOS pool, but I want to give them
> some attributes I can query for, this should be possible with the omap
> functionality, shouldn't it?
What do you mean, query for? You can look at an object and ask if it
has "foo=bar" in its omap, but you can't say "give me all objects with
'foo=bar'".


> Do to this I want to use phprados, but that is using the C-functions, so
> that's why I'm asking.
>
> Has this been forgotten or is there something blocking it?
It'll probably be inconvenient as always due to memory management, but
it's not blocked by anything that I'm aware of.
-Greg
