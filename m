From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph-users] would people mind a slow osd restart during luminous
 upgrade?
Date: Thu, 9 Feb 2017 14:25:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702091425310.7782@piezo.novalocal>
References: <alpine.DEB.2.11.1702090302470.7782@piezo.novalocal> <C490FBFB-7A7E-49FE-8283-A59C1205557F@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753117AbdBIOZo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Feb 2017 09:25:44 -0500
In-Reply-To: <C490FBFB-7A7E-49FE-8283-A59C1205557F@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: George Mihaiescu <lmihaiescu@gmail.com>
Cc: ceph-users@ceph.com, ceph-devel@vger.kernel.org

On Thu, 9 Feb 2017, George Mihaiescu wrote:
> Hi Sage,
> 
> Is the update running in parallel for all OSDs being restarted? 
> 
> Because 5 min per server is different than 150 min when there are 30 
> OSDs there..

In parallel.

sage

> 
> Thank you,
> George 
> 
> > On Feb 8, 2017, at 22:09, Sage Weil <sweil@redhat.com> wrote:
> > 
> > Hello, ceph operators...
> > 
> > Several times in the past we've had to do some ondisk format conversion 
> > during upgrade which mean that the first time the ceph-osd daemon started 
> > after upgrade it had to spend a few minutes fixing up it's ondisk files.  
> > We haven't had to recently, though, and generally try to avoid such 
> > things.
> > 
> > However, there's a change we'd like to make in FileStore for luminous (*) 
> > and it would save us a lot of time and complexity if it was a one-shot 
> > update during the upgrade.  I would probably take in the neighborhood of 
> > 1-5 minutes for a 4-6TB HDD.  That means that when restarting the daemon 
> > during the upgrade the OSD would stay down for that period (vs the usual 
> > <1 restart time).
> > 
> > Does this concern anyone?  It probably means the upgrades will take longer 
> > if you're going host by host since the time per host will go up.
> > 
> > sage
> > 
> > 
> > * eliminate 'snapdir' objects, replacing them with a head object + 
> > whiteout.
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
