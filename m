From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Fwd: Simple test system not working
Date: Wed, 2 Feb 2011 05:35:59 +0000 (UTC)
Message-ID: <slrnikhra0.3cc.chris@chris.onthe.net.au>
References: <loom.20110201T072445-567@post.gmane.org>
 <4D4890C3.3060408@hq.newdream.net>
 <loom.20110202T021600-867@post.gmane.org>
 <AANLkTinHREewy2QUt8cC33YzaTdS56VENBV6m2-kUuoM@mail.gmail.com>
 <AANLkTimbVpmXzosp2z8aNeMv4WWk+ONoCubpD482Gva8@mail.gmail.com>
Reply-To: chris@onthe.net.au
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:53915 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840Ab1BBFgN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 2 Feb 2011 00:36:13 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1PkVNy-000245-VT
	for ceph-devel@vger.kernel.org; Wed, 02 Feb 2011 06:36:10 +0100
Received: from 180.148.179.26 ([180.148.179.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 02 Feb 2011 06:36:10 +0100
Received: from chris by 180.148.179.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 02 Feb 2011 06:36:10 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

G'day Nev!

On 2011-02-02, Neville Burnell <neville.burnell@gmail.com> wrote:
> Just a guess, but maybe ceph is performing a dns lookup for b3 which
> is returning 127.0.0.1, and talking to 127.0.0.1 requires the loopback
> adapter?

That doesn't appear to be the case: the dns is definitely
configured to return the non-localhost address, and there's no
/etc/hosts entry that would do it. A brief skim and judicious
grepping of the source code doesn't reveal anything interesting
either. The symptom seems to be that the mds and osd daemons
*can* connect to the mon daemon, but the mon daemon tells 'em
to nick off.

Cheers,

Chris.

