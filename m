From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: Fixing NFS
Date: Mon, 7 Feb 2011 17:51:31 -0800
Message-ID: <AANLkTi=u6A539u3MV4irCrKG1gYgW+oMq7NoB=k4UxkZ@mail.gmail.com>
References: <AANLkTikdOsP-=YxwjRtPhso9asxZmYc09QgL_MwMux7f@mail.gmail.com>
	<Pine.LNX.4.64.1102030917190.19855@cobra.newdream.net>
	<20110203175242.GA6348@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50305 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab1BHBvc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Feb 2011 20:51:32 -0500
Received: by vxb37 with SMTP id 37so2005580vxb.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Feb 2011 17:51:31 -0800 (PST)
In-Reply-To: <20110203175242.GA6348@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Feb 3, 2011 at 9:52 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Thu, Feb 03, 2011 at 09:29:32AM -0800, Sage Weil wrote:
>> Which leaves us with a final problem: what if the fh is generated fo=
r
>> /foo/bar, but bar is renamed to /baz/bar, bar drops out of all cache=
s, and
>> the client tries to use the fh. =A0We're still stuck with ESTALE in =
that
>> case. =A0The only real solution there is to include a backpointer on=
 the
>> file's data object. =A0This is doable, but comes at a cost. =A0We co=
uld make
>> it optional, and/or mitigate it somewhat (backpointer is only create=
d once
>> a file is renamed, or something like that).
>>
>> I'm not really sure to what lengths a server is supposed to go to av=
oid
>> ESTALE. =A0I seem to remember that NFSv4 has a different class of fh=
's that
>> are allowed to expire. =A0I'm not sure how that helps, though; it se=
ems
>> likeif a client has a file open that is renamed by another node and =
then
>> idle for long enough and then tries to read it'll still be screwed,
>> regardless of what the server does/does not promise the client.
>
> NFSv4 volatile filehandles move away from the whole "stale"
> terminology into "expiring" filehandles, which a client SHOULD recove=
r
> from, and that's said with fairly strong language in RFC3530. The
> volatile filehandles may go away at any moment (for FH4_VOLATILE_ANY)=
=2E
>
> The RFC suggests clients remember the full path of every volatile
> filehandle, and points out that doesn't let you recover if someone
> else renamed the file.. which means your "final problem" above is
> still a problem, and smells unavoidable. But at least shifting
> responsibility for remembering the path to the client makes recovery
> easy in the typical case.
>
> If the real-world support is there, I'd say NFSv4 is the way to go,
> for future Ceph re-exporting.


I was playing around with implementing this.  I was trying to get the
ceph client's export functions to return NFS4ERR_FHEXPIRED instead of
ESTALE (hoping that my nfs4 clients would then attempt the full lookup
again).  I noticed also that the mds itself can also return an ESTALE
to the ceph kernel client, which seems to be getting propagated back
to the NFS client.  I'm wondering where I could intercept that and
send back an expiry notice?

-Brian


>
> --
> :(){ :|:&};:
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
