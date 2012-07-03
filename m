From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: iostat show constants write to osd disk with writeahead journal,  normal behaviour ?
Date: Tue, 03 Jul 2012 06:30:42 +0200 (CEST)
Message-ID: <6e2eace3-ec72-4c77-ba08-870b214953c5@mailpro>
References: <Pine.LNX.4.64.1207021358591.24205@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:44361 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab2GCEbG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 00:31:06 -0400
In-Reply-To: <Pine.LNX.4.64.1207021358591.24205@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org, Gregory Farnum <greg@inktank.com>

Thanks,
I'll try that.

note: with btrfs, il can use filestore flusher =3D true + wip_flush_min=
 git branch.
      and I see write to disk each X second.
      (2sec of seq write vs 30sec

with xfs,that doesn't work, filestore flusher =3D false + wip_flush,I s=
ee constant writes, without flusher in the logs.


----- Mail original -----=20

De: "Sage Weil" <sage@inktank.com>=20
=C3=80: "Gregory Farnum" <greg@inktank.com>=20
Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, "Mark Nelson" <mark.nel=
son@inktank.com>, ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 2 Juillet 2012 23:02:13=20
Objet: Re: iostat show constants write to osd disk with writeahead jour=
nal, normal behaviour ?=20

On Mon, 2 Jul 2012, Gregory Farnum wrote:=20
> On Tue, Jun 19, 2012 at 12:09 AM, Alexandre DERUMIER=20
> <aderumier@odiso.com> wrote:=20
> > Hi, more infos, I have active filestore debug =3D 20, min interval =
29 and max interval 30.=20
> >=20
> > I see sync_entry each 30s, so it seem work as expected.=20
> >=20
> > cat ceph-osd.0.log |grep sync_entry=20
> > 2012-06-19 07:56:00.084622 7fd09233b700 20 filestore(/srv/osd.0) sy=
nc_entry woke after 26.550294=20
> > 2012-06-19 07:56:00.084641 7fd09233b700 20 filestore(/srv/osd.0) sy=
nc_entry waiting for another 2.449706 to reach min interval 29.000000=20
> > 2012-06-19 07:56:02.534432 7fd09233b700 15 filestore(/srv/osd.0) sy=
nc_entry committing 18717 sync_epoch 5=20
> > 2012-06-19 07:56:02.534481 7fd09233b700 15 filestore(/srv/osd.0) sy=
nc_entry doing a full sync (syncfs(2) if possible)=20
> > 2012-06-19 07:56:02.963302 7fd09233b700 10 filestore(/srv/osd.0) sy=
nc_entry commit took 0.428878, interval was 29.428974=20
> > 2012-06-19 07:56:02.963332 7fd09233b700 15 filestore(/srv/osd.0) sy=
nc_entry committed to op_seq 18717=20
> > 2012-06-19 07:56:02.963341 7fd09233b700 20 filestore(/srv/osd.0) sy=
nc_entry waiting for max_interval 30.000000=20
> > 2012-06-19 07:56:12.066002 7fd09233b700 20 filestore(/srv/osd.0) sy=
nc_entry woke after 9.102662=20
> > 2012-06-19 07:56:12.066024 7fd09233b700 20 filestore(/srv/osd.0) sy=
nc_entry waiting for another 19.897338 to reach min interval 29.000000=20
> > 2012-06-19 07:56:31.963460 7fd09233b700 15 filestore(/srv/osd.0) sy=
nc_entry committing 18935 sync_epoch 6=20
> > 2012-06-19 07:56:31.963510 7fd09233b700 15 filestore(/srv/osd.0) sy=
nc_entry doing a full sync (syncfs(2) if possible)=20
> > 2012-06-19 07:56:32.279737 7fd09233b700 10 filestore(/srv/osd.0) sy=
nc_entry commit took 0.316285, interval was 29.316396=20
> > 2012-06-19 07:56:32.279778 7fd09233b700 15 filestore(/srv/osd.0) sy=
nc_entry committed to op_seq 18935=20
> > 2012-06-19 07:56:32.279786 7fd09233b700 20 filestore(/srv/osd.0) sy=
nc_entry waiting for max_interval 30.000000=20
> > 2012-06-19 07:56:44.837731 7fd09233b700 20 filestore(/srv/osd.0) sy=
nc_entry woke after 12.557945=20
> > 2012-06-19 07:56:44.837757 7fd09233b700 20 filestore(/srv/osd.0) sy=
nc_entry waiting for another 16.442055 to reach min interval 29.000000=20
> > 2012-06-19 07:57:01.279894 7fd09233b700 15 filestore(/srv/osd.0) sy=
nc_entry committing 19125 sync_epoch 7=20
> > 2012-06-19 07:57:01.279939 7fd09233b700 15 filestore(/srv/osd.0) sy=
nc_entry doing a full sync (syncfs(2) if possible)=20
> > 2012-06-19 07:57:01.558240 7fd09233b700 10 filestore(/srv/osd.0) sy=
nc_entry commit took 0.278354, interval was 29.278455=20
> > 2012-06-19 07:57:01.558282 7fd09233b700 15 filestore(/srv/osd.0) sy=
nc_entry committed to op_seq 19125=20
> > 2012-06-19 07:57:01.558291 7fd09233b700 20 filestore(/srv/osd.0) sy=
nc_entry waiting for max_interval 30.000000=20
> > 2012-06-19 07:57:31.558394 7fd09233b700 20 filestore(/srv/osd.0) sy=
nc_entry woke after 30.000104=20
> > 2012-06-19 07:57:31.558414 7fd09233b700 20 filestore(/srv/osd.0) sy=
nc_entry waiting for max_interval 30.000000=20
> >=20
> >=20
> > But during all the time of the bench, I have flusher_entry logs.=20
> > What is exactly flush_entry vs sync_entry?=20
>=20
> flush_entry is doing sync_file_range, which sends the data to the dis=
k=20
> but doesn't flush disk caches, or do a whole host of other things tha=
t=20
> are needed to maintain integrity. The idea is that we don't want the=20
> filesystem to store up thirty seconds worth of writes and then sync=20
> them out on command, but rather to continuously do writes to disk.=20
> sync_file_range is the best tool we have for accomplishing that.=20
>=20
> However, you could try turning it off and seeing if your performance=20
> improves. :) Set filestore_sync_flush and filestore_flusher to false=20
> in your config file.=20

One alternative is to let the kernel do this. If you adjust the VM=20
tunables with something like=20

echo 10000000 > /proc/sys/vm/dirty_background_bytes=20

and set=20

filestore flusher =3D false=20

that will rely on the kernel to keep the amount of dirty data small. Th=
is=20
affects the entire host, though, so keep in mind that it will affect ot=
her=20
processes and all mounted file systems. Conceptually, this is what we a=
re=20
trying to accomplish with the flushing stuff, but it's hard to do from =
a=20
user process. Maybe the new cgroups stuff will make some of this=20
easier... I haven't been following it very closely.=20

sage=20



--=20

--=20



=09

Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
