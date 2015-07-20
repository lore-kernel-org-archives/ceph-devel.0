From: Sage Weil <sage@newdream.net>
Subject: Re: start-stop-daemon radosgw
Date: Mon, 20 Jul 2015 06:49:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507200648210.8878@cobra.newdream.net>
References: <68A06213B74F1742A2C48216AE1BB6B8088009A6@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44075 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387AbbGTNtV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 09:49:21 -0400
In-Reply-To: <68A06213B74F1742A2C48216AE1BB6B8088009A6@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Srinivasula Maram <Srinivasula.Maram@sandisk.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>

On Mon, 20 Jul 2015, Pavan Rallabhandi wrote:
> [Resending in plain text format, apologies for the spam]
> 
> Hi,
> 
> This is with reference to the commit https://github.com/ceph/ceph/commit/f30fa4a364602fb9412babf7319140eca4c64995 and tracker http://tracker.ceph.com/issues/11453
> 
> On Hammer binaries, we are finding this fix has regressed to have multiple RGW instances to be run on a single machine. Meaning, with no user specified under 'client.radosgw.gateway' sections, and by having the default user to be assumed as 'root', we are unable to get multiple RGW daemons run on a client machine.
> 
> The start-stop-daemon complains than an instance of 'radosgw' is already running, by starting the first daemon in the configuration and bails out from starting further instances:
> 
> <snip>
> 
> + start-stop-daemon --start -u root -x /usr/bin/radosgw -- -n client.radosgw.gateway-3
> /usr/bin/radosgw already running.
> 
> <\snip>
> 
> However, by having a user specified in the relevant 'client.radosgw.gateway' sections, one can get around this issue. Wanted to confirm if this is indeed a regression or was it expected to behave so from the fix.

This was not intentional. Can you open a tracker ticket?

Thanks!
sage

