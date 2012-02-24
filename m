From: Martin Mailand <martin@tuxadero.com>
Subject: Re: [Crowbar] barclamp-ceph and crowbar
Date: Fri, 24 Feb 2012 17:34:38 +0100
Message-ID: <4F47BC1E.1000405@tuxadero.com>
References: <CAJBrc2tq856-_CJbC9Ls4MkPWrsXo-+JMy736_ww9CDQGTEoHw@mail.gmail.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:33592 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab2BXQen (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2012 11:34:43 -0500
In-Reply-To: <CAJBrc2tq856-_CJbC9Ls4MkPWrsXo-+JMy736_ww9CDQGTEoHw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Alberts <john.m.alberts@gmail.com>
Cc: crowbar@dell.com, ceph-devel@vger.kernel.org

Hi John,
I tried them a few weeks ago, they are developed for crowbar version 1.1 
and doesn't seem to work with 1.2. If I want to create a proposal, the 
next page is white and an error is log.
The barclamp installs one ceph-mon node, and several ceph-store nodes. 
The glue to connect your virtual machine to the ceph-store is not 
included in the barclamp.

-martin

On 24.02.2012 15:46, John Alberts wrote:
> Does anyone know what I can do with barclamp-ceph?
> https://github.com/NewDreamNetwork/barclamp-ceph
> The code hasn't been touched since it's initial import 4 months ago.
> Does it allow me to easily use ceph for /var/lib/instances on compute
> hosts so I can use features like live migration easily?
>
> Thanks
> John
>
> _______________________________________________
> Crowbar mailing list
> Crowbar@dell.com
> https://lists.us.dell.com/mailman/listinfo/crowbar
> For more information: https://github.com/dellcloudedge/crowbar/wiki

