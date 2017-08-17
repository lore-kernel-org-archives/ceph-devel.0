From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [PATCH] ceph: check negative offsets on ceph_llseek()
Date: Thu, 17 Aug 2017 14:45:49 +0100
Message-ID: <87pobuz4s2.fsf@hermes>
References: <20170728105640.16268-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39721 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750857AbdHQNpx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 17 Aug 2017 09:45:53 -0400
In-Reply-To: <20170728105640.16268-1-lhenriques@suse.com> (Luis Henriques's
        message of "Fri, 28 Jul 2017 11:56:40 +0100")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Luis Henriques <lhenriques@suse.com> writes:

> When a user requests SEEK_HOLE or SEEK_DATA with a negative offset
> ceph_llseek should return -ENXIO.  Currently -EINVAL is being returned for
> SEEK_DATA and 0 for SEEK_HOLE.

Ping

This patch should make xfstest generic/448 happy.

Cheers,
-- 
Luís

>
> Signed-off-by: Luis Henriques <lhenriques@suse.com>
> ---
>  fs/ceph/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 3d48c415f3cb..e1912e67843f 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1481,13 +1481,13 @@ static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
>  		offset += file->f_pos;
>  		break;
>  	case SEEK_DATA:
> -		if (offset >= i_size) {
> +		if (offset < 0 || offset >= i_size) {
>  			ret = -ENXIO;
>  			goto out;
>  		}
>  		break;
>  	case SEEK_HOLE:
> -		if (offset >= i_size) {
> +		if (offset < 0 || offset >= i_size) {
>  			ret = -ENXIO;
>  			goto out;
>  		}
>
