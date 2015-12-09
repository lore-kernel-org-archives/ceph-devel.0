From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: About rbd journal
Date: Tue, 8 Dec 2015 22:58:08 -0500 (EST)
Message-ID: <2147390578.31102155.1449633488780.JavaMail.zimbra@redhat.com>
References: <0e3101d1322f$22a53880$67efa980$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:47075 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbbLID62 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Dec 2015 22:58:28 -0500
In-Reply-To: <0e3101d1322f$22a53880$67efa980$@com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: changtao381 <changtao381@163.com>
Cc: ceph-devel@vger.kernel.org

The in-development RBD journaling feature is designed to be utilized with a future RBD mirroring daemon to perform continuous and point-in-time consistent replication of RBD images to another Ceph cluster (specifically with disaster recovery situations in-mind).  

Until this feature is available and stable, periodic RBD incremental diff exports are probably the best backup alternative.

-- 

Jason Dillaman 


----- Original Message -----
> From: "changtao381" <changtao381@163.com>
> To: dillaman@redhat.com
> Cc: ceph-devel@vger.kernel.org
> Sent: Tuesday, December 8, 2015 10:10:17 PM
> Subject: About rbd journal
> 
> HI,
> 
> There is requirement from customers that need to continuous backup rbd image
> to backup device or another ceph cluster.
> 
> As far as I know , rbd journal can be used to record all the rbd mutations
> to journal which is stored in rados objects in the same ceph cluster
> 
> Is it has interface to push rbd journal  to  another storage device or
> another ceph cluster ? Or is is has dev plan?
> 
> Or anyone has other good way to do backup ?  Thanks very much!
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
