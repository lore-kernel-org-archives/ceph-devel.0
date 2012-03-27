From: David McBride <dwm@doc.ic.ac.uk>
Subject: Re: Increasing the number of PGs
Date: Tue, 27 Mar 2012 17:45:11 +0100
Message-ID: <1332866711.8411.70.camel@squire.doc.ic.ac.uk>
References: <20120326213459.e8ace6f3.ctpm@ist.utl.pt>
	 <CAORUGqBzBBoi3TeWcqzyeN7vSW+=FCLM72MnPJfCqOFrQ9iOdg@mail.gmail.com>
	 <1332848771.8411.68.camel@squire.doc.ic.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from baza.doc.ic.ac.uk ([146.169.1.193]:53987 "EHLO
	baza.doc.ic.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab2C0QpV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 12:45:21 -0400
In-Reply-To: <1332848771.8411.68.camel@squire.doc.ic.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 2012-03-27 at 12:46 +0100, David McBride wrote:

> Does the act of adding OSDs itself result in the PG count being
> increased?  

Correction to my last: it doesn't, but changing the replica-count (e.g.
from 2 -> 3 using `ceph osd pool set rbd size 3`) does.

That's somewhat easier to avoid, however.

Apologies for the noise.

Cheers,
David
-- 
David McBride <dwm@doc.ic.ac.uk>
Department of Computing, Imperial College, London

