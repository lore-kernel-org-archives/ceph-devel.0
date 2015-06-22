From: Bill Sharer <bsharer@sharerland.com>
Subject: cephfs "obsolescence" and object location
Date: Mon, 22 Jun 2015 17:18:21 -0400
Message-ID: <55887B9D.4040605@sharerland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from static-72-66-110-237.washdc.fios.verizon.net ([72.66.110.237]:48237
	"EHLO refurb.sharerland.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752840AbbFVVYI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Jun 2015 17:24:08 -0400
Received: from [192.168.11.13] (thufir.sharerland.com [192.168.11.13])
	by refurb.sharerland.com (Postfix) with ESMTP id 34F469E029B
	for <ceph-devel@vger.kernel.org>; Mon, 22 Jun 2015 17:18:21 -0400 (EDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm currently running giant on gentoo and was wondering about the 
stability of the api for mapping MDS files to rados objects.  The cephfs 
binary complains that it is obsolete for getting layout information, but 
it also provides object location info.  AFAICT this is the only way to 
map files in a cephfs filesystem to object locations if I want to take 
advantage of the "UFO" nature of ceph's stores in order to access via 
both cephfs and rados methods.

I have a content store that scans files, calculates their sha1hash and 
then stores them on a cephfs filesystem tree with their filenames set to 
their sha1hash name.  I can then build views of this content using an 
external local filesystem and symlinks pointing into the cephfs store.  
At the same time, I want to be able to use this store via rados either 
through the gateway or my own software that is rados aware.  The store 
is being treated as a write-once, read-many style system.

Towards this end, I started writing a QT4 based library that includes 
this little Location routine (which currently works) to grab the rados 
object location from a hash object in this store. I'm just wondering 
whether this is all going to break horribly in the future when ongoing 
MDS development decides to break the code I borrowed from cephfs :-)



QString Shastore::Location(const QString hash) {
     QString result = "";
     QString cache_path = this->dbcache + "/" + hash.left(2) + "/" + 
hash.mid(2,2) + "/" + hash;
     QFile cache_file(cache_path);
     if (cache_file.exists()) {
         if (cache_file.open(QIODevice::ReadOnly)) {
             /*
              * Ripped from cephfs code, grab the handle and use the 
ceph version of ioctl to
              * rummage through the file's xattrs for rados location.  
cephfs whines about being
              * obsolete to get layout this way, but this appears to be 
only way to get location.
              * This may all break horribly in a future release since 
MDS is undergoing heavy development
              *
              *  cephfs lets user pass file_offset in argv but it 
defaults to 0.  Presumably this is the "first"
              *  extent of the pile of extents (4mb each?) and shards 
for the file.  If user wants to jump
              *  elsewhere with a non-zero offset, the resulting rados 
object location may be different
              */
             int fd = cache_file.handle();
             struct ceph_ioctl_dataloc location;
             location.file_offset = 0;
             int err = ioctl(fd, CEPH_IOC_GET_DATALOC, (unsigned 
long)&location);
             if (err) {
                 qDebug() << "Location: Error getting rados location for 
" << cache_path;
             } else {
                 result = QString(location.object_name);
             }
             cache_file.close();
         } else {
             qDebug() << "Location: unable to open " << cache_path << " 
readonly";
         }
     } else {
         qDebug() << "Location: cache file " << cache_path << " does not 
exist";
     }
     return result;
}

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
