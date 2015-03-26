From: Mark Nelson <mnelson@redhat.com>
Subject: Re: tcmalloc issue
Date: Thu, 26 Mar 2015 18:53:15 -0500
Message-ID: <55149BEB.9080207@redhat.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CAD14A@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45035 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847AbbCZXxS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Mar 2015 19:53:18 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F28CAD14A@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

FWIW, I've seen perf top traces like this in the past.  It's making me 
wonder how many times I've seen this and not connected the dots.

Mark

On 03/26/2015 06:18 PM, Somnath Roy wrote:
> Sage,
> Here is the tcmalloc issue I was talking in the performance meeting.
>
> http://code.google.com/p/gperftools/issues/detail?id=585
>
> The tcmalloc is consuming lot of cpus (and eventually slowing down the performance) with the following perf top  trace.
>
> 25.73% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::FetchFromSpans()
> 12.52% libtcmalloc.so.4.1.2 [.] tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::FreeList*, unsigned long, int)
> 11.62% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::ReleaseToSpans(void*)
> 1.56% [kernel] [k] __copy_user_nocache
> 1.44% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::RemoveRange(void*, void*, int)
> 1.39% libtcmalloc.so.4.1.2 [.] tcmalloc::CentralFreeList::ReleaseListToSpans(void*)
> 0.89% libtcmalloc.so.4.1.2 [.] operator new(unsigned long)
>
>
> The TCMALLOC_MAX_TOTAL_THREAD_CACHE_BYTES is alleviating that but the env variable setting for this is a noop in the binary we are having in Ubuntu 14.04. It is fixed in gperftools-2.1.90 release.
> See the following link.
>
> http://code.google.com/p/gperftools/
>
> We can request Ubuntu guys to incorporate this version or the latest tcmalloc version which is gperftools-2.4.
>
> It will be really helpful if you can push them to incorporate this in 14.04 updates.
>
> Thanks & Regards
> Somnath
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
