From: Mike Ryan <mike.ryan@inktank.com>
Subject: Re: PG recovery reservation state chart
Date: Tue, 2 Oct 2012 13:42:50 -0700
Message-ID: <20121002204249.GF8206@splice>
References: <20121002194858.GC8206@splice>
 <CADvuQRHUKEJzbySqqT-9ri=65wM3fh0Dk5wjSPJ1Uhn2+cY_+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65160 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab2JBUmx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 16:42:53 -0400
Received: by pbbrr4 with SMTP id rr4so9131913pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 13:42:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADvuQRHUKEJzbySqqT-9ri=65wM3fh0Dk5wjSPJ1Uhn2+cY_+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 02, 2012 at 01:35:34PM -0700, Tommi Virtanen wrote:
> On Tue, Oct 2, 2012 at 12:48 PM, Mike Ryan <mike.ryan@inktank.com> wrote:
> > Tried sending this earlier but it seems the list doesn't like PNGs.
> > dotty or dot -Tpng will make short work of the .dot file I've attached.
> 
> vger discards messages with attachments. It's old school mailing list
> software. It's also used by many old school communities, that consider
> this a valuable anti-spam tactic, so they're not interested in
> changing it.

I figured as much. It would have been nice to receive a notification
that it was dropped rather than having it silently fall on the floor,
especially since a copy of the message is not sent to the sender upon
list acceptance. c'est la vie

> Once this becomes less a design hypothetical and more a description of
> how the code works, please please please put the dot in doc/dev/

This is unnecessary, as the doc scripts will automatically generate a
full peering state chart (of which this is just a sub state). Major
kudos to Sam Just for making that happen!
