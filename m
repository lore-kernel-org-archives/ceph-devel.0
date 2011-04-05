From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Question about librados
Date: Tue, 05 Apr 2011 16:07:27 +0200
Message-ID: <1302012447.9554.2.camel@Nokia-N900-02-8>
References: <incab7$gnn$1@dough.gmane.org>
	 <BANLkTi=-9ESbE5uaMZYBH2X9Q5y-gPtW7w@mail.gmail.com>
	 <inedo0$3v2$1@dough.gmane.org>
	 <BANLkTik1OakYf7aqeUd6AW=wVXB87T72eg@mail.gmail.com>
	  <inf6mb$ln4$1@dough.gmane.org>
Reply-To: Wido den Hollander <wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:39187 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab1DEOJD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2011 10:09:03 -0400
In-Reply-To: <inf6mb$ln4$1@dough.gmane.org>
Content-ID: <1302012447.9554.1.camel@Nokia-N900-02-8>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rutger ter Borg <rutger@terborg.net>, ceph-devel@vger.kernel.org

Hi,
----- Original message -----
> On 04/05/2011 03:42 PM, Gregory Farnum wrote:
> > 
> > Have you tried using the full make system (go to src dir,
> > ./autogen.sh; ./configure; make)? All the required headers should get
> > pulled in when you install the package, but they might not be in your
> > default include paths.
> 
> No, I haven't tried compiling from source (yet). I did try the 
> following, though
> 
> rutger@gonzo:~$ dpkg -S atomic_ops
> dpkg-query: no path found matching pattern *atomic_ops*.
> 
> which made me conclude that I don't have the file. Probably a package 
> thing; I'm using the
> 
> deb http://ceph.newdream.net/debian/ sid main
> 
> repository on Debian sid amd64.
> 

On Debian/Ubuntu that file is in libatomic-ops-dev, it might be useful if librados-dev depended on that package.

Wido
