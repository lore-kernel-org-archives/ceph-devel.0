From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] buffer::ptr::cmp only compares up to the smallest
 length
Date: Sun, 17 Feb 2013 09:49:05 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302170948380.25660@cobra.newdream.net>
References: <1361065465-11115-1-git-send-email-loic@dachary.org> <1361090470-14891-1-git-send-email-loic@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42042 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab3BQRtG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Feb 2013 12:49:06 -0500
In-Reply-To: <1361090470-14891-1-git-send-email-loic@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

I left this in master since the only current caller I see is in the omap 
scrubbing code.  We may want to backport it soonish, though.

sage


On Sun, 17 Feb 2013, Loic Dachary wrote:

> When running
> 
>   bufferptr a("A", 1);
>   bufferptr ab("AB", 2);
>   a.cmp(ab);
> 
> it returned zero because. cmp only compared up to the length of the
> smallest buffer and returned if they are identical. The function is
> modified to compare the length of the buffers instead of returning.
> 
> http://tracker.ceph.com/issues/4170 refs #4170
> 
> Signed-off-by: Loic Dachary <loic@dachary.org>
> ---
>  src/common/buffer.cc   |    2 +-
>  src/test/bufferlist.cc |   17 +++++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/src/common/buffer.cc b/src/common/buffer.cc
> index e10d6c9..df50cfc 100644
> --- a/src/common/buffer.cc
> +++ b/src/common/buffer.cc
> @@ -371,7 +371,7 @@ bool buffer_track_alloc = get_env_bool("CEPH_BUFFER_TRACK");
>      int l = _len < o._len ? _len : o._len;
>      if (l) {
>        int r = memcmp(c_str(), o.c_str(), l);
> -      if (!r)
> +      if (r)
>  	return r;
>      }
>      if (_len < o._len)
> diff --git a/src/test/bufferlist.cc b/src/test/bufferlist.cc
> index 71c2e79..7abced1 100644
> --- a/src/test/bufferlist.cc
> +++ b/src/test/bufferlist.cc
> @@ -9,6 +9,23 @@
>  
>  #define MAX_TEST 1000000
>  
> +TEST(BufferPtr, cmp) {
> +  bufferptr empty;
> +  bufferptr a("A", 1);
> +  bufferptr ab("AB", 2);
> +  bufferptr af("AF", 2);
> +  bufferptr acc("ACC", 3);
> +  EXPECT_GE(-1, empty.cmp(a));
> +  EXPECT_LE(1, a.cmp(empty));
> +  EXPECT_GE(-1, a.cmp(ab));
> +  EXPECT_LE(1, ab.cmp(a));
> +  EXPECT_EQ(0, ab.cmp(ab));
> +  EXPECT_GE(-1, ab.cmp(af));
> +  EXPECT_LE(1, af.cmp(ab));
> +  EXPECT_GE(-1, acc.cmp(af));
> +  EXPECT_LE(1, af.cmp(acc));
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
