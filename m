From: Dan Mick <dan.mick@inktank.com>
Subject: Re: ceph admin command: debuggging
Date: Thu, 08 Aug 2013 12:32:02 -0700
Message-ID: <5203F232.9030802@inktank.com>
References: <20130808160417.3589315c@doppio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34478 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966205Ab3HHTcH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Aug 2013 15:32:07 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so3729279pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Aug 2013 12:32:06 -0700 (PDT)
In-Reply-To: <20130808160417.3589315c@doppio>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Bluemle <andreas.bluemle@itxperts.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

There are a number of subsystems that the clients use, so a number of 
knobs that matter.  The "logging/authentication name" (the type.id 
name), by default, is 'client.admin'.  Some of the relevant logging 
knobs are ms/monc; of course there are usually effects caused by the 
daemons too, so the mon/osd logs will contain things triggered by the 
client.

What sort of things are you looking for specifically?

On 08/08/2013 07:04 AM, Andreas Bluemle wrote:
> Hi,
>
> maybe this is the wrong list - but I am looking for
> logging support for the /usr/bin/ceph adminstration
> comamand.
>
> This is build from the same source as the ceph daemons are.
>
> For the daemons, logging is controlled for the different
> comoponents of a daemon on behalf of configuration file
> directives (e.g. "debug ms" for the message I/O).
>
> Can this be applied to the /usr/bin/ceph command, too?
> And where would the log file go?
>
>
> Thanks for any help
>
> Andreas Bluemle
>

