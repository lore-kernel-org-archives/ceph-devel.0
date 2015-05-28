From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: MDS auth caps for cephfs
Date: Thu, 28 May 2015 11:06:16 -0600
Message-ID: <CAANLjFpt06ML9x20swYTRS=jmBmc5PX4SFhBxCXV-1y7BwODeQ@mail.gmail.com>
References: <alpine.DEB.2.00.1505201651260.23818@cobra.newdream.net>
	<alpine.DEB.2.00.1505260801360.6462@cobra.newdream.net>
	<CAC6JEv-QN8_-eQP7mt_5=H-X16CO_GUYMpx_npFTsG5rJjQK=Q@mail.gmail.com>
	<alpine.DEB.2.00.1505261503480.26752@cobra.newdream.net>
	<CAC6JEv8wmyyQ9LhOEEWG-jZhUQXcjR1RgVyJReH6ubEG_L_ipg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35057 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbbE1RGS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 13:06:18 -0400
Received: by wicmx19 with SMTP id mx19so153913817wic.0
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 10:06:16 -0700 (PDT)
In-Reply-To: <CAC6JEv-MH=1uJD1HudhHJ=8wfg+dP3d9euhwLNEB-idsogGu+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Sage Weil <sweil@redhat.com>, John Spray <john.spray@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Nishtha Rai <nishtha3rai@gmail.com>, jashan kamboj <jashank42@gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I think if there is a way to store the tenant ID with the UID/GID,
then a lot of the challenges could be resolved.

On Thu, May 28, 2015 at 10:42 AM, Gregory Farnum  wrote:

> Right, this is basically what we're planning. The sticky bits are abo=
ut
> 1) dealing with clients that have access to multiple UIDs/GIDs
> (because different end users are on the same host, for instance). :)

I'm having trouble visualizing this. This seems to be the best option
because there is no collision of UID/GIDs. If the problem is that a
user on multiple boxes don't have the ability to set their UID/GID to
the same thing, then that is where the client can specify which
UID/GID to use. But by doing so, they can't access anything from other
tenants because the tenant ID won't match on the MDS.

> 2) dealing with "public cloud"-like scenarios, where you have a bunch
> of tenants who are all root on their own machines and thus control
> their UID space. (Right now we can't put multiple CephFS instances in
> a single RADOS cluster, so the only obvious way to support this is by
> giving each client their own subspace within the unified hierarchy.)

Yes, the tenant ID would give each tenant to do their own thing
regardless of root access to their local boxes. It creates a separate
space that the MDS can enforce.

>> Some tenants may want just local UID/GID
>> management, others may want LDAP, Kerberos, etc. I believe Ceph shou=
ld
>> only be worried about "share" permissions and leave "file" permissio=
ns
>> to the tenant. Ceph just needs the ability to store UID/GID and POSI=
X
>> ACLs.
>
> Well that doesn't quite work =E2=80=94 it's entirely possible you wan=
t to
> share read-only files with a bunch of people that shouldn't be allowe=
d
> to write them; that lack of write ability needs to be enforced by Cep=
h
> at the server layer!

The MDS would add the tenant ID to the perms, if it doesn't match,
then they can't write, only read because that is what is specified in
the User caps, only the "owner" of the directory would have write
access.

>> The MDS could combine a tenant ID and a UID/GID to store unique
>> UID/GIDs on the back end and just strip off the tenant ID when
>> presented to the client so there are no collisions of UID/GIDs betwe=
en
>> tenants in the MDS.
>
> Hmm, that is another thought...
> -Greg

- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVZ0sFCRDmVDuy+mK58QAAOqAQAJYvWDoCK6bv6YN49ccx
Ifu9P+1utGAOa9P+pE+BOGqdGWuMo++W371Iy5MkjsYU9Rli4LMwGxLjL8cs
s1wNyZ0KZej8q4ibkz1wH0btdv+vcIB79NICZE1CzKCIsMX5tWb6U2T0RG0g
KHhPQXFtYteRHimIUskG7VVvXyti8N0ysOUoSWDz/CXcFZEw2en9+M4jyMlr
9wqbzJzftfBpGq7FMXUaQC5t4tRTTg3mN8UPK2/SSINawwyM4QeCLHD+1+5b
1ksTAkD/weOX+IBnvRlaA9s+GsMHxi5pl7Ns2Oxb+TV3Kyx8mTI9ly28Euy+
JwKD3IyVS3ByIOfuzlaSsRwKnisaq3w1oaVeN9rAmDBK6N/CGsnGQ7ZdhcaO
wlFJcW9k1RMYGA4/dc08MIDs0k2Xo3qjuJNvtIT0et97l7qtylRYno7D1Uh4
cd4v5kzH7FgmuUIFn8x5GOhnHeDR9essL7PbidqyBYh6KEgoAQPzw99OyHje
rP3dlO4CmQDmB5lNj45CNFRe65kyMCbP5kMlHNWMu8NUiZo65yeXp2MX3+oB
9Vkq51Nznb3KTYqIcDTk3SCK5hKFcv55zAFvlnPLoapUeya3tsUmZn5Ui4U7
JZtzMebvtcHaITf9gZjmrST34B6D4Eqw5fydN0qsVXlVBmbbU86CkOPWVLS+
=46wa+
=3DAZFj
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
