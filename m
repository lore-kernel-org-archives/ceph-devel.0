From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH 0/2] Add Ceph integration with OCF-compliant HA resource managers
Date: Mon, 9 Jan 2012 11:32:47 -0800
Message-ID: <CAORUGqCOb61atmvj2bs1PR=-3Bmy-UDyOzmUeXbSNGXY1Uq6yg@mail.gmail.com>
References: <1325188682-9518-1-git-send-email-florian@hastexo.com>
 <1392105.DlScea8uhi@mranderson> <CAPUexz8+300nFSYT8MgUVATeyJfaPWXLujj+Cwi73yYfOHjyXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36378 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933046Ab2AITdJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2012 14:33:09 -0500
Received: by wgbdr10 with SMTP id dr10so2182400wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jan 2012 11:33:08 -0800 (PST)
In-Reply-To: <CAPUexz8+300nFSYT8MgUVATeyJfaPWXLujj+Cwi73yYfOHjyXA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jan 6, 2012 at 11:00, Florian Haas <florian@hastexo.com> wrote:
> Pacemaker integration has an added benefit: since Pacemaker is aware
> of the services in a cluster, we can always tell the cluster, i want
> this many mon instances, or this many OSDs, and Pacemaker can ensure
> exactly that. Pacemaker is also unique among cluster managers that it

We already talked on IRC, but just to clarify this to all:

How many OSDs to run (on what hosts) is a question about the available
& correctly-functioning storage devices, not really about the
administrators wishes. If you want to run more, plug in more hard
drives; starting OSDs without them having a backing store is not
helpful.

The planned architecture handles this automatically, triggering based
on the udev "new block device detected" hook. And that's one of the
reasons /etc/init.d/ceph-osd just isn't good enough for the brave new
world.
