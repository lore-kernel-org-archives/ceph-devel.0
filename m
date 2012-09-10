From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 4/4] rbd: use snaps list in rbd_snap_by_name()
Date: Mon, 10 Sep 2012 15:32:09 -0700
Message-ID: <504E6A69.8070109@inktank.com>
References: <504A090F.7000706@inktank.com> <504A09BA.5030203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38909 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756329Ab2IJWcV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Sep 2012 18:32:21 -0400
Received: by pbbrr13 with SMTP id rr13so3136644pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 10 Sep 2012 15:32:21 -0700 (PDT)
In-Reply-To: <504A09BA.5030203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 09/07/2012 07:50 AM, Alex Elder wrote:
> An rbd_dev structure maintains a list of current snapshots that have
> already been fully initialized.  The entries on the list have type
> struct rbd_snap, and each entry contains a copy of information
> that's found in the rbd_dev's snapshot context and header.
>
> The only caller of snap_by_name() is rbd_header_set_snap().  In that
> call site any positive return value (the index in the snapshot
> array) is ignored.
>
> rbd_header_set_snap() also has only one caller--rbd_add()--and that
> call is made after a call to rbd_dev_snap_devs_update().  Because
> the rbd_snap structures are initialized in that function, the
> current snapshot list can be used instead of the snapshot context to
> look up a snapshot's information by name.
>
> Change snap_by_name() so it uses the snapshot list rather than the
> rbd_dev's snapshot context in looking up snapshot information.
> Return 0 if it's found rather than the snapshot id.  To do this,
> change rbd_snap_by_name() to take an rbd_dev rather than
> rbd_image_header structure pointer as its first argument.

This argument change was an earlier commit now.

> No caller ever passes a null pointer to snap_by_name() for the
> snapshot id or the size, so just assign using those pointers
> unconditionally.

No caller passes id or size now either.

With the commit message fixed:

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index e922989..4dff92f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -623,23 +623,18 @@ out_err:
>
>   static int snap_by_name(struct rbd_device *rbd_dev, const char *snap_name)
>   {
> -	int i;
> -	struct rbd_image_header *header = &rbd_dev->header;
> -	char *p = header->snap_names;
> -
> -	rbd_assert(header->snapc != NULL);
> -	for (i = 0; i < header->snapc->num_snaps; i++) {
> -		if (!strcmp(snap_name, p)) {
>
> -			/* Found it.  Pass back its id and/or size */
> +	struct rbd_snap *snap;
>
> -			rbd_dev->mapping.snap_id = header->snapc->snaps[i];
> -			rbd_dev->mapping.size = header->snap_sizes[i];
> +	list_for_each_entry(snap, &rbd_dev->snaps, node) {
> +		if (!strcmp(snap_name, snap->name)) {
> +			rbd_dev->mapping.snap_id = snap->id;
> +			rbd_dev->mapping.size = snap->size;
>
> -			return i;
> +			return 0;
>   		}
> -		p += strlen(p) + 1;	/* Skip ahead to the next name */
>   	}
> +
>   	return -ENOENT;
>   }
>

