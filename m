From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] libcephfs: return error when not mounted
Date: Mon, 14 May 2012 10:08:19 -0700
Message-ID: <FC7D87FB-20FE-400E-959D-7C3FC558A89B@cs.ucsc.edu>
References: <6E886DEA-B266-4677-8206-C817595BBA86@cs.ucsc.edu> <CADvuQRENXm=5O+uZ8-UwGidSgbn3KvV212sPkUam9uzOyLrvMg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:51355 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405Ab2ENRI1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 13:08:27 -0400
In-Reply-To: <CADvuQRENXm=5O+uZ8-UwGidSgbn3KvV212sPkUam9uzOyLrvMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org, Greg Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>


On May 14, 2012, at 10:03 AM, Tommi Virtanen wrote:

> On Fri, May 11, 2012 at 6:21 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> Return an error rather than a segfault if a client uses the interface
>> when unmounted. The Java bindings were explicitly enforcing the
>> mounted state, but this was overly complicated, uncommon, and better
>> handled with a simple exception that can be checked at libcephfs level.
> ...
>> +  if (!cmount->is_mounted())
>> +    return -EDOM;
> 
> Noah, this is not really about your patch, as existing code already
> has return -EDOM, but... oh boy does the API abuse POSIX errors.
> 
> "Numerical argument out of domain".

:)   Yeh, i stared at errno.h for a while. Note that -EDOM is already returned by mount() when it is already mounted.

-Noah

