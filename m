From: Luis Henriques <lhenriques@suse.com>
Subject: Re: ceph-disk triggers XFS kernel bug?
Date: Thu, 1 Feb 2018 14:46:42 +0000
Message-ID: <20180201144642.zi7rwrfoekftvohx@hermes.olymp>
References: <CAGbviv+P9573YaCKhULn3bE-Txz7-wDHoTuvft2vEZGn1xyQ6Q@mail.gmail.com>
 <CAJE9aONOiym_UCbe5GD4wgbhcQSVtTVYt1dJE+gnr6Fvk22=jg@mail.gmail.com>
 <FB9565CD-3BF6-4F99-88BB-458C49C46DBC@flyingcircus.io>
 <E3CF8663-526C-4C55-96B5-BF121E4F4875@flyingcircus.io>
 <CABYiri-HRU58Vhc5-_fuBMOZgYpMaNCkLpNECgfs=HEkg4PzFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48615 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751508AbeBAOqn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:46:43 -0500
Content-Disposition: inline
In-Reply-To: <CABYiri-HRU58Vhc5-_fuBMOZgYpMaNCkLpNECgfs=HEkg4PzFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Christian Theune <ct@flyingcircus.io>, kefu chai <tchaikov@gmail.com>, Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 29, 2018 at 07:13:39PM +0300, Andrey Korolyov wrote:
> It appears that RH fixed that bug on top on their xfs queue:

Just for completeness, this is fixed in upstream kernel with commit
f35c5e10c6ed ("xfs: reinit btree pointer on attr tree inactivation
walk").  Simply updating to a more recent kernel should work.

Cheers,
--
Luís

> 
> --- a/fs/xfs/xfs_attr_inactive.c
> +++ b/fs/xfs/xfs_attr_inactive.c
> @@ -302,6 +302,8 @@
>                                                  &bp, XFS_ATTR_FORK);
>                         if (error)
>                                 return error;
> +                       node = bp->b_addr;
> +                       btree = dp->d_ops->node_tree_p(node);
>                         child_fsb = be32_to_cpu(btree[i + 1].before);
>                         xfs_trans_brelse(*trans, bp);
>                 }
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
