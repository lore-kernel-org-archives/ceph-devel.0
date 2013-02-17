From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] buffer::ptr::cmp only compares up to the smallest
 length
Date: Sat, 16 Feb 2013 18:11:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302161806540.25660@cobra.newdream.net>
References: <1361065465-11115-1-git-send-email-loic@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36946 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab3BQCLG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 21:11:06 -0500
In-Reply-To: <1361065465-11115-1-git-send-email-loic@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

On Sun, 17 Feb 2013, Loic Dachary wrote:
> When running
> 
>   bufferptr a("A", 1);
>   bufferptr ab("AB", 2);
>   a.cmp(ab);
> 
> it returned zero because cmp only compared up to the length of the
> smallest buffer. The tests comparing the length of the buffers are
> moved before the memcmp comparing the actual content of the buffers.
> 
> http://tracker.ceph.com/issues/4170 refs #4170
> 
> Signed-off-by: Loic Dachary <loic@dachary.org>

The problem here is that for B cmp AB, we should be 1, because 'B' > 'A'.  
The length only matters if we reach the end and everything so far is 
equal.

> ---
>  src/common/buffer.cc   |    8 +-------
>  src/test/bufferlist.cc |   14 ++++++++++++++
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/src/common/buffer.cc b/src/common/buffer.cc
> index e10d6c9..5a88849 100644
> --- a/src/common/buffer.cc
> +++ b/src/common/buffer.cc
> @@ -368,17 +368,11 @@ bool buffer_track_alloc = get_env_bool("CEPH_BUFFER_TRACK");
>  
>    int buffer::ptr::cmp(const ptr& o)
>    {
> -    int l = _len < o._len ? _len : o._len;
> -    if (l) {
> -      int r = memcmp(c_str(), o.c_str(), l);
> -      if (!r)
> -	return r;

I think this is the bug.. it should be if (r) return r, and fall through 
below only if r == 0 because the buffers are equal.

sage

> -    }
>      if (_len < o._len)
>        return -1;
>      if (_len > o._len)
>        return 1;
> -    return 0;
> +    return memcmp(c_str(), o.c_str(), _len);
>    }
>  
>    bool buffer::ptr::is_zero() const
> diff --git a/src/test/bufferlist.cc b/src/test/bufferlist.cc
> index 71c2e79..aac41c6 100644
> --- a/src/test/bufferlist.cc
> +++ b/src/test/bufferlist.cc
> @@ -9,6 +9,20 @@
>  
>  #define MAX_TEST 1000000
>  
> +TEST(BufferPtr, cmp) {
> +  bufferptr empty;
> +  bufferptr a("A", 1);
> +  bufferptr ab("AB", 2);
> +  bufferptr af("AF", 2);
> +  EXPECT_GE(-1, empty.cmp(a));
> +  EXPECT_LE(1, a.cmp(empty));
> +  EXPECT_GE(-1, a.cmp(ab));
> +  EXPECT_LE(1, ab.cmp(a));
> +  EXPECT_EQ(0, ab.cmp(ab));
> +  EXPECT_GE(-1, ab.cmp(af));
> +  EXPECT_LE(1, af.cmp(ab));
> +}
> +
>  TEST(BufferList, zero) {
>    //
>    // void zero()
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
