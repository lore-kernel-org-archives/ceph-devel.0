From: charles L <charlesboy009@hotmail.com>
Subject: FW: errno=Connection refused
Date: Tue, 26 Mar 2013 15:33:17 +0100
Message-ID: <DUB116-W933F690F6A1AB8C2998E43E0D00@phx.gbl>
References: <DUB116-W2072C51403FEC6645453AAE0D00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dub0-omc4-s13.dub0.hotmail.com ([157.55.2.88]:24578 "EHLO
	dub0-omc4-s13.dub0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933438Ab3CZOja convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 Mar 2013 10:39:30 -0400
In-Reply-To: <DUB116-W2072C51403FEC6645453AAE0D00@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

----------------------------------------
> From: charlesboy009@hotmail.com
> To: ceph-users@ceph.com
> Subject: errno=Connection refused
> Date: Tue, 26 Mar 2013 11:26:03 +0100
>
> Hi,
>
> Can somebody help?
>
> git clone --recursive https://github.com/ceph/ceph.git
> Cloning into 'ceph'...
> remote: Counting objects: 179817, done.
> remote: Compressing objects: 100% (34122/34122), done.
> remote: Total 179817 (delta 146077), reused 177377 (delta 143959)
> Receiving objects: 100% (179817/179817), 35.42 MiB | 136 KiB/s, done.
> Resolving deltas: 100% (146077/146077), done.
> Submodule 'ceph-object-corpus' (git://ceph.com/git/ceph-object-corpus.git) registered for path 'ceph-object-corpus'
> Submodule 'src/libs3' (git://github.com/ceph/libs3.git) registered for path 'src/libs3'
> Cloning into 'ceph-object-corpus'...
> fatal: unable to connect to ceph.com:
> ceph.com[0: 208.113.241.137]: errno=Connection refused
>
> Clone of 'git://ceph.com/git/ceph-object-corpus.git' into submodule path 'ceph-object-cor pus' failed
>
>
> Thanks. 		 	   		  