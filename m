From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD mirroring CLI proposal ...
Date: Tue, 22 Sep 2015 13:32:49 -0400 (EDT)
Message-ID: <151161168.32108716.1442943169367.JavaMail.zimbra@redhat.com>
References: <604040155.31290870.1442846770290.JavaMail.zimbra@redhat.com> <189900515.31291453.1442846891314.JavaMail.zimbra@redhat.com> <20150922092847.GA13767@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:50123 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbbIVRcu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Sep 2015 13:32:50 -0400
In-Reply-To: <20150922092847.GA13767@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> > * rbd consistency-group create <group-spec>
> >                 [--object-pool <pool-name>]
> >                 [--splay-width <num>]
> >                 [--object-size <B/K/M>]
> >                 [--additional-journal-tweakable-settings]
> >         This will create an empty journal for use with consistency groups
> >         (i.e. attaching
> >         multiple RBD images to the same journal to ensure consistent
> >         replay).
> 
> For 'rbd feature' commands the option names have "journal" prefix
> (--journal-object-pool), while for 'rbd consistency-group' they
> don't. Is it intentional? I would prefer having "journal" prefix for
> both.

It was intentional with the rationale that the 'journal-' prefix was added to the 'rbd feature enable' command because in the future it might support other configurable params.  I have no issue keeping them consistent between the two.   

> > 
> > * rbd consistency-group rename <group-spec>
> 
> s/rename/remove/ ?

Yup -- I think I merged the rename and remove commands by accident.  

> > * rbd consistency-group info <group-spec>
> >         This will display information about the specified consistent group
> > 
> > where <group-spec> is [<pool-name>/]<group-name>
> 
> Is a consistency-group just a journal (usually used for several images)
> or is it something more? If I enable journaling feature for an image,
> journal is automatically created, is it already a consistency-group?

Correct -- I'm just using the command name to describe the behavior you would receive if you attached multiple images to the same journal.  If you enable journaling for a given image (or if it is enabled by default due to the pool's mirroring policy), then you will have a journal created for you automatically that is only associated with the single image.  However, you wouldn't be able to attach another image to the same journal nor would you see such a journal listed as a named consistency group.  I was originally toying around with having all of these "rbd consistency-group" commands being just additional "rbd journal" commands and eliminating the semantic difference.

> > * rbd mirror pool enable <pool-name>
> >         This will, by default, ensure that all images created in this
> >         pool have exclusive lock, journaling, and mirroring feature bits
> >         enabled.
> > 
> > * rbd mirror pool disable <pool-name>
> >         This will clear the default image features for new images in this
> >         pool.
> 
> Will 'rbd mirror pool enable|disable' change behaviour only for newly
> created images in the pool or will enable|disable mirroring for
> existent images too?

Since the goal is to set default pool behavior, it would only apply to newly created images.  You can enable/disable on specific images using the 'rbd mirror image enable/disable' commands.

> > * rbd mirror pool add <remote-pool-spec>
> >         This will register a remote cluster/pool as a peer to the current,
> >         local pool.  All existing mirrored images and all future mirrored
> >         images will have this peer registered as a journal client.
> >         
> > * rbd mirror pool remove <remote-pool-spec>
> >         This will deregister a remote cluster/pool as a peer to the
> >         current,
> >         local pool.  All existing mirrored images will have the remote
> >         deregistered from image journals.
> 
> In remote-pool-spec, if it is "cluster/pool", where it is expected to
> find configuration for the cluster "cluster"? In /etc/ceph/cluster.conf?

Ceph conventions state that the configuration file for a given cluster should be named "<cluster-name>.conf" and placed in the search path (/etc/ceph being one such place). 

> Apart from the list of new commands, it would be very helpful to see
> typical use case examples. Are my examples below correct?
> 
> Enable mirroring for pool "volumes", using pool "journals" for journal
> objects:
> 
>   rbd mirror pool enable volumes --journal-object-pool journals

Yup -- I neglected to include journaling defaults in that command, but it would be good to include them.

> Start mirroring to the remote cluster ceph-remote:
> 
>   Specify the remote cluster configuration in
>   /etc/ceph/ceph-remote.conf
> 
>   rbd mirror pool add ceph-remote/volumes
> 
>   Start RBD mirroring daemon on the remote cluster. Both clusters
>   should be specified in config or via command line parameters. No
>   need to specify mirroring pools, I suppose?

Haven't thought about this level of detail, but I think you'd be fine only specifying the local cluster to the RBD mirroring daemon.  It could then scan all the pools, lookup peer cluster names, and connect.  The daemon should use the journal's primary / secondary state + epoch to know whether or not to replicate the events from the remote.

> To configure a consistency group cgroup1 for images volume1 and
> volume2 in pool volumes:
> 
>   rbd consistency-group create volume/cgroup1 --object-pool journals
>   rbd consistency-group attach volume/volume1 volume/cgroup1
>   rbd consistency-group attach volume/volume2 volume/cgroup1
> 
> I guess before attaching I will need to disable journaling for volumes
> (because it was automatically enabled previously with 'rbd mirror pool
> enable')? Will it automatically enable mirroring feature for the
> attached images?

I was planning to just fail the attach if journaling was already enabled, but it could just as easily (behind the scenes) disable journaling to kill off the old journal (and wean potential RBD mirroring daemons off the journal) and then just re-enable it using the new consistency group journal.  In this example, if the images volume1 and volume2 existed before you enable the pool mirroring property, they wouldn't have add journaling automatically enabled.

--

Jason Dillaman
 
