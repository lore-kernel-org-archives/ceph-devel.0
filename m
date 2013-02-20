From: Gregory Farnum <greg@inktank.com>
Subject: Re: enable old OSD snapshot to re-join a cluster
Date: Wed, 20 Feb 2013 10:52:30 -0800
Message-ID: <CAPYLRzjG3ws-TJt+XOv0vp-oRuOZti+b1yjBZw_shhmdQE9F4g@mail.gmail.com>
References: <orr4kbgbn3.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:44211 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008Ab3BTSwb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Feb 2013 13:52:31 -0500
Received: by mail-qa0-f50.google.com with SMTP id dx4so2587944qab.9
        for <ceph-devel@vger.kernel.org>; Wed, 20 Feb 2013 10:52:30 -0800 (PST)
In-Reply-To: <orr4kbgbn3.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Feb 19, 2013 at 2:52 PM, Alexandre Oliva <oliva@gnu.org> wrote:
> It recently occurred to me that I messed up an OSD's storage, and
> decided that the easiest way to bring it back was to roll it back to =
an
> earlier snapshot I'd taken (along the lines of clustersnap) and let i=
t
> recover from there.
>
> The problem with that idea was that the cluster had advanced too much
> since the snapshot was taken: the latest OSDMap known by that snapsho=
t
> was far behind the range still carried by the monitors.
>
> Determined to let that osd recover from all the data it already had,
> rather than restarting from scratch, I hacked up a =93solution=94 tha=
t
> appears to work: with the patch below, the OSD will use the contents =
of
> an earlier OSDMap (presumably the latest one it has) for a newer OSDM=
ap
> it can't get any more.
>
> A single run of osd with this patch was enough for it to pick up the
> newer state and join the cluster; from then on, the patched osd was n=
o
> longer necessary, and presumably should not be used except for this s=
ort
> of emergency.
>
> Of course this can only possibly work reliably if other nodes are up
> with same or newer versions of each of the PGs (but then, rolling bac=
k
> the OSD to an older snapshot would't be safe otherwise).  I don't kno=
w
> of any other scenarios in which this patch will not recover things
> correctly, but unless someone far more familiar with ceph internals t=
han
> I am vows for it, I'd recommend using this only if you're really
> desperate to avoid a recovery from scratch, and you save snapshots of
> the other osds (as you probably already do, or you wouldn't have olde=
r
> snapshots to rollback to :-) and the mon *before* you get the patched
> ceph-osd to run, and that you stop the mds or otherwise avoid changes
> that you're not willing to lose should the patch not work for you and
> you have to go back to the saved state and let the osd recover from
> scratch.  If it works, lucky us; if it breaks, well, I told you :-)

Yeah, this ought to basically work but it's very dangerous =97
potentially breaking invariants about cluster state changes, etc. I
wouldn't use it if the cluster wasn't otherwise healthy; other nodes
breaking in the middle of this operation could cause serious problems,
etc. I'd much prefer that one just recovers over the wire using normal
recovery paths... ;)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
