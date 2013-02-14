From: Wido den Hollander <wido@42on.com>
Subject: Re: urgent journal conf on ceph.conf
Date: Thu, 14 Feb 2013 14:47:07 +0100
Message-ID: <511CEADB.9070001@42on.com>
References: <DUB116-W25AEABD85893916143C7CFE00F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:41335 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757726Ab3BNNrK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Feb 2013 08:47:10 -0500
In-Reply-To: <DUB116-W25AEABD85893916143C7CFE00F0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: charles L <charlesboy009@hotmail.com>
Cc: ceph-devel@vger.kernel.org

On 02/14/2013 11:24 AM, charles L wrote:
>
> Pls can someone help me with the ceph.conf for 0.56.2. I have two servers for STORAGE with 3tb hard drives each and two SSD's each.  I want to use OSD data on the hard drive and osd journal on SSD.
>
> I want to know how osd journal configuration is set to SSD. My SSD is mounted on /dev/sdb.
>
> I have tried the osd data configurations  devs = /dev/sda and it worked just good.
>
> Is this line correct "osd journal = /dev/osd$id/journal" ?? and " osd journal = /dev/sdb " ???
>

In the osd specific (osd.0 and osd.1) sections you override the journal 
settings made in the [osd] section.

They are not needed, since you give the whole block device (/dev/sdb) to 
the OSD as a journal.

Are you sure /dev/sda is available for the OSD and it's not your boot 
device?

Wido

> [global]
>
>                  auth cluster required = cephx
>                  auth service required = cephx
>                  auth client required = cephx
>                  debug ms = 1
>
> [osd]
>                  osd journal size = 1000
>                  osd journal = /dev/osd$id/journal
>                  filestore xattr use omap = true
>                  osd mkfs type = xfs
>                  osd mkfs options xfs = -f
>                  osd mount options xfs = rw,noatime,
>
> [osd.0]
>                  host = server04
>                  devs = /dev/sda
>                  osd journal = /dev/sdb
> [osd.1]
>                  host = server05
>                  devs = /dev/sda
>                  osd journal = /dev/sdb
>
> THANKS. 		 	   		  --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
