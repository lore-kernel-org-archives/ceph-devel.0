From: Gregory Farnum <greg@inktank.com>
Subject: Re: Keys & caps
Date: Tue, 10 Jul 2012 13:09:10 -0700
Message-ID: <CAPYLRzgn6NC9193y4HsH7ASevtX-QWq9P=RrYJpmD3uvyoi8LA@mail.gmail.com>
References: <4183318.yLl07ggMzS@mranderson>
	<Pine.LNX.4.64.1207090925370.20547@cobra.newdream.net>
	<1968682.cis2SWxC6X@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48127 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab2GJUJO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 16:09:14 -0400
Received: by lbbgm6 with SMTP id gm6so951383lbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jul 2012 13:09:10 -0700 (PDT)
In-Reply-To: <1968682.cis2SWxC6X@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 9, 2012 at 10:27 AM, Sz=E9kelyi Szabolcs <szekelyi@niif.hu>=
 wrote:
> On 2012. July 9. 09:33:22 Sage Weil wrote:
>> On Mon, 9 Jul 2012, Sz=E9kelyi Szabolcs wrote:
>> > this far I accessed my Ceph (0.48) FS with the client.admin key, b=
ut I'd
>> > like to change that since I don't want to allow clients to control=
 the
>> > cluster.
>> >
>> > I thought I should create a new key, give it some caps (don't exac=
tly know
>> > which ones), and distribute it to clients. Here are some things I =
don't
>> > know/understand:
>> >
>> > * What do the r, w, x, and * caps ("permissions"?) mean on a mon, =
mds, or
>> > osd?
>>
>> They roughly correspond to read, write, execute.  The distinction is
>> subtle and poorly specfied for mon caps; just use the documented val=
ues
>> for now.
>
> Does this mean that what I'm trying to achieve is not possible at the=
 moment?
> I'd like to give access to my clients to the data in the filesystem, =
but not
> control over the cluster. My thought was that removing some mon caps =
from the
> clients' keys will get me there. But from what you write, it looks to=
 me like
> if a client can access the data in the filesystem, it can also (for e=
xample)
> bring the cluster down...

I believe your filesystem clients only need  'allow r' on the
monitors, and they should be good with 'allow rw' on the OSDs (though
still "allow" on the MDS). This is distinct from the "allow *" cap and
does minimize some ability to cause damage. :)

>> The problem is that the mount.ceph command doesn't understand keyrin=
gs; it
>> only understands secret=3D and secretfile=3D.  There is a longstandi=
ng feature
>> bug open for this
>>
>>       http://tracker.newdream.net/issues/266
>>
>> but it hasn't been prioritized.  Sorry for the confusion!  It will h=
appen
>> soon.
>>
>> In the meantime, you need
>>
>>        -o secretfile=3D/path/to/secretfile,name=3Daccess_fs
>
> Is this also true for the FUSE client? I have obscure memories about =
big
> differences between the kernel and the FUSE client, for example the l=
atter
> being able to read ceph.conf, and get the necessary info, including t=
he
> keyring file, from there. Maybe I didn't emphasize it, but that's wha=
t I'm
> using.

When using ceph-fuse, you want to specify the name with
--name=3Daccess_fs =97 no -o required.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
