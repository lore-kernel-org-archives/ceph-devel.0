From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Links to various language bindings
Date: Tue, 12 Feb 2013 12:29:12 -0800
Message-ID: <511AA618.2040802@inktank.com>
References: <5114BFFD.1060807@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:35706 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab3BLU3R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Feb 2013 15:29:17 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so199300dak.33
        for <ceph-devel@vger.kernel.org>; Tue, 12 Feb 2013 12:29:17 -0800 (PST)
In-Reply-To: <5114BFFD.1060807@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/08/2013 01:06 AM, Wido den Hollander wrote:
> Hi,
>
> I knew that there were Java bindings for RADOS, but they weren't linked.
>
> Well, some searching on Github lead me to Noah's bindings [0], but it
> was a bit of searching.
>
> I expect new users to be less fortunate and end up searching endlessly
> for them.
>
> The docs say this now:
> http://ceph.com/docs/master/api/#rados-object-store-apis
>
> Only the libcephfs bindings are linked to, but they are part of the main
> repository (which still puzzles me..).
>
> For what I know bindings exist for Java[0], PHP[1] and Python, but it's
> not to be found anywhere.
>
> Shall I submit a patch to put this in the docs or should this go on
> ceph.com itself?

I think it'd be good to include in the docs.

There are also Erlang bindings written against the current api:
https://github.com/renzhi/erlrados

There are a couple written against the older api, which wouldn't work
anymore, but wouldn't be too hard to update:

Ruby: https://github.com/johnl/desperados
Haskell: https://github.com/athanatos/librados.hsc

> I'd go for the docs so we can also include some simple samples for
> people who are less experienced with Ceph/RADOS and just want to get
> started, maybe developers who's only task is just to work with RADOS.
>
> Wido
>
> [0]: https://github.com/noahdesu/java-rados
> [1]: https://github.com/ceph/phprados

