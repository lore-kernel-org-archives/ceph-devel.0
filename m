From: Gregory Farnum <greg@gregs42.com>
Subject: Re: cephfs "obsolescence" and object location
Date: Tue, 23 Jun 2015 12:50:52 +0100
Message-ID: <CAC6JEv8j0tGp-U65=B86jzyu9LWnjKeDjhOJxDZUVxGZbMm4BA@mail.gmail.com>
References: <55887B9D.4040605@sharerland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:34127 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935AbbFWLu4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jun 2015 07:50:56 -0400
Received: by lagx9 with SMTP id x9so4843297lag.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jun 2015 04:50:54 -0700 (PDT)
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com. [209.85.215.54])
        by mx.google.com with ESMTPSA id j2sm5470459lbs.24.2015.06.23.04.50.53
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 04:50:53 -0700 (PDT)
Received: by lacny3 with SMTP id ny3so4802319lac.3
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jun 2015 04:50:52 -0700 (PDT)
In-Reply-To: <55887B9D.4040605@sharerland.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bill Sharer <bsharer@sharerland.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jun 22, 2015 at 10:18 PM, Bill Sharer <bsharer@sharerland.com> wrote:
> I'm currently running giant on gentoo and was wondering about the stability
> of the api for mapping MDS files to rados objects.  The cephfs binary
> complains that it is obsolete for getting layout information, but it also
> provides object location info.  AFAICT this is the only way to map files in
> a cephfs filesystem to object locations if I want to take advantage of the
> "UFO" nature of ceph's stores in order to access via both cephfs and rados
> methods.
>
> I have a content store that scans files, calculates their sha1hash and then
> stores them on a cephfs filesystem tree with their filenames set to their
> sha1hash name.  I can then build views of this content using an external
> local filesystem and symlinks pointing into the cephfs store.  At the same
> time, I want to be able to use this store via rados either through the
> gateway or my own software that is rados aware.  The store is being treated
> as a write-once, read-many style system.
>
> Towards this end, I started writing a QT4 based library that includes this
> little Location routine (which currently works) to grab the rados object
> location from a hash object in this store. I'm just wondering whether this
> is all going to break horribly in the future when ongoing MDS development
> decides to break the code I borrowed from cephfs :-)

I don't know when things will break exactly, but it will probably be
when we remove the ioctl rather than when the MDS stops supporting it.
This particular one is implemented entirely on the client without
talking to the MDS. :)

You can also do this yourself in userspace: get the layout structure
information on the file via the virtual xattrs (ceph.layout, I
believe?). Use that to map to the specific object you're interested in
(you can look at the kernel's fs/ceph/ioctl.c
"ceph_ioctl_get_dataloc()" function, or any of the userspace stuff
that does it). The tricky bit is that finding locations does require
an up-to-date cluster map, but libcephfs will do that for you (and it
looks to me like you really just want object names, not their
locations).
-Greg

>
>
>
> QString Shastore::Location(const QString hash) {
>     QString result = "";
>     QString cache_path = this->dbcache + "/" + hash.left(2) + "/" +
> hash.mid(2,2) + "/" + hash;
>     QFile cache_file(cache_path);
>     if (cache_file.exists()) {
>         if (cache_file.open(QIODevice::ReadOnly)) {
>             /*
>              * Ripped from cephfs code, grab the handle and use the ceph
> version of ioctl to
>              * rummage through the file's xattrs for rados location.  cephfs
> whines about being
>              * obsolete to get layout this way, but this appears to be only
> way to get location.
>              * This may all break horribly in a future release since MDS is
> undergoing heavy development
>              *
>              *  cephfs lets user pass file_offset in argv but it defaults to
> 0.  Presumably this is the "first"
>              *  extent of the pile of extents (4mb each?) and shards for the
> file.  If user wants to jump
>              *  elsewhere with a non-zero offset, the resulting rados object
> location may be different
>              */
>             int fd = cache_file.handle();
>             struct ceph_ioctl_dataloc location;
>             location.file_offset = 0;
>             int err = ioctl(fd, CEPH_IOC_GET_DATALOC, (unsigned
> long)&location);
>             if (err) {
>                 qDebug() << "Location: Error getting rados location for " <<
> cache_path;
>             } else {
>                 result = QString(location.object_name);
>             }
>             cache_file.close();
>         } else {
>             qDebug() << "Location: unable to open " << cache_path << "
> readonly";
>         }
>     } else {
>         qDebug() << "Location: cache file " << cache_path << " does not
> exist";
>     }
>     return result;
> }
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
