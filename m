From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Logging braindump
Date: Mon, 19 Mar 2012 13:53:26 -0700
Message-ID: <CAORUGqCqK0WUEGiXyM+6KYfWswPrW_eV=qp8Q2CCAUSXguYdDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65215 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab2CSUxr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Mar 2012 16:53:47 -0400
Received: by dajr28 with SMTP id r28so10382578daj.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Mar 2012 13:53:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

So, we've been talking about an in-memory buffer that would contain
debug-level messages, and a separate thread/process [1] that would
write a subset of these to disk. Thus, on crash, we'd have a lot of
detail available (the ring buffer entries not yet overwritten),
without paying the IO/serialization/storage cost of dumping it all out
to disk.

[1] e.g. varnish uses an mmaped file for a ringbuffer, consumes it
from a difference process; that way, the log consumer cannot corrupt
the server process memory. Of course, this means log messages cannot
contain pointers to indirect data. And that means the buffer is not
made of constant size entries, like Disruptor tends to assume.. though
I think you could view Disruptor sequence numbers as byte offsets, if
you wanted.



RING BUFFER

For the ring buffer, we've been looking at Disruptor[2]-style
"consumer tries to catch up with a sequence number from producer"
design. As we have multiple producers (threads creating log entries),
the cost of creating a log entry would be a single cmpxchg op, and
then whatever work is needed to lay out the event in the ringbuffer.

http://martinfowler.com/articles/lmax.html
http://code.google.com/p/disruptor/

The in-memory data format could just use whatever data format is most
convenient. The ringbuffer could be an array tiny structs with the
base fields like thread id embedded there, and pointers to separately
allocated data for items that aren't always present. But this means we
need to be very careful about memory management; we want the data
pointed to to stay alive and unmodified until the producer loops
around the ringbuffer.

Alternatively, interpret Disruptor sequence numbers as byte offsets,
serialize message first, allocate that much space from ring buffer
(still just one cmpxchg). This pushes more of the work to the producer
of log messages, but avoids having an intermediate data format that
needs to be converted to another format, and simplifies memory
management tremendously.


DISK FORMAT

The process writing the events to disk should be more focused on
usefulness and longevity of the data. If the ring buffer is just
arrays with pointers, here we should take the performance hit to
convert to one of the known formats. I feel strongly in favor of
structured logging, as parsing bazillion log entries is slow, and
maintaining the parsing rules is actually harder than structured
logging in the first place.

The status quo is hoping to improve syslog, but there's so much
Enterprise in this stuff that I'm not holding my breath..
http://lwn.net/Articles/484731/ . Work that has come out includes the
structured syslog format below, CEE querying further down.

Some candidates:

- Scribe and Flume are pre-existing "log collectors" that emphasize a
DAG of log flow, lots of Java everywhere.. I'm not thrilled.
  https://github.com/facebook/scribe  https://cwiki.apache.org/FLUME/

- journald: I'm just going to pretend it doesn't exist, at least for 2
years: http://blog.gerhards.net/2011/11/journald-and-rsyslog.html

- syslog's structured logging extension:
http://tools.ietf.org/html/rfc5424#section-6.5

  essentially, [key=value key2=val2] MESSAGE

 <165>1 2003-10-11T22:14:15.003Z mymachine.example.com
           evntslog - ID47 [exampleSDID@32473 iut="3" eventSource=
           "Application" eventID="1011"] BOMAn application
           event log entry...

- JSON: http://json.org/

  {"key": "value", "key2": "val2", "message": "MESSAGE"}

  the convention is lines of json, separated by newlines, each line is
a full event

  biggest downside is numbers are always floats (need to stringify
large numbers), binary data must be encoded somehow into a utf-8
string (base64 is most common).

- GELF: compressed JSON with specific fields:
https://github.com/Graylog2/graylog2-docs/wiki/GELF
- Google Protocol Buffers: considered clumsy these days (code
generation from IDL etc); only Google has significant investment in
the format
- Thrift: considered clumsy these days (code generation from IDL etc);
only Facebook has significant investment in the format
- BSON: sort of close to binary encoding of JSON + extra data types,
not a huge improvement in speed/space.. http://bsonspec.org/
- Avro: Apache-sponspored data format, nicely self-describing,
apparently slow? http://avro.apache.org/
- MessagePack: binary encoding for JSON, claims to beat others in
speed.. http://msgpack.org/

And all of these can be compressed with e.g. Snappy as they flow to
disk.  http://code.google.com/p/snappy/

Downside of just all but JSON: we'd need to bundle the library --
distro support just isn't there yet.

Should the disk format be binary? That makes it less friendly to the
admin. I'm not sure which way to go. JSON is simpler and friendlier,
e.g. MessagePack has identical data model but is faster and takes less
space. Some options:
  a. make configurable so simple installations don't need to suffer binary logs
  b. just pick one and stick with it



QUERYING / ANALYSIS

- use a format from above that is mapreduce-friedly, or can be 1:1
imported into another storage system
- software like Graylog may be of use, but I fear we'll overwhelm it
with events: http://graylog2.org/
- Cassandra's Brisk is a really easy way to run SQL-like Hive queries
over structured data, and has a design that'll ingest any amount of
data, Just Add Hardware(tm):
http://www.datastax.com/docs/0.8/brisk/index
- the standards process is churning out things like CEE, but I'm not
holding my breath: http://cee.mitre.org/



MY RECOMMENDATIONS [biased, as always ;-]

- bundle the MessagePack library
- in thread that calls log: serialize as MessagePack onto stack,
allocate needed bytes from ringbuffer, copy event to ringbuffer
- write to disk is now very simple, could even be done in a different
process (mmap header+ringbuffer)
- let disk files be named after timestamp they were started at, start
new ones based on time & size (no .0 -> .1 -> .2 renaming needed)
- make it really simple to process+delete chunks of log, feeding them
into Brisk or Graylog, then deleting from the node (perhaps after a
delay, so last 24h is locally browseable)
  (and don't remove things that haven't been processed)



Hope that made sense. Let's talk more, especially if it didn't ;)
