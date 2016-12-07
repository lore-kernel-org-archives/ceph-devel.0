From: Sage Weil <sage@newdream.net>
Subject: Re: Question about ReplicatedBackend::sub_op_modify_reply
Date: Wed, 7 Dec 2016 14:29:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612071429320.22485@piezo.novalocal>
References: <41f33622.d4cc.158d91430e9.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51742 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbcLGO36 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Dec 2016 09:29:58 -0500
In-Reply-To: <41f33622.d4cc.158d91430e9.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 7 Dec 2016, xxhdx1985126 wrote:
> Hi, everyone.
> 
> 
> I'm trying to read the source code of ceph, and I found that some code seems strange.
> In ReplicatedBackend::sub_op_modify_reply, there is the following code:
> 		if (r->ack_type & CEPH_OSD_FLAG_ONDISK) {
> 			assert(ip_op.waiting_for_commit.count(from));
> 			ip_op.waiting_for_commit.erase(from);
> 			if (ip_op.op) {
> 				ostringstream ss;
> 				ss << "sub_op_commit_rec_from_osd." << from.osd;
> 				ip_op.op->mark_event(ss.str());
> 			}
> 		} else {
> 			assert(ip_op.waiting_for_applied.count(from));
> 			if (ip_op.op) {
> 				ostringstream ss;
> 				ss << "sub_op_applied_rec_from_osd." << from.osd;
> 				ip_op.op->mark_event(ss.str());
> 			}
> 		}
> 		ip_op.waiting_for_applied.erase(from);
> It seems that the statement "ip_op.waiting_for_applied.erase(from)" should be in the "else" clause, otherwise items in waiting_for_applied could be errorly erased when ack_type is CEPH_OSD_FLAG_ONDISK.
> 
> Why put it outside the "else" clause?

The commit/ondisk message implies applied.

sage
