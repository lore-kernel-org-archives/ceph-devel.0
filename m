From: Wido den Hollander <wido@widodh.nl>
Subject: Re: omap functions in librados.h
Date: Fri, 17 Aug 2012 22:24:22 +0200
Message-ID: <502EA876.2090002@widodh.nl>
References: <502E9D44.6010006@widodh.nl> <CAPYLRzhw9BF+9h6y4WUW113oc71OHQnecACNK0sw7oXbqiUpLA@mail.gmail.com> <502EA502.20709@widodh.nl> <CAPYLRzi6PPBEO5GhQoey_+a1e5-btgjpfr-R9j17w7fjqj_3mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:56177 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab2HQUYX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 16:24:23 -0400
In-Reply-To: <CAPYLRzi6PPBEO5GhQoey_+a1e5-btgjpfr-R9j17w7fjqj_3mA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>, Eleanor Cawthon <eleanor.cawthon@inktank.com>



On 08/17/2012 10:13 PM, Gregory Farnum wrote:
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

I'm talking about 6000 objects ranging from 600MB to 4GB each, so that=20
is even stretching the limit of a single object, that's why I would lik=
e=20
that layer on top of librados:=20
http://article.gmane.org/gmane.comp.file-systems.ceph.devel/6176

I would definitely want to take a look at that b-tree database!

Wido

> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
