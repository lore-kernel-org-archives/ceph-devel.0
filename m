From: Wido den Hollander <wido@42on.com>
Subject: Re: question about ceph and FC SAN LUN data IO path
Date: Mon, 13 May 2013 14:34:11 +0200
Message-ID: <5190DDC3.7030604@42on.com>
References: <5190DB83.9010007@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:57917 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819Ab3EMMeN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 May 2013 08:34:13 -0400
In-Reply-To: <5190DB83.9010007@tnsoft.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dennis Chen <xschen@tnsoft.com.cn>
Cc: ceph-devel@vger.kernel.org

On 05/13/2013 02:24 PM, Dennis Chen wrote:
> Hi,
>
> If I have an OSD attached by a FC SAN device with the connection like this:
> OSD HBA-->FC Switch-->SAN storage device.
>
> Then Map a LUN in the SAN to the OSD as its only disk device to save
> data. if I have a client also has an HBA and the topology diagram looks
> like:
>
>                    osd                                         client
>          -------        -------                            ------- -------
>         | HBA |      | NIC |  <---------------> | NIC |   | HBA |
>          ---+---      --------                            ------- -------
> \                                                            /
>                    \ /
>                         \                                   /
>                                \    --------------
>                                    | FC Switch |
>                                     --------------
>                                            |
>                                         SAN
>
> Suppose the created LUN above for OSD can be accessed by both osd and
> client though FC I/F, the question is:
> if I create a rbd block device in osd and map it to client, make a file
> system and mount it in client side, then create a file in the mounted
> FS. The read/write operation followed for this file will transfer data
> though ethernet path or FC path?
>

That will follow the Ethernet path.

I'm also trying to figure out why you would Ceph here and use RBD? If 
the client has direct access to the FC, why not have the client access 
that direcly?

Ceph makes sense when you are running it on multiple fully separated 
machines, but not if you run it all one one FC SAN imho.

Wido

> BRs,
> Dennis
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
