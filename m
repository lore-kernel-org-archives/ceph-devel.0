From: Sage Weil <sage@newdream.net>
Subject: Re: crush multipick anomaly
Date: Tue, 7 Mar 2017 23:06:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703072259520.24356@piezo.novalocal>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal> <3554101b-4d10-e46b-93b0-f74794258f2e@dachary.org> <alpine.DEB.2.11.1702131417070.7782@piezo.novalocal> <CAFdhnje5hJMsU8ZCSL8mFj=d4UH6b41=nnddNvcfemhyWXg6aw@mail.gmail.com>
 <4dbab28a-220b-2cef-fcbc-aca4dd17ab3b@dachary.org> <CAFdhnjf=WPmC+CEwX1QWe_v1HXmZu2cv7983zHGG4muKR_G0jw@mail.gmail.com> <43736207-9e38-9389-4b99-d246716092ed@dachary.org> <CAFdhnjfGKdmOFnT-imHo55O7LLPCdOV=_pbU50ruxo1x9C3NDA@mail.gmail.com>
 <cbcf592e-a0c0-bc5b-0f2a-11c4a110d485@dachary.org> <CAFdhnjcDfUG6Dzm2R_Fu16d7rT1z_h+mFy6ngYLUcLtURn_pVA@mail.gmail.com> <63256e6b-ec48-e369-afc3-6d65eb5230f8@dachary.org> <eca40695-44b3-6843-b1c3-8359231e4d87@dachary.org>
 <CAFdhnjfYK43=ZdQ-cPG0k8KzKnTZ=T5VNoYdfdSdPH8gRG_i+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-220185021-1488928012=:24356"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45438 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756561AbdCHABx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Mar 2017 19:01:53 -0500
In-Reply-To: <CAFdhnjfYK43=ZdQ-cPG0k8KzKnTZ=T5VNoYdfdSdPH8gRG_i+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Pedro_L=F3pez-Adeva?= <plopezadeva@gmail.com>
Cc: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-220185021-1488928012=:24356
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Pedro,

Thanks for taking a look at this!  It's a frustrating problem and we 
haven't made much headway.

On Thu, 2 Mar 2017, Pedro López-Adeva wrote:
> Hi,
> 
> I will have a look. BTW, I have not progressed that much but I have
> been thinking about it. In order to adapt the previous algorithm in
> the python notebook I need to substitute the iteration over all
> possible devices permutations to iteration over all the possible
> selections that crush would make. That is the main thing I need to
> work on.
> 
> The other thing is of course that weights change for each replica.
> That is, they cannot be really fixed in the crush map. So the
> algorithm inside libcrush, not only the weights in the map, need to be
> changed. The weights in the crush map should reflect then, maybe, the
> desired usage frequencies. Or maybe each replica should have their own
> crush map, but then the information about the previous selection
> should be passed to the next replica placement run so it avoids
> selecting the same one again.

My suspicion is that the best solution here (whatever that means!) 
leaves the CRUSH weights intact with the desired distribution, and 
then generates a set of derivative weights--probably one set for each 
round/replica/rank.

One nice property of this is that once the support is added to encode 
multiple sets of weights, the algorithm used to generate them is free to 
change and evolve independently.  (In most cases any change is 
CRUSH's mapping behavior is difficult to roll out because all 
parties participating in the cluster have to support any new behavior 
before it is enabled or used.)

> I have a question also. Is there any significant difference between
> the device selection algorithm description in the paper and its final
> implementation?

The main difference is the "retry_bucket" behavior was found to be a bad 
idea; any collision or failed()/overload() case triggers the 
retry_descent.

There are other changes, of course, but I don't think they'll impact any 
solution we come with here (or at least any solution can be suitably 
adapted)!

sage
--8323329-220185021-1488928012=:24356--
