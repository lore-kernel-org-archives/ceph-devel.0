From: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: ceph-disk is now deprecated
Date: Tue, 28 Nov 2017 09:24:01 +0100
Message-ID: <20171128082401.wumj4qo5pi4hawtg@nora.maurer-it.com>
References: <CAC-Np1z7OJNxUeso+FEB8g+7RUABkvKF58_mmXDHt4SeOTHSDw@mail.gmail.com>
 <f6e851fd-b4d8-8f79-c017-267dc0e30199@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from proxmox.maurer-it.com ([212.186.127.180]:29997 "EHLO
        proxmox.maurer-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751063AbdK1IYJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 03:24:09 -0500
Content-Disposition: inline
In-Reply-To: <f6e851fd-b4d8-8f79-c017-267dc0e30199@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 27, 2017 at 09:07:02PM +0100, Nathan Cutler wrote:
> > A few items to consider:
> > 
> > * ceph-disk is expected to be fully removed by the Mimic release
> 
> It's pretty standard in the software world to deprecate in one release and
> remove in the next. Maybe I'm blind, but I didn't see anything in the
> announcement explaining why deprecation *and* removal in a single release
> cycle is warranted in this case?

Especially since ceph-volume has been undergoing lots of changes in the
recent weeks and months, so I highly doubt it has seen enough testing to
support such an abrupt change[1].

Maybe removing the deprecation warning for now, highlighting ceph-volume
in the release notes for 12.2.2 and then re-adding the deprecation
warning later on in the Luminous cycle (or even just the Mimic RCs) is
more advisable?

1: 90 commits touching src/ceph-volume since v12.2.1, not counting those
having "test" in the commit subject - that's about 12% of all non-"test"
commits currently slated for v12.2.2!

