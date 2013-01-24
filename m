From: Nick Bartos <nick@pistoncloud.com>
Subject: Re: Consistently reading/writing rados objects via command line
Date: Thu, 24 Jan 2013 09:37:39 -0800
Message-ID: <CAPud5_4VV+rS9zOUC+aEGy8M1uFHGV+CLQjoqx4h_cEN7ghCfw@mail.gmail.com>
References: <CAPud5_7tn1yEkCZSb+f7MC8_-jGFPzm+VZp6RAMBK8vaX3sArA@mail.gmail.com>
	<0CFBBA27610A4E35A8D340A46E009F40@inktank.com>
	<alpine.DEB.2.00.1301212113140.29915@cobra.newdream.net>
	<CAPud5_4fdrdSb9aNms1H=4HPm_YYovQQuVJgzF4APcRKWXOzqQ@mail.gmail.com>
	<alpine.DEB.2.00.1301220906540.4085@cobra.newdream.net>
	<CAPud5_68kM1xki2MQ_1bWGgxsQxgWNB1pa98Oz9EMdw=WiZoGw@mail.gmail.com>
	<alpine.DEB.2.00.1301221228250.17154@cobra.newdream.net>
	<CAPud5_4fetJgKLQMbc7f9bTSZY2zRu612Q93OUdyk3phi-ipTw@mail.gmail.com>
	<alpine.DEB.2.00.1301232023150.10201@cobra.newdream.net>
	<alpine.DEB.2.00.1301232131350.13434@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:51768 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3AXRhk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 12:37:40 -0500
Received: by mail-qc0-f173.google.com with SMTP id b12so1851913qca.4
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 09:37:39 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301232131350.13434@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

Thanks!

On Wed, Jan 23, 2013 at 9:31 PM, Sage Weil <sage@inktank.com> wrote:
> Try wip-rados-get
>
> On Wed, 23 Jan 2013, Sage Weil wrote:
>
>> Hi Nick-
>>
>> The problem here looks to just be that do_get() in rados.cc isn't making
>> any attempt to read large objects in chunks.  I'm not sure where the 2GB
>> limit is, but it well beyond non-optimal before it gets to that point.
>> That function needs to read in chunks of a few MB and keep going until it
>> gets a short read, modulo some extra futzing for stdout.
>>
>> Any takers?  :)
>>
>> sage
>>
>>
>> On Wed, 23 Jan 2013, Nick Bartos wrote:
>>
>> > This seems to be working ok for the most part, but I noticed that
>> > using large files gives errors getting them (but not putting them).
>> > The problems start after 2GB which, as you said, is larger than should
>> > be used in this method.  It shouldn't affect us since we shouldn't be
>> > using this for files that large, but I thought it was worth reporting.
>> >
>> > This is the test:
>> >
>> > dd if=/dev/zero of=4.bin bs=1M count=100
>> > export FILE=4.bin
>> > rados -p swift_ring ls -
>> > rados -p swift_ring put $FILE.tmp $FILE --object-locator $FILE
>> > rados -p swift_ring clonedata $FILE.tmp $FILE --object-locator $FILE
>> > rados -p swift_ring ls -
>> > rados -p swift_ring rm $FILE.tmp --object-locator $FILE
>> > rados -p swift_ring ls -
>> > rados -p swift_ring stat $FILE
>> > rm -f $FILE.downloaded
>> > rados -p swift_ring get $FILE $FILE.downloaded
>> >
>> > These are the results:
>> >
>> > dd if=/dev/zero of=4.bin bs=1M count=1000:
>> > # rados -p swift_ring stat $FILE
>> > swift_ring/4.bin mtime 1358967088, size 1048576000
>> > rados -p swift_ring get $FILE $FILE.downloaded
>> > <ok>
>> >
>> > dd if=/dev/zero of=4.bin bs=1M count=2000:
>> > # rados -p swift_ring stat $FILE
>> > swift_ring/4.bin mtime 1358967172, size 2097152000
>> > # rados -p swift_ring get $FILE $FILE.downloaded
>> > <ok>
>> >
>> > dd if=/dev/zero of=4.bin bs=1M count=3000:
>> > # rados -p swift_ring stat $FILE
>> > swift_ring/4.bin mtime 1358966844, size 3145728000
>> > # rados -p swift_ring get $FILE $FILE.downloaded
>> > error getting swift_ring/4.bin: Unknown error 1149239296
>> >
>> > dd if=/dev/zero of=4.bin bs=1M count=8000:
>> > # rados -p swift_ring stat $FILE
>> > swift_ring/4.bin mtime 1358967388, size 8388608000
>> > # rados -p swift_ring get $FILE $FILE.downloaded
>> > error getting swift_ring/4.bin: Bad address
>> >
>> >
>> >
>> >
>> >
>> > On Tue, Jan 22, 2013 at 12:28 PM, Sage Weil <sage@inktank.com> wrote:
>> > > On Tue, 22 Jan 2013, Nick Bartos wrote:
>> > >> Thanks!  Is it safe to just apply that last commit to 0.56.1?  Also,
>> > >> is the rados command 'clonedata' instead of 'clone'?  That's what it
>> > >> looked like in the code.
>> > >
>> > > Yep, and yep!
>> > >
>> > > s
>> > >
>> > >>
>> > >> On Tue, Jan 22, 2013 at 9:27 AM, Sage Weil <sage@inktank.com> wrote:
>> > >> > On Tue, 22 Jan 2013, Nick Bartos wrote:
>> > >> >> Assuming that the clone is atomic so that the client only ever grabbed
>> > >> >> a complete old or new version of the file, that method really seems
>> > >> >> ideal.  How much work/time would that be?
>> > >> >>
>> > >> >> The objects will likely average around 10-20MB, but it's possible that
>> > >> >> in some cases they may grow to a few hundred MB.
>> > >> >
>> > >> > You're in luck--my email load was mercifully light this morning.
>> > >> >
>> > >> >   713  ./rados -p data ls -
>> > >> >   714  ./rados put foo.tmp /etc/passwd  -p data --object-locator foo
>> > >> >   715  ./rados clone foo.tmp foo -p data --object-locator foo
>> > >> >   716  ./rados -p data ls -
>> > >> >   717  ./rados -p data rm foo.tmp --object-locator foo
>> > >> >   718  ./rados -p data ls -
>> > >> >   719  ./rados -p data get foo -
>> > >> >
>> > >> > see wip-rados-clone.
>> > >> >
>> > >> > sage
>> > >> >
>> > >> >
>> > >> >>
>> > >> >>
>> > >> >> On Mon, Jan 21, 2013 at 9:14 PM, Sage Weil <sage@inktank.com> wrote:
>> > >> >> > With a bit of additional support in the rados tool, we could write to
>> > >> >> > object $foo.tmp with key $foo, and then clone it into position and delete
>> > >> >> > the .tmp.
>> > >> >> >
>> > >> >> > If they're really big objects, though, you may also be better off with
>> > >> >> > radosgw, which provides striping and atomicity..
>> > >> >> >
>> > >> >> > sage
>> > >> >>
>> > >> >>
>> > >>
>> > >>
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
