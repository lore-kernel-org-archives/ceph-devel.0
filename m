From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] reinstate ceph cluster_snap support
Date: Fri, 23 Aug 2013 17:17:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308231715500.28981@cobra.newdream.net>
References: <orob8qt7kf.fsf@livre.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43210 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab3HXARX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Aug 2013 20:17:23 -0400
In-Reply-To: <orob8qt7kf.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>, sam.just@inktank.com
Cc: ceph-devel@vger.kernel.org

Sam, do you remember why we disabled this?

I think it happened when the pg threading stuff went in, but I'm not sure 
why we can't just take a blanket snapshot of current/.

FWIW Alexandre, this feature was never really complete.  For it to work, 
we also need to snapshot the monitors, and roll them back as well.

sage


On Thu, 22 Aug 2013, Alexandre Oliva wrote:

> This patch brings back and updates (for dumpling) the code originally
> introduced to support ?ceph osd cluster_snap <snap>?, that was disabled
> and partially removed before cuttlefish.
> 
> Some minimal testing appears to indicate this even works: the modified
> mon actually generated an osdmap with the cluster_snap request, and
> starting a modified osd that was down and letting it catch up caused
> the osd to take the requested snapshot.  I see no reason why it
> wouldn't have taken it if it was up and running, so...  Why was this
> feature disabled in the first place?
> 
> Signed-off-by: Alexandre Oliva <oliva@gnu.org>
> ---
>  src/mon/MonCommands.h |    6 ++++--
>  src/mon/OSDMonitor.cc |   11 +++++++----
>  src/osd/OSD.cc        |   13 +++++++++++++
>  3 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/src/mon/MonCommands.h b/src/mon/MonCommands.h
> index 8e9c2bb..225c687 100644
> --- a/src/mon/MonCommands.h
> +++ b/src/mon/MonCommands.h
> @@ -431,8 +431,10 @@ COMMAND("osd set " \
>  COMMAND("osd unset " \
>  	"name=key,type=CephChoices,strings=pause|noup|nodown|noout|noin|nobackfill|norecover|noscrub|nodeep-scrub", \
>  	"unset <key>", "osd", "rw", "cli,rest")
> -COMMAND("osd cluster_snap", "take cluster snapshot (disabled)", \
> -	"osd", "r", "")
> +COMMAND("osd cluster_snap " \
> +	"name=snap,type=CephString", \
> +	"take cluster snapshot",	\
> +	"osd", "r", "cli")
>  COMMAND("osd down " \
>  	"type=CephString,name=ids,n=N", \
>  	"set osd(s) <id> [<id>...] down", "osd", "rw", "cli,rest")
> diff --git a/src/mon/OSDMonitor.cc b/src/mon/OSDMonitor.cc
> index 07022ae..9bf9511 100644
> --- a/src/mon/OSDMonitor.cc
> +++ b/src/mon/OSDMonitor.cc
> @@ -3099,10 +3099,13 @@ bool OSDMonitor::prepare_command(MMonCommand *m)
>        return prepare_unset_flag(m, CEPH_OSDMAP_NODEEP_SCRUB);
>  
>    } else if (prefix == "osd cluster_snap") {
> -    // ** DISABLE THIS FOR NOW **
> -    ss << "cluster snapshot currently disabled (broken implementation)";
> -    // ** DISABLE THIS FOR NOW **
> -
> +    string snap;
> +    cmd_getval(g_ceph_context, cmdmap, "snap", snap);
> +    pending_inc.cluster_snapshot = snap;
> +    ss << "creating cluster snap " << snap;
> +    getline(ss, rs);
> +    wait_for_finished_proposal(new Monitor::C_Command(mon, m, 0, rs, get_last_committed()));
> +    return true;
>    } else if (prefix == "osd down" ||
>  	     prefix == "osd out" ||
>  	     prefix == "osd in" ||
> diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
> index 1a77dae..e41a6b3 100644
> --- a/src/osd/OSD.cc
> +++ b/src/osd/OSD.cc
> @@ -5022,6 +5022,19 @@ void OSD::handle_osd_map(MOSDMap *m)
>      assert(0 == "MOSDMap lied about what maps it had?");
>    }
>  
> +  // check for cluster snapshots
> +  for (epoch_t cur = superblock.current_epoch + 1; cur <= m->get_last(); cur++) {
> +    OSDMapRef newmap = get_map(cur);
> +    string cluster_snap = newmap->get_cluster_snapshot();
> +    if (cluster_snap.length() == 0)
> +      continue;
> +
> +    dout(0) << "creating cluster snapshot '" << cluster_snap << "'" << dendl;
> +    int r = store->snapshot(cluster_snap);
> +    if (r)
> +      dout(0) << "failed to create cluster snapshot: " << cpp_strerror(r) << dendl;
> +  }
> +
>    if (superblock.oldest_map) {
>      int num = 0;
>      epoch_t min(
> 
> -- 
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist      Red Hat Brazil Compiler Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
