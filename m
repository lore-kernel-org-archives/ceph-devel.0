From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: compile error for ceph-0.28.*.tar.gz
Date: Wed, 1 Jun 2011 08:42:10 -0700
Message-ID: <20110601154209.GA28536@dreamer>
References: <BANLkTinCKuhzaRLKaBmJXJJCsNNHeDFuPA@mail.gmail.com>
 <20110531172458.GA12733@dreamer>
 <4DE52AE3.9020900@sandia.gov>
 <20110531184821.GB12733@dreamer>
 <BANLkTi=RFMvVLUnuMrm-f_3XTCq+EXyf+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55034 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758334Ab1FAPmK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 11:42:10 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=RFMvVLUnuMrm-f_3XTCq+EXyf+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>, Sam Just <sam.just@dreamhost.com>
Cc: Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org

On Wed, Jun 01, 2011 at 05:46:30PM +0800, Simon Tian wrote:
> I found it is difficult to update boost on all my rhel5.4 hosts, is
> there any way to make ceph-0.28.* successfully on rhel5.4 with old
> boost?

My understanding is that the OSD peering refactor made Ceph use
boost::statechart heavily, and older versions of libboost might not
include that feature, or it might not work quite the same way.

Sam, do you know whether the OSD refactor requires some specific
minimum version of libboost? I'd like to get the minimum known good
version recorded in autoconf & packaging, as per the ticket..

-- 
:(){ :|:&};:
