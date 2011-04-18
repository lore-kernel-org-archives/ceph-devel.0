From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [PATCH 2/4] config: Update sample configuration to new naming scheme
Date: Sun, 17 Apr 2011 17:37:18 -0700
Message-ID: <BANLkTikdn5JmByEum8Phz_0nK0G7f5W7vQ@mail.gmail.com>
References: <1303032724-13456-1-git-send-email-wido@widodh.nl>
	<1303032724-13456-2-git-send-email-wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58467 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab1DRAhT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Apr 2011 20:37:19 -0400
Received: by fxm17 with SMTP id 17so2699225fxm.19
        for <ceph-devel@vger.kernel.org>; Sun, 17 Apr 2011 17:37:18 -0700 (PDT)
In-Reply-To: <1303032724-13456-2-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hi Wido,

Thanks for the patch.
This was already fixed by e34e332bc43b30f43dee3f2b153ea10977553068.

I don't think we want log to syslog to be in the sample configuration
file. Maybe we could include it, but commented out. Most users will
want to enable logging to a file or to syslog, but not both.

Colin


On Sun, Apr 17, 2011 at 2:32 AM, Wido den Hollander <wido@widodh.nl> wr=
ote:
>
> Signed-off-by: Wido den Hollander <wido@widodh.nl>
> ---
> =A0src/sample.ceph.conf | =A0 23 +++++++++++++----------
> =A01 files changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/src/sample.ceph.conf b/src/sample.ceph.conf
> index bb874e7..31674f6 100644
> --- a/src/sample.ceph.conf
> +++ b/src/sample.ceph.conf
> @@ -24,6 +24,9 @@
> =A0 =A0 =A0 =A0 ; set up pid files
> =A0 =A0 =A0 =A0 pid file =3D /var/run/ceph/$name.pid
>
> + =A0 =A0 =A0 =A0; Also log to syslog
> + =A0 =A0 =A0 =A0log to syslog =3D true
> +
> =A0; monitors
> =A0; =A0You need at least one. =A0You need at least three if you want=
 to
> =A0; =A0tolerate any node failures. =A0Always create an odd number.
> @@ -37,15 +40,15 @@
> =A0 =A0 =A0 =A0;debug paxos =3D 20
> =A0 =A0 =A0 =A0;debug auth =3D 20
>
> -[mon0]
> +[mon.alpha]
> =A0 =A0 =A0 =A0host =3D alpha
> =A0 =A0 =A0 =A0mon addr =3D 192.168.0.10:6789
>
> -[mon1]
> +[mon.beta]
> =A0 =A0 =A0 =A0host =3D beta
> =A0 =A0 =A0 =A0mon addr =3D 192.168.0.11:6789
>
> -[mon2]
> +[mon.gamma]
> =A0 =A0 =A0 =A0host =3D gamma
> =A0 =A0 =A0 =A0mon addr =3D 192.168.0.12:6789
>
> @@ -70,16 +73,16 @@
> =A0; =A0Define as many as you like.
> =A0[osd]
> =A0 =A0 =A0 =A0; This is where the btrfs volume will be mounted.
> - =A0 =A0 =A0 osd data =3D /data/osd$id
> + =A0 =A0 =A0 osd data =3D /data/$name
>
> =A0 =A0 =A0 =A0; Ideally, make this a separate disk or partition. =A0=
A few
> =A0 =A0 =A0 =A0; hundred MB should be enough; more if you have fast o=
r many
> =A0 =A0 =A0 =A0; disks. =A0You can use a file under the osd data dir =
if need be
> - =A0 =A0 =A0 ; (e.g. /data/osd$id/journal), but it will be slower th=
an a
> + =A0 =A0 =A0 ; (e.g. /data/$name/journal), but it will be slower tha=
n a
> =A0 =A0 =A0 =A0; separate disk or partition.
>
> =A0 =A0 =A0 =A0 ; This is an example of a file-based journal.
> - =A0 =A0 =A0 osd journal =3D /data/osd$id/journal
> + =A0 =A0 =A0 osd journal =3D /data/$name/journal
> =A0 =A0 =A0 =A0osd journal size =3D 1000 ; journal size, in megabytes
>
> =A0 =A0 =A0 =A0; osd logging to debug osd issues, in order of likelih=
ood of being
> @@ -89,7 +92,7 @@
> =A0 =A0 =A0 =A0;debug filestore =3D 20
> =A0 =A0 =A0 =A0;debug journal =3D 20
>
> -[osd0]
> +[osd.0]
> =A0 =A0 =A0 =A0host =3D delta
>
> =A0 =A0 =A0 =A0; if 'btrfs devs' is not specified, you're responsible=
 for
> @@ -98,14 +101,14 @@
> =A0 =A0 =A0 =A0; usually fine for basic testing).
> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdx
>
> -[osd1]
> +[osd.1]
> =A0 =A0 =A0 =A0host =3D epsilon
> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdy
>
> -[osd2]
> +[osd.2]
> =A0 =A0 =A0 =A0host =3D zeta
> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdx
>
> -[osd3]
> +[osd.3]
> =A0 =A0 =A0 =A0host =3D eta
> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdy
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
