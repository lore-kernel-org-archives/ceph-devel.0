From: Sage Weil <sage@newdream.net>
Subject: Re: cephfs "obsolescence" and object location
Date: Mon, 6 Jul 2015 14:00:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507061358170.13991@cobra.newdream.net>
References: <55887B9D.4040605@sharerland.com> <55894CE9.6030002@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36575 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbbGFVA1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jul 2015 17:00:27 -0400
In-Reply-To: <55894CE9.6030002@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Bill Sharer <bsharer@sharerland.com>, ceph-devel@vger.kernel.org

On Tue, 23 Jun 2015, John Spray wrote:
> Since you're only looking up the ID of the first object, it's really simple.
> It's just the hex printed inode number followed by ".00000000".  That's not
> guaranteed to always be the case in the future, but it's likely to be true
> longer than the deprecated ioctls exist.  If I was you, I would hard-code the
> object naming convention rather than writing in a dependency on the ioctl.
> 
> As Greg says, you can also query all the layout stuff (via supported
> interfaces) and do the full calculation of object names for arbitrary offsets
> into the file if you need to.

The mapping portion of this seems to come up pretty frequently.  FWIW I 
think the best way to fill that gap is to add a librados call that 
calculates just the mapping, using the librados instance's OSDMap.  That 
way the user doesn't have to worry about fetching and decoding a map (just 
fire up librados), and they can calculate many mappings efficiently.  
If/when they want to ensure a fresh map there is already a librados call 
for that.

sage



> 
> John
> 
> 
> On 22/06/2015 22:18, Bill Sharer wrote:
> > I'm currently running giant on gentoo and was wondering about the stability
> > of the api for mapping MDS files to rados objects.  The cephfs binary
> > complains that it is obsolete for getting layout information, but it also
> > provides object location info.  AFAICT this is the only way to map files in
> > a cephfs filesystem to object locations if I want to take advantage of the
> > "UFO" nature of ceph's stores in order to access via both cephfs and rados
> > methods.
> > 
> > I have a content store that scans files, calculates their sha1hash and then
> > stores them on a cephfs filesystem tree with their filenames set to their
> > sha1hash name.  I can then build views of this content using an external
> > local filesystem and symlinks pointing into the cephfs store.  At the same
> > time, I want to be able to use this store via rados either through the
> > gateway or my own software that is rados aware.  The store is being treated
> > as a write-once, read-many style system.
> > 
> > Towards this end, I started writing a QT4 based library that includes this
> > little Location routine (which currently works) to grab the rados object
> > location from a hash object in this store. I'm just wondering whether this
> > is all going to break horribly in the future when ongoing MDS development
> > decides to break the code I borrowed from cephfs :-)
> > 
> > 
> > 
> > QString Shastore::Location(const QString hash) {
> >     QString result = "";
> >     QString cache_path = this->dbcache + "/" + hash.left(2) + "/" +
> > hash.mid(2,2) + "/" + hash;
> >     QFile cache_file(cache_path);
> >     if (cache_file.exists()) {
> >         if (cache_file.open(QIODevice::ReadOnly)) {
> >             /*
> >              * Ripped from cephfs code, grab the handle and use the ceph
> > version of ioctl to
> >              * rummage through the file's xattrs for rados location.  cephfs
> > whines about being
> >              * obsolete to get layout this way, but this appears to be only
> > way to get location.
> >              * This may all break horribly in a future release since MDS is
> > undergoing heavy development
> >              *
> >              *  cephfs lets user pass file_offset in argv but it defaults to
> > 0.  Presumably this is the "first"
> >              *  extent of the pile of extents (4mb each?) and shards for the
> > file.  If user wants to jump
> >              *  elsewhere with a non-zero offset, the resulting rados object
> > location may be different
> >              */
> >             int fd = cache_file.handle();
> >             struct ceph_ioctl_dataloc location;
> >             location.file_offset = 0;
> >             int err = ioctl(fd, CEPH_IOC_GET_DATALOC, (unsigned
> > long)&location);
> >             if (err) {
> >                 qDebug() << "Location: Error getting rados location for " <<
> > cache_path;
> >             } else {
> >                 result = QString(location.object_name);
> >             }
> >             cache_file.close();
> >         } else {
> >             qDebug() << "Location: unable to open " << cache_path << "
> > readonly";
> >         }
> >     } else {
> >         qDebug() << "Location: cache file " << cache_path << " does not
> > exist";
> >     }
> >     return result;
> > }
> 
> Since you're only looking at
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
