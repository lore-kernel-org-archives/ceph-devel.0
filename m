From: Sage Weil <sage@newdream.net>
Subject: specifying rbd images in libvirt
Date: Sat, 27 Aug 2011 12:19:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108271207100.14206@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34888 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab1H0TO0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Aug 2011 15:14:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org

Hi all,

Currently, you can specify an rbd (or nbd, sheepdog) image with xml 
that looks like so:

    <disk type='network' device='disk'>
      <driver name='qemu' type='raw' cache='writeback'/>
      <source protocol='rbd' name='mypool/myimage'>
        <host name='monhost1.mydomain.com' port='6789'/>
        <host name='monhost2.mydomain.com' port='6789'/>
        <host name='monhost3.mydomain.com' port='6789'/>
      </source>
      <target dev='vda' bus='virtio'/>
    </disk>

This works okay if you have authentication disabled and all of the default 
settings are okay.  Usually, though, there are other options you need to 
specify to librbd to make it do what you want.  

The current schema can be abused by adding options after the image name 
like so:

    <disk type='network' device='disk'>
      <driver name='qemu' type='raw' cache='writeback'/>
      <source protocol='rbd' name='mypool/myimage:conf=/etc/ceph/ceph.conf:id=admin:this=that:foo=bar'>
        <host name='monhost1.mydomain.com' port='6789'/>
        <host name='monhost2.mydomain.com' port='6789'/>
        <host name='monhost3.mydomain.com' port='6789'/>
      </source>
      <target dev='vda' bus='virtio'/>
    </disk>

This works only because that's what the qemu incantation looks like.  In 
general, though, this is ugly.  I also doesn't generalize well to the 
kernel-level rbd driver, which we'd like to also support, as that will 
work with hypervisors other than qemu.

What about something more like this?

    <disk type='network' device='disk'>
      <driver name='qemu' type='raw' cache='writeback'/>
      <source protocol='rbd' name='mypool/myimage'>
        <option name='conf'>/etc/ceph/ceph.conf</option>
        <option name='id'>myusername</option>
        <option name='foo'>bar</option>
        <host name='monhost1.mydomain.com' port='6789'/>
        <host name='monhost2.mydomain.com' port='6789'/>
        <host name='monhost3.mydomain.com' port='6789'/>
      </source>
      <target dev='vda' bus='virtio'/>
    </disk>

I'm not married to any particular syntax/schema, as long as there is a 
generic way to specify name/value pairs to configure the driver.  I think 
the above would generalize well to other network block devices as well, 
which presumably also want a way to feed in information other than a 
server address (e.g. for authentication).

Does that look reasonable?  If there are no objections we can work up some 
patches and send them along!

Thanks-
sage
