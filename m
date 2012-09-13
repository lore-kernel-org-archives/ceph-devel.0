From: Gregory Farnum <greg@inktank.com>
Subject: Re: mds'es stuck in resolve(and one duplicated?)
Date: Thu, 13 Sep 2012 11:37:13 -0700
Message-ID: <CAPYLRzi3Hn3-fMY=9oeRE8VdgDdga_XY3xXDOgnKt_2jj8atDg@mail.gmail.com>
References: <504E5D40.10006@aktzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55887 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab2IMShO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Sep 2012 14:37:14 -0400
Received: by ieje11 with SMTP id e11so5420323iej.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Sep 2012 11:37:13 -0700 (PDT)
In-Reply-To: <504E5D40.10006@aktzero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Thompson <andrewkt@aktzero.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Sep 10, 2012 at 2:36 PM, Andrew Thompson <andrewkt@aktzero.com>=
 wrote:
> Greetings,
>
> Has anyone seen this or got ideas on how to fix it?
>
> mdsmap e18399: 3/3/3 up {0=3Db=3Dup:resolve,1=3Da=3Dup:resolve(laggy =
or
> crashed),2=3Da=3Dup:resolve(laggy or crashed)}
>
> Notice that the 2nd and 3rd mds are the same letter("a"). I'm not sur=
e how
> that happened, I'm guessing a typo in my ceph.conf.

So you actually have three configured MDSes?
What you're seeing there is that the logical[1] MDS 1 and MDS 2 have
both taken so long to report in that the monitor thinks they've
probably died ("laggy or crashed"). You should check out your
ceph.conf and see if you in fact have two named the same =97 the other
possibility is that mds.a actually was the most recent one to take
ownership of both of those logical identities (probably both have a
corrupted state that is causing the daemon to assert out, and perhaps
your MDSes are being restarted by upstart but mds.a went a little
longer than mds.c?), although if it did that's certainly a bug.

> Taking mds.a down doesn't help, b just stays in resolve.
Indeed not =97=A0the resolve phase is when the MDS daemons agree on who
has authority over what part of the filesystem hierarchy.

> mds.a is only running on a single instance, even though it shows as u=
p
> twice.
>
> When I take a mds down, and start it back up, it goes through a coupl=
e of
> states and then sticks at resolve.
>
> I've tried the method listed here, but can't see any change:
> http://www.sebastien-han.fr/blog/2012/07/04/remove-a-mds-server-from-=
a-ceph-cluster/
>
> I tried "ceph mds stop X" as mentioned here
> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/2585 , b=
ut see
> the results below:
>
> athompson@ceph01:~$ sudo ceph mds stop 0
> mds.0 not active (up:resolve)
> athompson@ceph01:~$ sudo ceph mds stop 1
> mds.1 not active (up:resolve)
> athompson@ceph01:~$ sudo ceph mds stop 2
> mds.2 not active (up:resolve)

"Stopping" an MDS requires it to cooperatively give its hierarchy away
to other MDS daemons. Since it's not running, it can't do that.

>
> I've attached the results of `ceph mds dump -o -`
>
> Currently, mds.b.log is full of these reset/connect's and then where =
I
> issued a `service ceph stop mds` a few minutes ago(see attached).

You'll want to go look at mds.a =97=A0its log should have a backtrace t=
hat
might tell us more. Figuring this out will probably also require
enabling some debug logging, but I have to warn you it might not turn
out well =97 we say the POSIX filesystem isn't production ready for a
reason!

Sorry your email dropped through the cracks for a few days; I hope this=
 helps.
-Greg
[1]: Since an MDS has no local storage, each configured system can be
associated with any "logical MDS", which consists solely of the MDS
log and the responsibility for part of the tree.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
