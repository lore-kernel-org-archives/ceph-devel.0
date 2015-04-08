From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Initial newstore vs filestore results
Date: Tue, 07 Apr 2015 20:53:06 -0500
Message-ID: <55248A02.5050602@redhat.com>
References: <5523F069.3000400@redhat.com> <55242D15.8080800@redhat.com> <55248856.1010808@redhat.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD75A03@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35070 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbbDHBxM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 7 Apr 2015 21:53:12 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD75A03@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Somnath,

Sure.  It's very easy:

1) install or build wip-newstore
2) Add the following to your ceph.conf file:

enable experimental unrecoverable data corrupting features = newstore 
rocksdb
osd objectstore = newstore

Lots of interesting things to dig into!

Mark

On 04/07/2015 08:48 PM, Somnath Roy wrote:
> Mark,
> Could you please send the instruction out on how to use this new store?
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Tuesday, April 07, 2015 6:46 PM
> To: ceph-devel
> Subject: Re: Initial newstore vs filestore results
>
>
>
> On 04/07/2015 02:16 PM, Mark Nelson wrote:
>> On 04/07/2015 09:57 AM, Mark Nelson wrote:
>>> Hi Guys,
>>>
>>> I ran some quick tests on Sage's newstore branch.  So far given that
>>> this is a prototype, things are looking pretty good imho.  The 4MB
>>> object rados bench read/write and small read performance looks
>>> especially good.  Keep in mind that this is not using the SSD
>>> journals in any way, so 640MB/s sequential writes is actually really
>>> good compared to filestore without SSD journals.
>>>
>>> small write performance appears to be fairly bad, especially in the
>>> RBD case where it's small writes to larger objects.  I'm going to sit
>>> down and see if I can figure out what's going on.  It's bad enough
>>> that I suspect there's just something odd going on.
>>>
>>> Mark
>>
>> Seekwatcher/blktrace graphs of a 4 OSD cluster using newstore for
>> those
>> interested:
>>
>> http://nhm.ceph.com/newstore/
>>
>> Interestingly small object write/read performance with 4 OSDs was
>> about
>> 1/3-1/4 the speed of the same cluster with 36 OSDs.
>>
>> Note: Thanks Dan for fixing the directory column width!
>>
>> Mark
>
> New fio/librbd results using Sage's latest code that attempts to keep small overwrite extents in the db.  This is 4 OSD so not directly comparable to the 36 OSD tests above, but does include seekwatcher graphs.  Results in MB/s:
>
>          write   read    randw   randr
> 4MB     57.9    319.6   55.2    285.9
> 128KB   2.5     230.6   2.4     125.4
> 4KB     0.46    55.65   1.11    3.56
>
> Seekwatcher graphs:
>
> http://nhm.ceph.com/newstore/20150407/
>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
