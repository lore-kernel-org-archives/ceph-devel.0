From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 0/4] libceph: nocephx_sign_messages option + misc
Date: Tue, 3 Nov 2015 11:36:52 +0800
Message-ID: <BD35DE10-9518-4DC4-9B30-ADDD7F6DEE23@redhat.com>
References: <1446504250-25647-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38734 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754187AbbKCDg7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Nov 2015 22:36:59 -0500
In-Reply-To: <1446504250-25647-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org


> On Nov 3, 2015, at 06:44, Ilya Dryomov <idryomov@gmail.com> wrote:
> 
> Hello,
> 
> This adds nocephx_sign_messages libceph option (a lack of which is
> something people are running into, see [1]), plus a couple of related
> cleanups.
> 
> [1] https://forum.proxmox.com/threads/24116-new-krbd-option-on-pve4-don-t-work
> 
> Thanks,
> 
>                Ilya
> 
> 
> Ilya Dryomov (4):
>  libceph: msg signing callouts don't need con argument
>  libceph: drop authorizer check from cephx msg signing routines
>  libceph: stop duplicating client fields in messenger
>  libceph: add nocephx_sign_messages option
> 
> fs/ceph/mds_client.c           | 14 ++++++++------
> include/linux/ceph/libceph.h   |  4 +++-
> include/linux/ceph/messenger.h | 16 +++-------------
> net/ceph/auth_x.c              |  8 ++++++--
> net/ceph/ceph_common.c         | 18 +++++++++++++-----
> net/ceph/messenger.c           | 32 ++++++++++++--------------------
> net/ceph/osd_client.c          | 14 ++++++++------
> 7 files changed, 53 insertions(+), 53 deletions(-)
> 

Reviewed-by: Yan, Zheng <zyan@redhat.com>


