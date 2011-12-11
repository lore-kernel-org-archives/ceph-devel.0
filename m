From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] [PATCH] security: don't try to label network disks
Date: Sun, 11 Dec 2011 22:38:26 +0000
Message-ID: <20111211223826.GB2197@redhat.com>
References: <f80b111522e8dc7069ade8d5aacb4d05c2a8fed2.1323488550.git.josh.durgin@dreamhost.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42086 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab1LKWif (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 11 Dec 2011 17:38:35 -0500
Content-Disposition: inline
In-Reply-To: <f80b111522e8dc7069ade8d5aacb4d05c2a8fed2.1323488550.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Fri, Dec 09, 2011 at 07:49:40PM -0800, Josh Durgin wrote:
> Network disks don't have paths to be resolved or files to be checked
> for ownership. ee3efc41e6233e625aa03003bf3127319ccd546f checked this
> for some image label functions, but was partially reverted in a
> refactor.  This finishes adding the check to each security driver's
> set and restore label methods for images.
> 
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> ---
>  src/security/security_apparmor.c |    3 +++
>  src/security/security_dac.c      |    6 ++++++
>  src/security/security_selinux.c  |    3 +++
>  3 files changed, 12 insertions(+), 0 deletions(-)

ACK

Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
