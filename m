From: Sage Weil <sage@newdream.net>
Subject: Re:Re: Question about ReplicatedBackend::sub_op_modify_reply
Date: Fri, 9 Dec 2016 03:54:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612090353310.5710@piezo.novalocal>
References: <41f33622.d4cc.158d91430e9.Coremail.xxhdx1985126@163.com> <alpine.DEB.2.11.1612071429320.22485@piezo.novalocal> <4bb8100c.56f0.158e1b25e72.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1121986784-1481255680=:5710"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34370 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932192AbcLIDym (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2016 22:54:42 -0500
In-Reply-To: <4bb8100c.56f0.158e1b25e72.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1121986784-1481255680=:5710
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 9 Dec 2016, xxhdx1985126 wrote:
> Thanks for the quick reply:-)
> 
> By the way,  according to my understanding of the source code, the ondisk
> callback is trigger both when journal write complete or syscall(SYS_syncfs,
> fd) complete. Is this right?

The syncfs path only happens if you're using btrfs ('parallel' mode) since 
with xfs we don't even write to the fs until the journaled event has 
committed.

s
 > 
> 
> 
> At 2016-12-07 22:29:55, "Sage Weil" <sage@newdream.net> wrote:
> >On Wed, 7 Dec 2016, xxhdx1985126 wrote:
> >> Hi, everyone.
> >> 
> >> 
> >> I'm trying to read the source code of ceph, and I found that some code se
> ems strange.
> >> In ReplicatedBackend::sub_op_modify_reply, there is the following code:
> >> 		if (r->ack_type & CEPH_OSD_FLAG_ONDISK) {
> >> 			assert(ip_op.waiting_for_commit.count(from));
> >> 			ip_op.waiting_for_commit.erase(from);
> >> 			if (ip_op.op) {
> >> 				ostringstream ss;
> >> 				ss << "sub_op_commit_rec_from_osd." << from.osd;
> >> 				ip_op.op->mark_event(ss.str());
> >> 			}
> >> 		} else {
> >> 			assert(ip_op.waiting_for_applied.count(from));
> >> 			if (ip_op.op) {
> >> 				ostringstream ss;
> >> 				ss << "sub_op_applied_rec_from_osd." << from.osd;
> >> 				ip_op.op->mark_event(ss.str());
> >> 			}
> >> 		}
> >> 		ip_op.waiting_for_applied.erase(from);
> >> It seems that the statement "ip_op.waiting_for_applied.erase(from)" shoul
> d be in the "else" clause, otherwise items in waiting_for_applied could be e
> rrorly erased when ack_type is CEPH_OSD_FLAG_ONDISK.
> >> 
> >> Why put it outside the "else" clause?
> >
> >The commit/ondisk message implies applied.
> >
> >sage
> 
> 
>  
> 
> 
> 
--8323329-1121986784-1481255680=:5710--
