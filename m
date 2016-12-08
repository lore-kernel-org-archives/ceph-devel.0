From: Haomai Wang <haomai@xsky.com>
Subject: Re: [SUGGESTION]Should we provide a method to get git's branch name
 and commit tag?
Date: Thu, 8 Dec 2016 14:23:08 +0800
Message-ID: <CACJqLyba68pAOVcjO_rOPV8Vyb_GYOV2a5Uhk3GRzjWr0_KZPQ@mail.gmail.com>
References: <CACKY0b8Y1JFqu-qD-XXUx9ZtLitfFuEaSqamEGK4fD=SspoziA@mail.gmail.com>
 <alpine.DEB.2.11.1612071431140.22485@piezo.novalocal> <CACKY0b8TLkBroE0cw8uvF=TATnqa99kZnQSKtmrS=-CpWHkZYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0100.outbound.protection.outlook.com ([104.47.124.100]:45568
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750827AbcLHGXY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Dec 2016 01:23:24 -0500
Received: by mail-ua0-f169.google.com with SMTP id 12so439271112uas.2
        for <ceph-devel@vger.kernel.org>; Wed, 07 Dec 2016 22:23:19 -0800 (PST)
In-Reply-To: <CACKY0b8TLkBroE0cw8uvF=TATnqa99kZnQSKtmrS=-CpWHkZYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Dec 8, 2016 at 12:36 PM, liuchang0812 <liuchang0812@gmail.com> wrot=
e:
> Awesome, thanks!
>
>
> # ceph daemon /var/run/ceph/ceph-osd.32.asok version
> {"version":"0.94.9-166-gbe32c81"}
>
> Is "gbe32c81" git's commit?

be32c81

>
> [root@node4 /data/home/channingliu]# ceph daemon
> /var/run/ceph/ceph-osd.32.asok version
> {"version":"0.94.9-166-gbe32c81"}
>
> Sage Weil <sage@newdream.net>=E4=BA=8E2016=E5=B9=B412=E6=9C=887=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:31=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Wed, 7 Dec 2016, =E5=88=98=E7=95=85 wrote:
>> > hi, all
>> >
>> > For example, we could register a command "build info" to
>> > CephContext::_admin_sock. I would like to implement it if it's useful
>> > and necessary.
>>
>> The 'version' command will give you the commit.  It doesn't show the
>> branch name, though.
>>
>> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
