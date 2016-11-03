From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: kraken
Date: Thu, 03 Nov 2016 18:36:25 -0400
Message-ID: <1478212585.17105.3.camel@poochiereds.net>
References: <alpine.DEB.2.11.1611011319120.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34985 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933204AbcKCWg3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Nov 2016 18:36:29 -0400
Received: by mail-qt0-f171.google.com with SMTP id c47so37904616qtc.2
        for <ceph-devel@vger.kernel.org>; Thu, 03 Nov 2016 15:36:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1611011319120.20331@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org
Cc: John Spray <jspray@redhat.com>

On Tue, 2016-11-01 at 13:20 +0000, Sage Weil wrote:
> Hey everyone,
> 
> I think we're about ready for a kraken feature freeze.  The main item we 
> were waiting for was the EC overwrites and Sam has a working branch for 
> review this week.  There are still a few odds and ends that I have on my 
> list to get in (like the new CRUSH tunable), but it's a short list.
> 
> How does next Monday (11/7) sound for an initial freeze?
> 
> 

I have a PR up that I'd like to see go in that fixes some really slow
fsync performance in libcephfs:

    https://github.com/ceph/ceph/pull/11710

The catch here is that it requires a protocol change in MClientCaps, so
it'd be good to merge that in with the btime/change_attr stuff before
release. At this point though, I just want to understand whether the
general approach is sound. Do we want to allow the client to hint to
the MDS that it should flush its log.

Also, we probably need to think about what to do with the libcephfs API
overhaul:

    https://github.com/ceph/ceph/pull/11647

That will rev the libcephfs version to "2", and break the API. I have
the ganesha and samba patches done.

Do we want that in kraken, or should it wait for luminous?
-- 
Jeff Layton <jlayton@poochiereds.net>
