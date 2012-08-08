From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/4] rbd: return earlier in rbd_header_from_disk()
Date: Tue, 07 Aug 2012 17:29:43 -0700
Message-ID: <5021B2F7.6030406@inktank.com>
References: <502009D1.7090005@inktank.com> <50200A46.3070508@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39615 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab2HHA3u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 20:29:50 -0400
Received: by yhmm54 with SMTP id m54so229654yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Aug 2012 17:29:49 -0700 (PDT)
In-Reply-To: <50200A46.3070508@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/06/2012 11:17 AM, Alex Elder wrote:
> The only caller of rbd_header_from_disk() is rbd_read_header().
> It passes as allocated_snaps the number of snapshots it will
> have received from the server for the snapshot context that
> rbd_header_from_disk() is to interpret.  The first time through
> it provides 0--mainly to extract the number of snapshots from
> the snapshot context header--so that it can allocate an
> appropriately-sized buffer to receive the entire snapshot
> context from the server in a second request.
>
> rbd_header_from_disk() will not fill in the array of snapshot ids
> unless the number in the snapshot matches the number the caller
> had allocated.
>
> This patch adjusts that logic a little further to be more efficient.
> rbd_read_header() doesn't even examine the snapshot context unless
> the snapshot count (stored in header->total_snaps) matches the
> number of snapshots allocated.  So rbd_header_from_disk() doesn't
> need to allocate or fill in the snapshot context field at all in
> that case.
>
> Signed-off-by: Alex Elder <elder@inktank.com>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> ---
>   drivers/block/rbd.c |   15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> Index: b/drivers/block/rbd.c
> ===================================================================
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -541,7 +541,14 @@ static int rbd_header_from_disk(struct r
>       header->comp_type = ondisk->options.comp_type;
>       header->total_snaps = snap_count;
>
> -    /* Set up the snapshot context */
> +    /*
> +     * If the number of snapshot ids provided by the caller
> +     * doesn't match the number in the entire context there's
> +     * no point in going further.  Caller will try again after
> +     * getting an updated snapshot context from the server.
> +     */
> +    if (allocated_snaps != snap_count)
> +        return 0;
>
>       size = sizeof (struct ceph_snap_context);
>       size += snap_count * sizeof (header->snapc->snaps[0]);
> @@ -553,8 +560,10 @@ static int rbd_header_from_disk(struct r
>       header->snapc->seq = le64_to_cpu(ondisk->snap_seq);
>       header->snapc->num_snaps = snap_count;
>
> -    if (snap_count && allocated_snaps == snap_count) {
> -        int i;
> +    /* Fill in the snapshot information */
> +
> +    if (snap_count) {
> +        u32 i;
>
>           for (i = 0; i < snap_count; i++) {
>               header->snapc->snaps[i] =
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

