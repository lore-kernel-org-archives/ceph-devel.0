From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: Status of ceph ITP?
Date: Thu, 02 Dec 2010 17:57:31 +0100
Message-ID: <1291309051.14018.667.camel@julia.gcs.org.hu>
References: <1290365977.9821.3.camel@clint-MacBookPro>
	 <Pine.LNX.4.64.1011211521510.17131@cobra.newdream.net>
	 <1290436452.9821.5.camel@clint-MacBookPro>
	 <Pine.LNX.4.64.1011291120510.4337@cobra.newdream.net>
	 <1291075213.14018.101.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1011300922530.30759@cobra.newdream.net>
	 <1291221518.14018.564.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1012011010570.29814@cobra.newdream.net>
	 <1291249852.14018.611.camel@julia.gcs.org.hu>
	 <1291274357.20409.171.camel@clint-MacBookPro>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.routers.hu ([212.40.96.82]:34400 "EHLO mail.routers.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757617Ab0LBQ6H (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 2 Dec 2010 11:58:07 -0500
In-Reply-To: <1291274357.20409.171.camel@clint-MacBookPro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Clint Byrum <clint@ubuntu.com>
Cc: Sage Weil <sage@newdream.net>, asheesh@asheesh.org, 506040@bugs.debian.org, noel@debian.org, ceph-devel@vger.kernel.org

Hi Clint,

On Wed, 2010-12-01 at 23:19 -0800, Clint Byrum wrote:
> On Thu, 2010-12-02 at 01:30 +0100, Laszlo Boszormenyi wrote:
> Essentially, as long as the files don't have a license that conflicts
> with COPYING, then there's no need for a license header.
 Got a confirmation from an FTP Assistant, Mike O'Connor; he says
exactly the same. "Its not required, for instance, that every
single .h .c file etc have a license information, as long as it can be
reasonably assumed that we know the copyright holders' intention. When
the upstream author says "i'm the copyright holder for everything in the
src directory, and its distributable under the LGPL, we'll assume this
to be correct unless there is something that indicates otherwise."
I just have a memory that recently a package was rejected due to this,
but I assume it neither had the license information in
debian/copyright .

> Laszlo, I did a thorough review of the licensing before working to get
> ceph uploaded to Ubuntu, but I wasn't aware of the incompatibility
> between the GPL/LGPL and OpenSSL. This page details it pretty well:
> 
> http://people.gnome.org/~markmc/openssl-and-the-gpl.html
 Please note two things. First is the bottom line of the page which
says: "Usual disclaimers apply, I've no legal background whatsoever,
don't trust a word I say ... I'm quite probably completely wrong." and
it was written in 2004. More recently, three months ago a bug was
filed[1] in Debian that states there's indeed a need for that license
exception for a GPL programs.
 On the other hand, yes, I do realize that ceph is mostly LGPL which may
or may not need this exception. Just found a conversation on
debian-legal, where the second message[2] states: "There is no need for
an OpenSSL exception for a LGPL-licensed work."; thus I'm ready to
upload ceph as soon as the two missing manpages are written.

> Also Sage, if the other authors (or you) are not comfortable with the
> OpenSSL advertising clause, there's always GNUTLS which exists in large
> part to address this sort of thing.
 Rewrite the SSL part may not be that easy, but see above that it seems
it's not needed for LGPL sources.

Laszlo/GCS
[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=595446
[2] http://lists.debian.org/debian-legal/2008/06/msg00007.html

