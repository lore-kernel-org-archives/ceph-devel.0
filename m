From: Roman Alekseev <rs.alekseev@gmail.com>
Subject: Re: rbd image association
Date: Mon, 03 Jun 2013 18:54:19 +0400
Message-ID: <51ACAE1B.3090803@gmail.com>
References: <51AC3D1E.2000800@gmail.com> <20130603070836.GA2422@nix.wogri.at> <51AC42FC.1040703@gmail.com> <51AC4717.7010304@42on.com> <51AC4980.4010000@gmail.com> <alpine.DEB.2.00.1306030748240.18537@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:54094 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758536Ab3FCOyW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jun 2013 10:54:22 -0400
Received: by mail-lb0-f177.google.com with SMTP id y6so828709lbh.36
        for <ceph-devel@vger.kernel.org>; Mon, 03 Jun 2013 07:54:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1306030748240.18537@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Wido den Hollander <wido@42on.com>, Wolfgang Hennerbichler <wolfgang.hennerbichler@risc-software.at>, ceph-devel@vger.kernel.org

On 03.06.2013 18:49, Sage Weil wrote:
> On Mon, 3 Jun 2013, Roman Alekseev wrote:
>> On 03.06.2013 11:34, Wido den Hollander wrote:
>>> udev takes car
>> Do you mean we need to create some rules in /etc/udev/rules.d/ directory and
>> after running rbd -p pool map image my image will be mapped with appropriate
>> device?
> The ceph package installs a udev rules file in that directory; you
> shouldn't have to do anything other than the 'rbd map ..' command.  If it
> is not already present, there must be something wrong with the package on
> the platform you are using.  What OS is it?
>
>> If so, could you please provide me with the commands which should be presented
>> in that file?
>>
>> Thanks
>>
>> -- 
>> Kind regards,
>>
>> R. Alekseev
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
Yep, u're right there is only the file 70-persistent-net.rules in 
/etc/udev/rules.d/ directory.
It is Debian Wheezy 3.2.0-4-amd64

thanks

-- 
Kind regards,

R. Alekseev

