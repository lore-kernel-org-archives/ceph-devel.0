From: Gregory Meno <gmeno@redhat.com>
Subject: Re: [ceph-calamari] [ceph-users] Does anyone understand Calamari??
Date: Wed, 13 May 2015 15:52:15 -0700
Message-ID: <6FD19CFC-0C99-468B-9B12-A1AD3086F133@redhat.com>
References: <D17908E7.31B8A%mk7193@yp.com> <7E8CF9C16F722345A89076330719CB1F4A825CAB@EXMAIL1.taec.toshiba.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55408 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934657AbbEMWwX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 May 2015 18:52:23 -0400
In-Reply-To: <7E8CF9C16F722345A89076330719CB1F4A825CAB@EXMAIL1.taec.toshiba.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bruce McFarland <Bruce.McFarland@taec.toshiba.com>
Cc: Michael Kuriger <mk7193@yp.com>, "ceph-calamari@lists.ceph.com" <ceph-calamari@lists.ceph.com>, "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>

Wow,

That must be a record. I didn=E2=80=99t realize that.

It turns out that you=E2=80=99ll have the best experience if the versio=
ns of master and minion are in sync.

We test and use 2014.1.5 and are still evaluating 2014.7.Z.

Glad to hear things are working better.

regards,
Gregory



> On May 13, 2015, at 3:33 PM, Bruce McFarland <Bruce.McFarland@taec.to=
shiba.com> wrote:
>=20
> Possibly my issue as well. The calamari master is salt 0.17.5 but the=
 minions are running 2015.2.0rc2. I have to build the minions from sour=
ce (big endian unsupported architecture). All of my salt issues seemed =
to get resolved when I got similar versions of ZMQ running on both mast=
er and minion. The calamari master is running on Ubuntu 14.04.
> =20
> =20
> From: Michael Kuriger [mailto:mk7193@yp.com]=20
> Sent: Wednesday, May 13, 2015 2:00 PM
> To: Bruce McFarland; ceph-calamari@lists.ceph.com; ceph-users@ceph.co=
m; ceph-devel (ceph-devel@vger.kernel.org)
> Subject: Re: [ceph-users] Does anyone understand Calamari??
> =20
> OK, I finally got mine working.  For whatever reason, the latest vers=
ion of salt was the issue for me.  Leaving the latest version of salt o=
n the calamari server is working, but had to downgrade the minions.
> =20
>   Removed:
>     salt.noarch 0:2014.7.5-1.el6        salt-minion.noarch 0:2014.7.5=
-1.el6      =20
>  =20
>   Installed:
>     salt.noarch 0:2014.7.1-1.el6        salt-minion.noarch 0:2014.7.1=
-1.el6      =20
> =20
> This is on CentOS 6.6
> =20
> -=3DMike Kuriger
> =20
> =20
> <image001.png>
> =20
> Michael Kuriger
> Sr. Unix Systems Engineer
> * mk7193@yp.com |( 818-649-7235
> =20
> From: Bruce McFarland <Bruce.McFarland@taec.toshiba.com>
> Date: Tuesday, May 12, 2015 at 4:34 PM
> To: "ceph-calamari@lists.ceph.com" <ceph-calamari@lists.ceph.com>, ce=
ph-users <ceph-users@ceph.com>, "ceph-devel (ceph-devel@vger.kernel.org=
)" <ceph-devel@vger.kernel.org>
> Subject: [ceph-users] Does anyone understand Calamari??
> =20
> Increasing the audience since ceph-calamari is not responsive. What s=
alt event/info does the Calamari Master expect to see from the ceph-mon=
 to determine there is an working cluster? I had to change servers host=
ing the calamari master and can=E2=80=99t get the new machine to recogn=
ize the cluster. The =E2=80=98salt \* ceph.get_heartbeats=E2=80=99 retu=
rns monmap, fsid, ver, epoch, etc for the monitor and all of the osd=E2=
=80=99s. Can anyone point me to docs or code that might enlighten me to=
 what I=E2=80=99m overlooking? Thanks.
> _______________________________________________
> ceph-calamari mailing list
> ceph-calamari@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-calamari-ceph.com

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
