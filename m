From: Milosz Tanski <milosz@adfin.com>
Subject: Re: C++11
Date: Mon, 29 Sep 2014 11:44:10 -0400
Message-ID: <CANP1eJE4RqGBFon84a8QcE7-FO2xW8zE803Fww2XnhRgP5gw_w@mail.gmail.com>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
	<1411994072-18850-1-git-send-email-j@jannau.net>
	<CANP1eJGxY8wR4smOfZ49+1dwjWCU7FrdbOG4UvMJR7UP77UX4g@mail.gmail.com>
	<alpine.DEB.2.00.1409290821220.14393@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:64037 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbaI2PoN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 11:44:13 -0400
Received: by mail-oi0-f43.google.com with SMTP id x69so1907718oia.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Sep 2014 08:44:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409290821220.14393@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Janne Grunau <j@jannau.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Sep 29, 2014 at 11:24 AM, Sage Weil <sweil@redhat.com> wrote:
> On Mon, 29 Sep 2014, Milosz Tanski wrote:
>> A second more general Ceph question is somewhat off-topic. What about
>> C++11 use in the Ceph code base (like in this case)? It's not
>> explicitly prohibited by the coding style document, but I imagine the
>> goal is to build on as many systems as possible and quite a few
>> supported distros have pretty old versions of GCC. I'm asking this
>> because I imagine some of the performance work that's about to happen
>> will want to use things like lockless queues, and then you get into
>> C++11 memory model and std::atomic... etc.
>
> We are all very eager to move to C++11.  The challenge is that we still
> need to build packages for the target distros.  That doesn't necessarily
> mean that the compilers on those distros need to support c++11 as long as
> the runtime does... if we can make the build enviroment sane.
>
> I'm really curious what other projects do here...
>
> sage

I know that Ubuntu (12.04) and RHEL (6) provide updated compilers. I
think you can get 4.8.x in ubuntu and 4.7 in RHEL6. One problem you're
going to into is that the system (eg. old) version boost will be build
whatever is the default compiler (4.6 for ubuntu, 4.4 for RHEL6)
without C++11 features. Your new runtime vector becomes very large.

-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
