From: Wido den Hollander <wido@widodh.nl>
Subject: Re: [PATCH 0/5 v2] Improve Ceph Qemu+RBD support
Date: Fri, 07 Oct 2011 13:39:50 +0200
Message-ID: <1317987590.3149.5.camel@wido-desktop>
References: <1316492023-17749-1-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:54035 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965366Ab1JGLjz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Oct 2011 07:39:55 -0400
In-Reply-To: <1316492023-17749-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org, veillard@redhat.com

Hi,

On Mon, 2011-09-19 at 21:13 -0700, Sage Weil wrote:
> The current support for qemu and Ceph RBD (rados block device) has two 
> main deficiencies: authentication doesn't work, and it relies on 
> environment variables (which don't work with latest upstream). This 
> patch set addresses both those problems.
> 

Authentication is something that is really needed in the libvirt
implementation of RBD.

The interest in RBD is growing rapidly, but without auth support it's
kind of useless.

Would like to see this implemented!

Wido

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
> 
> Thanks!
> sage
> 
> 
> Changes from v1:
>   update docs/schemas/{domain,secret}.rng
> 
> Sage Weil (5):
>   secret: add Ceph secret type
>   storage: add authId, authDomain to virDomainDiskDef
>   qemu: pass virConnectPtr into Domain{Attach,Detach}*
>   buf: implement generic virBufferEscape
>   qemu/rbd: improve rbd device specification
> 
>  docs/schemas/domain.rng                            |    6 +
>  docs/schemas/secret.rng                            |   17 ++
>  include/libvirt/libvirt.h.in                       |    3 +
>  src/conf/domain_conf.c                             |   43 +++-
>  src/conf/domain_conf.h                             |    2 +
>  src/conf/secret_conf.c                             |   45 ++++-
>  src/conf/secret_conf.h                             |    1 +
>  src/libvirt_private.syms                           |    1 +
>  src/qemu/qemu_command.c                            |  273 +++++++++++---------
>  src/qemu/qemu_command.h                            |    3 +-
>  src/qemu/qemu_driver.c                             |   17 +-
>  src/qemu/qemu_hotplug.c                            |   15 +-
>  src/qemu/qemu_hotplug.h                            |    9 +-
>  src/secret/secret_driver.c                         |    8 +
>  src/util/buf.c                                     |   33 ++-
>  src/util/buf.h                                     |    1 +
>  .../qemuxml2argv-disk-drive-network-rbd.args       |    6 +-
>  .../qemuxml2argv-disk-drive-network-rbd.xml        |    1 +
>  18 files changed, 328 insertions(+), 156 deletions(-)
> 
> -- 
> 1.7.4.1
> 
> >From 498cd06b76bbb4415a2f81f9d169f267ff99329c Mon Sep 17 00:00:00 2001
> From: Sage Weil <sage@newdream.net>
> Date: Thu, 15 Sep 2011 13:47:40 -0700
> Subject: [PATCH 0/5] Improve Ceph Qemu+RBD support
> 
> The current support for qemu and Ceph RBD (rados block device) has two 
> main deficiencies: authentication doesn't work, and it relies on 
> environment variables (which don't work with latest upstream).
> 
> This patch set addresses both those problems, while trying to integrate as
> cleanly as possible with the rest of libvirt.
> 
> The first few patches make some changes to libvirt itself: adding a CEPH 
> secret type (for Ceph/RBD authentication), adding authentication fields 
> to the XML schema, passing the virConnectPtr into the 
> Domain{Attach,Detach} methods (needed to access secrets while building 
> the qemu command), a helper that will escape arbitrary characters, and 
> finally a patch that replaces the current RBD qemu code.
> 
> Comments on this approach?
> 
> Thanks!
> sage
> 
> 
> Sage Weil (5):
>   secret: add Ceph secret type
>   storage: add authId, authDomain to virDomainDiskDef
>   qemu: pass virConnectPtr into Domain{Attach,Detach}*
>   buf: implement generic virBufferEscape
>   qemu/rbd: improve rbd device specification
> 
>  include/libvirt/libvirt.h.in                       |    3 +
>  src/conf/domain_conf.c                             |   43 +++-
>  src/conf/domain_conf.h                             |    2 +
>  src/conf/secret_conf.c                             |   45 ++++-
>  src/conf/secret_conf.h                             |    1 +
>  src/libvirt_private.syms                           |    1 +
>  src/qemu/qemu_command.c                            |  273 +++++++++++---------
>  src/qemu/qemu_command.h                            |    3 +-
>  src/qemu/qemu_driver.c                             |   17 +-
>  src/qemu/qemu_hotplug.c                            |   15 +-
>  src/qemu/qemu_hotplug.h                            |    9 +-
>  src/secret/secret_driver.c                         |    8 +
>  src/util/buf.c                                     |   33 ++-
>  src/util/buf.h                                     |    1 +
>  .../qemuxml2argv-disk-drive-network-rbd.args       |    6 +-
>  .../qemuxml2argv-disk-drive-network-rbd.xml        |    1 +
>  16 files changed, 305 insertions(+), 156 deletions(-)
> 


