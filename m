From: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Subject: Re: civetweb upstream
Date: Sun, 8 Feb 2015 10:54:44 +0300
Message-ID: <CAMWPydQ00kDEq5ihVpa7iJ+Gb=zHWh_=Wr8cSZ08MK_UtwGbSQ@mail.gmail.com>
References: <54D4DDAE.50604@redhat.com>
	<391658056.205926.1423242173510.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:46687 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbbBHHyq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Feb 2015 02:54:46 -0500
Received: by mail-we0-f179.google.com with SMTP id u56so15614106wes.10
        for <ceph-devel@vger.kernel.org>; Sat, 07 Feb 2015 23:54:44 -0800 (PST)
In-Reply-To: <391658056.205926.1423242173510.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Feb 6, 2015 at 8:02 PM, Yehuda Sadeh-Weinraub <yehuda@redhat.com> wrote:
>
>
> ----- Original Message -----
>> From: "Ken Dreyer" <kdreyer@redhat.com>
>> To: ceph-devel@vger.kernel.org
>> Sent: Friday, February 6, 2015 7:28:46 AM
>> Subject: civetweb upstream
>>
>> Hi folks,
>>
>> It looks like Ceph has its own fork of the upstream civetweb project.
>> What was the reason for forking at the time? Has there been much effort
>> to get our civetweb changes upstream?
>>
>
> The biggest motivation originally was to get it integrated into our automake system, as it was using weird suffixes for some include file. When civetweb was split out of mongoose, they made some changes to the code structure that made it harder to embed into our system. Later on there were some relatively minor changes and bug fixes. We might be able to push some upstream as is, and some might need to be reworked so that they'd make sense in that context.
>
> Yehuda

I posted on another thread about changing the upstream before reading
this, sorry about that, but I think this should be done before Hammer
release.

Regards
Mustafa
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
