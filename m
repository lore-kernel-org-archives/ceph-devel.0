From: Sage Weil <sage@newdream.net>
Subject: Re: [libvirt] specifying rbd images in libvirt
Date: Wed, 7 Sep 2011 16:54:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109071635040.13143@cobra.newdream.net>
References: <Pine.LNX.4.64.1108271207100.14206@cobra.newdream.net>
 <20110901124635.GD14462@redhat.com> <Pine.LNX.4.64.1109011321420.1621@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39914 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756647Ab1IGXtF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Sep 2011 19:49:05 -0400
In-Reply-To: <Pine.LNX.4.64.1109011321420.1621@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Thu, 1 Sep 2011, Sage Weil wrote:
> On Thu, 1 Sep 2011, Daniel P. Berrange wrote:
> > On Sat, Aug 27, 2011 at 12:19:33PM -0700, Sage Weil wrote:
> > > Hi all,
> > > 
> > > Currently, you can specify an rbd (or nbd, sheepdog) image with xml 
> > > that looks like so:
> > > 
> > >     <disk type='network' device='disk'>
> > >       <driver name='qemu' type='raw' cache='writeback'/>
> > >       <source protocol='rbd' name='mypool/myimage'>
> > >         <host name='monhost1.mydomain.com' port='6789'/>
> > >         <host name='monhost2.mydomain.com' port='6789'/>
> > >         <host name='monhost3.mydomain.com' port='6789'/>
> > >       </source>
> > >       <target dev='vda' bus='virtio'/>
> > >     </disk>
> > > 
> > > This works okay if you have authentication disabled and all of the default 
> > > settings are okay.  Usually, though, there are other options you need to 
> > > specify to librbd to make it do what you want.  
> > > 
> > > The current schema can be abused by adding options after the image name 
> > > like so:
> > > 
> > >     <disk type='network' device='disk'>
> > >       <driver name='qemu' type='raw' cache='writeback'/>
> > >       <source protocol='rbd' name='mypool/myimage:conf=/etc/ceph/ceph.conf:id=admin:this=that:foo=bar'>
> > >         <host name='monhost1.mydomain.com' port='6789'/>
> > >         <host name='monhost2.mydomain.com' port='6789'/>
> > >         <host name='monhost3.mydomain.com' port='6789'/>
> > >       </source>
> > >       <target dev='vda' bus='virtio'/>
> > >     </disk>
> > > 
> > > This works only because that's what the qemu incantation looks like.  In 
> > > general, though, this is ugly.  I also doesn't generalize well to the 
> > > kernel-level rbd driver, which we'd like to also support, as that will 
> > > work with hypervisors other than qemu.
> > 
> > Also, we should be doing some validation on the content of
> > the 'name' attribute to prevent abuse like that.
> > 
> > > What about something more like this?
> > > 
> > >     <disk type='network' device='disk'>
> > >       <driver name='qemu' type='raw' cache='writeback'/>
> > >       <source protocol='rbd' name='mypool/myimage'>
> > >         <option name='conf'>/etc/ceph/ceph.conf</option>
> > >         <option name='id'>myusername</option>
> > >         <option name='foo'>bar</option>
> > >         <host name='monhost1.mydomain.com' port='6789'/>
> > >         <host name='monhost2.mydomain.com' port='6789'/>
> > >         <host name='monhost3.mydomain.com' port='6789'/>
> > >       </source>
> > >       <target dev='vda' bus='virtio'/>
> > >     </disk>
> > > 
> > > I'm not married to any particular syntax/schema, as long as there is a 
> > > generic way to specify name/value pairs to configure the driver.  I think 
> > > the above would generalize well to other network block devices as well, 
> > > which presumably also want a way to feed in information other than a 
> > > server address (e.g. for authentication).
> > > 
> > > Does that look reasonable?  If there are no objections we can work up some 
> > > patches and send them along!
> > 
> > We generally prefer to add explicit models for attributes, rather than
> > just do a generic key/value passthrough.
> 
> Fair enough.  For the qemu/librbd and kernel drivers, the key fields we 
> need are:
> 
>  id - ceph userid to authenticate as
>  snap - snapshot name (optional; used if mapping a read-only snapshot)
> 
> The goal would be to have libvirt describe rbd images in a generic way, 
> and let you managed them as a storage pool via librbd.  Then, when it 
> comes time to spin up an actual VM, either use the native qemu support or 
> map a kernel block device.  To control that it might make sense to have an 
> option like
> 
>  driver - librbd (qemu-only), kernel, or auto (default)
> 
> to let users control which driver to use in the qemu case.
> 
> > For authentication credentials, we also need to consider security
> > implications of keeping them in the XML. For qcow2 encryption
> > keys, we leverage the separate libvirt secrets management APIs
> > to provide the keys outside the XML. IMHO we should likely do the
> > same for any keys required to login to network block devices.
> 
> Usually we keep secrets in a file on disk and reference the file when 
> starting up librbd or mapping a kernel rbd device.  It's possible to 
> specify it explicitly but that is discouraged.  So by specifying id=foo 
> above, librbd would normally look for a key called foo in its default 
> keyring file.
> 
> We can definitely use the libvirt secrets API to store these keys there, 
> too.  In that case, we would need something like
> 
>  keyname - name of the libvirt secret to use for authentication
> 
> What do you think?

Shall I take silence as general agreement and start putting together 
patches?

I don't think there's anything controversial here.  I suspect the main 
concern is that these fields are named in a sufficiently general fashion 
so that they can be used for other backend storage types.

sage
