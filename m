From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/5] rbd: define some new format constants
Date: Tue, 11 Sep 2012 08:18:20 -0700
Message-ID: <504F563C.3040001@inktank.com>
References: <504A39E0.1040107@inktank.com> <504A3AAF.1000403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52488 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090Ab2IKPS0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 11:18:26 -0400
Received: by dady13 with SMTP id y13so371340dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 08:18:26 -0700 (PDT)
In-Reply-To: <504A3AAF.1000403@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 11:19 AM, Alex Elder wrote:
> Define constant symbols related to the rbd format 2 object names.
> This begins to bring this version of the "rbd_types.h" header
> more in line with the current user-space version of that file.
> Complete reconciliation of differences will be done at some
> point later, as a separate task.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd_types.h |   25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/rbd_types.h b/drivers/block/rbd_types.h
> index d9d8a77..cbe77fa 100644
> --- a/drivers/block/rbd_types.h
> +++ b/drivers/block/rbd_types.h
> @@ -15,15 +15,30 @@
>
>   #include <linux/types.h>
>
> +/* For format version 2, rbd image 'foo' consists of objects
> + *   rbd_id.foo		- id of image
> + *   rbd_header.<id>	- image metadata
> + *   rbd_data.<id>.0000000000000000
> + *   rbd_data.<id>.0000000000000001
> + *   ...		- data
> + * Clients do not access header data directly in rbd format 2.
> + */
> +
> +#define RBD_HEADER_PREFIX      "rbd_header."
> +#define RBD_DATA_PREFIX        "rbd_data."
> +#define RBD_ID_PREFIX          "rbd_id."
> +
>   /*
> - * rbd image 'foo' consists of objects
> - *   foo.rbd      - image metadata
> - *   foo.00000000
> - *   foo.00000001
> - *   ...          - data
> + * For format version 1, rbd image 'foo' consists of objects
> + *   foo.rbd		- image metadata
> + *   rb.<idhi>.<idlo>.00000000
> + *   rb.<idhi>.<idlo>.00000001
> + *   ...		- data
> + * There is no notion of a persistent image id in rbd format 1.
>    */
>
>   #define RBD_SUFFIX		".rbd"
> +
>   #define RBD_DIRECTORY           "rbd_directory"
>   #define RBD_INFO                "rbd_info"
>

