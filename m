From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: [SUGGESTION]Should we provide a method to get git's branch name
 and commit tag?
Date: Thu, 8 Dec 2016 12:36:44 +0800
Message-ID: <CACKY0b8TLkBroE0cw8uvF=TATnqa99kZnQSKtmrS=-CpWHkZYw@mail.gmail.com>
References: <CACKY0b8Y1JFqu-qD-XXUx9ZtLitfFuEaSqamEGK4fD=SspoziA@mail.gmail.com>
 <alpine.DEB.2.11.1612071431140.22485@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34397 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbcLHFnp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2016 00:43:45 -0500
Received: by mail-qt0-f195.google.com with SMTP id l20so47650862qta.1
        for <ceph-devel@vger.kernel.org>; Wed, 07 Dec 2016 21:43:03 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612071431140.22485@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Awesome, thanks!


# ceph daemon /var/run/ceph/ceph-osd.32.asok version
{"version":"0.94.9-166-gbe32c81"}

Is "gbe32c81" git's commit?

[root@node4 /data/home/channingliu]# ceph daemon
/var/run/ceph/ceph-osd.32.asok version
{"version":"0.94.9-166-gbe32c81"}

Sage Weil <sage@newdream.net>=E4=BA=8E2016=E5=B9=B412=E6=9C=887=E6=97=A5=E5=
=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 7 Dec 2016, =E5=88=98=E7=95=85 wrote:
> > hi, all
> >
> > For example, we could register a command "build info" to
> > CephContext::_admin_sock. I would like to implement it if it's useful
> > and necessary.
>
> The 'version' command will give you the commit.  It doesn't show the
> branch name, though.
>
> sage
