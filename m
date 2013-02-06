From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: rest mgmt api
Date: Wed, 06 Feb 2013 19:25:11 +0000
Message-ID: <5112AE17.6080605@inktank.com>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net> <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:60716 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757845Ab3BFTZ4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 14:25:56 -0500
Received: by mail-we0-f172.google.com with SMTP id x10so1447034wey.17
        for <ceph-devel@vger.kernel.org>; Wed, 06 Feb 2013 11:25:54 -0800 (PST)
In-Reply-To: <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 02/06/2013 06:15 PM, Yehuda Sadeh wrote:
> On Wed, Feb 6, 2013 at 9:25 AM, Sage Weil <sage@inktank.com> wrote:
>> One of the goals for cuttlefish is to improvement manageability of the
>> system.  This will invovle both cleaning up the CLI and adding a REST API
>> to do everything the CLI current does.  There are a few implementation
>> choices to make.
>>
>> Currenty the 'ceph' tool has a bunch of code to send messages to the
>> monitor and wait for replies.  This is 90% of what users currently can do.
>> For the most part, the commands are interpreted by the monitor.  A small
>> subset of commands (ceph tell ..., ceph pg <pgid> ...) will send commands
>> directory to OSDs.
>>
>>
>> There are two main options for a REST endpoint that we've discussed so
>> far:
>>
>> 1- Wrap the above in a clean library (probably integrating most of the
>> code into Objecter/MonClient.. see wip-monc for a start on this).  Wrap
>> libcephadmin in python and make a simple HTTP/REST front-end.  Users would
>> deploy mgmt endpoints in addition to/alongside monitors and everything
>> else.  If they want the rest api at all.
>>
>> 2- Embed a web server in the ceph-mon daemons, and push the current admin
>> 'client' functionality there.  Come up with some basic authentication so
>> that this doesn't break the current security model.
>
> I'm in favor of the more modular and flexible approach, #1.

Also in favour of #1 rather than #2.  I believe the monitors should be 
as light as possible, and embedding a web server is going on the 
opposite direction.  Also, relying on libraries to interface with the 
monitors allows the users to employ them however they see fit.

>> Note that neither of these solves the HA issue directly; HTTP is a
>> client/server protocol, so whoever is using the API can specify only one
>> server endpoint.  If it is a monitor, they'll need to be prepare to fail
>> over to another in their code, or set up a load balancer.  Same goes for
>> the restful endpoint, if it fails.  The difference is that a single
>> endpoint can proxy to whichever monitors are in quorum, so a much smaller
>> set of errors (endpoint machine crash, buggy endpoint) affect availability
>> of the API.
>
> Right. However, that's really an orthogonal issue. It'll be easier
> scaling the HTTP endpoints if they're decoupled from the monitors.

Again, I'm with Yehuda on this one. And I would also assume that by 
relying on a library, instead of on a embedded web server, this could be 
smoothed over by letting the library's monclient hunt for a new monitor, 
thus freeing whatever is in the middle from taking on this responsibility.

>> The somewhat orthogonal question is how to clean up the CLI usage,
>> parsing, and get equivalence in the new REST API.
>>
>> One option is to create a basic framework in the monitor so that there is
>> a table of api commands.  The 'parsing' would be regularized and validated
>> in a generic way.  The rest endpoint would pass the URI through in a
>> generic way (sanitized json?) that can be matched against the same table.
>>
>> Another option is to support a single set of commands on the monitor side,
>> and do the REST->CLI or CLI->REST or CLI,REST->json translation on the
>> client side.  The command registry framework above would live in the CLI
>> utility and REST endpoints instead (or libcephadmin).  This means that the
>> monitor code is simpler, but also means that the libcephadmin or ceph tool
>> and REST endpoint need to be running the latest code to be able to send
>> the latest commands to the monitor.  It also means multiple places where
>> the command set is defined (mon and endpoint and cli).
>
> I'd rather keep the clients dumb, not involve them with the actual
> configuration logic. Will make our lives easier in the long run.

I'm all for keeping clients dumb, but I believe that the responsibility 
of outputting in a human-readable format should be theirs.

My take on this is to keep the current behaviour (client issues a 
command and the monitor handles it as it sees fit), but all 
communication should be done in json, either to or from the monitors. 
This would allow us to provide more information on each result, getting 
rid of all the annoying format on the reply messages and simplify a 
great deal of code on the monitor end by removing the silly need of 
returning on either plain-text or json.  We would then let the 
client-side libraries deal with converting it to whichever format the 
user wants (plain-text, xml, w/e).  As for new commands on the monitor 
that are not present on the library, replies to said commands could then 
be presented just in json, or we could come up with a standardized way 
to always convert json into a human-readable format/any other format.

This would however mean to be able to parse json on the monitors (which 
we do not currently do, although we do produce json output).  I can't 
say I have strong feeling for the client->monitor communication to be 
done in json, but for sake of coherency I do think it would be best.

   -Joao
