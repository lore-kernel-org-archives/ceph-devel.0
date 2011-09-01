From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] specifying rbd images in libvirt
Date: Thu, 1 Sep 2011 13:46:35 +0100
Message-ID: <20110901124635.GD14462@redhat.com>
References: <Pine.LNX.4.64.1108271207100.14206@cobra.newdream.net>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63522 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757370Ab1IAMqn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 1 Sep 2011 08:46:43 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1108271207100.14206@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Sat, Aug 27, 2011 at 12:19:33PM -0700, Sage Weil wrote:
> Hi all,
> 
> Currently, you can specify an rbd (or nbd, sheepdog) image with xml 
> that looks like so:
> 
>     <disk type='network' device='disk'>
>       <driver name='qemu' type='raw' cache='writeback'/>
>       <source protocol='rbd' name='mypool/myimage'>
>         <host name='monhost1.mydomain.com' port='6789'/>
>         <host name='monhost2.mydomain.com' port='6789'/>
>         <host name='monhost3.mydomain.com' port='6789'/>
>       </source>
>       <target dev='vda' bus='virtio'/>
>     </disk>
> 
> This works okay if you have authentication disabled and all of the default 
> settings are okay.  Usually, though, there are other options you need to 
> specify to librbd to make it do what you want.  
> 
> The current schema can be abused by adding options after the image name 
> like so:
> 
>     <disk type='network' device='disk'>
>       <driver name='qemu' type='raw' cache='writeback'/>
>       <source protocol='rbd' name='mypool/myimage:conf=/etc/ceph/ceph.conf:id=admin:this=that:foo=bar'>
>         <host name='monhost1.mydomain.com' port='6789'/>
>         <host name='monhost2.mydomain.com' port='6789'/>
>         <host name='monhost3.mydomain.com' port='6789'/>
>       </source>
>       <target dev='vda' bus='virtio'/>
>     </disk>
> 
> This works only because that's what the qemu incantation looks like.  In 
> general, though, this is ugly.  I also doesn't generalize well to the 
> kernel-level rbd driver, which we'd like to also support, as that will 
> work with hypervisors other than qemu.

Also, we should be doing some validation on the content of
the 'name' attribute to prevent abuse like that.

> What about something more like this?
> 
>     <disk type='network' device='disk'>
>       <driver name='qemu' type='raw' cache='writeback'/>
>       <source protocol='rbd' name='mypool/myimage'>
>         <option name='conf'>/etc/ceph/ceph.conf</option>
>         <option name='id'>myusername</option>
>         <option name='foo'>bar</option>
>         <host name='monhost1.mydomain.com' port='6789'/>
>         <host name='monhost2.mydomain.com' port='6789'/>
>         <host name='monhost3.mydomain.com' port='6789'/>
>       </source>
>       <target dev='vda' bus='virtio'/>
>     </disk>
> 
> I'm not married to any particular syntax/schema, as long as there is a 
> generic way to specify name/value pairs to configure the driver.  I think 
> the above would generalize well to other network block devices as well, 
> which presumably also want a way to feed in information other than a 
> server address (e.g. for authentication).
> 
> Does that look reasonable?  If there are no objections we can work up some 
> patches and send them along!

We generally prefer to add explicit models for attributes, rather than
just do a generic key/value passthrough.

For authentication credentials, we also need to consider security
implications of keeping them in the XML. For qcow2 encryption
keys, we leverage the separate libvirt secrets management APIs
to provide the keys outside the XML. IMHO we should likely do the
same for any keys required to login to network block devices.


Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
