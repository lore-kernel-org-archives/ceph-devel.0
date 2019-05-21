From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 4/4] ceph: fix improper use of smp_mb__before_atomic()
Date: Tue, 21 May 2019 10:18:07 +0800
Message-ID: <a1dcab3f-6018-9d4d-ee6d-505b4086f097@redhat.com>
References: <1558373038-5611-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1558373038-5611-5-git-send-email-andrea.parri@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1558373038-5611-5-git-send-email-andrea.parri@amarulasolutions.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: ceph-devel.vger.kernel.org

On 5/21/19 1:23 AM, Andrea Parri wrote:
> This barrier only applies to the read-modify-write operations; in
> particular, it does not apply to the atomic64_set() primitive.
> 
> Replace the barrier with an smp_mb().
> 
> Fixes: fdd4e15838e59 ("ceph: rework dcache readdir")
> Cc: stable@vger.kernel.org
> Reported-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: "Yan, Zheng" <zyan@redhat.com>
> Cc: Sage Weil <sage@redhat.com>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>   fs/ceph/super.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 6edab9a750f8a..e02f4ff0be3f1 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -541,7 +541,12 @@ static inline void __ceph_dir_set_complete(struct ceph_inode_info *ci,
>   					   long long release_count,
>   					   long long ordered_count)
>   {
> -	smp_mb__before_atomic();
> +	/*
> +	 * Makes sure operations that setup readdir cache (update page
> +	 * cache and i_size) are strongly ordered w.r.t. the following
> +	 * atomic64_set() operations.
> +	 */
> +	smp_mb();
>   	atomic64_set(&ci->i_complete_seq[0], release_count);
>   	atomic64_set(&ci->i_complete_seq[1], ordered_count);
>   }
> 

Applied, thanks
