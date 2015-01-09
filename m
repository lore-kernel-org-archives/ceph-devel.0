From: Gregory Farnum <greg@gregs42.com>
Subject: Re: /usr/bin/cephfs tool
Date: Fri, 9 Jan 2015 09:52:52 -0800
Message-ID: <CAC6JEv9XuGSLOnzo_m1GVOYd46XyLUKysjnrJpu9623TZaxO2A@mail.gmail.com>
References: <alpine.DEB.2.00.1501090719200.10528@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:64291 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbbAIRwy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jan 2015 12:52:54 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so16260296iec.11
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jan 2015 09:52:53 -0800 (PST)
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com. [209.85.223.174])
        by mx.google.com with ESMTPSA id t8sm9857090igs.21.2015.01.09.09.52.52
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 Jan 2015 09:52:52 -0800 (PST)
Received: by mail-ie0-f174.google.com with SMTP id at20so16310561iec.5
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jan 2015 09:52:52 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501090719200.10528@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: gfarnum@redhat.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jan 9, 2015 at 7:20 AM, Sage Weil <sweil@redhat.com> wrote:
> Should we drop this entirely in hammer?

Yes!

>  If I remember correctly all of
> the layout stuff is fully supported using virtual xattrs and standard
> tools.  The only thing left is the tool that shows you how file blocks map
> to objects map to OSDs (or something like that), which I've never used and
> have never seen anyone use...

...oh, hmmm. Actually there have been people using that tool
occasionally over the years, and I don't think we provide any other
way to learn that information (besides calculating it yourself,
obviously).
Perhaps we could extend the vxattr interface to include that
information as well?
-Greg
