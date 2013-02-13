From: Wido den Hollander <wido@42on.com>
Subject: Re: Links to various language bindings
Date: Wed, 13 Feb 2013 20:21:55 +0100
Message-ID: <511BE7D3.3000008@42on.com>
References: <5114BFFD.1060807@widodh.nl> <511AA618.2040802@inktank.com> <CAM2gkg6uB5+hEB=eY4MjGb96VBjeDvNeSBBpquoXUvzuu6gugw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:40706 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757167Ab3BMTV5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Feb 2013 14:21:57 -0500
In-Reply-To: <CAM2gkg6uB5+hEB=eY4MjGb96VBjeDvNeSBBpquoXUvzuu6gugw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Wilkins <john.wilkins@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/12/2013 11:53 PM, John Wilkins wrote:
> Also, be sure to open bugs and assign them to me.
>

Yes! Although I'll probably write some docs as well (if I get them to 
build...). I'll sent patches or pull requests.

So we have the following bindings/extensions/whatever:

librados:
* Python
* Java (rados4j?)
* PHP
* C
* C++ (native)
* Ruby?

librbd:
* Python

I still want to wrap librbd in PHP and Java (CloudStack probably) as well.

Did I miss something? Anyway, I created a ticket for this: 
http://tracker.ceph.com/issues/4117

Wido


> On Tue, Feb 12, 2013 at 12:29 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
>> On 02/08/2013 01:06 AM, Wido den Hollander wrote:
>>>
>>> Hi,
>>>
>>> I knew that there were Java bindings for RADOS, but they weren't linked.
>>>
>>> Well, some searching on Github lead me to Noah's bindings [0], but it
>>> was a bit of searching.
>>>
>>> I expect new users to be less fortunate and end up searching endlessly
>>> for them.
>>>
>>> The docs say this now:
>>> http://ceph.com/docs/master/api/#rados-object-store-apis
>>>
>>> Only the libcephfs bindings are linked to, but they are part of the main
>>> repository (which still puzzles me..).
>>>
>>> For what I know bindings exist for Java[0], PHP[1] and Python, but it's
>>> not to be found anywhere.
>>>
>>> Shall I submit a patch to put this in the docs or should this go on
>>> ceph.com itself?
>>
>>
>> I think it'd be good to include in the docs.
>>
>> There are also Erlang bindings written against the current api:
>> https://github.com/renzhi/erlrados
>>
>> There are a couple written against the older api, which wouldn't work
>> anymore, but wouldn't be too hard to update:
>>
>> Ruby: https://github.com/johnl/desperados
>> Haskell: https://github.com/athanatos/librados.hsc
>>
>>
>>> I'd go for the docs so we can also include some simple samples for
>>> people who are less experienced with Ceph/RADOS and just want to get
>>> started, maybe developers who's only task is just to work with RADOS.
>>>
>>> Wido
>>>
>>> [0]: https://github.com/noahdesu/java-rados
>>> [1]: https://github.com/ceph/phprados
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
