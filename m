From: kefu chai <tchaikov@gmail.com>
Subject: Re: ceph-disk broken????
Date: Fri, 6 May 2016 12:49:25 +0800
Message-ID: <CAJE9aOM2HmZP79JumjD5+oAypye3fvFx-nfO1=uYjdg+_+z9Hw@mail.gmail.com>
References: <5e9940d6-d9bb-e9b4-0af8-49e0f0cbb0f5@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33140 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbcEFEt0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2016 00:49:26 -0400
Received: by mail-yw0-f196.google.com with SMTP id y6so14902507ywe.0
        for <ceph-devel@vger.kernel.org>; Thu, 05 May 2016 21:49:26 -0700 (PDT)
In-Reply-To: <5e9940d6-d9bb-e9b4-0af8-49e0f0cbb0f5@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, May 5, 2016 at 4:44 AM, Willem Jan Withagen <wjw@digiware.nl> w=
rote:
> Hi
>
> Setup:
>   Fresh VM with CentOS7
>   standard ceph/ceph clone
>   building with run-make-check.sh
>      So the dependancies are installed by install-deps.sh
>
> I have several tests that fail with:
>
>  run_osd:  ceph-disk --statedir=3Dtestdir/osd-crush
> --sysconfdir=3Dtestdir/osd-crush --prepend-to-path=3D prepare
> testdir/osd-crush/0
> Traceback (most recent call last):
>   File "/tmp/ceph-disk-virtualenv/bin/ceph-disk", line 5, in <module>
>     from pkg_resources import load_entry_point
>   File
> "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pkg_resources.=
py",
> line 3007, in <module>
>     working_set.require(__requires__)
>   File
> "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pkg_resources.=
py",
> line 728, in require
>     needed =3D self.resolve(parse_requirements(requirements))
>   File
> "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pkg_resources.=
py",
> line 626, in resolve
>     raise DistributionNotFound(req)
> pkg_resources.DistributionNotFound: ceph-disk=3D=3D1.0.0
>
> Looks like ceph-disk is not in the fresh install in tmp...
>
> Ran into this with my development fork, but then also with a regular =
HEAD
> Did I miss something?

Willem, you are not missing anything. the problem you are facing is wha=
t
happens in our jenkins sometimes. for example, see
https://jenkins.ceph.com/job/ceph-pull-requests/5222/consoleFull . Lo=C3=
=AFc tried
to root cause this, and found that it only happens in rhel7.0.

>
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards
Kefu Chai
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
