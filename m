From: Wido den Hollander <wido@widodh.nl>
Subject: Re: cephx auth question
Date: Tue, 12 Jun 2012 11:52:43 +0200
Message-ID: <4FD7116B.9030003@widodh.nl>
References: <CAMmJxtJViXYznfRuzMqJsvWZ7YEghkgD2HUhHZ9h4AyaXFz+cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:50590 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab2FLJwq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jun 2012 05:52:46 -0400
In-Reply-To: <CAMmJxtJViXYznfRuzMqJsvWZ7YEghkgD2HUhHZ9h4AyaXFz+cA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

Hi,

On 06/12/2012 11:31 AM, John Axel Eriksson wrote:
> I asked a similar question in a previous email but I didn't get any
> satisfying answers. What exactly does cephx auth secure?

I wanted to get back on your e-mail from yesterday, but you beat me to 
it! :)

>  From the wiki I just get "this makes your cluster more secure", well
> from what? If I run on an internal network accessible only
> by a few trusted people - what does cephx auth secure in such a scenario?
>

Never ever trust anything, even in a local network. Security has more 
aspects then just uninvited guests accessing or modifying your data.

Like I said in the previous e-mail, it prevents you from having an old 
machine or just a plain configuration error on a client disrupting 
cluster service.

> In that previous email I got the answer that it secures the cluster
> from mistakenly connecting to wrong cluster with rados and
> accidentally deleting a pool... well, can rados really "accidentally"
> connect to the wrong cluster? Only if I have the wrong config
> file right? And if I have the wrong config-file won't it be possible
> that I also have the "wrong" key in that case?
>

The "rados" command doesn't really need a config file, you can also 
specify the monitor address manually.

$ rados -p <mon address> rmpool data

If you'd issue that with the wrong monitor address while playing in your 
local network you could remove the pool on the wrong cluster.

With cephx in place you also have to specify the correct key, it's just 
a second layer in place from preventing something like this happening.

> Another scenario would be if I take down an OSD that just sits in
> storage for say 6 months and then someone starts that machine
> again - with key-based auth that OSD wouldn't be able to
> connect(somehow? but if it has a working key?) but without auth it
> could
> possibly connect and wreak havoc in the cluster (since it is so much
> behind perhaps in both version of software and what's stored on it).
> I thought marking and OSD as down or out would do that?
>

If you mark an OSD out it will get marked as "in" again when you start 
up the OSD, but that also depends on your settings like "noautoin".

When you take an OSD out of production with cephx you would also remove 
the corresponding OSD key from the cluster keyring.

> Are those the main reasons for having cephx auth? Is it to secure the
> cluster against people (myself included) making mistakes or  from
> hacking, or is there some technical reason that I don't know of or understand?
>

It can serve multiple purposes. In a bigger env you should never trust 
any machine. So if you have a client which only has access to the "rbd" 
pool for running Virtual Machines, it shouldn't get more permissions 
than that.

So yes, it's again human error, but if a machine gets hacked, you can 
prevent that machine from ruining your whole cluster.

> The reason I'm asking is because having cephx enabled makes cluster
> setup much more complicated...
>

cephx might be complicated at first glance, but it isn't really that hard.

It is up to you if you enable it, but take the recommendations above 
into account when making your decision.

Wido

>
> Thanks,
>
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

