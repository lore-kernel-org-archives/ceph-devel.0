From: Wido den Hollander <wido@42on.com>
Subject: Re: ceph-deploy osd destroy feature
Date: Sun, 04 Jan 2015 12:07:06 +0100
Message-ID: <54A91EDA.8080008@42on.com>
References: <CACkq2moPdXgDGCtr-jtd+rxEGT3H_SFnVGruvKqfXDuvU8eagg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:41438 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbbADLHK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 4 Jan 2015 06:07:10 -0500
In-Reply-To: <CACkq2moPdXgDGCtr-jtd+rxEGT3H_SFnVGruvKqfXDuvU8eagg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 01/02/2015 10:31 PM, Travis Rhoden wrote:
> Hi everyone,
> 
> There has been a long-standing request [1] to implement an OSD
> "destroy" capability to ceph-deploy.  A community user has submitted a
> pull request implementing this feature [2].  While the code needs a
> bit of work (there are a few things to work out before it would be
> ready to merge), I want to verify that the approach is sound before
> diving into it.
> 
> As it currently stands, the new feature would do allow for the following:
> 
> ceph-deploy osd destroy <host> --osd-id <id>
> 
> From that command, ceph-deploy would reach out to the host, do "ceph
> osd out", stop the ceph-osd service for the OSD, then finish by doing
> "ceph osd crush remove", "ceph auth del", and "ceph osd rm".  Finally,
> it would umount the OSD, typically in /var/lib/ceph/osd/...
> 

Prior to the unmount, shouldn't it also clean up the 'ready' file to
prevent the OSD from starting after a reboot?

Although it's key has been removed from the cluster it shouldn't matter
that much, but it seems a bit cleaner.

It could even be more destructive, that if you pass --zap-disk to it, it
also runs wipefs or something to clean the whole disk.

> 
> Does this high-level approach seem sane?  Anything that is missing
> when trying to remove an OSD?
> 
> 
> There are a few specifics to the current PR that jump out to me as
> things to address.  The format of the command is a bit rough, as other
> "ceph-deploy osd" commands take a list of [host[:disk[:journal]]] args
> to specify a bunch of disks/osds to act on at one.  But this command
> only allows one at a time, by virtue of the --osd-id argument.  We
> could try to accept [host:disk] and look up the OSD ID from that, or
> potentially take [host:ID] as input.
> 
> Additionally, what should be done with the OSD's journal during the
> destroy process?  Should it be left untouched?
> 
> Should there be any additional barriers to performing such a
> destructive command?  User confirmation?
> 
> 
>  - Travis
> 
> [1] http://tracker.ceph.com/issues/3480
> [2] https://github.com/ceph/ceph-deploy/pull/254
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
