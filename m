From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: userland nfs server
Date: Fri, 29 Jul 2011 12:30:32 -0400 (EDT)
Message-ID: <1843323934.77.1311957032511.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1766745211.75.1311956818895.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([134.215.213.37]:3416 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789Ab1G2Qga (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Jul 2011 12:36:30 -0400
In-Reply-To: <1766745211.75.1311956818895.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

We (Linux Box) have built and published a native FSAL for Ceph, which is pretty advanced, and we've submitted the FSAL driver code upstream for review Philippe Deniel.

In addition, we're working on pNFS support in Ganesha and Ceph, and have a prototype file-based pNFS layout driver for the FSAL that takes advantage of Ceph OSDs for parallel IO.

We're actively extending these efforts and there should be some publication forthcoming.

We have an external git repository here:

    git://github.com/aemerson-linuxbox/ganesha.git

We would really appreciate your feedback--and guidance on how to participate in Ceph, we'd like to.

Matt

----- "Sage Weil" <sage@newdream.net> wrote:

> Has anyone looked at Genesha?
> 
> 	http://sourceforge.net/apps/trac/nfs-ganesha/
> 
> In principle it would probably be pretty straightforward to wire that
> up 
> to libceph and avoid the kernel NFS server for reexporting ceph via
> NFS...
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Matt Benjamin

The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel. 734-761-4689
fax. 734-769-8938
cel. 734-216-5309
