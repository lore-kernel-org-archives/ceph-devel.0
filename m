From: "Handzik, Joe" <joseph.t.handzik@hp.com>
Subject: RE: Preferred location for utility execution
Date: Mon, 29 Jun 2015 20:46:12 +0000
Message-ID: <2C438B34CAC8264398F5C7AF7411910A6D961B92@G4W3206.americas.hpqcorp.net>
References: <2C438B34CAC8264398F5C7AF7411910A6D9605F5@G4W3206.americas.hpqcorp.net>
 <558DD0FC.8080608@redhat.com>
 <2C438B34CAC8264398F5C7AF7411910A6D961A4B@G4W3206.americas.hpqcorp.net>
 <5591A5FD.2030708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:59802 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbbF2Ur2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 16:47:28 -0400
In-Reply-To: <5591A5FD.2030708@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>
Cc: "gmeno@redhat.com" <gmeno@redhat.com>

Sounds like a worthwhile discussion point for the blueprint session. Thanks for the feedback!

Joe

-----Original Message-----
From: John Spray [mailto:john.spray@redhat.com] 
Sent: Monday, June 29, 2015 3:10 PM
To: Handzik, Joe; ceph-devel
Cc: gmeno@redhat.com
Subject: Re: Preferred location for utility execution

On 29/06/2015 19:44, Handzik, Joe wrote:
> Thanks for the reply, John. I knew where you stood. :)
>
> I tend to agree with you for much of this, I should be able to pull a 
> fair amount of drive metadata out of /sys, and now that I've added the 
> device node to bootstrap off of, that sort of data collection should 
> be easy to initiate alongside the rest of the metadata collection 
> here: https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L4566
>
> Something I'm not sure of is, say, Gregory's commit to Calamari. Does your opinion extend to functionality like that? Should SMART be collected within Ceph, rather than via a salt script initiated by Calamari?

Good question...  It depends on your position: if you're someone already using or developing Calamari, then it's a perfectly reasonable thing to add into Calamari.  If you're looking for a way to provide functionality for most ordinary ceph users, and enable involvement of most ceph developers, then Calamari brings quite a bit of baggage with it, and it's much more desirable to have it baked into Ceph.

The good news is that there's no rule against doing these things both places, so there's not really a wrong answer (at least in my opinion).  
We might find that while Calamari remains a minority thing, it's useful to have a whizz-bang version of a feature in Calamari, and something more basic baked into Ceph.  That's kind of already true for e.g. 
calamari's /server API vs. ceph's built in "node ls".

Finally, going a bit off topic: in an ideal world, the answer would be to get Calamari where it needs to be, and then add hardware monitoring functionality into Calamari while keeping the core of Ceph lightweight.  
This applies to other pieces of functionality, like the recent "node ls" 
functionality, continued existence of ceph-rest-api, some of the recent MDS health check stuff, all the kind of things that we would add in the python layer if we had one that was positioned to be present in all Ceph deployments, rather than only some.  Instead, we're writing these things into the C++ part because that's the only way to reach all the users.  
Calamari can only take up that role once it's:
  * Packaged (without any onerous dependencies)
  * Comprehensive (can do anything the CLI can do)
  * Lightweight (nothing to prevent us from enabling it by default)

John

