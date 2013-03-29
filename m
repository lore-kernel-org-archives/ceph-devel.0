From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [ceph-users] Puppet modules for Ceph finally landed!
Date: Thu, 28 Mar 2013 21:26:28 -0700
Message-ID: <515517F4.3030501@inktank.com>
References: <2C8FAE48-A968-4999-A7B7-20A8D47805CE@enovance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:61770 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab3C2E0b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 00:26:31 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so88692daj.8
        for <ceph-devel@vger.kernel.org>; Thu, 28 Mar 2013 21:26:31 -0700 (PDT)
In-Reply-To: <2C8FAE48-A968-4999-A7B7-20A8D47805CE@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <sebastien.han@enovance.com>
Cc: ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

This is pretty cool, S=E9bastien.

On 03/28/2013 02:34 AM, Sebastien Han wrote:
> Hello everybody,
>
> Quite recently Fran=E7ois Charlier and I worked together on the Puppe=
t
> modules for Ceph on behalf of our employer eNovance. In fact, Fran=E7=
ois
> started to work on them last summer, back then he achieved the Monito=
r
> manifests. So basically, we worked on the OSD manifest. Modules are i=
n
> pretty good shape thus we thought it was important to communicate to =
the
> community. That's enough talk, let's dive into these modules and expl=
ain
> what do they do. See below what's available:
>
> * Testing environment is Vagrant ready.
> * Bobtail Debian latest stable version will be installed
> * The module only supports CephX, at least for now
> * Generic deployment for 3 monitors based on a template file
> examples/common.sh which respectively includes mon.sh, osd.sh, mds.sh=
=2E
> * Generic deployment for N OSDs. OSD disks need to be set from the
> examples/site.pp file (line 71). Puppet will format specified disks i=
n
> XFS (only filesystem implemented) using these options: `-f -d
> agcount=3D<cpu-core-number> -l size=3D1024m -n size=3D64k` and finall=
y mounted
> with: `rw,noatime,inode64`. Then it will mount all of them and append
> the appropriate lines in the fstab file of each storage node. Finally
> the OSDs will be added into Ceph.
>
> All the necessary materials (sources and how-to) are publicly availab=
le
> (and for free) under AGPL license on Github at
> https://github.com/enovance/puppet-ceph . Those manifests do the job
> quite nicely, although we still need to work on MDS (90% done, just n=
eed
> a validation),  RGW (0% done) and a more flexible implementation
> (authentication and filesystem support). Obviously comments,
> constructive critics and feedback are more then welcome. Thus don't
> hesitate to drop an email to either Fran=E7ois (f.charlier@enovance.c=
om
> <mailto:f.charlier@enovance.com>) or I (sebastien@enovance.com
> <mailto:sebastien@enovance.com>) if you have further questions.
>
> Cheers!
>
> =96=96=96=96
> S=E9bastien Han
> Cloud Engineer
>
> "Always give 100%. Unless you're giving blood."
>
>
>
>
>
>
>
>
>
> PHONE : +33 (0)1 49 70 99 72 =96 MOBILE : +33 (0)6 52 84 44 70
> EMAIL : sebastien.han@enovance.com
> <mailto:sebastien.han@enovance.com> =96 SKYPE : han.sbastien
> ADDRESS : 10, rue de la Victoire =96 75009 Paris
> WEB : www.enovance.com =96 TWITTER : @enovance
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
