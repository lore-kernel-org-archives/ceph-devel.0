From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: libcephfs API changes for credential rework
Date: Tue, 27 Sep 2016 22:40:59 +0200
Message-ID: <c1661d12-67fc-e04a-3e54-4a244879b465@suse.cz>
References: <1474987148.2652.31.camel@redhat.com>
 <alpine.DEB.2.11.1609271501090.19850@piezo.us.to>
 <1474991011.2652.58.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39965 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754129AbcI0UlC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 27 Sep 2016 16:41:02 -0400
In-Reply-To: <1474991011.2652.58.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>, Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Gregory Farnum <gfarnum@redhat.com>

> That said, the RPMs are currently named libcephfs1 and
> libcephfs1-devel. I guess then we'd end up with a libcephfs2-devel. I
> think we could add a "conflicts" directive in the specfile for it to
> make sure we have a conflict with libcephfs1-devel.

Actually, in RPM we recently dropped the major version number from the 
devel package names, so in the kraken release we will have 
"libcephfs-devel" instead of "libcephfs1-devel". Same goes for the other 
lib packages like librados2, librbd1, etc.

It would make sense to do the same for the debian packages, right? The 
only reason to have the major version number in the package name is to 
enable multiple major versions of a library to be installed at the same 
time. But with the devel packages this is not possible - having the 
major version in the package name there is just confusing.

At least, this is how it was explained to me ;-)

Nathan
