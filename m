From: "Handzik, Joe" <joseph.t.handzik@hp.com>
Subject: RE: Thoughts about metadata exposure in Calamari
Date: Mon, 8 Jun 2015 19:50:04 +0000
Message-ID: <2C438B34CAC8264398F5C7AF7411910A634A8A0E@G9W0731.americas.hpqcorp.net>
References: <2C438B34CAC8264398F5C7AF7411910A6349D1E2@G4W3206.americas.hpqcorp.net>,<alpine.DEB.2.00.1506051221440.1217@cobra.newdream.net>
 <73364EFF-DAC3-41F1-816A-DCE5426D4F2B@hp.com> <5572410E.9060806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:51306 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbbFHTuu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jun 2015 15:50:50 -0400
In-Reply-To: <5572410E.9060806@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: "gmeno@redhat.com" <gmeno@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Dan Mick (dmick@redhat.com)" <dmick@redhat.com>

From what I see in the source file, we'd want to fix 'osd crush dump' somehow too, right? I can take a look while I'm working in this area to see what I can accomplish. 

Joe

-----Original Message-----
From: John Spray [mailto:john.spray@redhat.com] 
Sent: Friday, June 05, 2015 7:39 PM
To: Handzik, Joe; Sage Weil
Cc: gmeno@redhat.com; ceph-devel@vger.kernel.org; Dan Mick (dmick@redhat.com)
Subject: Re: Thoughts about metadata exposure in Calamari



On 05/06/2015 20:33, Handzik, Joe wrote:
> I err in the direction of calling 'osd metadata' too, but it does mean that Calamari will need to add that call in (I'll leave it to Gregory to say if that is particularly undesirable). Do you think it would be worthwhile to better define the metadata bundle into a structure, or is it ok to leave it as a set of string pairs?

Versioning of the metadata is something to consider. The "osd metadata" 
stuff is outside the osdmap epochs, so anything that is consuming 
updates to it is stuck with doing some kind of full polling as it 
stands.  It might be that some better interface with versions+deltas is 
needed for a management layer to efficiently consume it.

A version concept where the version is incremented when an OSD starts or 
updates its metadata could make synchronization with a management layer 
much more efficient.  Efficiency matters here when we're calling on the 
mons to serialize data for potentially 10000s of OSDs into JSON whenever 
the management layer wants an update.

John
