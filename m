From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Logging braindump
Date: Thu, 22 Mar 2012 09:38:48 -0700
Message-ID: <CA+qbEUPQcVqmUgNYXu6+U4+QCUjxsSkq9pVQ98=Es8rKscT12Q@mail.gmail.com>
References: <CAORUGqCqK0WUEGiXyM+6KYfWswPrW_eV=qp8Q2CCAUSXguYdDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33890 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab2CVQiu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Mar 2012 12:38:50 -0400
Received: by wibhj6 with SMTP id hj6so1034912wib.1
        for <ceph-devel@vger.kernel.org>; Thu, 22 Mar 2012 09:38:48 -0700 (PDT)
In-Reply-To: <CAORUGqCqK0WUEGiXyM+6KYfWswPrW_eV=qp8Q2CCAUSXguYdDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Mar 19, 2012 at 1:53 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> [mmap'ed buffer discussion]

I always thought mmap'ed circular buffers were an elegant approach for
getting data that survived a process crash, but not paying the
overhead of write(2) and read(2).  The main problem is that you need
special tools to read the circular buffer files off of the disk.  As
Sage commented, that is probably undesirable for many users.

An mmap'ed buffer, even a lockless one, is a simple beast.  Do you
really need a whole library just for that?  Maybe I'm just
old-fashioned.

> DISK FORMAT
> - GELF: compressed JSON with specific fields:
> https://github.com/Graylog2/graylog2-docs/wiki/GELF
> - Google Protocol Buffers: considered clumsy these days (code
> generation from IDL etc); only Google has significant investment in
> the format

Hadoop also has a significant investment in Google Protocol Buffers.
It's almost the only thing we send over the wire these days.  I don't
think this affects your decision about logging at all, though.

> - Thrift: considered clumsy these days (code generation from IDL etc)=
;
> only Facebook has significant investment in the format
> - BSON: sort of close to binary encoding of JSON + extra data types,
> not a huge improvement in speed/space.. http://bsonspec.org/
> - Avro: Apache-sponspored data format, nicely self-describing,
> apparently slow? http://avro.apache.org/
> - MessagePack: binary encoding for JSON, claims to beat others in
> speed.. http://msgpack.org/

I'm not sure why you consider code generation from a schema file "clums=
y."
To me, the whole point of structured logging is that
1. it is more efficient in terms of space/speed, partly because it
doesn't need to be self-describing, and
2. it is a stable ABI that binds the system together

The sticking point for most programmers is point #2.  They don't want
to commit to a log format ahead of time because it slows down
development.  (Pretty  much the same reason Linus doesn't want a
stable in-kernel ABI.)  In my opinion, that's the reason why
structured logging has not made much headway in the world at large.
Journald is an interesting experiment-- we'll see how many programmers
carefully design structured journald log messages, and how many just
output a single field called "text" or something similar. :)

If you "just" want better efficiency, there's a lot of ways to get
that which don't involve changing the Ceph logging APIs.  Probably the
easiest one is just cutting down on hugely verbose (as in more than 80
character) log messages.  There's no shortage of those.

=46or an unrelated project, I have been considering a system where all
logs are generated and go to a circular buffer, but are not sent to
permanent storage until/unless there is a crash, or the particular log
message type is enabled.  It seems like something like this is a good
compromise between too much logging and not enough.

Colin


>
> And all of these can be compressed with e.g. Snappy as they flow to
> disk. =A0http://code.google.com/p/snappy/
>
> Downside of just all but JSON: we'd need to bundle the library --
> distro support just isn't there yet.
>
> Should the disk format be binary? That makes it less friendly to the
> admin. I'm not sure which way to go. JSON is simpler and friendlier,
> e.g. MessagePack has identical data model but is faster and takes les=
s
> space. Some options:
> =A0a. make configurable so simple installations don't need to suffer =
binary logs
> =A0b. just pick one and stick with it
>
>
>
> QUERYING / ANALYSIS
>
> - use a format from above that is mapreduce-friedly, or can be 1:1
> imported into another storage system
> - software like Graylog may be of use, but I fear we'll overwhelm it
> with events: http://graylog2.org/
> - Cassandra's Brisk is a really easy way to run SQL-like Hive queries
> over structured data, and has a design that'll ingest any amount of
> data, Just Add Hardware(tm):
> http://www.datastax.com/docs/0.8/brisk/index
> - the standards process is churning out things like CEE, but I'm not
> holding my breath: http://cee.mitre.org/
>
>
>
> MY RECOMMENDATIONS [biased, as always ;-]
>
> - bundle the MessagePack library
> - in thread that calls log: serialize as MessagePack onto stack,
> allocate needed bytes from ringbuffer, copy event to ringbuffer
> - write to disk is now very simple, could even be done in a different
> process (mmap header+ringbuffer)
> - let disk files be named after timestamp they were started at, start
> new ones based on time & size (no .0 -> .1 -> .2 renaming needed)
> - make it really simple to process+delete chunks of log, feeding them
> into Brisk or Graylog, then deleting from the node (perhaps after a
> delay, so last 24h is locally browseable)
> =A0(and don't remove things that haven't been processed)
>
>
>
> Hope that made sense. Let's talk more, especially if it didn't ;)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
