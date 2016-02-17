From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: Use xattr to replace omap operations in rbd
Date: Wed, 17 Feb 2016 11:21:26 -0500 (EST)
Message-ID: <1834073137.24389531.1455726086385.JavaMail.zimbra@redhat.com>
References: <CABAwU-Ysn9f=U+Aj53n_2k6L_5U_ViaOhXQ_UR9VPdbCisxhTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:38043 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422694AbcBQQV2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Feb 2016 11:21:28 -0500
In-Reply-To: <CABAwU-Ysn9f=U+Aj53n_2k6L_5U_ViaOhXQ_UR9VPdbCisxhTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

One of the biggest issues is that EC pools do not currently support overwrites.  There is design work underway to address this limitation [1].  As for replacing tmap/omap with xattrs, I heard through the grapevine that the goal is to also support omap directly within an EC pool (via replication).  tmap is used by format 1 RBD images and these images should be deprecated in favor of format 2, so I'm not sure it deserves much effort.  Additionally, all the current class methods used by RBD would need to be supported by the EC pool (rbd::get_id and rbd::object_map_XYZ methods issue a read/write ops).  Finally, any necessary changes would need to carefully consider backwards compatibility with older RBD images, clients, and OSDs.

[1] http://tracker.ceph.com/projects/ceph/wiki/CDM_03-FEB-2016

-- 

Jason Dillaman 


----- Original Message -----
> From: "huang jun" <hjwsm1989@gmail.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, February 17, 2016 10:46:49 AM
> Subject: Use xattr to replace omap operations in rbd
> 
> hi,all
> now, rbd can only use erasure code pool  with cache tier.
> If we want to use rbd + ec, without cache tier,
> that means all rbd operations should be rollback,
> after trace the rbd code, there are many tmap\omap ops which not
> supported by ec.
> can i replace the omap operations to xattr, does it works?
> and for rbd kernel module,what should be done to support rbd +ec?
> 
> By the way, what's main difference between xattr and omap?
> bc the omap performance is better when storing larger bytes?
> 
> --
> thanks
> huangjun
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
