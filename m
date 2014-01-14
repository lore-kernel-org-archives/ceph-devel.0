From: Sage Weil <sage@inktank.com>
Subject: Re: EC API to expose locality
Date: Tue, 14 Jan 2014 07:39:45 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401140658120.10628@cobra.newdream.net>
References: <3472A07E6605974CBC9BC573F1BC02E4AE6B0BE8@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38099 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaANPjq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jan 2014 10:39:46 -0500
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE6B0BE8@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Andreas,

On Tue, 14 Jan 2014, Andreas Joachim Peters wrote:
> After some exchange with Loic and the recent list discussion, 
> the API of the EC plugin might need some clarification/extension in the ::encode method:
> 
> Currently ::encode returns a map of bufferlists where the key is the index of [ 0 .. (m+k) ] 
> and the value is the encoded buffer belonging to that stripe index:
> 
> map<int, bufferlist> *encoded
> 
> If a pyramid code is used the index would be [ 0 .. (m+k+(l*l_k)) ] where l is the number of local 
> parity subgroups and l_k are the number of parity stripes per subgroup. The pyramid code would just
> chunk the input into the requested number of subgroups and compute local parity for them according 
> to the configuration.
> 
> With this API the caller has actually no clue how to group stripes together for intelligent
> placement allowing to keep subgroups with local parities together to minimize traffic 
> during remapping and reconstruction.

This is a bit awkward, it's true.  I'm not sure there is a 'magic' way to 
accomplish this.  In the end, the CRUSH rule needs to have the required 
width *and* should group nodes accordingly, but this mapping happens at a 
very different layer in Ceph than the low-level plugin, so even if callers 
had this information they wouldn't be able to do anything about it.

Currently, what we need to do is make sure the EC plugin maps onto a 
linear array of devices the same way that CRUSH does.  For a pyramid code, 
the CRUSH rule will be something like 

 step take root
 step choose 3 rack
 step choose 5 osd
 emit

to get 3 groups of 5 devices as an array of size 15.  That means the EC
plugin needs to map onto ranks that go something like

 0-3 data
 4 local parity
 5-8 data
 9 local parity
 10-11 data
 12-13 global parity
 14 local parity

(or whatever).

Getting this to line up is a bit fragile, unfortunately.  We could make
a plugin method that describes the subgrouping, but even then I'm not
sure how easy it is to programmatically validate that an arbitrary CRUSH
rule will behave well.  Maybe it is enough to

- have some way to query the layout of the EC plugin (e.g, 3 groups of 5).
- add a new 'osd crush rule create-pyramid ...' command to supplement 
  'create-simple'.

and document it well... 

sage


> 
> Either there is an additional function returning the location sub-group [ 0 .. l ] for each created 
> chunk or the ::encode function returns the chunks already grouped like:
> 
> vector<int, map<int, bufferlist> *encoded
> 
> Probably it would be good to have both.
> 
> However it is not clear, if you can actually remap/recover an OSD without destroying the locality 
> of pyramid encoding and if you can at all define CRUSH rules honoring the idea of chunk locality where
> shrinking/extension of pools keeps the locality.
> 
> Last question is, if a remapping/recovery action is only possible with the traffic going through the primary OSD.
> 
> If locality cannot be supported sufficiently now or in the future, should the API stay as it is?
> 
> The ::decode function is fine, since the plugin knows about the locality of the available chunks and will
> select the cheapest decoding possible.
> 
> Cheers Andreas.--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
