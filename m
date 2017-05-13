From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: Monitoring ceph and prometheus
Date: Sat, 13 May 2017 12:14:14 +0200
Message-ID: <20170513101414.wisczvozh6kilps7@suse.com>
References: <20170511115211.isjqn6y3x2tuqxbo@jf_suse_laptop>
 <CALe9h7ed4aUDYEJKfH8qSoVmiPB8+F+g7+ffzrwE08sdX7RHSQ@mail.gmail.com>
 <alpine.DEB.2.11.1705111246400.18953@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:50728 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdEMKOY (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Sat, 13 May 2017 06:14:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1705111246400.18953@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2017-05-11T12:47:21, Sage Weil <sage@newdream.net> wrote:

> > I would love to see a mgr module for prometheus integration!
> Me too!  It might make more sense to do it in C++ than python, though, for 
> performance reasons.

I'm leaning the other way. (Disclaimer: I started this dialogue
internally and was originally thinking of putting it into ceph-mgr.)

prometheus implements a pull model for time series data / metrics. For
those to be pull-able from ceph-mgr, either ceph-mgr needs to pull
itself, or daemons stream to it. Clearly it can't pull something that's
not there.

Both have slightly different issues with aligning the periods/intervals.

Prometheus also can scale through polling via several instances; if we
pull everything from ceph-mgr, that is a single chokepoint.

Further, if ceph-mgr were to pull data from individual daemons - why not
have prometheus do this directly? What benefit does this additional
indirection step offer?

If we have rather detailed stats per daemon, ceph-mgr would either relay
them on as-is (pure overhead), or aggregate them - and likely not
aggregate them as well/flexibly as Prometheus would allow via PQL.

Now, that's not to say that ceph-mgr would not benefit from a Prometheus
interface! I could easily see ceph-mgr have stats of its own that are
worth monitoring, and we should make it easy to export those.

So, in short, I believe an easy way to export per-daemon metrics is
desirable. ceph-mgr might choose to pull these in as well if it has a
use for them, but I think Prometheus would best attach to the daemons
directly too.


Regards,
    Lars

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

