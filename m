From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: ceph-mon terminated with status 28
Date: Mon, 14 Dec 2015 16:46:52 -0500 (EST)
Message-ID: <1465638247.45060213.1450129612249.JavaMail.zimbra@redhat.com>
References: <DM2PR12MB0556410B658CF096B4F3326C9BEC0@DM2PR12MB0556.namprd12.prod.outlook.com> <1290007151.43805078.1450045125175.JavaMail.zimbra@redhat.com> <SN1PR12MB05583004753B74FFF2745DAA9BED0@SN1PR12MB0558.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:33693 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273AbbLNVqz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Dec 2015 16:46:55 -0500
In-Reply-To: <SN1PR12MB05583004753B74FFF2745DAA9BED0@SN1PR12MB0558.namprd12.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tom Deneau <tom.deneau@amd.com>
Cc: ceph-devel@vger.kernel.org

----- Original Message -----
> From: "Tom Deneau" <tom.deneau@amd.com>
> To: "Brad Hubbard" <bhubbard@redhat.com>
> Cc: ceph-devel@vger.kernel.org
> Sent: Tuesday, 15 December, 2015 3:21:27 AM
> Subject: RE: ceph-mon terminated with status 28
>=20
> Thanks, Brad.  That was the problem.

Np.

>=20
> Is there a reason why we don't log more descriptive info for this kin=
d of
> failure?

I guess it may not have been anticipated that init would swallow these =
types of
errors early in the process and just report the return code.

If you wouldn't mind opening a tracker for "Fatal errors at start-up ar=
e not
logged", or something similar,  I can take a look at getting some meani=
ngful log
entries reported during these early failures.

Let me know the tracker number.

Cheers,
Brad

>=20
> -- Tom
>=20
> > -----Original Message-----
> > From: Brad Hubbard [mailto:bhubbard@redhat.com]
> > Sent: Sunday, December 13, 2015 4:19 PM
> > To: Deneau, Tom
> > Cc: ceph-devel@vger.kernel.org
> > Subject: Re: ceph-mon terminated with status 28
> >=20
> > ----- Original Message -----
> > > From: "Tom Deneau" <tom.deneau@amd.com>
> > > To: ceph-devel@vger.kernel.org
> > > Sent: Sunday, 13 December, 2015 11:49:16 PM
> > > Subject: ceph-mon terminated with status 28
> > >
> > > I am trying to understand the following failure:
> > >
> > > A small cluster was running fine, and then was left unused for a =
while.
> > > When I went to try to use it again, the mon socket wasn't there a=
nd I
> > > could see that ceph-mon was not running.  I saw the lines below a=
t the
> > > end of dmesg output.
> > > When I tried to restart ceph-mon using sudo start ceph-mon id=3Dm=
onhost,
> > > I got the same set of errors newly appended to dmesg output.
> > >
> > > I don't see anything more descriptive in /var/log/ceph/ceph-mon.l=
og,
> > > just the recording of new mon processes starting.
> > >
> > > In this particular small cluster, the mon process was running on =
the
> > > same node with 7 osd processes.  sudo initctl list shows that the=
 osd
> > > procs are still up, although logging the fact that they can't
> > > communicate with the mon socket.
> > >
> > > Is there someplace else I should look for more details as to why =
mon
> > > is down and can't be restarted?
> > >
> > > -- Tom Deneau
> > >
> > > dmesg output:
> > > --------------
> > >  init: ceph-mon (ceph/monhost) main process (16538) terminated wi=
th
> > > status 28
> > >  init: ceph-mon (ceph/monhost) main process ended, respawning
> > >  init: ceph-create-keys main process (16227) killed by TERM signa=
l
> > >  init: ceph-mon (ceph/monhost) main process (16546) terminated wi=
th
> > > status 28
> > >  init: ceph-mon (ceph/monhost) main process ended, respawning
> > >  init: ceph-create-keys main process (16548) killed by TERM signa=
l
> > >  init: ceph-mon (ceph/monhost) main process (16556) terminated wi=
th
> > > status 28
> > >  init: ceph-mon (ceph/monhost) main process ended, respawning
> > >  init: ceph-create-keys main process (16558) killed by TERM signa=
l
> > >  init: ceph-mon (ceph/monhost) main process (16566) terminated wi=
th
> > > status 28
> > >  init: ceph-mon (ceph/monhost) respawning too fast, stopped
> > >  init: ceph-create-keys main process (16568) killed by TERM signa=
l
> >=20
> > It looks like it's complaining about lack of space?
> >=20
> > src/ceph_mon.cc:
> >=20
> > 204 int main(int argc, const char **argv)=C2=B7
> > 205 {
> > ----8<----
> > 475   {
> > 476     // check fs stats. don't start if it's critically close to =
full.
> > 477     ceph_data_stats_t stats;
> > 478     int err =3D get_fs_stats(stats, g_conf->mon_data.c_str());
> > 479     if (err < 0) {
> > 480       cerr << "error checking monitor data's fs stats: " <<
> > cpp_strerror(err)
> > 481            << std::endl;
> > 482       exit(-err);
> > 483     }
> > 484     if (stats.avail_percent <=3D g_conf->mon_data_avail_crit) {
> > 485       cerr << "error: monitor data filesystem reached concernin=
g
> > levels of"
> > 486            << " available storage space (available: "
> > 487            << stats.avail_percent << "% " <<
> > prettybyte_t(stats.byte_avail)
> > 488            << ")\nyou may adjust 'mon data avail crit' to a low=
er
> > value"
> > 489            << " to make this go away (default: " << g_conf-
> > >mon_data_avail_crit
> > 490            << "%)\n" << std::endl;
> > 491       exit(ENOSPC);
> > 492     }
> >=20
> > #define ENOSPC          28      /* No space left on device */
> >=20
> > Try starting ceph-mon from the command line and see if you get the =
above
> > message.
> >=20
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"
> > > in the body of a message to majordomo@vger.kernel.org More majord=
omo
> > > info at  http://vger.kernel.org/majordomo-info.html
> > >
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=
=EF=BF=BD=EF=BF=BD
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
