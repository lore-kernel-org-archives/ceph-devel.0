From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: =?UTF-8?Q?Re=3A_some_bugs_when_cluster_name_is_not_=E2=80=98ceph=27?=
Date: Thu, 17 Jul 2014 15:43:36 -0400
Message-ID: <CANtztVypUYTZm+YMf-6jx5SMZ6j_F=T7e-kMcAryzoEs08TZMw@mail.gmail.com>
References: <tencent_2FAE500D23138B8C713B9511@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:43334 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbaGQTvm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jul 2014 15:51:42 -0400
Received: by mail-oa0-f50.google.com with SMTP id g18so1440345oah.23
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jul 2014 12:51:42 -0700 (PDT)
In-Reply-To: <tencent_2FAE500D23138B8C713B9511@qq.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yy <yy@xspring.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 16, 2014 at 12:37 PM, yy <yy@xspring.net> wrote:
> Hi, we found some bugs when cluster name is not =E2=80=98ceph' in ver=
sion 0.80.1,
> -----
> diff --git a/src/ceph-disk b/src/ceph-disk
> index f79e341..153e344 100755
> --- a/src/ceph-disk
> +++ b/src/ceph-disk
> @@ -1611,6 +1611,8 @@ def start_daemon(
>                  [
>                      svc,
>                      'ceph',
> +                    '-c',
> +                    '/etc/ceph/{cluster}.conf'.format(cluster=3Dclus=
ter),
>                      'start',
>                      'osd.{osd_id}'.format(osd_id=3Dosd_id),
>                      ],
> diff --git a/src/ceph_common.sh b/src/ceph_common.sh
> index 01781b7..8d14a3c 100644
> --- a/src/ceph_common.sh
> +++ b/src/ceph_common.sh
> @@ -49,13 +49,13 @@ check_host() {
>      get_conf user "" "user"
>
>      #echo host for $name is $host, i am $hostname
> -
> -    if [ -e "/var/lib/ceph/$type/ceph-$id/upstart" ]; then
> +    cluster=3D$1

Are we always passing `$1` here? What happens when `check_host` is
called with no arguments? It seems to
me that we should default to `ceph` but reading this, doesn't look like=
 we do.


> +    if [ -e "/var/lib/ceph/$type/$cluster-$id/upstart" ]; then
>         return 1
>      fi
>
>      # sysvinit managed instance in standard location?
> -    if [ -e "/var/lib/ceph/$type/ceph-$id/sysvinit" ]; then
> +    if [ -e "/var/lib/ceph/$type/$cluster-$id/sysvinit" ]; then
>         host=3D"$hostname"
>         echo "=3D=3D=3D $type.$id =3D=3D=3D "
>         return 0
> diff --git a/src/init-ceph.in b/src/init-ceph.in
> index 846bd57..24c52d9 100644
> --- a/src/init-ceph.in
> +++ b/src/init-ceph.in
> @@ -189,7 +189,7 @@ for name in $what; do
>      num=3D$id
>      name=3D"$type.$id"
>
> -    check_host || continue
> +    check_host $cluster|| continue
>
>      binary=3D"$BINDIR/ceph-$type"
>      cmd=3D"$binary -i $id"
> @@ -231,7 +231,7 @@ for name in $what; do
>      cmd=3D"$cmd -c $conf"
>
>      if echo $name | grep -q ^osd; then
> -       get_conf osd_data "/var/lib/ceph/osd/ceph-$id" "osd data"
> +       get_conf osd_data "/var/lib/ceph/osd/$cluster-$id" "osd data"
>         get_conf fs_path "$osd_data" "fs path"  # mount point default=
s so osd data
>          get_conf fs_devs "" "devs"
>         if [ -z "$fs_devs" ]; then
> @@ -323,7 +323,7 @@ for name in $what; do
>                 if [ "${update_crush:-1}" =3D "1" -o "${update_crush:=
-1}" =3D "true" ]; then
>                     # update location in crush
>                     get_conf osd_location_hook "$BINDIR/ceph-crush-lo=
cation" "osd crush location hook"
> -                   osd_location=3D`$osd_location_hook --cluster ceph=
 --id $id --type osd`
> +                   osd_location=3D`$osd_location_hook --cluster $clu=
ster --id $id --type osd`
>                     get_conf osd_weight "" "osd crush initial weight"
>                     defaultweight=3D"$(df -P -k $osd_data/. | tail -1=
 | awk '{ print sprintf("%.2f",$2/1073741824) }')"
>                     get_conf osd_keyring "$osd_data/keyring" "keyring=
"
> @@ -354,7 +354,7 @@ for name in $what; do
>                 get_conf mon_data "/var/lib/ceph/mon/ceph-$id" "mon d=
ata"
>                 if [ "$mon_data" =3D "/var/lib/ceph/mon/ceph-$id" -a =
"$asok" =3D "/var/run/ceph/ceph-mon.$id.asok" ]; then
>                     echo Starting ceph-create-keys on $host...
> -                   cmd2=3D"$SBINDIR/ceph-create-keys -i $id 2> /dev/=
null &"
> +                   cmd2=3D"$SBINDIR/ceph-create-keys --cluster $clus=
ter -i $id 2> /dev/null &"
>                     do_cmd "$cmd2"
>                 fi
>             fi
>
> -----------
> Best regards,
> yy,
> eXtreme Spring Network Technology Limited. Co.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
