From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] fix operator>=(bufferlist& l, bufferlist& r)
Date: Sat, 16 Feb 2013 14:52:09 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302161452030.25660@cobra.newdream.net>
References: <1361005875-768-1-git-send-email-loic@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35697 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898Ab3BPWwK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 17:52:10 -0500
In-Reply-To: <1361005875-768-1-git-send-email-loic@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Applied.  Thanks, Loic!

On Sat, 16 Feb 2013, Loic Dachary wrote:

>   bufferlist a;
>   a.append("A");
>   bufferlist ab;
>   ab.append("AB");
> 
> a >= ab failed, throwing an instance of 'ceph::buffer::end_of_buffer'
> because it tried to access a[1]. All comparison operators should be
> tested using a lexicographic sort like strcmp or memcmp (-1, 0, 1).
> In the meantime, the missing test is added:
> 
>   if (l.length() == p && r.length() > p) return false;
> 
> A set of unit tests demonstrating the problem and covering all comparison
> operators are added to show that the proposed fix works as expected.
> 
> http://tracker.ceph.com/issues/4157 refs #4157
> 
> Signed-off-by: Loic Dachary <loic@dachary.org>
> ---
>  src/include/buffer.h   |    1 +
>  src/test/bufferlist.cc |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/src/include/buffer.h b/src/include/buffer.h
> index 4f87ed7..b84e7f4 100644
> --- a/src/include/buffer.h
> +++ b/src/include/buffer.h
> @@ -467,6 +467,7 @@ inline bool operator>=(bufferlist& l, bufferlist& r) {
>    for (unsigned p = 0; ; p++) {
>      if (l.length() > p && r.length() == p) return true;
>      if (r.length() == p && l.length() == p) return true;
> +    if (l.length() == p && r.length() > p) return false;
>      if (l[p] > r[p]) return true;
>      if (l[p] < r[p]) return false;
>    }
> diff --git a/src/test/bufferlist.cc b/src/test/bufferlist.cc
> index 91e37e6..71c2e79 100644
> --- a/src/test/bufferlist.cc
> +++ b/src/test/bufferlist.cc
> @@ -57,6 +57,53 @@ TEST(BufferList, zero) {
>    }
>  }
>  
> +TEST(BufferList, compare) {
> +  bufferlist a;
> +  a.append("A");
> +  bufferlist ab;
> +  ab.append("AB");
> +  bufferlist ac;
> +  ac.append("AC");
> +  //
> +  // bool operator>(bufferlist& l, bufferlist& r)
> +  //
> +  ASSERT_FALSE(a > ab);
> +  ASSERT_TRUE(ab > a);
> +  ASSERT_TRUE(ac > ab);
> +  ASSERT_FALSE(ab > ac);
> +  ASSERT_FALSE(ab > ab);
> +  //
> +  // bool operator>=(bufferlist& l, bufferlist& r)
> +  //
> +  ASSERT_FALSE(a >= ab);
> +  ASSERT_TRUE(ab >= a);
> +  ASSERT_TRUE(ac >= ab);
> +  ASSERT_FALSE(ab >= ac);
> +  ASSERT_TRUE(ab >= ab);
> +  //
> +  // bool operator<(bufferlist& l, bufferlist& r)
> +  //
> +  ASSERT_TRUE(a < ab);
> +  ASSERT_FALSE(ab < a);
> +  ASSERT_FALSE(ac < ab);
> +  ASSERT_TRUE(ab < ac);
> +  ASSERT_FALSE(ab < ab);
> +  //
> +  // bool operator<=(bufferlist& l, bufferlist& r)
> +  //
> +  ASSERT_TRUE(a <= ab);
> +  ASSERT_FALSE(ab <= a);
> +  ASSERT_FALSE(ac <= ab);
> +  ASSERT_TRUE(ab <= ac);
> +  ASSERT_TRUE(ab <= ab);
> +  //
> +  // bool operator==(bufferlist &l, bufferlist &r)
> +  //
> +  ASSERT_FALSE(a == ab);
> +  ASSERT_FALSE(ac == ab);
> +  ASSERT_TRUE(ab == ab);
> +}
> +
>  TEST(BufferList, EmptyAppend) {
>    bufferlist bl;
>    bufferptr ptr;
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
