From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: Re: [ceph-users] Problem installing ceph from package manager / ceph repositories
Date: Tue, 10 Jun 2014 08:22:10 -0400
Message-ID: <CANtztVwCJx_=bR-mpct0i3j=xaMxreRJw0X9PF1CE7X07o-jgA@mail.gmail.com>
References: <4849752F-2209-4D3F-B934-C670ADBB9CDC@csc.fi>
	<4DC842D9-8254-4519-9034-1E76F0BF3C84@csc.fi>
	<C108D0D0-F5F3-4E73-B12E-2196C8FD652B@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:39779 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbaFJMWL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jun 2014 08:22:11 -0400
Received: by mail-yk0-f182.google.com with SMTP id 19so2178340ykq.27
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jun 2014 05:22:10 -0700 (PDT)
In-Reply-To: <C108D0D0-F5F3-4E73-B12E-2196C8FD652B@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Van Der Ster <daniel.vanderster@cern.ch>
Cc: Karan Singh <karan.singh@csc.fi>, "ceph-users@ceph.com" <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jun 10, 2014 at 4:34 AM, Dan Van Der Ster
<daniel.vanderster@cern.ch> wrote:
> Hi,
>
> On 10 Jun 2014, at 10:30, Karan Singh <karan.singh@csc.fi> wrote:
>
> Hello Cephers
>
> First of all this problem is not related to ceph-deploy , ceph-deploy=
 1.5.4
> works like charm :-) , thanks for Alfredo
>
> Problem :
>
> 1. When installing Ceph using package manger ( # yum install ceph  or=
  # yum
> update cehp) that uses ceph repositories (cep.repo) , the package man=
ager
> does not respect the ceph.repo file and takes ceph package directly f=
rom
> EPEL . But when i disable EPEL repo and again try to install ceph , i=
t takes
> from ceph repo.  This is a new problem and earlier i have not faced t=
his ,
> though i have done several ceph cluster installation with package man=
ager. I
> don=E2=80=99t want EPEL version of Ceph.
>
>
> You probably need to tweak the repo priorities. We use priority=3D30 =
for
> epel.repo, priority=3D5 for ceph.repo.
>

This is exactly what ceph-deploy is now doing. It is installing the
priorities plugin for yum
and then setting a very low number for ceph.repo (1 I believe)

This is explained in the last release announcement for ceph-deploy and
for more details
you can see this ticket:  http://tracker.ceph.com/issues/8533

> Cheers, Dan
>
>
> -- Dan van der Ster || Data & Storage Services || CERN IT Department =
--
>
>
> 2. When i uninstall ceph , from system its repository file i.e. ceph.=
repo is
> getting removed . Is this normal , i have not seen this before.
>
>
> Any one else facing the same problem or have solution to this.
>
>
> Regards
> Karan Singh
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
