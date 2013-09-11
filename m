From: Sage Weil <sage@inktank.com>
Subject: Re: Bobtail to dumpling (was: OSD crash during repair)
Date: Tue, 10 Sep 2013 21:10:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309102105410.26058@cobra.newdream.net>
References: <20130906000409.GA10181@onthe.net.au> <alpine.DEB.2.00.1309051937410.6929@cobra.newdream.net> <20130906025004.GA15642@onthe.net.au> <alpine.DEB.2.00.1309051952200.6929@cobra.newdream.net> <20130906031221.GA16201@onthe.net.au>
 <alpine.DEB.2.00.1309060815320.2805@cobra.newdream.net> <20130911005243.GA466@onthe.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37040 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab3IKEK6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Sep 2013 00:10:58 -0400
In-Reply-To: <20130911005243.GA466@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

On Wed, 11 Sep 2013, Chris Dunlop wrote:
> On Fri, Sep 06, 2013 at 08:21:07AM -0700, Sage Weil wrote:
> > On Fri, 6 Sep 2013, Chris Dunlop wrote:
> >> On Thu, Sep 05, 2013 at 07:55:52PM -0700, Sage Weil wrote:
> >>> Also, you should upgrade to dumpling.  :)
> >> 
> >> I've been considering it. It was initially a little scary with
> >> the various issues that were cropping up but that all seems to
> >> have quietened down.
> >> 
> >> Of course I'd like my cluster to be clean before attempting an upgrade!
> > 
> > Definitely.  Let us know how it goes! :)
> 
> Upgraded, directly from bobtail to dumpling.
> 
> Well, that was a mite more traumatic than I expected. I had two
> issues, both my fault...
> 
> Firstly, I didn't realise I should have restarted the osds one
> at a time rather than doing 'service ceph restart' on each host
> quickly in succession. Restarting them all at once meant
> everything was offline whilst "PGs are upgrading".
> 
> Secondly, whilst I saw the 'osd crush update on start' issue in
> the release notes, and checked that my crush map hostnames match
> the actual hostnames, I have two separate pools (for fast SAS vs
> bulk SATA disks) and I stupidly only noticed the one which
> matched, but not the other which didn't match. So on restart all
> the osds moved into the one pool, and started rebalancing.
> 
> The two issues at the same time produced quite the adrenaline
> rush! :-)

I can imagine!

> My current crush configuration is below (host b2 is recently
> added and I haven't added it into the pools yet). Is there a
> better/recommended way of using the crush map to support
> separate pools to avoid setting 'osd crush update on start =
> false'? It doesn't seem that I can use the same 'host' names
> under the separate 'sas' and 'default' roots?

For now we don't have a better solution than setting 'osd crush update on 
start = false'.  Sorry!  I'm guessing that it is pretty uncommong for 
disks to switch hosts, at least.  :/

We could come up with a 'standard' way of structuring these sorts of maps 
with prefixes or suffixes on the bucket names; I'm open to suggestions.

However, I'm also wondering if we should take the next step at the same 
time and embed another dimension in the CRUSH tree so that CRUSH itself 
understands that it is host=b4 (say) but it is only looking at the sas or 
ssd items.  This would (help) allow rules along the lines of "pick 3 
hosts; choose the ssd from the first and sas disks from the other two".  
I'm not convinced that is an especially good idea for most users, but it's 
probably worth considering.

sage


> 
> Cheers,
> 
> Chris
> 
> ----------------------------------------------------------------------
> # ceph osd tree
> # id    weight  type name       up/down reweight
> -8      2       root sas
> -7      2               rack sas-rack-1
> -5      1                       host b4-sas
> 4       0.5                             osd.4   up      1       
> 5       0.5                             osd.5   up      1       
> -6      1                       host b5-sas
> 2       0.5                             osd.2   up      1       
> 3       0.5                             osd.3   up      1       
> -1      12.66   root default
> -3      8               rack unknownrack
> -2      4                       host b4
> 0       2                               osd.0   up      1       
> 7       2                               osd.7   up      1       
> -4      4                       host b5
> 1       2                               osd.1   up      1       
> 6       2                               osd.6   up      1       
> -9      4.66            host b2
> 10      1.82                    osd.10  up      1       
> 11      1.82                    osd.11  up      1       
> 8       0.51                    osd.8   up      1       
> 9       0.51                    osd.9   up      1       
> 
> ----------------------------------------------------------------------
> # begin crush map
> 
> # devices
> device 0 osd.0
> device 1 osd.1
> device 2 osd.2
> device 3 osd.3
> device 4 osd.4
> device 5 osd.5
> device 6 osd.6
> device 7 osd.7
> device 8 osd.8
> device 9 osd.9
> device 10 osd.10
> device 11 osd.11
> 
> # types
> type 0 osd
> type 1 host
> type 2 rack
> type 3 row
> type 4 room
> type 5 datacenter
> type 6 root
> 
> # buckets
> host b4 {
> 	id -2		# do not change unnecessarily
> 	# weight 4.000
> 	alg straw
> 	hash 0	# rjenkins1
> 	item osd.0 weight 2.000
> 	item osd.7 weight 2.000
> }
> host b5 {
> 	id -4		# do not change unnecessarily
> 	# weight 4.000
> 	alg straw
> 	hash 0	# rjenkins1
> 	item osd.1 weight 2.000
> 	item osd.6 weight 2.000
> }
> rack unknownrack {
> 	id -3		# do not change unnecessarily
> 	# weight 8.000
> 	alg straw
> 	hash 0	# rjenkins1
> 	item b4 weight 4.000
> 	item b5 weight 4.000
> }
> host b2 {
> 	id -9		# do not change unnecessarily
> 	# weight 4.660
> 	alg straw
> 	hash 0	# rjenkins1
> 	item osd.10 weight 1.820
> 	item osd.11 weight 1.820
> 	item osd.8 weight 0.510
> 	item osd.9 weight 0.510
> }
> root default {
> 	id -1		# do not change unnecessarily
> 	# weight 12.660
> 	alg straw
> 	hash 0	# rjenkins1
> 	item unknownrack weight 8.000
> 	item b2 weight 4.660
> }
> host b4-sas {
> 	id -5		# do not change unnecessarily
> 	# weight 1.000
> 	alg straw
> 	hash 0	# rjenkins1
> 	item osd.4 weight 0.500
> 	item osd.5 weight 0.500
> }
> host b5-sas {
> 	id -6		# do not change unnecessarily
> 	# weight 1.000
> 	alg straw
> 	hash 0	# rjenkins1
> 	item osd.2 weight 0.500
> 	item osd.3 weight 0.500
> }
> rack sas-rack-1 {
> 	id -7		# do not change unnecessarily
> 	# weight 2.000
> 	alg straw
> 	hash 0	# rjenkins1
> 	item b4-sas weight 1.000
> 	item b5-sas weight 1.000
> }
> root sas {
> 	id -8		# do not change unnecessarily
> 	# weight 2.000
> 	alg straw
> 	hash 0	# rjenkins1
> 	item sas-rack-1 weight 2.000
> }
> 
> # rules
> rule data {
> 	ruleset 0
> 	type replicated
> 	min_size 1
> 	max_size 10
> 	step take default
> 	step chooseleaf firstn 0 type host
> 	step emit
> }
> rule metadata {
> 	ruleset 1
> 	type replicated
> 	min_size 1
> 	max_size 10
> 	step take default
> 	step chooseleaf firstn 0 type host
> 	step emit
> }
> rule rbd {
> 	ruleset 2
> 	type replicated
> 	min_size 1
> 	max_size 10
> 	step take default
> 	step chooseleaf firstn 0 type host
> 	step emit
> }
> rule rbd-sas {
> 	ruleset 3
> 	type replicated
> 	min_size 1
> 	max_size 10
> 	step take sas
> 	step chooseleaf firstn 0 type host
> 	step emit
> }
> 
> # end crush map
> ----------------------------------------------------------------------
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
