From: Sage Weil <sage@newdream.net>
Subject: Re: Best plan for recovery if disk holding monitor data dies
Date: Mon, 13 Feb 2012 21:09:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202132107420.4097@cobra.newdream.net>
References: <CA+jddaOUL1z-3JfS-ixAHthCU6k9zpCB55rmj9BO-tB92vvTHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39719 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab2BNFJF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2012 00:09:05 -0500
In-Reply-To: <CA+jddaOUL1z-3JfS-ixAHthCU6k9zpCB55rmj9BO-tB92vvTHQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 13 Feb 2012, Mandell Degerness wrote:
> What would you recommend as the best recovery strategy when the disk
> holding the monitor data for a given monitor fails?
> 
> Should I recover from a periodic back up and re-start the monitor or
> should I treat it as a new monitor being added to the cluster?  I
> suspect the former, but i'd like confirmation.  Any information on
> gotcha's would be useful as well.

The simplest is to treat is as a new addition.  

sage
