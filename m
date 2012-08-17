From: Gregory Farnum <greg@inktank.com>
Subject: Re: omap functions in librados.h
Date: Fri, 17 Aug 2012 13:13:18 -0700
Message-ID: <CAPYLRzi6PPBEO5GhQoey_+a1e5-btgjpfr-R9j17w7fjqj_3mA@mail.gmail.com>
References: <502E9D44.6010006@widodh.nl>
	<CAPYLRzhw9BF+9h6y4WUW113oc71OHQnecACNK0sw7oXbqiUpLA@mail.gmail.com>
	<502EA502.20709@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60087 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758820Ab2HQUNU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 16:13:20 -0400
Received: by lbbgj3 with SMTP id gj3so2338508lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Aug 2012 13:13:18 -0700 (PDT)
In-Reply-To: <502EA502.20709@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>, Eleanor Cawthon <eleanor.cawthon@inktank.com>

On Fri, Aug 17, 2012 at 1:09 PM, Wido den Hollander <wido@widodh.nl> wr=
ote:
>
>
> On 08/17/2012 09:54 PM, Gregory Farnum wrote:
>>
>> On Fri, Aug 17, 2012 at 12:36 PM, Wido den Hollander <wido@widodh.nl=
>
>> wrote:
>>>
>>> Hi,
>>>
>>> I'm looking for the omap functions in librados.h, but they only see=
m to
>>> be
>>> implemented in librados.hpp?
>>>
>>> I want to store about 6000 objects in a RADOS pool, but I want to g=
ive
>>> them
>>> some attributes I can query for, this should be possible with the o=
map
>>> functionality, shouldn't it?
>>
>> What do you mean, query for? You can look at an object and ask if it
>> has "foo=3Dbar" in its omap, but you can't say "give me all objects =
with
>> 'foo=3Dbar'".
>>
>
> Ah, I must have understood that differently. I thought that leveldb w=
as
> added so you could give objects attributes you could query.
No, leveldb is just a nice fast store =97=A0sorry!

> So yes: "Give me all objects that have foo=3Dbar"
>
> I thought I saw some discussion regarding this.
>
> Any ideas besides setting up a own external database with this inform=
ation?

Well, you could maintain the data in a single rados object, if it
doesn't need to get too large. Or Eleanor (one of our friendly
interns!) has been writing a prototype distributed b-tree database
thingy that you might want to look at.
But there are presently no plans to (or ideas of how to) implement a
generic query-able set of attributes which are co-located with nodes.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
