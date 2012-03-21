From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Problem about writing configuration file
Date: Wed, 21 Mar 2012 10:29:33 +0100
Message-ID: <4F699F7D.8010602@widodh.nl>
References: <CALwGbPKkq0Dj=SiYAaJjNeA6zme_DwbiL_e-dVMjD_HcRsAxGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:44435 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757137Ab2CUJ3g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 05:29:36 -0400
In-Reply-To: <CALwGbPKkq0Dj=SiYAaJjNeA6zme_DwbiL_e-dVMjD_HcRsAxGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 03/21/2012 10:26 AM, =E8=83=A1=E7=80=9A=E6=A3=AE wrote:
> I created my own configuration file.
> Unfortunately for some reason, I cannot use BTRFS at the moment.
>
> In that case, if I want to use ext4 as OSD FS, what should I write in
> my configuration file?
>
> And are there any official guide about the configuration file?

Just make sure your "osd data" points to the right direction for storin=
g=20
the OSD data.

Also, make sure that you enable user_xattr for the ext4 fileystem.

Wido

>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
