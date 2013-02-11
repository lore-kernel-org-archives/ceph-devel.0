From: Gregory Farnum <greg@inktank.com>
Subject: Re: rest mgmt api
Date: Mon, 11 Feb 2013 12:04:06 -0800
Message-ID: <CAPYLRzh5JD3hvxB5VFrmEXq2g9JuEk-ODQquahPMwGMRiqSc6g@mail.gmail.com>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net>
	<CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com>
	<5112AE17.6080605@inktank.com>
	<alpine.DEB.2.00.1302061130220.13326@cobra.newdream.net>
	<5112B43D.6070602@bmrb.wisc.edu>
	<alpine.DEB.2.00.1302061211550.13326@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:61349 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758792Ab3BKUEI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 15:04:08 -0500
Received: by mail-qc0-f172.google.com with SMTP id b25so2383326qca.3
        for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 12:04:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302061211550.13326@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Feb 6, 2013 at 12:14 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 6 Feb 2013, Dimitri Maziuk wrote:
>> On 02/06/2013 01:34 PM, Sage Weil wrote:
>>
>> > I think the one caveat here is that having a single registry for c=
ommands
>> > in the monitor means that commands can come in two flavors: vector=
<string>
>> > (cli) and URL (presumably in json form).  But a single command
>> > dispatch/registry framework will make that distinction pretty simp=
le...
>>
>> Any reason you can't have your CLI json-encode the commands (or,
>> conversely, your cgi/wsgi/php/servlet URL handler decode them into
>> vector<string>) before passing them on to the monitor?
>
> We can, but they won't necessarily look the same, because it is unlik=
ely
> we can make a sane 1:1 translation of the CLI to REST that makes sens=
e,
> and it would be nice to avoid baking knowledge about the individual
> commands into the client side.

I disagree and am with Joao on this one =97 the monitor parsing is
ridiculous as it stand right now, and we should be trying to get rid
of the manual string parsing. The monitors should be parsing JSON
commands that are sent by the client; it makes validation and the
logic control flow a lot easier. We're going to want some level of
intelligence in the clients so that they can tailor themselves to the
appropriate UI conventions, and having two different parsing paths in
the monitors is just asking for trouble: they will get out of sync and
have different kinds of parsing errors.

What we could do is have the monitors speak JSON only, and then give
the clients a minimal intelligence so that the CLI could (for
instance) prettify the options for commands it knows about, but still
allow pass-through for access to newer commands it hasn't yet heard
of.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
