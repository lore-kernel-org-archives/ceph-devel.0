From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 13/15] ceph: Use pagevec_lookup_range_nr_tag()
Date: Mon, 18 Sep 2017 13:35:50 +0800
Message-ID: <CAAM7YAnHjkGRhzeUUXOMnux70UKqnQ3kG6x0jRpzasSNeyAVCg@mail.gmail.com>
References: <20170914131819.26266-1-jack@suse.cz> <20170914131819.26266-14-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170914131819.26266-14-jack@suse.cz>
Sender: owner-linux-mm@kvack.org
To: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

On Thu, Sep 14, 2017 at 9:18 PM, Jan Kara <jack@suse.cz> wrote:
> Use new function for looking up pages since nr_pages argument from
> pagevec_lookup_range_tag() is going away.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ceph/addr.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index e57e9d37bf2d..87789c477381 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -869,11 +869,9 @@ static int ceph_writepages_start(struct address_space *mapping,
>                 max_pages = wsize >> PAGE_SHIFT;
>
>  get_more_pages:
> -               pvec_pages = min_t(unsigned, PAGEVEC_SIZE,
> -                                  max_pages - locked_pages);
> -               pvec_pages = pagevec_lookup_range_tag(&pvec, mapping, &index,
> +               pvec_pages = pagevec_lookup_range_nr_tag(&pvec, mapping, &index,
>                                                 end, PAGECACHE_TAG_DIRTY,
> -                                               pvec_pages);
> +                                               max_pages - locked_pages);
>                 dout("pagevec_lookup_range_tag got %d\n", pvec_pages);
>                 if (!pvec_pages && !locked_pages)
>                         break;
> --
> 2.12.3
>

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
