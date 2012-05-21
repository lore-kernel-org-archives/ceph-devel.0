From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: Release/branch naming; input requested
Date: Mon, 21 May 2012 12:50:21 -0700
Message-ID: <4FBA9C7D.4020400@inktank.com>
References: <CAORUGqBxO=n_7xkDEFr_gi=y=+7abo0mErYSDOwVTq+zaA_cTw@mail.gmail.com> <CAC-hyiFdGudQSfby7QkJZRBhGDBQeWGiA7LwtFWhmevUMa_2bw@mail.gmail.com> <Pine.LNX.4.64.1205180918190.8006@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53811 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170Ab2EUTuZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 15:50:25 -0400
Received: by dady13 with SMTP id y13so7233903dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 12:50:24 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1205180918190.8006@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 05/18/12 09:32, Sage Weil wrote:

> I think we can limit the relative branches to:
>
>   master = integration, unstable, tip, bleeding edge (same as now)
>   [next] = next upcoming release (same as now)
>   current = most recent release
>   stable = most recent stable release

We have already signed one contract that obligates us
to years of support, and once customers go into production
they will be loathe to move to each new stable release as
it comes out.  Thus, I fear that we will be maintaining
multiple stable releases ... but once a stable release ceases
to be the newest, the bar on what has to be back-ported to
it can be significantly raised, lowering the cost.

> I like Yehuda's suggestion of cephalopods, or other interesting sea
> creatures.  As he points out, though,
>
>    http://www.thecephalopodpage.org/taxa.php
>
> suggests that there may not be enough good choices that are strictly
> cephalopods, though.  Although it might be ok?
> ...

I don't have an opinion about themes, but I do suggest that they
should be memorable and easily pronounced ... and taxonomic
family names do not always have those characteristics.

>>> 3. What do we do with version numbers? With a 2-3 week iteration,
>>> we'll end up with something like 0.41.x, 0.56.x for Folsom integration
>>> (less than a year from now), and 0.57, 0.58 etc for "latest".
>>
>> We can keep those, they are completely orthogonal. These are exactly
>> what they are: dev cycle numbers. I'm not too afraid of big numbers
>> there, as they become uninteresting once you have the other naming
>> scheme. They have the nice property of monotonically increasing which
>> is useful internally.

Given that most releases will only get a subset of what is in builds,
I too think that builds should be orthogonal to releases.

