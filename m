From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: omap functions in librados.h
Date: Fri, 17 Aug 2012 13:10:36 -0700
Message-ID: <502EA53C.7090707@inktank.com>
References: <502E9D44.6010006@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48171 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755665Ab2HQUKl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 16:10:41 -0400
Received: by pbbrr13 with SMTP id rr13so3823359pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Aug 2012 13:10:40 -0700 (PDT)
In-Reply-To: <502E9D44.6010006@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/17/2012 12:36 PM, Wido den Hollander wrote:
> Hi,
>
> I'm looking for the omap functions in librados.h, but they only seem to
> be implemented in librados.hpp?
>
> I want to store about 6000 objects in a RADOS pool, but I want to give
> them some attributes I can query for, this should be possible with the
> omap functionality, shouldn't it?
>
> Do to this I want to use phprados, but that is using the C-functions, so
> that's why I'm asking.
>
> Has this been forgotten or is there something blocking it?
>
> Wido

The librados C++ api's ObjectOperation methods aren't implemented in
the C api yet. There's no reason not to add them, it's just that
no one's gotten to it yet. I can help if you're interested in
implementing them, although I'll be away from email next week.

Josh
