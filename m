From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: librbd cacher lock protection?
Date: Tue, 23 Jun 2015 11:40:49 -0400 (EDT)
Message-ID: <885563429.22721443.1435074049868.JavaMail.zimbra@redhat.com>
References: <679865E03F4C71419D9847EA3AACB1632A889519@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:59341 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbbFWPkv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jun 2015 11:40:51 -0400
In-Reply-To: <679865E03F4C71419D9847EA3AACB1632A889519@IRSMSX102.ger.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Maciej Patelczyk <maciej.patelczyk@intel.com>
Cc: ceph-devel@vger.kernel.org

You are correct that a rx BH can be overwritten by a write request -- this will then mark the BH as dirty.  If it's a partial overwrite, the BH will be split and only the affected section's state will be changed to dirty.  When the outstanding read request completes, it will invoke 'ObjectCacher::bh_read_finish', which verifies that the BH is still in the rx state (and that the transaction ids match) before overwriting the data.  The pending client read request will then complete and will be provided the latest contents of the BH(s).

-- 

Jason Dillaman 
Red Hat 
dillaman@redhat.com 
http://www.redhat.com 


----- Original Message -----
> From: "Maciej Patelczyk" <maciej.patelczyk@intel.com>
> To: ceph-devel@vger.kernel.org
> Sent: Tuesday, June 23, 2015 11:21:32 AM
> Subject: librbd cacher lock protection?
> 
> Hi All,
> 
> I'm investigating librbd code related to caching (ObjectCacher).
> What I cannot find is the data integrity protection while there is a 'cache
> miss' (full or partial). It looks like _readx exits with 'defer' and
> cache_lock is released (and locked again in LibWriteback). The BufferHead's
> are marked as 'rx' but not protected against write. Writex is not skipping
> nor checking for any BH. It's just populating data in cache.
> That confuses me. So where is the protection? How does the cache integrity
> protection actually work?
> 
> Thanks,
> maciej
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
