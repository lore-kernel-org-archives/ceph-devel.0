From: Sage Weil <sage@newdream.net>
Subject: rbd storage pool support for libvirt
Date: Mon, 1 Nov 2010 20:52:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1011012051190.28156@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52074 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab0KBDsi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Nov 2010 23:48:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org

Hi,

We've been working on RBD, a distributed block device backed by the Ceph 
distributed object store.  (Ceph is a highly scalable, fault tolerant 
distributed storage and file system; see http://ceph.newdream.net.)  
Although the Ceph file system client has been in Linux since 2.6.34, the 
RBD block device was just merged for 2.6.37.  We also have patches pending 
for Qemu that use librados to natively talk to the Ceph storage backend, 
avoiding any kernel dependency.

To support disks backed by RBD in libvirt, we originally proposed a 
'virtual' type that simply passed the configuration information through to 
qemu, but that idea was shot down for a variety of reasons:

	http://www.redhat.com/archives/libvir-list/2010-June/thread.html#00257

It sounds like the "right" approach is to create a storage pool type.  
Ceph also has a 'pool' concept that contains some number of RBD images and 
a command line tool to manipulate (create, destroy, resize, rename, 
snapshot, etc.) those images, which seems to map nicely onto the storage 
pool abstraction.  For example,

 $ rbd create foo -s 1000
 rbd image 'foo':
         size 1000 MB in 250 objects
         order 22 (4096 KB objects)
 adding rbd image to directory...
  creating rbd image...
 done.
 $ rbd create bar -s 10000
 [...]
 $ rbd list
 bar
 foo

Something along the lines of

 <pool type="rbd">
   <name>virtimages</name>
   <source mode="kernel">
     <host monitor="ceph-mon1.domain.com:6789"/>
     <host monitor="ceph-mon2.domain.com:6789"/>
     <host monitor="ceph-mon3.domain.com:6789"/>
     <pool name="rbd"/>
   </source>
 </pool>

or whatever (I'm not too familiar with the libvirt schema)?  One 
difference between the existing pool types listed at 
libvirt.org/storage.html is that RBD does not necessarily associate itself 
with a path in the local file system.  If the native qemu driver is used, 
there is no path involved, just a magic string passed to qemu 
(rbd:poolname/imagename).  If the kernel RBD driver is used, it gets 
mapped to a /dev/rbd/$n (or similar, depending on the udev rule), but $n 
is not static across reboots.

In any case, before someone goes off and implements something, does this 
look like the right general approach to adding rbd support to libvirt?

Thanks!
sage

