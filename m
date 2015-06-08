From: Dan Mick <dmick@redhat.com>
Subject: Re: Thoughts about metadata exposure in Calamari
Date: Mon, 08 Jun 2015 12:54:06 -0700
Message-ID: <5575F2DE.7010306@redhat.com>
References: <2C438B34CAC8264398F5C7AF7411910A6349D1E2@G4W3206.americas.hpqcorp.net>,<alpine.DEB.2.00.1506051221440.1217@cobra.newdream.net> <73364EFF-DAC3-41F1-816A-DCE5426D4F2B@hp.com> <5572410E.9060806@redhat.com> <2C438B34CAC8264398F5C7AF7411910A634A8A0E@G9W0731.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54015 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbbFHTyG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 8 Jun 2015 15:54:06 -0400
In-Reply-To: <2C438B34CAC8264398F5C7AF7411910A634A8A0E@G9W0731.americas.hpqcorp.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Handzik, Joe" <joseph.t.handzik@hp.com>, John Spray <john.spray@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: "gmeno@redhat.com" <gmeno@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The crush map changing causes a change in the osdmap version, I'm pretty
sure.

On 06/08/2015 12:50 PM, Handzik, Joe wrote:
> From what I see in the source file, we'd want to fix 'osd crush dump' somehow too, right? I can take a look while I'm working in this area to see what I can accomplish. 
> 
> Joe
> 
> -----Original Message-----
> From: John Spray [mailto:john.spray@redhat.com] 
> Sent: Friday, June 05, 2015 7:39 PM
> To: Handzik, Joe; Sage Weil
> Cc: gmeno@redhat.com; ceph-devel@vger.kernel.org; Dan Mick (dmick@redhat.com)
> Subject: Re: Thoughts about metadata exposure in Calamari
> 
> 
> 
> On 05/06/2015 20:33, Handzik, Joe wrote:
>> I err in the direction of calling 'osd metadata' too, but it does mean that Calamari will need to add that call in (I'll leave it to Gregory to say if that is particularly undesirable). Do you think it would be worthwhile to better define the metadata bundle into a structure, or is it ok to leave it as a set of string pairs?
> 
> Versioning of the metadata is something to consider. The "osd metadata" 
> stuff is outside the osdmap epochs, so anything that is consuming 
> updates to it is stuck with doing some kind of full polling as it 
> stands.  It might be that some better interface with versions+deltas is 
> needed for a management layer to efficiently consume it.
> 
> A version concept where the version is incremented when an OSD starts or 
> updates its metadata could make synchronization with a management layer 
> much more efficient.  Efficiency matters here when we're calling on the 
> mons to serialize data for potentially 10000s of OSDs into JSON whenever 
> the management layer wants an update.
> 
> John
> 

