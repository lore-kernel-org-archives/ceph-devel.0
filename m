From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH]ceph:init-ceph can't start osds after using mkcephfs
 created cluster
Date: Sun, 24 Nov 2013 22:04:58 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311242202370.2298@cobra.newdream.net>
References: <CAM9_UU9RJouy7X0A296neNC_Jdm29tEra7aGb-GHFEuq9yrikw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59431 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab3KYGE7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Nov 2013 01:04:59 -0500
In-Reply-To: <CAM9_UU9RJouy7X0A296neNC_Jdm29tEra7aGb-GHFEuq9yrikw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ketor D <d.ketor@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ketor,

Can you tell what is making the ceph command fail at this point?  If the 
mons are started before the OSDs, the crush map update ought to succeed...

Thanks!
sage

On Mon, 11 Nov 2013, Ketor D wrote:

> Hi Sage:
>         We always use mkcephfs to create out ceph cluster. Before
> 0.72, all is ok.
> But in 0.72, we found the osds can't start up useing "service ceph -a
> start". After viewing the init-ceph.in script , I found that a return
> value errro caused osds can't startup.And if we modifiy a little code
> like 0.67.4 do, the osds can startup.
> 
>          Regards!
> 
> Here is the patch:
> 
> Signed-off-by: Ketor D <d.ketor@gmail.com>
> ---
> diff --git "a/src/init-ceph.in" "b/src/init-ceph.in"
> index 7399abb..cf2eaa6 100644
> --- "a/src/init-ceph.in"
> +++ "b/src/init-ceph.in"
> @@ -331,7 +331,8 @@ for name in $what; do
>   -- \
>   $id \
>   ${osd_weight:-${defaultweight:-1}} \
> - $osd_location"
> + $osd_location \
> + || :"
>   fi
>      fi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
