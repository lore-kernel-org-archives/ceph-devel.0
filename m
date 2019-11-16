From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 100/237] libceph: don't consume a ref on
 pagelist in ceph_msg_data_add_pagelist()
Date: Sat, 16 Nov 2019 17:23:28 +0100
Message-ID: <CAOi1vP8ZTyaGsn-hXtnr+AnCrEQfSB6sTLYwkkZ8P1oY9EgPXg@mail.gmail.com>
References: <20191116154113.7417-1-sashal@kernel.org> <20191116154113.7417-100-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191116154113.7417-100-sashal@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Ceph Development <ceph-devel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Sat, Nov 16, 2019 at 4:43 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Ilya Dryomov <idryomov@gmail.com>
>
> [ Upstream commit 894868330a1e038ea4a65dbb81741eef70ad71b1 ]
>
> Because send_mds_reconnect() wants to send a message with a pagelist
> and pass the ownership to the messenger, ceph_msg_data_add_pagelist()
> consumes a ref which is then put in ceph_msg_data_destroy().  This
> makes managing pagelists in the OSD client (where they are wrapped in
> ceph_osd_data) unnecessarily hard because the handoff only happens in
> ceph_osdc_start_request() instead of when the pagelist is passed to
> ceph_osd_data_pagelist_init().  I counted several memory leaks on
> various error paths.
>
> Fix up ceph_msg_data_add_pagelist() and carry a pagelist ref in
> ceph_osd_data.
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/ceph/mds_client.c  | 2 +-
>  net/ceph/messenger.c  | 1 +
>  net/ceph/osd_client.c | 8 ++++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 09db6d08614d2..94494d05a94cb 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2184,7 +2184,6 @@ static struct ceph_msg *create_request_message(struct ceph_mds_client *mdsc,
>
>         if (req->r_pagelist) {
>                 struct ceph_pagelist *pagelist = req->r_pagelist;
> -               refcount_inc(&pagelist->refcnt);
>                 ceph_msg_data_add_pagelist(msg, pagelist);
>                 msg->hdr.data_len = cpu_to_le32(pagelist->length);
>         } else {
> @@ -3289,6 +3288,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
>         mutex_unlock(&mdsc->mutex);
>
>         up_read(&mdsc->snap_rwsem);
> +       ceph_pagelist_release(pagelist);
>         return;
>
>  fail:
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index f7d7f32ac673c..2c8cd339d59ea 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -3323,6 +3323,7 @@ void ceph_msg_data_add_pagelist(struct ceph_msg *msg,
>
>         data = ceph_msg_data_create(CEPH_MSG_DATA_PAGELIST);
>         BUG_ON(!data);
> +       refcount_inc(&pagelist->refcnt);
>         data->pagelist = pagelist;
>
>         list_add_tail(&data->links, &msg->data);
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 76c41a84550e7..c3494c1fb3a9a 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -126,6 +126,9 @@ static void ceph_osd_data_init(struct ceph_osd_data *osd_data)
>         osd_data->type = CEPH_OSD_DATA_TYPE_NONE;
>  }
>
> +/*
> + * Consumes @pages if @own_pages is true.
> + */
>  static void ceph_osd_data_pages_init(struct ceph_osd_data *osd_data,
>                         struct page **pages, u64 length, u32 alignment,
>                         bool pages_from_pool, bool own_pages)
> @@ -138,6 +141,9 @@ static void ceph_osd_data_pages_init(struct ceph_osd_data *osd_data,
>         osd_data->own_pages = own_pages;
>  }
>
> +/*
> + * Consumes a ref on @pagelist.
> + */
>  static void ceph_osd_data_pagelist_init(struct ceph_osd_data *osd_data,
>                         struct ceph_pagelist *pagelist)
>  {
> @@ -362,6 +368,8 @@ static void ceph_osd_data_release(struct ceph_osd_data *osd_data)
>                 num_pages = calc_pages_for((u64)osd_data->alignment,
>                                                 (u64)osd_data->length);
>                 ceph_release_page_vector(osd_data->pages, num_pages);
> +       } else if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGELIST) {
> +               ceph_pagelist_release(osd_data->pagelist);
>         }
>         ceph_osd_data_init(osd_data);
>  }

Hi Sasha,

This commit was part of a larger series and shouldn't be backported on
its own.  Please drop it.

Thanks,

                Ilya
