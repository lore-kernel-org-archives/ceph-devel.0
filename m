From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] libcephfs: return error when not mounted
Date: Mon, 14 May 2012 10:39:15 -0700
Message-ID: <6DA7B347-76E2-4D6D-9ABA-42BF973F8AAC@cs.ucsc.edu>
References: <6E886DEA-B266-4677-8206-C817595BBA86@cs.ucsc.edu> <CADvuQRENXm=5O+uZ8-UwGidSgbn3KvV212sPkUam9uzOyLrvMg@mail.gmail.com> <FC7D87FB-20FE-400E-959D-7C3FC558A89B@cs.ucsc.edu> <Pine.LNX.4.64.1205141034001.20330@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:60524 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604Ab2ENRjQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 13:39:16 -0400
In-Reply-To: <Pine.LNX.4.64.1205141034001.20330@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Tommi Virtanen <tv@inktank.com>, ceph-devel@vger.kernel.org, Greg Farnum <gregory.farnum@dreamhost.com>


On May 14, 2012, at 10:34 AM, Sage Weil wrote:

> On Mon, 14 May 2012, Noah Watkins wrote:
>> On May 14, 2012, at 10:03 AM, Tommi Virtanen wrote:
>>> On Fri, May 11, 2012 at 6:21 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>>>> Return an error rather than a segfault if a client uses the interface
>>>> when unmounted. The Java bindings were explicitly enforcing the
>>>> mounted state, but this was overly complicated, uncommon, and better
>>>> handled with a simple exception that can be checked at libcephfs level.
>>> ...
>>>> +  if (!cmount->is_mounted())
>>>> +    return -EDOM;
>>> 
>>> Noah, this is not really about your patch, as existing code already
>>> has return -EDOM, but... oh boy does the API abuse POSIX errors.
>>> 
>>> "Numerical argument out of domain".
>> 
>> :)  Yeh, i stared at errno.h for a while. Note that -EDOM is already 
>> returned by mount() when it is already mounted.
> 
> Given the small number of libcephfs users, let's not be afraid to change 
> it to something better.

-ENOTCONN replace -EDOM for this patch
-EISCONN  replace -EDOM for mount() when already mounted?

- Noah