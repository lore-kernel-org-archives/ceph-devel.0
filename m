From: Gregory Farnum <greg@inktank.com>
Subject: Re: Limiting specific to specific directory, client separation
Date: Mon, 24 Mar 2014 10:14:39 -0700
Message-ID: <CAPYLRzikDj9M=iJxW4_UAMazL2kAdcvLRGfo6CKsqZTPBW=-dA@mail.gmail.com>
References: <CA+5bbP9-NGQ2sAsSwrauhKpsvqxjRjcxf4MRRNNL4gqxDO2k+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:36103 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200AbaCXROk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Mar 2014 13:14:40 -0400
Received: by mail-qc0-f176.google.com with SMTP id m20so6290841qcx.7
        for <ceph-devel@vger.kernel.org>; Mon, 24 Mar 2014 10:14:39 -0700 (PDT)
In-Reply-To: <CA+5bbP9-NGQ2sAsSwrauhKpsvqxjRjcxf4MRRNNL4gqxDO2k+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Szymon Szypulski <szymon.szypulski@ragnarson.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is not currently a priority in Inktank's roadmap for the MDS. :(
But we discussed client security in more detail than those tickets
during the Dumpling Ceph Developer Summit:
http://wiki.ceph.com/Planning/CDS/Dumpling (search for "1G: Client
Security for CephFS" -- there's a blueprint, an etherpad, and a video
of the discussion)

I think that pretty well covers the work involved in doing what you
describe, and we would love to support any developers working on this
or other features!
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Mon, Mar 24, 2014 at 3:37 AM, Szymon Szypulski
<szymon.szypulski@ragnarson.com> wrote:
> Hi,
>
> We would liked to migrate from gluster to ceph in environment where
> multiple servers can access one directory, where some should be
> unavailable. Basically we need per directory access list for multiple
> users.
>
> I've found some overdue tickets on tracker
> http://tracker.ceph.com/issues/1401 and
> http://tracker.ceph.com/issues/1237. Is there any chance it will be
> included into road map soon? If not, is there anything we can do to
> speed it up? Hire C/C++ dev internally and delegate it to ceph
> development? Maybe something else?
>
> ---
> Szymon Szypulski
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
