From: David Disseldorp <ddiss@suse.de>
Subject: Re: [RFC PATCH] Samba RADOS service registration
Date: Tue, 13 Feb 2018 13:29:41 +0100
Message-ID: <20180213132941.0208a8b2@suse.de>
References: <20180213022540.5f9686b7@suse.de>
        <CALe9h7dPuDOtY06RPXJ2u5wkT=j8S6D1PkwgfByuQ8y3cuP9Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935182AbeBMM3n (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:29:43 -0500
In-Reply-To: <CALe9h7dPuDOtY06RPXJ2u5wkT=j8S6D1PkwgfByuQ8y3cuP9Fg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samba Technical <samba-technical@lists.samba.org>

Thanks for the feedback everyone...

On Tue, 13 Feb 2018 11:07:44 +0000, John Spray wrote:

> On Tue, Feb 13, 2018 at 1:25 AM, David Disseldorp <ddiss@suse.de> wrote:
...
> > I'd like to (at the very least) pack the CephFS backed share names and
> > paths into the service registration.  
> 
> Echoing back the share configuration probably isn't a good use of this
> interface -- the idea is for service daemons to register just enough
> information about themselves to report on their existence, location
> and health.

Okay, I'll keep it simple then, and just use the Ceph global instance id
and daemon name (smbd) for now.

> In the case of nfs-ganesha, we're moving toward having the option of
> consuming its share configuration from a central place like a RADOS
> object, rather than from a local text config file -- in that model, a
> UI can go look at the configuration directly rather than having the
> daemon report it back.  This is kind of a Ceph-ized version of the way
> a lot of new projects are storing their configuration in etcd.

Interesting. The same should be possible for Samba when we eventually
have a Ceph key-value store backend for Samba's dbwrap, and then use
Registry configuration.

Cheers, David
