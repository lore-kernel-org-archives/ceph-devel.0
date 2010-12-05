From: Sage Weil <sage@newdream.net>
Subject: Re: Status of ceph ITP?
Date: Sat, 4 Dec 2010 21:09:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012042108030.28007@cobra.newdream.net>
References: <1290365977.9821.3.camel@clint-MacBookPro>
 <Pine.LNX.4.64.1011211521510.17131@cobra.newdream.net>
 <1290436452.9821.5.camel@clint-MacBookPro> <Pine.LNX.4.64.1011291120510.4337@cobra.newdream.net>
 <1291075213.14018.101.camel@julia.gcs.org.hu> <Pine.LNX.4.64.1011300922530.30759@cobra.newdream.net>
 <1291221518.14018.564.camel@julia.gcs.org.hu> <Pine.LNX.4.64.1012011010570.29814@cobra.newdream.net>
 <1291249852.14018.611.camel@julia.gcs.org.hu> <1291274357.20409.171.camel@clint-MacBookPro>
 <1291309051.14018.667.camel@julia.gcs.org.hu>
 <AANLkTikz6y6qT4Oqe+GvmdBmsRH-KVe9L_4OK8Jsy4n1@mail.gmail.com>
 <1291467221.25001.30.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42143 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743Ab0LEFEx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Dec 2010 00:04:53 -0500
In-Reply-To: <1291467221.25001.30.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Clint Byrum <clint@ubuntu.com>, asheesh@asheesh.org, 506040@bugs.debian.org, noel@debian.org, ceph-devel@vger.kernel.org

Hey Laszlo,

On Sat, 4 Dec 2010, Laszlo Boszormenyi wrote:
> On Fri, 2010-12-03 at 22:02 -0800, Yehuda Sadeh Weinraub wrote:
> [ about OpenSSL license exception for ceph ]
> > I removed all the openssl references in the ceph code and replaced it
> > with crypto++, so hopefully all this discussion is now moot. It's all
> > pushed to the ceph rc branch.
>  Does it mean that I shouldn't upload v0.23.2 [1] to Debian? Wait for
> the v0.24.0 release and upload that one? I know v0.23.2 is not even
> noted as a release on the homepage, but tagged in the git tree.
> Main changes are that debian/source/format is re-added, the tree cleaned
> as make distclean, backported cephfs.8 manpage as a patch, pristine
> clean the source, noted myself as maintainer while Sage remains as an
> uploader.

Yeah, let's just wait for 0.24.  BTW, I made radosacl only build 
--with-debug; it can be dropped from the package.

Thanks-
sage


> 
> Laszlo/GCS
> Ps: Please delete parts of the email that not relevant to the
> conversation.
> [1] dget http://www.routers.hu/gcs/ceph_0.23.2-1.dsc
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
