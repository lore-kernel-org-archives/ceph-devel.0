From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: EC API to expose locality
Date: Tue, 14 Jan 2014 13:43:02 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE6B0BE8@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:45244 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413AbaANNnF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jan 2014 08:43:05 -0500
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

After some exchange with Loic and the recent list discussion, 
the API of the EC plugin might need some clarification/extension in the ::encode method:

Currently ::encode returns a map of bufferlists where the key is the index of [ 0 .. (m+k) ] 
and the value is the encoded buffer belonging to that stripe index:

map<int, bufferlist> *encoded

If a pyramid code is used the index would be [ 0 .. (m+k+(l*l_k)) ] where l is the number of local 
parity subgroups and l_k are the number of parity stripes per subgroup. The pyramid code would just
chunk the input into the requested number of subgroups and compute local parity for them according 
to the configuration.

With this API the caller has actually no clue how to group stripes together for intelligent
placement allowing to keep subgroups with local parities together to minimize traffic 
during remapping and reconstruction.

Either there is an additional function returning the location sub-group [ 0 .. l ] for each created 
chunk or the ::encode function returns the chunks already grouped like:

vector<int, map<int, bufferlist> *encoded

Probably it would be good to have both.

However it is not clear, if you can actually remap/recover an OSD without destroying the locality 
of pyramid encoding and if you can at all define CRUSH rules honoring the idea of chunk locality where
shrinking/extension of pools keeps the locality.

Last question is, if a remapping/recovery action is only possible with the traffic going through the primary OSD.

If locality cannot be supported sufficiently now or in the future, should the API stay as it is?

The ::decode function is fine, since the plugin knows about the locality of the available chunks and will
select the cheapest decoding possible.

Cheers Andreas.