From: Tommi Virtanen <tv@inktank.com>
Subject: Re: omap functions in librados.h
Date: Fri, 17 Aug 2012 13:45:21 -0700
Message-ID: <CADvuQRG9DCp4TWRKRP-DFQ0tYyAG6zXwFfu_UKdXpqk0Y1AMzQ@mail.gmail.com>
References: <502E9D44.6010006@widodh.nl> <CAPYLRzhw9BF+9h6y4WUW113oc71OHQnecACNK0sw7oXbqiUpLA@mail.gmail.com>
 <502EA502.20709@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:45238 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758896Ab2HQUpm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 16:45:42 -0400
Received: by vbbff1 with SMTP id ff1so3723460vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Aug 2012 13:45:41 -0700 (PDT)
In-Reply-To: <502EA502.20709@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 17, 2012 at 1:09 PM, Wido den Hollander <wido@widodh.nl> wrote:
> So yes: "Give me all objects that have foo=bar"
>
> I thought I saw some discussion regarding this.
>
> Any ideas besides setting up a own external database with this information?

What you want is called a secondary index. Ceph does not maintain one for you.

You pretty much have two choices:

1,. use an external service, such as ElasticSearch

2. manage the secondary index yourself: for every key "foo" you want
to query for:
- as you set object "quux" key "foo" to value "bar", in another pool,
set object "foo" key "bar:quux" to value "" (assuming ":" is a safe
separator that cannot be in "bar")
- on delete, remove the above
- on modify, remove old value, add new one
- to handle larger scale, shard the index over multiple objects
etc. There's a lot of prior art in the nosql ecosystem about this
stuff. You could probably take Solandra and port that on top of RADOS
instead of Cassandra, fi you really wanted to.
https://github.com/tjake/Solandra/
