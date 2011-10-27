From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [RFC PATCH v3 1/4] secret: add Ceph secret type
Date: Thu, 27 Oct 2011 09:28:45 +0100
Message-ID: <20111027082845.GA20878@redhat.com>
References: <cover.1319072460.git.josh.durgin@dreamhost.com>
 <539f3129dfd5d3f80a06837b63dfc5d355f1acc8.1319072460.git.josh.durgin@dreamhost.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12526 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753661Ab1J0I2n (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 27 Oct 2011 04:28:43 -0400
Content-Disposition: inline
In-Reply-To: <539f3129dfd5d3f80a06837b63dfc5d355f1acc8.1319072460.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Thu, Oct 20, 2011 at 11:01:24AM -0700, Josh Durgin wrote:
> From: Sage Weil <sage@newdream.net>
> 
> Add a new secret type to store a Ceph authentication key. The name
> is simply an identifier for easy human reference.
> 
> The xml looks like this:
> 
> <secret ephemeral='no' private='no'>
>   <uuid>0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f</uuid>
>   <usage type='ceph'>
>     <name>mycluster_admin</name>
>   </usage>
> </secret>
> 
> Signed-off-by: Sage Weil <sage@newdream.net>
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> ---
>  docs/schemas/secret.rng      |   10 ++++++++++
>  include/libvirt/libvirt.h.in |    3 +++
>  src/conf/secret_conf.c       |   23 ++++++++++++++++++++++-
>  src/conf/secret_conf.h       |    1 +
>  src/secret/secret_driver.c   |    8 ++++++++
>  5 files changed, 44 insertions(+), 1 deletions(-)

ACK

Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
