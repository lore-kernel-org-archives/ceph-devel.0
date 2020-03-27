From: Lee Duncan <lduncan-IBi9RG/b67k@public.gmane.org>
Subject: Re:
Date: Fri, 27 Mar 2020 08:53:20 -0700
Message-ID: <5462bc04-8409-a0c3-628f-640d1c92b8c6@suse.com>
References: <5e7dc543.vYG3wru8B/me1sOV%chenanqing@oppo.com>
Reply-To: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <open-iscsi+bncBD54HHNYIIILVRXY6MCRUBDRJD4XS-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <5e7dc543.vYG3wru8B/me1sOV%chenanqing-Oq79sGaMObY@public.gmane.org>
Content-Language: en-US
List-Post: <https://groups.google.com/group/open-iscsi/post>, <mailto:open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:open-iscsi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/open-iscsi
List-Subscribe: <https://groups.google.com/group/open-iscsi/subscribe>, <mailto:open-iscsi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+856124926423+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/open-iscsi/subscribe>
To: chenanqing-Oq79sGaMObY@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, martin.petersen-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 3/27/20 2:20 AM, chenanqing-Oq79sGaMObY@public.gmane.org wrote:
> From: Chen Anqing <chenanqing-Oq79sGaMObY@public.gmane.org>
> To: Lee Duncan <lduncan-IBi9RG/b67k@public.gmane.org>
> Cc: Chris Leech <cleech-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
>         "James E . J . Bottomley" <jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>,
>         "Martin K . Petersen" <martin.petersen-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
>         ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
>         open-iscsi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
>         linux-scsi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
>         linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
>         chenanqing-Oq79sGaMObY@public.gmane.org
> Subject: [PATCH] scsi: libiscsi: we should take compound page into account also
> Date: Fri, 27 Mar 2020 05:20:01 -0400
> Message-Id: <20200327092001.56879-1-chenanqing-Oq79sGaMObY@public.gmane.org>
> X-Mailer: git-send-email 2.18.2
> 
> the patch is occur at a real crash,which slab is
> come from a compound page,so we need take the compound page
> into account also.
> fixed commit 08b11eaccfcf ("scsi: libiscsi: fall back to
> sendmsg for slab pages").
> 
> Signed-off-by: Chen Anqing <chenanqing-Oq79sGaMObY@public.gmane.org>
> ---
>  drivers/scsi/libiscsi_tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/libiscsi_tcp.c b/drivers/scsi/libiscsi_tcp.c
> index 6ef93c7af954..98304e5e1f6f 100644
> --- a/drivers/scsi/libiscsi_tcp.c
> +++ b/drivers/scsi/libiscsi_tcp.c
> @@ -128,7 +128,8 @@ static void iscsi_tcp_segment_map(struct iscsi_segment *segment, int recv)
>          * coalescing neighboring slab objects into a single frag which
>          * triggers one of hardened usercopy checks.
>          */
> -       if (!recv && page_count(sg_page(sg)) >= 1 && !PageSlab(sg_page(sg)))
> +       if (!recv && page_count(sg_page(sg)) >= 1 &&
> +           !PageSlab(compound_head(sg_page(sg))))
>                 return;
> 
>         if (recv) {
> --
> 2.18.2
> 


This is missing a proper subject ...

-- 
You received this message because you are subscribed to the Google Groups "open-iscsi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to open-iscsi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web visit https://groups.google.com/d/msgid/open-iscsi/5462bc04-8409-a0c3-628f-640d1c92b8c6%40suse.com.
