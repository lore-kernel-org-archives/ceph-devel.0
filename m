From: Dan Mick <dan.mick@inktank.com>
Subject: Re: rest mgmt api
Date: Wed, 06 Feb 2013 11:36:23 -0800
Message-ID: <5112B0B7.2040802@inktank.com>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net> <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com> <5112AE17.6080605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:63018 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757988Ab3BFTg1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 14:36:27 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so1995240iaj.20
        for <ceph-devel@vger.kernel.org>; Wed, 06 Feb 2013 11:36:26 -0800 (PST)
In-Reply-To: <5112AE17.6080605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org


> My take on this is to keep the current behaviour (client issues a
> command and the monitor handles it as it sees fit), but all
> communication should be done in json, either to or from the monitors.
> This would allow us to provide more information on each result, getting
> rid of all the annoying format on the reply messages and simplify a
> great deal of code on the monitor end by removing the silly need of
> returning on either plain-text or json.  We would then let the
> client-side libraries deal with converting it to whichever format the
> user wants (plain-text, xml, w/e).  As for new commands on the monitor
> that are not present on the library, replies to said commands could then
> be presented just in json, or we could come up with a standardized way
> to always convert json into a human-readable format/any other format.
>
> This would however mean to be able to parse json on the monitors (which
> we do not currently do, although we do produce json output).  I can't
> say I have strong feeling for the client->monitor communication to be
> done in json, but for sake of coherency I do think it would be best.

Sage and I talked briefly about this yesterday; my take is that the 
input doesn't do very much mechanical validation at all; most of it is 
semantic and based on partial results (i.e. "you can't ask for that from 
this object" or "that object you want to operate on doesn't exist"), so 
I'm not sure we win much from JSON input.  There are a few places where 
numbers need to be validated but that's about it; the input is not 
complex, it's pretty much just a list of words for the most part.

but there's also no reason to rule it out for future 
perhaps-more-complex command inputs.

I think having the commands be self-describing and table-driven will 
solve a whole lot of ugliness, and one of the self-description vectors 
can be "this parameter should be validated in this standard way".
