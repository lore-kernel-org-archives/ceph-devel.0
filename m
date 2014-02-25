From: Gregory Farnum <greg@inktank.com>
Subject: Re: Assertion error in librados
Date: Tue, 25 Feb 2014 09:51:28 -0800
Message-ID: <CAPYLRzjDLMQZqk=DRsQMrtKa_zQJNFxFztNu++u6FJon-miqLA@mail.gmail.com>
References: <20140225144900.GA30739@philipgian-mac>
	<CAPYLRzhnPTEgycnmZ0HXeEW=ADe01QKS8nUmL8451rYYtoMvgw@mail.gmail.com>
	<20140225155838.GB30739@philipgian-mac>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:55892 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbaBYRv2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 12:51:28 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so772187qaq.15
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 09:51:28 -0800 (PST)
In-Reply-To: <20140225155838.GB30739@philipgian-mac>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Filippos Giannakos <philipgian@grnet.gr>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, synnefo-devel@googlegroups.com

Nope; it's an entirely local problem. I'm kind of surprised there
wasn't more logging available in the same location you got the core
dump, but it's possible the log generation is turned off (in addition
to the log dumping).

The Dispatch lock and the messenger lock are distinct, Yehuda, and the
messenger and pipe locks are the only ones we should be grabbing in
submit_message. Unless you were referring to something else?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Tue, Feb 25, 2014 at 7:58 AM, Filippos Giannakos <philipgian@grnet.gr> wrote:
> Hi Greg,
>
> Unfortunately we don't keep any Ceph related logs on the client side. On the
> server side, we kept the default log settings to avoid overlogging.
> Do you think that there might be something usefull on the OSD side ?
>
> On Tue, Feb 25, 2014 at 07:28:30AM -0800, Gregory Farnum wrote:
>> Do you have logs? The assert indicates that the messenger got back
>> something other than "okay" when trying to grab a local Mutex, which
>> shouldn't be able to happen. It may be that some error-handling path
>> didn't drop it (within the same thread that later tried to grab it
>> again), but we'll need more details to track it down.
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>
> Kind Regards,
> --
> Filippos
> <philipgian@grnet.gr>
