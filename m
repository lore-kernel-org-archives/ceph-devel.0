From: Roman Alekseev <rs.alekseev@gmail.com>
Subject: Re: rbd image association
Date: Mon, 03 Jun 2013 11:17:16 +0400
Message-ID: <51AC42FC.1040703@gmail.com>
References: <51AC3D1E.2000800@gmail.com> <20130603070836.GA2422@nix.wogri.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:55057 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab3FCHRT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jun 2013 03:17:19 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so3128235lab.15
        for <ceph-devel@vger.kernel.org>; Mon, 03 Jun 2013 00:17:17 -0700 (PDT)
In-Reply-To: <20130603070836.GA2422@nix.wogri.at>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>, ceph-devel@vger.kernel.org

On 03.06.2013 11:08, Wolfgang Hennerbichler wrote:
> On Mon, Jun 03, 2013 at 10:52:14AM +0400, Roman Alekseev wrote:
>> Hi,
>>
>> Is it possible to associate certain rbd device with the appropriate
>> rbd image (for example : image1 > /dev/rbd0)?
>> We always need to map image1 to /dev/rbd0, image2 to /dev/rbd1 etc.
>> Because I'm using /dev/rbd* in some configuration files.
> Hi,
>
> I can't remember exactly, but I think there is something like /dev/rbd/<pool>/<imagename> which simply symlinks to /dev/rbdX. This should solve your issue.
>   
>> Thanks
> HTH
> Wolfgang
>
Dear Wolfgang,

I was trying to use the command ln -s /dev/rbd1 image1 but it creates 
wrong symlink. Most likely there is more specific command to symlink the 
image and device correctly.

Thanks.

-- 
Kind regards,

R. Alekseev

