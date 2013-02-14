From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: urgent journal conf on ceph.conf
Date: Thu, 14 Feb 2013 13:52:57 +0000
Message-ID: <511CEC39.8020400@inktank.com>
References: <DUB116-W25AEABD85893916143C7CFE00F0@phx.gbl> <511CEADB.9070001@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:52810 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757584Ab3BNNxH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 08:53:07 -0500
Received: by mail-wi0-f179.google.com with SMTP id ez12so2757387wid.12
        for <ceph-devel@vger.kernel.org>; Thu, 14 Feb 2013 05:53:04 -0800 (PST)
In-Reply-To: <511CEADB.9070001@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: charles L <charlesboy009@hotmail.com>, ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com

Including ceph-users, as it feels like this belongs there :-)


On 02/14/2013 01:47 PM, Wido den Hollander wrote:
> On 02/14/2013 11:24 AM, charles L wrote:
>>
>> Pls can someone help me with the ceph.conf for 0.56.2. I have two
>> servers for STORAGE with 3tb hard drives each and two SSD's each.  I
>> want to use OSD data on the hard drive and osd journal on SSD.
>>
>> I want to know how osd journal configuration is set to SSD. My SSD is
>> mounted on /dev/sdb.
>>
>> I have tried the osd data configurations  devs = /dev/sda and it
>> worked just good.
>>
>> Is this line correct "osd journal = /dev/osd$id/journal" ?? and " osd
>> journal = /dev/sdb " ???
>>
>
> In the osd specific (osd.0 and osd.1) sections you override the journal
> settings made in the [osd] section.
>
> They are not needed, since you give the whole block device (/dev/sdb) to
> the OSD as a journal.
>
> Are you sure /dev/sda is available for the OSD and it's not your boot
> device?
>
> Wido
>
>> [global]
>>
>>                  auth cluster required = cephx
>>                  auth service required = cephx
>>                  auth client required = cephx
>>                  debug ms = 1
>>
>> [osd]
>>                  osd journal size = 1000
>>                  osd journal = /dev/osd$id/journal
>>                  filestore xattr use omap = true
>>                  osd mkfs type = xfs
>>                  osd mkfs options xfs = -f
>>                  osd mount options xfs = rw,noatime,
>>
>> [osd.0]
>>                  host = server04
>>                  devs = /dev/sda
>>                  osd journal = /dev/sdb
>> [osd.1]
>>                  host = server05
>>                  devs = /dev/sda
>>                  osd journal = /dev/sdb
>>
>> THANKS.                           --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>

