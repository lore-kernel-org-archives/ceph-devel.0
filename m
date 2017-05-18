From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: Monitoring ceph and prometheus
Date: Thu, 18 May 2017 10:37:16 +0200
Message-ID: <20170518083716.s4kv4d5gus7e2trb@suse.com>
References: <20170511115211.isjqn6y3x2tuqxbo@jf_suse_laptop>
 <CALe9h7ed4aUDYEJKfH8qSoVmiPB8+F+g7+ffzrwE08sdX7RHSQ@mail.gmail.com>
 <alpine.DEB.2.11.1705111246400.18953@piezo.novalocal>
 <20170513101414.wisczvozh6kilps7@suse.com>
 <CALe9h7fhson-vgFpbUoi+x+nSiqZRw72qmKKEMgrT-KQtWy93g@mail.gmail.com>
 <20170515064449.hsbl7l6zzkuwowq2@suse.com>
 <CALe9h7c9vdgKc3rSG853Lmbr=oan73Y32jxc+-1gWfniRV_iaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:56360 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753606AbdERIha (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 18 May 2017 04:37:30 -0400
Content-Disposition: inline
In-Reply-To: <CALe9h7c9vdgKc3rSG853Lmbr=oan73Y32jxc+-1gWfniRV_iaw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2017-05-15T13:33:29, John Spray <jspray@redhat.com> wrote:

> At the risk of being a bit picky, it's only redundant if prometheus is
> the only thing consuming them.  If the user is also using some mgr
> modules (including things like handy CLI views) that consume the
> stats, it's not redundant at all.  I'd like to keep these stats around
> in the mgr because we're not quite sure yet what kinds of modules
> we'll end up with.

Fair enough. The point that they may wish to gather information at
different frequencies still remains though - a ceph-mgr module may do it
on-demand for certain tasks, event driven, or periodically, prometheus
(or other trending) would want to poll certain counters at various
frequencies, etc.

(e.g., maybe the OSD ones every 10s, SMART every 3h, whatever)

Aligning these would be annoying, and it seems to me that it makes more
sense to allow them to poll independently from the same interfaces.

> Sage's recent change to add the importance thresholds to perf counters
> could be interesting here: we might end up sending everything that's
> "reasonably important" and higher to the mgr for exposing in CLI tools
> etc (I'm thinking of things like the OSD throughput, the MDS number of
> each op per second, etc), while perhaps the really obscure stuff would
> only get collected (into prometheus?) if someone actively chose that.

That's actually somewhat related to how smart classifies. Value,
threshold, type (old-age, pre-fail, we could add a "perf" one).

I take the point - there's also a need for an event-driven channel that
needs to be push by default. (From simple operation completion
notification to "OMFG the disk caught fire.")

I could see those going to ceph-mgr for handling/relaying.

> > So, perhaps exposing this - the dynamic service/target discovery via
> > ceph-mgr to Prometheus, and then having Prometheus pull directly - is a
> > synthesis of both positions?
> It would certainly be ++good build in the service discovery so that
> the user only needs to point prometheus at one place to discover
> everything.  Anything that avoids the need for extra external tools to
> set things up makes me happy.

Yes, I think that'd be great to have. And at least in my head the idea
of where information goes becomes clearer.

Notifications/events go to and through ceph-mgr. ceph-mgr keeps track of
Ceph services. Trending/metrics should IMNSHO be polled directly as
needed.


Regards,
    Lars

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

