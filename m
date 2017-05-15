From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: Monitoring ceph and prometheus
Date: Mon, 15 May 2017 08:44:49 +0200
Message-ID: <20170515064449.hsbl7l6zzkuwowq2@suse.com>
References: <20170511115211.isjqn6y3x2tuqxbo@jf_suse_laptop>
 <CALe9h7ed4aUDYEJKfH8qSoVmiPB8+F+g7+ffzrwE08sdX7RHSQ@mail.gmail.com>
 <alpine.DEB.2.11.1705111246400.18953@piezo.novalocal>
 <20170513101414.wisczvozh6kilps7@suse.com>
 <CALe9h7fhson-vgFpbUoi+x+nSiqZRw72qmKKEMgrT-KQtWy93g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:51418 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759432AbdEOGo6 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Mon, 15 May 2017 02:44:58 -0400
Content-Disposition: inline
In-Reply-To: <CALe9h7fhson-vgFpbUoi+x+nSiqZRw72qmKKEMgrT-KQtWy93g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2017-05-14T23:27:03, John Spray <jspray@redhat.com> wrote:

> a problem.  We're talking about pretty small messages here, doing
> nothing but updating some counters in memory, and it's a lot less work
> than the OSDs already do.

True, but sending (or exposing) them to ceph-mgr only for ceph-mgr to
pass them on on-demand to Prometheus just still strikes me as a
redundant hop.

> Simplicity.  It makes it super simple for a user with nothing but
> vanilla Ceph and vanilla Prometheus to connect the two things
> together.  Anything that requires lots of per-daemon configuration
> relies on some addition orchestration tool to do that plumbing.

Prometheus doesn't usually require per-daemon configuration; it has all
the hooks to deal with dynamically update the list of daemons to
monitor.
https://github.com/prometheus/docs/blob/master/content/docs/operating/configuration.md

Ok, so maybe we don't want to use consul/marathon/k8s/serversets.
(Surprised not to see etcd, actually ;-)

But Ceph *does* have a service that tells a client about all
OSDs/MDSs/MONs/... instances, don't we? All the maps. This might better
be solved by a ceph_sd_configs section to point it at a Ceph cluster
with a single stanza?

So, OK, ceph-mgr could additionally keep track of radosgw or nfs-ganesha
instances, possibly more - and possibly strip out the parts of the maps
Prometheus doesn't need to know about. And possibly provide an API that
doesn't require CephX.

So, perhaps exposing this - the dynamic service/target discovery via
ceph-mgr to Prometheus, and then having Prometheus pull directly - is a
synthesis of both positions?

> In conversations about this topic (centralized vs. per-daemon stats),
> we usually come to the conclusion that both are useful: the simple
> "batteries included" configuration where we present a single endpoint,
> vs. the configuration where some external program is aware of all
> individual daemons and monitoring them directly.  If we end up with
> both, that's not an awful thing.

Perhaps the above is the one that can converge both positions into
one?


Regards,
    Lars

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

