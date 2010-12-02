From: Clint Byrum <clint@ubuntu.com>
Subject: Re: Status of ceph ITP?
Date: Wed, 01 Dec 2010 23:19:17 -0800
Message-ID: <1291274357.20409.171.camel@clint-MacBookPro>
References: <1290365977.9821.3.camel@clint-MacBookPro>
	 <Pine.LNX.4.64.1011211521510.17131@cobra.newdream.net>
	 <1290436452.9821.5.camel@clint-MacBookPro>
	 <Pine.LNX.4.64.1011291120510.4337@cobra.newdream.net>
	 <1291075213.14018.101.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1011300922530.30759@cobra.newdream.net>
	 <1291221518.14018.564.camel@julia.gcs.org.hu>
	 <Pine.LNX.4.64.1012011010570.29814@cobra.newdream.net>
	 <1291249852.14018.611.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from xenclint.srihosting.com ([65.98.207.160]:58231 "EHLO
	xen.spamaps.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757228Ab0LBHTT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Dec 2010 02:19:19 -0500
In-Reply-To: <1291249852.14018.611.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: Sage Weil <sage@newdream.net>, asheesh@asheesh.org, 506040@bugs.debian.org, noel@debian.org, ceph-devel@vger.kernel.org

On Thu, 2010-12-02 at 01:30 +0100, Laszlo Boszormenyi wrote:

> I'm not an ftp-master, but your package maybe rejected[2] for two
> reasons. I think only debian/copyright is not enough, all source file=
s
> should have a comment header about their license in short. You have i=
t

I don't see where this is a hard requirement in the reject faq.
Essentially, as long as the files don't have a license that conflicts
with COPYING, then there's no need for a license header. I DO think its
a good idea to have a Copyright header in every file, but thats also
probably ok to have in an AUTHORS file or something like that.

> in cephfs.cc , cfuse.cc , etc; but missing in barclass.cc , cconf.cc =
,
> cls_acl.cc and in others. Second is that you link with OpenSSL when y=
our
> license is (L)GPL. See their FAQ[3] and the fact that I can't find an=
y
> upstream license file permitting that nor it's mentioned in
> debian/copyright . Also you may see the debian/copyright of my packag=
es,
> like neon27[4]: it has a pointer to the full license file
> under /usr/share/common-licenses/ .
> On the other hand, it went into Ubuntu without any problems. Clint,
> No=C3=A8l? Feel free to post comment on what needs to be done with ce=
ph
> packaging to be accepted on the first round.
>=20

Laszlo, I did a thorough review of the licensing before working to get
ceph uploaded to Ubuntu, but I wasn't aware of the incompatibility
between the GPL/LGPL and OpenSSL. This page details it pretty well:

http://people.gnome.org/~markmc/openssl-and-the-gpl.html

Sage, I'd guess that you can work on getting an OK from the other
authors on adding an exception. I've opened a bug against CEPH in ubunt=
u
here:

https://bugs.launchpad.net/ubuntu/+source/ceph/+bug/684011

Sage, if you can please update that bug's status when you have secured
an exception, that would be ideal, as I'm going to mark it as Critical,
so we'll probably have to drop ceph from Natty if there's no resolution
before the release, and consider dropping it from Maverick as well.

Also Sage, if the other authors (or you) are not comfortable with the
OpenSSL advertising clause, there's always GNUTLS which exists in large
part to address this sort of thing.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
