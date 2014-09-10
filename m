From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: Question to RWLock & reverse DNS ip=>hostname
Date: Wed, 10 Sep 2014 07:52:52 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE7BCB2D@CERNXCHG44.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4AE7B5737@CERNXCHG44.cern.ch>
	<alpine.DEB.2.00.1409091050040.11887@cobra.newdream.net>,<CAPYLRzj7K6MadhMVDRtsusKxo3nMWEe+-Ed5uNryMMsk8-s4ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:29193 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbaIJHw4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Sep 2014 03:52:56 -0400
In-Reply-To: <CAPYLRzj7K6MadhMVDRtsusKxo3nMWEe+-Ed5uNryMMsk8-s4ng@mail.gmail.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We did a lot of testing of RW locks in another multi-threaded project a=
nd we use successfully "PTHREAD_RWLOCK_PREFER_WRITER_NP" which works pe=
rfectly fine if you avoid recursive read locks. It is probably good pra=
ctice to avoid any recursive mutex in general.

If one stay's with the default RW mutex without setting attributes we h=
ave seen that you starve writers for long periods if there is a content=
ion on the read mutex (n-reader >> n-writer). I agree this is a very 's=
ensitive' topic but could well be an origin for threading scalability p=
roblems - depends how and where you use the RW locks in CEPH.

Cheers Andreas.

________________________________________
=46rom: Gregory Farnum [greg@inktank.com]
Sent: 09 September 2014 21:56
To: Sage Weil
Cc: Andreas Joachim Peters; ceph-devel@vger.kernel.org
Subject: Re: Question to RWLock & reverse DNS ip=3D>hostname

On Tue, Sep 9, 2014 at 10:50 AM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 9 Sep 2014, Andreas Joachim Peters wrote:
>> Hi,
>> by chance I had a look to the RWLock class. To my best knowledge the=
 way
>> you create RW locks it defaults to writer-starvation e.g. all reader=
s
>> will always jump a head of a pending writer. I cannot imagine that y=
ou
>> never have the opposite requirement in the CEPH multithreaded code b=
ut I
>> didn't review where it is used. In case you are aware, you can just
>> ignore this comment, otherwise one could add the option to create a
>> writer-prefering RWLock at construction time using e.g.
>> pthread_rwlockattr_setkind_np(&attr, PTHREAD_RWLOCK_PREFER_WRITER_NP=
)
>
> Hmm, I was not aware.  Perhaps we should make the reader vs writer
> preference explicit during construction?

Yeah, this is interesting as I thought I'd learned somewhere that the
default behavior was to prefer writers. Poking around the internet
makes me wonder if we actually want to make any changes =97 best I can
tell PTHREAD_RWLOCK_PREFER_WRITER_NP does not actually behave the way
one wants (as part of the spec!) because pthreads requires recursive
locking, so we'd have to use
PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP. But we'd probably want
to profile the performance changes (and, uh, run tests to make sure we
don't deadlock somehow) before putting any such code upstream.

>> Another question: I couldn't find a base implementation to translate
>> IPV4/6 ip's to host names? Is there same configuration table/method
>> allowing to get back from an OSD address retrieved via
>> OSDMap::get_addr() the original host name avoiding the use of DNS
>> lookups?
>
> I don't think we are doing reverse DNS lookups anywhere in the ceph
> code ...

In particular I think we've looked at doing this before and been
unable to reliably map to the *proper* hostname in cases where servers
have multiple NICs.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
