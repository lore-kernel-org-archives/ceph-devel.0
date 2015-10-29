From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: pg scrub check problem
Date: Thu, 29 Oct 2015 08:42:13 +0800
Message-ID: <CANE=7sXK0tfFbarVQ22ywuQpz9xh=F2=QmHqu37QNYh7Si0nRg@mail.gmail.com>
References: <000001d11164$7fa470a0$7eed51e0$@com>
	<alpine.DEB.2.00.1510281712280.1004@cobra.newdream.net>
	<563167B3.1040504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:33398 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbJ2AmN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Oct 2015 20:42:13 -0400
Received: by obbwb3 with SMTP id wb3so21482135obb.0
        for <ceph-devel@vger.kernel.org>; Wed, 28 Oct 2015 17:42:13 -0700 (PDT)
In-Reply-To: <563167B3.1040504@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: Sage Weil <sage@newdream.net>, changtao381 <changtao381@163.com>, ceph-devel <ceph-devel@vger.kernel.org>

Yes, I think we should also the scrub_interval.

OSD::sched_scrub()
{
      if ((double)diff < cct->_conf->osd_scrub_min_interval) {
dout(10) << "sched_scrub " << pgid << " at " << t
<< ": " << (double)diff << " < min (" <<
cct->_conf->osd_scrub_min_interval << " seconds)" << dendl;
break;
      }
      if ((double)diff < cct->_conf->osd_scrub_max_interval && !load_is_low) {
// save ourselves some effort
dout(10) << "sched_scrub " << pgid << " high load at " << t
<< ": " << (double)diff << " < max (" <<
cct->_conf->osd_scrub_max_interval << " seconds)" << dendl;
break;
      }
}

2015-10-29 8:26 GMT+08:00 David Zafman <dzafman@redhat.com>:
>
> Good point.  In my previous response I did "echo garbage >
> ........./foo__head_7FC1F406__1" to corrupt a replica.
>
> David
>
>
> On 10/28/15 5:13 PM, Sage Weil wrote:
>>
>> Becuse you *just* wrote the object, and the FileStore caches open file
>> handles.  Vim renames a new inode over the old one so the open inode is
>> untouched.
>>
>> If you restart the osd and then scrub you'll see the error.
>>
>> sage
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
xinze
