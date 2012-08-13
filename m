From: Gregory Farnum <greg@inktank.com>
Subject: Re: No lock on RBD allow several mount on different servers...
Date: Mon, 13 Aug 2012 09:55:51 -0700
Message-ID: <CAPYLRzhXmwt2AzvmUPZQWeHn75ViFTuCVq5EFwmiG+wV8cjKDQ@mail.gmail.com>
References: <CAOLwVUkWEOdo_HjKRZwU0rGi4S8rA33-o5gCMBJvhJahkrLXpQ@mail.gmail.com>
	<CALFpzo49Urnf8rnFCQ=wQ8eFMR0-8FWh2=9nKrCAxb+0Xm0rVQ@mail.gmail.com>
	<CAOLwVUnSUpAC69W48gbz-+7L7+p9z5tioODh_hPwVEt39GDvHw@mail.gmail.com>
	<CALFpzo4X7iL6aEUtqyEBp4AMDxKkK9wtwPx35WQVauYQbe8Hng@mail.gmail.com>
	<CALFpzo4up8oqKNESWDzm2AVpZ0Z5WyB5PQX-8Cu2+Sga7i=zbQ@mail.gmail.com>
	<CALFpzo7YicrNh8qCoTAe2hUU+onkci8PbggKWfUjn1TJ635HUw@mail.gmail.com>
	<06A44B2B-FA7F-418C-B9D2-D0602F4EB95B@gmail.com>
	<alpine.DEB.2.00.1208120825320.19162@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45908 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab2HMQzw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Aug 2012 12:55:52 -0400
Received: by lbbgj3 with SMTP id gj3so1451526lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 13 Aug 2012 09:55:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208120825320.19162@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <josh.durgin@inktank.com>
Cc: Sebastien HAN <han.sebastien@gmail.com>, Marcus Sorensen <shadowsor@gmail.com>

We've discussed some of the issues here a little bit before. See
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/7094 if
you're interested.

Josh, can you discuss the current status of the advisory locking?
-Greg

On Sun, Aug 12, 2012 at 8:44 AM, Sage Weil <sage@inktank.com> wrote:
> RBD image locking is on roadmap, but it's tricky.  Almost all of the
> pieces are in place for exclusive locking of the image header, which will
> let the user know when other nodes have the image mapped, and give them
> the option to break their lock and take over ownership.
>
> The real challenge is fencing.  Unlike move conventional options like
> SCSI, the RBD image is distributed across the entire cluster, so ensuring
> that the old guy doesn't still have IOs in flight that will stomp on the
> new owner means that potentially everyone needs to be informed that the
> bad guy should be locked out.
>
> I think there are a few options:
>
> 1- The user has their own fencing or STOGITH on top of rbd, informed by
>    the rbd locking.  Pull the plug, update your iptables, whatever.  Not
>    very friendly.
> 2- Extend the rados 'blacklist' functionality to let you ensure that every
>    node in the cluster has received the updated osdmap+blacklist
>    information, so that you can be sure no further IO from the old guy is
>    possible.
> 3- Use the same approach that ceph-mds fencing uses, in which the old
>    owner isn't known to be fenced away from a particular object until the
>    new owner reads/touches that object.
>
> My hope is that we can get away with #3, in which case all of the basic
> pieces are in place and the real remaining work is integration and
> testing.  The logic goes something like this:
>
> File systems write to blocks on disk in a somewhat ordered fashion.
> After writing a bunch of data, they approach a 'consistency point' where
> their journal and/or superblocks must be flushed and things 'commit' to
> disk.  At that point, if the IO fails or blocks, it won't continue to
> clobber other parts of the disk.
>
> When an fs in mounted, those same critical areas are read (superblock,
> journal, etc.).  The existing client/osd interaction ensures that if
> the new guy knows that the old guy is fenced, the act of reading
> ensures that the relevant ceph-osds will find out too and that
> paticular object will be fenced.
>
> The resulting conclusion is that if a file system (or application on top
> of it doing direct io) is sufficiently well-behaved that will be not
> corrupt itself when the disk reorders IOs (they do) and issues
> barrier/flush operations at the appropriate time (in modern kernels, they
> do), then it will work.
>
> I suppose it's roughly analogous to Schroedinger's cat: until the new
> owner reads a block, it may or may not still be modified/modifiable by the
> old guy, but as soon as it is observed, its state is known.
>
> What do you guys think?  If that doesn't work, I think we're stuck with
> #2, which is expensive but doable.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
