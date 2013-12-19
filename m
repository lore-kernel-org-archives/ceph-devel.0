From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: mds: fix Resetter locking
Date: Thu, 19 Dec 2013 21:31:15 +0800
Message-ID: <CAAM7YAmW5UR2eiE5ytEGtX9=EwJW1fLcUSTF6-2bYA5tzk7dgQ@mail.gmail.com>
References: <ord2kt71bg.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:48371 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab3LSNbR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Dec 2013 08:31:17 -0500
Received: by mail-lb0-f177.google.com with SMTP id q8so445149lbi.8
        for <ceph-devel@vger.kernel.org>; Thu, 19 Dec 2013 05:31:16 -0800 (PST)
In-Reply-To: <ord2kt71bg.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Dec 19, 2013 at 3:21 PM, Alexandre Oliva <oliva@gnu.org> wrote:
> For some weird reason I couldn't figure out, after I simultaneously
> brought down all components of my ceph cluster and then brought them
> back up, the mds wouldn't come back, complaining about a zero-sized
> entry in its journal some 8+MB behind the end of the journal.  I hadn't
> ever got this problem, and it's not entirely unusual for me to restart
> all cluster components at once after some configuration change.
>

I suspect it was caused by bug http://tracker.ceph.com/issues/6458.
did you use active + standby mds step ? how quickly did you bring down
the osd and mds?

Regards
Yan, Zheng


> Anyway...  Long story short, after some poking at the mds journal to see
> if I could figure out how to get it back up, I gave up and decided to
> use the --reset-journal hammer.  Except that it just sat there, never
> completing or even getting noticed by the cluster.  After a bit of
> additional investigation, the following patch was born, and now my
> Emperor cluster is back up.  Phew! :-)
>
>
>
> --
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist      Red Hat Brazil Compiler Engineer
>
