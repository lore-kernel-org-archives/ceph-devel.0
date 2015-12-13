From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: ceph-mon terminated with status 28
Date: Sun, 13 Dec 2015 17:18:45 -0500 (EST)
Message-ID: <1290007151.43805078.1450045125175.JavaMail.zimbra@redhat.com>
References: <DM2PR12MB0556410B658CF096B4F3326C9BEC0@DM2PR12MB0556.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:60146 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbLMWSs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Dec 2015 17:18:48 -0500
In-Reply-To: <DM2PR12MB0556410B658CF096B4F3326C9BEC0@DM2PR12MB0556.namprd12.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tom Deneau <tom.deneau@amd.com>
Cc: ceph-devel@vger.kernel.org

----- Original Message -----
> From: "Tom Deneau" <tom.deneau@amd.com>
> To: ceph-devel@vger.kernel.org
> Sent: Sunday, 13 December, 2015 11:49:16 PM
> Subject: ceph-mon terminated with status 28
>=20
> I am trying to understand the following failure:
>=20
> A small cluster was running fine, and then was left unused for a whil=
e.
> When I went to try to use it again, the mon socket wasn't there and I=
 could
> see that
> ceph-mon was not running.  I saw the lines below at the end of dmesg =
output.
> When I tried to restart ceph-mon using sudo start ceph-mon id=3Dmonho=
st,
> I got the same set of errors newly appended to dmesg output.
>=20
> I don't see anything more descriptive in /var/log/ceph/ceph-mon.log, =
just
> the recording of new mon processes starting.
>=20
> In this particular small cluster, the mon process was running on the =
same
> node with 7 osd processes.  sudo initctl list shows that the osd proc=
s are
> still
> up, although logging the fact that they can't communicate with the mo=
n
> socket.
>=20
> Is there someplace else I should look for more details as to why mon =
is down
> and can't be restarted?
>=20
> -- Tom Deneau
>=20
> dmesg output:
> --------------
>  init: ceph-mon (ceph/monhost) main process (16538) terminated with s=
tatus 28
>  init: ceph-mon (ceph/monhost) main process ended, respawning
>  init: ceph-create-keys main process (16227) killed by TERM signal
>  init: ceph-mon (ceph/monhost) main process (16546) terminated with s=
tatus 28
>  init: ceph-mon (ceph/monhost) main process ended, respawning
>  init: ceph-create-keys main process (16548) killed by TERM signal
>  init: ceph-mon (ceph/monhost) main process (16556) terminated with s=
tatus 28
>  init: ceph-mon (ceph/monhost) main process ended, respawning
>  init: ceph-create-keys main process (16558) killed by TERM signal
>  init: ceph-mon (ceph/monhost) main process (16566) terminated with s=
tatus 28
>  init: ceph-mon (ceph/monhost) respawning too fast, stopped
>  init: ceph-create-keys main process (16568) killed by TERM signal

It looks like it's complaining about lack of space?

src/ceph_mon.cc:

204 int main(int argc, const char **argv)=C2=B7
205 {
----8<----
475   {
476     // check fs stats. don't start if it's critically close to full=
=2E
477     ceph_data_stats_t stats;
478     int err =3D get_fs_stats(stats, g_conf->mon_data.c_str());
479     if (err < 0) {
480       cerr << "error checking monitor data's fs stats: " << cpp_str=
error(err)
481            << std::endl;
482       exit(-err);
483     }
484     if (stats.avail_percent <=3D g_conf->mon_data_avail_crit) {
485       cerr << "error: monitor data filesystem reached concerning le=
vels of"
486            << " available storage space (available: "
487            << stats.avail_percent << "% " << prettybyte_t(stats.byt=
e_avail)
488            << ")\nyou may adjust 'mon data avail crit' to a lower v=
alue"
489            << " to make this go away (default: " << g_conf->mon_dat=
a_avail_crit
490            << "%)\n" << std::endl;
491       exit(ENOSPC);
492     }

#define ENOSPC          28      /* No space left on device */

Try starting ceph-mon from the command line and see if you get the abov=
e message.

>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
