From: Axel Dunkel <ad@dunkel.de>
Subject: Re: radosgw: bad content length
Date: Fri, 30 Jan 2015 18:01:33 +0000 (UTC)
Message-ID: <loom.20150130T180747-561@post.gmane.org>
References: <loom.20150130T152219-712@post.gmane.org> <CABBk=J9G-pQauPiaiixmbZ6U=aLgb16i99WS5Ck0QcZ7ZcGdig@mail.gmail.com> <02c301d03cae$090b3590$1b21a0b0$@dunkel.de> <CABBk=J8ufgB-e8vMua=nk1jYrywy7VB+zNgmCJRXGysB9rJOxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55298 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759727AbbA3SBs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 30 Jan 2015 13:01:48 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YHFt3-00076T-JL
	for ceph-devel@vger.kernel.org; Fri, 30 Jan 2015 19:01:45 +0100
Received: from soc.dunkel.de ([soc.dunkel.de])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 19:01:45 +0100
Received: from ad by soc.dunkel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 19:01:45 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


 >
> > Telling from the source code the issue seems not to be that the 
content
> > lengths do not match, rather that the http-header Content-Length is 
not
> > parseable (allthough the header is displayed fine in the debug 
output). If
> > strict_strtol returns an error, to be exact - ?
> >
> 
> In that case the time is meaningless. How big is Content-Length when 
it fails?

CONTENT_LENGTH=2147483648
just a bit too much for a long - ?

Best regards
Axel Dunkel

