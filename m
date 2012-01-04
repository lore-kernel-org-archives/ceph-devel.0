From: Wido den Hollander <wido@widodh.nl>
Subject: First work on RBD storage pool support in libvirt
Date: Wed, 04 Jan 2012 20:30:09 +0100
Message-ID: <4F04A8C1.1090205@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:37561 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab2ADTaM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jan 2012 14:30:12 -0500
Received: from [IPv6:2001:7b8:3cb:0:219:d2ff:fec0:b754] (unknown [IPv6:2001:7b8:3cb:0:219:d2ff:fec0:b754])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPA id 8888F3FC11
	for <ceph-devel@vger.kernel.org>; Wed,  4 Jan 2012 20:30:10 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

The last few days I've been working on a storage backend driver for 
libvirt which supports RBD.

This has been in the tracker for a while: 
http://tracker.newdream.net/issues/1422

My current work can be found at: http://www.widodh.nl/git/libvirt.git in 
the 'rbd' branch.

I realize it is far from done, a lot of work has to be done, but I'd 
like to discuss some things first before making some decisions I might 
later regret.

My idea was to discuss it here first and after a few iterations get it 
reviewed by the libvirt guys.

Let me start with the XML:

<pool type='rbd'>
   <name>cephclusterdev</name>
   <source>
	  <name>myrbdpool</name>
     <host name='[2a00:f10:11b:cef0:230:48ff:fed3:b086]' port='6789' 
prefer_ipv6='true'/>
     <auth type='cephx' id='admin' 
secret='a313871d-864a-423c-9765-5374707565e1'/>
   </source>
</pool>

A few things here:

* I'm leaning on the secretDriver from libvirt for storing the actual 
cephx key. Should I also store the id in there or keep that in the pool 
declaration?

* prefer_ipv6? I'm a IPv6 guy, I try to get as much over IPv6 as I can. 
Since Ceph doesn't support dual-stack you have to explicitly enable 
IPv6. I did not want to let librados read a ceph.conf from outside 
libvirt I added this variable. Not the fanciest way I think, but it 
could serve other future storage drivers in libvirt

* How should we pass other configuration options? I want to stay away 
from the ceph.conf as far as possible. Imho a user should be able to 
define a XML and get it all up and running. You will also run into 
apparmor/SELinux on systems, so libvirt won't have permission to read 
files everywhere you want it to. I also thinks the libvirt guys want to 
keep everything as generic as possible. In the future we might see more 
storage backends which have almost the same properties as RBD. How do we 
pass extra config options?


That's the XML file for declaring the pool.

The pool itself uses librados/librbd instead of invoking the 'rbd' command.

The other storage backends do invoke external binaries, but that didn't 
seem the right way here since we have the luxury of C-API's.

I'm aware of the fact that a lot of memory handling and cleaning won't 
be as it should be. I'm fairly new to C, so I'll make mistakes here and 
there.

The current driver is however focused on Qemu/KVM, since that is 
currently the only virtualization technique which supports RBD.

This exposes another problem. Then you do a "dumpxml" it expects a 
target path which is up until now an absolute path to a file or block 
device.

Recently disks with the type 'network' were introduced for Sheepdog and 
RBD, but attaching a 'network' volume to a domain is currently not 
possible with the XML schemes. I'm thinking about a generic way to 
attach network volumes to a domain.

Another feature I'd like to add in the future is managing kernel RBD. We 
could set up RBD for the user and mapping and unmapping devices on 
demand for virtual machines.

The 'rbd' binary does this mapping, but that is done in the binary 
itself and not by librbd. Would it be a smart move to add a map() and 
unmap() method to librbd?

The last thing I'm thinking about is the spare allocation of the RBD 
images. Right now both 'allocation' and 'capacity' are set to the 
virtual size of the RBD image. rbd_stat() does not report the actual 
size of the image, it only reports the virtual size of the image. Is 
there a way to figure out how big a RBD image actually is?


My plan is to add RBD support to CloudStack after the libvirt 
integration has finished. CloudStack heavily relies on the storage pools 
of libvirt, so adding RBD support to CloudStack depends on libvirt.

Feedback is welcome on this!

Thanks,

Wido
