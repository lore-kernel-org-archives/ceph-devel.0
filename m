From: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Subject: Re: deb/rpm package purge
Date: Wed, 20 Mar 2013 06:29:29 +0000
Message-ID: <1363760969.12547.52.camel@julia>
References: <alpine.DEB.2.00.1303191246330.4850@cobra.newdream.net>
	 <5148C4EE.5090205@inktank.com> <5148CEC2.2050405@inktank.com>
	 <alpine.DEB.2.00.1303191349360.4850@cobra.newdream.net>
	 <1363732049.12547.22.camel@julia>
	 <alpine.DEB.2.00.1303191528510.4850@cobra.newdream.net>
	 <1363733473.12547.33.camel@julia>
	 <alpine.DEB.2.00.1303191554590.4850@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:39283 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab3CTG3a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 02:29:30 -0400
In-Reply-To: <alpine.DEB.2.00.1303191554590.4850@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org, james.page@ubuntu.com

On Tue, 2013-03-19 at 15:59 -0700, Sage Weil wrote:
> On Tue, 19 Mar 2013, Laszlo Boszormenyi (GCS) wrote:
> > On the other hand, 'dpkg --purge' is to remove everything the package
> > has installed and/or generated. This includes debconf answers as well.
> > With other words, purge is used to make the system totally clean of the
> > package. As such, if the sysadmin install the package again, all debconf
> > questions will be asked again and all generated files will be generated
> > again from scratch.
> 
> I understand that part, but the policy isn't very clear about files that 
> are not part of the package but are generated as a result of the package 
> being installed (i.e., user data).
 Forgive me, I just learnt English and my wording may not be that clear
for a natural speaker.

> As a point of comparison, mysql removes the config files but not 
> /var/lib/mysql.
 As I remember, MySQL asks if /var/lib/mysql/ should be purged or not; I
may mix with an other (database related) package.

> The question is, is that okay/typical/desireable/recommended/a bad idea?
 I can rephrase my words. Purge removes the (binary) package files, its
configuration and logs (its generated files). To emphasis, user files
are _not_ fall into this category and must remain as-is, _intact_.
Some packages writes a console message that 'your files remain at xxx,
they were not removed' on purge. Others just leave the dpkg warning
"directory not empty so not removed" which means user files may have
left there and that may be the reason the directory is not empty.
 I'm in a rush, but hopefully will be able to note policy parts in the
afternoon (CET).

> The less important question is whether /var/log/ceph should be removed; 
> I'm assuming yes?
 Yes, logs are going to be removed.

Hope I could answer your question now. Please note me if I should clear
more parts of my answer.
Laszlo/GCS

