From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph block pointer abstractions
Date: Wed, 27 Apr 2011 13:02:19 -0700
Message-ID: <B26DB7AA9C4543B9A97EF1DC7596104B@gmail.com>
References: <BANLkTimWV7QUUa7tQkzLO688XvMYKFKshQ@mail.gmail.com>
 <5C6848CA1E2C4DC09E2F12612C447199@gmail.com>
 <BANLkTiktRZYqpWb9c+=roAuu7GCum9qK8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58913 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab1D0UCW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 16:02:22 -0400
Received: by pvg12 with SMTP id 12so1371127pvg.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Apr 2011 13:02:22 -0700 (PDT)
In-Reply-To: <BANLkTiktRZYqpWb9c+=roAuu7GCum9qK8g@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fabio Kaminski <fabiokaminski@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wednesday, April 27, 2011 at 12:42 PM, Fabio Kaminski wrote:
Ok, thats the way it should be.. :)
> 
> But specializing a little more the question.. whats the data
> partition scheme between nodes, how can a user control it.. block
> level? file level?
> suppose that i have agregations that i want it to stick together in
> nodes... even if replicated in several nodes.. but always together, to
> get network roundtrips diminished..

The posix-compliant Ceph filesystem is built on top of the RADOS object store. RADOS places objects into "placement groups" (PGs), and puts these PGs on OSD storage nodes using a pseudo-random hash algorithm called CRUSH. Generally this is based on the object's name (in Ceph the names are based on inode numbers and which block of the file it is), although if you are using the RADOS libraries to place data you can specify an alternative string to hash on (look at the object_locator_t bits). This is there so that you can place different pieces of data on the same node, but if you use this interface you'll need to be able to provide the object_locator_t every time you access the object.
When using Ceph you don't have access to the object_locator_t method of placing data, but you do have some options. Using either the libraries or the cephfs tool you can specify the preferred PG and/or the pool for a file to be placed in. (You can also use the cephfs tool on a directory, so that its placement settings will apply to that directory's subtree).
Setting the PG will keep data together, and each OSD node has some PGs which are kept local to that OSD whenever it's up if you want local reads/writes (generally these PGs are unused, but they can be valuable for doing things like simulating HDFS behavior). Setting just the pool will let the system properly distribute data, but you can set up the CRUSH map so that the pool always roots at a specific node, or do any of a number of other things to specify how you want the data to be laid out.
Which interface you want to use for keeping data together depends a lot on your exact use case and your skills.

Lastly, I will say this: it is often the case that trying to keep specific data co-located is not actually worth the trouble. You may have such a use-case and it's always good to have tools that support such things, but eg the Hadoop people have discovered that guaranteeing local writes is not actually helpful to performance in most situations. Before going through the hassle of setting up such a thing I'd be very sure that it matters to you and that the default placement is unacceptable.
-Greg



