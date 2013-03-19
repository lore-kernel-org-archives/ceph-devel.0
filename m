From: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Subject: Re: deb/rpm package purge
Date: Tue, 19 Mar 2013 22:27:29 +0000
Message-ID: <1363732049.12547.22.camel@julia>
References: <alpine.DEB.2.00.1303191246330.4850@cobra.newdream.net>
	 <5148C4EE.5090205@inktank.com> <5148CEC2.2050405@inktank.com>
	 <alpine.DEB.2.00.1303191349360.4850@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:37984 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab3CSWfQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 18:35:16 -0400
In-Reply-To: <alpine.DEB.2.00.1303191349360.4850@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org, james.page@ubuntu.com

On Tue, 2013-03-19 at 13:51 -0700, Sage Weil wrote:
> On Tue, 19 Mar 2013, Dan Mick wrote:
> > Is there a way out if you remove the keyrings?
> 
> Yeah; you can use the keyring in the mon data dir to refetch any keyrings 
> you deleted from /etc/ceph/.
 But if packages are purged on mon as well...

> I don't disagree with any of this discussion, BTW; I ask the question 
> because I want to understand what the packaging best-practices are before 
> we put our foot down for what is "right".
 Actually there are two methods to uninstall a package from the system.
One is '-r' or '--remove' options of dpkg . As it's name and the
manpage confirms: "Remove  an  installed  package. -r or --remove remove
everything _except conffiles_. This may avoid having to reconfigure the
package if it is reinstalled later.". The second is '-P' or '--purge',
which stands for '[...] removes  everything,  including conffiles.".
Debian policy chapter 10 [1] writes about files and their handling. Its
subchapter 10.7 [2] talks about configuration files. Their handling is
expressed in subchapter 6.8 [3].

 In short, if user asks to purge the package, then the keys have to be
removed as well. If someone thinks about a reinstallation, s/he should
use remove instead. To be safe, I see one option. On purge, a debconf
message can be displayed notifying the user about the keys are going to
be removed as well. Abort of purge or backup of keys can be offered,
based on the choice.

Hope this helps,
Laszlo/GCS
[1] http://www.debian.org/doc/debian-policy/ch-files.html
[2] http://www.debian.org/doc/debian-policy/ch-files.html#s-config-files
[3] http://www.debian.org/doc/debian-policy/ch-maintainerscripts.html#s-removedetails

