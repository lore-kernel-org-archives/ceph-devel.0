From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Hardware Requirements for RADOS Gateway Cluster
Date: Mon, 24 Sep 2012 18:34:21 -0500
Message-ID: <5060EDFD.1050908@inktank.com>
References: <5060E5AE.10400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40764 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab2IXXeZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Sep 2012 19:34:25 -0400
Received: by ieak13 with SMTP id k13so12454963iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 24 Sep 2012 16:34:24 -0700 (PDT)
In-Reply-To: <5060E5AE.10400@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brice Burgess <briceburg@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Brice!

On 09/24/2012 05:58 PM, Brice Burgess wrote:
>I am planning the system architecture around a ceph cluster [my first!].
> While resources for setting up the basic cluster (MON+MDS+OSD) are
> readily available*, I haven't come across anything outlining production
> recommendations for a RADOS Gateway Cluster. Specifically;
>
> 1. Is it preferable to run the RADOS Gateway on a MDS machine [for
> latency issues], or should the Gateway run on seperate hosts/VMs than
> the ODS/MON/MDS servers?
>

It's entirely possible to run the gateway on an OSD/MON/MDS.  I don't 
think we've done any kind of extensive analysis of where the best place 
to run one is.  My guess is that it will only matter in very specific cases.

> 2. I've seen reference that multiple RADOS Gateway servers can be setup
> as a cluster "to scale". Is this possible? Is there an
> example/documentation for this? Is it just 2 standalone gateways with a
> load balancer in front?
>

Yes!  It's entirely possible to run multiple RGWs with a load balancer 
in front.  I'm not sure how much documentation is out there for this 
yet, but it's something that customers of ours have successfully 
implemented.

> My assumption is to provision a dedicated machine for the RADOS Gateway.
> I'd treat this machine as a "front end proxy/caching server" meaning it
> would have a lot of RAM for varnish/nginx and a low latency, high
> throughput network connection to the ODS/MDS machines as well as one to
> the public network.

Sounds good to me.  Other people might chime in with more suggestions.

>
> Any thoughts and suggestions are welcome. Eventually I'd like to release
> a whitepaper of this setup if we can hit the budget to actually
> implement ;)

Some things you'll want to keep in mind:

You'll want to make sure that your testing (especially of small IO) is 
done across many buckets.  Performance of a single bucket can be limited 
by the OSD where it's log is stored (or optionally you can turn the log 
off).  You'll also want to keep in mind that RGW will likely incur 
larger performance overhead for small objects than large ones.

Thanks,
Mark
