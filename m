From: Jeff Layton <jlayton@samba.org>
Subject: Re: [PATCH v2] Samba RADOS service registration
Date: Thu, 15 Feb 2018 14:05:55 -0500
Message-ID: <1518721555.4086.56.camel@samba.org>
References: <20180213022540.5f9686b7@suse.de>
         <20180213202727.77175e21@suse.de> <1518718185.4086.45.camel@samba.org>
         <20180215195219.259acfc8@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hr2.samba.org ([144.76.82.148]:24682 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1167186AbeBOTF6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:05:58 -0500
In-Reply-To: <20180215195219.259acfc8@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Samba Technical <samba-technical@lists.samba.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 2018-02-15 at 19:52 +0100, David Disseldorp wrote:
> Hi Jeff,
> 
> On Thu, 15 Feb 2018 13:09:45 -0500, Jeff Layton wrote:
> 
> > IIUC, if the program (samba in this case) dies, and then is restarted
> > (maybe host reboots?), it'll get a new instance_guid, right? Or am I
> > misunderstanding what rados_get_instance_id will return here?
> 
> Yes, that's right. On smbd restart it'll reconnect and get a new
> instance ID. The hostname is carried in the metadata, which makes it a
> little easier to identify what's going on from the Ceph side.
> 
> AFAICT the service record (unfortunately) remains present after
> rados_shutdown() until a timeout on the manager is tripped, so
> it's quite possible to have to registrations for the same host for a
> short amount of time.
> 
> Cheers, David

Got it, thanks. I guess the fact that it changes it not a problem here?
I'm not that well versed in what ceph-mgr does, tbqh...

One thing you may want to be careful about: I found some thread safety
problems a few months ago in how CephContext objects are handled in the
ceph code. While I patched them up as best I could, a lot of older
shipping versions still have those bugs. Even with those fixes, I think
there may still be lurking problems when we have multiple ceph/rados
clients within the same process image.

The upshot here is that if you have the rados client here and (e.g.) a
vfs_ceph client for exporting cephfs, you can hit some races
particularly on setup and teardown of those clients that can cause
crashes.

libcephfs has a ceph_create_with_context image and librados has
something similar. You might consider having a truly global cct object,
and then have the vfs_ceph create a client handle with the same object.

-- 
Jeff Layton <jlayton@samba.org>
