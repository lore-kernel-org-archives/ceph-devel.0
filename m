From: Sage Weil <sage@newdream.net>
Subject: Re: Outreachy Project - Ceph-mgr
Date: Wed, 8 Mar 2017 14:29:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703081424520.1727@piezo.novalocal>
References: <CAD0HchM0=_X=ENks1F_+5MEqh0pDghnysB2dDYqWQxSLtUDb3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48156 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbdCHOgn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Mar 2017 09:36:43 -0500
In-Reply-To: <CAD0HchM0=_X=ENks1F_+5MEqh0pDghnysB2dDYqWQxSLtUDb3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Seraphina Nix <seraphina.nix@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 7 Mar 2017, Seraphina Nix wrote:
> Hello,
> My name is Seraphina Nix. I am interested in submitting a proposal for
> the "ceph-mgr: slow osd identification, automated cluster response"
> project.
> 
> I am a Computer Science and Math major at Oberlin College. I have
> worked previous summers at Berkeley-Lawrence National Laboratory
> interfacing with instruments in LabVIEW and monitoring data
> collection, and at Denison University automating the calibration of a
> wavemeter using Python.
> 
> I do not have previous experience with Ceph, but I look forward to
> exploring the code base and making small contributions in the coming
> days. I look forward to learning more about the project I wish to work
> on. If there is more information about it or tasks I can work on now
> that are related to it, I would appreciate someone letting me know.

Hi Seraphina!

Delighted to hear you're interested in this project--we'd love to finally 
build in this functionality (it's a common request from users).  This will 
be one of the first python plugins in the new ceph-mgr daemon, so there 
will likely be some related work with the plugin interface and the 
corresponding C++ code.  You can find what's there now (not much!) at

	https://github.com/ceph/ceph/tree/master/src/pybind/mgr

For a larger example (not yet merged) that adds a full-blown GUI written 
in python see

	https://github.com/ceph/ceph/pull/13725

The implementation logistics aside, the crux of this project will 
be figuring out a statistical model to identify performance outliers and 
define a reasonable automated response... ideally one that will avoid 
false positives and overcorrections.

sage
