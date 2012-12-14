From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: osd crash after reboot
Date: Fri, 14 Dec 2012 09:20:56 -0600
Message-ID: <50CB43D8.3020603@inktank.com>
References: <50CADF58.4010902@profihost.ag> <50CAE1AA.80801@profihost.ag> <50CAEDE5.9070509@profihost.ag> <50CB3D33.7070800@conversis.de> <50CB3F32.2070106@inktank.com> <50CB41BE.8020300@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:62646 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289Ab2LNPU4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Dec 2012 10:20:56 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so6023089ieb.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Dec 2012 07:20:56 -0800 (PST)
In-Reply-To: <50CB41BE.8020300@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Dennis Jacobfeuerborn <dennisml@conversis.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Stefan,

Here's what I often do when I have a journal and data partition sharing 
a disk:

sudo parted -s -a optimal /dev/$DEV mklabel gpt
sudo parted -s -a optimal /dev/$DEV mkpart osd-device-$i-journal 0% 10G
sudo parted -s -a optimal /dev/$DEV mkpart osd-device-$i-data 10G 100%

Mark

On 12/14/2012 09:11 AM, Stefan Priebe - Profihost AG wrote:
> Hi Mark,
>
> but do i set a label for a partition without FS like the journal blockdev?
> Am 14.12.2012 16:01, schrieb Mark Nelson:
>> I often map partitions to something in /dev/disk/by-partlabel and use
>> those in my ceph.conf files.  that way disks can be remapped behind the
>> scenes and the ceph configuration doesn't have to change even if disks
>> get replaced.
>
> Greets,
> Stefan

