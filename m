From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v3 0/5] ceph: implement new-style ENOSPC handling in
 kcephfs
Date: Tue, 7 Feb 2017 22:28:20 +0800
Message-ID: <8419BC98-9637-479B-AB5F-8B865739A438@redhat.com>
References: <20170207122828.5550-1-jlayton@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753285AbdBGO21 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Feb 2017 09:28:27 -0500
In-Reply-To: <20170207122828.5550-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: ceph-devel@vger.kernel.org, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com


> On 7 Feb 2017, at 20:28, Jeff Layton <jlayton@redhat.com> wrote:
> 
> v3: track "abort_on_full" behavior with a new bool in osd request
> instead of a protocol flag. Remove some extraneous arguments from
> various functions. Don't export have_pool_full, call it from the
> abort_on_full callback instead.
> 
> v2: teach libcephfs how to hold on to requests until the right map
> epoch appears, instead of delaying cap handling in the cephfs layer.
> 
> This patchset is an updated version of the patch series originally
> done by John Spray and posted here:
> 
>    http://www.spinics.net/lists/ceph-devel/msg21257.html
> 
> This version incorporates changes based on Ilya's cursory review
> yesterday. It also cleans up the handling of requests that should
> be aborted on a full condition. The patch that exports have_pool_full
> has also been dropped since it's no longer needed.
> 
> Jeff Layton (4):
>  libceph: allow requests to return immediately on full conditions if
>    caller wishes
>  libceph: add an epoch_barrier field to struct ceph_osd_client
>  ceph: register map callback to handle ENOSPC conditions
>  ceph: handle epoch barriers in cap messages
> 
> John Spray (1):
>  libceph: add ceph_osdc_abort_on_full
> 
> fs/ceph/addr.c                  |   4 ++
> fs/ceph/caps.c                  |  17 +++++--
> fs/ceph/file.c                  |   4 ++
> fs/ceph/mds_client.c            |  33 +++++++++++++
> fs/ceph/mds_client.h            |   7 ++-
> include/linux/ceph/osd_client.h |   7 +++
> net/ceph/osd_client.c           | 100 ++++++++++++++++++++++++++++++++++++----
> 7 files changed, 158 insertions(+), 14 deletions(-)

The cephfs part looks good for me

Regards
Yan, Zheng


> 
> -- 
> 2.9.3
> 

