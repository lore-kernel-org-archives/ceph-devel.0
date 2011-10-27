From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [RFC PATCH v3 3/4] qemu: pass virConnectPtr into
 Domain{Attach,Detach}*
Date: Thu, 27 Oct 2011 09:33:24 +0100
Message-ID: <20111027083324.GC20878@redhat.com>
References: <cover.1319072460.git.josh.durgin@dreamhost.com>
 <4e26cbcba8e3c97941311abbc172b894626b8f96.1319072460.git.josh.durgin@dreamhost.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57490 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754789Ab1J0IdW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 27 Oct 2011 04:33:22 -0400
Content-Disposition: inline
In-Reply-To: <4e26cbcba8e3c97941311abbc172b894626b8f96.1319072460.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Thu, Oct 20, 2011 at 11:01:26AM -0700, Josh Durgin wrote:
> From: Sage Weil <sage@newdream.net>
> 
> The qemu RBD driver needs access to the conn in order to get the secret
> needed for connecting to the ceph cluster.
> 
> Signed-off-by: Sage Weil <sage@newdream.net>
> ---
>  src/qemu/qemu_command.c |    5 +++--
>  src/qemu/qemu_command.h |    3 ++-
>  src/qemu/qemu_driver.c  |   17 ++++++++---------
>  src/qemu/qemu_hotplug.c |   15 +++++++++------
>  src/qemu/qemu_hotplug.h |    9 ++++++---
>  5 files changed, 28 insertions(+), 21 deletions(-)

Trivial, ACK

Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
