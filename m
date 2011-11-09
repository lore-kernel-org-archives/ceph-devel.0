From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: [patch RFC] client: return stripe address replicas
Date: Tue, 8 Nov 2011 19:15:17 -0800 (PST)
Message-ID: <1771502131.44602.1320808517281.JavaMail.root@mail-01.cse.ucsc.edu>
References: <CAORUGqAS7xgKGrf6SgxoRg4P6JaZwuRmjDBwmW6PDFyTG+GoDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:39381 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab1KIDPR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2011 22:15:17 -0500
In-Reply-To: <CAORUGqAS7xgKGrf6SgxoRg4P6JaZwuRmjDBwmW6PDFyTG+GoDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <gregory.farnum@dreamhost.com>

----- Original Message -----
> From: "Tommi Virtanen" <tommi.virtanen@dreamhost.com>
> 
> The value in returning the number that *would have been written* is in
> that now the caller can reallocate a buffer of exactly the right size
> (barring races). Like snprintf() and friends. With just a generic
> -ENOBUFS/-EMSGSIZE/whatever you cram in there, the caller must do a
> series of increasing guesses.
> 

Thanks for the feedback. I ended up using -ERANGE, and allow naddr=0 for querying the actual size.

-Noah
