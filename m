From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: how to remove laggy mds ?
Date: Fri, 3 Feb 2012 13:34:21 -0800
Message-ID: <CAF3hT9Bh2EBgVm8OO82akiLbqeKRmbv0WxB5hx0D29hZADiMwg@mail.gmail.com>
References: <4F2C3A10.1040605@shadow.gt.owl.de>
	<CAORUGqD2q3G+aEGVBJ4+68YAyA+Wy_0RyGi=J_f3qMRHLG_Ljg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38272 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab2BCVeV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 16:34:21 -0500
Received: by ggnh1 with SMTP id h1so2110702ggn.19
        for <ceph-devel@vger.kernel.org>; Fri, 03 Feb 2012 13:34:21 -0800 (PST)
In-Reply-To: <CAORUGqD2q3G+aEGVBJ4+68YAyA+Wy_0RyGi=J_f3qMRHLG_Ljg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: =?ISO-8859-1?Q?Jens_Rehp=F6hler?= <jens@shadow.gt.owl.de>, ceph-devel@vger.kernel.org

On Fri, Feb 3, 2012 at 1:19 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Fri, Feb 3, 2012 at 11:48, Jens Rehp=F6hler <jens@shadow.gt.owl.de=
> wrote:
>> one of my test mds servers died a few days ago. (hardware crash) I w=
ill
>> not buy a new one.
>>
>> Is there any chance to remove this laggy mds ?
>
> Start the mds daemon somewhere. If you don't want to fix/replace the
> hardware, well, start it somewhere else. It has no local state.
>
> Decreasing the number of active mdses is not currently supported.

Actually, it should work, if you have a daemon running for that MDS.
Once it's running, execute "ceph mds stop 1" and it should export
authority to the remaining MDS and shut down cleanly.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
