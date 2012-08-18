From: Xiaopong Tran <xiaopong.tran@gmail.com>
Subject: Re: omap functions in librados.h
Date: Sat, 18 Aug 2012 10:25:15 +0800
Message-ID: <502EFD0B.3030401@gmail.com>
References: <502E9D44.6010006@widodh.nl> <CAPYLRzhw9BF+9h6y4WUW113oc71OHQnecACNK0sw7oXbqiUpLA@mail.gmail.com> <502EA502.20709@widodh.nl> <CAPYLRzi6PPBEO5GhQoey_+a1e5-btgjpfr-R9j17w7fjqj_3mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64370 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756440Ab2HRCZT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 22:25:19 -0400
Received: by pbbrr13 with SMTP id rr13so4204577pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Aug 2012 19:25:18 -0700 (PDT)
In-Reply-To: <CAPYLRzi6PPBEO5GhQoey_+a1e5-btgjpfr-R9j17w7fjqj_3mA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>, Eleanor Cawthon <eleanor.cawthon@inktank.com>

On 08/18/2012 04:13 AM, Gregory Farnum wrote:
> On Fri, Aug 17, 2012 at 1:09 PM, Wido den Hollander <wido@widodh.nl> =
wrote:
>>
>>
>> On 08/17/2012 09:54 PM, Gregory Farnum wrote:
>>>
>>> On Fri, Aug 17, 2012 at 12:36 PM, Wido den Hollander <wido@widodh.n=
l>
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> I'm looking for the omap functions in librados.h, but they only se=
em to
>>>> be
>>>> implemented in librados.hpp?
>>>>
>>>> I want to store about 6000 objects in a RADOS pool, but I want to =
give
>>>> them
>>>> some attributes I can query for, this should be possible with the =
omap
>>>> functionality, shouldn't it?
>>>
>>> What do you mean, query for? You can look at an object and ask if i=
t
>>> has "foo=3Dbar" in its omap, but you can't say "give me all objects=
 with
>>> 'foo=3Dbar'".
>>>
>>
>> Ah, I must have understood that differently. I thought that leveldb =
was
>> added so you could give objects attributes you could query.
> No, leveldb is just a nice fast store =97 sorry!
>
>> So yes: "Give me all objects that have foo=3Dbar"
>>
>> I thought I saw some discussion regarding this.
>>
>> Any ideas besides setting up a own external database with this infor=
mation?
>
> Well, you could maintain the data in a single rados object, if it
> doesn't need to get too large. Or Eleanor (one of our friendly
> interns!) has been writing a prototype distributed b-tree database
> thingy that you might want to look at.
> But there are presently no plans to (or ideas of how to) implement a
> generic query-able set of attributes which are co-located with nodes.
> -Greg
> --

Where is this distributed b-tree located? Is it open source as well?
I'd be very interested too.

Regards,

Xiaopong


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
