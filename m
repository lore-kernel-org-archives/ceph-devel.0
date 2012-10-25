From: Jonathan Proulx <jon@csail.mit.edu>
Subject: reconfiguring existing hardware for ceph use
Date: Thu, 25 Oct 2012 16:40:45 -0400
Message-ID: <20121025204045.GF23127@csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from outgoing.csail.mit.edu ([128.30.2.149]:46253 "EHLO
	outgoing.csail.mit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760327Ab2JYUyb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 16:54:31 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,

I have 8 servers available to test ceph on which are a bit over
powered/under-disked and I'm trying to develop a plan for how to lay
out services and how to populate the available disk slots.

The hardware is dual socket Intel E5640 chips (8 core total/ node) with 48G
RAM, dual 10G ethernet but only four 3.5" SAS slots (with Fusion-MPT
controller).

Target application is primarily RBD as volume storage backend for
openstack (folsom cinder), and possibly using as object store for
glance.  I'd also like to test CephFS, but don't have a particular
usecase in mind for it.

The openstack cloud this would back end is used for reasearch
computing by a variety of internal research groups and has wildly
unpredictable work loads.  Volume storage use has not been
particularly intensive to date so I don't have a particular
performance point to hit. 

Comparatively the current back end is a single cinder-volume server
bpacing volumes on two software raid6 volumes each backed by 12 2T
nearline SAS drives.  Another option we're evaluating is a Dell
EqualLogic san with a mirrored pair of 16x1T drive raid6 units.

My first though is to populate the test systesm with a single solid
state drive (not sure size or type) to hold the operating system and
journals and three 3T SAS drives of the OSD data filesystems.  Running
3 osd on all nodes (one per data disk), with mon and mds only on the
first 3. 

My second though is to use 3T drives in all slots.  Take the os cut
off the top of each (probably 16G each assmbled as software raid10 for
32G or mirrored space) and run 4 osd per node on the remaining disk
space using internal journals.

Is either more sane than the other? Are both so crazy I should just use
an os disk and three osd disks with internal journals? have any better
suggestions?

Thanks,
-Jon



