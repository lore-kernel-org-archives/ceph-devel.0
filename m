From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: silence logrotate some more
Date: Wed, 6 Feb 2013 12:51:15 -0800
Message-ID: <30D1B51B-1D4B-474A-87C2-F7E413D3AC0D@inktank.com>
References: <ormwvhnyj2.fsf@livre.home>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61959 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758625Ab3BFUvT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 15:51:19 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so2480734iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Feb 2013 12:51:19 -0800 (PST)
In-Reply-To: <ormwvhnyj2.fsf@livre.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: ceph-devel@vger.kernel.org

Hi Alex -

This patch has been merged to master.  I made the same change to the ne=
w rgw logrotate.conf.

Cheers,
Gary

On Feb 6, 2013, at 9:27 AM, Alexandre Oliva wrote:

> I was getting email with logrotate error output from =93which invoke-=
rc.d=94
> on systems without an invoke-rc.d.  This patch silences it.
>=20
> Silence stderr from which when running logrotate
>=20
> From: Alexandre Oliva <oliva@gnu.org>
>=20
> Signed-off-by: Alexandre Oliva <oliva@gnu.org>
> ---
> src/logrotate.conf |    9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/logrotate.conf b/src/logrotate.conf
> index 9af3104..c443eed 100644
> --- a/src/logrotate.conf
> +++ b/src/logrotate.conf
> @@ -4,13 +4,16 @@
>     compress
>     sharedscripts
>     postrotate
> -        if which invoke-rc.d > /dev/null && [ -x `which invoke-rc.d`=
 ]; then
> +        if which invoke-rc.d > /dev/null 2>&1 &&=20
> +	   [ -x `which invoke-rc.d` ]; then
>             invoke-rc.d ceph reload >/dev/null
> -        elif which service > /dev/null && [ -x `which service` ]; th=
en
> +        elif which service > /dev/null 2>&1 &&=20
> +	     [ -x `which service` ]; then
>             service ceph reload >/dev/null
>         fi
>         # Possibly reload twice, but depending on ceph.conf the reloa=
d above may be a no-op
> -        if which initctl > /dev/null && [ -x `which initctl` ]; then
> +        if which initctl > /dev/null 2>&1 &&=20
> +	   [ -x `which initctl` ]; then
>             # upstart reload isn't very helpful here:
>             #   https://bugs.launchpad.net/upstart/+bug/1012938
>             for type in mon osd mds; do
>=20
>=20
> --=20
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist      Red Hat Brazil Compiler Engineer

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
