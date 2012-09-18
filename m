From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: How are you using Ceph?
Date: Tue, 18 Sep 2012 12:21:32 -0400 (EDT)
Message-ID: <1696200491.44.1347985292864.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <alpine.DEB.2.00.1209180912060.10642@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3644 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324Ab2IRQVm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Sep 2012 12:21:42 -0400
In-Reply-To: <alpine.DEB.2.00.1209180912060.10642@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: f wiessner <f.wiessner@smart-weblications.de>, Ross Turk <ross@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Tren Blackburn <tren@eotnetworks.com>

Hi Sage,

----- "Sage Weil" <sage@inktank.com> wrote:

> Hi Matt,
> 
> On Mon, 17 Sep 2012, Matt W. Benjamin wrote:
> > Hi
> > 
> > Just FYI, on the NFS integration front.  A pnfs files
> (RFC5661)-capable 
> > NFSv4 re-exporter for Ceph has been committed to the Ganesha NFSv4 
> > server development branch.  We're continuing to enhance and
> elaborate 
> > this.  We have had on our (full) plates for a while to return Ceph 
> > client library changes.  We've finished pullup and rebasing of
> these, 
> > are doing some final testing of a couple things in preparation to
> push a 
> > branch for review.
> 
> This is great news!  I'm interested to hear how the Ganesha bits map
> pNFS 
> server instances to OSDs.. is it just matching IP addresses or
> something?

The returned pnfs layouts together with a set of pseudo devices mentioned in it express a striping pattern.  The devices indicate the location of each OSD, each of which is running a Ganesha data server. We're in the process of deepening our integration here, potentially switching to the next draft version of the pnfs object layout.  This will increase the expressiveness of the stripe mappings we can do--as it is now, there is some impedence.

Regards,

Matt

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel. 734-761-4689
fax. 734-769-8938
cel. 734-216-5309
