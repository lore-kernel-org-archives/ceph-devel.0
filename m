From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: silence sparse endianness warning in encode_caps_cb
Date: Wed, 1 Nov 2017 10:16:23 +0800
Message-ID: <C5A05E8A-DD66-4872-86C1-30A31E029683@redhat.com>
References: <20171031200924.27875-1-jlayton@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932210AbdKACQc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 31 Oct 2017 22:16:32 -0400
In-Reply-To: <20171031200924.27875-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org



> On 1 Nov 2017, at 04:09, Jeff Layton <jlayton@kernel.org> wrote:
> 
> From: Jeff Layton <jlayton@redhat.com>
> 
> fs/ceph/mds_client.c:2887:34: warning: incorrect type in assignment (different base types)
> fs/ceph/mds_client.c:2887:34:    expected restricted __le32 [assigned] [usertype] flock_len
> fs/ceph/mds_client.c:2887:34:    got int
> 
> At this point, it's just being used as a flag. It gets
> overwritten later if the rest of the encoding succeeds.
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
> fs/ceph/mds_client.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index f5b1e8d73e85..927afb612e43 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2884,8 +2884,8 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
> 		rec.v2.issued = cpu_to_le32(cap->issued);
> 		rec.v2.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
> 		rec.v2.pathbase = cpu_to_le64(pathbase);
> -		rec.v2.flock_len =
> -			(ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1;
> +		rec.v2.flock_len = (__force __le32)
> +			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
> 	} else {
> 		rec.v1.cap_id = cpu_to_le64(cap->cap_id);
> 		rec.v1.wanted = cpu_to_le32(__ceph_caps_wanted(ci));

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>

> -- 
> 2.13.6
> 

