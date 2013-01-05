From: Gregory Farnum <greg@inktank.com>
Subject: Re: Any idea about doing deduplication in ceph?
Date: Fri, 4 Jan 2013 16:47:17 -0800
Message-ID: <CAPYLRzjRhNBW=w43M==Y1JavqXxm=f9PfaccwhFuZXMj6LSZWQ@mail.gmail.com>
References: <000001cde3d8$2c61a410$8524ec30$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:53629 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934Ab3AEArR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 19:47:17 -0500
Received: by mail-qc0-f176.google.com with SMTP id n41so9080484qco.7
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jan 2013 16:47:17 -0800 (PST)
In-Reply-To: <000001cde3d8$2c61a410$8524ec30$@com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: lollipop <lollipop_jin@126.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Dec 26, 2012 at 6:16 PM, lollipop <lollipop_jin@126.com> wrote:
> Nowadays, I am wondering doing offline deduplication in ceph?
> My idea is:
> First in the ceph-client, I try to get the locations of chunks in one file.
> The information includes
> how many chunks the file has and which osd the chunk(object group) has been
> stored.
> Then the ceph-client try to communicate with the exact osd to ask the osd to
> return the chunk hash.
> After that, we compare the returned hash with the already stored hash table,
> If the chunk is duplicated, we try to change the file meta-data.
> Can it work?
> Can you give some ideas? Thank you


Any off-line deduplication support in Ceph is going to have the
important parts be in the OSD code, not in the clients. :) We've
discussed dedup a little bit internally and on the mailing list; you
can do an archive search if you're interested in what the current
thoughts are. :)
-Greg
