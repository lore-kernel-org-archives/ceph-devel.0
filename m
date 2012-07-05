From: Gregory Farnum <greg@inktank.com>
Subject: Re: cephfs show_location produces kernel "divide error: 0000 [#1]"
 when run against a directory that is not the filesystem root
Date: Thu, 5 Jul 2012 13:29:36 -0700
Message-ID: <CAPYLRzhqvcuYBaV24dT0QdctvBAgJwC8GsajWt8UK85S9XNtTQ@mail.gmail.com>
References: <CAPUexz9+L+nrJCNh0gK0RGd8H5kk8ZGHZ+7WU4mP3mq5UHXLDQ@mail.gmail.com>
	<CAPYLRzgWiLDEv8=26hHrixe_dMmAbmHHt3XKBftA7wjjmXp_xQ@mail.gmail.com>
	<CAPUexz-sNhO_A62S4FiFYt0+7bHsT9zKaktVPxm-bL0n_CpkzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50912 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab2GEU3i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 16:29:38 -0400
Received: by lbbgm6 with SMTP id gm6so13431587lbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 13:29:36 -0700 (PDT)
In-Reply-To: <CAPUexz-sNhO_A62S4FiFYt0+7bHsT9zKaktVPxm-bL0n_CpkzQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org, Alex Elder <elder@inktank.com>

On Thu, Jul 5, 2012 at 1:19 PM, Florian Haas <florian@hastexo.com> wrote:
> On Thu, Jul 5, 2012 at 10:04 PM, Gregory Farnum <greg@inktank.com> wrote:
>> But I have a few more queries while this is fresh. If you create a
>> directory, unmount and remount, and get the location, does that work?
>
> Nope, same error.
>
>> (actually, just flushing caches would probably do it.)
>
> Idem.
>
>> If you create a
>> directory on one node, and then go look at it on another node and try
>> to get the location from there, does that work?
>
> No.
>
> Cheers,
> Florian

Okay, this used to work at least some, so something definitely got
broken in the kernel. :/ Thanks for checking...
-Greg
