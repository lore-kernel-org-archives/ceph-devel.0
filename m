From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd.cc: Check io-size avoid floating point exception.
Date: Thu, 10 Jul 2014 18:01:53 -0700
Message-ID: <53BF3781.5090707@inktank.com>
References: <6AA21C22F0A5DA478922644AD2EC308C87E2AA@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48965 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaGKBBl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jul 2014 21:01:41 -0400
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C87E2AA@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/12/2014 01:15 AM, Ma, Jianpeng wrote:
> In func do_bench_write if io_size is zero,it can cause floating point execption.
>
> Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>

Applied, thanks!

Josh

> ---
>   src/rbd.cc | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/src/rbd.cc b/src/rbd.cc
> index d6658e3..c068ed6 100644
> --- a/src/rbd.cc
> +++ b/src/rbd.cc
> @@ -2038,6 +2038,14 @@ int main(int argc, const char **argv)
>   	return EXIT_FAILURE;
>         }
>       } else if (ceph_argparse_withlonglong(args, i, &bench_io_size, &err, "--io-size", (char*)NULL)) {
> +      if (!err.str().empty()) {
> +	cerr << "rbd: " << err.str() << std::endl;
> +	return EXIT_FAILURE;
> +      }
> +      if (bench_io_size == 0) {
> +	cerr << "rbd: io-size must be > 0" << std::endl;
> +	return EXIT_FAILURE;
> +      }
>       } else if (ceph_argparse_withlonglong(args, i, &bench_io_threads, &err, "--io-threads", (char*)NULL)) {
>       } else if (ceph_argparse_withlonglong(args, i, &bench_bytes, &err, "--io-total", (char*)NULL)) {
>       } else if (ceph_argparse_witharg(args, i, &bench_pattern, &err, "--io-pattern", (char*)NULL)) {
>

