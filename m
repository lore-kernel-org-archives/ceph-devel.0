From: Dan Mick <dan.mick@inktank.com>
Subject: Re: deb/rpm package purge
Date: Wed, 20 Mar 2013 18:08:25 -0700
Message-ID: <514A5D89.5050908@inktank.com>
References: <alpine.DEB.2.00.1303191246330.4850@cobra.newdream.net>  <5148C4EE.5090205@inktank.com> <5148CEC2.2050405@inktank.com>  <alpine.DEB.2.00.1303191349360.4850@cobra.newdream.net>  <1363732049.12547.22.camel@julia>  <alpine.DEB.2.00.1303191528510.4850@cobra.newdream.net>  <1363733473.12547.33.camel@julia>  <alpine.DEB.2.00.1303191554590.4850@cobra.newdream.net>  <1363760969.12547.52.camel@julia>  <alpine.DEB.2.00.1303200545140.11428@cobra.newdream.net> <1363821815.12547.97.camel@julia>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:60299 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab3CUBI2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 21:08:28 -0400
Received: by mail-pb0-f51.google.com with SMTP id un15so1781120pbc.24
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 18:08:28 -0700 (PDT)
In-Reply-To: <1363821815.12547.97.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: Sage Weil <sage@inktank.com>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org, james.page@ubuntu.com


>>>> As a point of comparison, mysql removes the config files but not
>>>> /var/lib/mysql.
>>>> The question is, is that okay/typical/desireable/recommended/a bad=
 idea?
>   I should have asked this sooner. Do you know _any_ program that rem=
oves
> your favorite music collection, your family photos or your business
> emails when you do uninstall it?
> I suspect that your question was theoretical instead.

It's somewhat different in that the data is not owned by one user, but=20
there are clear parallels.  The thing to be careful about here, IMO, is=
=20
not only to preserve the data, but the associated files that allow
(reasonably-easy) access to that data.  (It's no good preserving the OS=
D
filestore if the keys, monmap, or osdmap are gone or hard to recover.)

>> - remove /etc/ceph if it has been untouched
>   This is an other case. dpkg itself handle package files here, calle=
d
> conffiles. I should check the method (md5sum and/or sha1 variants) us=
ed
> for the checksum on these files. On upgrade it's used not to overwrit=
e
> local changes by the user. It may worth to read a bit more about it[1=
]
> from Rapha=EBl Hertzog. He is the co-author of Debian Administrator's
> handbook[2] BTW.

Excellent reference; thanks for the pointer.

>   On purge dpkg will remove the package conffiles no matter what. It
> won't check if those were changed or not. You may not mark the files
> under /etc as conffiles, but then you'll lose the mentioned
> merge logic on upgrades; dpkg will just overwrite those.
>   In short, files under /var/lib/ceph are the only candidates for
> in-package checksumming. How many files under there that essential fo=
r
> the packages?
>
> Laszlo/GCS
> [1] http://raphaelhertzog.com/2010/09/21/debian-conffile-configuratio=
n-file-managed-by-dpkg/
> [2] http://debian-handbook.info/
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
