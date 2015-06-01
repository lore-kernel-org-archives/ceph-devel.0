From: Sage Weil <sage@newdream.net>
Subject: Re: MDS auth caps for cephfs
Date: Mon, 1 Jun 2015 12:39:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506011131270.10340@cobra.newdream.net>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net> <alpine.DEB.2.00.1505271508020.6462@cobra.newdream.net> <CAC6JEv_Kpkgra-w=yrfyNh_WEdy5ouCOyx-hosup69h0VaxVzQ@mail.gmail.com> <alpine.DEB.2.00.1505271542410.6462@cobra.newdream.net>
 <CAC6JEv8BfMX+jHq8PCONFM4sMN81Nk+YfYkHJbHWK90kKnC+TQ@mail.gmail.com> <alpine.DEB.2.00.1505271646360.6462@cobra.newdream.net> <CAC6JEv_Jw5S94E2yiW-g-t1Ro3gjiYXnoRKGNf=721CjoLESkA@mail.gmail.com> <alpine.DEB.2.00.1505271728250.6462@cobra.newdream.net>
 <CAC6JEv8pmJ-PhMUVqoP_VNsGR-STyjiyfcPqqpEQRv8x=UTjwA@mail.gmail.com> <CAANLjFqA+X7WYQ6NX_-L--vZorerSCQs6YcNSfUrurjsQFOsYA@mail.gmail.com> <CAC6JEv-MH=1uJD1HudhHJ=8wfg+dP3d9euhwLNEB-idsogGu+Q@mail.gmail.com> <alpine.DEB.2.00.1505280957450.6462@cobra.newdream.net>
 <CAANLjFrs6xrQXJHu-Z7bqw_FWmGbqbc-HT1SKBxi0=Ls2SmBbg@mail.gmail.com> <alpine.DEB.2.00.1505281024560.6462@cobra.newdream.net> <CAANLjFqoZ0hBjXEHAcc4VLygCuzwzxtKpNH+nJHE3X00dvfKqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54016 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbbFATjd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jun 2015 15:39:33 -0400
In-Reply-To: <CAANLjFqoZ0hBjXEHAcc4VLygCuzwzxtKpNH+nJHE3X00dvfKqQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Gregory Farnum <greg@gregs42.com>, John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

I have a pull request posted at

	https://github.com/ceph/ceph/pull/4809

that updates the mds cap parser and defines a check method.  Please take 
a look and see if this makes sense.

For the path restrictions, I think the next steps are something like

 - generate a path string and pass it in to that method
 - write some simple tests
 - make sure the hook is called from everywhere it needs to be (all of the 
other request handlers in Server.cc)
 - call the hook from the cap writeback path (tricky)
 - figure out how to handle files in the stray dir (tricky)

For the user-based restrictions,

 - I think we need to expand the allows() method so that it has a couple 
output arguments (uid and gid list) that subsequent permissions should be 
validated against.  Then we can change the function in Server.cc so 
that when those are populated it does an actually unix permissions check.  
This seems like the simplest thing to me, although it does have the 
slightly-odd property that if you are doing an operation that requires 
permission on two inodes (directory and file, say) you might have to 
different 'allow ...' lines granting access to each.  (I think this is 
both painful to avoid and also harmless?)
 - same items above to call into the check method in the appropriate 
places.
 - extend client/mds protocol to pass credential struct.  This should 
piggyback on Goldwyn's work to fix up these structures for namespaces.
 - mark caps with credentials on clients, fix writeback order, etc.

In any case, the first item on both those lists seems like the place 
to start.

sage
