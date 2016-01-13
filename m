From: John Spray <jspray@redhat.com>
Subject: Re: Ideas for new ceph-mgr service
Date: Wed, 13 Jan 2016 23:02:57 +0000
Message-ID: <CALe9h7fw31AZqof=Pj4RB6WzrOvq88j-xo==jYBQK_BW3V2Czg@mail.gmail.com>
References: <CALe9h7f-AaBxcNU=25dmYUxbZe9RhJwxvBTRyc5qVxzTjSCMrw@mail.gmail.com>
 <156637337.14721161.1452700430079.JavaMail.zimbra@redhat.com>
 <CALe9h7fm_r2a8p7BMYscr+Ba09X_ZMQsQcA+2QwPdkpAYCVZFg@mail.gmail.com>
 <56969124.4040604@redhat.com> <20160113211536.GA26123@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35663 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbcAMXDT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jan 2016 18:03:19 -0500
Received: by mail-lf0-f41.google.com with SMTP id c192so265405948lfe.2
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jan 2016 15:03:18 -0800 (PST)
In-Reply-To: <20160113211536.GA26123@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, John Spray <jspray@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jan 13, 2016 at 9:15 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 13/01/2016, Mark Nelson wrote:
> [snip]
>> My gut instinct is to agree with Matt on this one, but I know the pain of
>> trying to develop web services in C++ so I can't get too ornery about it.
>> If there are ways to keep it C++ throughout without too much pain I'd
>> advocate that route.
> [snip]
>
> If the main concern is the annoyance of writing web services, would it make
> sense to use some widely supported binary protocol (Protocol Buffers, Flat
> Buffers, Cap'n Proto, etc.) that can be implemented easily in C++ and is well
> supported in Python and other languages?

When writing our upward-facing interfaces, the #1 goal is low friction
interoperability.  REST is essentially the closest thing we have to a
language-agnostic lingua franca.

To pick up on the examples you mention, Protobuf and Flat buffers are
both just serialization formats, not protocols as such.  Cap'n Proto
is an RPC framework, and describes itself as beta, and its RPC as
"particularly experimental".  I've spent a fair bit of time in this
space, and there really isn't a more popular or widely supported
protocol for services like this than vanilla REST+JSON.  Avoiding the
need for client libraries is key to the usefulness of it, as is the
familiarity and comfort level of third parties we might like to
interact with our API.

Clearly binary encodings and RPC libraries have a reason to exist:
they are especially useful within systems where both ends are
controlled by the same developers, and performance is important.  I'm
a big fan of protobuf, I just don't think it's a good fit here.

> If we /need/ HTTP and JSON specifically (presumably for someone hacking up
> management software in a web browser's JavaScript runtime) could we have a
> Python translator that just shovels messages from the binary protocol to the
> HTTP JSON protocol and back?

You could, but the resulting HTTP service would not be RESTful.  You
can have a "REST API" with an endpoint per RPC call, that only accepts
POSTs (that's what ceph-rest-api is), but it's not really a REST API
(try GET'ing a list of OSDs with ceph-rest-api: it's just not the
model it implements).

More broadly than the questions of REST vs RPC, or JSON vs protobuf, I
can imagine all kinds of modules someone might drop into this new
service:
 * Emit SNMP
 * Emit graphite, or influxdb
 * Run a simple GUI locally in process
 * Fuse the Ceph state with something from another API, like a
hardware status, and serve the result.
 * Talk to vendor X's custom protocol for reporting status

Most of those things would be natural fits for a language like python.
Remember that we're also going to be part of an ecosystem of tools,
including installers, things akin to ceph-deploy, openstack services,
etc etc -- a suitably high level language will make the outward-facing
parts of the code that much more accessible to our non-C++ colleagues.
Using a language that's so widely understood by people doing
integration work is a big win, pragmatically.

In a way I'm seeking to sidestep the question of the actual protocol:
rather than trying to come up with an all-singing-all-dancing high
performance procotol that is also very easy to consume (there's no
such thing!) I want to create a simple interface from C++ to Python,
so that anyone can readily write a Python module to generate whatever
output or interface they needed between Ceph and their wider
environment.

I see implementing a REST API in Python as the cheap, low risk option.
I'm not arguing that it's so superior that we should invest lots of
work in it, I'm arguing that it's appealing because of its simplicity
and convenience[1], and if we need to come back with something native
later, we could do that without upsetting the design of the service as
a whole.

John
