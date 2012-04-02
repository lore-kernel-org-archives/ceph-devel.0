From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Failed HD, automate procedure?
Date: Mon, 02 Apr 2012 17:07:07 +0200
Message-ID: <4F79C09B.2040902@widodh.nl>
References: <CAHzdKU+85+aKqr2aQqCcrnzjo4kou3FVQxCLAZpa=OKN_ZNfOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:52888 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2DBPHJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Apr 2012 11:07:09 -0400
In-Reply-To: <CAHzdKU+85+aKqr2aQqCcrnzjo4kou3FVQxCLAZpa=OKN_ZNfOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marco Aroldi <marco.aroldi@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 04/02/2012 12:31 PM, Marco Aroldi wrote:
> Hi all,
> i'm looking the procedure to replace a failed HD
> (http://ceph.newdream.net/wiki/Replacing_a_failed_disk/OSD)

The Wiki is a bit outdated, most of the docs are moving to 
http://ceph.newdream.net/docs/ but the Wiki is still linked on the 
frontpage.

> and I was wondering if the procedure could be more automated like:
>
> 1- The operator replaces the failed hd, say osd.23
> 2- Give a new command like "ceph reborn osd.23"

Currently that isn't available. But some discussion has been going on 
about this: http://marc.info/?l=ceph-devel&m=133106885906229&w=2

That might not seem related at first glance, but it is. Somehow that new 
disk has to be formatted and linked to the new OSD.

A OSD simply wants a data directory were to store it's data.

If you replace the disk, something/somebody has to format that disk and 
make sure it's mounted.

When that's done, the OSD can format the fresh data directory and 
connect to the cluster again.

The OSD also needs the current monitor map and needs his key to 
authenticate to the cluster.

That data needs to come from somewhere, some form of external 
involvement is needed to get this done.

To make the story short: This is on the radar.

Wido

>
> Thanks, thanks to all the community for this big piece of software!
> Marco Aroldi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
