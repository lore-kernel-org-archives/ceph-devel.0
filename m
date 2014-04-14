From: David McBride <dwm37@cam.ac.uk>
Subject: Re: Ceph daemon memory utilization: 'heap release' drops use by 50%
Date: Mon, 14 Apr 2014 15:04:44 +0100
Message-ID: <534BEAFC.8000306@cam.ac.uk>
References: <534BD487.5090507@cam.ac.uk> <CAPYLRzhJL93sgo0QnHZHy72f77m4NwZ+nG+LkSU6RP8UEL4PSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:38631 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbaDNOEp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Apr 2014 10:04:45 -0400
In-Reply-To: <CAPYLRzhJL93sgo0QnHZHy72f77m4NwZ+nG+LkSU6RP8UEL4PSw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph-devel <ceph-devel@vger.kernel.org>

On 14/04/14 14:53, Gregory Farnum wrote:
> What distro are you running on?
> -Greg

Hi Greg,

This is sitting atop a pre-release build of Ubuntu 14.04, using the
packages provided by same.

dpkg-query -W ceph shows:

ceph	0.79-0ubuntu1

ceph --version shows:

ceph version 0.79 (4c2d73a5095f527c3a2168deb5fa54b3c8991a6e)

Note that I'm currently half-way through nuking my existing cluster (to
reduce my PG count, and experiment with different OSD filesystems); I'm
happy to run experiments, but there'll be a small lag while I bring the
cluster back up!

Cheers,
David
-- 
David McBride <dwm37@cam.ac.uk>
Unix Specialist, University Information Services
