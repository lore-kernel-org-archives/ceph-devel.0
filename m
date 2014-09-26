From: Craig Lewis <clewis@centraldesktop.com>
Subject: Re: RGW URL Parsing
Date: Fri, 26 Sep 2014 15:54:01 -0700
Message-ID: <CADHZLBb-_QT2dttecDkYvsHPvFs4CVOsTMhuZOZP+DFf3jPNJQ@mail.gmail.com>
References: <CADHZLBbpjftiH+rxBAKz3SdgHVaxJQ=_fQTwU5B8wM7gTqmj8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:52025 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbaIZWyX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Sep 2014 18:54:23 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so1874371wgh.22
        for <ceph-devel@vger.kernel.org>; Fri, 26 Sep 2014 15:54:22 -0700 (PDT)
In-Reply-To: <CADHZLBbpjftiH+rxBAKz3SdgHVaxJQ=_fQTwU5B8wM7gTqmj8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>, Yehuda Sadeh <yehuda@inktank.com>

Sorry for the re-post.  I forgot to disable HTML.


I've been slacking on my RGW Snapshots blueprint, but I'm getting back into it.

I started working on the URL parsing, to parse the query string in
http://bucket.cluster.com/object?snapshot=snapname


I found the url_decode in src/rgw/rgw_common.cc, but I notice that
it's not really parsing the URL.  It's just decoding the + and %
escape sequences.

Rather than re-implementing URL parsing, I was thinking of replacing
url_decode with something that returns a Civet structure.  No idea
what yet, I wanted to get some opinions before I put much effort into
it.  I wasn't sure how tightly RGW should be coupled to Civet.  It
looks like it's already linked, so I don't see any harm.


I'm definitely a junior dev here, and I'm always leery when a junior
dev proposes a refactor.  ;-)

Opinions?
