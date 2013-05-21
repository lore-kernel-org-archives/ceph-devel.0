From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: [ceph-users] mon IO usage
Date: Tue, 21 May 2013 18:05:35 +0200
Message-ID: <CAF6-1L4C1QQHZ_5=3OCATFTCD_As63HEjJLcKsGURAV02PFQPQ@mail.gmail.com>
References: <CAF6-1L4oWCwNxywALb=cUNP_pbD=ND631MJqvCWyvAfvNdWauQ@mail.gmail.com>
	<519B6F28.9000400@scholarstack.com>
	<519B75B2.4070405@scholarstack.com>
	<CAF6-1L4NHhtaaGGB4vBwWWqEa0pVR4T44-Xx_eTmkUEEXHsfgA@mail.gmail.com>
	<alpine.DEB.2.00.1305210854320.16413@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:33922 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab3EUQFh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 12:05:37 -0400
Received: by mail-bk0-f53.google.com with SMTP id mx1so512961bkb.26
        for <ceph-devel@vger.kernel.org>; Tue, 21 May 2013 09:05:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1305210854320.16413@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mike Dawson <mike.dawson@scholarstack.com>, ceph-users@lists.ceph.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

>> So, AFAICT, the bulk of the write would be writing out the pgmap to
>> disk every second or so.
>
> It should be writing out the full map only every N commits... see 'paxos
> stash full interval', which defaults to 25.

But doesn't it also write it in full when there is a new pgmap ?

I have a new one about every second and its size * period seemed to
match the IO rate pretty well which it why I thought it was the reason
for the IO.


>> Is it really needed to write it in full ? It doesn't change all that
>> much AFAICT, so writing incremental changes with only periodic flush
>> might be a better option ?
>
> Right.  It works this way now only because we haven't fully transitioned
> from the old scheme.  The next step is to store the PGMap over lots of
> leveldb keys (one per pg) so that there is no big encode/decode of the
> entire PGMap structure...

Makes sense. I'm not sure of the "per-key" overhead of leveldb though,
in case where there are lots ( > 10k ) PGs.


Cheers,

    Sylvain
