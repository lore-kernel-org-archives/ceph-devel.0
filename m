From: Sage Weil <sweil@redhat.com>
Subject: Re: reducing package size / compression time
Date: Mon, 14 Sep 2015 05:22:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509140522030.23022@cobra.newdream.net>
References: <55F5FAD2.10802@dachary.org> <alpine.DEB.2.00.1509131839480.23022@cobra.newdream.net> <55F66834.3030909@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1782100475-1442233368=:23022"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56319 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754779AbbINMWs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Sep 2015 08:22:48 -0400
In-Reply-To: <55F66834.3030909@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1782100475-1442233368=:23022
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT

On Mon, 14 Sep 2015, Loic Dachary wrote:
> Thanks for the link. Was that effective ?

It appeared to cut out ~17 minutes from the build time, and increased the 
debuginfo package size by 30%.  Seems like a good trade to me!

s

> 
> On 14/09/2015 03:40, Sage Weil wrote:
> > On Mon, 14 Sep 2015, Loic Dachary wrote:
> >> Hi Sage,
> >>
> >> You did something to reduce the size (hence the compression time) of the 
> >> debug packages using 
> >> https://fedoraproject.org/wiki/Features/DwarfCompressor. Would you be so 
> >> kind as to remind me which commit does that ?
> > 
> > https://github.com/ceph/autobuild-ceph/commit/193864ec69edb4dbb0112bb3ea54e6d2f20b30dd
> > 
> > The suggestion came from Boris.
> > 
> > sage
> > 
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> 
> 
--557981400-1782100475-1442233368=:23022--
