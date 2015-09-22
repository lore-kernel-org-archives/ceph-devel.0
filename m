From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: RBD mirroring CLI proposal ...
Date: Tue, 22 Sep 2015 12:28:50 +0300
Message-ID: <20150922092847.GA13767@gmail.com>
References: <604040155.31290870.1442846770290.JavaMail.zimbra@redhat.com>
 <189900515.31291453.1442846891314.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37900 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756537AbbIVJ2x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Sep 2015 05:28:53 -0400
Received: by wiclk2 with SMTP id lk2so14451837wic.1
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2015 02:28:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <189900515.31291453.1442846891314.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Sep 21, 2015 at 10:48:11AM -0400, Jason Dillaman wrote:
> The following describes a set of proposals to support the upcoming RBD mirroring feature [1] via the rbd cli.    The RBD mirroring feature will utilize a journal to allow modifications from a primary source to be replicated to one or more backup destinations. 
> 
> To keep configuration simple (no need for synchronizing mirroring metadata), RBD mirroring will be configured on a per-pool basis within a (conceptional) availability zone. For a given image, each zone will have a copy of the image and a journal.  When mirroring is enabled on an image (either at creation due to the default pool settings to explicitly via the rbd CLI), the image's journal will automatically register the known peer clusters.  If a peer is added or rebuilt after mirroring is enabled, the peer will be registered with the image and the RBD mirroring daemon on the remote peer will then be responsible for snapshotting the image, transferring the base image, deleting the snapshot, and starting journal replay.
> 
> A mirrored image can have the following state: primary, secondary (consistent), and secondary (inconsistent).  The images will also track an epoch associated with the primary state for
> detecting when a secondary is now inconsistent due to a failover event. Any modification (IO writes, resize, snap create, etc) to a mirrored image will result in its status being automatically updated to primary.  Inconsistent secondary images will disallow any modifications.
> 
> Proposed CLI Updates
> 
> To configure basic journaling support for an RBD image:
> 
> * rbd feature enable <image-spec> journaling
>                 [--journal-object-pool <pool-name>]
>                 [--journal-splay-width <num>]
>                 [--journal-object-size <B/K/M>]
>                 [--journal-additional-tweakable-settings]
>         This will enable the RBD journaling feature bit.  A new journal will be
>         created using default settings if not overridden.  
> 
> * rbd feature disable <image-spec> journaling
>         This will disable the RBD journaling feature bit. If there are associated RBD
>         mirroring peers connected to this image's journal, this will fail if the mirror
>         doesn't detach within a timeout.  If the image is not attached to a consistency
>         group, the journal will be automatically deleted.
> 
> To configure consistency groups:
> 
> * rbd consistency-group create <group-spec>
>                 [--object-pool <pool-name>]
>                 [--splay-width <num>]
>                 [--object-size <B/K/M>]
>                 [--additional-journal-tweakable-settings]
>         This will create an empty journal for use with consistency groups (i.e. attaching
>         multiple RBD images to the same journal to ensure consistent replay).

For 'rbd feature' commands the option names have "journal" prefix
(--journal-object-pool), while for 'rbd consistency-group' they
don't. Is it intentional? I would prefer having "journal" prefix for
both.

> 
> * rbd consistency-group rename <group-spec>

s/rename/remove/ ?

>         This will remove the named consistency group journal.  If one or more images
>         are attached, this will fail.
> 
> * rbd consistency-group attach <image-spec> <journal-spec>
>         This will enable the RBD journaling feature bit and will configure the image to
>         record all journal entries to the specified journal.  If journaling is already
>         enabled on the image, this will fail.
> 
> * rbd consistency-group detach <image-spec>
>         This will detach the specified image from its journal and disable the RBD
>         journaling feature. 
> 
> * rbd consistency-group ls
>         This will list all consistency groups within the current pool.
> 
> * rbd consistency-group info <group-spec>
>         This will display information about the specified consistent group
> 
> where <group-spec> is [<pool-name>/]<group-name>

Is a consistency-group just a journal (usually used for several images)
or is it something more? If I enable journaling feature for an image,
journal is automatically created, is it already a consistency-group?

> 
> To configure mirroring support for an RBD image:
> 
> * rbd feature enable <image-spec> mirroring
>         This will enable mirroring for an existing image if it wasn't auto-enabled
>         by the default pool policy.
> 
> * rbd feature disable <image-spec> mirroring
>         This will disable mirroring for a specific image if enabled manually or
>         automatically via the default pool policy.
>         
> * rbd mirror pool enable <pool-name>
>         This will, by default, ensure that all images created in this
>         pool have exclusive lock, journaling, and mirroring feature bits
>         enabled.
> 
> * rbd mirror pool disable <pool-name>
>         This will clear the default image features for new images in this
>         pool.

Will 'rbd mirror pool enable|disable' change behaviour only for newly
created images in the pool or will enable|disable mirroring for
existent images too?

> 
> * rbd mirror pool add <remote-pool-spec>
>         This will register a remote cluster/pool as a peer to the current,
>         local pool.  All existing mirrored images and all future mirrored
>         images will have this peer registered as a journal client.
>         
> * rbd mirror pool remove <remote-pool-spec>
>         This will deregister a remote cluster/pool as a peer to the current,
>         local pool.  All existing mirrored images will have the remote
>         deregistered from image journals.

In remote-pool-spec, if it is "cluster/pool", where it is expected to
find configuration for the cluster "cluster"? In /etc/ceph/cluster.conf?

> 
> * rbd mirror pool info
>          This will show the current status of pool mirroring (if newly created
>          images automatically have mirroring enabled) and will list any
>          registered remote clusters/pools.
> 
> * rbd mirror image enable <image-spec>
>         This is an alias for 'rbd feature enable mirroring'
> 
> * rbd mirror image disable <image-spec>
>         This is an alias for 'rbd feature disable mirroring'
> 
> * rbd mirror image resync <image-spec>
>         This will delete the local image and initiate a full resync
>         with a remote primary image.  This can be used to fix an
>         inconsistent secondary image.
> 
> where <pool-spec> is [<cluster name>/]<pool name>
> 
> To verify the operational status of mirroring for a given image:
> 
> * rbd status <image-spec>
>         This command currently only shows the current watchers for the
>         image. This will be expanded to include mirroring status.
> 
> To manage journals:
> 
> * rbd journal info <journal-spec>
>         This will display information about the specified journal
> 
> * rbd journal inspect <journal-spec>
>         This will inspect the journal for structural errors
> 
> * rbd journal export <journal-spec> <dest>
>         This will export the journal entries into JSON
> 
> * rbd journal import <src> <journal-spec>
>         This will import the JSON-formated journal
> 
> * rbd journal reset
>         This will delete all entries from the journal
> 
> where <journal-spec> is [<pool name>/]journal name


Apart from the list of new commands, it would be very helpful to see
typical use case examples. Are my examples below correct?

Enable mirroring for pool "volumes", using pool "journals" for journal
objects:

  rbd mirror pool enable volumes --journal-object-pool journals

Start mirroring to the remote cluster ceph-remote:

  Specify the remote cluster configuration in
  /etc/ceph/ceph-remote.conf

  rbd mirror pool add ceph-remote/volumes

  Start RBD mirroring daemon on the remote cluster. Both clusters
  should be specified in config or via command line parameters. No
  need to specify mirroring pools, I suppose?

To configure a consistency group cgroup1 for images volume1 and
volume2 in pool volumes:

  rbd consistency-group create volume/cgroup1 --object-pool journals
  rbd consistency-group attach volume/volume1 volume/cgroup1
  rbd consistency-group attach volume/volume2 volume/cgroup1

I guess before attaching I will need to disable journaling for volumes
(because it was automatically enabled previously with 'rbd mirror pool
enable')? Will it automatically enable mirroring feature for the
attached images?

> 
> -- 
> 
> Jason Dillaman 
> 
> [1] http://tracker.ceph.com/projects/ceph/wiki/RBD_Async_Mirroring
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Mykola Golub
