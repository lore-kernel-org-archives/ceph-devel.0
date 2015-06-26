From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: librbd cacher lock protection?
Date: Fri, 26 Jun 2015 12:22:23 -0400 (EDT)
Message-ID: <452241726.25180132.1435335743503.JavaMail.zimbra@redhat.com>
References: <679865E03F4C71419D9847EA3AACB1632A889519@IRSMSX102.ger.corp.intel.com> <885563429.22721443.1435074049868.JavaMail.zimbra@redhat.com> <679865E03F4C71419D9847EA3AACB1632A88B261@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:52083 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbbFZQWZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Jun 2015 12:22:25 -0400
In-Reply-To: <679865E03F4C71419D9847EA3AACB1632A88B261@IRSMSX102.ger.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Maciej Patelczyk <maciej.patelczyk@intel.com>
Cc: ceph-devel@vger.kernel.org

Yes, with RBD striping enabled, it is possible for the image_extent passed to aio_read to contain more than one pair.  For example, if I have a clone of a striped parent image, a simple offset/length read request from the clone could result in an aio_read from the parent with multiple image extents populated.

-- 

Jason Dillaman 
Red Hat 
dillaman@redhat.com 
http://www.redhat.com 


----- Original Message -----
> From: "Maciej Patelczyk" <maciej.patelczyk@intel.com>
> To: "Jason Dillaman" <dillaman@redhat.com>
> Cc: ceph-devel@vger.kernel.org
> Sent: Friday, June 26, 2015 12:00:15 PM
> Subject: RE: librbd cacher lock protection?
> 
> Thank you.
> 
> More questions if I may.
> Librbd interface has rbd_ read/write aio_read/aio_write functions which take
> offset, len.
> Reads/aio_reads are in internal.cc transformed from off/len into
> image_extents pairs. However the common function aio_read is not called
> anywhere apart from API functions. It looks like the image_extents is always
> pair of simple offset/len and there is only one pair in vector. Is that
> correct?
> Write/aio_write keeps pair off/len till last call in the calling chain.
> 
> Is there a valid scenario in which in aio_read there will be more than single
> image_extent? If so which one (except unit tests of course)?
> 
> Thanks,
> maciej
> 
> -----Original Message-----
> From: Jason Dillaman [mailto:dillaman@redhat.com]
> Sent: Tuesday, June 23, 2015 5:41 PM
> To: Patelczyk, Maciej
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: librbd cacher lock protection?
> 
> You are correct that a rx BH can be overwritten by a write request -- this
> will then mark the BH as dirty.  If it's a partial overwrite, the BH will be
> split and only the affected section's state will be changed to dirty.  When
> the outstanding read request completes, it will invoke
> 'ObjectCacher::bh_read_finish', which verifies that the BH is still in the
> rx state (and that the transaction ids match) before overwriting the data.
> The pending client read request will then complete and will be provided the
> latest contents of the BH(s).
> 
> --
> 
> Jason Dillaman
> Red Hat
> dillaman@redhat.com
> http://www.redhat.com
> 
> 
> ----- Original Message -----
> > From: "Maciej Patelczyk" <maciej.patelczyk@intel.com>
> > To: ceph-devel@vger.kernel.org
> > Sent: Tuesday, June 23, 2015 11:21:32 AM
> > Subject: librbd cacher lock protection?
> > 
> > Hi All,
> > 
> > I'm investigating librbd code related to caching (ObjectCacher).
> > What I cannot find is the data integrity protection while there is a
> > 'cache miss' (full or partial). It looks like _readx exits with
> > 'defer' and cache_lock is released (and locked again in LibWriteback).
> > The BufferHead's are marked as 'rx' but not protected against write.
> > Writex is not skipping nor checking for any BH. It's just populating data
> > in cache.
> > That confuses me. So where is the protection? How does the cache
> > integrity protection actually work?
> > 
> > Thanks,
> > maciej
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> > 
