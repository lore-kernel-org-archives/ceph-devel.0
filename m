From: Tommi Virtanen <tv@inktank.com>
Subject: Re: PG recovery reservation state chart
Date: Tue, 2 Oct 2012 13:35:34 -0700
Message-ID: <CADvuQRHUKEJzbySqqT-9ri=65wM3fh0Dk5wjSPJ1Uhn2+cY_+Q@mail.gmail.com>
References: <20121002194858.GC8206@splice>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:36187 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827Ab2JBUfz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 16:35:55 -0400
Received: by qaas11 with SMTP id s11so902502qaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 13:35:54 -0700 (PDT)
In-Reply-To: <20121002194858.GC8206@splice>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Ryan <mike.ryan@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 2, 2012 at 12:48 PM, Mike Ryan <mike.ryan@inktank.com> wrote:
> Tried sending this earlier but it seems the list doesn't like PNGs.
> dotty or dot -Tpng will make short work of the .dot file I've attached.

vger discards messages with attachments. It's old school mailing list
software. It's also used by many old school communities, that consider
this a valuable anti-spam tactic, so they're not interested in
changing it.

Once this becomes less a design hypothetical and more a description of
how the code works, please please please put the dot in doc/dev/
