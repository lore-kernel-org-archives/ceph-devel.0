From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: MDS auth caps for cephfs
Date: Thu, 28 May 2015 11:21:17 -0600
Message-ID: <CAANLjFrs6xrQXJHu-Z7bqw_FWmGbqbc-HT1SKBxi0=Ls2SmBbg@mail.gmail.com>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net>
	<alpine.DEB.2.00.1505261601400.26752@cobra.newdream.net>
	<CAC6JEv8tb3J-oNSe7SgNJGvLfXPWvXkd+W6aOK_+dsjktoYUrA@mail.gmail.com>
	<alpine.DEB.2.00.1505271427590.6462@cobra.newdream.net>
	<CAC6JEv85TGA32MUpSjg6bhuWJp16833HQh8pwbFvgW84S7BRyg@mail.gmail.com>
	<alpine.DEB.2.00.1505271508020.6462@cobra.newdream.net>
	<CAC6JEv_Kpkgra-w=yrfyNh_WEdy5ouCOyx-hosup69h0VaxVzQ@mail.gmail.com>
	<alpine.DEB.2.00.1505271542410.6462@cobra.newdream.net>
	<CAC6JEv8BfMX+jHq8PCONFM4sMN81Nk+YfYkHJbHWK90kKnC+TQ@mail.gmail.com>
	<alpine.DEB.2.00.1505271646360.6462@cobra.newdream.net>
	<CAC6JEv_Jw5S94E2yiW-g-t1Ro3gjiYXnoRKGNf=721CjoLESkA@mail.gmail.com>
	<alpine.DEB.2.00.1505271728250.6462@cobra.newdream.net>
	<CAC6JEv8pmJ-PhMUVqoP_VNsGR-STyjiyfcPqqpEQRv8x=UTjwA@mail.gmail.com>
	<CAANLjFqA+X7WYQ6NX_-L--vZorerSCQs6YcNSfUrurjsQFOsYA@mail.gmail.com>
	<CAC6JEv-MH=1uJD1HudhHJ=8wfg+dP3d9euhwLNEB-idsogGu+Q@mail.gmail.com>
	<alpine.DEB.2.00.1505280957450.6462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37405 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbbE1RVT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 13:21:19 -0400
Received: by wifw1 with SMTP id w1so70990329wif.0
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 10:21:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1505280957450.6462@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <greg@gregs42.com>, John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

On Thu, May 28, 2015 at 11:02 AM, Sage Weil <sage@newdream.net> wrote:

>> > The MDS could combine a tenant ID and a UID/GID to store unique
>> > UID/GIDs on the back end and just strip off the tenant ID when
>> > presented to the client so there are no collisions of UID/GIDs between
>> > tenants in the MDS.
>>
>> Hmm, that is another thought...
>
> Unless you ask Ceph to enforce the unix permissions server side, the
> uid/gid are stored but not interpreted.  I don't think the tenant ID is
> needed since there is no impact if the same uids are used in different
> subtrees.  It's just up to the admin to divvy up non-overlapping subtrees
> to the tenants...

I don't think I would expect Ceph to enforce file permissions, only
share permissions. The file permissions should be enforced by the host
mounting the FS.

If Ceph appends 8 bits as the Tenant ID to the 16 bit UID/GID for
example, then Ceph only has to match and act the first 8 bits and pass
the next 16 bits to the client. It only has to store the UID/GID and
perms/ACLs. Then you don't have to worry about not crossing the
streams in subtrees. If an admin later decides to provide access to
two clients to the same subtree nothing bad will happen. The two
clients will have to figure out between themselves what to do with
UID/GIDs/perms/ACLs to provide the appropriate access.

If for instance a directory is shared between tenant A and B, and A
can write and B can't, then when B tries to write because the perms
are correct for the UID/GID on the client side, the MDS will prevent
the write because that tenant doesn't have "share" write access on
that directory.

If a tenant wants to allow write access to part of a directory, then
there has to be some level of trust that they will act responsibly. I
can't see getting around that without implementing Kerberos and
preventing the client from mapping to other UID/GIDs, but that really
takes the flexibility out of the system.

----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
