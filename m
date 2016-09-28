From: Jeff Layton <jlayton@redhat.com>
Subject: Re: libcephfs API changes for credential rework
Date: Wed, 28 Sep 2016 10:55:03 -0400
Message-ID: <1475074503.2664.3.camel@redhat.com>
References: <1474987148.2652.31.camel@redhat.com>
         <alpine.DEB.2.11.1609271501090.19850@piezo.us.to>
         <1474991011.2652.58.camel@redhat.com>
         <c1661d12-67fc-e04a-3e54-4a244879b465@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f178.google.com ([209.85.213.178]:33901 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbcI1OzI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2016 10:55:08 -0400
Received: by mail-yb0-f178.google.com with SMTP id e2so6665247ybi.1
        for <ceph-devel@vger.kernel.org>; Wed, 28 Sep 2016 07:55:07 -0700 (PDT)
In-Reply-To: <c1661d12-67fc-e04a-3e54-4a244879b465@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Gregory Farnum <gfarnum@redhat.com>

On Tue, 2016-09-27 at 22:40 +0200, Nathan Cutler wrote:
> > 
> > That said, the RPMs are currently named libcephfs1 and
> > libcephfs1-devel. I guess then we'd end up with a libcephfs2-devel. I
> > think we could add a "conflicts" directive in the specfile for it to
> > make sure we have a conflict with libcephfs1-devel.
> 
> Actually, in RPM we recently dropped the major version number from the 
> devel package names, so in the kraken release we will have 
> "libcephfs-devel" instead of "libcephfs1-devel". Same goes for the other 
> lib packages like librados2, librbd1, etc.
> 
> It would make sense to do the same for the debian packages, right? The 
> only reason to have the major version number in the package name is to 
> enable multiple major versions of a library to be installed at the same 
> time. But with the devel packages this is not possible - having the 
> major version in the package name there is just confusing.
> 
> At least, this is how it was explained to me ;-)
> 
> Nathan

I think that should be fine. I don't think you'd want to have more than
one devel package installed. That just contains the headers and a
symlink anyway, and the headers would most likely conflict.

If you want to build vs. the old API then you'd need an older set of
devel packages (and binary libs to build against).

-- 
Jeff Layton <jlayton@redhat.com>
