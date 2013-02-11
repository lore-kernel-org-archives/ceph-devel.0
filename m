From: Sage Weil <sage@inktank.com>
Subject: Re: rest mgmt api
Date: Mon, 11 Feb 2013 14:00:58 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302111345000.27987@cobra.newdream.net>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net> <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com> <5112AE17.6080605@inktank.com> <alpine.DEB.2.00.1302061130220.13326@cobra.newdream.net> <5112B43D.6070602@bmrb.wisc.edu>
 <alpine.DEB.2.00.1302061211550.13326@cobra.newdream.net> <CAPYLRzh5JD3hvxB5VFrmEXq2g9JuEk-ODQquahPMwGMRiqSc6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40164 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932691Ab3BKWA6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 17:00:58 -0500
In-Reply-To: <CAPYLRzh5JD3hvxB5VFrmEXq2g9JuEk-ODQquahPMwGMRiqSc6g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 11 Feb 2013, Gregory Farnum wrote:
> On Wed, Feb 6, 2013 at 12:14 PM, Sage Weil <sage@inktank.com> wrote:
> > On Wed, 6 Feb 2013, Dimitri Maziuk wrote:
> >> On 02/06/2013 01:34 PM, Sage Weil wrote:
> >>
> >> > I think the one caveat here is that having a single registry for commands
> >> > in the monitor means that commands can come in two flavors: vector<string>
> >> > (cli) and URL (presumably in json form).  But a single command
> >> > dispatch/registry framework will make that distinction pretty simple...
> >>
> >> Any reason you can't have your CLI json-encode the commands (or,
> >> conversely, your cgi/wsgi/php/servlet URL handler decode them into
> >> vector<string>) before passing them on to the monitor?
> >
> > We can, but they won't necessarily look the same, because it is unlikely
> > we can make a sane 1:1 translation of the CLI to REST that makes sense,
> > and it would be nice to avoid baking knowledge about the individual
> > commands into the client side.
> 
> I disagree and am with Joao on this one ? the monitor parsing is
> ridiculous as it stand right now, and we should be trying to get rid
> of the manual string parsing. The monitors should be parsing JSON
> commands that are sent by the client; it makes validation and the

No argument that the current parsing code is bad...

> logic control flow a lot easier. We're going to want some level of
> intelligence in the clients so that they can tailor themselves to the
> appropriate UI conventions, and having two different parsing paths in

What do you mean by tailor to UI conventions?

> the monitors is just asking for trouble: they will get out of sync and
> have different kinds of parsing errors.
> 
> What we could do is have the monitors speak JSON only, and then give
> the clients a minimal intelligence so that the CLI could (for
> instance) prettify the options for commands it knows about, but still
> allow pass-through for access to newer commands it hasn't yet heard
> of.

That doesn't really help; it means the mon still has to understand the 
CLI grammar.

What we are talking about is the difference between:

[ 'osd', 'down', '123' ]

and

{
  URI: '/osd/down',
  OSD-Id: 123
}

or however we generically translate the HTTP request into JSON.  Once we 
normalize the code, calling it "parsing" is probably misleading.  The top 
(CLI) fragment will match against a rule like:

 [ STR("osd"), STR("down"), POSINT ]

or however we encode the syntax, while the below would match against

 { .prefix = "/osd/down",
   .fields = [ "OSD-Id": POSINT ]
 }

..or something.  I'm making this syntax up, but you get the idea: there 
would be a strict format for the request and generic code that validates 
it and passes the resulting arguments/matches into a function like

 int do_command_osd_down(int n);

regardless of which type of input pattern it matched.

Obviously we'll need 100% testing coverage for both the RESTful and CLI 
variants, whether we do the above or whether the CLI is translating one 
into the other via duplicated knowledge of the command set.

FWIW you could pass the CLI command as JSON, but that's no different than 
encoding vector<string>; it's still a different way to describing the same 
command.


If the parsing code is wrapping in a single library that validates typed 
fields or positional arguments/flags, I don't think this is going to turn 
into anything remotely like the same wild-west horror that the current 
code represents.  And if we were building this from scratch with no 
legacy, I'd argue that the same model is still pretty good... unless we 
recast the entire CLI in terms of a generic URI+field model that 
matches the REST API perfectly.

Now.. if that is the route want to go, that is another choice.  We could:

 - redesign a fresh CLI with commands like

   ceph /osd/123 mark=down
   ceph /pool/foo create pg_num=123

 - make this a programmatic transformation to/from a REST request, like

   /osd/123?command=mark&status=down
   /pool/foo?command=create&pg_num=123

   (or whatever the REST requests are "supposed" to look like)

 - hard-code a client-side mapping for legacy commands only
 - only add new commands in the new syntax

That means retraining users and only adding new commands in the new model 
of things.  And dreaming up said model...

sage
