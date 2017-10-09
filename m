From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: Fix bool initialization/comparison
Date: Mon, 9 Oct 2017 09:52:40 +0800
Message-ID: <CE98214F-1FB7-4F7A-AB96-102EFF9A725C@redhat.com>
References: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
 <1507383097083-770412664-4-diffsplit-thomas@m3y3r.de>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507383097083-770412664-4-diffsplit-thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Sage Weil <sage@redhat.com>, idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org



> On 7 Oct 2017, at 22:02, Thomas Meyer <thomas@m3y3r.de> wrote:
> 
> Bool initializations should use true and false. Bool tests don't need
> comparisons.
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> 
> diff -u -p a/fs/ceph/caps.c b/fs/ceph/caps.c
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1711,7 +1711,7 @@ void ceph_check_caps(struct ceph_inode_i
> 
> 	/* if we are unmounting, flush any unused caps immediately. */
> 	if (mdsc->stopping)
> -		is_delayed = 1;
> +		is_delayed = true;
> 
> 	spin_lock(&ci->i_ceph_lock);
> 
> @@ -3185,8 +3185,8 @@ static void handle_cap_flush_ack(struct
> 	int dirty = le32_to_cpu(m->dirty);
> 	int cleaned = 0;
> 	bool drop = false;
> -	bool wake_ci = 0;
> -	bool wake_mdsc = 0;
> +	bool wake_ci = false;
> +	bool wake_mdsc = false;
> 
> 	list_for_each_entry_safe(cf, tmp_cf, &ci->i_cap_flush_list, i_list) {
> 		if (cf->tid == flush_tid)

Applied, thanks

Yan, Zheng
