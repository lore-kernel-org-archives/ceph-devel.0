From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 0/3] block I/O when cluster is full
Date: Fri, 6 Dec 2013 18:24:55 -0800
Message-ID: <CAPYLRzgLX=dni9cD2f4sANHTNqPrvr8=wZdTKHj0J5NSOgU0wQ@mail.gmail.com>
References: <1386112373-25610-1-git-send-email-josh.durgin@inktank.com>
	<52A12CA9.3020008@inktank.com>
	<CAPYLRzj+NE-g=NAt9P-x1dtvLFFFBHZmrwJSU4hxBuXiJaQbfA@mail.gmail.com>
	<52A284F8.7020602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:39246 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab3LGCY5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Dec 2013 21:24:57 -0500
Received: by mail-wi0-f169.google.com with SMTP id hn6so1757207wib.2
        for <ceph-devel@vger.kernel.org>; Fri, 06 Dec 2013 18:24:56 -0800 (PST)
In-Reply-To: <52A284F8.7020602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Dec 6, 2013 at 6:16 PM, Josh Durgin <josh.durgin@inktank.com> w=
rote:
> On 12/05/2013 08:58 PM, Gregory Farnum wrote:
>>
>> On Thu, Dec 5, 2013 at 5:47 PM, Josh Durgin <josh.durgin@inktank.com=
>
>> wrote:
>>>
>>> On 12/03/2013 03:12 PM, Josh Durgin wrote:
>>>>
>>>>
>>>> These patches allow rbd to block writes instead of returning error=
s
>>>> when OSDs are full enough that the FULL flag is set in the osd map=
=2E
>>>> This avoids filesystems on top of rbd getting confused by transien=
t
>>>> EIOs if the cluster oscillates between full and non-full.
>>>>
>>>> These are also available in the wip-full branch of ceph-client.git=
=2E
>>>>
>>>> Josh Durgin (3):
>>>>     libceph: block I/O when PAUSE or FULL osd map flags are set
>>>>     libceph: add an option to configure client behavior when osds =
are
>>>>       full
>>>>     rbd: document rbd-specific options
>>>
>>>
>>>
>>> Due to a race condition between clients and osds in handling maps
>>> marked FULL, it's not feasible to offer the 'error' option, so patc=
hes
>>> 2 and 3 can be ignored.
>>>
>>> http://tracker.ceph.com/issues/6938
>>
>>
>> It's not clear to me =97 are you going to assume all ENOSPC means th=
e
>> map is marked as full and intercept it, or that you can't reliably
>> block IO so don't bother trying?
>
>
> Don't bother trying to stop ENOSPC on the client side, since it'd nee=
d some
> restructuring in the kernel side and would be prone to screwing up
> write ordering.
>
> Instead drop writes on the osd side when they have a map marked full,
> and have clients resend all writes when a map goes transitions from
> full -> nonfull. The userspace side is https://github.com/ceph/ceph/p=
ull/914

Do previous client implementations already satisfy that requirement?
We can't drop requests if older clients expect a response...
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
