From: Marcus Sorensen <shadowsor@gmail.com>
Subject: Re: architecture questions - OSD layout
Date: Thu, 21 Jul 2011 17:06:29 -0600
Message-ID: <CALFpzo4-Sskzd=ht+AoTMBT4tvjD_tHdoQtVvF6feCpsT7NK+g@mail.gmail.com>
References: <CALFpzo74hRFUis0-P+ekPuC5eqa1AbM4aEimB+zO=cU-mgpjsw@mail.gmail.com>
	<CA+qbEUNrARNq8PLigcx0H7dQYrSAtgQ_ND4W2sSS1A7KVuoQzA@mail.gmail.com>
	<CAF3hT9DjNB9FM9tXUqg_Qszn+8fFOOL1zcbz20jcm1EdcydEhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61745 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab1GUXGa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2011 19:06:30 -0400
Received: by wyg8 with SMTP id 8so1160973wyg.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2011 16:06:29 -0700 (PDT)
In-Reply-To: <CAF3hT9DjNB9FM9tXUqg_Qszn+8fFOOL1zcbz20jcm1EdcydEhA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Thanks for the input guys.  I think I will end up going with some sort
of RAID groups, simply because if we decide in the future to use it
and scale to say 4000 or so drives like our current system, I don't
want two drive failures out of 4000 to cause downtime or an i/o error
on clients, something like that. At the moment we can often have 3 or
4 drives out or rebuilding at the same time across those 4k.

The flapping thing is also good to know, we'll probably have the OSD
hardware as quad core, 8 thread with 16 or 32 GB ram. So we'll maybe
do 16-20 cosd processes among ~200 drives.

Still, I'll try a few configs and see what I get. I'd be happy to post
the info I gather if anyone is interested, and of course submit
problems to the proper channels. Right now I'm having a few systems
built and we'll start testing with 84 drives.

On Thu, Jul 21, 2011 at 10:34 AM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Thu, Jul 21, 2011 at 9:25 AM, Colin Patrick McCabe
> <colin.mccabe@dreamhost.com> wrote:
>> On the other hand, there is some fixed overhead to having multiple
>> cosd processes running. RAIDing a few disks might be a good option if
>> the fixed overhead of having a cosd per disk is too much.
> This in particular is important. In general the cosd processes won't
> use much CPU or memory, but in some situations (like recovery) they
> can spike in a correlated fashion that ends up causing OSD flapping.
> These behavior characteristics aren't well-modeled yet simply because
> there's bug fixing still going on in those code paths (and some
> optimization), but it's something to be aware of. I think you want
> something like 1GHz of a modern core per cosd to handle this, even
> though a stable system will often do just fine running 4 cosds on an
> Atom. (Presumably we can bring these requirements down once we move on
> from stabilization to performance.)
> -Greg
>
