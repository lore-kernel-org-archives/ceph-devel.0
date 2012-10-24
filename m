From: Alex Elder <elder@inktank.com>
Subject: Re: getting kernel debug output
Date: Wed, 24 Oct 2012 13:14:49 -0500
Message-ID: <50883019.5040506@inktank.com>
References: <alpine.DEB.2.00.1210241007500.31573@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48844 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161061Ab2JXSOw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 14:14:52 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so1094758iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Oct 2012 11:14:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210241007500.31573@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/24/2012 12:11 PM, Sage Weil wrote:
> I'm working on http://tracker.newdream.net/issues/3342 and was able to 
> reproduce the msgr bug (some annoying msgr race I think) while generating 
> full libceph debug output.  I used a teuthology yaml fragment like so:

I have more trouble than that, but perhaps there's something
weird about having my serial console connected from 1500 miles
away.  I'm impressed full debugging didn't mess things up.

> tasks:
> - clock: null
> - ceph:
>     log-whitelist:
>     - wrongly marked me down
>     - objects unfound and apparently lost
> - thrashosds: null
> - kclient: null
> - exec:
>     client.0:
>       - echo 'module libceph +p' > /sys/kernel/debug/dynamic_debug/control

This is cool, I didn't know you could do this.

> - workunit:
>     clients:
>       all:
>       - suites/ffsb.sh
> 
> I was pleasantly surprised that even though this is putting copious 
> amounts of crap in dmesg it didn't slow things down enough to avoid 
> tripping the bug.  And the 'dmesg' command in kdb appears to be working 
> now (a couple months back it wasn't).  Yay!

For me, dmesg has been working, but I'd like to know how to
truncate the output to just, say, the last 200 lines.  (Maybe
there is one.)

> Anyway, this might be useful in tracking down other bugs as well...

Yes, this is good news.

					-Alex
