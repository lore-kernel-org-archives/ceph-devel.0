From: Dan Mick <dan.mick@inktank.com>
Subject: Re: rest mgmt api
Date: Wed, 06 Feb 2013 13:19:02 -0800
Message-ID: <5112C8C6.5020402@inktank.com>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net> <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com> <5112AE17.6080605@inktank.com> <alpine.DEB.2.00.1302061130220.13326@cobra.newdream.net> <5112B43D.6070602@bmrb.wisc.edu> <alpine.DEB.2.00.1302061211550.13326@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:59240 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758026Ab3BFVTH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 16:19:07 -0500
Received: by mail-ia0-f174.google.com with SMTP id o25so2187860iad.33
        for <ceph-devel@vger.kernel.org>; Wed, 06 Feb 2013 13:19:06 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302061211550.13326@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>, ceph-devel@vger.kernel.org



On 02/06/2013 12:14 PM, Sage Weil wrote:
> On Wed, 6 Feb 2013, Dimitri Maziuk wrote:
>> On 02/06/2013 01:34 PM, Sage Weil wrote:
>>
>>> I think the one caveat here is that having a single registry for commands
>>> in the monitor means that commands can come in two flavors: vector<string>
>>> (cli) and URL (presumably in json form).  But a single command
>>> dispatch/registry framework will make that distinction pretty simple...
>>
>> Any reason you can't have your CLI json-encode the commands (or,
>> conversely, your cgi/wsgi/php/servlet URL handler decode them into
>> vector<string>) before passing them on to the monitor?
>
> We can, but they won't necessarily look the same, because it is unlikely
> we can make a sane 1:1 translation of the CLI to REST that makes sense,
> and it would be nice to avoid baking knowledge about the individual
> commands into the client side.
>
>   ceph osd pool create <poolname> <numpgs>
>     vs
>   /osd/pool/?op=create&poolname=foo&numpgs=bar
>
> or whatever.  I know next to nothing about REST API design best practices,
> but I'm guessing it doesn't look like a CLI.
>
> sage

Well we could easily package, say, "mon getmap" into a json
vector-of-strings for transmission as the http payload of the PUT
request, *or* encode them as a simple "s1=mon&s2=getmap", but again, the
data format is so simple that I'm not sure it buys much. We definitely
want all the interpretation centralized in the daemons, I think, so this
is just string marshalling however we choose to do it.
