From: James Page <james.page@ubuntu.com>
Subject: Re: deb/rpm package purge
Date: Wed, 20 Mar 2013 17:27:04 +0000
Message-ID: <5149F168.8010802@ubuntu.com>
References: <alpine.DEB.2.00.1303191246330.4850@cobra.newdream.net> <5148C4EE.5090205@inktank.com> <5148CEC2.2050405@inktank.com> <alpine.DEB.2.00.1303191349360.4850@cobra.newdream.net> <1363732049.12547.22.camel@julia> <alpine.DEB.2.00.1303191528510.4850@cobra.newdream.net> <1363733473.12547.33.camel@julia> <alpine.DEB.2.00.1303191554590.4850@cobra.newdream.net> <1363760969.12547.52.camel@julia> <alpine.DEB.2.00.1303200545140.11428@cobra.newdream.net> <5149CC4A.9030409@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:54557 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab3CTR1H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 13:27:07 -0400
In-Reply-To: <5149CC4A.9030409@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>, Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 20/03/13 14:48, Mark Nelson wrote:
>> 
>> We'll need to update teuthology ceph.py and nuke to clean up 
>> /var/lib/ceph (for qa runs), and I think we should add a
>> ceph-deploy 'purgedata' command to clean out /var/lib/ceph on a
>> given host.
> 
> It's not as important given that it won't outright destroy the
> cluster, but perhaps we should also leave /etc/ceph untouched on
> purge if a ceph.conf file has been placed in it (since that also
> was not installed by the package, but rather by a user?).  I figure
> we should probably try to get it right now.  The message about the
> directory not being empty sounds good.
> 
> My thought here is:
> 
> - remove anything created by the packages in /var/lib/ceph that has
> been untouched since package installation. - remove /var/lib/ceph
> if it has been untouched - remove /etc/ceph if it has been
> untouched

If those directories are created by dpkg rather than maintainer
scripts (i.e. in ceph.dirs rather than ceph.postinst) you should
should get that all for free; if the directories contain anything dpkg
does not know about it will just not removed them.


- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJRSfFoAAoJEL/srsug59jDJgsP/0zD4aKFtimFPh02/zdfJ3X0
BEY8Jmnmt3HcCxSPbGleZ+2p/38iLfLz8HdM1ZpOwGDVIv13N45vG0wW9zF/843R
8vKoGHJY7gAt/uY1fqa115m9txeNXAIZoaxwjrd6Zd31pgPvTBmfZhVsFKUnk7E5
9JmUs/K8gjjAZajhkUKgddp2ID70n/WGdHR+iu5cy72TyuvXVBQV1OmyYi9lMIxM
yHGnCM/X7x5DE1g61x532VP2D0gAegA2WWURoqQ6vAM3IZfVGVuvat+HdzZ8Ej8z
LfTk+8n2alTj6s1Xp3KGbb/D231MIi3VBaFMQx5pBlM29lAv8OYKidRQpZc9bZe2
5m5vhDutp4ZOZmqxDvDdayZgb/s8uVuodT2XK7qn4KbBRDEJN5aJKiUzXH0wTVTZ
Lg/A/criFuzRP+ZH/Sh1pfSnLkNrrLMbdTglUv4krM2L6ZPOmEU3fh+UIXkr2u9t
f6lnu4fVBwikDy/4hDztVL76IqB3wjnxYlJ1uHMHOrCugDeLRsGHdbCdFcoZonRW
rUhdrtqzuuSbPHkzs/dEMCm4vF439YdmuL4WGsfzxEu+djcESDtzuAw4D1LRO12V
JbEc9s8+L84oBJUv5dCSDG333jWc/8eihSs1ZG33NKZsWsNheppLR6aeXbg/nGi1
53R63uM1Lv7f1UaTxvH8
=6adU
-----END PGP SIGNATURE-----
