From: Sage Weil <sage@newdream.net>
Subject: Re: Bug in mempool::map?
Date: Tue, 20 Dec 2016 15:25:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612201524400.10615@piezo.novalocal>
References: <36219e00-6114-7b9e-f7ca-5190cb545c93@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56338 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756078AbcLTPZc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2016 10:25:32 -0500
In-Reply-To: <36219e00-6114-7b9e-f7ca-5190cb545c93@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 20 Dec 2016, Igor Fedotov wrote:
> Hi Allen,
> 
> It looks like mempools don't measure maps allocations properly.
> 
> I extended unittest_mempool in the following way but corresponding output is
> always 0 for both 'before' and 'after' values:
> 
> 
> diff --git a/src/test/test_mempool.cc b/src/test/test_mempool.cc
> index 4113c53..b38a356 100644
> --- a/src/test/test_mempool.cc
> +++ b/src/test/test_mempool.cc
> @@ -232,9 +232,19 @@ TEST(mempool, set)
>  TEST(mempool, map)
>  {
>    {
> -    mempool::unittest_1::map<int,int> v;
> -    v[1] = 2;
> -    v[3] = 4;
> +    size_t before = mempool::buffer_data::allocated_bytes();

I think it's just that you're measuring the buffer_data pool...

> +    mempool::unittest_1::map<int,int>* v = new mempool::unittest_1::map<int,int>;

but the map is in the unittest_1 pool?

> +    (*v)[1] = 2;
> +    (*v)[3] = 4;
> +    size_t after = mempool::buffer_data::allocated_bytes();
> +    cout << "before " << before << " after " << after << std::endl;
> +    delete v;
> +    before = after;
> +    mempool::unittest_1::map<int64_t,int64_t> v2;
> +    v2[1] = 2;
> +    v2[3] = 4;
> +    after = mempool::buffer_data::allocated_bytes();
> +    cout << " before " << before << " after " << after << std::endl;
>    }
>    {
>      mempool::unittest_2::map<int,obj> v;
> 
> 
> Output:
> 
> [ RUN      ] mempool.map
> before 0 after 0
>  before 0 after 0
> [       OK ] mempool.map (0 ms)
> 
> It looks like we do not measure ref_map for BlueStore Blob and SharedBlob
> classes too.
> 
> Any ideas?
> 
> Thanks,
> 
> Igor
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
