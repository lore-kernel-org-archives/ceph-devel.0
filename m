From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 48/68] libceph: fix breakage caused by
 multipage bvecs
Date: Tue, 23 Apr 2019 10:27:34 +0200
Message-ID: <CAOi1vP9qzUZOO5Mv2+eoFH9Xn2Kvxf_1EiDJsFuDHLZS1843+w@mail.gmail.com>
References: <20190422194516.11634-1-sashal@kernel.org> <20190422194516.11634-48-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422194516.11634-48-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Ceph Development <ceph-devel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Apr 22, 2019 at 9:46 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Ilya Dryomov <idryomov@gmail.com>
>
> [ Upstream commit 187df76325af5d9e12ae9daec1510307797e54f0 ]
>
> A bvec can now consist of multiple physically contiguous pages.
> This means that bvec_iter_advance() can move to a different page while
> staying in the same bvec (i.e. ->bi_bvec_done != 0).
>
> The messenger works in terms of segments which can now be defined as
> the smaller of a bvec and a page.  The "more bytes to process in this
> segment" condition holds only if bvec_iter_advance() leaves us in the
> same bvec _and_ in the same page.  On next bvec (possibly in the same
> page) and on next page (possibly in the same bvec) we may need to set
> ->last_piece.
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
> ---
>  net/ceph/messenger.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index f7d7f32ac673..ef5216206bdf 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -870,6 +870,7 @@ static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
>                                         size_t bytes)
>  {
>         struct ceph_bio_iter *it = &cursor->bio_iter;
> +       struct page *page = bio_iter_page(it->bio, it->iter);
>
>         BUG_ON(bytes > cursor->resid);
>         BUG_ON(bytes > bio_iter_len(it->bio, it->iter));
> @@ -881,7 +882,8 @@ static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
>                 return false;   /* no more data */
>         }
>
> -       if (!bytes || (it->iter.bi_size && it->iter.bi_bvec_done))
> +       if (!bytes || (it->iter.bi_size && it->iter.bi_bvec_done &&
> +                      page == bio_iter_page(it->bio, it->iter)))
>                 return false;   /* more bytes to process in this segment */
>
>         if (!it->iter.bi_size) {
> @@ -929,6 +931,7 @@ static bool ceph_msg_data_bvecs_advance(struct ceph_msg_data_cursor *cursor,
>                                         size_t bytes)
>  {
>         struct bio_vec *bvecs = cursor->data->bvec_pos.bvecs;
> +       struct page *page = bvec_iter_page(bvecs, cursor->bvec_iter);
>
>         BUG_ON(bytes > cursor->resid);
>         BUG_ON(bytes > bvec_iter_len(bvecs, cursor->bvec_iter));
> @@ -940,7 +943,8 @@ static bool ceph_msg_data_bvecs_advance(struct ceph_msg_data_cursor *cursor,
>                 return false;   /* no more data */
>         }
>
> -       if (!bytes || cursor->bvec_iter.bi_bvec_done)
> +       if (!bytes || (cursor->bvec_iter.bi_bvec_done &&
> +                      page == bvec_iter_page(bvecs, cursor->bvec_iter)))
>                 return false;   /* more bytes to process in this segment */
>
>         BUG_ON(cursor->last_piece);

Hi Sasha,

This shouldn't be needed.  Multipage bvecs code is new in 5.1 (commit
07173c3ec276 ("block: enable multipage bvecs")), this commit just fixed
the fall out.

Thanks,

                Ilya
