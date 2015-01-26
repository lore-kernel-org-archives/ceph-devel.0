From: Sage Weil <sweil@redhat.com>
Subject: RE: wip-auth
Date: Mon, 26 Jan 2015 09:23:32 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501260921250.3895@cobra.newdream.net>
References: <alpine.DEB.2.00.1501221512580.19192@cobra.newdream.net> <3649A15A2562B54294DE14BCE5AC79120AB43257@ORSMSX152.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50766 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752778AbbAZRXh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 26 Jan 2015 12:23:37 -0500
In-Reply-To: <3649A15A2562B54294DE14BCE5AC79120AB43257@ORSMSX152.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Blinick, Stephen L" <stephen.l.blinick@intel.com>
Cc: "andreas.bluemle@itxperts.de" <andreas.bluemle@itxperts.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 26 Jan 2015, Blinick, Stephen L wrote:
> I noticed that the spec file for building RPM's defaults to building with libnss, instead of libcrypto++.  Since the measurements I'd done so far were from those RPM's I rebuilt with libcrypto++.. so FWIW here is the difference between those two on my system, memstore backend with a single OSD, and single client.    
> 
> Dual socket Xeon E5 2620v3, 64GB Memory,  RHEL7 
> Kernel: 3.10.0-123.13.2.el7
> 
> 100% 4K Writes, 1xOSD w/ Rados Bench
> 	libnss		            |    Cryptopp		
> # QD	IOPS	Latency(ms)   |	IOPS	Latency(ms)	IOPS Improvement %
> 16	14432.57	1.11    |	18896.60	0.85	30.93%
> 	                                     
> 100% 4K Reads, 1xOSD w/ Rados Bench				
> 	libnss | Cryptopp # QD IOPS Latency(ms)  | IOPS Latency(ms) IOPS 
> Improvement % 16 19532.53 0.82 | 25708.70 0.62 31.62%

Yikes, 30%!  I think this definitely worth some effort.  We switched to 
libnss because it has the weird government certfiications that everyone 
wants and is more prevalent.  crypto++ is also not packaged for Red 
Hat distros at all (presumably for that reason).

I suspect that most of the overhead is in the encryption context setup and 
can be avoided with a bit of effort..

sage


> 
> 
> Thanks,
> 
> Stephen
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Thursday, January 22, 2015 4:56 PM
> To: andreas.bluemle@itxperts.de
> Cc: ceph-devel@vger.kernel.org
> Subject: wip-auth
> 
> Hi Andreas,
> 
> I took a look at the wip-auth I mentioned in the security call last week... and the patch didn't work at all.  Sorry if you wasted any time trying it.
> 
> Anyway, I fixed it up so that it actually worked and made one other optimization.  It would be great to hear what latencies you measure with the changes in place.
> 
> Also, it might be worth trying --with-cryptopp (or --with-nss if you built cryptopp by default) to see if there is a difference.  There is a ton of boilerplate setting up encryption contexts and key structures and so on that I suspect could be cached (perhaps stashed in the CryptoKey struct?) with a bit of effort.  See
> 
> 	https://github.com/ceph/ceph/blob/master/src/auth/Crypto.cc#L99-L213
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
