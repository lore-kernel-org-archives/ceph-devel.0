From: Sage Weil <sage@newdream.net>
Subject: Re: the messenger to send osd write ack|ondisk
Date: Tue, 6 Sep 2011 22:15:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109062214560.7331@cobra.newdream.net>
References: <Pine.LNX.4.64.1109062058240.7748@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51723 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab1IGFKP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2011 01:10:15 -0400
In-Reply-To: <Pine.LNX.4.64.1109062058240.7748@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 6 Sep 2011, Sage Weil wrote:
> Ah, nice catch.  This fixes it:
> 
> diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
> index 73b42ac..48ee6bb 100644
> --- a/src/osd/ReplicatedPG.cc
> +++ b/src/osd/ReplicatedPG.cc
> @@ -2817,7 +2817,7 @@ void ReplicatedPG::eval_repop(RepGather *repop)
>           reply = new MOSDOpReply(op, 0, osd->osdmap->get_epoch(), 0);
>         reply->add_flags(CEPH_OSD_FLAG_ACK);
>         dout(10) << " sending ack on " << *repop << " " << reply << dendl;
> -       osd->cluster_messenger->send_message(reply, op->get_connection());
> +       osd->client_messenger->send_message(reply, op->get_connection());
>         repop->sent_ack = true;
>        }
> 
> Pushing to master.

Er, looks like Greg already pushed this fix on Sunday!

sage
