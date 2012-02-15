From: Sage Weil <sage@newdream.net>
Subject: Re: Size of monitor data dir
Date: Tue, 14 Feb 2012 18:20:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202141818560.3836@cobra.newdream.net>
References: <CA+jddaODnwadRXpXaCNzzmDB5h7dK_+Y82y_+zpBKF0zkTgJNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43680 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814Ab2BOCUy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2012 21:20:54 -0500
In-Reply-To: <CA+jddaODnwadRXpXaCNzzmDB5h7dK_+Y82y_+zpBKF0zkTgJNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mandell Degerness <mandell@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org, wido@widodh.nl

On Tue, 14 Feb 2012, Mandell Degerness wrote:
> How big can the monitor data directory grow?  Is there a rule of thumb
> that can be used?

Right now the monitor dir include teh cluster log files (log and log.*), 
which grow indefinitely unless you rotate them.  The other directories 
are mostly trimmed by the monitor itself and should stay pretty small (few 
hundred megs at most?).  The lingering exception is the mdsmap dir, which 
isn't yet trimmed, but you guys won't be using that anyway (and the maps 
are small).

Maybe Wido or someone else who has a long running cluster can see how big 
it is?

sage
