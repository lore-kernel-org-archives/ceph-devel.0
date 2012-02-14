From: Sage Weil <sage@newdream.net>
Subject: Re: Best plan for recovery if disk holding monitor data dies
Date: Tue, 14 Feb 2012 09:12:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202140911230.1554@cobra.newdream.net>
References: <CA+jddaOUL1z-3JfS-ixAHthCU6k9zpCB55rmj9BO-tB92vvTHQ@mail.gmail.com>
 <Pine.LNX.4.64.1202132107420.4097@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36310 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793Ab2BNRMa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2012 12:12:30 -0500
In-Reply-To: <Pine.LNX.4.64.1202132107420.4097@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 13 Feb 2012, Sage Weil wrote:
> On Mon, 13 Feb 2012, Mandell Degerness wrote:
> > What would you recommend as the best recovery strategy when the disk
> > holding the monitor data for a given monitor fails?
> > 
> > Should I recover from a periodic back up and re-start the monitor or
> > should I treat it as a new monitor being added to the cluster?  I
> > suspect the former, but i'd like confirmation.  Any information on
> > gotcha's would be useful as well.
> 
> The simplest is to treat is as a new addition.  

Just to clarify, you should re-add the "new" mon with the same name and IP 
as the one that failed.  The process is nearly identical, except that 
'newname' is 'oldname':

	http://ceph.newdream.net/docs/latest/ops/manage/grow/mon/

sage

