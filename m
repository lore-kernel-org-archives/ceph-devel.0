From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: cmake
Date: Tue, 28 Jun 2016 10:57:23 +0200
Message-ID: <11a9c51d-fa53-24f7-678c-88d0b4c8dbbc@digiware.nl>
References: <alpine.DEB.2.11.1606271746590.2844@piezo.us.to>
 <94aeab09-6e86-9e94-5a96-d8e477b85cad@digiware.nl>
 <e454dbac-1c33-04be-965b-c290f7356e93@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:31842 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbcF1JMG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jun 2016 05:12:06 -0400
In-Reply-To: <e454dbac-1c33-04be-965b-c290f7356e93@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 28-6-2016 10:41, Willem Jan Withagen wrote:
> But this one really has me:
> ====
> CMake Error: The following variables are used in this project, but they
> are set to NOTFOUND.
> Please set them or make sure they are set and tested correctly in the
> CMake files:
> FUSE_LIBRARIES (ADVANCED)
>     linked by target "rbd-fuse" in directory
> 	/usr/srcs/Ceph/work.cmake/ceph/src
> ====
> 
> in configure I'd say --without-fuse, but that does not really work here.
> Same for RBD....
> 
> Any suggestions as to proceed? Preferably withotu fuse and RBD for the
> moment? So my cmake env is more or less equal to the new cmake env.

Impolite to answer ones own questions:
-D WITH_<item>=OFF

However "" give:
CMake Error at src/test/bench/CMakeLists.txt:76 (install):
  install TARGETS given target "ceph_smalliobenchrbd" which does not
exist in
  this directory.

So got to tweek that.

--WjW

