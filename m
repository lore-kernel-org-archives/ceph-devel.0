From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: ./make-debs.sh / dpkg-buildpackage failed because of
 override_dh_auto_configure from debian/rules
Date: Thu, 4 Aug 2016 08:37:48 -0600
Message-ID: <CALqRxCx4hQs634_YE07RswiKCcZ_S+NyUSvP8F0ihV0ApC9QJw@mail.gmail.com>
References: <DB5PR05MB1607E14365A8266A29A7E260A9060@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36579 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbcHDOht (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Aug 2016 10:37:49 -0400
Received: by mail-vk0-f42.google.com with SMTP id n129so169063852vke.3
        for <ceph-devel@vger.kernel.org>; Thu, 04 Aug 2016 07:37:49 -0700 (PDT)
In-Reply-To: <DB5PR05MB1607E14365A8266A29A7E260A9060@DB5PR05MB1607.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Would you please paste more output above the lines you've pasted
there? The failure is higher up in the log.

- Ken

On Wed, Aug 3, 2016 at 5:42 AM, Avner Ben Hanoch <avnerb@mellanox.com> wrote:
> Hi all,
>
> Running ./make-debs.sh from Ceph master branch on Ubuntu-16.04 produces the error below:
> =====
>     debian/rules:25: recipe for target 'override_dh_auto_configure' failed
>     make[1]: *** [override_dh_auto_configure] Error 2
>     make[1]: Leaving directory '/mnt/sdh/avnerb/deb-v11.0.0/Ubuntu/WORKDIR/ceph-11.0.0-1228-gc162a8a'
>     debian/rules:22: recipe for target 'build' failed
>     make: *** [build] Error 2
>     dpkg-buildpackage: error: debian/rules build gave error exit status 2
> =====
> I saw that recently there were changes in this area for gitbuilder to enable cmake. Perhaps it is related??
>
> Anyhow, is there a way to create deb packages? Or, is there a plan to fix this situation?
> TIA,
>   Avner
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
