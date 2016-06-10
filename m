From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: A Transformation of our Global Context
Date: Fri, 10 Jun 2016 12:47:10 -0700
Message-ID: <CAJ4mKGatR70eFdKx4_RhPT3rHOp+pTz6VZBWy_mpAiK8j-TpMg@mail.gmail.com>
References: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36596 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbcFJTrM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jun 2016 15:47:12 -0400
Received: by mail-vk0-f44.google.com with SMTP id u64so8990vkf.3
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jun 2016 12:47:11 -0700 (PDT)
In-Reply-To: <20160610185033.GA29233@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, Jun 10, 2016 at 11:50 AM, Adam C. Emerson <aemerson@redhat.com>=
 wrote:
> Terriffically Tentacular Teammates,
>
> I come not with a multilateral trade deal, but with a request for
> comments.
>
> In our code base we have CephContext. In daemons and official Ceph
> Utilities, we have g_ceph_context. I believe CephContext does not sho=
w
> proper separation of concerns.
>
> Some of its contents (debugging flags, file locations, and the log
> levels used by the dout, initialized cryptographic subsystems, the
> admin socket, and others) are relevant to the process as a whole.
>
> Others (such as the monitor address, fsid, cluster and public network=
,
> CrushLocation, and so forth) are relevant to the cluster.
>
> I would like to split CephContext between its process-relevant subset
> and its cluster-relevant subset and move the process-relevant portion
> into a global variable in libcommon. Cluster-relevant parts would be
> plumbed into subsystems the way CephContext is now.
>
> The improved separation of concerns would make it easier to write
> utilities that connect to multiple clusters, which sounds like it wil=
l
> be increasingly important with the work people have done on
> replication and the notion of 'pop-up' Ceph clusters for specific
> workloads.

Maybe I'm misunderstanding the scope of what you're proposing, but I
don't think this is a good reason to go through this work right now.
Lots of things that seem process-specific turn out to be essentially
cluster properties, despite being configurable on both ends, and will
need to be referenced from all over the stack. And in general if we're
addressing multiple Ceph clusters within a utility we want a full
RadosClient etc for each cluster, so the split doesn't do us much good
on its own, does it? (If we don't want separate admin sockets for each
one, we'd need to extend all of those interfaces to support two
entries for the same type of thing, etc)

> It would also make the code more modular and reusable. Several pieces
> that could be reasonably made into libraries (such as the MDS or OSD)
> or incorporated into non-daemon code (like the erasure code system)
> can't be now. They could be re-plumbed, but having to thread a
> CephContext around just to log messages is unappealing.

If this is your actual goal, I think the unappealing work of replacing
g_ceph_context with a CephContext *cct is the way to go =E2=80=94 we'd =
need to
do this much to support multiple ClusterContexts within a process
anyway. Once we have a motivating use case for splitting stuff up, we
can address that. But if we try and do a generic solution it'll be
much more difficult, and probably will miss some key points we don't
run into until trying to make use of it.

Am I missing something?
-Greg

>
> It would also be cleaner not having to plumb a CephContext in to ever=
y
> point in libcommon that checks the time or prints to the log.
>
> If I were to do this, my plan would be:
>
> 1. Separate configuration variables into process and cluster
> 2. Create a global 'ProcessContext' class. Move some elements of
>    CephContext into it and the process-relevant configuration
>    options. Have the configuration parser write to both locations, an=
d
>    have CephContext carry references to alias the relevant members of
>    the global.
> 3. Create a ClusterContext (perhaps as a base to CephContext holding
>    all non-aliased members).
> 4. Subsystem by subsystem remove uses of CephContext, replacing some
>    with ClusterContext.
> 5. When all uses of CephContext are removed, remove the class.
>
> Does this seem reasonable?
>
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@{RedHat, OFTC, Freenode}
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
