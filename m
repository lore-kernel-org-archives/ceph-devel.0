From: Gregory Farnum <greg@inktank.com>
Subject: Re: rest mgmt api
Date: Mon, 11 Feb 2013 14:41:37 -0800
Message-ID: <CAPYLRzhfsYeqRVhxt+i7N7Djer7TfwVzZy67jJuyZ6LVM0P2yw@mail.gmail.com>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net>
	<CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com>
	<5112AE17.6080605@inktank.com>
	<alpine.DEB.2.00.1302061130220.13326@cobra.newdream.net>
	<5112B43D.6070602@bmrb.wisc.edu>
	<alpine.DEB.2.00.1302061211550.13326@cobra.newdream.net>
	<CAPYLRzh5JD3hvxB5VFrmEXq2g9JuEk-ODQquahPMwGMRiqSc6g@mail.gmail.com>
	<alpine.DEB.2.00.1302111345000.27987@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:45954 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641Ab3BKWli convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 17:41:38 -0500
Received: by mail-qc0-f182.google.com with SMTP id k19so2378239qcs.41
        for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 14:41:37 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302111345000.27987@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Feb 11, 2013 at 2:00 PM, Sage Weil <sage@inktank.com> wrote:
> On Mon, 11 Feb 2013, Gregory Farnum wrote:
>> On Wed, Feb 6, 2013 at 12:14 PM, Sage Weil <sage@inktank.com> wrote:
>> > On Wed, 6 Feb 2013, Dimitri Maziuk wrote:
>> >> On 02/06/2013 01:34 PM, Sage Weil wrote:
>> >>
>> >> > I think the one caveat here is that having a single registry fo=
r commands
>> >> > in the monitor means that commands can come in two flavors: vec=
tor<string>
>> >> > (cli) and URL (presumably in json form).  But a single command
>> >> > dispatch/registry framework will make that distinction pretty s=
imple...
>> >>
>> >> Any reason you can't have your CLI json-encode the commands (or,
>> >> conversely, your cgi/wsgi/php/servlet URL handler decode them int=
o
>> >> vector<string>) before passing them on to the monitor?
>> >
>> > We can, but they won't necessarily look the same, because it is un=
likely
>> > we can make a sane 1:1 translation of the CLI to REST that makes s=
ense,
>> > and it would be nice to avoid baking knowledge about the individua=
l
>> > commands into the client side.
>>
>> I disagree and am with Joao on this one ? the monitor parsing is
>> ridiculous as it stand right now, and we should be trying to get rid
>> of the manual string parsing. The monitors should be parsing JSON
>> commands that are sent by the client; it makes validation and the
>
> No argument that the current parsing code is bad...
>
>> logic control flow a lot easier. We're going to want some level of
>> intelligence in the clients so that they can tailor themselves to th=
e
>> appropriate UI conventions, and having two different parsing paths i=
n
>
> What do you mean by tailor to UI conventions?

Implementing and/or allowing positional versus named parameters, to
toss off one suggestion. Obviously the CLI will want to allow input
data in a format different than an API, but a port to a different
platform might prefer named parameters instead of positional ones, or
whatever.
Basically I'm agreeing that we as users want to be able to input data
differently and have it mean the same thing ;) ....

>> the monitors is just asking for trouble: they will get out of sync a=
nd
>> have different kinds of parsing errors.
>>
>> What we could do is have the monitors speak JSON only, and then give
>> the clients a minimal intelligence so that the CLI could (for
>> instance) prettify the options for commands it knows about, but stil=
l
>> allow pass-through for access to newer commands it hasn't yet heard
>> of.
>
> That doesn't really help; it means the mon still has to understand th=
e
> CLI grammar.
>
> What we are talking about is the difference between:
>
> [ 'osd', 'down', '123' ]
>
> and
>
> {
>   URI: '/osd/down',
>   OSD-Id: 123
> }
>
> or however we generically translate the HTTP request into JSON.  Once=
 we
> normalize the code, calling it "parsing" is probably misleading.  The=
 top
> (CLI) fragment will match against a rule like:
>
>  [ STR("osd"), STR("down"), POSINT ]
>
> or however we encode the syntax, while the below would match against
>
>  { .prefix =3D "/osd/down",
>    .fields =3D [ "OSD-Id": POSINT ]
>  }
>
> ..or something.  I'm making this syntax up, but you get the idea: the=
re
> would be a strict format for the request and generic code that valida=
tes
> it and passes the resulting arguments/matches into a function like
>
>  int do_command_osd_down(int n);
>
> regardless of which type of input pattern it matched.

=2E..but my instinct is to want one canonical code path in the monitors=
,
not two. Two allows for discrepancies in what each method allows to
come in that we're not going to have if they all come in to the
monitor in a single form. So I say that the canonicalization should
happen client-side, and the enforcement should happen server-side (and
probably client-side as well, but that's just for courtesy).
You've suggested that we want the monitors to do the parsing so that
old clients will work, but given that new commands in the monitors
often require new capabilities in the clients, having it be slightly
more awkward to send new commands to new monitors from old clients
doesn't seem like such a big deal to me =97 if somebody's running
monitor version .64 and client ceph tool version .60 and wants to use
a new thing, I don't feel bad about making them give the CLI a command
which completely specifies what the JSON looks like, instead of using
the pretty wrapping they'd get if they upgraded their client.

Having a canonicalized format also means that when we return errors
they can be a lot more useful, since the monitor can specify what
fields it received and which ones were bad, instead of just outputting
a string from whichever line of code actually broke. Consider an
incoming command whose canonical form is

[ 'crush', 'add', '123', '1.0' ]

And the parsing code runs through that and it fails and the string
going back says "error: does not specify weight!". But the user looks
and says "yes I did, it's 1.0!"

Versus if the error came back as
"Received command: ['area': 'crush', 'command': 'add', 'osd name':
'123', 'osd id': '1.0', 'CRUSH weight': MISSING ]. Error: does not
specify weight!"

to pick one random example that people have had trouble with. That's a
lot harder if we need to support two different methods of parsing
incoming and support that format outgoing.

And to use the same example subject, if we have a standard encoding
coming in to the monitor, it's a lot easier to handle different
versions of commands from users and clients =97 perhaps the client
interface was originally

"ceph crush add osd.123 123 1.0"

but we later decided that was stupid and switched it to just be

"ceph crush add 123 1.0".

If the format is specified by strings in the monitor, a client sending
the old style fails. Whereas if it's incoming fields, then we can
switch the parsing requirement from

{"field": "crush", "command": "add", "name": STR().POS_INT(), "id":
POS_INT(), "weight": POS_FLOAT}

to

{"field": "crush", "command": "add", OPTIONAL("name":
STR().POS_INT()), "id": POS_INT(), "weight": POS_FLOAT}

Or even something that incorporates versioning explicitly, like

{"command version": "0.56" "field": "crush", "command": "add",
VERSION(0.48, "name": STR().POS_INT()), "id": POS_INT(), "weight":
POS_FLOAT}

instead of requiring users to change all their habits and tools
instantly upon upgrade.


Hell, there's probably a way we can export that parse table back out
to the clients on request so they can use a programmatic
pretty-fication for anything they don't recognize and pretty-fi
already.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
