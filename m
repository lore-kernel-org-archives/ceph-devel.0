From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/3] block I/O when cluster is full
Date: Mon, 09 Dec 2013 16:11:34 -0800
Message-ID: <52A65C36.9060105@inktank.com>
References: <1386112373-25610-1-git-send-email-josh.durgin@inktank.com>	<52A12CA9.3020008@inktank.com>	<CAPYLRzj+NE-g=NAt9P-x1dtvLFFFBHZmrwJSU4hxBuXiJaQbfA@mail.gmail.com>	<52A284F8.7020602@inktank.com> <CAPYLRzgLX=dni9cD2f4sANHTNqPrvr8=wZdTKHj0J5NSOgU0wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:45239 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab3LJALg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Dec 2013 19:11:36 -0500
Received: by mail-yh0-f41.google.com with SMTP id f11so3394472yha.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Dec 2013 16:11:35 -0800 (PST)
In-Reply-To: <CAPYLRzgLX=dni9cD2f4sANHTNqPrvr8=wZdTKHj0J5NSOgU0wQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/06/2013 06:24 PM, Gregory Farnum wrote:
> On Fri, Dec 6, 2013 at 6:16 PM, Josh Durgin <josh.durgin@inktank.com>=
 wrote:
>> On 12/05/2013 08:58 PM, Gregory Farnum wrote:
>>>
>>> On Thu, Dec 5, 2013 at 5:47 PM, Josh Durgin <josh.durgin@inktank.co=
m>
>>> wrote:
>>>>
>>>> On 12/03/2013 03:12 PM, Josh Durgin wrote:
>>>>>
>>>>>
>>>>> These patches allow rbd to block writes instead of returning erro=
rs
>>>>> when OSDs are full enough that the FULL flag is set in the osd ma=
p.
>>>>> This avoids filesystems on top of rbd getting confused by transie=
nt
>>>>> EIOs if the cluster oscillates between full and non-full.
>>>>>
>>>>> These are also available in the wip-full branch of ceph-client.gi=
t.
>>>>>
>>>>> Josh Durgin (3):
>>>>>      libceph: block I/O when PAUSE or FULL osd map flags are set
>>>>>      libceph: add an option to configure client behavior when osd=
s are
>>>>>        full
>>>>>      rbd: document rbd-specific options
>>>>
>>>>
>>>>
>>>> Due to a race condition between clients and osds in handling maps
>>>> marked FULL, it's not feasible to offer the 'error' option, so pat=
ches
>>>> 2 and 3 can be ignored.
>>>>
>>>> http://tracker.ceph.com/issues/6938
>>>
>>>
>>> It's not clear to me =97 are you going to assume all ENOSPC means t=
he
>>> map is marked as full and intercept it, or that you can't reliably
>>> block IO so don't bother trying?
>>
>>
>> Don't bother trying to stop ENOSPC on the client side, since it'd ne=
ed some
>> restructuring in the kernel side and would be prone to screwing up
>> write ordering.
>>
>> Instead drop writes on the osd side when they have a map marked full=
,
>> and have clients resend all writes when a map goes transitions from
>> full -> nonfull. The userspace side is https://github.com/ceph/ceph/=
pull/914
>
> Do previous client implementations already satisfy that requirement?
> We can't drop requests if older clients expect a response...

No, previous clients do not do this. For old rbd clients, this turns a
potential corruption into a hang, which is a good trade-off imo.

=46or userspace clients, this only happens when the osd gets the FULL m=
ap
first, and rejects a write in flight before the client got a FULL map.

The kernel client already rejects writes at the fs layer when the FULL
flag is set, so kcephfs will only be affected when it hits this race as
well.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
