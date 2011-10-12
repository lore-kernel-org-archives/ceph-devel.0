From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] [PATCH 0/5 v2] Improve Ceph Qemu+RBD support
Date: Wed, 12 Oct 2011 17:33:18 +0100
Message-ID: <20111012163318.GA3444@redhat.com>
References: <1316492023-17749-1-git-send-email-sage@newdream.net>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26831 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab1JLQdb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 12 Oct 2011 12:33:31 -0400
Content-Disposition: inline
In-Reply-To: <1316492023-17749-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Mon, Sep 19, 2011 at 09:13:38PM -0700, Sage Weil wrote:
> The current support for qemu and Ceph RBD (rados block device) has two 
> main deficiencies: authentication doesn't work, and it relies on 
> environment variables (which don't work with latest upstream). This 
> patch set addresses both those problems.
> 
> The first two patches update the xml schemas and conf to add a Ceph 
> secret type and to specify authentication information along with the rbd 
> disk.
>
> The next two patches make some libvirt changes.  We pass virConnectPtr 
> down into the Domain{Attach,Detach} methods (needed to access secrets 
> while building the qemu command), and add a helper that will escape 
> arbitrary characters.
> 
> The final patch replaces the current RBD qemu code and uses the new conf 
> info to do authentication properly.  (We still need to make a change 
> there to avoid having the authentication key show up on qemu command 
> line; I'll clean that up shortly.)
> 
> Comments on this approach?

Ok, I've finally got myself a Ceph cluster up & running, with RBD
exports to a QEMU guest[1], so I can give more sensible answers to
these patches :-)


Overall you are taking the current XML for a disk:

  <disk type='network' device='disk'>
    <driver name='qemu' type='raw'/>
    <source protocol='rbd' name='demo/wibble'>
      <host name='lettuce.example.org' port='6798'/>
      <host name='mustard.example.org' port='6798'/>
      <host name='avocado.example.org' port='6798'/>
    </source>
    <target dev='vdb' bus='virtio'/>
  </disk>

and adding one new element <auth> such that we get

  <disk type='network' device='disk'>
    <driver name='qemu' type='raw'/>
    <source protocol='rbd' name='demo/wibble'>
      <auth id='admin' domain='clustername'/>
      <host name='lettuce.example.org' port='6798'/>
      <host name='mustard.example.org' port='6798'/>
      <host name='avocado.example.org' port='6798'/>
    </source>
    <target dev='vdb' bus='virtio'/>
  </disk>

together with some secret XML that looks like:

  <secret ephemeral='no' private='no'>
    <uuid>0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f</uuid>
    <usage type='ceph'>
      <auth id='admin' domain='clustername'/>
    </usage>
  </secret>

When starting a guest the auth id + domain are concatenated to find
the secret. The 'id' is also used as the username to pass to QEMU.
The 'domain' is only ever used for the secret lookup part, never
passed to QEMU, since the host IP addrs do that job.

By comparison, QCow2 encryption disks are done with:

  <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/home/berrange/VirtualMachines/demo.qcow2'/>
      <target dev='hda' bus='ide'/>
      <encryption format='qcow'>
        <secret type='passphrase' uuid='0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f'/>
      </encryption>
  </disk>

And the secret with:

  <secret ephemeral='no' private='no'>
    <uuid>0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f</uuid>
    <usage type='volume'>
      <volume>/home/berrange/VirtualMachines/demo.qcow2</volume>
    </usage>
  </secret>

When starting a guest, the secret UUID is used to find the passphrase.


So we have a difference in the way the secrets are linked to the disks
between Ceph and QCow2 here.

I can see the appeal of doing it the way you have, but at the same time
I would like to have consistency with the QCow2 approach, and UUIDs are
a stronger identifier IMHO.

Also, although the secret XML is exposed auth id + domain as separate
attributes in the XML, internally they're processed as a concatenated
string, likewise the public API uses a concatenated string form. So
I think the XML ought to use that form too, and not split them.

Finally, I think the concept of authentication credentials for
disks, could be more generally useful than just for Ceph or other
network block devs, so I'm somewhat inclined to move it outside the
<source> element


Thus I would propose a slight variation on what you've done:

  <disk type='network' device='disk'>
    <driver name='qemu' type='raw'/>
    <auth username='admin'>
       <secret type='passphrase' uuid='0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f'/>
    </auth>
    <source protocol='rbd' name='demo/wibble'>
      <host name='lettuce.example.org' port='6798'/>
      <host name='mustard.example.org' port='6798'/>
      <host name='avocado.example.org' port='6798'/>
    </source>
    <target dev='vdb' bus='virtio'/>
  </disk>


And in the secret XML:

  <secret ephemeral='no' private='no'>
    <uuid>0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f</uuid>
    <usage type='ceph'>
      <domain>some.cluster.name/admin</domain>
    </usage>
  </secret>


Though I think the UUID based lookup should be primary, I would also
accept an optional alternate syntax based on usage strings, if you
think that's important:

  <disk type='network' device='disk'>
    <driver name='qemu' type='raw'/>
    <auth username='admin'>
       <secret type='passphrase' usage='some.cluster.name/admin'/>
    </auth>
    <source protocol='rbd' name='demo/wibble'>
      <host name='lettuce.example.org' port='6798'/>
      <host name='mustard.example.org' port='6798'/>
      <host name='avocado.example.org' port='6798'/>
    </source>
    <target dev='vdb' bus='virtio'/>
  </disk>


Regards,
Daniel

[1] http://berrange.com/posts/2011/10/12/setting-up-a-ceph-cluster-and-exporting-a-rbd-volume-to-a-kvm-guest/
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
