From: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Subject: Re: deb/rpm package purge
Date: Wed, 20 Mar 2013 23:23:35 +0000
Message-ID: <1363821815.12547.97.camel@julia>
References: <alpine.DEB.2.00.1303191246330.4850@cobra.newdream.net>
	 <5148C4EE.5090205@inktank.com> <5148CEC2.2050405@inktank.com>
	 <alpine.DEB.2.00.1303191349360.4850@cobra.newdream.net>
	 <1363732049.12547.22.camel@julia>
	 <alpine.DEB.2.00.1303191528510.4850@cobra.newdream.net>
	 <1363733473.12547.33.camel@julia>
	 <alpine.DEB.2.00.1303191554590.4850@cobra.newdream.net>
	 <1363760969.12547.52.camel@julia>
	 <alpine.DEB.2.00.1303200545140.11428@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:43305 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab3CTXXh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 19:23:37 -0400
In-Reply-To: <alpine.DEB.2.00.1303200545140.11428@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org, james.page@ubuntu.com

On Wed, 2013-03-20 at 05:48 -0700, Sage Weil wrote:
> On Wed, 20 Mar 2013, Laszlo Boszormenyi (GCS) wrote:
> > On Tue, 2013-03-19 at 15:59 -0700, Sage Weil wrote:
> > > As a point of comparison, mysql removes the config files but not=20
> > > /var/lib/mysql.
> > > The question is, is that okay/typical/desireable/recommended/a ba=
d idea?
 I should have asked this sooner. Do you know _any_ program that remove=
s
your favorite music collection, your family photos or your business
emails when you do uninstall it?
I suspect that your question was theoretical instead.

On Wed, 2013-03-20 at 09:48 -0500, Mark Nelson wrote:
On 03/20/2013 07:48 AM, Sage Weil wrote:
> It's not as important given that it won't outright destroy the cluste=
r,=20
> but perhaps we should also leave /etc/ceph untouched on purge if a=20
> ceph.conf file has been placed in it (since that also was not install=
ed=20
> by the package, but rather by a user?).  I figure we should probably =
try=20
> to get it right now.  The message about the directory not being empty=
=20
> sounds good.
 Sure, personal user data must be kept. If it's a big amount of data an=
d
left under a non-standard location (ie, not under his/her $HOME) then
s/he should be informed where those files are located on purge.

> My thought here is:
> - remove anything created by the packages in /var/lib/ceph that has b=
een=20
> untouched since package installation.
> - remove /var/lib/ceph if it has been untouched
 Please note that you have to store some kind of checksum for the files
then. Probably md5sum is enough.

> - remove /etc/ceph if it has been untouched
 This is an other case. dpkg itself handle package files here, called
conffiles. I should check the method (md5sum and/or sha1 variants) used
for the checksum on these files. On upgrade it's used not to overwrite
local changes by the user. It may worth to read a bit more about it[1]
from Rapha=EBl Hertzog. He is the co-author of Debian Administrator's
handbook[2] BTW.
 On purge dpkg will remove the package conffiles no matter what. It
won't check if those were changed or not. You may not mark the files
under /etc as conffiles, but then you'll lose the mentioned
merge logic on upgrades; dpkg will just overwrite those.
 In short, files under /var/lib/ceph are the only candidates for
in-package checksumming. How many files under there that essential for
the packages?

Laszlo/GCS
[1] http://raphaelhertzog.com/2010/09/21/debian-conffile-configuration-=
file-managed-by-dpkg/
[2] http://debian-handbook.info/

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
