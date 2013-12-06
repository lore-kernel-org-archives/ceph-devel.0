From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 0/3] block I/O when cluster is full
Date: Thu, 5 Dec 2013 20:58:11 -0800
Message-ID: <CAPYLRzj+NE-g=NAt9P-x1dtvLFFFBHZmrwJSU4hxBuXiJaQbfA@mail.gmail.com>
References: <1386112373-25610-1-git-send-email-josh.durgin@inktank.com>
	<52A12CA9.3020008@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:64180 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab3LFE6M convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Dec 2013 23:58:12 -0500
Received: by mail-we0-f171.google.com with SMTP id q58so161595wes.16
        for <ceph-devel@vger.kernel.org>; Thu, 05 Dec 2013 20:58:11 -0800 (PST)
In-Reply-To: <52A12CA9.3020008@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Dec 5, 2013 at 5:47 PM, Josh Durgin <josh.durgin@inktank.com> w=
rote:
> On 12/03/2013 03:12 PM, Josh Durgin wrote:
>>
>> These patches allow rbd to block writes instead of returning errors
>> when OSDs are full enough that the FULL flag is set in the osd map.
>> This avoids filesystems on top of rbd getting confused by transient
>> EIOs if the cluster oscillates between full and non-full.
>>
>> These are also available in the wip-full branch of ceph-client.git.
>>
>> Josh Durgin (3):
>>    libceph: block I/O when PAUSE or FULL osd map flags are set
>>    libceph: add an option to configure client behavior when osds are
>>      full
>>    rbd: document rbd-specific options
>
>
> Due to a race condition between clients and osds in handling maps
> marked FULL, it's not feasible to offer the 'error' option, so patche=
s
> 2 and 3 can be ignored.
>
> http://tracker.ceph.com/issues/6938

It's not clear to me =97 are you going to assume all ENOSPC means the
map is marked as full and intercept it, or that you can't reliably
block IO so don't bother trying?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
