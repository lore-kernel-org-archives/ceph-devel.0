From: John Wilkins <john.wilkins@inktank.com>
Subject: Re: Links to various language bindings
Date: Tue, 12 Feb 2013 14:53:04 -0800
Message-ID: <CAM2gkg6uB5+hEB=eY4MjGb96VBjeDvNeSBBpquoXUvzuu6gugw@mail.gmail.com>
References: <5114BFFD.1060807@widodh.nl>
	<511AA618.2040802@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:46226 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab3BLWxF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Feb 2013 17:53:05 -0500
Received: by mail-vc0-f173.google.com with SMTP id fy7so400567vcb.32
        for <ceph-devel@vger.kernel.org>; Tue, 12 Feb 2013 14:53:04 -0800 (PST)
In-Reply-To: <511AA618.2040802@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Also, be sure to open bugs and assign them to me.

On Tue, Feb 12, 2013 at 12:29 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> On 02/08/2013 01:06 AM, Wido den Hollander wrote:
>>
>> Hi,
>>
>> I knew that there were Java bindings for RADOS, but they weren't linked.
>>
>> Well, some searching on Github lead me to Noah's bindings [0], but it
>> was a bit of searching.
>>
>> I expect new users to be less fortunate and end up searching endlessly
>> for them.
>>
>> The docs say this now:
>> http://ceph.com/docs/master/api/#rados-object-store-apis
>>
>> Only the libcephfs bindings are linked to, but they are part of the main
>> repository (which still puzzles me..).
>>
>> For what I know bindings exist for Java[0], PHP[1] and Python, but it's
>> not to be found anywhere.
>>
>> Shall I submit a patch to put this in the docs or should this go on
>> ceph.com itself?
>
>
> I think it'd be good to include in the docs.
>
> There are also Erlang bindings written against the current api:
> https://github.com/renzhi/erlrados
>
> There are a couple written against the older api, which wouldn't work
> anymore, but wouldn't be too hard to update:
>
> Ruby: https://github.com/johnl/desperados
> Haskell: https://github.com/athanatos/librados.hsc
>
>
>> I'd go for the docs so we can also include some simple samples for
>> people who are less experienced with Ceph/RADOS and just want to get
>> started, maybe developers who's only task is just to work with RADOS.
>>
>> Wido
>>
>> [0]: https://github.com/noahdesu/java-rados
>> [1]: https://github.com/ceph/phprados
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
John Wilkins
Senior Technical Writer
Intank
john.wilkins@inktank.com
(415) 425-9599
