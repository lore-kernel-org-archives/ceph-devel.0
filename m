From: John Spray <jspray@redhat.com>
Subject: Re: Monitoring ceph and prometheus
Date: Mon, 15 May 2017 13:33:29 +0100
Message-ID: <CALe9h7c9vdgKc3rSG853Lmbr=oan73Y32jxc+-1gWfniRV_iaw@mail.gmail.com>
References: <20170511115211.isjqn6y3x2tuqxbo@jf_suse_laptop>
 <CALe9h7ed4aUDYEJKfH8qSoVmiPB8+F+g7+ffzrwE08sdX7RHSQ@mail.gmail.com>
 <alpine.DEB.2.11.1705111246400.18953@piezo.novalocal> <20170513101414.wisczvozh6kilps7@suse.com>
 <CALe9h7fhson-vgFpbUoi+x+nSiqZRw72qmKKEMgrT-KQtWy93g@mail.gmail.com> <20170515064449.hsbl7l6zzkuwowq2@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38882 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755630AbdEOMdv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 May 2017 08:33:51 -0400
Received: by mail-wm0-f43.google.com with SMTP id v15so45151140wmv.1
        for <ceph-devel@vger.kernel.org>; Mon, 15 May 2017 05:33:51 -0700 (PDT)
In-Reply-To: <20170515064449.hsbl7l6zzkuwowq2@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, May 15, 2017 at 7:44 AM, Lars Marowsky-Bree <lmb@suse.com> wrote:
> On 2017-05-14T23:27:03, John Spray <jspray@redhat.com> wrote:
>
>> a problem.  We're talking about pretty small messages here, doing
>> nothing but updating some counters in memory, and it's a lot less work
>> than the OSDs already do.
>
> True, but sending (or exposing) them to ceph-mgr only for ceph-mgr to
> pass them on on-demand to Prometheus just still strikes me as a
> redundant hop.

At the risk of being a bit picky, it's only redundant if prometheus is
the only thing consuming them.  If the user is also using some mgr
modules (including things like handy CLI views) that consume the
stats, it's not redundant at all.  I'd like to keep these stats around
in the mgr because we're not quite sure yet what kinds of modules
we'll end up with.

Sage's recent change to add the importance thresholds to perf counters
could be interesting here: we might end up sending everything that's
"reasonably important" and higher to the mgr for exposing in CLI tools
etc (I'm thinking of things like the OSD throughput, the MDS number of
each op per second, etc), while perhaps the really obscure stuff would
only get collected (into prometheus?) if someone actively chose that.

>> Simplicity.  It makes it super simple for a user with nothing but
>> vanilla Ceph and vanilla Prometheus to connect the two things
>> together.  Anything that requires lots of per-daemon configuration
>> relies on some addition orchestration tool to do that plumbing.
>
> Prometheus doesn't usually require per-daemon configuration; it has all
> the hooks to deal with dynamically update the list of daemons to
> monitor.
> https://github.com/prometheus/docs/blob/master/content/docs/operating/configuration.md
>
> Ok, so maybe we don't want to use consul/marathon/k8s/serversets.
> (Surprised not to see etcd, actually ;-)
>
> But Ceph *does* have a service that tells a client about all
> OSDs/MDSs/MONs/... instances, don't we? All the maps. This might better
> be solved by a ceph_sd_configs section to point it at a Ceph cluster
> with a single stanza?
>
> So, OK, ceph-mgr could additionally keep track of radosgw or nfs-ganesha
> instances, possibly more - and possibly strip out the parts of the maps
> Prometheus doesn't need to know about. And possibly provide an API that
> doesn't require CephX.
>
> So, perhaps exposing this - the dynamic service/target discovery via
> ceph-mgr to Prometheus, and then having Prometheus pull directly - is a
> synthesis of both positions?

It would certainly be ++good build in the service discovery so that
the user only needs to point prometheus at one place to discover
everything.  Anything that avoids the need for extra external tools to
set things up makes me happy.

John

>
>> In conversations about this topic (centralized vs. per-daemon stats),
>> we usually come to the conclusion that both are useful: the simple
>> "batteries included" configuration where we present a single endpoint,
>> vs. the configuration where some external program is aware of all
>> individual daemons and monitoring them directly.  If we end up with
>> both, that's not an awful thing.
>
> Perhaps the above is the one that can converge both positions into
> one?
>
>
> Regards,
>     Lars
>
> --
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> "Experience is the name everyone gives to their mistakes." -- Oscar Wilde
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
