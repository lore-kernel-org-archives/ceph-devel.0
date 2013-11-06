From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Returning the bucket name in RGW response
Date: Wed, 6 Nov 2013 13:12:50 -0800
Message-ID: <CABBk=J88dNmZUhAki0ZvCd1toG9qg=u9UP5UkeTm3WT_EqL7SA@mail.gmail.com>
References: <527A9996.8050402@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:43039 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866Ab3KFVMv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Nov 2013 16:12:51 -0500
Received: by mail-ve0-f169.google.com with SMTP id jy13so56475veb.28
        for <ceph-devel@vger.kernel.org>; Wed, 06 Nov 2013 13:12:50 -0800 (PST)
In-Reply-To: <527A9996.8050402@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Nov 6, 2013 at 11:33 AM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> I'm working on a RGW setup where I'm using Varnish[0] to cache objects, but
> when doing so you run into the problem that a lot of (cached) requests will
> not reach the RGW itself so the accounting of traffic isn't correct.
>
> To overcome this I've been sending all the logs from Varnish to Logstash[1]
> and into ElasticSearch and afterwards analyzing the logs in ElasticSearch to
> find out how much traffic each bucket did.
>
> This method works, but it isn't safe enough. Since I'm currently parsing the
> "Host" header to find out which bucket it was, but this isn't always safe
> since users can CNAME.
>
> So I've been playing with the idea to add the "Rgwx-bucket" header to each
> response which tells you which bucket the request was made to.
>
> In Varnish I can catch this response header and send it to Logstash so I
> have a safer method of which requests was done by which bucket.
>
> I'm using Varnish, but you could do the same with nginx or any HTTP caching
> proxy.
>
> Would it be an idea to add this to RGW? I have it running on my system and
> it works fine, but it's currently a bit hacky.

Yeah, I don't see why not. As long as it's configurable.

>
> A config variable like "rgw expose bucket" could be false by default, but
> when set to true RGW would send the response header with the bucket name.
>
> How does this sound?


Sounds good, just need to see the code now ...

>
> P.S.: When this is all up and running I'm planning to make a cool
> presentation about this for the next Ceph day.
>

Awesome!

Yehuda
