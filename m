From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Ideas for new ceph-mgr service
Date: Thu, 14 Jan 2016 10:56:24 -0500 (EST)
Message-ID: <199686024.15852754.1452786984645.JavaMail.zimbra@redhat.com>
References: <CALe9h7f-AaBxcNU=25dmYUxbZe9RhJwxvBTRyc5qVxzTjSCMrw@mail.gmail.com> <156637337.14721161.1452700430079.JavaMail.zimbra@redhat.com> <CALe9h7fm_r2a8p7BMYscr+Ba09X_ZMQsQcA+2QwPdkpAYCVZFg@mail.gmail.com> <56969124.4040604@redhat.com> <20160113211536.GA26123@ultraspiritum.redhat.com> <CALe9h7fw31AZqof=Pj4RB6WzrOvq88j-xo==jYBQK_BW3V2Czg@mail.gmail.com> <427576339.11773553.1452738785760.JavaMail.zimbra@redhat.com> <CALe9h7cNXN3+na2C5d0SbaJ-JqquY=csZDzGgdX4Y=Ms7TL0ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:53205 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbcANP4Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jan 2016 10:56:25 -0500
In-Reply-To: <CALe9h7cNXN3+na2C5d0SbaJ-JqquY=csZDzGgdX4Y=Ms7TL0ag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Brad Hubbard <bhubbard@redhat.com>, Mark Nelson <mnelson@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi John,

The language preference of the individual programmer has a lot of red-herring in it.  The question I ask is, what codebase do I want to own and maintain?  I am as biased as many, but I think the long-term value of a Python codebase in a server is limited--whether that matters depends on what happens to our product in the market.

Python provides a readable surface and it's cheaper to write than C++, but there are real issues with long-running servers written in it.  When I think of starting a new coding project of potentially substantial size, I really think it matters what kind of performance, scalability, future-facing serviceability it's going to have.

I think it's hard to argue with coding the devops/edge pieces in Python--but if a server-hosted Ceph management service inherits Python's GIL in any part of its core workflow, I think that would be a fail.

Matt

----- Original Message -----
> From: "John Spray" <jspray@redhat.com>
> To: "Brad Hubbard" <bhubbard@redhat.com>
> Cc: "Mark Nelson" <mnelson@redhat.com>, "Matt Benjamin" <mbenjamin@redhat.com>, "Ceph Development"
> <ceph-devel@vger.kernel.org>
> Sent: Thursday, January 14, 2016 6:31:18 AM
> Subject: Re: Ideas for new ceph-mgr service
> 
> On Thu, Jan 14, 2016 at 2:33 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
> > ----- Original Message -----
> >> From: "John Spray" <jspray@redhat.com>
> >> To: "Mark Nelson" <mnelson@redhat.com>, "John Spray" <jspray@redhat.com>,
> >> "Matt Benjamin" <mbenjamin@redhat.com>,
> >> "Ceph Development" <ceph-devel@vger.kernel.org>
> >> Sent: Thursday, 14 January, 2016 9:02:57 AM
> >> Subject: Re: Ideas for new ceph-mgr service
> >>
> >> On Wed, Jan 13, 2016 at 9:15 PM, Adam C. Emerson <aemerson@redhat.com>
> >> wrote:
> >> > On 13/01/2016, Mark Nelson wrote:
> >> > [snip]
> >> >> My gut instinct is to agree with Matt on this one, but I know the pain
> >> >> of
> >> >> trying to develop web services in C++ so I can't get too ornery about
> >> >> it.
> >> >> If there are ways to keep it C++ throughout without too much pain I'd
> >> >> advocate that route.
> >> > [snip]
> >> >
> >> > If the main concern is the annoyance of writing web services, would it
> >> > make
> >> > sense to use some widely supported binary protocol (Protocol Buffers,
> >> > Flat
> >> > Buffers, Cap'n Proto, etc.) that can be implemented easily in C++ and is
> >> > well
> >> > supported in Python and other languages?
> >>
> >> When writing our upward-facing interfaces, the #1 goal is low friction
> >> interoperability.  REST is essentially the closest thing we have to a
> >> language-agnostic lingua franca.
> >>
> >> To pick up on the examples you mention, Protobuf and Flat buffers are
> >> both just serialization formats, not protocols as such.  Cap'n Proto
> >> is an RPC framework, and describes itself as beta, and its RPC as
> >> "particularly experimental".  I've spent a fair bit of time in this
> >> space, and there really isn't a more popular or widely supported
> >> protocol for services like this than vanilla REST+JSON.  Avoiding the
> >> need for client libraries is key to the usefulness of it, as is the
> >> familiarity and comfort level of third parties we might like to
> >> interact with our API.
> >
> > Something like this then maybe?
> >
> > https://github.com/corvusoft/restbed
> 
> Or this: https://github.com/ceph/ceph/blob/master/src/rgw/rgw_rest.cc
> 
> It's certainly possible to write anything in C++.  But just because we
> can, doesn't mean we should.  We already have a mixture of C++ and
> Python in our codebase, and I'm firmly of the opinion that when
> writing a web frontend we should be using Python unless there's a
> super-good reason to take the hit of writing it in C++.
> 
> While I'm not deaf to the feedback that a single language solution
> would be desirable, I'm also conscious that I've emailed a list of
> mostly C++ developers suggesting a piece of Python code.  I could
> probably email a list of Python developers with a suggestion to write
> a web service in C++ and see what feedback I get there :-)
> 
> I think we'll need to remain flexible on this part.  It could be that
> there's a neat solution where the serving part is C++ (a la civetweb)
> with the option to write request handlers in either C++ or Python.
> The relative benefits of languages might be clearer once we have some
> examples, and in practice whoever writes the code will have a pretty
> strong ability to influence the choice.
> 
> John
> 
> P.S. I also noticed that restbed is AGPL, it's not clear to me that
> that's compatible with linking into our LGPL codebase.
> 
> >>
> >> Clearly binary encodings and RPC libraries have a reason to exist:
> >> they are especially useful within systems where both ends are
> >> controlled by the same developers, and performance is important.  I'm
> >> a big fan of protobuf, I just don't think it's a good fit here.
> >>
> >> > If we /need/ HTTP and JSON specifically (presumably for someone hacking
> >> > up
> >> > management software in a web browser's JavaScript runtime) could we have
> >> > a
> >> > Python translator that just shovels messages from the binary protocol to
> >> > the
> >> > HTTP JSON protocol and back?
> >>
> >> You could, but the resulting HTTP service would not be RESTful.  You
> >> can have a "REST API" with an endpoint per RPC call, that only accepts
> >> POSTs (that's what ceph-rest-api is), but it's not really a REST API
> >> (try GET'ing a list of OSDs with ceph-rest-api: it's just not the
> >> model it implements).
> >>
> >> More broadly than the questions of REST vs RPC, or JSON vs protobuf, I
> >> can imagine all kinds of modules someone might drop into this new
> >> service:
> >>  * Emit SNMP
> >>  * Emit graphite, or influxdb
> >>  * Run a simple GUI locally in process
> >>  * Fuse the Ceph state with something from another API, like a
> >> hardware status, and serve the result.
> >>  * Talk to vendor X's custom protocol for reporting status
> >>
> >> Most of those things would be natural fits for a language like python.
> >> Remember that we're also going to be part of an ecosystem of tools,
> >> including installers, things akin to ceph-deploy, openstack services,
> >> etc etc -- a suitably high level language will make the outward-facing
> >> parts of the code that much more accessible to our non-C++ colleagues.
> >> Using a language that's so widely understood by people doing
> >> integration work is a big win, pragmatically.
> >>
> >> In a way I'm seeking to sidestep the question of the actual protocol:
> >> rather than trying to come up with an all-singing-all-dancing high
> >> performance procotol that is also very easy to consume (there's no
> >> such thing!) I want to create a simple interface from C++ to Python,
> >> so that anyone can readily write a Python module to generate whatever
> >> output or interface they needed between Ceph and their wider
> >> environment.
> >>
> >> I see implementing a REST API in Python as the cheap, low risk option.
> >> I'm not arguing that it's so superior that we should invest lots of
> >> work in it, I'm arguing that it's appealing because of its simplicity
> >> and convenience[1], and if we need to come back with something native
> >> later, we could do that without upsetting the design of the service as
> >> a whole.
> >>
> >> John
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> 

-- 
-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
