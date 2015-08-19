From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Wed, 19 Aug 2015 05:06:28 -0400 (EDT)
Message-ID: <380641833.6250870.1439975188966.JavaMail.zimbra@redhat.com>
References: <55D409F0.3050802@redhat.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE1171B@SACMBXIP01.sdcorp.global.sandisk.com> <CACJqLyatyLmdf0ptSuJ5fGrvkQiy-5pOPHFA=h9vuG54xKrngw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:33247 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbbHSJGd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 05:06:33 -0400
In-Reply-To: <CACJqLyatyLmdf0ptSuJ5fGrvkQiy-5pOPHFA=h9vuG54xKrngw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

yes, that's true.

----- Original Message -----
From: "Haomai Wang" <haomaiwang@gmail.com>
To: "Somnath Roy" <Somnath.Roy@sandisk.com>
Cc: "Mark Nelson" <mnelson@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
Sent: Wednesday, August 19, 2015 5:07:53 PM
Subject: Re: Ceph Hackathon: More Memory Allocator Testing

On Wed, Aug 19, 2015 at 1:36 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Mark,
> Thanks for verifying this. Nice report !
> Since there is a big difference in memory consumption with jemalloc, I would say a recovery performance data or client performance data during recovery would be helpful.
>

The RSS memory usage in the report is per OSD I guess(really?). It
can't be ignored since it's really a great improvement memory usage.

> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Tuesday, August 18, 2015 9:46 PM
> To: ceph-devel
> Subject: Ceph Hackathon: More Memory Allocator Testing
>
> Hi Everyone,
>
> One of the goals at the Ceph Hackathon last week was to examine how to improve Ceph Small IO performance.  Jian Zhang presented findings showing a dramatic improvement in small random IO performance when Ceph is used with jemalloc.  His results build upon Sandisk's original findings that the default thread cache values are a major bottleneck in TCMalloc 2.1.  To further verify these results, we sat down at the Hackathon and configured the new performance test cluster that Intel generously donated to the Ceph community laboratory to run through a variety of tests with different memory allocator configurations.  I've since written the results of those tests up in pdf form for folks who are interested.
>
> The results are located here:
>
> http://nhm.ceph.com/hackathon/Ceph_Hackathon_Memory_Allocator_Testing.pdf
>
> I want to be clear that many other folks have done the heavy lifting here.  These results are simply a validation of the many tests that other folks have already done.  Many thanks to Sandisk and others for figuring this out as it's a pretty big deal!
>
> Side note:  Very little tuning other than swapping the memory allocator and a couple of quick and dirty ceph tunables were set during these tests. It's quite possible that higher IOPS will be achieved as we really start digging into the cluster and learning what the bottlenecks are.
>
> Thanks,
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>



-- 
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
