From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/3] block I/O when cluster is full
Date: Fri, 06 Dec 2013 18:16:24 -0800
Message-ID: <52A284F8.7020602@inktank.com>
References: <1386112373-25610-1-git-send-email-josh.durgin@inktank.com>	<52A12CA9.3020008@inktank.com> <CAPYLRzj+NE-g=NAt9P-x1dtvLFFFBHZmrwJSU4hxBuXiJaQbfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:36556 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530Ab3LGCQm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Dec 2013 21:16:42 -0500
Received: by mail-yh0-f46.google.com with SMTP id l109so1117266yhq.33
        for <ceph-devel@vger.kernel.org>; Fri, 06 Dec 2013 18:16:42 -0800 (PST)
In-Reply-To: <CAPYLRzj+NE-g=NAt9P-x1dtvLFFFBHZmrwJSU4hxBuXiJaQbfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/05/2013 08:58 PM, Gregory Farnum wrote:
> On Thu, Dec 5, 2013 at 5:47 PM, Josh Durgin <josh.durgin@inktank.com>=
 wrote:
>> On 12/03/2013 03:12 PM, Josh Durgin wrote:
>>>
>>> These patches allow rbd to block writes instead of returning errors
>>> when OSDs are full enough that the FULL flag is set in the osd map.
>>> This avoids filesystems on top of rbd getting confused by transient
>>> EIOs if the cluster oscillates between full and non-full.
>>>
>>> These are also available in the wip-full branch of ceph-client.git.
>>>
>>> Josh Durgin (3):
>>>     libceph: block I/O when PAUSE or FULL osd map flags are set
>>>     libceph: add an option to configure client behavior when osds a=
re
>>>       full
>>>     rbd: document rbd-specific options
>>
>>
>> Due to a race condition between clients and osds in handling maps
>> marked FULL, it's not feasible to offer the 'error' option, so patch=
es
>> 2 and 3 can be ignored.
>>
>> http://tracker.ceph.com/issues/6938
>
> It's not clear to me =97 are you going to assume all ENOSPC means the
> map is marked as full and intercept it, or that you can't reliably
> block IO so don't bother trying?

Don't bother trying to stop ENOSPC on the client side, since it'd need=20
some restructuring in the kernel side and would be prone to screwing up
write ordering.

Instead drop writes on the osd side when they have a map marked full,
and have clients resend all writes when a map goes transitions from
full -> nonfull. The userspace side is https://github.com/ceph/ceph/pul=
l/914

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
