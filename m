From: Tim Serong <tserong@suse.com>
Subject: Re: [ceph-calamari] Calamari 1.4
Date: Sat, 20 Feb 2016 08:50:43 +0100
Message-ID: <56C81AD3.9020709@suse.com>
References: <CABq-AySXr9TPruUTB_6V986XGRGaZAETV1djmsYTCTGf2ssPyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:37902 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758121AbcBTHu6 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Sat, 20 Feb 2016 02:50:58 -0500
In-Reply-To: <CABq-AySXr9TPruUTB_6V986XGRGaZAETV1djmsYTCTGf2ssPyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-calamari@lists.ceph.com, ceph-devel <ceph-devel@vger.kernel.org>

On 02/20/2016 02:14 AM, Gregory Meno wrote:
> Coming soon to a jewel near you.
> 
> What is it:
> 
> Calamari is a REST API written in python. It seeks to give API
> endpoints like /cluster,
> /pool, and /osd and unsurprisingly allow HTTP requests to inspect and
> modify the resources a Ceph cluster provides. It simplifies access to
> the control-plane by making it available across the network.
> 
> [...]
> 
> How can I help:
> * Contribute doc improvements
> * File bugs in https://github.com/ceph/calamari/issues
> * Fix bugs :)
> * help with packaging

I can help with that (as of a couple of days ago I've got a very rough
RPM build for SLES and openSUSE).  You'll want patches against the
calamari_on_monitor branch, right?  Or is there going to be a 1.4 branch?

Regards,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
